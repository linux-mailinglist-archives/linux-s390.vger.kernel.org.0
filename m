Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ED77115E5
	for <lists+linux-s390@lfdr.de>; Thu, 25 May 2023 20:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242725AbjEYSqf (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 25 May 2023 14:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242988AbjEYSps (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 25 May 2023 14:45:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9D01706;
        Thu, 25 May 2023 11:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 031966422B;
        Thu, 25 May 2023 18:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D57C433D2;
        Thu, 25 May 2023 18:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040128;
        bh=vR3gdLk2lwQFpq5DKF6oeHeq/xHoQob/o2RETl2k0ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TMtmGX41SOtjnW4SYD4bVoBcZvd3iE3c/0A4vXKoU7CyuWN99CWBmFTVnv9sDF+ns
         rZ9p6xZ9jscaZJv/6UTdETDCnbAXIMCGg2OMgrnsjlVtZLwRXTORY/98HAkK69rvM/
         tihN8KCNUdMQinn/AMIreui6fjKq8Slyv6OBcKckgGh5vb+K4/0JOeqHBfLAQWLQ4B
         GHJTrB5xsCFuA5xwrrBiefY3hP268Yggyak8HP5usYJ5vRDxyy6lXY9kgJODcKxXNN
         qgVFnw6XBZEuymUwmTg+LH9AiG/AE1bEEgIjHXNkmXvtHalPbXz5FYpwWpxYBYRDHc
         pkpvoUh3V2nCQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Holger Dengler <dengler@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, hca@linux.ibm.com,
        gor@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 20/31] s390/pkey: zeroize key blobs
Date:   Thu, 25 May 2023 14:40:51 -0400
Message-Id: <20230525184105.1909399-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184105.1909399-1-sashal@kernel.org>
References: <20230525184105.1909399-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Holger Dengler <dengler@linux.ibm.com>

[ Upstream commit 844cf829e5f33e00b279230470c8c93b58b8c16f ]

Key blobs for the IOCTLs PKEY_KBLOB2PROTK[23] may contain clear key
material. Zeroize the copies of these keys in kernel memory after
creating the protected key.

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/pkey_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index dd84995049b91..870e00effe439 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1271,6 +1271,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 			return PTR_ERR(kkey);
 		rc = pkey_keyblob2pkey(kkey, ktp.keylen, &ktp.protkey);
 		DEBUG_DBG("%s pkey_keyblob2pkey()=%d\n", __func__, rc);
+		memzero_explicit(kkey, ktp.keylen);
 		kfree(kkey);
 		if (rc)
 			break;
@@ -1404,6 +1405,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 					kkey, ktp.keylen, &ktp.protkey);
 		DEBUG_DBG("%s pkey_keyblob2pkey2()=%d\n", __func__, rc);
 		kfree(apqns);
+		memzero_explicit(kkey, ktp.keylen);
 		kfree(kkey);
 		if (rc)
 			break;
@@ -1530,6 +1532,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 					protkey, &protkeylen);
 		DEBUG_DBG("%s pkey_keyblob2pkey3()=%d\n", __func__, rc);
 		kfree(apqns);
+		memzero_explicit(kkey, ktp.keylen);
 		kfree(kkey);
 		if (rc) {
 			kfree(protkey);
-- 
2.39.2

