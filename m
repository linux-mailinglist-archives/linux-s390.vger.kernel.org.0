Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65AA58F1CE
	for <lists+linux-s390@lfdr.de>; Wed, 10 Aug 2022 19:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiHJRsD (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 10 Aug 2022 13:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiHJRsB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 Aug 2022 13:48:01 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F07C8C012;
        Wed, 10 Aug 2022 10:47:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VLvs-tS_1660153666;
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VLvs-tS_1660153666)
          by smtp.aliyun-inc.com;
          Thu, 11 Aug 2022 01:47:46 +0800
From:   "D. Wythe" <alibuda@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH net-next 05/10] net/smc: llc_conf_mutex refactor, replace it with rw_semaphore
Date:   Thu, 11 Aug 2022 01:47:36 +0800
Message-Id: <7a58a89a310d9760f183a5db60844e439a613a4a.1660152975.git.alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1660152975.git.alibuda@linux.alibaba.com>
References: <cover.1660152975.git.alibuda@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: "D. Wythe" <alibuda@linux.alibaba.com>

llc_conf_mutex was used to protect links and link related configurations
in the same link group, for example, add or delete links. However,
in most cases, the protected critical area has only read semantics and
with no write semantics at all, such as obtaining a usable link or an
available rmb_desc.

This patch do simply code refactoring, replace mutex with rw_semaphore,
replace mutex_lock with down_write and replace mutex_unlock with
up_write.

Theoretically, this replacement is equivalent, but after this patch,
we can distinguish lock granularity according to different semantics
of critical areas.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c   |  8 ++++----
 net/smc/smc_core.c | 20 ++++++++++----------
 net/smc/smc_core.h |  2 +-
 net/smc/smc_llc.c  | 18 +++++++++---------
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index c0842a9..51b90e2 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -498,7 +498,7 @@ static int smcr_lgr_reg_sndbufs(struct smc_link *link,
 		return -EINVAL;
 
 	/* protect against parallel smcr_link_reg_buf() */
-	mutex_lock(&lgr->llc_conf_mutex);
+	down_write(&lgr->llc_conf_mutex);
 	for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
 		if (!smc_link_active(&lgr->lnk[i]))
 			continue;
@@ -506,7 +506,7 @@ static int smcr_lgr_reg_sndbufs(struct smc_link *link,
 		if (rc)
 			break;
 	}
-	mutex_unlock(&lgr->llc_conf_mutex);
+	up_write(&lgr->llc_conf_mutex);
 	return rc;
 }
 
@@ -523,7 +523,7 @@ static int smcr_lgr_reg_rmbs(struct smc_link *link,
 	/* protect against parallel smc_llc_cli_rkey_exchange() and
 	 * parallel smcr_link_reg_buf()
 	 */
-	mutex_lock(&lgr->llc_conf_mutex);
+	down_write(&lgr->llc_conf_mutex);
 	for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
 		if (!smc_link_active(&lgr->lnk[i]))
 			continue;
@@ -540,7 +540,7 @@ static int smcr_lgr_reg_rmbs(struct smc_link *link,
 	}
 	rmb_desc->is_conf_rkey = true;
 out:
-	mutex_unlock(&lgr->llc_conf_mutex);
+	up_write(&lgr->llc_conf_mutex);
 	smc_llc_flow_stop(lgr, &lgr->llc_flow_lcl);
 	return rc;
 }
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 61a3854..fc8deec 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1388,10 +1388,10 @@ static void smcr_buf_unuse(struct smc_buf_desc *buf_desc, bool is_rmb,
 		rc = smc_llc_flow_initiate(lgr, SMC_LLC_FLOW_RKEY);
 		if (!rc) {
 			/* protect against smc_llc_cli_rkey_exchange() */
-			mutex_lock(&lgr->llc_conf_mutex);
+			down_write(&lgr->llc_conf_mutex);
 			smc_llc_do_delete_rkey(lgr, buf_desc);
 			buf_desc->is_conf_rkey = false;
-			mutex_unlock(&lgr->llc_conf_mutex);
+			up_write(&lgr->llc_conf_mutex);
 			smc_llc_flow_stop(lgr, &lgr->llc_flow_lcl);
 		}
 	}
@@ -1661,12 +1661,12 @@ static void smc_lgr_free(struct smc_link_group *lgr)
 	int i;
 
 	if (!lgr->is_smcd) {
-		mutex_lock(&lgr->llc_conf_mutex);
+		down_write(&lgr->llc_conf_mutex);
 		for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
 			if (lgr->lnk[i].state != SMC_LNK_UNUSED)
 				smcr_link_clear(&lgr->lnk[i], false);
 		}
-		mutex_unlock(&lgr->llc_conf_mutex);
+		up_write(&lgr->llc_conf_mutex);
 		smc_llc_lgr_clear(lgr);
 	}
 
@@ -1980,12 +1980,12 @@ static void smcr_link_down(struct smc_link *lnk)
 	} else {
 		if (lgr->llc_flow_lcl.type != SMC_LLC_FLOW_NONE) {
 			/* another llc task is ongoing */
-			mutex_unlock(&lgr->llc_conf_mutex);
+			up_write(&lgr->llc_conf_mutex);
 			wait_event_timeout(lgr->llc_flow_waiter,
 				(list_empty(&lgr->list) ||
 				 lgr->llc_flow_lcl.type == SMC_LLC_FLOW_NONE),
 				SMC_LLC_WAIT_TIME);
-			mutex_lock(&lgr->llc_conf_mutex);
+			down_write(&lgr->llc_conf_mutex);
 		}
 		if (!list_empty(&lgr->list)) {
 			smc_llc_send_delete_link(to_lnk, del_link_id,
@@ -2047,9 +2047,9 @@ static void smc_link_down_work(struct work_struct *work)
 	if (list_empty(&lgr->list))
 		return;
 	wake_up_all(&lgr->llc_msg_waiter);
-	mutex_lock(&lgr->llc_conf_mutex);
+	down_write(&lgr->llc_conf_mutex);
 	smcr_link_down(link);
-	mutex_unlock(&lgr->llc_conf_mutex);
+	up_write(&lgr->llc_conf_mutex);
 }
 
 static int smc_vlan_by_tcpsk_walk(struct net_device *lower_dev,
@@ -2581,7 +2581,7 @@ static int smcr_buf_map_usable_links(struct smc_link_group *lgr,
 	int i, rc = 0;
 
 	/* protect against parallel link reconfiguration */
-	mutex_lock(&lgr->llc_conf_mutex);
+	down_write(&lgr->llc_conf_mutex);
 	for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
 		struct smc_link *lnk = &lgr->lnk[i];
 
@@ -2593,7 +2593,7 @@ static int smcr_buf_map_usable_links(struct smc_link_group *lgr,
 		}
 	}
 out:
-	mutex_unlock(&lgr->llc_conf_mutex);
+	up_write(&lgr->llc_conf_mutex);
 	return rc;
 }
 
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 8490676..559d330 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -346,7 +346,7 @@ struct smc_link_group {
 						/* queue for llc events */
 			spinlock_t		llc_event_q_lock;
 						/* protects llc_event_q */
-			struct mutex		llc_conf_mutex;
+			struct rw_semaphore	llc_conf_mutex;
 						/* protects lgr reconfig. */
 			struct work_struct	llc_add_link_work;
 			struct work_struct	llc_del_link_work;
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 965a3cc..d744937 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -1237,12 +1237,12 @@ static void smc_llc_process_cli_add_link(struct smc_link_group *lgr)
 
 	qentry = smc_llc_flow_qentry_clr(&lgr->llc_flow_lcl);
 
-	mutex_lock(&lgr->llc_conf_mutex);
+	down_write(&lgr->llc_conf_mutex);
 	if (smc_llc_is_local_add_link(&qentry->msg))
 		smc_llc_cli_add_link_invite(qentry->link, qentry);
 	else
 		smc_llc_cli_add_link(qentry->link, qentry);
-	mutex_unlock(&lgr->llc_conf_mutex);
+	up_write(&lgr->llc_conf_mutex);
 }
 
 static int smc_llc_active_link_count(struct smc_link_group *lgr)
@@ -1546,13 +1546,13 @@ static void smc_llc_process_srv_add_link(struct smc_link_group *lgr)
 
 	qentry = smc_llc_flow_qentry_clr(&lgr->llc_flow_lcl);
 
-	mutex_lock(&lgr->llc_conf_mutex);
+	down_write(&lgr->llc_conf_mutex);
 	rc = smc_llc_srv_add_link(link, qentry);
 	if (!rc && lgr->type == SMC_LGR_SYMMETRIC) {
 		/* delete any asymmetric link */
 		smc_llc_delete_asym_link(lgr);
 	}
-	mutex_unlock(&lgr->llc_conf_mutex);
+	up_write(&lgr->llc_conf_mutex);
 	kfree(qentry);
 }
 
@@ -1619,7 +1619,7 @@ static void smc_llc_process_cli_delete_link(struct smc_link_group *lgr)
 		smc_lgr_terminate_sched(lgr);
 		goto out;
 	}
-	mutex_lock(&lgr->llc_conf_mutex);
+	down_write(&lgr->llc_conf_mutex);
 	/* delete single link */
 	for (lnk_idx = 0; lnk_idx < SMC_LINKS_PER_LGR_MAX; lnk_idx++) {
 		if (lgr->lnk[lnk_idx].link_id != del_llc->link_num)
@@ -1655,7 +1655,7 @@ static void smc_llc_process_cli_delete_link(struct smc_link_group *lgr)
 		smc_lgr_terminate_sched(lgr);
 	}
 out_unlock:
-	mutex_unlock(&lgr->llc_conf_mutex);
+	up_write(&lgr->llc_conf_mutex);
 out:
 	kfree(qentry);
 }
@@ -1691,7 +1691,7 @@ static void smc_llc_process_srv_delete_link(struct smc_link_group *lgr)
 	int active_links;
 	int i;
 
-	mutex_lock(&lgr->llc_conf_mutex);
+	down_write(&lgr->llc_conf_mutex);
 	qentry = smc_llc_flow_qentry_clr(&lgr->llc_flow_lcl);
 	lnk = qentry->link;
 	del_llc = &qentry->msg.delete_link;
@@ -1748,7 +1748,7 @@ static void smc_llc_process_srv_delete_link(struct smc_link_group *lgr)
 		smc_llc_add_link_local(lnk);
 	}
 out:
-	mutex_unlock(&lgr->llc_conf_mutex);
+	up_write(&lgr->llc_conf_mutex);
 	kfree(qentry);
 }
 
@@ -2162,7 +2162,7 @@ void smc_llc_lgr_init(struct smc_link_group *lgr, struct smc_sock *smc)
 	spin_lock_init(&lgr->llc_flow_lock);
 	init_waitqueue_head(&lgr->llc_flow_waiter);
 	init_waitqueue_head(&lgr->llc_msg_waiter);
-	mutex_init(&lgr->llc_conf_mutex);
+	init_rwsem(&lgr->llc_conf_mutex);
 	lgr->llc_testlink_time = READ_ONCE(net->ipv4.sysctl_tcp_keepalive_time);
 }
 
-- 
1.8.3.1

