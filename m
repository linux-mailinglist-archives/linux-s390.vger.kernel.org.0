Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9230C2D21E8
	for <lists+linux-s390@lfdr.de>; Tue,  8 Dec 2020 05:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgLHERv (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 7 Dec 2020 23:17:51 -0500
Received: from foss.arm.com ([217.140.110.172]:40614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgLHERv (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 7 Dec 2020 23:17:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 202AC31B;
        Mon,  7 Dec 2020 20:17:05 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.87.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7BF863F718;
        Mon,  7 Dec 2020 20:17:00 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        hca@linux.ibm.com, catalin.marinas@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/3] mm/hotplug: Prevalidate the address range being added with platform
Date:   Tue,  8 Dec 2020 09:46:16 +0530
Message-Id: <1607400978-31595-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607400978-31595-1-git-send-email-anshuman.khandual@arm.com>
References: <1607400978-31595-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This introduces memhp_range_allowed() which can be called in various memory
hotplug paths to prevalidate the address range which is being added, with
the platform. Then memhp_range_allowed() calls memhp_get_pluggable_range()
which provides applicable address range depending on whether linear mapping
is required or not. For ranges that require linear mapping, it calls a new
arch callback arch_get_mappable_range() which the platform can override. So
the new callback, in turn provides the platform an opportunity to configure
acceptable memory hotplug address ranges in case there are constraints.

This mechanism will help prevent platform specific errors deep down during
hotplug calls. This drops now redundant check_hotplug_memory_addressable()
check in __add_pages() but instead adds a VM_BUG_ON() check which would
ensure that the range has been validated with memhp_range_allowed() earlier
in the call chain.

Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/memory_hotplug.h |  3 ++
 mm/memory_hotplug.c            | 78 +++++++++++++++++++++++++---------
 mm/memremap.c                  |  6 ++-
 3 files changed, 66 insertions(+), 21 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 551093b74596..efa3202524c0 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -70,6 +70,9 @@ typedef int __bitwise mhp_t;
  */
 #define MEMHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
 
+bool memhp_range_allowed(u64 start, u64 size, bool need_mapping);
+struct range arch_get_mappable_range(void);
+
 /*
  * Extended parameters for memory hotplug:
  * altmap: alternative allocator for memmap array (optional)
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 63b2e46b6555..797fa7f506b0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -107,6 +107,9 @@ static struct resource *register_memory_resource(u64 start, u64 size,
 	if (strcmp(resource_name, "System RAM"))
 		flags |= IORESOURCE_SYSRAM_DRIVER_MANAGED;
 
+	if (!memhp_range_allowed(start, size, 1))
+		return ERR_PTR(-E2BIG);
+
 	/*
 	 * Make sure value parsed from 'mem=' only restricts memory adding
 	 * while booting, so that memory hotplug won't be impacted. Please
@@ -284,22 +287,6 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
 	return 0;
 }
 
-static int check_hotplug_memory_addressable(unsigned long pfn,
-					    unsigned long nr_pages)
-{
-	const u64 max_addr = PFN_PHYS(pfn + nr_pages) - 1;
-
-	if (max_addr >> MAX_PHYSMEM_BITS) {
-		const u64 max_allowed = (1ull << (MAX_PHYSMEM_BITS + 1)) - 1;
-		WARN(1,
-		     "Hotplugged memory exceeds maximum addressable address, range=%#llx-%#llx, maximum=%#llx\n",
-		     (u64)PFN_PHYS(pfn), max_addr, max_allowed);
-		return -E2BIG;
-	}
-
-	return 0;
-}
-
 /*
  * Reasonably generic function for adding memory.  It is
  * expected that archs that support memory hotplug will
@@ -317,10 +304,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 	if (WARN_ON_ONCE(!params->pgprot.pgprot))
 		return -EINVAL;
 
-	err = check_hotplug_memory_addressable(pfn, nr_pages);
-	if (err)
-		return err;
-
+	VM_BUG_ON(!memhp_range_allowed(PFN_PHYS(pfn), nr_pages * PAGE_SIZE, 1));
 	if (altmap) {
 		/*
 		 * Validate altmap is within bounds of the total request
@@ -1181,6 +1165,60 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 }
 EXPORT_SYMBOL_GPL(add_memory_driver_managed);
 
+/*
+ * Platforms should define arch_get_mappable_range() that provides
+ * maximum possible addressable physical memory range for which the
+ * linear mapping could be created. The platform returned address
+ * range must adhere to these following semantics.
+ *
+ * - range.start <= range.end
+ * - Range includes both end points [range.start..range.end]
+ *
+ * There is also a fallback definition provided here, allowing the
+ * entire possible physical address range in case any platform does
+ * not define arch_get_mappable_range().
+ */
+struct range __weak arch_get_mappable_range(void)
+{
+	struct range memhp_range = {
+		.start = 0UL,
+		.end = -1ULL,
+	};
+	return memhp_range;
+}
+
+static inline struct range memhp_get_pluggable_range(bool need_mapping)
+{
+	const u64 max_phys = (1ULL << (MAX_PHYSMEM_BITS + 1)) - 1;
+	struct range memhp_range;
+
+	if (need_mapping) {
+		memhp_range = arch_get_mappable_range();
+		if (memhp_range.start > max_phys) {
+			memhp_range.start = 0;
+			memhp_range.end = 0;
+		}
+		memhp_range.end = min_t(u64, memhp_range.end, max_phys);
+	} else {
+		memhp_range.start = 0;
+		memhp_range.end = max_phys;
+	}
+	return memhp_range;
+}
+
+bool memhp_range_allowed(u64 start, u64 size, bool need_mapping)
+{
+	struct range memhp_range = memhp_get_pluggable_range(need_mapping);
+	u64 end = start + size;
+
+	if (start < end && start >= memhp_range.start && (end - 1) <= memhp_range.end)
+		return true;
+
+	pr_warn("Hotplug memory [%#llx-%#llx] exceeds maximum addressable range [%#llx-%#llx]\n",
+		start, end, memhp_range.start, memhp_range.end);
+	return false;
+}
+
 #ifdef CONFIG_MEMORY_HOTREMOVE
 /*
  * Confirm all pages in a range [start, end) belong to the same zone (skipping
diff --git a/mm/memremap.c b/mm/memremap.c
index 16b2fb482da1..26c1825756cc 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -185,6 +185,7 @@ static void dev_pagemap_percpu_release(struct percpu_ref *ref)
 static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 		int range_id, int nid)
 {
+	const bool is_private = pgmap->type == MEMORY_DEVICE_PRIVATE;
 	struct range *range = &pgmap->ranges[range_id];
 	struct dev_pagemap *conflict_pgmap;
 	int error, is_ram;
@@ -230,6 +231,9 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 	if (error)
 		goto err_pfn_remap;
 
+	if (!memhp_range_allowed(range->start, range_len(range), !is_private))
+		goto err_pfn_remap;
+
 	mem_hotplug_begin();
 
 	/*
@@ -243,7 +247,7 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 	 * the CPU, we do want the linear mapping and thus use
 	 * arch_add_memory().
 	 */
-	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
+	if (is_private) {
 		error = add_pages(nid, PHYS_PFN(range->start),
 				PHYS_PFN(range_len(range)), params);
 	} else {
-- 
2.20.1

