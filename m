Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB603880EF
	for <lists+linux-s390@lfdr.de>; Tue, 18 May 2021 22:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352034AbhERUJi (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 18 May 2021 16:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbhERUJi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 May 2021 16:09:38 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7BCC061573;
        Tue, 18 May 2021 13:08:19 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t4so5735360plc.6;
        Tue, 18 May 2021 13:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MNGAefi2XGquv7ADvXSLLg1AB0DvLJWZ+nDSpBzysJE=;
        b=po/9chrKD5sFYOH0pueuDwSaCPgabrhMyc2CjLFVET34fJ/hAWd+g1uwVdnYlIgkM+
         4Ky3Ze4gxG+3rMHG++vd50nQbD+GcH4CDBrS/fB25iJHtU5C/ltZNj5/KFryTVVVNMzU
         qG9Dt/5SuplVU08G+DtdnC3924xIFn9edObevi2Z+XpcL4HytFsRdqZRiWhjkYBxKvgf
         CDqFs4wFYo1uiFVTX0FlMzkBw9zeV4McZ/CGXsnz1M8OgfSuX3Soq8WWn3gY/gwtIA1r
         t4z6U0AsV5+gSgz7Ku0p4VbMplFDqIX3xDmWGvAOCGVfAMRc5hYokfVpRBnhBGKSWyZv
         9xGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MNGAefi2XGquv7ADvXSLLg1AB0DvLJWZ+nDSpBzysJE=;
        b=gy7bKxhI/7DdI/ymLVoPm+IwE0R1XBcTosHS608ZzNIEHqXsf1vreMxYuxYTxovruf
         mBDcPO4OE22OpwAF/wHDRObknVRkGasrCpbCX4OJ/1MZAYmZm3MRz9PZ441iM4agCFUi
         vwAGFVRrPBUqC2ZDBV/RLFfWblpYIJ81Ah+WFGomtRev8E23YNtbro+Pl2ZWxvZgxRyp
         u2SJ1MatbR0dTyIjd1pZlRfh0P3aRbOAPblGSxWSm4TA7s5GAbNYY8lhrQCNOvEo2sz5
         KiWi5jTjmS8wUPBIBARmZ9rtUMDKIacYBxDrcFIYvVmucnIOv0EMMqhueKjGwFvnJGBU
         IPWg==
X-Gm-Message-State: AOAM530QKKu0uqFMxf59FA6e6v0YA6T2Kr27O+fy5IBVZvn0Q2oCiOLf
        UoDR1xJ0ceaOR/yDX69xP+E=
X-Google-Smtp-Source: ABdhPJzGW7Ar92/6nEIX2ysdxrWuQCZB2TGBhuS0zyU1hYinjuGSb+/BC0JRw+C4p2hD4TR/SSpEcw==
X-Received: by 2002:a17:90a:e7c6:: with SMTP id kb6mr7137260pjb.81.1621368498964;
        Tue, 18 May 2021 13:08:18 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id r11sm13456600pgl.34.2021.05.18.13.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 13:08:18 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@suse.de, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        ying.huang@intel.com, mhocko@suse.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 1/7] mm: memory: add orig_pmd to struct vm_fault
Date:   Tue, 18 May 2021 13:07:55 -0700
Message-Id: <20210518200801.7413-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210518200801.7413-1-shy828301@gmail.com>
References: <20210518200801.7413-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add orig_pmd to struct vm_fault so the "orig_pmd" parameter used by huge page
fault could be removed, just like its PTE counterpart does.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/huge_mm.h |  9 ++++-----
 include/linux/mm.h      |  7 ++++++-
 mm/huge_memory.c        |  9 ++++++---
 mm/memory.c             | 26 +++++++++++++-------------
 4 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 60dad7c88d72..77d6d454df90 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -11,7 +11,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
 		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
-void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd);
+void huge_pmd_set_accessed(struct vm_fault *vmf);
 int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
 		  struct vm_area_struct *vma);
@@ -24,7 +24,7 @@ static inline void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 }
 #endif
 
-vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd);
+vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf);
 struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 				   unsigned long addr, pmd_t *pmd,
 				   unsigned int flags);
@@ -283,7 +283,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 		pud_t *pud, int flags, struct dev_pagemap **pgmap);
 
-vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t orig_pmd);
+vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
 
 extern struct page *huge_zero_page;
 
@@ -429,8 +429,7 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 	return NULL;
 }
 
-static inline vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf,
-		pmd_t orig_pmd)
+static inline vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 {
 	return 0;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6ce7bac74530..b3a4b405364b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -550,7 +550,12 @@ struct vm_fault {
 	pud_t *pud;			/* Pointer to pud entry matching
 					 * the 'address'
 					 */
-	pte_t orig_pte;			/* Value of PTE at the time of fault */
+	union {
+		pte_t orig_pte;		/* Value of PTE at the time of fault */
+		pmd_t orig_pmd;		/* Value of PMD at the time of fault,
+					 * used by PMD fault only.
+					 */
+	};
 
 	struct page *cow_page;		/* Page handler may use for COW fault */
 	struct page *page;		/* ->fault handlers should return a
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 19195fca1aee..692788988530 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1245,11 +1245,12 @@ void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 }
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
-void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd)
+void huge_pmd_set_accessed(struct vm_fault *vmf)
 {
 	pmd_t entry;
 	unsigned long haddr;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
+	pmd_t orig_pmd = vmf->orig_pmd;
 
 	vmf->ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_same(*vmf->pmd, orig_pmd)))
@@ -1266,11 +1267,12 @@ void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd)
 	spin_unlock(vmf->ptl);
 }
 
-vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
+vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
+	pmd_t orig_pmd = vmf->orig_pmd;
 
 	vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
 	VM_BUG_ON_VMA(!vma->anon_vma, vma);
@@ -1406,9 +1408,10 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 }
 
 /* NUMA hinting page fault entry point for trans huge pmds */
-vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
+vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	pmd_t pmd = vmf->orig_pmd;
 	struct anon_vma *anon_vma = NULL;
 	struct page *page;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
diff --git a/mm/memory.c b/mm/memory.c
index 97ca3e51cf85..f9df3ab12813 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4252,12 +4252,12 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 }
 
 /* `inline' is required to avoid gcc 4.1.2 build error */
-static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf, pmd_t orig_pmd)
+static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 {
 	if (vma_is_anonymous(vmf->vma)) {
-		if (userfaultfd_huge_pmd_wp(vmf->vma, orig_pmd))
+		if (userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
 			return handle_userfault(vmf, VM_UFFD_WP);
-		return do_huge_pmd_wp_page(vmf, orig_pmd);
+		return do_huge_pmd_wp_page(vmf);
 	}
 	if (vmf->vma->vm_ops->huge_fault) {
 		vm_fault_t ret = vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
@@ -4484,26 +4484,26 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
 	} else {
-		pmd_t orig_pmd = *vmf.pmd;
+		vmf.orig_pmd = *vmf.pmd;
 
 		barrier();
-		if (unlikely(is_swap_pmd(orig_pmd))) {
+		if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
 			VM_BUG_ON(thp_migration_supported() &&
-					  !is_pmd_migration_entry(orig_pmd));
-			if (is_pmd_migration_entry(orig_pmd))
+					  !is_pmd_migration_entry(vmf.orig_pmd));
+			if (is_pmd_migration_entry(vmf.orig_pmd))
 				pmd_migration_entry_wait(mm, vmf.pmd);
 			return 0;
 		}
-		if (pmd_trans_huge(orig_pmd) || pmd_devmap(orig_pmd)) {
-			if (pmd_protnone(orig_pmd) && vma_is_accessible(vma))
-				return do_huge_pmd_numa_page(&vmf, orig_pmd);
+		if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_pmd)) {
+			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
+				return do_huge_pmd_numa_page(&vmf);
 
-			if (dirty && !pmd_write(orig_pmd)) {
-				ret = wp_huge_pmd(&vmf, orig_pmd);
+			if (dirty && !pmd_write(vmf.orig_pmd)) {
+				ret = wp_huge_pmd(&vmf);
 				if (!(ret & VM_FAULT_FALLBACK))
 					return ret;
 			} else {
-				huge_pmd_set_accessed(&vmf, orig_pmd);
+				huge_pmd_set_accessed(&vmf);
 				return 0;
 			}
 		}
-- 
2.26.2

