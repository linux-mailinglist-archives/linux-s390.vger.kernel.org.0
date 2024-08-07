Return-Path: <linux-s390+bounces-5425-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91600949B2C
	for <lists+linux-s390@lfdr.de>; Wed,  7 Aug 2024 00:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39EC1C22A38
	for <lists+linux-s390@lfdr.de>; Tue,  6 Aug 2024 22:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481B3171E68;
	Tue,  6 Aug 2024 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="jMqDWrs6"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376F3170A11
	for <linux-s390@vger.kernel.org>; Tue,  6 Aug 2024 22:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982503; cv=none; b=akqu/2NOjSDDl6idzZLW7TiRh+hK4xLqgYbPX0Etsru5En8Xfc38EIyxbIuja4gBLSzemhZyFOqYTfiNXlScQZwZPMDGIUTVrnHXxGUC8PeHJHZKBDjEcEAn/yv8Z4ArkjwkIqCq7+0P5463LJ+aukupLKlsnFMXRMYmzuxQsb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982503; c=relaxed/simple;
	bh=9e0WaRPQ5tkd1BX7HOX3i9wBMmPwOQ07aBux+rhj1mE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaDYzzEf61Isx6PkkEVjjFY3dC3UBw90UixnesPiAv7lsB4PjGkNlu2BBwOXaaakTjpWV6tSkswex9rxz0ipyZjOhAGgeAo0fJJ2JFYOMln/TpSdeEZPrNlfSRarvOkd7vOOxTZHvSrMv7wwTau4jt7QY/twOoWoSt92GJDEa64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=jMqDWrs6; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-69483a97848so9759277b3.2
        for <linux-s390@vger.kernel.org>; Tue, 06 Aug 2024 15:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1722982499; x=1723587299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7m8AXjGIE//n/y8EnZvRZBr5S07q4MZ8rZJ4WK1cCs=;
        b=jMqDWrs6bLSnltuYsOnBMGpWrgVZHOkL2SjKl5DHxh/HuwI+mne0R7ew47JA/y91rs
         QElenEDQehlqoPcF+/x62Y3mhKTNWFrhh09XPWvsoC3Uz+vs5cnBhnCG6VcLrzXUPLLg
         hkWuDtnLZBkm+cjt0SxhvvGK/KSrU3tBEASSBAUQxk6QiTDVU6n7zuiEgqUENhwBAN1M
         DFK1/qq5deBnEa2yHY/nmGYHzVv0C1QEXe5Fjtj/aWRfHNRBSX0ra3J2YhndeMs78cjn
         cqLwOUVCrzbGCw4zpS3BaS3m6WY+MKsiqqYAOfgajMAU2F9Qzga0SbDGS7WOWwoA4uKk
         u2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722982499; x=1723587299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7m8AXjGIE//n/y8EnZvRZBr5S07q4MZ8rZJ4WK1cCs=;
        b=Y2hYUhKcTbjye4hj8Vu8IQGY3sfLhqHMsDfWQjJlQl6wO4/n+w4PJwUK+4+Q8o1bXD
         f4J08LOZi5teZwmd7Pw+tg8gg4LP1rj1Q36MDzrheH4cB/ciXWul1Xbj8DCyrmnO3IP4
         V322S4WXOAymcXy5pr9KzA7h7f2Rs+LABH3BfvXoYCJx9Fn2d3c/u8sr88aO/2PRvrpe
         7YmOIuINUssPh98vcCNODIVxfqzRhwepVX0j8y/P5IdYFxy/zK15WYz593vXDJOUmSut
         +ejaT5p8haMDeiwJA87AAhqOjM/+HGuQ6FPNW+7LE/GzqNEnonuHgl6wuFD94ChWbBcs
         rL2A==
X-Forwarded-Encrypted: i=1; AJvYcCV4PbEKs/kQrKRaOhSMwn14sZGBU1bvgBZ+Nmvz3bd9uxiceAJbFGHjpDqMu1cm0ZwDLoL2sqSogkF2O26naeuoqobL6HdOMHcsPQ==
X-Gm-Message-State: AOJu0YxTXJPApsjziEZlvFoZeJwwkqg0UwNw97hDupp7wqKLNlKWmXB5
	+dvXvvbsApLXUYtP7hQ+GvnGas6Fr5nStAS/Mg6drtHCH+Ou3QLNG9TJJN/ROE4=
X-Google-Smtp-Source: AGHT+IGIO0sFXsBF1eTQ0icc4IIEsdk0oMud/A0qVs+YtT55Cl3ZtQ5CEJPlkw6JzrdTl3cVtoHafQ==
X-Received: by 2002:a05:690c:701:b0:64a:d9a1:db3f with SMTP id 00721157ae682-6904c8c2bbcmr129440177b3.7.1722982499048;
        Tue, 06 Aug 2024 15:14:59 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c8778e1sm50584506d6.128.2024.08.06.15.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:14:58 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alexghiti@rivosinc.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	arnd@arndb.de,
	bhe@redhat.com,
	bjorn@rivosinc.com,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	chenhuacai@kernel.org,
	chenjiahao16@huawei.com,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	dawei.li@shingroup.cn,
	gerald.schaefer@linux.ibm.com,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	hpa@zytor.com,
	kent.overstreet@linux.dev,
	kernel@xen0n.name,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	loongarch@lists.linux.dev,
	luto@kernel.org,
	maobibo@loongson.cn,
	mark.rutland@arm.com,
	mcgrof@kernel.org,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	muchun.song@linux.dev,
	namcao@linutronix.de,
	naveen@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	palmer@dabbelt.com,
	pasha.tatashin@soleen.com,
	paul.walmsley@sifive.com,
	peterz@infradead.org,
	philmd@linaro.org,
	rdunlap@infradead.org,
	rientjes@google.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	souravpanda@google.com,
	svens@linux.ibm.com,
	tglx@linutronix.de,
	tzimmermann@suse.de,
	will@kernel.org,
	x86@kernel.org
Subject: [PATCH 2/2] mm: keep nid around during hot-remove
Date: Tue,  6 Aug 2024 22:14:54 +0000
Message-ID: <20240806221454.1971755-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240806221454.1971755-1-pasha.tatashin@soleen.com>
References: <20240806221454.1971755-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nid is needed during memory hot-remove in order to account the
information about the memmap overhead that is being removed.

In addition, we cannot use page_pgdat(pfn_to_page(pfn)) during
hotremove after remove_pfn_range_from_zone().

We also cannot determine nid from walking through memblocks after
remove_memory_block_devices() is called.

Therefore, pass nid down from the beginning of hotremove to where
it is used for the accounting purposes.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/linux-cxl/CAHj4cs9Ax1=CoJkgBGP_+sNu6-6=6v=_L-ZBZY0bVLD3wUWZQg@mail.gmail.com
Reported-by: Alison Schofield <alison.schofield@intel.com>
Closes: https://lore.kernel.org/linux-mm/Zq0tPd2h6alFz8XF@aschofie-mobl2/#t

Fixes: 15995a352474 ("mm: report per-page metadata information")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/mm/mmu.c            |  5 +++--
 arch/loongarch/mm/init.c       |  5 +++--
 arch/powerpc/mm/mem.c          |  5 +++--
 arch/riscv/mm/init.c           |  5 +++--
 arch/s390/mm/init.c            |  5 +++--
 arch/x86/mm/init_64.c          |  5 +++--
 include/linux/memory_hotplug.h |  7 ++++---
 mm/memory_hotplug.c            | 18 +++++++++---------
 mm/memremap.c                  |  6 ++++--
 mm/sparse-vmemmap.c            | 14 ++++++++------
 mm/sparse.c                    | 20 +++++++++++---------
 11 files changed, 54 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 353ea5dc32b8..cd0808d05551 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1363,12 +1363,13 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	return ret;
 }
 
-void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
+			int nid)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
-	__remove_pages(start_pfn, nr_pages, altmap);
+	__remove_pages(start_pfn, nr_pages, altmap, nid);
 	__remove_pgd_mapping(swapper_pg_dir, __phys_to_virt(start), size);
 }
 
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index bf789d114c2d..64cfbfb75c15 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -106,7 +106,8 @@ int arch_add_memory(int nid, u64 start, u64 size, struct mhp_params *params)
 	return ret;
 }
 
-void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
+			int nid)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
@@ -115,7 +116,7 @@ void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 	/* With altmap the first mapped page is offset from @start */
 	if (altmap)
 		page += vmem_altmap_offset(altmap);
-	__remove_pages(start_pfn, nr_pages, altmap);
+	__remove_pages(start_pfn, nr_pages, altmap, nid);
 }
 
 #ifdef CONFIG_NUMA
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index d325217ab201..74c0213f995a 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -157,12 +157,13 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
 	return rc;
 }
 
-void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
+			      int nid)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
-	__remove_pages(start_pfn, nr_pages, altmap);
+	__remove_pages(start_pfn, nr_pages, altmap, nid);
 	arch_remove_linear_mapping(start, size);
 }
 #endif
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 8b698d9609e7..bf1be25cc513 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1796,9 +1796,10 @@ int __ref arch_add_memory(int nid, u64 start, u64 size, struct mhp_params *param
 	return ret;
 }
 
-void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
+			      int nid)
 {
-	__remove_pages(start >> PAGE_SHIFT, size >> PAGE_SHIFT, altmap);
+	__remove_pages(start >> PAGE_SHIFT, size >> PAGE_SHIFT, altmap, nid);
 	remove_linear_mapping(start, size);
 	flush_tlb_all();
 }
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index e3d258f9e726..bf596d87543a 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -290,12 +290,13 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	return rc;
 }
 
-void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
+			int nid)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
-	__remove_pages(start_pfn, nr_pages, altmap);
+	__remove_pages(start_pfn, nr_pages, altmap, nid);
 	vmem_remove_mapping(start, size);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index d8dbeac8b206..5bb82fbb7c2c 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1262,12 +1262,13 @@ kernel_physical_mapping_remove(unsigned long start, unsigned long end)
 	remove_pagetable(start, end, true, NULL);
 }
 
-void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
+			      int nid)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
-	__remove_pages(start_pfn, nr_pages, altmap);
+	__remove_pages(start_pfn, nr_pages, altmap, nid);
 	kernel_physical_mapping_remove(start, start + size);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index ebe876930e78..47c9af202884 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -201,9 +201,10 @@ static inline bool movable_node_is_enabled(void)
 	return movable_node_enabled;
 }
 
-extern void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap);
+extern void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
+			       int nid);
 extern void __remove_pages(unsigned long start_pfn, unsigned long nr_pages,
-			   struct vmem_altmap *altmap);
+			   struct vmem_altmap *altmap, int nid);
 
 /* reasonably generic interface to expand the physical pages */
 extern int __add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
@@ -369,7 +370,7 @@ extern int sparse_add_section(int nid, unsigned long pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap);
 extern void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
-				  struct vmem_altmap *altmap);
+				  struct vmem_altmap *altmap, int nid);
 extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
 					  unsigned long pnum);
 extern struct zone *zone_for_pfn_range(int online_type, int nid,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 66267c26ca1b..c66148049fa6 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -571,7 +571,7 @@ void __ref remove_pfn_range_from_zone(struct zone *zone,
  * calling offline_pages().
  */
 void __remove_pages(unsigned long pfn, unsigned long nr_pages,
-		    struct vmem_altmap *altmap)
+		    struct vmem_altmap *altmap, int nid)
 {
 	const unsigned long end_pfn = pfn + nr_pages;
 	unsigned long cur_nr_pages;
@@ -586,7 +586,7 @@ void __remove_pages(unsigned long pfn, unsigned long nr_pages,
 		/* Select all remaining pages up to the next section boundary */
 		cur_nr_pages = min(end_pfn - pfn,
 				   SECTION_ALIGN_UP(pfn + 1) - pfn);
-		sparse_remove_section(pfn, cur_nr_pages, altmap);
+		sparse_remove_section(pfn, cur_nr_pages, altmap, nid);
 	}
 }
 
@@ -1386,7 +1386,7 @@ bool mhp_supports_memmap_on_memory(void)
 }
 EXPORT_SYMBOL_GPL(mhp_supports_memmap_on_memory);
 
-static void __ref remove_memory_blocks_and_altmaps(u64 start, u64 size)
+static void __ref remove_memory_blocks_and_altmaps(u64 start, u64 size, int nid)
 {
 	unsigned long memblock_size = memory_block_size_bytes();
 	u64 cur_start;
@@ -1409,7 +1409,7 @@ static void __ref remove_memory_blocks_and_altmaps(u64 start, u64 size)
 
 		remove_memory_block_devices(cur_start, memblock_size);
 
-		arch_remove_memory(cur_start, memblock_size, altmap);
+		arch_remove_memory(cur_start, memblock_size, altmap, nid);
 
 		/* Verify that all vmemmap pages have actually been freed. */
 		WARN(altmap->alloc, "Altmap not fully unmapped");
@@ -1454,7 +1454,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 		ret = create_memory_block_devices(cur_start, memblock_size,
 						  params.altmap, group);
 		if (ret) {
-			arch_remove_memory(cur_start, memblock_size, NULL);
+			arch_remove_memory(cur_start, memblock_size, NULL, nid);
 			kfree(params.altmap);
 			goto out;
 		}
@@ -1463,7 +1463,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 	return 0;
 out:
 	if (ret && cur_start != start)
-		remove_memory_blocks_and_altmaps(start, cur_start - start);
+		remove_memory_blocks_and_altmaps(start, cur_start - start, nid);
 	return ret;
 }
 
@@ -1532,7 +1532,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		/* create memory block devices after memory was added */
 		ret = create_memory_block_devices(start, size, NULL, group);
 		if (ret) {
-			arch_remove_memory(start, size, params.altmap);
+			arch_remove_memory(start, size, params.altmap, nid);
 			goto error;
 		}
 	}
@@ -2275,10 +2275,10 @@ static int __ref try_remove_memory(u64 start, u64 size)
 		 * No altmaps present, do the removal directly
 		 */
 		remove_memory_block_devices(start, size);
-		arch_remove_memory(start, size, NULL);
+		arch_remove_memory(start, size, NULL, nid);
 	} else {
 		/* all memblocks in the range have altmaps */
-		remove_memory_blocks_and_altmaps(start, size);
+		remove_memory_blocks_and_altmaps(start, size, nid);
 	}
 
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
diff --git a/mm/memremap.c b/mm/memremap.c
index 40d4547ce514..08e72959eb48 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -112,9 +112,11 @@ static void pageunmap_range(struct dev_pagemap *pgmap, int range_id)
 {
 	struct range *range = &pgmap->ranges[range_id];
 	struct page *first_page;
+	int nid;
 
 	/* make sure to access a memmap that was actually initialized */
 	first_page = pfn_to_page(pfn_first(pgmap, range_id));
+	nid = page_to_nid(first_page);
 
 	/* pages are dead and unused, undo the arch mapping */
 	mem_hotplug_begin();
@@ -122,10 +124,10 @@ static void pageunmap_range(struct dev_pagemap *pgmap, int range_id)
 				   PHYS_PFN(range_len(range)));
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
 		__remove_pages(PHYS_PFN(range->start),
-			       PHYS_PFN(range_len(range)), NULL);
+			       PHYS_PFN(range_len(range)), NULL, nid);
 	} else {
 		arch_remove_memory(range->start, range_len(range),
-				pgmap_altmap(pgmap));
+				   pgmap_altmap(pgmap), nid);
 		kasan_remove_zero_shadow(__va(range->start), range_len(range));
 	}
 	mem_hotplug_done();
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 1dda6c53370b..0dafad626ab8 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -469,12 +469,14 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 	if (r < 0)
 		return NULL;
 
-	if (system_state == SYSTEM_BOOTING) {
-		mod_node_early_perpage_metadata(nid, DIV_ROUND_UP(end - start,
-								  PAGE_SIZE));
-	} else {
-		mod_node_page_state(NODE_DATA(nid), NR_MEMMAP,
-				    DIV_ROUND_UP(end - start, PAGE_SIZE));
+	if (nid != NUMA_NO_NODE) {
+		if (system_state == SYSTEM_BOOTING) {
+			mod_node_early_perpage_metadata(nid, DIV_ROUND_UP(end - start,
+									  PAGE_SIZE));
+		} else {
+			mod_node_page_state(NODE_DATA(nid), NR_MEMMAP,
+					    DIV_ROUND_UP(end - start, PAGE_SIZE));
+		}
 	}
 
 	return pfn_to_page(pfn);
diff --git a/mm/sparse.c b/mm/sparse.c
index e4b830091d13..fc01bc5f0f1d 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -638,13 +638,15 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 }
 
 static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap)
+		struct vmem_altmap *altmap, int nid)
 {
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	mod_node_page_state(page_pgdat(pfn_to_page(pfn)), NR_MEMMAP,
-			    -1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
+	if (nid != NUMA_NO_NODE) {
+		mod_node_page_state(NODE_DATA(nid), NR_MEMMAP,
+				    -1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
+	}
 	vmemmap_free(start, end, altmap);
 }
 static void free_map_bootmem(struct page *memmap)
@@ -713,7 +715,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 }
 
 static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap)
+		struct vmem_altmap *altmap, int nid)
 {
 	kvfree(pfn_to_page(pfn));
 }
@@ -781,7 +783,7 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
  * For 2 and 3, the SPARSEMEM_VMEMMAP={y,n} cases are unified
  */
 static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap)
+		struct vmem_altmap *altmap, int nid)
 {
 	struct mem_section *ms = __pfn_to_section(pfn);
 	bool section_is_early = early_section(ms);
@@ -821,7 +823,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	 * section_activate() and pfn_valid() .
 	 */
 	if (!section_is_early)
-		depopulate_section_memmap(pfn, nr_pages, altmap);
+		depopulate_section_memmap(pfn, nr_pages, altmap, nid);
 	else if (memmap)
 		free_map_bootmem(memmap);
 
@@ -865,7 +867,7 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 
 	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
 	if (!memmap) {
-		section_deactivate(pfn, nr_pages, altmap);
+		section_deactivate(pfn, nr_pages, altmap, nid);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -928,13 +930,13 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 }
 
 void sparse_remove_section(unsigned long pfn, unsigned long nr_pages,
-			   struct vmem_altmap *altmap)
+			   struct vmem_altmap *altmap, int nid)
 {
 	struct mem_section *ms = __pfn_to_section(pfn);
 
 	if (WARN_ON_ONCE(!valid_section(ms)))
 		return;
 
-	section_deactivate(pfn, nr_pages, altmap);
+	section_deactivate(pfn, nr_pages, altmap, nid);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
-- 
2.46.0.76.ge559c4bf1a-goog


