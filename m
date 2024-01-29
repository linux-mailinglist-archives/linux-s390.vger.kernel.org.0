Return-Path: <linux-s390+bounces-1243-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2105A84087F
	for <lists+linux-s390@lfdr.de>; Mon, 29 Jan 2024 15:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A039228BE82
	for <lists+linux-s390@lfdr.de>; Mon, 29 Jan 2024 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7120E151CE9;
	Mon, 29 Jan 2024 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jde4vgNt"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913B0154BE2
	for <linux-s390@vger.kernel.org>; Mon, 29 Jan 2024 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538801; cv=none; b=qsXAtvmoMO1UkS4rN4oLcwfhbJxMz5F579hLBE/HD/s2O2c7OinMHSaItiS5j1BvXzbhT11w+H5a13G/Jc2WlUyT3uag+wHY9uZUvBBP9ZwLSbFQeGGdccVFr0lBW1TFv8ZAU4UhN1fS8Tu2c0ZLqxNcoBddhd97U5HLTZzFvU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538801; c=relaxed/simple;
	bh=TSmfVJpTFAI5Bi+X9dzLq2pbCeH7Qo4+UMUFhytmPFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEVRxjeGjtwQp/H7+Vc7e1vS55ctNRkcK/Iv/HdzvMYdrvQdx1Wolul01wXz7s3yDZjVQb6iZP4qPmbj1ch38dNIb/65N+rgNCmyO7gvMK9hbQrYM97IRLZyNP4y2A5Jw7qvOwIuCeP7Zvjo3bCR3NhF22UOGHhRCyt3Hin85t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jde4vgNt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706538798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zfDWyrOXB1mD+zgjXEawbz7aquFQMadFUbUPJ1Y1hbE=;
	b=Jde4vgNt9FLcTh04SK6lPnB/a1lN3TqH3VvDst+prnSTm+Lx2wZCYBUet5NH9jfcpmNsGV
	4dz024++StKb1BRiSv2vvazWlWa5NKfpnMqeo3WfmcHO9HNsXNYHkqeC+9ZGuh2rB8sBdu
	libY0GiUIVG8xxVSS+nCk0ZzuwHKq6c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-G5xnxcuDPh6_dHlX6DUXrg-1; Mon, 29 Jan 2024 09:33:13 -0500
X-MC-Unique: G5xnxcuDPh6_dHlX6DUXrg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D140685A597;
	Mon, 29 Jan 2024 14:33:11 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E6EB5AD1;
	Mon, 29 Jan 2024 14:33:07 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org
Subject: [PATCH v1 9/9] mm/memory: optimize unmap/zap with PTE-mapped THP
Date: Mon, 29 Jan 2024 15:32:21 +0100
Message-ID: <20240129143221.263763-10-david@redhat.com>
In-Reply-To: <20240129143221.263763-1-david@redhat.com>
References: <20240129143221.263763-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Similar to how we optimized fork(), let's implement PTE batching when
consecutive (present) PTEs map consecutive pages of the same large
folio.

Most infrastructure we need for batching (mmu gather, rmap) is already
there. We only have to add get_and_clear_full_ptes() and
clear_full_ptes(). Similarly, extend zap_install_uffd_wp_if_needed() to
process a PTE range.

We won't bother sanity-checking the mapcount of all subpages, but only
check the mapcount of the first subpage we process.

To keep small folios as fast as possible force inlining of a specialized
variant using __always_inline with nr=1.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/pgtable.h | 66 +++++++++++++++++++++++++++++
 mm/memory.c             | 92 +++++++++++++++++++++++++++++------------
 2 files changed, 132 insertions(+), 26 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index aab227e12493..f0feae7f89fb 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -580,6 +580,72 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 }
 #endif
 
+#ifndef get_and_clear_full_ptes
+/**
+ * get_and_clear_full_ptes - Clear PTEs that map consecutive pages of the same
+ *			     folio, collecting dirty/accessed bits.
+ * @mm: Address space the pages are mapped into.
+ * @addr: Address the first page is mapped at.
+ * @ptep: Page table pointer for the first entry.
+ * @nr: Number of entries to clear.
+ * @full: Whether we are clearing a full mm.
+ *
+ * May be overridden by the architecture; otherwise, implemented as a simple
+ * loop over ptep_get_and_clear_full(), merging dirty/accessed bits into
+ * returned PTE.
+ *
+ * Note that PTE bits in the PTE range besides the PFN can differ. For example,
+ * some PTEs might be write-protected.
+ *
+ * Context: The caller holds the page table lock.  The PTEs map consecutive
+ * pages that belong to the same folio.  The PTEs are all in the same PMD.
+ */
+static inline pte_t get_and_clear_full_ptes(struct mm_struct *mm,
+		unsigned long addr, pte_t *ptep, unsigned int nr, int full)
+{
+	pte_t pte, tmp_pte;
+
+	pte = ptep_get_and_clear_full(mm, addr, ptep, full);
+	while (--nr) {
+		ptep++;
+		addr += PAGE_SIZE;
+		tmp_pte = ptep_get_and_clear_full(mm, addr, ptep, full);
+		if (pte_dirty(tmp_pte))
+			pte = pte_mkdirty(pte);
+		if (pte_young(tmp_pte))
+			pte = pte_mkyoung(pte);
+	}
+	return pte;
+}
+#endif
+
+#ifndef clear_full_ptes
+/**
+ * clear_full_ptes - Clear PTEs that map consecutive pages of the same folio.
+ * @mm: Address space the pages are mapped into.
+ * @addr: Address the first page is mapped at.
+ * @ptep: Page table pointer for the first entry.
+ * @nr: Number of entries to clear.
+ * @full: Whether we are clearing a full mm.
+ *
+ * Note that PTE bits in the PTE range besides the PFN can differ. For example,
+ * some PTEs might be write-protected.
+ *
+ * Context: The caller holds the page table lock.  The PTEs map consecutive
+ * pages that belong to the same folio.  The PTEs are all in the same PMD.
+ */
+static inline void clear_full_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, unsigned int nr, int full)
+{
+	for (;;) {
+		ptep_get_and_clear_full(mm, addr, ptep, full);
+		if (--nr == 0)
+			break;
+		ptep++;
+		addr += PAGE_SIZE;
+	}
+}
+#endif
 
 /*
  * If two threads concurrently fault at the same page, the thread that
diff --git a/mm/memory.c b/mm/memory.c
index a2190d7cfa74..38a010c4d04d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1515,7 +1515,7 @@ static inline bool zap_drop_file_uffd_wp(struct zap_details *details)
  */
 static inline void
 zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
-			      unsigned long addr, pte_t *pte,
+			      unsigned long addr, pte_t *pte, int nr,
 			      struct zap_details *details, pte_t pteval)
 {
 	/* Zap on anonymous always means dropping everything */
@@ -1525,20 +1525,27 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 	if (zap_drop_file_uffd_wp(details))
 		return;
 
-	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
+	for (;;) {
+		/* the PFN in the PTE is irrelevant. */
+		pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
+		if (--nr == 0)
+			break;
+		pte++;
+		addr += PAGE_SIZE;
+	}
 }
 
-static inline void zap_present_folio_pte(struct mmu_gather *tlb,
+static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, struct folio *folio,
-		struct page *page, pte_t *pte, pte_t ptent, unsigned long addr,
-		struct zap_details *details, int *rss, bool *force_flush,
-		bool *force_break)
+		struct page *page, pte_t *pte, pte_t ptent, unsigned int nr,
+		unsigned long addr, struct zap_details *details, int *rss,
+		bool *force_flush, bool *force_break)
 {
 	struct mm_struct *mm = tlb->mm;
 	bool delay_rmap = false;
 
 	if (!folio_test_anon(folio)) {
-		ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
+		ptent = get_and_clear_full_ptes(mm, addr, pte, nr, tlb->fullmm);
 		if (pte_dirty(ptent)) {
 			folio_mark_dirty(folio);
 			if (tlb_delay_rmap(tlb)) {
@@ -1548,36 +1555,49 @@ static inline void zap_present_folio_pte(struct mmu_gather *tlb,
 		}
 		if (pte_young(ptent) && likely(vma_has_recency(vma)))
 			folio_mark_accessed(folio);
-		rss[mm_counter(folio)]--;
+		rss[mm_counter(folio)] -= nr;
 	} else {
 		/* We don't need up-to-date accessed/dirty bits. */
-		ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
-		rss[MM_ANONPAGES]--;
+		clear_full_ptes(mm, addr, pte, nr, tlb->fullmm);
+		rss[MM_ANONPAGES] -= nr;
 	}
+	/* Checking a single PTE in a batch is sufficient. */
 	arch_check_zapped_pte(vma, ptent);
-	tlb_remove_tlb_entry(tlb, pte, addr);
+	tlb_remove_tlb_entries(tlb, pte, nr, addr);
 	if (unlikely(userfaultfd_pte_wp(vma, ptent)))
-		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
+		zap_install_uffd_wp_if_needed(vma, addr, pte, nr, details,
+					      ptent);
 
 	if (!delay_rmap) {
-		folio_remove_rmap_pte(folio, page, vma);
+		folio_remove_rmap_ptes(folio, page, nr, vma);
+
+		/* Only sanity-check the first page in a batch. */
 		if (unlikely(page_mapcount(page) < 0))
 			print_bad_pte(vma, addr, ptent, page);
 	}
-	if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
+	if (unlikely(__tlb_remove_folio_pages(tlb, page, nr, delay_rmap))) {
 		*force_flush = true;
 		*force_break = true;
 	}
 }
 
-static inline void zap_present_pte(struct mmu_gather *tlb,
+/*
+ * Zap or skip one present PTE, trying to batch-process subsequent PTEs that map
+ * consecutive pages of the same folio.
+ *
+ * Returns the number of processed (skipped or zapped) PTEs (at least 1).
+ */
+static inline int zap_present_ptes(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, pte_t *pte, pte_t ptent,
-		unsigned long addr, struct zap_details *details,
-		int *rss, bool *force_flush, bool *force_break)
+		unsigned int max_nr, unsigned long addr,
+		struct zap_details *details, int *rss, bool *force_flush,
+		bool *force_break)
 {
+	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
 	struct mm_struct *mm = tlb->mm;
 	struct folio *folio;
 	struct page *page;
+	int nr;
 
 	page = vm_normal_page(vma, addr, ptent);
 	if (!page) {
@@ -1587,14 +1607,29 @@ static inline void zap_present_pte(struct mmu_gather *tlb,
 		tlb_remove_tlb_entry(tlb, pte, addr);
 		VM_WARN_ON_ONCE(userfaultfd_wp(vma));
 		ksm_might_unmap_zero_page(mm, ptent);
-		return;
+		return 1;
 	}
 
 	folio = page_folio(page);
 	if (unlikely(!should_zap_folio(details, folio)))
-		return;
-	zap_present_folio_pte(tlb, vma, folio, page, pte, ptent, addr, details,
-			      rss, force_flush, force_break);
+		return 1;
+
+	/*
+	 * Make sure that the common "small folio" case is as fast as possible
+	 * by keeping the batching logic separate.
+	 */
+	if (unlikely(folio_test_large(folio) && max_nr != 1)) {
+		nr = folio_pte_batch(folio, addr, pte, ptent, max_nr, fpb_flags,
+				     NULL);
+
+		zap_present_folio_ptes(tlb, vma, folio, page, pte, ptent, nr,
+				       addr, details, rss, force_flush,
+				       force_break);
+		return nr;
+	}
+	zap_present_folio_ptes(tlb, vma, folio, page, pte, ptent, 1, addr,
+			       details, rss, force_flush, force_break);
+	return 1;
 }
 
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
@@ -1609,6 +1644,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	pte_t *start_pte;
 	pte_t *pte;
 	swp_entry_t entry;
+	int nr;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	init_rss_vec(rss);
@@ -1622,7 +1658,9 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		pte_t ptent = ptep_get(pte);
 		struct folio *folio = NULL;
 		struct page *page;
+		int max_nr;
 
+		nr = 1;
 		if (pte_none(ptent))
 			continue;
 
@@ -1630,10 +1668,12 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			break;
 
 		if (pte_present(ptent)) {
-			zap_present_pte(tlb, vma, pte, ptent, addr, details,
-					rss, &force_flush, &force_break);
+			max_nr = (end - addr) / PAGE_SIZE;
+			nr = zap_present_ptes(tlb, vma, pte, ptent, max_nr,
+					      addr, details, rss, &force_flush,
+					      &force_break);
 			if (unlikely(force_break)) {
-				addr += PAGE_SIZE;
+				addr += nr * PAGE_SIZE;
 				break;
 			}
 			continue;
@@ -1687,8 +1727,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			WARN_ON_ONCE(1);
 		}
 		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
-		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+		zap_install_uffd_wp_if_needed(vma, addr, pte, 1, details, ptent);
+	} while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
 
 	add_mm_rss_vec(mm, rss);
 	arch_leave_lazy_mmu_mode();
-- 
2.43.0


