Return-Path: <linux-s390+bounces-3327-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 278348A4025
	for <lists+linux-s390@lfdr.de>; Sun, 14 Apr 2024 06:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86361F21707
	for <lists+linux-s390@lfdr.de>; Sun, 14 Apr 2024 04:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3695B18C3D;
	Sun, 14 Apr 2024 04:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qPTs0jpu"
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FB72A1D4;
	Sun, 14 Apr 2024 04:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713067415; cv=none; b=A9p5GgNFEalHqHQw7SYr2V5qZFVDREym+iMFr19v/MZmHdS1JAZnmzWgT4V8DwJDcGvtxv+2KO8BInfIpgt616U+IyRJWaBrWr5tn8MEfIj29KdCgeD6xVYd9VdFxS+WQSJIrX00jQmszt8X8/NmCG3KjG/GMZvsqwRTDfYwAFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713067415; c=relaxed/simple;
	bh=ml8XBd4t/EjacVpGSk9tropHTdaruhEtaMNNWhn9OjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G+Ibq7ErFem+i/Z0HhpnXPBCYjSZaied85gr9oy6+aFE0NaPxqpAQ4sIE+mAcZIQRZEkO8fNmS0G0QAy9G9Tc+Wdn56dQV8WPqLL3LWa8UlQoAy/B8h6wkMzYh9a23faUJnS/PMDlUIxY5rY40FwO8LoXEyRqfOWz2pZt7xdngE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qPTs0jpu; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713067404; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TRMkEBmhvkR4yW3s8bf6OAtkd66aTfemcZ+2Tsdt1r4=;
	b=qPTs0jpuHvTUCDPEnojm+g1hwNT+CRIcFcTSB0lTbgza43fmT/21jEcPkqc7ECQSsfdurpBJah5eybpQBjK9KIwtYiYveLz/HohD9gFV2xYM5Rnnb9KYbKKib8tH1MERW5QQYs2EmP5HAPtWQocTwg42K+PDAY/DFQxr3kifAJg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W4RqRI2_1713067402;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W4RqRI2_1713067402)
          by smtp.aliyun-inc.com;
          Sun, 14 Apr 2024 12:03:24 +0800
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
Subject: [PATCH net-next v6 08/11] net/smc: add operations to merge sndbuf with peer DMB
Date: Sun, 14 Apr 2024 12:03:01 +0800
Message-Id: <20240414040304.54255-9-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240414040304.54255-1-guwen@linux.alibaba.com>
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some scenarios using Emulated-ISM device, sndbuf can share the same
physical memory region with peer DMB to avoid data copy from one side
to the other. In such case the sndbuf is only a descriptor that
describes the shared memory and does not actually occupy memory, it's
more like a ghost buffer.

      +----------+                     +----------+
      | socket A |                     | socket B |
      +----------+                     +----------+
            |                               |
       +--------+                       +--------+
       | sndbuf |                       |  DMB   |
       |  desc  |                       |  desc  |
       +--------+                       +--------+
            |                               |
            |                          +----v-----+
            +-------------------------->  memory  |
                                       +----------+

So here introduces three new SMC-D device operations to check if this
feature is supported by device, and to {attach|detach} ghost sndbuf to
peer DMB. For now only loopback-ism supports this.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 include/net/smc.h |  3 +++
 net/smc/smc_ism.c | 40 ++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_ism.h |  4 ++++
 3 files changed, 47 insertions(+)

diff --git a/include/net/smc.h b/include/net/smc.h
index 33b753115e43..db84e4e35080 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -74,6 +74,9 @@ struct smcd_ops {
 	int (*reset_vlan_required)(struct smcd_dev *dev);
 	int (*signal_event)(struct smcd_dev *dev, struct smcd_gid *rgid,
 			    u32 trigger_irq, u32 event_code, u64 info);
+	int (*support_dmb_nocopy)(struct smcd_dev *dev);
+	int (*attach_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb);
+	int (*detach_dmb)(struct smcd_dev *dev, u64 token);
 };
 
 struct smcd_dev {
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 6bed0a61b746..84f98e18c7db 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -250,6 +250,46 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
 	return rc;
 }
 
+bool smc_ism_support_dmb_nocopy(struct smcd_dev *smcd)
+{
+	/* for now only loopback-ism supports
+	 * merging sndbuf with peer DMB to avoid
+	 * data copies between them.
+	 */
+	return (smcd->ops->support_dmb_nocopy &&
+		smcd->ops->support_dmb_nocopy(smcd));
+}
+
+int smc_ism_attach_dmb(struct smcd_dev *dev, u64 token,
+		       struct smc_buf_desc *dmb_desc)
+{
+	struct smcd_dmb dmb;
+	int rc = 0;
+
+	if (!dev->ops->attach_dmb)
+		return -EINVAL;
+
+	memset(&dmb, 0, sizeof(dmb));
+	dmb.dmb_tok = token;
+	rc = dev->ops->attach_dmb(dev, &dmb);
+	if (!rc) {
+		dmb_desc->sba_idx = dmb.sba_idx;
+		dmb_desc->token = dmb.dmb_tok;
+		dmb_desc->cpu_addr = dmb.cpu_addr;
+		dmb_desc->dma_addr = dmb.dma_addr;
+		dmb_desc->len = dmb.dmb_len;
+	}
+	return rc;
+}
+
+int smc_ism_detach_dmb(struct smcd_dev *dev, u64 token)
+{
+	if (!dev->ops->detach_dmb)
+		return -EINVAL;
+
+	return dev->ops->detach_dmb(dev, token);
+}
+
 static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
 				  struct sk_buff *skb,
 				  struct netlink_callback *cb)
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index e6f57e5e1ef9..6763133dd8d0 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -48,6 +48,10 @@ int smc_ism_put_vlan(struct smcd_dev *dev, unsigned short vlan_id);
 int smc_ism_register_dmb(struct smc_link_group *lgr, int buf_size,
 			 struct smc_buf_desc *dmb_desc);
 int smc_ism_unregister_dmb(struct smcd_dev *dev, struct smc_buf_desc *dmb_desc);
+bool smc_ism_support_dmb_nocopy(struct smcd_dev *smcd);
+int smc_ism_attach_dmb(struct smcd_dev *dev, u64 token,
+		       struct smc_buf_desc *dmb_desc);
+int smc_ism_detach_dmb(struct smcd_dev *dev, u64 token);
 int smc_ism_signal_shutdown(struct smc_link_group *lgr);
 void smc_ism_get_system_eid(u8 **eid);
 u16 smc_ism_get_chid(struct smcd_dev *dev);
-- 
2.32.0.3.g01195cf9f


