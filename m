Return-Path: <linux-s390+bounces-19966-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ItFAcTbD2ojQgYAu9opvQ
	(envelope-from <linux-s390+bounces-19966-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 22 May 2026 06:29:56 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF28F5AE9C6
	for <lists+linux-s390@lfdr.de>; Fri, 22 May 2026 06:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1B8D300EC74
	for <lists+linux-s390@lfdr.de>; Fri, 22 May 2026 04:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71B53101C8;
	Fri, 22 May 2026 04:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw7yRvJC"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DECD1C5F13;
	Fri, 22 May 2026 04:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779424166; cv=none; b=tw8tak21SCs1w7HXdfV8qqNYs205UYvKGxzEBdrnpjP1qSSKs5142MjJFoWE32WDm2CfcxIMVWq5bw11X6mnvcQSJscMgujJV/+enIcm9zhMtIJF+3DvPXMPCWQa186KriL/7phlMaTpf0KIzijsxSGwm7+cY4W30HqjgKZVnPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779424166; c=relaxed/simple;
	bh=lfeMjdmsBLLh45oGEJ6h5sXG7d5ZHOMmFRwifnU/B5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4ynJ9YZ5P2j7kNq94u1TNJ4m09UWh3tIaUe6T6+CpAvowe/Q4ky1tvtsmP8t8tJCIQSS/QUO2Jk/MAlACPFnNEGrOqOmE/Hs6e73NS5Pz9Q01OgX4pR33vobS6uw6064x+WYu9XReOQK3AKbkwbUsyISsexAe2pwC6A4bm6Ejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aw7yRvJC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179781F000E9;
	Fri, 22 May 2026 04:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779424165;
	bh=OPgHp7pxAl+G137GB0yt85dPbtiD0BHiuOT+gKio7vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aw7yRvJCooVrFTKlzMdtEgb1kRMsEFzLc/ODc9uR9zpQKFeUd4Ld1QGBCEOI/N1iA
	 RPG4Sc3hgUWzei8gOtyavODnhE6Uh6NhxNkpk4ENMph2sEBPBEP63Y/mHjkWK3fJ7w
	 UlF8ojLoXfpzJu5jMzb9VhuMURrcZOtM26glZfnIo5xPPGy6IJ+izSD9bRiIE/xtoR
	 JfsrvLFe+kSKcl+DglH3k97+xsmnIj1y3UnrSSL0Ham0uW85uyDHWPKky+sz74exGn
	 XQFzxNIvJ9mHHoU14gDbUzI7RbiF49w+xKONCmqJhWo9NX2zKdHzQ09KRGUzAkjw0y
	 IkaJcfK1qXq8g==
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
	x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH v5 04/20] dma-direct: use DMA_ATTR_CC_SHARED in alloc/free paths
Date: Fri, 22 May 2026 09:57:59 +0530
Message-ID: <20260522042815.370873-5-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522042815.370873-1-aneesh.kumar@kernel.org>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,samsung.com,resnulli.us,ziepe.ca,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,vger.kernel.org,linux.ibm.com,ellerman.id.au,gmail.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19966-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aneesh.kumar@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: EF28F5AE9C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Propagate force_dma_unencrypted() into DMA_ATTR_CC_SHARED in the
dma-direct allocation path and use the attribute to drive the related
decisions.

This updates dma_direct_alloc(), dma_direct_free(), and
dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.

Tested-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 53 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index fe8e83a36058..a224b1bed6f9 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -193,16 +193,31 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	bool remap = false, set_uncached = false;
-	bool mark_mem_decrypt = true;
+	bool mark_mem_decrypt = false;
 	struct page *page;
 	void *ret;
 
+	/*
+	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
+	 * attribute. The direct allocator uses it internally after it has
+	 * decided that the backing pages must be shared/decrypted, so the
+	 * rest of the allocation path can consistently select DMA addresses,
+	 * choose compatible pools and restore encryption on free.
+	 */
+	if (attrs & DMA_ATTR_CC_SHARED)
+		return NULL;
+
+	if (force_dma_unencrypted(dev)) {
+		attrs |= DMA_ATTR_CC_SHARED;
+		mark_mem_decrypt = true;
+	}
+
 	size = PAGE_ALIGN(size);
 	if (attrs & DMA_ATTR_NO_WARN)
 		gfp |= __GFP_NOWARN;
 
-	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
+	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_SHARED)) ==
+	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev))
 		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
 
 	if (!dev_is_dma_coherent(dev)) {
@@ -236,7 +251,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * Remapping or decrypting memory may block, allocate the memory from
 	 * the atomic pools instead if we aren't allowed block.
 	 */
-	if ((remap || force_dma_unencrypted(dev)) &&
+	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
 	    dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
@@ -312,12 +327,24 @@ void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
 	phys_addr_t phys;
-	bool mark_mem_encrypted = true;
+	bool mark_mem_encrypted = false;
 	struct io_tlb_pool *swiotlb_pool;
 	unsigned int page_order = get_order(size);
 
-	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
+	/* see dma_direct_alloc() for details */
+	WARN_ON(attrs & DMA_ATTR_CC_SHARED);
+
+	/*
+	 * if the device had requested for an unencrypted buffer,
+	 * convert it to encrypted on free
+	 */
+	if (force_dma_unencrypted(dev)) {
+		attrs |= DMA_ATTR_CC_SHARED;
+		mark_mem_encrypted = true;
+	}
+
+	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_SHARED)) ==
+	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev)) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
 		dma_free_contiguous(dev, cpu_addr, size);
 		return;
@@ -366,10 +393,14 @@ void dma_direct_free(struct device *dev, size_t size,
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
+	unsigned long attrs = 0;
 	struct page *page;
 	void *ret;
 
-	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
+	if (force_dma_unencrypted(dev))
+		attrs |= DMA_ATTR_CC_SHARED;
+
+	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	if (is_swiotlb_for_alloc(dev)) {
@@ -403,7 +434,11 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 	phys_addr_t phys;
 	void *vaddr = page_address(page);
 	struct io_tlb_pool *swiotlb_pool;
-	bool mark_mem_encrypted = true;
+	/*
+	 * if the device had requested for an unencrypted buffer,
+	 * convert it to encrypted on free
+	 */
+	bool mark_mem_encrypted = force_dma_unencrypted(dev);
 
 	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
-- 
2.43.0


