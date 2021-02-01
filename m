Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C57C30A087
	for <lists+linux-s390@lfdr.de>; Mon,  1 Feb 2021 04:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhBADZq (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 31 Jan 2021 22:25:46 -0500
Received: from foss.arm.com ([217.140.110.172]:46272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231301AbhBADZm (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 31 Jan 2021 22:25:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9B5C13D5;
        Sun, 31 Jan 2021 19:24:56 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.93.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 63B473F66E;
        Sun, 31 Jan 2021 19:24:52 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com,
        catalin.marinas@arm.com, david@redhat.com, osalvador@suse.de
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 3/4] s390/mm: Define arch_get_mappable_range()
Date:   Mon,  1 Feb 2021 08:55:01 +0530
Message-Id: <1612149902-7867-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612149902-7867-1-git-send-email-anshuman.khandual@arm.com>
References: <1612149902-7867-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This overrides arch_get_mappabble_range() on s390 platform which will be
used with recently added generic framework. It modifies the existing range
check in vmem_add_mapping() using arch_get_mappable_range(). It also adds a
VM_BUG_ON() check that would ensure that mhp_range_allowed() has already
been called on the hotplug path.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/s390/mm/init.c |  1 +
 arch/s390/mm/vmem.c | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 73a163065b95..0e76b2127dc6 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -297,6 +297,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
 		return -EINVAL;
 
+	VM_BUG_ON(!mhp_range_allowed(start, size, true));
 	rc = vmem_add_mapping(start, size);
 	if (rc)
 		return rc;
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 01f3a5f58e64..82dbf9450105 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -4,6 +4,7 @@
  *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
  */
 
+#include <linux/memory_hotplug.h>
 #include <linux/memblock.h>
 #include <linux/pfn.h>
 #include <linux/mm.h>
@@ -532,11 +533,22 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
 	mutex_unlock(&vmem_mutex);
 }
 
+struct range arch_get_mappable_range(void)
+{
+	struct range mhp_range;
+
+	mhp_range.start = 0;
+	mhp_range.end =  VMEM_MAX_PHYS - 1;
+	return mhp_range;
+}
+
 int vmem_add_mapping(unsigned long start, unsigned long size)
 {
+	struct range range = arch_get_mappable_range();
 	int ret;
 
-	if (start + size > VMEM_MAX_PHYS ||
+	if (start < range.start ||
+	    start + size > range.end + 1 ||
 	    start + size < start)
 		return -ERANGE;
 
-- 
2.20.1

