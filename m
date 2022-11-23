Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568C5636501
	for <lists+linux-s390@lfdr.de>; Wed, 23 Nov 2022 16:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbiKWP4N (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 23 Nov 2022 10:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238286AbiKWPzY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Nov 2022 10:55:24 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD0CC6572;
        Wed, 23 Nov 2022 07:55:06 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VVXZuKh_1669218902;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VVXZuKh_1669218902)
          by smtp.aliyun-inc.com;
          Wed, 23 Nov 2022 23:55:03 +0800
From:   "D.Wythe" <alibuda@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH net-next v5 09/10] net/smc: reduce unnecessary blocking in smcr_lgr_reg_rmbs()
Date:   Wed, 23 Nov 2022 23:54:49 +0800
Message-Id: <1669218890-115854-10-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669218890-115854-1-git-send-email-alibuda@linux.alibaba.com>
References: <1669218890-115854-1-git-send-email-alibuda@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: "D. Wythe" <alibuda@linux.alibaba.com>

Unlike smc_buf_create() and smcr_buf_unuse(), smcr_lgr_reg_rmbs() is
exclusive when assigned rmb_desc was not registered, although it can be
executed in parallel when assigned rmb_desc was registered already
and only performs read semtamics on it. Hence, we can not simply replace
it with read semaphore.

The idea here is that if the assigned rmb_desc was registered already,
use read semaphore to protect the critical section, once the assigned
rmb_desc was not registered, keep using keep write semaphore still
to keep its exclusivity.

Thanks to the reusable features of rmb_desc, which allows us to execute
in parallel in most cases.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 338ae3f..e76109e 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -512,11 +512,26 @@ static int smcr_lgr_reg_rmbs(struct smc_link *link,
 			     struct smc_buf_desc *rmb_desc)
 {
 	struct smc_link_group *lgr = link->lgr;
+	bool do_slow = false;
 	int i, rc = 0;
 
 	rc = smc_llc_flow_initiate(lgr, SMC_LLC_FLOW_RKEY);
 	if (rc)
 		return rc;
+
+	down_read(&lgr->llc_conf_mutex);
+	for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
+		if (!smc_link_active(&lgr->lnk[i]))
+			continue;
+		if (!rmb_desc->is_reg_mr[link->link_idx]) {
+			up_read(&lgr->llc_conf_mutex);
+			goto slow_path;
+		}
+	}
+	/* mr register already */
+	goto fast_path;
+slow_path:
+	do_slow = true;
 	/* protect against parallel smc_llc_cli_rkey_exchange() and
 	 * parallel smcr_link_reg_buf()
 	 */
@@ -528,7 +543,7 @@ static int smcr_lgr_reg_rmbs(struct smc_link *link,
 		if (rc)
 			goto out;
 	}
-
+fast_path:
 	/* exchange confirm_rkey msg with peer */
 	rc = smc_llc_do_confirm_rkey(link, rmb_desc);
 	if (rc) {
@@ -537,7 +552,7 @@ static int smcr_lgr_reg_rmbs(struct smc_link *link,
 	}
 	rmb_desc->is_conf_rkey = true;
 out:
-	up_write(&lgr->llc_conf_mutex);
+	do_slow ? up_write(&lgr->llc_conf_mutex) : up_read(&lgr->llc_conf_mutex);
 	smc_llc_flow_stop(lgr, &lgr->llc_flow_lcl);
 	return rc;
 }
-- 
1.8.3.1

