Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DA35A2503
	for <lists+linux-s390@lfdr.de>; Fri, 26 Aug 2022 11:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344103AbiHZJwE (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 26 Aug 2022 05:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343698AbiHZJv5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 26 Aug 2022 05:51:57 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195EDD5723;
        Fri, 26 Aug 2022 02:51:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VNIZJ-4_1661507510;
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VNIZJ-4_1661507510)
          by smtp.aliyun-inc.com;
          Fri, 26 Aug 2022 17:51:51 +0800
From:   "D. Wythe" <alibuda@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        "D. Wythe" <alibuda@linux.alibaba.com>
Subject: [PATCH net-next v2 01/10] net/smc: remove locks smc_client_lgr_pending and smc_server_lgr_pending
Date:   Fri, 26 Aug 2022 17:51:28 +0800
Message-Id: <688d165fe630989665e5091a28a5b1238123fbdc.1661407821.git.alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1661407821.git.alibuda@linux.alibaba.com>
References: <cover.1661407821.git.alibuda@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: "D. Wythe" <alibuda@linux.alibaba.com>

This patch attempts to remove locks named smc_client_lgr_pending and
smc_server_lgr_pending, which aim to serialize the creation of link
group. However, once link group existed already, those locks are
meaningless, worse still, they make incoming connections have to be
queued one after the other.

Now, the creation of link group is no longer generated by competition,
but allocated through following strategy.

1. Try to find a suitable link group, if successd, current connection
is considered as NON first contact connection. ends.

2. Check the number of connections currently waiting for a suitable
link group to be created, if it is not less that the number of link
groups to be created multiplied by (SMC_RMBS_PER_LGR_MAX - 1), then
increase the number of link groups to be created, current connection
is considered as the first contact connection. ends.

3. Increase the number of connections currently waiting, and wait
for woken up.

4. Decrease the number of connections currently waiting, goto 1.

We wake up the connection that was put to sleep in stage 3 through
the SMC link state change event. Once the link moves out of the
SMC_LNK_ACTIVATING state, decrease the number of link groups to
be created, and then wake up at most (SMC_RMBS_PER_LGR_MAX - 1)
connections.

In the iplementation, we introduce the concept of lnk cluster, which is
a collection of links with the same characteristics (see
smcr_lnk_cluster_cmpfn() with more details), which makes it possible to
wake up efficiently in the scenario of N v.s 1.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c   |  13 +-
 net/smc/smc_core.c | 352 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 net/smc/smc_core.h |  53 ++++++++
 net/smc/smc_llc.c  |   9 +-
 4 files changed, 411 insertions(+), 16 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 79c1318..d0e6bec 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1194,10 +1194,8 @@ static int smc_connect_rdma(struct smc_sock *smc,
 	if (reason_code)
 		return reason_code;
 
-	mutex_lock(&smc_client_lgr_pending);
 	reason_code = smc_conn_create(smc, ini);
 	if (reason_code) {
-		mutex_unlock(&smc_client_lgr_pending);
 		return reason_code;
 	}
 
@@ -1289,7 +1287,6 @@ static int smc_connect_rdma(struct smc_sock *smc,
 		if (reason_code)
 			goto connect_abort;
 	}
-	mutex_unlock(&smc_client_lgr_pending);
 
 	smc_copy_sock_settings_to_clc(smc);
 	smc->connect_nonblock = 0;
@@ -1299,7 +1296,6 @@ static int smc_connect_rdma(struct smc_sock *smc,
 	return 0;
 connect_abort:
 	smc_conn_abort(smc, ini->first_contact_local);
-	mutex_unlock(&smc_client_lgr_pending);
 	smc->connect_nonblock = 0;
 
 	return reason_code;
@@ -2377,7 +2373,8 @@ static void smc_listen_work(struct work_struct *work)
 	if (rc)
 		goto out_decl;
 
-	mutex_lock(&smc_server_lgr_pending);
+	if (ini->is_smcd)
+		mutex_lock(&smc_server_lgr_pending);
 	smc_close_init(new_smc);
 	smc_rx_init(new_smc);
 	smc_tx_init(new_smc);
@@ -2404,8 +2401,6 @@ static void smc_listen_work(struct work_struct *work)
 	rc = smc_clc_wait_msg(new_smc, cclc, sizeof(*buf),
 			      SMC_CLC_CONFIRM, CLC_WAIT_TIME);
 	if (rc) {
-		if (!ini->is_smcd)
-			goto out_unlock;
 		goto out_decl;
 	}
 
@@ -2415,7 +2410,6 @@ static void smc_listen_work(struct work_struct *work)
 					    ini->first_contact_local, ini);
 		if (rc)
 			goto out_unlock;
-		mutex_unlock(&smc_server_lgr_pending);
 	}
 	smc_conn_save_peer_info(new_smc, cclc);
 	smc_listen_out_connected(new_smc);
@@ -2423,7 +2417,8 @@ static void smc_listen_work(struct work_struct *work)
 	goto out_free;
 
 out_unlock:
-	mutex_unlock(&smc_server_lgr_pending);
+	if (ini->is_smcd)
+		mutex_unlock(&smc_server_lgr_pending);
 out_decl:
 	smc_listen_decline(new_smc, rc, ini ? ini->first_contact_local : 0,
 			   proposal_version);
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index ff49a11..cfaddf2 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -46,6 +46,10 @@ struct smc_lgr_list smc_lgr_list = {	/* established link groups */
 	.num = 0,
 };
 
+static struct smc_lgr_manager smc_lgr_manager = {
+	.lock = __SPIN_LOCK_UNLOCKED(smc_lgr_manager.lock),
+};
+
 static atomic_t lgr_cnt = ATOMIC_INIT(0); /* number of existing link groups */
 static DECLARE_WAIT_QUEUE_HEAD(lgrs_deleted);
 
@@ -55,6 +59,255 @@ static void smc_buf_free(struct smc_link_group *lgr, bool is_rmb,
 
 static void smc_link_down_work(struct work_struct *work);
 
+/* SMC-R lnk cluster compare func
+ * All lnks that meet the description conditions of this function
+ * are logically aggregated, called lnk cluster.
+ * For the server side, lnk cluster is used to determine whether
+ * a new group needs to be created when processing new imcoming connections.
+ * For the client side, lnk cluster is used to determine whether
+ * to wait for link ready (in other words, first contact ready).
+ */
+static int smcr_link_cluster_cmpfn(struct rhashtable_compare_arg *arg, const void *obj)
+{
+	const struct smc_link_cluster_compare_arg *key = arg->key;
+	const struct smc_link_cluster *lnkc = obj;
+
+	if (memcmp(key->peer_systemid, lnkc->peer_systemid, SMC_SYSTEMID_LEN))
+		return 1;
+
+	if (memcmp(key->peer_gid, lnkc->peer_gid, SMC_GID_SIZE))
+		return 1;
+
+	if ((key->role == SMC_SERV || key->clcqpn == lnkc->clcqpn) &&
+	    (key->smcr_version == SMC_V2 ||
+	    !memcmp(key->peer_mac, lnkc->peer_mac, ETH_ALEN)))
+		return 0;
+
+	return 1;
+}
+
+/* SMC-R lnk cluster hash func */
+static u32 smcr_link_cluster_hashfn(const void *data, u32 len, u32 seed)
+{
+	const struct smc_link_cluster *lnkc = data;
+
+	return jhash2((u32 *)lnkc->peer_systemid, SMC_SYSTEMID_LEN / sizeof(u32), seed)
+		+ ((lnkc->role == SMC_SERV) ? 0 : lnkc->clcqpn);
+}
+
+/* SMC-R lnk cluster compare arg hash func */
+static u32 smcr_link_cluster_compare_arg_hashfn(const void *data, u32 len, u32 seed)
+{
+	const struct smc_link_cluster_compare_arg *key = data;
+
+	return jhash2((u32 *)key->peer_systemid, SMC_SYSTEMID_LEN / sizeof(u32), seed)
+		+ ((key->role == SMC_SERV) ? 0 : key->clcqpn);
+}
+
+static const struct rhashtable_params smcr_link_cluster_rhl_params = {
+	.head_offset = offsetof(struct smc_link_cluster, rnode),
+	.key_len = sizeof(struct smc_link_cluster_compare_arg),
+	.obj_cmpfn = smcr_link_cluster_cmpfn,
+	.obj_hashfn = smcr_link_cluster_hashfn,
+	.hashfn = smcr_link_cluster_compare_arg_hashfn,
+	.automatic_shrinking = true,
+};
+
+/* hold a reference for smc_link_cluster */
+static inline void smc_link_cluster_hold(struct smc_link_cluster *lnkc)
+{
+	if (likely(lnkc))
+		refcount_inc(&lnkc->ref);
+}
+
+/* release a reference for smc_link_cluster */
+static inline void smc_link_cluster_put(struct smc_link_cluster *lnkc)
+{
+	bool do_free = false;
+
+	if (!lnkc)
+		return;
+
+	if (refcount_dec_not_one(&lnkc->ref))
+		return;
+
+	spin_lock_bh(&smc_lgr_manager.lock);
+	/* last ref */
+	if (refcount_dec_and_test(&lnkc->ref)) {
+		do_free = true;
+		rhashtable_remove_fast(&smc_lgr_manager.link_cluster_maps, &lnkc->rnode,
+				       smcr_link_cluster_rhl_params);
+	}
+	spin_unlock_bh(&smc_lgr_manager.lock);
+	if (do_free)
+		kfree(lnkc);
+}
+
+/* Get or create smc_link_cluster by key
+ * This function will hold a reference of returned smc_link_cluster
+ * or create a new smc_link_cluster with the reference initialized to 1。
+ * caller MUST call smc_link_cluster_put after this.
+ */
+static inline struct smc_link_cluster *
+smcr_link_get_or_create_cluster(struct smc_link_cluster_compare_arg *key)
+{
+	struct smc_link_cluster *lnkc;
+	int err;
+
+	spin_lock_bh(&smc_lgr_manager.lock);
+	lnkc = rhashtable_lookup_fast(&smc_lgr_manager.link_cluster_maps, key,
+				      smcr_link_cluster_rhl_params);
+	if (!lnkc) {
+		lnkc = kzalloc(sizeof(*lnkc), GFP_ATOMIC);
+		if (unlikely(!lnkc))
+			goto fail;
+
+		/* init cluster */
+		spin_lock_init(&lnkc->lock);
+		lnkc->role = key->role;
+		if (key->role == SMC_CLNT)
+			lnkc->clcqpn = key->clcqpn;
+		init_waitqueue_head(&lnkc->first_contact_waitqueue);
+		memcpy(lnkc->peer_systemid, key->peer_systemid, SMC_SYSTEMID_LEN);
+		memcpy(lnkc->peer_gid, key->peer_gid, SMC_GID_SIZE);
+		memcpy(lnkc->peer_mac, key->peer_mac, ETH_ALEN);
+		refcount_set(&lnkc->ref, 1);
+
+		err = rhashtable_insert_fast(&smc_lgr_manager.link_cluster_maps,
+					     &lnkc->rnode, smcr_link_cluster_rhl_params);
+		if (unlikely(err)) {
+			pr_warn_ratelimited("smc: rhashtable_insert_fast failed (%d)", err);
+			kfree(lnkc);
+			lnkc = NULL;
+		}
+	} else {
+		smc_link_cluster_hold(lnkc);
+	}
+fail:
+	spin_unlock_bh(&smc_lgr_manager.lock);
+	return lnkc;
+}
+
+/* Get or create a smc_link_cluster by lnk
+ * caller MUST call smc_link_cluster_put after this.
+ */
+static inline struct smc_link_cluster *smcr_link_get_cluster(struct smc_link *lnk)
+{
+	struct smc_link_cluster_compare_arg key;
+	struct smc_link_group *lgr;
+
+	lgr = lnk->lgr;
+	if (!lgr || lgr->is_smcd)
+		return NULL;
+
+	key.smcr_version = lgr->smc_version;
+	key.peer_systemid = lgr->peer_systemid;
+	key.peer_gid = lnk->peer_gid;
+	key.peer_mac = lnk->peer_mac;
+	key.role	 = lgr->role;
+	if (key.role == SMC_CLNT)
+		key.clcqpn = lnk->peer_qpn;
+
+	return smcr_link_get_or_create_cluster(&key);
+}
+
+/* Get or create a smc_link_cluster by ini
+ * caller MUST call smc_link_cluster_put after this.
+ */
+static inline struct smc_link_cluster *
+smcr_link_get_cluster_by_ini(struct smc_init_info *ini, int role)
+{
+	struct smc_link_cluster_compare_arg key;
+
+	if (ini->is_smcd)
+		return NULL;
+
+	key.smcr_version = ini->smcr_version;
+	key.peer_systemid = ini->peer_systemid;
+	key.peer_gid = ini->peer_gid;
+	key.peer_mac = ini->peer_mac;
+	key.role	= role;
+	if (role == SMC_CLNT)
+		key.clcqpn	= ini->ib_clcqpn;
+
+	return smcr_link_get_or_create_cluster(&key);
+}
+
+/* callback when smc link state change */
+void smcr_link_cluster_on_link_state(struct smc_link *lnk)
+{
+	struct smc_link_cluster *lnkc;
+	int nr = 0;
+
+	/* barrier for lnk->state */
+	smp_mb();
+
+	/* only first link can made connections block on
+	 * first_contact_waitqueue
+	 */
+	if (lnk->link_idx != SMC_SINGLE_LINK)
+		return;
+
+	/* state already seen  */
+	if (lnk->state_record & SMC_LNK_STATE_BIT(lnk->state))
+		return;
+
+	lnkc = smcr_link_get_cluster(lnk);
+
+	if (unlikely(!lnkc))
+		return;
+
+	spin_lock_bh(&lnkc->lock);
+
+	/* all lnk state change should be
+	 * 1. SMC_LNK_UNUSED -> SMC_LNK_TEAR_DOWN (link init failed)
+	 * 2. SMC_LNK_UNUSED -> SMC_LNK_ACTIVATING -> SMC_LNK_TEAR_DOWN
+	 * 3. SMC_LNK_UNUSED -> SMC_LNK_ACTIVATING -> SMC_LNK_INACTIVE -> SMC_LNK_TEAR_DOWN
+	 * 4. SMC_LNK_UNUSED -> SMC_LNK_ACTIVATING -> SMC_LNK_INACTIVE -> SMC_LNK_TEAR_DOWN
+	 * 5. SMC_LNK_UNUSED -> SMC_LNK_ATIVATING -> SMC_LNK_ACTIVE ->SMC_LNK_INACTIVE
+	 * -> SMC_LNK_TEAR_DOWN
+	 */
+	switch (lnk->state) {
+	case SMC_LNK_ACTIVATING:
+		/* It's safe to hold a reference without lock
+		 * dues to the smcr_link_get_cluster already hold one
+		 */
+		smc_link_cluster_hold(lnkc);
+		break;
+	case SMC_LNK_TEAR_DOWN:
+		if (lnk->state_record & SMC_LNK_STATE_BIT(SMC_LNK_ACTIVATING))
+			/* smc_link_cluster_hold in SMC_LNK_ACTIVATING */
+			smc_link_cluster_put(lnkc);
+		fallthrough;
+	case SMC_LNK_ACTIVE:
+	case SMC_LNK_INACTIVE:
+		if (!(lnk->state_record &
+			(SMC_LNK_STATE_BIT(SMC_LNK_ACTIVE)
+			| SMC_LNK_STATE_BIT(SMC_LNK_INACTIVE)))) {
+			lnkc->pending_capability -= (SMC_RMBS_PER_LGR_MAX - 1);
+			nr = SMC_RMBS_PER_LGR_MAX - 1;
+			if (unlikely(lnk->state != SMC_LNK_ACTIVE)) {
+				lnkc->lacking_first_contact++;
+				/* only to wake up one connection to perfrom
+				 * first contact in server side, client MUST wake up
+				 * all to decline.
+				 */
+				if (lnkc->role == SMC_SERV)
+					nr = 1;
+			}
+		}
+		break;
+	case SMC_LNK_UNUSED:
+		pr_warn_ratelimited("net/smc: invalid lnk state. ");
+		break;
+	}
+	SMC_LNK_STATE_RECORD(lnk, lnk->state);
+	spin_unlock_bh(&lnkc->lock);
+	if (nr)
+		wake_up_nr(&lnkc->first_contact_waitqueue, nr);
+	smc_link_cluster_put(lnkc);	/* smc_link_cluster_hold in smcr_link_get_cluster */
+}
+
 /* return head of link group list and its lock for a given link group */
 static inline struct list_head *smc_lgr_list_head(struct smc_link_group *lgr,
 						  spinlock_t **lgr_lock)
@@ -651,8 +904,10 @@ static void smcr_lgr_link_deactivate_all(struct smc_link_group *lgr)
 	for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
 		struct smc_link *lnk = &lgr->lnk[i];
 
-		if (smc_link_sendable(lnk))
+		if (smc_link_sendable(lnk)) {
 			lnk->state = SMC_LNK_INACTIVE;
+			smcr_link_cluster_on_link_state(lnk);
+		}
 	}
 	wake_up_all(&lgr->llc_msg_waiter);
 	wake_up_all(&lgr->llc_flow_waiter);
@@ -756,12 +1011,16 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 	lnk->link_id = smcr_next_link_id(lgr);
 	lnk->lgr = lgr;
 	smc_lgr_hold(lgr); /* lgr_put in smcr_link_clear() */
+	rwlock_init(&lnk->rtokens_lock);
 	lnk->link_idx = link_idx;
 	smc_ibdev_cnt_inc(lnk);
 	smcr_copy_dev_info_to_link(lnk);
 	atomic_set(&lnk->conn_cnt, 0);
 	smc_llc_link_set_uid(lnk);
 	INIT_WORK(&lnk->link_down_wrk, smc_link_down_work);
+	lnk->peer_qpn = ini->ib_clcqpn;
+	memcpy(lnk->peer_gid, ini->peer_gid, SMC_GID_SIZE);
+	memcpy(lnk->peer_mac, ini->peer_mac, sizeof(lnk->peer_mac));
 	if (!lnk->smcibdev->initialized) {
 		rc = (int)smc_ib_setup_per_ibdev(lnk->smcibdev);
 		if (rc)
@@ -792,6 +1051,7 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 	if (rc)
 		goto destroy_qp;
 	lnk->state = SMC_LNK_ACTIVATING;
+	smcr_link_cluster_on_link_state(lnk);
 	return 0;
 
 destroy_qp:
@@ -806,6 +1066,8 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 	smc_ibdev_cnt_dec(lnk);
 	put_device(&lnk->smcibdev->ibdev->dev);
 	smcibdev = lnk->smcibdev;
+	lnk->state = SMC_LNK_TEAR_DOWN;
+	smcr_link_cluster_on_link_state(lnk);
 	memset(lnk, 0, sizeof(struct smc_link));
 	lnk->state = SMC_LNK_UNUSED;
 	if (!atomic_dec_return(&smcibdev->lnk_cnt))
@@ -1263,6 +1525,8 @@ void smcr_link_clear(struct smc_link *lnk, bool log)
 	if (!lnk->lgr || lnk->clearing ||
 	    lnk->state == SMC_LNK_UNUSED)
 		return;
+	lnk->state = SMC_LNK_TEAR_DOWN;
+	smcr_link_cluster_on_link_state(lnk);
 	lnk->clearing = 1;
 	lnk->peer_qpn = 0;
 	smc_llc_link_clear(lnk, log);
@@ -1712,6 +1976,7 @@ void smcr_link_down_cond(struct smc_link *lnk)
 {
 	if (smc_link_downing(&lnk->state)) {
 		trace_smcr_link_down(lnk, __builtin_return_address(0));
+		smcr_link_cluster_on_link_state(lnk);
 		smcr_link_down(lnk);
 	}
 }
@@ -1721,6 +1986,7 @@ void smcr_link_down_cond_sched(struct smc_link *lnk)
 {
 	if (smc_link_downing(&lnk->state)) {
 		trace_smcr_link_down(lnk, __builtin_return_address(0));
+		smcr_link_cluster_on_link_state(lnk);
 		schedule_work(&lnk->link_down_wrk);
 	}
 }
@@ -1850,11 +2116,13 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 {
 	struct smc_connection *conn = &smc->conn;
 	struct net *net = sock_net(&smc->sk);
+	DECLARE_WAITQUEUE(wait, current);
+	struct smc_link_cluster *lnkc = NULL;
 	struct list_head *lgr_list;
 	struct smc_link_group *lgr;
 	enum smc_lgr_role role;
 	spinlock_t *lgr_lock;
-	int rc = 0;
+	int rc = 0, timeo = CLC_WAIT_TIME;
 
 	lgr_list = ini->is_smcd ? &ini->ism_dev[ini->ism_selected]->lgr_list :
 				  &smc_lgr_list.list;
@@ -1862,12 +2130,29 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 				  &smc_lgr_list.lock;
 	ini->first_contact_local = 1;
 	role = smc->listen_smc ? SMC_SERV : SMC_CLNT;
-	if (role == SMC_CLNT && ini->first_contact_peer)
+
+	if (!ini->is_smcd) {
+		lnkc = smcr_link_get_cluster_by_ini(ini, role);
+		if (unlikely(!lnkc))
+			return SMC_CLC_DECL_INTERR;
+	}
+
+	if (role == SMC_CLNT && ini->first_contact_peer) {
+		if (!ini->is_smcd) {
+			/* first_contact */
+			spin_lock_bh(&lnkc->lock);
+			lnkc->pending_capability += (SMC_RMBS_PER_LGR_MAX - 1);
+			spin_unlock_bh(&lnkc->lock);
+		}
 		/* create new link group as well */
 		goto create;
+	}
 
 	/* determine if an existing link group can be reused */
 	spin_lock_bh(lgr_lock);
+	if (!ini->is_smcd)
+		spin_lock(&lnkc->lock);
+again:
 	list_for_each_entry(lgr, lgr_list, list) {
 		write_lock_bh(&lgr->conns_lock);
 		if ((ini->is_smcd ?
@@ -1894,9 +2179,41 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 		}
 		write_unlock_bh(&lgr->conns_lock);
 	}
+	if (!ini->is_smcd && ini->first_contact_local) {
+		if (lnkc->pending_capability > lnkc->conns_pending) {
+			lnkc->conns_pending++;
+			add_wait_queue(&lnkc->first_contact_waitqueue, &wait);
+			spin_unlock(&lnkc->lock);
+			spin_unlock_bh(lgr_lock);
+			set_current_state(TASK_INTERRUPTIBLE);
+			/* need to wait at least once first contact done */
+			timeo = schedule_timeout(timeo);
+			set_current_state(TASK_RUNNING);
+			remove_wait_queue(&lnkc->first_contact_waitqueue, &wait);
+			spin_lock_bh(lgr_lock);
+			spin_lock(&lnkc->lock);
+
+			lnkc->conns_pending--;
+			if (likely(timeo && !lnkc->lacking_first_contact))
+				goto again;
+
+			/* lnk create failed, only server side can raise
+			 * a new first contact. client side here will
+			 * fallback by SMC_CLC_DECL_SYNCERR.
+			 */
+			if (role == SMC_SERV && lnkc->lacking_first_contact)
+				lnkc->lacking_first_contact--;
+		}
+		if (role == SMC_SERV) {
+			/* first_contact */
+			lnkc->pending_capability += (SMC_RMBS_PER_LGR_MAX - 1);
+		}
+	}
+	if (!ini->is_smcd)
+		spin_unlock(&lnkc->lock);
 	spin_unlock_bh(lgr_lock);
 	if (rc)
-		return rc;
+		goto out;
 
 	if (role == SMC_CLNT && !ini->first_contact_peer &&
 	    ini->first_contact_local) {
@@ -1904,7 +2221,8 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 		 * a new one
 		 * send out_of_sync decline, reason synchr. error
 		 */
-		return SMC_CLC_DECL_SYNCERR;
+		rc = SMC_CLC_DECL_SYNCERR;
+		goto out;
 	}
 
 create:
@@ -1941,6 +2259,9 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 #endif
 
 out:
+	/* smc_link_cluster_hold in smcr_link_get_or_create_cluster */
+	if (!ini->is_smcd)
+		smc_link_cluster_put(lnkc);
 	return rc;
 }
 
@@ -2500,19 +2821,24 @@ int smc_rtoken_add(struct smc_link *lnk, __be64 nw_vaddr, __be32 nw_rkey)
 	u32 rkey = ntohl(nw_rkey);
 	int i;
 
+	write_lock_bh(&lnk->rtokens_lock);
 	for (i = 0; i < SMC_RMBS_PER_LGR_MAX; i++) {
 		if (lgr->rtokens[i][lnk->link_idx].rkey == rkey &&
 		    lgr->rtokens[i][lnk->link_idx].dma_addr == dma_addr &&
 		    test_bit(i, lgr->rtokens_used_mask)) {
 			/* already in list */
+			write_unlock_bh(&lnk->rtokens_lock);
 			return i;
 		}
 	}
 	i = smc_rmb_reserve_rtoken_idx(lgr);
-	if (i < 0)
+	if (i < 0) {
+		write_unlock_bh(&lnk->rtokens_lock);
 		return i;
+	}
 	lgr->rtokens[i][lnk->link_idx].rkey = rkey;
 	lgr->rtokens[i][lnk->link_idx].dma_addr = dma_addr;
+	write_unlock_bh(&lnk->rtokens_lock);
 	return i;
 }
 
@@ -2523,6 +2849,7 @@ int smc_rtoken_delete(struct smc_link *lnk, __be32 nw_rkey)
 	u32 rkey = ntohl(nw_rkey);
 	int i, j;
 
+	write_lock_bh(&lnk->rtokens_lock);
 	for (i = 0; i < SMC_RMBS_PER_LGR_MAX; i++) {
 		if (lgr->rtokens[i][lnk->link_idx].rkey == rkey &&
 		    test_bit(i, lgr->rtokens_used_mask)) {
@@ -2531,9 +2858,11 @@ int smc_rtoken_delete(struct smc_link *lnk, __be32 nw_rkey)
 				lgr->rtokens[i][j].dma_addr = 0;
 			}
 			clear_bit(i, lgr->rtokens_used_mask);
+			write_unlock_bh(&lnk->rtokens_lock);
 			return 0;
 		}
 	}
+	write_unlock_bh(&lnk->rtokens_lock);
 	return -ENOENT;
 }
 
@@ -2599,12 +2928,23 @@ static int smc_core_reboot_event(struct notifier_block *this,
 
 int __init smc_core_init(void)
 {
+	/* init smc lnk cluster maps */
+	rhashtable_init(&smc_lgr_manager.link_cluster_maps, &smcr_link_cluster_rhl_params);
 	return register_reboot_notifier(&smc_reboot_notifier);
 }
 
+static void smc_link_cluster_free_cb(void *ptr, void *arg)
+{
+	pr_warn("smc: smc lnk cluster refcnt leak.\n");
+	kfree(ptr);
+}
+
 /* Called (from smc_exit) when module is removed */
 void smc_core_exit(void)
 {
 	unregister_reboot_notifier(&smc_reboot_notifier);
 	smc_lgrs_shutdown();
+	/* destroy smc lnk cluster maps */
+	rhashtable_free_and_destroy(&smc_lgr_manager.link_cluster_maps, smc_link_cluster_free_cb,
+				    NULL);
 }
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index fe8b524..3c3bc11 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -15,6 +15,7 @@
 #include <linux/atomic.h>
 #include <linux/smc.h>
 #include <linux/pci.h>
+#include <linux/rhashtable.h>
 #include <rdma/ib_verbs.h>
 #include <net/genetlink.h>
 
@@ -29,18 +30,66 @@ struct smc_lgr_list {			/* list of link group definition */
 	u32			num;	/* unique link group number */
 };
 
+struct smc_lgr_manager {		/* manager for link group */
+	struct rhashtable	link_cluster_maps;	/* maps of smc_link_cluster */
+	spinlock_t		lock;	/* lock for lgr_cm_maps */
+};
+
+struct smc_link_cluster {
+	struct rhash_head	rnode;	/* node for rhashtable */
+	struct wait_queue_head	first_contact_waitqueue;
+					/* queue for non first contact to wait
+					 * first contact to be established.
+					 */
+	spinlock_t		lock;	/* protection for link group */
+	refcount_t		ref;	/* refcount for cluster */
+	unsigned long		pending_capability;
+					/* maximum pending number of connections that
+					 * need wait first contact complete.
+					 */
+	unsigned long		conns_pending;
+					/* connections that are waiting for first contact
+					 * complete
+					 */
+	u32					lacking_first_contact;
+					/* indicate that the connection
+					 * should perform first contact.
+					 */
+	u8		peer_systemid[SMC_SYSTEMID_LEN];
+	u8		peer_mac[ETH_ALEN];	/* = gid[8:10||13:15] */
+	u8		peer_gid[SMC_GID_SIZE];	/* gid of peer*/
+	int		clcqpn;
+	int		role;
+};
+
 enum smc_lgr_role {		/* possible roles of a link group */
 	SMC_CLNT,	/* client */
 	SMC_SERV	/* server */
 };
 
+struct smc_link_cluster_compare_arg	/* key for smc_link_cluster */
+{
+	int	smcr_version;
+	enum smc_lgr_role role;
+	u8	*peer_systemid;
+	u8	*peer_gid;
+	u8	*peer_mac;
+	int clcqpn;
+};
+
 enum smc_link_state {			/* possible states of a link */
 	SMC_LNK_UNUSED,		/* link is unused */
 	SMC_LNK_INACTIVE,	/* link is inactive */
 	SMC_LNK_ACTIVATING,	/* link is being activated */
 	SMC_LNK_ACTIVE,		/* link is active */
+	SMC_LNK_TEAR_DOWN,	/* link is tear down */
 };
 
+#define SMC_LNK_STATE_BIT(state)	(1 << (state))
+
+#define	SMC_LNK_STATE_RECORD(lnk, state)	\
+	((lnk)->state_record |= SMC_LNK_STATE_BIT(state))
+
 #define SMC_WR_BUF_SIZE		48	/* size of work request buffer */
 #define SMC_WR_BUF_V2_SIZE	8192	/* size of v2 work request buffer */
 
@@ -107,6 +156,7 @@ struct smc_link {
 	u32			wr_tx_cnt;	/* number of WR send buffers */
 	wait_queue_head_t	wr_tx_wait;	/* wait for free WR send buf */
 	atomic_t		wr_tx_refcnt;	/* tx refs to link */
+	rwlock_t		rtokens_lock;
 
 	struct smc_wr_buf	*wr_rx_bufs;	/* WR recv payload buffers */
 	struct ib_recv_wr	*wr_rx_ibs;	/* WR recv meta data */
@@ -145,6 +195,7 @@ struct smc_link {
 	int			ndev_ifidx; /* network device ifindex */
 
 	enum smc_link_state	state;		/* state of link */
+	int			state_record;		/* record of previous state */
 	struct delayed_work	llc_testlink_wrk; /* testlink worker */
 	struct completion	llc_testlink_resp; /* wait for rx of testlink */
 	int			llc_testlink_time; /* testlink interval */
@@ -557,6 +608,8 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
 int smcr_nl_get_link(struct sk_buff *skb, struct netlink_callback *cb);
 int smcd_nl_get_lgr(struct sk_buff *skb, struct netlink_callback *cb);
 
+void smcr_link_cluster_on_link_state(struct smc_link *lnk);
+
 static inline struct smc_link_group *smc_get_lgr(struct smc_link *link)
 {
 	return link->lgr;
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 175026a..c1ce80b 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -1099,6 +1099,7 @@ int smc_llc_cli_add_link(struct smc_link *link, struct smc_llc_qentry *qentry)
 		goto out;
 out_clear_lnk:
 	lnk_new->state = SMC_LNK_INACTIVE;
+	smcr_link_cluster_on_link_state(lnk_new);
 	smcr_link_clear(lnk_new, false);
 out_reject:
 	smc_llc_cli_add_link_reject(qentry);
@@ -1278,6 +1279,7 @@ static void smc_llc_delete_asym_link(struct smc_link_group *lgr)
 		return; /* no asymmetric link */
 	if (!smc_link_downing(&lnk_asym->state))
 		return;
+	smcr_link_cluster_on_link_state(lnk_asym);
 	lnk_new = smc_switch_conns(lgr, lnk_asym, false);
 	smc_wr_tx_wait_no_pending_sends(lnk_asym);
 	if (!lnk_new)
@@ -1492,6 +1494,7 @@ int smc_llc_srv_add_link(struct smc_link *link,
 out_err:
 	if (link_new) {
 		link_new->state = SMC_LNK_INACTIVE;
+		smcr_link_cluster_on_link_state(link_new);
 		smcr_link_clear(link_new, false);
 	}
 out:
@@ -1602,8 +1605,10 @@ static void smc_llc_process_cli_delete_link(struct smc_link_group *lgr)
 	del_llc->reason = 0;
 	smc_llc_send_message(lnk, &qentry->msg); /* response */
 
-	if (smc_link_downing(&lnk_del->state))
+	if (smc_link_downing(&lnk_del->state)) {
+		smcr_link_cluster_on_link_state(lnk);
 		smc_switch_conns(lgr, lnk_del, false);
+	}
 	smcr_link_clear(lnk_del, true);
 
 	active_links = smc_llc_active_link_count(lgr);
@@ -1676,6 +1681,7 @@ static void smc_llc_process_srv_delete_link(struct smc_link_group *lgr)
 		goto out; /* asymmetric link already deleted */
 
 	if (smc_link_downing(&lnk_del->state)) {
+		smcr_link_cluster_on_link_state(lnk);
 		if (smc_switch_conns(lgr, lnk_del, false))
 			smc_wr_tx_wait_no_pending_sends(lnk_del);
 	}
@@ -2167,6 +2173,7 @@ void smc_llc_link_active(struct smc_link *link)
 		schedule_delayed_work(&link->llc_testlink_wrk,
 				      link->llc_testlink_time);
 	}
+	smcr_link_cluster_on_link_state(link);
 }
 
 /* called in worker context */
-- 
1.8.3.1

