Return-Path: <linux-s390+bounces-21398-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8xeaLyarRGruygoAu9opvQ
	(envelope-from <linux-s390+bounces-21398-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 07:52:38 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEF86E9FA6
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 07:52:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YDmtGiFg;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21398-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21398-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 178D3303CA58
	for <lists+linux-s390@lfdr.de>; Wed,  1 Jul 2026 05:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F33370AE5;
	Wed,  1 Jul 2026 05:50:29 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D000248873;
	Wed,  1 Jul 2026 05:50:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885029; cv=none; b=Jx1RLIZIBCIcWfHp1bgAtQhP6IK3F8ePtzfnXfmb9kq0kXs+MSX2dC9Wg0vMom4BycZ/Er9o5KooctGSHnJHVBXu/y0W0ITHHbScyQa6rUyDNDjA2ccSYfY7u6RMWZ/V7UnwnKBwXN5ukXuddl3/OYa97BvGVmIUhP5RcVwOqhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885029; c=relaxed/simple;
	bh=X/IJalMGGaBJCayVYUvb+I0lXrJ5dlVSSroBOo2VoIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WydCeBkulf2GfGF8TiCbZRbjYCDC3+lO5Sd04uhBhqIHb0e8nbsqVlCKx4jMaJMElRW5NT8IemzOeHOXTyA1loWz/VwYNap0O8yulb/LNzWKzkgkRDYEo7ObPKlcXgJDDn1ZoB81hLI8YcLncHnn4hulh4I+y9+TI07NTq1VuF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDmtGiFg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCA41F00A3D;
	Wed,  1 Jul 2026 05:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885028;
	bh=uK0F/gWRwNVcExGs/aIxWo/TgoVvALCb4U1mwxZD1ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YDmtGiFgLXr0WvkfFZn8uSPkzcA16GAjnn54jLRiDJpcMm62Wz2J7FHoT9OU7pfGo
	 aDW41YlDlTKR8+ZZGuRsC1//sxp2nz1/HVYRRxTr2/mn55kX2HHdueW/2aPCQw73dd
	 uknDJVv5tDQVWK1jy4yvq0OSU3mljNcp2JqFC1vzWzFXgwTFHO1Cnc7rdv3suftGeb
	 56Bhk8NUZbwqfuSpui5K4uxQd3Gi3Vc4KSnZeNE0H+YnKtLxxlCYRmOKhBFrG2onhk
	 IdaiHcoPjuKXuagfPUmyJrGnMq2HdCTamC6HjH5u/F9/oj9pV/jtblD+gsXk3cfGLE
	 RsUhRYNWtvoVA==
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
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v7 04/22] dma: free atomic pool pages by physical address
Date: Wed,  1 Jul 2026 11:19:08 +0530
Message-ID: <20260701054926.825925-5-aneesh.kumar@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21398-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:aneesh.kumar@kernel.org,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:jgg@ziepe.ca,m:smostafa@google.com,m:ptesarik@suse.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aneesh.kumar@kernel.org,linux-s390@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,samsung.com,resnulli.us,ziepe.ca,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,vger.kernel.org,linux.ibm.com,ellerman.id.au,gmail.com,outlook.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aneesh.kumar@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AEF86E9FA6

dma_direct_alloc_pages() may satisfy atomic allocations from the coherent
atomic pools. The pool allocation is keyed by the virtual address stored in
the gen_pool, but the pages API returns only the backing struct page.

On architectures with CONFIG_DMA_DIRECT_REMAP, atomic pool chunks are added
to the gen_pool using their remapped virtual address.
dma_direct_free_pages() reconstructs a linear-map address with
page_address(page) and passes that to dma_free_from_pool(). That address
does not match the gen_pool virtual range, so the pool lookup can fail and
the code can fall through to freeing a pool-owned page through the normal
page allocator path.

Add a page-based pool free helper that looks up the owning pool chunk by
physical address, translates it back to the gen_pool virtual address, and
frees that address to the pool. Use it from dma_direct_free_pages() while
keeping the existing virtual-address helper for coherent allocation frees.

Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 include/linux/dma-map-ops.h |  1 +
 kernel/dma/direct.c         |  4 +--
 kernel/dma/pool.c           | 54 +++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index bcb5b5428aea..137e015c1750 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -215,6 +215,7 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
 		void **cpu_addr, gfp_t flags,
 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
 bool dma_free_from_pool(struct device *dev, void *start, size_t size);
+bool dma_free_from_pool_page(struct device *dev, struct page *page, size_t size);
 
 int dma_direct_set_offset(struct device *dev, phys_addr_t cpu_start,
 		dma_addr_t dma_start, u64 size);
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index b4cb2c03e5d7..17f1e097499e 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -381,9 +381,9 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 {
 	void *vaddr = page_address(page);
 
-	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
+	/* If page is not from an atomic pool, dma_free_from_pool_page() fails */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
-	    dma_free_from_pool(dev, vaddr, size))
+	    dma_free_from_pool_page(dev, page, size))
 		return;
 
 	if (dma_set_encrypted(dev, vaddr, size))
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index b0303efbc153..76bcafe03e44 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -311,3 +311,57 @@ bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 
 	return false;
 }
+
+struct dma_pool_phys_match {
+	phys_addr_t phys;
+	size_t size;
+	unsigned long addr;
+	bool found;
+};
+
+static void dma_pool_find_phys(struct gen_pool *pool, struct gen_pool_chunk *chunk,
+			       void *data)
+{
+	struct dma_pool_phys_match *match = data;
+	phys_addr_t end = match->phys + match->size - 1;
+	phys_addr_t chunk_end;
+
+	if (match->found)
+		return;
+
+	chunk_end = chunk->phys_addr + (chunk->end_addr - chunk->start_addr);
+	if (match->phys < chunk->phys_addr || end > chunk_end)
+		return;
+
+	match->addr = chunk->start_addr + (match->phys - chunk->phys_addr);
+	match->found = true;
+}
+
+static bool dma_free_from_pool_phys(struct gen_pool *pool, phys_addr_t phys,
+				    size_t size)
+{
+	struct dma_pool_phys_match match = {
+		.phys = phys,
+		.size = size,
+	};
+
+	gen_pool_for_each_chunk(pool, dma_pool_find_phys, &match);
+	if (!match.found)
+		return false;
+
+	gen_pool_free(pool, match.addr, size);
+	return true;
+}
+
+bool dma_free_from_pool_page(struct device *dev, struct page *page, size_t size)
+{
+	struct gen_pool *pool = NULL;
+	phys_addr_t phys = page_to_phys(page);
+
+	while ((pool = dma_guess_pool(pool, 0))) {
+		if (dma_free_from_pool_phys(pool, phys, size))
+			return true;
+	}
+
+	return false;
+}
-- 
2.43.0


