Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3E06092E7
	for <lists+linux-s390@lfdr.de>; Sun, 23 Oct 2022 14:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiJWMoZ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 23 Oct 2022 08:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiJWMoV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 23 Oct 2022 08:44:21 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4980C5AC46;
        Sun, 23 Oct 2022 05:44:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VSpfJwS_1666529055;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VSpfJwS_1666529055)
          by smtp.aliyun-inc.com;
          Sun, 23 Oct 2022 20:44:15 +0800
From:   "D.Wythe" <alibuda@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH net-next v4 07/10] net/smc: reduce unnecessary blocking in smcr_lgr_reg_rmbs()
Date:   Sun, 23 Oct 2022 20:43:59 +0800
Message-Id: <1666529042-40828-8-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1666529042-40828-1-git-send-email-alibuda@linux.alibaba.com>
References: <1666529042-40828-1-git-send-email-alibuda@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
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
index 5c12cd7..3bac24e 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -510,11 +510,26 @@ static int smcr_lgr_reg_rmbs(struct smc_link *link,
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
@@ -526,7 +541,7 @@ static int smcr_lgr_reg_rmbs(struct smc_link *link,
 		if (rc)
 			goto out;
 	}
-
+fast_path:
 	/* exchange confirm_rkey msg with peer */
 	rc = smc_llc_do_confirm_rkey(link, rmb_desc);
 	if (rc) {
@@ -535,7 +550,7 @@ static int smcr_lgr_reg_rmbs(struct smc_link *link,
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

