Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDC6480791
	for <lists+linux-s390@lfdr.de>; Tue, 28 Dec 2021 10:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbhL1JDb (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 28 Dec 2021 04:03:31 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:34350 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235791AbhL1JDa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 28 Dec 2021 04:03:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V04tc5d_1640682208;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0V04tc5d_1640682208)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Dec 2021 17:03:28 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     Karsten Graul <kgraul@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Wen Gu <guwen@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>
Subject: [PATCH net 2/2] net/smc: fix kernel panic caused by race of smc_sock
Date:   Tue, 28 Dec 2021 17:03:25 +0800
Message-Id: <20211228090325.27263-3-dust.li@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
In-Reply-To: <20211228090325.27263-1-dust.li@linux.alibaba.com>
References: <20211228090325.27263-1-dust.li@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

A crash occurs when smc_cdc_tx_handler() tries to access smc_sock
but smc_release() has already freed it.

[ 4570.695099] BUG: unable to handle page fault for address: 000000002eae9e88
[ 4570.696048] #PF: supervisor write access in kernel mode
[ 4570.696728] #PF: error_code(0x0002) - not-present page
[ 4570.697401] PGD 0 P4D 0
[ 4570.697716] Oops: 0002 [#1] PREEMPT SMP NOPTI
[ 4570.698228] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.16.0-rc4+ #111
[ 4570.699013] Hardware name: Alibaba Cloud Alibaba Cloud ECS, BIOS 8c24b4c 04/0
[ 4570.699933] RIP: 0010:_raw_spin_lock+0x1a/0x30
<...>
[ 4570.711446] Call Trace:
[ 4570.711746]  <IRQ>
[ 4570.711992]  smc_cdc_tx_handler+0x41/0xc0
[ 4570.712470]  smc_wr_tx_tasklet_fn+0x213/0x560
[ 4570.712981]  ? smc_cdc_tx_dismisser+0x10/0x10
[ 4570.713489]  tasklet_action_common.isra.17+0x66/0x140
[ 4570.714083]  __do_softirq+0x123/0x2f4
[ 4570.714521]  irq_exit_rcu+0xc4/0xf0
[ 4570.714934]  common_interrupt+0xba/0xe0

Though smc_cdc_tx_handler() checked the existence of smc connection,
smc_release() may have already dismissed and released the smc socket
before smc_cdc_tx_handler() further visits it.

smc_cdc_tx_handler()           |smc_release()
if (!conn)                     |
                               |
                               |smc_cdc_tx_dismiss_slots()
                               |      smc_cdc_tx_dismisser()
                               |
                               |sock_put(&smc->sk) <- last sock_put,
                               |                      smc_sock freed
bh_lock_sock(&smc->sk) (panic) |

To make sure we won't receive any CDC messages after we free the
smc_sock, add a refcount on the smc_connection for inflight CDC
message(posted to the QP but haven't received related CQE), and
don't release the smc_connection until all the inflight CDC messages
haven been done, for both success or failed ones.

Using refcount on CDC messages brings another problem: when the link
is going to be destroyed, smcr_link_clear() will reset the QP, which
then remove all the pending CQEs related to the QP in the CQ. To make
sure all the CQEs will always come back so the refcount on the
smc_connection can always reach 0, smc_ib_modify_qp_reset() was replaced
by smc_ib_modify_qp_error().
And remove the timeout in smc_wr_tx_wait_no_pending_sends() since we
need to wait for all pending WQEs done, or we may encounter use-after-
free when handling CQEs.

For IB device removal routine, we need to wait for all the QPs on that
device been destroyed before we can destroy CQs on the device, or
the refcount on smc_connection won't reach 0 and smc_sock cannot be
released.

Fixes: 5f08318f617b ("smc: connection data control (CDC)")
Reported-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
---
 net/smc/smc.h      |  5 +++++
 net/smc/smc_cdc.c  | 52 +++++++++++++++++++++-------------------------
 net/smc/smc_cdc.h  |  2 +-
 net/smc/smc_core.c | 25 +++++++++++++++++-----
 net/smc/smc_ib.c   |  4 ++--
 net/smc/smc_ib.h   |  1 +
 net/smc/smc_wr.c   | 41 +++---------------------------------
 net/smc/smc_wr.h   |  3 +--
 8 files changed, 57 insertions(+), 76 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 2b663819fd53..463e40eb6c2f 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -185,6 +185,11 @@ struct smc_connection {
 	u16			tx_cdc_seq;	/* sequence # for CDC send */
 	u16			tx_cdc_seq_fin;	/* sequence # - tx completed */
 	spinlock_t		send_lock;	/* protect wr_sends */
+	atomic_t		cdc_pend_tx_wr; /* number of pending tx CDC wqe
+						 * - inc when post wqe,
+						 * - dec on polled tx cqe
+						 */
+	wait_queue_head_t	cdc_pend_tx_wq; /* wakeup on no cdc_pend_tx_wr*/
 	struct delayed_work	tx_work;	/* retry of smc_cdc_msg_send */
 	u32			tx_off;		/* base offset in peer rmb */
 
diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 99acd337ba90..84c8a4374fdd 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -31,10 +31,6 @@ static void smc_cdc_tx_handler(struct smc_wr_tx_pend_priv *pnd_snd,
 	struct smc_sock *smc;
 	int diff;
 
-	if (!conn)
-		/* already dismissed */
-		return;
-
 	smc = container_of(conn, struct smc_sock, conn);
 	bh_lock_sock(&smc->sk);
 	if (!wc_status) {
@@ -51,6 +47,12 @@ static void smc_cdc_tx_handler(struct smc_wr_tx_pend_priv *pnd_snd,
 			      conn);
 		conn->tx_cdc_seq_fin = cdcpend->ctrl_seq;
 	}
+
+	if (atomic_dec_and_test(&conn->cdc_pend_tx_wr) &&
+	    unlikely(wq_has_sleeper(&conn->cdc_pend_tx_wq)))
+		wake_up(&conn->cdc_pend_tx_wq);
+	WARN_ON(atomic_read(&conn->cdc_pend_tx_wr) < 0);
+
 	smc_tx_sndbuf_nonfull(smc);
 	bh_unlock_sock(&smc->sk);
 }
@@ -107,6 +109,10 @@ int smc_cdc_msg_send(struct smc_connection *conn,
 	conn->tx_cdc_seq++;
 	conn->local_tx_ctrl.seqno = conn->tx_cdc_seq;
 	smc_host_msg_to_cdc((struct smc_cdc_msg *)wr_buf, conn, &cfed);
+
+	atomic_inc(&conn->cdc_pend_tx_wr);
+	smp_mb__after_atomic(); /* Make sure cdc_pend_tx_wr added before post */
+
 	rc = smc_wr_tx_send(link, (struct smc_wr_tx_pend_priv *)pend);
 	if (!rc) {
 		smc_curs_copy(&conn->rx_curs_confirmed, &cfed, conn);
@@ -114,6 +120,7 @@ int smc_cdc_msg_send(struct smc_connection *conn,
 	} else {
 		conn->tx_cdc_seq--;
 		conn->local_tx_ctrl.seqno = conn->tx_cdc_seq;
+		atomic_dec(&conn->cdc_pend_tx_wr);
 	}
 
 	return rc;
@@ -136,7 +143,18 @@ int smcr_cdc_msg_send_validation(struct smc_connection *conn,
 	peer->token = htonl(local->token);
 	peer->prod_flags.failover_validation = 1;
 
+	/* We need to set pend->conn here to make sure smc_cdc_tx_handler()
+	 * can handle properly
+	 */
+	smc_cdc_add_pending_send(conn, pend);
+
+	atomic_inc(&conn->cdc_pend_tx_wr);
+	smp_mb__after_atomic(); /* Make sure cdc_pend_tx_wr added before post */
+
 	rc = smc_wr_tx_send(link, (struct smc_wr_tx_pend_priv *)pend);
+	if (unlikely(rc))
+		atomic_dec(&conn->cdc_pend_tx_wr);
+
 	return rc;
 }
 
@@ -193,31 +211,9 @@ int smc_cdc_get_slot_and_msg_send(struct smc_connection *conn)
 	return rc;
 }
 
-static bool smc_cdc_tx_filter(struct smc_wr_tx_pend_priv *tx_pend,
-			      unsigned long data)
+void smc_cdc_wait_pend_tx_wr(struct smc_connection *conn)
 {
-	struct smc_connection *conn = (struct smc_connection *)data;
-	struct smc_cdc_tx_pend *cdc_pend =
-		(struct smc_cdc_tx_pend *)tx_pend;
-
-	return cdc_pend->conn == conn;
-}
-
-static void smc_cdc_tx_dismisser(struct smc_wr_tx_pend_priv *tx_pend)
-{
-	struct smc_cdc_tx_pend *cdc_pend =
-		(struct smc_cdc_tx_pend *)tx_pend;
-
-	cdc_pend->conn = NULL;
-}
-
-void smc_cdc_tx_dismiss_slots(struct smc_connection *conn)
-{
-	struct smc_link *link = conn->lnk;
-
-	smc_wr_tx_dismiss_slots(link, SMC_CDC_MSG_TYPE,
-				smc_cdc_tx_filter, smc_cdc_tx_dismisser,
-				(unsigned long)conn);
+	wait_event(conn->cdc_pend_tx_wq, !atomic_read(&conn->cdc_pend_tx_wr));
 }
 
 /* Send a SMC-D CDC header.
diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
index 0a0a89abd38b..696cc11f2303 100644
--- a/net/smc/smc_cdc.h
+++ b/net/smc/smc_cdc.h
@@ -291,7 +291,7 @@ int smc_cdc_get_free_slot(struct smc_connection *conn,
 			  struct smc_wr_buf **wr_buf,
 			  struct smc_rdma_wr **wr_rdma_buf,
 			  struct smc_cdc_tx_pend **pend);
-void smc_cdc_tx_dismiss_slots(struct smc_connection *conn);
+void smc_cdc_wait_pend_tx_wr(struct smc_connection *conn);
 int smc_cdc_msg_send(struct smc_connection *conn, struct smc_wr_buf *wr_buf,
 		     struct smc_cdc_tx_pend *pend);
 int smc_cdc_get_slot_and_msg_send(struct smc_connection *conn);
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 55ca175e8d57..a6849362f4dd 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1127,7 +1127,7 @@ void smc_conn_free(struct smc_connection *conn)
 			smc_ism_unset_conn(conn);
 		tasklet_kill(&conn->rx_tsklet);
 	} else {
-		smc_cdc_tx_dismiss_slots(conn);
+		smc_cdc_wait_pend_tx_wr(conn);
 		if (current_work() != &conn->abort_work)
 			cancel_work_sync(&conn->abort_work);
 	}
@@ -1204,7 +1204,7 @@ void smcr_link_clear(struct smc_link *lnk, bool log)
 	smc_llc_link_clear(lnk, log);
 	smcr_buf_unmap_lgr(lnk);
 	smcr_rtoken_clear_link(lnk);
-	smc_ib_modify_qp_reset(lnk);
+	smc_ib_modify_qp_error(lnk);
 	smc_wr_free_link(lnk);
 	smc_ib_destroy_queue_pair(lnk);
 	smc_ib_dealloc_protection_domain(lnk);
@@ -1336,7 +1336,7 @@ static void smc_conn_kill(struct smc_connection *conn, bool soft)
 		else
 			tasklet_unlock_wait(&conn->rx_tsklet);
 	} else {
-		smc_cdc_tx_dismiss_slots(conn);
+		smc_cdc_wait_pend_tx_wr(conn);
 	}
 	smc_lgr_unregister_conn(conn);
 	smc_close_active_abort(smc);
@@ -1459,11 +1459,16 @@ void smc_smcd_terminate_all(struct smcd_dev *smcd)
 /* Called when an SMCR device is removed or the smc module is unloaded.
  * If smcibdev is given, all SMCR link groups using this device are terminated.
  * If smcibdev is NULL, all SMCR link groups are terminated.
+ *
+ * We must wait here for QPs been destroyed before we destroy the CQs,
+ * or we won't received any CQEs and cdc_pend_tx_wr cannot reach 0 thus
+ * smc_sock cannot be released.
  */
 void smc_smcr_terminate_all(struct smc_ib_device *smcibdev)
 {
 	struct smc_link_group *lgr, *lg;
 	LIST_HEAD(lgr_free_list);
+	LIST_HEAD(lgr_linkdown_list);
 	int i;
 
 	spin_lock_bh(&smc_lgr_list.lock);
@@ -1475,7 +1480,7 @@ void smc_smcr_terminate_all(struct smc_ib_device *smcibdev)
 		list_for_each_entry_safe(lgr, lg, &smc_lgr_list.list, list) {
 			for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
 				if (lgr->lnk[i].smcibdev == smcibdev)
-					smcr_link_down_cond_sched(&lgr->lnk[i]);
+					list_move_tail(&lgr->list, &lgr_linkdown_list);
 			}
 		}
 	}
@@ -1487,6 +1492,16 @@ void smc_smcr_terminate_all(struct smc_ib_device *smcibdev)
 		__smc_lgr_terminate(lgr, false);
 	}
 
+	list_for_each_entry_safe(lgr, lg, &lgr_linkdown_list, list) {
+		for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
+			if (lgr->lnk[i].smcibdev == smcibdev) {
+				mutex_lock(&lgr->llc_conf_mutex);
+				smcr_link_down_cond(&lgr->lnk[i]);
+				mutex_unlock(&lgr->llc_conf_mutex);
+			}
+		}
+	}
+
 	if (smcibdev) {
 		if (atomic_read(&smcibdev->lnk_cnt))
 			wait_event(smcibdev->lnks_deleted,
@@ -1586,7 +1601,6 @@ static void smcr_link_down(struct smc_link *lnk)
 	if (!lgr || lnk->state == SMC_LNK_UNUSED || list_empty(&lgr->list))
 		return;
 
-	smc_ib_modify_qp_reset(lnk);
 	to_lnk = smc_switch_conns(lgr, lnk, true);
 	if (!to_lnk) { /* no backup link available */
 		smcr_link_clear(lnk, true);
@@ -1824,6 +1838,7 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 	conn->local_tx_ctrl.common.type = SMC_CDC_MSG_TYPE;
 	conn->local_tx_ctrl.len = SMC_WR_TX_SIZE;
 	conn->urg_state = SMC_URG_READ;
+	init_waitqueue_head(&conn->cdc_pend_tx_wq);
 	INIT_WORK(&smc->conn.abort_work, smc_conn_abort_work);
 	if (ini->is_smcd) {
 		conn->rx_off = sizeof(struct smcd_cdc_msg);
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index d93055ec17ae..fe5d5399c4e8 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -109,12 +109,12 @@ int smc_ib_modify_qp_rts(struct smc_link *lnk)
 			    IB_QP_MAX_QP_RD_ATOMIC);
 }
 
-int smc_ib_modify_qp_reset(struct smc_link *lnk)
+int smc_ib_modify_qp_error(struct smc_link *lnk)
 {
 	struct ib_qp_attr qp_attr;
 
 	memset(&qp_attr, 0, sizeof(qp_attr));
-	qp_attr.qp_state = IB_QPS_RESET;
+	qp_attr.qp_state = IB_QPS_ERR;
 	return ib_modify_qp(lnk->roce_qp, &qp_attr, IB_QP_STATE);
 }
 
diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
index 07585937370e..bfa1c6bf6313 100644
--- a/net/smc/smc_ib.h
+++ b/net/smc/smc_ib.h
@@ -90,6 +90,7 @@ int smc_ib_create_queue_pair(struct smc_link *lnk);
 int smc_ib_ready_link(struct smc_link *lnk);
 int smc_ib_modify_qp_rts(struct smc_link *lnk);
 int smc_ib_modify_qp_reset(struct smc_link *lnk);
+int smc_ib_modify_qp_error(struct smc_link *lnk);
 long smc_ib_setup_per_ibdev(struct smc_ib_device *smcibdev);
 int smc_ib_get_memory_region(struct ib_pd *pd, int access_flags,
 			     struct smc_buf_desc *buf_slot, u8 link_idx);
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index aaf3028a6fe9..bb0946b32479 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -62,13 +62,9 @@ static inline bool smc_wr_is_tx_pend(struct smc_link *link)
 }
 
 /* wait till all pending tx work requests on the given link are completed */
-int smc_wr_tx_wait_no_pending_sends(struct smc_link *link)
+void smc_wr_tx_wait_no_pending_sends(struct smc_link *link)
 {
-	if (wait_event_timeout(link->wr_tx_wait, !smc_wr_is_tx_pend(link),
-			       SMC_WR_TX_WAIT_PENDING_TIME))
-		return 0;
-	else /* timeout */
-		return -EPIPE;
+	wait_event(link->wr_tx_wait, !smc_wr_is_tx_pend(link));
 }
 
 static inline int smc_wr_tx_find_pending_index(struct smc_link *link, u64 wr_id)
@@ -87,7 +83,6 @@ static inline void smc_wr_tx_process_cqe(struct ib_wc *wc)
 	struct smc_wr_tx_pend pnd_snd;
 	struct smc_link *link;
 	u32 pnd_snd_idx;
-	int i;
 
 	link = wc->qp->qp_context;
 
@@ -128,14 +123,6 @@ static inline void smc_wr_tx_process_cqe(struct ib_wc *wc)
 	}
 
 	if (wc->status) {
-		for_each_set_bit(i, link->wr_tx_mask, link->wr_tx_cnt) {
-			/* clear full struct smc_wr_tx_pend including .priv */
-			memset(&link->wr_tx_pends[i], 0,
-			       sizeof(link->wr_tx_pends[i]));
-			memset(&link->wr_tx_bufs[i], 0,
-			       sizeof(link->wr_tx_bufs[i]));
-			clear_bit(i, link->wr_tx_mask);
-		}
 		if (link->lgr->smc_version == SMC_V2) {
 			memset(link->wr_tx_v2_pend, 0,
 			       sizeof(*link->wr_tx_v2_pend));
@@ -419,25 +406,6 @@ int smc_wr_reg_send(struct smc_link *link, struct ib_mr *mr)
 	return rc;
 }
 
-void smc_wr_tx_dismiss_slots(struct smc_link *link, u8 wr_tx_hdr_type,
-			     smc_wr_tx_filter filter,
-			     smc_wr_tx_dismisser dismisser,
-			     unsigned long data)
-{
-	struct smc_wr_tx_pend_priv *tx_pend;
-	struct smc_wr_rx_hdr *wr_tx;
-	int i;
-
-	for_each_set_bit(i, link->wr_tx_mask, link->wr_tx_cnt) {
-		wr_tx = (struct smc_wr_rx_hdr *)&link->wr_tx_bufs[i];
-		if (wr_tx->type != wr_tx_hdr_type)
-			continue;
-		tx_pend = &link->wr_tx_pends[i].priv;
-		if (filter(tx_pend, data))
-			dismisser(tx_pend);
-	}
-}
-
 /****************************** receive queue ********************************/
 
 int smc_wr_rx_register_handler(struct smc_wr_rx_handler *handler)
@@ -673,10 +641,7 @@ void smc_wr_free_link(struct smc_link *lnk)
 	smc_wr_wakeup_reg_wait(lnk);
 	smc_wr_wakeup_tx_wait(lnk);
 
-	if (smc_wr_tx_wait_no_pending_sends(lnk))
-		memset(lnk->wr_tx_mask, 0,
-		       BITS_TO_LONGS(SMC_WR_BUF_CNT) *
-						sizeof(*lnk->wr_tx_mask));
+	smc_wr_tx_wait_no_pending_sends(lnk);
 	wait_event(lnk->wr_reg_wait, (!atomic_read(&lnk->wr_reg_refcnt)));
 	wait_event(lnk->wr_tx_wait, (!atomic_read(&lnk->wr_tx_refcnt)));
 
diff --git a/net/smc/smc_wr.h b/net/smc/smc_wr.h
index 48ed9b08ac7a..47512ccce5ef 100644
--- a/net/smc/smc_wr.h
+++ b/net/smc/smc_wr.h
@@ -22,7 +22,6 @@
 #define SMC_WR_BUF_CNT 16	/* # of ctrl buffers per link */
 
 #define SMC_WR_TX_WAIT_FREE_SLOT_TIME	(10 * HZ)
-#define SMC_WR_TX_WAIT_PENDING_TIME	(5 * HZ)
 
 #define SMC_WR_TX_SIZE 44 /* actual size of wr_send data (<=SMC_WR_BUF_SIZE) */
 
@@ -130,7 +129,7 @@ void smc_wr_tx_dismiss_slots(struct smc_link *lnk, u8 wr_rx_hdr_type,
 			     smc_wr_tx_filter filter,
 			     smc_wr_tx_dismisser dismisser,
 			     unsigned long data);
-int smc_wr_tx_wait_no_pending_sends(struct smc_link *link);
+void smc_wr_tx_wait_no_pending_sends(struct smc_link *link);
 
 int smc_wr_rx_register_handler(struct smc_wr_rx_handler *handler);
 int smc_wr_rx_post_init(struct smc_link *link);
-- 
2.19.1.3.ge56e4f7

