Return-Path: <linux-s390+bounces-363-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1283B807F4B
	for <lists+linux-s390@lfdr.de>; Thu,  7 Dec 2023 04:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB481F21603
	for <lists+linux-s390@lfdr.de>; Thu,  7 Dec 2023 03:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95253538C;
	Thu,  7 Dec 2023 03:50:17 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A880010C4;
	Wed,  6 Dec 2023 19:50:12 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vy-JsCQ_1701921008;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vy-JsCQ_1701921008)
          by smtp.aliyun-inc.com;
          Thu, 07 Dec 2023 11:50:10 +0800
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
	guangguan.wang@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 5/9] net/smc: define a reserved CHID range for virtual ISM devices
Date: Thu,  7 Dec 2023 11:49:50 +0800
Message-Id: <1701920994-73705-6-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701920994-73705-1-git-send-email-guwen@linux.alibaba.com>
References: <1701920994-73705-1-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

According to virtual ISM support feature defined by SMCv2.1, CHIDs in
the range 0xFF00 to 0xFFFF are reserved for use by virtual ISM devices.

And two helpers are introduced to distinguish virtual ISM devices from
the existing platform firmware ISM devices.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_ism.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 832b2f4..d1228a6 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -15,6 +15,8 @@
 
 #include "smc.h"
 
+#define SMC_VIRTUAL_ISM_CHID_MASK	0xFF00
+
 struct smcd_dev_list {	/* List of SMCD devices */
 	struct list_head list;
 	struct mutex mutex;	/* Protects list of devices */
@@ -56,4 +58,22 @@ static inline int smc_ism_write(struct smcd_dev *smcd, u64 dmb_tok,
 	return rc < 0 ? rc : 0;
 }
 
+static inline bool __smc_ism_is_virtual(u16 chid)
+{
+	/* CHIDs in range of 0xFF00 to 0xFFFF are reserved
+	 * for virtual ISM device.
+	 *
+	 * loopback-ism:	0xFFFF
+	 * virtio-ism:		0xFF00 ~ 0xFFFE
+	 */
+	return ((chid & 0xFF00) == 0xFF00);
+}
+
+static inline bool smc_ism_is_virtual(struct smcd_dev *smcd)
+{
+	u16 chid = smcd->ops->get_chid(smcd);
+
+	return __smc_ism_is_virtual(chid);
+}
+
 #endif
-- 
1.8.3.1


