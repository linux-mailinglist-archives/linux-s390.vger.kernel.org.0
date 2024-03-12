Return-Path: <linux-s390+bounces-2507-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D42B6879629
	for <lists+linux-s390@lfdr.de>; Tue, 12 Mar 2024 15:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7101A1F22F70
	for <lists+linux-s390@lfdr.de>; Tue, 12 Mar 2024 14:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7417CF30;
	Tue, 12 Mar 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CMnrtjcJ"
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4F7C6D6;
	Tue, 12 Mar 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253689; cv=none; b=luhNo+TCdY8Vlm4iUjyITbAoBN0Kf/6m3VJvzXU6hNVZOmy+oSBs0TABQEBwchgSrUBsET4CKgEAJuQCVJUIXEhcaohI6n8xRsJn28hUALSIKHqbylSZixeynOyHmgUjak+Sd/xPh0bJc6+swWXHU18fcBTsJlq30Hs03SHFosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253689; c=relaxed/simple;
	bh=C1mw7oH08T3IaINFHe/PDEuNZ2af3//YPGBqcSjSzq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZK5blm5LJOeXMGJYmp66Y9FIqq6fBQWVhZJT1bv6DjehKkgZd9YHwSX/NELEmpD9fIiXbHAPbyFaGVRvuvGU4swXb0LIFfVhR+eiD8Lf/IFHN+GrmylQQ3HOI+ACyOH68unEoiH83L0g1Sk8hMNX3ojAbg6Khbg3uVzuegIQxTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CMnrtjcJ; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710253684; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=k2AEGh2dIEmA6LLggJT02tbo3NMTF78wsiLAFf4qX7g=;
	b=CMnrtjcJtkmkmJla4x3kvlOgbd/36haoBC3qjNQOP/JxUEYWf3bQxGKCanepuctLVAVPeBeYP4XI9UxUN6mtpKAJKB/DV2e8+Vs22kkqVYnp7xjKrArlaTbriTUBCuvP6bZPWi45l6PrMN1kyYgTSP/OYkfUfRPW1DjK/1vuMyI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2M60SF_1710253681;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W2M60SF_1710253681)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 22:28:03 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	twinkler@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 02/11] net/smc: decouple ism_client from SMC-D DMB registration
Date: Tue, 12 Mar 2024 22:27:34 +0800
Message-Id: <20240312142743.41406-3-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240312142743.41406-1-guwen@linux.alibaba.com>
References: <20240312142743.41406-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct 'ism_client' is specialized for s390 platform firmware ISM.
So replace it with 'void' to make SMCD DMB registration helper generic
for both Emulated-ISM and existing ISM.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 drivers/s390/net/ism_drv.c | 2 +-
 include/net/smc.h          | 4 ++--
 net/smc/smc_ism.c          | 7 ++-----
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 2c8e964425dc..9b2a52913e76 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -726,7 +726,7 @@ static int smcd_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
 }
 
 static int smcd_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
-			     struct ism_client *client)
+			     void *client)
 {
 	return ism_register_dmb(smcd->priv, (struct ism_dmb *)dmb, client);
 }
diff --git a/include/net/smc.h b/include/net/smc.h
index c9dcb30e3fd9..6273c3a8b24a 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -50,7 +50,6 @@ struct smcd_dmb {
 #define ISM_ERROR	0xFFFF
 
 struct smcd_dev;
-struct ism_client;
 
 struct smcd_gid {
 	u64	gid;
@@ -61,7 +60,7 @@ struct smcd_ops {
 	int (*query_remote_gid)(struct smcd_dev *dev, struct smcd_gid *rgid,
 				u32 vid_valid, u32 vid);
 	int (*register_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb,
-			    struct ism_client *client);
+			    void *client);
 	int (*unregister_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb);
 	int (*add_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
 	int (*del_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
@@ -81,6 +80,7 @@ struct smcd_ops {
 struct smcd_dev {
 	const struct smcd_ops *ops;
 	void *priv;
+	void *client;
 	struct list_head list;
 	spinlock_t lock;
 	struct smc_connection **conn;
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index b6eca4231913..26743a14cf27 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -222,7 +222,6 @@ int smc_ism_unregister_dmb(struct smcd_dev *smcd, struct smc_buf_desc *dmb_desc)
 int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
 			 struct smc_buf_desc *dmb_desc)
 {
-#if IS_ENABLED(CONFIG_ISM)
 	struct smcd_dmb dmb;
 	int rc;
 
@@ -231,7 +230,7 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
 	dmb.sba_idx = dmb_desc->sba_idx;
 	dmb.vlan_id = lgr->vlan_id;
 	dmb.rgid = lgr->peer_gid.gid;
-	rc = lgr->smcd->ops->register_dmb(lgr->smcd, &dmb, &smc_ism_client);
+	rc = lgr->smcd->ops->register_dmb(lgr->smcd, &dmb, lgr->smcd->client);
 	if (!rc) {
 		dmb_desc->sba_idx = dmb.sba_idx;
 		dmb_desc->token = dmb.dmb_tok;
@@ -240,9 +239,6 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
 		dmb_desc->len = dmb.dmb_len;
 	}
 	return rc;
-#else
-	return 0;
-#endif
 }
 
 static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
@@ -453,6 +449,7 @@ static void smcd_register_dev(struct ism_dev *ism)
 	if (!smcd)
 		return;
 	smcd->priv = ism;
+	smcd->client = &smc_ism_client;
 	ism_set_priv(ism, &smc_ism_client, smcd);
 	if (smc_pnetid_by_dev_port(&ism->pdev->dev, 0, smcd->pnetid))
 		smc_pnetid_by_table_smcd(smcd);
-- 
2.32.0.3.g01195cf9f


