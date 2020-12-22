Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872DE2DD432
	for <lists+linux-s390@lfdr.de>; Thu, 17 Dec 2020 16:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgLQP3f (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 17 Dec 2020 10:29:35 -0500
Received: from foss.arm.com ([217.140.110.172]:42310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbgLQP3e (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Dec 2020 10:29:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F09F1042;
        Thu, 17 Dec 2020 07:28:48 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.84.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D3B0D3F66B;
        Thu, 17 Dec 2020 07:28:44 -0800 (PST)
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
Subject: [PATCH V2 2/3] arm64/mm: Define arch_get_mappable_range()
Date:   Thu, 17 Dec 2020 20:58:31 +0530
Message-Id: <1608218912-28932-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608218912-28932-1-git-send-email-anshuman.khandual@arm.com>
References: <1608218912-28932-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This overrides arch_get_mappable_range() on arm64 platform which will be
used with recently added generic framework. It drops inside_linear_region()
and subsequent check in arch_add_memory() which are no longer required. It
also adds a VM_BUG_ON() check that would ensure that memhp_range_allowed()
has already been called.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/mmu.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ca692a815731..54705dcacb4e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1444,16 +1444,19 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
 	free_empty_tables(start, end, PAGE_OFFSET, PAGE_END);
 }
 
-static bool inside_linear_region(u64 start, u64 size)
+struct range arch_get_mappable_range(void)
 {
+	struct range memhp_range;
+
 	/*
 	 * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
 	 * accommodating both its ends but excluding PAGE_END. Max physical
 	 * range which can be mapped inside this linear mapping range, must
 	 * also be derived from its end points.
 	 */
-	return start >= __pa(_PAGE_OFFSET(vabits_actual)) &&
-	       (start + size - 1) <= __pa(PAGE_END - 1);
+	memhp_range.start = __pa(_PAGE_OFFSET(vabits_actual));
+	memhp_range.end =  __pa(PAGE_END - 1);
+	return memhp_range;
 }
 
 int arch_add_memory(int nid, u64 start, u64 size,
@@ -1461,11 +1464,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
 {
 	int ret, flags = 0;
 
-	if (!inside_linear_region(start, size)) {
-		pr_err("[%llx %llx] is outside linear mapping region\n", start, start + size);
-		return -EINVAL;
-	}
-
+	VM_BUG_ON(!memhp_range_allowed(start, size, 1));
 	if (rodata_full || debug_pagealloc_enabled())
 		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
-- 
2.20.1

