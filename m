Return-Path: <linux-s390+bounces-20479-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hftfKO86IWr+BQEAu9opvQ
	(envelope-from <linux-s390+bounces-20479-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 10:44:31 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5721D63E195
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 10:44:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nirNpdm6;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20479-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-20479-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2442F3088BD9
	for <lists+linux-s390@lfdr.de>; Thu,  4 Jun 2026 08:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B353F0AA9;
	Thu,  4 Jun 2026 08:41:01 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF153E8333;
	Thu,  4 Jun 2026 08:40:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562460; cv=none; b=T2GBW00ZnbaB3/X1HVIkN8UF9UKv+fVHU1tV4QMzkjbKDiqCOCrMdeXafxHFc7Y9Ns7dATJ0DnCNwY29s3YE0KSXdsAEedKOZTxlimtd+s69p629HQDHPDFnx42jF3m/pUEHHWB5GP+sCYx3pR6SY/zd44h/T2ogjzxAmlx54zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562460; c=relaxed/simple;
	bh=gCQiDtQ3gUOroN6tQaB4mcoDR/CnhellP5R1eFcJOTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtYh91L8pHFP20Q2B5G1BJFxEZpe1O6w+/ESLKjEics+n5eJ2qZuAnXFpwgBEAjuCFcX5cod5PsGeIcABobBccA9d4BA7mWgushSdxz+TGXkhBwCOqrvk3KNIRgjlqDfkQy9T3HYMjFR2iNiwcHc9egF7gyuhPRmlTYZ7IHPhCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nirNpdm6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C217E1F00899;
	Thu,  4 Jun 2026 08:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562450;
	bh=UoA06AF2jFoOpEty6iEpghCPkBEXBL7lN2LetCBuQvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nirNpdm61GhI9uD/QaPnGzj3UXVrWlFQ7rWYOt5n1qZeeoMvcXQKN0YuKdV6+fuUH
	 NpXVYpyJS1Mr4ALgQKc/Dj07O0z9tbRA1LpbpoZwIOO0WXIOelpMyXTGf1l2UXDAra
	 G+0dW7jmRmVlfzdF3HKV93gwA9cncAciPg/VH0ClInhTHzShDghVvBvemEhKquhTBy
	 4pgaTRiZs3nXLifjc6BTW5tPhZxMqKlMf7AUPMuCP5HCaeCDaP3g3bskKPXpZGYt8p
	 iauNVO0jGJanSIGl1pz50kw9nbS+p0dhFut2dez9+wYClgOQZp/IvjAD6so6SEwm8n
	 b1t2Mm9uYwNkA==
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
	Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v6 04/20] dma-pool: track decrypted atomic pools and select them via attrs
Date: Thu,  4 Jun 2026 14:09:43 +0530
Message-ID: <20260604083959.1265923-5-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,samsung.com,resnulli.us,ziepe.ca,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,vger.kernel.org,linux.ibm.com,ellerman.id.au,gmail.com,nvidia.com,outlook.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20479-lists,linux-s390=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:aneesh.kumar@kernel.org,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:jgg@ziepe.ca,m:smostafa@google.com,m:ptesarik@suse.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,m:jiri@nvidia.com,m:mhklinux@outlook.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[aneesh.kumar@kernel.org,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aneesh.kumar@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,vger.kernel.org:from_smtp,outlook.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5721D63E195

Teach the atomic DMA pool code to distinguish between encrypted and
unencrypted pools, and make pool allocation select the matching pool based
on DMA attributes.

Introduce a dma_gen_pool wrapper that records whether a pool is
unencrypted, initialize that state when the atomic pools are created, and
use it when expanding and resizing the pools. Update dma_alloc_from_pool()
to take attrs and skip pools whose encrypted state does not match
DMA_ATTR_CC_SHARED. Update dma_free_from_pool() accordingly.

Also pass DMA_ATTR_CC_SHARED from the swiotlb atomic allocation path so
decrypted swiotlb allocations are taken from the correct atomic pool.

Tested-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/dma-iommu.c   |   2 +-
 include/linux/dma-map-ops.h |   2 +-
 kernel/dma/direct.c         |  11 ++-
 kernel/dma/pool.c           | 167 +++++++++++++++++++++++-------------
 kernel/dma/swiotlb.c        |   7 +-
 5 files changed, 123 insertions(+), 66 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 54d96e847f16..c2595bee3d41 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1673,7 +1673,7 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    !gfpflags_allow_blocking(gfp) && !coherent)
 		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
-					       gfp, NULL);
+					   gfp, attrs, NULL);
 	else
 		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
 	if (!cpu_addr)
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 6a1832a73cad..696b2c3a2305 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -212,7 +212,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size, pgprot_t prot,
 void dma_common_free_remap(void *cpu_addr, size_t size);
 
 struct page *dma_alloc_from_pool(struct device *dev, size_t size,
-		void **cpu_addr, gfp_t flags,
+		void **cpu_addr, gfp_t flags, unsigned long attrs,
 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
 bool dma_free_from_pool(struct device *dev, void *start, size_t size);
 
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 90dc5057a0c0..681f16a984ab 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -154,7 +154,7 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
 }
 
 static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp)
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	struct page *page;
 	u64 phys_limit;
@@ -164,7 +164,8 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 		return NULL;
 
 	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
-	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
+	page = dma_alloc_from_pool(dev, size, &ret, gfp, attrs,
+				   dma_coherent_ok);
 	if (!page)
 		return NULL;
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
@@ -253,7 +254,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 */
 	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
 	    dma_direct_use_pool(dev, gfp))
-		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
+		return dma_direct_alloc_from_pool(dev, size, dma_handle,
+						  gfp, attrs);
 
 	if (is_swiotlb_for_alloc(dev)) {
 		page = dma_direct_alloc_swiotlb(dev, size);
@@ -401,7 +403,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		attrs |= DMA_ATTR_CC_SHARED;
 
 	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
-		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
+		return dma_direct_alloc_from_pool(dev, size, dma_handle,
+						  gfp, attrs);
 
 	if (is_swiotlb_for_alloc(dev)) {
 		page = dma_direct_alloc_swiotlb(dev, size);
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 2b2fbb709242..be78474a6c49 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -12,12 +12,18 @@
 #include <linux/set_memory.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/cc_platform.h>
 
-static struct gen_pool *atomic_pool_dma __ro_after_init;
+struct dma_gen_pool {
+	bool unencrypted;
+	struct gen_pool *pool;
+};
+
+static struct dma_gen_pool atomic_pool_dma __ro_after_init;
 static unsigned long pool_size_dma;
-static struct gen_pool *atomic_pool_dma32 __ro_after_init;
+static struct dma_gen_pool atomic_pool_dma32 __ro_after_init;
 static unsigned long pool_size_dma32;
-static struct gen_pool *atomic_pool_kernel __ro_after_init;
+static struct dma_gen_pool atomic_pool_kernel __ro_after_init;
 static unsigned long pool_size_kernel;
 
 /* Size can be defined by the coherent_pool command line */
@@ -76,11 +82,12 @@ static bool cma_in_zone(gfp_t gfp)
 	return true;
 }
 
-static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
+static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 			      gfp_t gfp)
 {
 	unsigned int order;
 	struct page *page = NULL;
+	bool leak_pages = false;
 	void *addr;
 	int ret = -ENOMEM;
 
@@ -113,12 +120,17 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
 	 * shrink so no re-encryption occurs in dma_direct_free().
 	 */
-	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
-				   1 << order);
-	if (ret)
-		goto remove_mapping;
-	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
-				pool_size, NUMA_NO_NODE);
+	if (dma_pool->unencrypted) {
+		ret = set_memory_decrypted((unsigned long)page_to_virt(page),
+					   1 << order);
+		if (ret) {
+			leak_pages = true;
+			goto remove_mapping;
+		}
+	}
+
+	ret = gen_pool_add_virt(dma_pool->pool, (unsigned long)addr,
+				page_to_phys(page), pool_size, NUMA_NO_NODE);
 	if (ret)
 		goto encrypt_mapping;
 
@@ -126,62 +138,67 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	return 0;
 
 encrypt_mapping:
-	ret = set_memory_encrypted((unsigned long)page_to_virt(page),
-				   1 << order);
-	if (WARN_ON_ONCE(ret)) {
-		/* Decrypt succeeded but encrypt failed, purposely leak */
-		goto out;
-	}
+	if (dma_pool->unencrypted &&
+	    set_memory_encrypted((unsigned long)page_to_virt(page), 1 << order))
+		leak_pages = true;
+
 remove_mapping:
 #ifdef CONFIG_DMA_DIRECT_REMAP
 	dma_common_free_remap(addr, pool_size);
 free_page:
-	__free_pages(page, order);
+	if (!leak_pages)
+		__free_pages(page, order);
 #endif
 out:
 	return ret;
 }
 
-static void atomic_pool_resize(struct gen_pool *pool, gfp_t gfp)
+static void atomic_pool_resize(struct dma_gen_pool *dma_pool, gfp_t gfp)
 {
-	if (pool && gen_pool_avail(pool) < atomic_pool_size)
-		atomic_pool_expand(pool, gen_pool_size(pool), gfp);
+	if (dma_pool->pool && gen_pool_avail(dma_pool->pool) < atomic_pool_size)
+		atomic_pool_expand(dma_pool, gen_pool_size(dma_pool->pool), gfp);
 }
 
 static void atomic_pool_work_fn(struct work_struct *work)
 {
 	if (IS_ENABLED(CONFIG_ZONE_DMA))
-		atomic_pool_resize(atomic_pool_dma,
+		atomic_pool_resize(&atomic_pool_dma,
 				   GFP_KERNEL | GFP_DMA);
 	if (IS_ENABLED(CONFIG_ZONE_DMA32))
-		atomic_pool_resize(atomic_pool_dma32,
+		atomic_pool_resize(&atomic_pool_dma32,
 				   GFP_KERNEL | GFP_DMA32);
-	atomic_pool_resize(atomic_pool_kernel, GFP_KERNEL);
+	atomic_pool_resize(&atomic_pool_kernel, GFP_KERNEL);
 }
 
-static __init struct gen_pool *__dma_atomic_pool_init(size_t pool_size,
-						      gfp_t gfp)
+static __init struct dma_gen_pool *__dma_atomic_pool_init(struct dma_gen_pool *dma_pool,
+		size_t pool_size, gfp_t gfp)
 {
-	struct gen_pool *pool;
 	int ret;
 
-	pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
-	if (!pool)
+	dma_pool->pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
+	if (!dma_pool->pool)
 		return NULL;
 
-	gen_pool_set_algo(pool, gen_pool_first_fit_order_align, NULL);
+	gen_pool_set_algo(dma_pool->pool, gen_pool_first_fit_order_align, NULL);
+
+	/* if platform is using memory encryption atomic pools are by default decrypted. */
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		dma_pool->unencrypted = true;
+	else
+		dma_pool->unencrypted = false;
 
-	ret = atomic_pool_expand(pool, pool_size, gfp);
+	ret = atomic_pool_expand(dma_pool, pool_size, gfp);
 	if (ret) {
-		gen_pool_destroy(pool);
+		gen_pool_destroy(dma_pool->pool);
+		dma_pool->pool = NULL;
 		pr_err("DMA: failed to allocate %zu KiB %pGg pool for atomic allocation\n",
 		       pool_size >> 10, &gfp);
 		return NULL;
 	}
 
 	pr_info("DMA: preallocated %zu KiB %pGg pool for atomic allocations\n",
-		gen_pool_size(pool) >> 10, &gfp);
-	return pool;
+		gen_pool_size(dma_pool->pool) >> 10, &gfp);
+	return dma_pool;
 }
 
 #ifdef CONFIG_ZONE_DMA32
@@ -207,21 +224,22 @@ static int __init dma_atomic_pool_init(void)
 
 	/* All memory might be in the DMA zone(s) to begin with */
 	if (has_managed_zone(ZONE_NORMAL)) {
-		atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
-						    GFP_KERNEL);
-		if (!atomic_pool_kernel)
+		__dma_atomic_pool_init(&atomic_pool_kernel, atomic_pool_size, GFP_KERNEL);
+		if (!atomic_pool_kernel.pool)
 			ret = -ENOMEM;
 	}
+
 	if (has_managed_dma()) {
-		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
-						GFP_KERNEL | GFP_DMA);
-		if (!atomic_pool_dma)
+		__dma_atomic_pool_init(&atomic_pool_dma, atomic_pool_size,
+				       GFP_KERNEL | GFP_DMA);
+		if (!atomic_pool_dma.pool)
 			ret = -ENOMEM;
 	}
+
 	if (has_managed_dma32) {
-		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
-						GFP_KERNEL | GFP_DMA32);
-		if (!atomic_pool_dma32)
+		__dma_atomic_pool_init(&atomic_pool_dma32, atomic_pool_size,
+				       GFP_KERNEL | GFP_DMA32);
+		if (!atomic_pool_dma32.pool)
 			ret = -ENOMEM;
 	}
 
@@ -230,19 +248,44 @@ static int __init dma_atomic_pool_init(void)
 }
 postcore_initcall(dma_atomic_pool_init);
 
-static inline struct gen_pool *dma_guess_pool(struct gen_pool *prev, gfp_t gfp)
+static inline struct dma_gen_pool *__dma_guess_pool(struct dma_gen_pool *first,
+		struct dma_gen_pool *second, struct dma_gen_pool *third)
 {
-	if (prev == NULL) {
+	if (first->pool)
+		return first;
+	if (second && second->pool)
+		return second;
+	if (third && third->pool)
+		return third;
+	return NULL;
+}
+
+static inline struct dma_gen_pool *dma_guess_pool(struct dma_gen_pool *prev,
+		gfp_t gfp)
+{
+	if (!prev) {
 		if (gfp & GFP_DMA)
-			return atomic_pool_dma ?: atomic_pool_dma32 ?: atomic_pool_kernel;
+			return __dma_guess_pool(&atomic_pool_dma,
+						&atomic_pool_dma32,
+						&atomic_pool_kernel);
+
 		if (gfp & GFP_DMA32)
-			return atomic_pool_dma32 ?: atomic_pool_dma ?: atomic_pool_kernel;
-		return atomic_pool_kernel ?: atomic_pool_dma32 ?: atomic_pool_dma;
+			return __dma_guess_pool(&atomic_pool_dma32,
+						&atomic_pool_dma,
+						&atomic_pool_kernel);
+
+		return __dma_guess_pool(&atomic_pool_kernel,
+					&atomic_pool_dma32,
+					&atomic_pool_dma);
 	}
-	if (prev == atomic_pool_kernel)
-		return atomic_pool_dma32 ? atomic_pool_dma32 : atomic_pool_dma;
-	if (prev == atomic_pool_dma32)
-		return atomic_pool_dma;
+
+	if (prev == &atomic_pool_kernel)
+		return __dma_guess_pool(&atomic_pool_dma32,
+					&atomic_pool_dma, NULL);
+
+	if (prev == &atomic_pool_dma32)
+		return __dma_guess_pool(&atomic_pool_dma, NULL, NULL);
+
 	return NULL;
 }
 
@@ -272,16 +315,20 @@ static struct page *__dma_alloc_from_pool(struct device *dev, size_t size,
 }
 
 struct page *dma_alloc_from_pool(struct device *dev, size_t size,
-		void **cpu_addr, gfp_t gfp,
+		void **cpu_addr, gfp_t gfp, unsigned long attrs,
 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
 {
-	struct gen_pool *pool = NULL;
+	struct dma_gen_pool *dma_pool = NULL;
 	struct page *page;
 	bool pool_found = false;
 
-	while ((pool = dma_guess_pool(pool, gfp))) {
+	while ((dma_pool = dma_guess_pool(dma_pool, gfp))) {
+
+		if (dma_pool->unencrypted != !!(attrs & DMA_ATTR_CC_SHARED))
+			continue;
+
 		pool_found = true;
-		page = __dma_alloc_from_pool(dev, size, pool, cpu_addr,
+		page = __dma_alloc_from_pool(dev, size, dma_pool->pool, cpu_addr,
 					     phys_addr_ok);
 		if (page)
 			return page;
@@ -296,12 +343,14 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
 
 bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 {
-	struct gen_pool *pool = NULL;
+	struct dma_gen_pool *dma_pool = NULL;
+
+	while ((dma_pool = dma_guess_pool(dma_pool, 0))) {
 
-	while ((pool = dma_guess_pool(pool, 0))) {
-		if (!gen_pool_has_addr(pool, (unsigned long)start, size))
+		if (!gen_pool_has_addr(dma_pool->pool, (unsigned long)start, size))
 			continue;
-		gen_pool_free(pool, (unsigned long)start, size);
+
+		gen_pool_free(dma_pool->pool, (unsigned long)start, size);
 		return true;
 	}
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index ac03a6856c2e..be4d418d92ac 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -612,6 +612,7 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
 		u64 phys_limit, gfp_t gfp)
 {
 	struct page *page;
+	unsigned long attrs = 0;
 
 	/*
 	 * Allocate from the atomic pools if memory is encrypted and
@@ -623,8 +624,12 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
 		if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
 			return NULL;
 
+		/* swiotlb considered decrypted by default */
+		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+			attrs = DMA_ATTR_CC_SHARED;
+
 		return dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
-					   dma_coherent_ok);
+					   attrs, dma_coherent_ok);
 	}
 
 	gfp &= ~GFP_ZONEMASK;
-- 
2.43.0


