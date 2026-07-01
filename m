Return-Path: <linux-s390+bounces-21416-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GJVcNc+rRGosywoAu9opvQ
	(envelope-from <linux-s390+bounces-21416-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 07:55:27 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5951E6EA04F
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 07:55:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=B4vj3mIC;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21416-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21416-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3834630655BF
	for <lists+linux-s390@lfdr.de>; Wed,  1 Jul 2026 05:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B7233C53F;
	Wed,  1 Jul 2026 05:53:46 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36DB32470A;
	Wed,  1 Jul 2026 05:53:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885226; cv=none; b=dL0cV5nHNnoehO6hUAby/IHxm+57KpJVj9epfyOOsoN0RLssouaIIZY+Fa8q6E80HOfu1kkKg5TIZjTeOFfOPXe8Blw1u2LyyuyrJCf03XCt24Vbz15KVn5Xo23iN8YUI4pXAyENUylcIz29OAl6ODnvNSOip+W04/yJQ6GXaj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885226; c=relaxed/simple;
	bh=hM3lAVLh0SUrkRUyWQwPuKLFlcNPsX/Jb65pYFjPFi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dy9Q9YWXhGzCB+QYy7dfu5sWr6KHT4nQwyFlVASSAVjVKRRAxyu3cHgoXr//fAnQfMNJArtWui03UjILJ6MazLKejCm16BNu5utAGZdo3Sumbf3jP3edvp9cBDCVhW6FE3Mfr2/h/hSJ1YOr7TG91ks+KP2dR/Bi+Y24uhiGtiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4vj3mIC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14681F000E9;
	Wed,  1 Jul 2026 05:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885225;
	bh=s22aUv759o7jOuYTf2EHjxStbcsNFUSunZW4b9jUGRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B4vj3mICqCBG5J6Qz1J6ZL/CdmqQL9ug/kU7JGVQcXS/8c208ZLND9bS6m7eybLO3
	 wRL6NLoxPnyItyX6BkBvidUfufZTBjxayOXlZzNA2azgv4I1eWOEZB2TaqCfWlcnQC
	 Lhg+GmezbOHy6Z7trc8XjTQcmIocngXXawx1bfAk7MzOh6wGLGd6dsiULHFTHsgGUi
	 mAHVzEmlUlVthSQ+H6gHh09sCL2AdPHYDtYkKMEzikE7XJmHgMtxeB0B3Yh2RRNl9u
	 b1gMBtydG6RDBRmQfYyjayYc7c0SSo+Et5Q5wau0fZfwIuCBXoBqwuXpFpy3E3b5vi
	 XcxBdGsO01mCg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	x86@kernel.org
Subject: [PATCH v7 22/22] swiotlb: remove unused SWIOTLB_FORCE flag
Date: Wed,  1 Jul 2026 11:19:26 +0530
Message-ID: <20260701054926.825925-23-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701054926.825925-1-aneesh.kumar@kernel.org>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21416-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:aneesh.kumar@kernel.org,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:jgg@ziepe.ca,m:smostafa@google.com,m:ptesarik@suse.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aneesh.kumar@kernel.org,linux-s390@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,sto.lore.kernel.org:server fail];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aneesh.kumar@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,samsung.com,resnulli.us,ziepe.ca,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,vger.kernel.org,linux.ibm.com,ellerman.id.au,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5951E6EA04F

SWIOTLB_FORCE has no remaining in-tree users. Forced bouncing is now
controlled through the swiotlb=force command line option via
swiotlb_force_bounce.

Remove the unused flag and simplify the force_bounce initialization.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 include/linux/swiotlb.h | 3 +--
 kernel/dma/swiotlb.c    | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index c3bf7ed6f7a6..9caca923c380 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -15,8 +15,7 @@ struct page;
 struct scatterlist;
 
 #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
-#define SWIOTLB_FORCE	(1 << 1) /* force bounce buffering */
-#define SWIOTLB_ANY	(1 << 2) /* allow any memory for the buffer */
+#define SWIOTLB_ANY	(1 << 1) /* allow any memory for the buffer */
 
 /*
  * Maximum allowable number of contiguous slabs to map,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8b7e47504304..897aba538c5b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -400,8 +400,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	if (swiotlb_force_disable)
 		return;
 
-	io_tlb_default_mem.force_bounce =
-		swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
+	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
 
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 	if (!remap)
-- 
2.43.0


