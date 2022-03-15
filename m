Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B694D9293
	for <lists+linux-s390@lfdr.de>; Tue, 15 Mar 2022 03:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344431AbiCOCbF (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 14 Mar 2022 22:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbiCOCbF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Mar 2022 22:31:05 -0400
X-Greylist: delayed 67 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Mar 2022 19:29:53 PDT
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468D947069
        for <linux-s390@vger.kernel.org>; Mon, 14 Mar 2022 19:29:52 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 15 Mar
 2022 10:28:43 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 15 Mar
 2022 10:28:42 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <freude@linux.ibm.com>, <hca@linux.ibm.com>, <gor@linux.ibm.com>,
        <agordeev@linux.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] s390: crypto: Use min() instead of doing it manually
Date:   Tue, 15 Mar 2022 10:28:41 +0800
Message-ID: <1647311321-26303-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Fix following coccicheck warning:
drivers/s390/crypto/zcrypt_ep11misc.c:1112:25-26: WARNING opportunity for min()

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/s390/crypto/zcrypt_ep11misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 9ce5a71..bb2a527 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -1109,7 +1109,7 @@ static int ep11_wrapkey(u16 card, u16 domain,
 	if (kb->head.type == TOKTYPE_NON_CCA &&
 	    kb->head.version == TOKVER_EP11_AES) {
 		has_header = true;
-		keysize = kb->head.len < keysize ? kb->head.len : keysize;
+		keysize = min(kb->head.len, keysize);
 	}
 
 	/* request cprb and payload */
-- 
2.7.4

