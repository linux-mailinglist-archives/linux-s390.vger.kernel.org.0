Return-Path: <linux-s390+bounces-247-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46D87FEDCB
	for <lists+linux-s390@lfdr.de>; Thu, 30 Nov 2023 12:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A098CB20E9D
	for <lists+linux-s390@lfdr.de>; Thu, 30 Nov 2023 11:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FB53C68B;
	Thu, 30 Nov 2023 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5E210F3;
	Thu, 30 Nov 2023 03:28:32 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VxROQ-o_1701343707;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VxROQ-o_1701343707)
          by smtp.aliyun-inc.com;
          Thu, 30 Nov 2023 19:28:29 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	wenjia@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kgraul@linux.ibm.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	raspl@linux.ibm.com,
	schnelle@linux.ibm.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/7] net/smc: introduce virtual ISM device support feature
Date: Thu, 30 Nov 2023 19:28:11 +0800
Message-Id: <1701343695-122657-4-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701343695-122657-1-git-send-email-guwen@linux.alibaba.com>
References: <1701343695-122657-1-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

This introduces virtual ISM device support feature to SMCv2.1 as the
first supplemental feature.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/af_smc.c | 2 ++
 net/smc/smc.h    | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index c61666e..766a1f1 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1520,6 +1520,7 @@ static int __smc_connect(struct smc_sock *smc)
 	ini->smcr_version = SMC_V1 | SMC_V2;
 	ini->smc_type_v1 = SMC_TYPE_B;
 	ini->smc_type_v2 = SMC_TYPE_B;
+	ini->feature_mask = SMC_FEATURE_MASK;
 
 	/* get vlan id from IP device */
 	if (smc_vlan_by_tcpsk(smc->clcsock, ini)) {
@@ -1985,6 +1986,7 @@ static int smc_listen_v2_check(struct smc_sock *new_smc,
 	ini->smc_type_v2 = pclc->hdr.typev2;
 	ini->smcd_version = smcd_indicated(ini->smc_type_v1) ? SMC_V1 : 0;
 	ini->smcr_version = smcr_indicated(ini->smc_type_v1) ? SMC_V1 : 0;
+	ini->feature_mask = SMC_FEATURE_MASK;
 	if (pclc->hdr.version > SMC_V1) {
 		if (smcd_indicated(ini->smc_type_v2))
 			ini->smcd_version |= SMC_V2;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 95f56c7..0dc722b 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -58,9 +58,12 @@ enum smc_state {		/* possible states of an SMC socket */
 	SMC_PROCESSABORT	= 27,
 };
 
-#define SMC_FEATURE_MASK	0	/* bitmask of
-					 * supported supplemental features
-					 */
+enum smc_supplemental_features {
+	SMC_SPF_VIRT_ISM_DEV	= 0,
+};
+
+#define SMC_FEATURE_MASK \
+	(BIT(SMC_SPF_VIRT_ISM_DEV))
 
 struct smc_link_group;
 
-- 
1.8.3.1


