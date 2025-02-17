Return-Path: <linux-s390+bounces-9029-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B4AA38C11
	for <lists+linux-s390@lfdr.de>; Mon, 17 Feb 2025 20:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B21188784A
	for <lists+linux-s390@lfdr.de>; Mon, 17 Feb 2025 19:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A453E236A9F;
	Mon, 17 Feb 2025 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nbrWGX9N"
X-Original-To: linux-s390@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7602123718F;
	Mon, 17 Feb 2025 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819325; cv=none; b=HpRSGOg/NIv5AsDwyOlG/64kNl23/SQWWB9tassElTdV/GUSkGrcd4X/Qa5WobJfU7lyrCsyzZZqRZBfx3hUduugA56urK9evQwKoCXhB45u7gWoFbT7oVtH9OCyHGatAnZSUdWX6BuqdbgHuPS1Ef1HArroZTMxi3TuR5VpeXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819325; c=relaxed/simple;
	bh=3Yqsg1FdAAVQB+GQurmWuiUx3D0SW+zk6WFKS26Zzsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTDlrVvGodv/R3855hRs97zgwKymOsIq45HyRnVJBxFOYRwFWoHS/ZIqgRwW2LyTIETWDlF+INeo0Y+JS4ggtPpVG9W/QCvgHQErAzupqQ6QXWzPrMOjHiM5BaSP4U4GciJ3sf2CCpMuKz2nSErpwkYHFjB163C9tBYFcUH5S0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nbrWGX9N; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=YrjyUBt/jPWMpLQ4u9XWRkTeXfHbGxT9tJvSkCzHi+Y=; b=nbrWGX9NUujeOLaQPWifJH3KhX
	M0n2DFCnUimuNgcnma8CSZfUn6TbHsYNLww8CWwKb78ZGQCCjy+Z9546yArOBRhEtZdujxmm6qwHf
	6LCA+zUaRfoReWZG6XftJ+vs9y+Thz/d0xfT7663zfF159bo2etRsxPXPTHxf3Ntb5uwcMKc/NJdW
	QiW//7fUPE53dlmPdOH4Ujhc649BNPAYLFp1xZwoogMZbBrdraGw18CFarWCSo5ODRYe420itA9Ri
	iG7U4Ux4d4aIjrv6GNPkwQwcYps+bQlrumL+YpzxY1bj7rckFwZjCisf9+9t2n/WGANnDbWT/+5sd
	isRJb0Wg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6Tu-00000001pBF-32Qn;
	Mon, 17 Feb 2025 19:08:38 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arch@vger.kernel.org,
	x86@kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH 2/7] mm: Introduce a common definition of mk_pte()
Date: Mon, 17 Feb 2025 19:08:29 +0000
Message-ID: <20250217190836.435039-3-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217190836.435039-1-willy@infradead.org>
References: <20250217190836.435039-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most architectures simply call pfn_pte().  Centralise that as the normal
definition and remove the definition of mk_pte() from the architectures
which have either that exact definition or something similar.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/alpha/include/asm/pgtable.h         | 7 -------
 arch/arc/include/asm/pgtable-levels.h    | 1 -
 arch/arm/include/asm/pgtable.h           | 1 -
 arch/arm64/include/asm/pgtable.h         | 6 ------
 arch/csky/include/asm/pgtable.h          | 5 -----
 arch/hexagon/include/asm/pgtable.h       | 3 ---
 arch/loongarch/include/asm/pgtable.h     | 6 ------
 arch/m68k/include/asm/mcf_pgtable.h      | 6 ------
 arch/m68k/include/asm/motorola_pgtable.h | 6 ------
 arch/m68k/include/asm/sun3_pgtable.h     | 6 ------
 arch/microblaze/include/asm/pgtable.h    | 8 --------
 arch/mips/include/asm/pgtable.h          | 6 ------
 arch/nios2/include/asm/pgtable.h         | 6 ------
 arch/openrisc/include/asm/pgtable.h      | 2 --
 arch/parisc/include/asm/pgtable.h        | 6 ------
 arch/powerpc/include/asm/pgtable.h       | 3 +--
 arch/riscv/include/asm/pgtable.h         | 2 --
 arch/s390/include/asm/pgtable.h          | 5 -----
 arch/sh/include/asm/pgtable_32.h         | 8 --------
 arch/sparc/include/asm/pgtable_64.h      | 1 -
 arch/xtensa/include/asm/pgtable.h        | 6 ------
 include/linux/mm.h                       | 9 +++++++++
 22 files changed, 10 insertions(+), 99 deletions(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 02e8817a8921..2676017f42f1 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -192,13 +192,6 @@ extern unsigned long __zero_page(void);
 #define pte_pfn(pte)		(pte_val(pte) >> PFN_PTE_SHIFT)
 
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
-#define mk_pte(page, pgprot)						\
-({									\
-	pte_t pte;							\
-									\
-	pte_val(pte) = (page_to_pfn(page) << 32) | pgprot_val(pgprot);	\
-	pte;								\
-})
 
 extern inline pte_t pfn_pte(unsigned long physpfn, pgprot_t pgprot)
 { pte_t pte; pte_val(pte) = (PHYS_TWIDDLE(physpfn) << 32) | pgprot_val(pgprot); return pte; }
diff --git a/arch/arc/include/asm/pgtable-levels.h b/arch/arc/include/asm/pgtable-levels.h
index 86e148226463..55dbd2719e35 100644
--- a/arch/arc/include/asm/pgtable-levels.h
+++ b/arch/arc/include/asm/pgtable-levels.h
@@ -177,7 +177,6 @@
 #define set_pte(ptep, pte)	((*(ptep)) = (pte))
 #define pte_pfn(pte)		(pte_val(pte) >> PAGE_SHIFT)
 #define pfn_pte(pfn, prot)	__pte(__pfn_to_phys(pfn) | pgprot_val(prot))
-#define mk_pte(page, prot)	pfn_pte(page_to_pfn(page), prot)
 
 #ifdef CONFIG_ISA_ARCV2
 #define pmd_leaf(x)		(pmd_val(x) & _PAGE_HW_SZ)
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index be91e376df79..74c3b5a6eab3 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -169,7 +169,6 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 #define pfn_pte(pfn,prot)	__pte(__pfn_to_phys(pfn) | pgprot_val(prot))
 
 #define pte_page(pte)		pfn_to_page(pte_pfn(pte))
-#define mk_pte(page,prot)	pfn_pte(page_to_pfn(page), prot)
 
 #define pte_clear(mm,addr,ptep)	set_pte_ext(ptep, __pte(0), 0)
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0b2a2ad1b9e8..64b469d799c6 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -793,12 +793,6 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 /* use ONLY for statically allocated translation tables */
 #define pte_offset_kimg(dir,addr)	((pte_t *)__phys_to_kimg(pte_offset_phys((dir), (addr))))
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-#define mk_pte(page,prot)	pfn_pte(page_to_pfn(page),prot)
-
 #if CONFIG_PGTABLE_LEVELS > 2
 
 #define pmd_ERROR(e)	\
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index a397e1718ab6..b8378431aeff 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -249,11 +249,6 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
 	return __pgprot(prot);
 }
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-#define mk_pte(page, pgprot)    pfn_pte(page_to_pfn(page), (pgprot))
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index 8c5b7a1c3d90..9fbdfdbc539f 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -238,9 +238,6 @@ static inline int pte_present(pte_t pte)
 	return pte_val(pte) & _PAGE_PRESENT;
 }
 
-/* mk_pte - make a PTE out of a page pointer and protection bits */
-#define mk_pte(page, pgprot) pfn_pte(page_to_pfn(page), (pgprot))
-
 /* pte_page - returns a page (frame pointer/descriptor?) based on a PTE */
 #define pte_page(x) pfn_to_page(pte_pfn(x))
 
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index da346733a1da..9ba3a4ebcd98 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -426,12 +426,6 @@ static inline unsigned long pte_accessible(struct mm_struct *mm, pte_t a)
 	return false;
 }
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-#define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
index 48f87a8a8832..f5c596b211d4 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -96,12 +96,6 @@
 
 #define pmd_pgtable(pmd) pfn_to_virt(pmd_val(pmd) >> PAGE_SHIFT)
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-#define mk_pte(page, pgprot) pfn_pte(page_to_pfn(page), (pgprot))
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pte_val(pte) = (pte_val(pte) & CF_PAGE_CHG_MASK) | pgprot_val(newprot);
diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
index 9866c7acdabe..040ac3bad713 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -81,12 +81,6 @@ extern unsigned long mm_cachebits;
 
 #define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-#define mk_pte(page, pgprot) pfn_pte(page_to_pfn(page), (pgprot))
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot);
diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/sun3_pgtable.h
index 30081aee8164..73745dc0ec0e 100644
--- a/arch/m68k/include/asm/sun3_pgtable.h
+++ b/arch/m68k/include/asm/sun3_pgtable.h
@@ -76,12 +76,6 @@
 
 #ifndef __ASSEMBLY__
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-#define mk_pte(page, pgprot) pfn_pte(page_to_pfn(page), (pgprot))
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pte_val(pte) = (pte_val(pte) & SUN3_PAGE_CHG_MASK) | pgprot_val(newprot);
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index e4ea2ec3642f..b1bb2c65dd04 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -285,14 +285,6 @@ static inline pte_t mk_pte_phys(phys_addr_t physpage, pgprot_t pgprot)
 	return pte;
 }
 
-#define mk_pte(page, pgprot) \
-({									   \
-	pte_t pte;							   \
-	pte_val(pte) = (((page - mem_map) << PAGE_SHIFT) + memory_start) |  \
-			pgprot_val(pgprot);				   \
-	pte;								   \
-})
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot);
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index c29a551eb0ca..d69cfa5a8ac6 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -504,12 +504,6 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 	return true;
 }
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-#define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
-
 #if defined(CONFIG_XPA)
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index eab87c6beacb..f490f2fa0dca 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -217,12 +217,6 @@ static inline void pte_clear(struct mm_struct *mm,
 	set_pte(ptep, null);
 }
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-#define mk_pte(page, prot)	(pfn_pte(page_to_pfn(page), prot))
-
 /*
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 60c6ce7ff2dc..71bfb8c8c482 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -299,8 +299,6 @@ static inline pte_t __mk_pte(void *page, pgprot_t pgprot)
 	return pte;
 }
 
-#define mk_pte(page, pgprot) __mk_pte(page_address(page), (pgprot))
-
 #define mk_pte_phys(physpage, pgprot) \
 ({                                                                      \
 	pte_t __pte;                                                    \
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index babf65751e81..e85963fefa63 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -338,10 +338,6 @@ static inline pte_t pte_mkspecial(pte_t pte)	{ pte_val(pte) |= _PAGE_SPECIAL; re
 #endif
 
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
 #define __mk_pte(addr,pgprot) \
 ({									\
 	pte_t __pte;							\
@@ -351,8 +347,6 @@ static inline pte_t pte_mkspecial(pte_t pte)	{ pte_val(pte) |= _PAGE_SPECIAL; re
 	__pte;								\
 })
 
-#define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
-
 static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
 {
 	pte_t pte;
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 2f72ad885332..93d77ad5a92f 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -53,9 +53,8 @@ void set_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 #define MAX_PTRS_PER_PGD PTRS_PER_PGD
 #endif
 
-/* Keep these as a macros to avoid include dependency mess */
+/* Keep this as a macro to avoid include dependency mess */
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
-#define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
 
 static inline unsigned long pte_pfn(pte_t pte)
 {
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 050fdc49b5ad..293a7776fe07 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -339,8 +339,6 @@ static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
 	return __pte((pfn << _PAGE_PFN_SHIFT) | prot_val);
 }
 
-#define mk_pte(page, prot)       pfn_pte(page_to_pfn(page), prot)
-
 static inline int pte_present(pte_t pte)
 {
 	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE));
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 3ee495b5171e..db932beabc87 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1449,11 +1449,6 @@ static inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
 	return pte_mkyoung(__pte);
 }
 
-static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
-{
-	return mk_pte_phys(page_to_phys(page), pgprot);
-}
-
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 #define p4d_index(address) (((address) >> P4D_SHIFT) & (PTRS_PER_P4D-1))
 #define pud_index(address) (((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index f939f1215232..db2e48366e0d 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -380,14 +380,6 @@ PTE_BIT_FUNC(low, mkspecial, |= _PAGE_SPECIAL);
 
 #define pgprot_noncached	 pgprot_writecombine
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- *
- * extern pte_t mk_pte(struct page *page, pgprot_t pgprot)
- */
-#define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	pte.pte_low &= _PAGE_CHG_MASK;
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 2b7f358762c1..ac115adb488f 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -225,7 +225,6 @@ static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
 	BUILD_BUG_ON(_PAGE_SZBITS_4U != 0UL || _PAGE_SZBITS_4V != 0UL);
 	return __pte(paddr | pgprot_val(prot));
 }
-#define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index 1647a7cc3fbf..cb1725c40e36 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -269,17 +269,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 		((__pgprot((pgprot_val(prot) & ~_PAGE_CA_MASK) | \
 			   _PAGE_CA_BYPASS)))
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-
 #define PFN_PTE_SHIFT		PAGE_SHIFT
 #define pte_pfn(pte)		(pte_val(pte) >> PAGE_SHIFT)
 #define pte_same(a,b)		(pte_val(a) == pte_val(b))
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 #define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
-#define mk_pte(page, prot)	pfn_pte(page_to_pfn(page), prot)
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..3ef11ff3922f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1916,6 +1916,15 @@ static inline struct folio *pfn_folio(unsigned long pfn)
 	return page_folio(pfn_to_page(pfn));
 }
 
+#ifndef mk_pte
+#ifdef CONFIG_MMU
+static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
+{
+	return pfn_pte(page_to_pfn(page), pgprot);
+}
+#endif
+#endif
+
 /**
  * folio_maybe_dma_pinned - Report if a folio may be pinned for DMA.
  * @folio: The folio.
-- 
2.47.2


