Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2957ED940
	for <lists+linux-s390@lfdr.de>; Thu, 16 Nov 2023 03:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344454AbjKPCUr (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 15 Nov 2023 21:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343910AbjKPCUr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Nov 2023 21:20:47 -0500
Received: from njjs-sys-mailin01.njjs.baidu.com (mx314.baidu.com [180.101.52.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA9E08E;
        Wed, 15 Nov 2023 18:20:42 -0800 (PST)
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 38C9E7F00049;
        Thu, 16 Nov 2023 10:20:41 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     wenjia@linux.ibm.co, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, dust.li@linux.alibaba.com
Subject: [PATCH][net-next] net/smc: avoid atomic_set and smp_wmb in the tx path when possible
Date:   Thu, 16 Nov 2023 10:20:41 +0800
Message-Id: <20231116022041.51959-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

there is rare possibility that conn->tx_pushing is not 1, since
tx_pushing is just checked with 1, so move the setting tx_pushing
to 1 after atomic_dec_and_test() return false, to avoid atomic_set
and smp_wmb in tx path

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/smc/smc_tx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 3b0ff3b..72dbdee 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -667,8 +667,6 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
 		return 0;
 
 again:
-	atomic_set(&conn->tx_pushing, 1);
-	smp_wmb(); /* Make sure tx_pushing is 1 before real send */
 	rc = __smc_tx_sndbuf_nonempty(conn);
 
 	/* We need to check whether someone else have added some data into
@@ -677,8 +675,11 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
 	 * If so, we need to push again to prevent those data hang in the send
 	 * queue.
 	 */
-	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing)))
+	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing))) {
+		atomic_set(&conn->tx_pushing, 1);
+		smp_wmb(); /* Make sure tx_pushing is 1 before real send */
 		goto again;
+	}
 
 	return rc;
 }
-- 
2.9.4

