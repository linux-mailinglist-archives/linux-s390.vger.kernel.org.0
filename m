Return-Path: <linux-s390+bounces-434-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F6880BAEE
	for <lists+linux-s390@lfdr.de>; Sun, 10 Dec 2023 14:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D9EB20AED
	for <lists+linux-s390@lfdr.de>; Sun, 10 Dec 2023 13:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256C5C8E0;
	Sun, 10 Dec 2023 13:24:26 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D71910D;
	Sun, 10 Dec 2023 05:24:21 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vy8H5GJ_1702214657;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vy8H5GJ_1702214657)
          by smtp.aliyun-inc.com;
          Sun, 10 Dec 2023 21:24:19 +0800
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
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 01/13] net/smc: improve SMC-D device dump for virtual ISM
Date: Sun, 10 Dec 2023 21:24:02 +0800
Message-Id: <1702214654-32069-2-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702214654-32069-1-git-send-email-guwen@linux.alibaba.com>
References: <1702214654-32069-1-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The introduction of virtual ISM requires improvement of SMC-D device
dump. Software implemented non-PCI device (loopback-ism) should be
handled correctly and the CHID reserved for virtual ISM should be got
from smcd_ops interface instead of PCI information.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_ism.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index ac88de2..66bcfdd 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -252,12 +252,11 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
 	char smc_pnet[SMC_MAX_PNETID_LEN + 1];
 	struct smc_pci_dev smc_pci_dev;
 	struct nlattr *port_attrs;
+	struct device *device;
 	struct nlattr *attrs;
-	struct ism_dev *ism;
 	int use_cnt = 0;
 	void *nlh;
 
-	ism = smcd->priv;
 	nlh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
 			  &smc_gen_nl_family, NLM_F_MULTI,
 			  SMC_NETLINK_GET_DEV_SMCD);
@@ -272,7 +271,15 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
 	if (nla_put_u8(skb, SMC_NLA_DEV_IS_CRIT, use_cnt > 0))
 		goto errattr;
 	memset(&smc_pci_dev, 0, sizeof(smc_pci_dev));
-	smc_set_pci_values(to_pci_dev(ism->dev.parent), &smc_pci_dev);
+	device = smcd->ops->get_dev(smcd);
+	if (device->parent)
+		smc_set_pci_values(to_pci_dev(device->parent), &smc_pci_dev);
+	if (smc_ism_is_virtual(smcd)) {
+		smc_pci_dev.pci_pchid = smc_ism_get_chid(smcd);
+		if (!device->parent)
+			snprintf(smc_pci_dev.pci_id, sizeof(smc_pci_dev.pci_id),
+				 "%s", dev_name(device));
+	}
 	if (nla_put_u32(skb, SMC_NLA_DEV_PCI_FID, smc_pci_dev.pci_fid))
 		goto errattr;
 	if (nla_put_u16(skb, SMC_NLA_DEV_PCI_CHID, smc_pci_dev.pci_pchid))
-- 
1.8.3.1


