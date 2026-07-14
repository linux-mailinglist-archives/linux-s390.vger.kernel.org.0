Return-Path: <linux-s390+bounces-22259-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UevLASNHVmrn2gAAu9opvQ
	(envelope-from <linux-s390+bounces-22259-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:26:43 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F165755CAB
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:26:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b="EkfHX0/w";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22259-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22259-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6654F34BE47A
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 14:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F76480DFC;
	Tue, 14 Jul 2026 14:08:12 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABB847F2F2;
	Tue, 14 Jul 2026 14:08:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038091; cv=none; b=ozt3pGhytdQC3E/wBke/YHc9XJ7XvJWJPlJzOxH9wcTv7vQU/3cBpFjQFPadFsRjQUyR7BAFP21XBYqTzazAjOufBZVroLUOMyN6BlCsPhTVa3vNwKpxrTzaXwvPLVwQarGGuQnWFv5WQXuJY1q/95gZdP12LDjpHfznK7NOBLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038091; c=relaxed/simple;
	bh=DQUlXrijxnSdwAI1lj2qunwwpXAiVnOlOXfc6mAyMUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JlYmx1Nho5fHwhe4FaMs+gXIn1Tx5o9vLuUZPpGRmvbCflykiXfJrTtomxaLAjtH+agJE4DpWg6mPrJ1AgZBxbu0hAzxwJuL2kTqU3ooP6e2coxP/1RsLdgcuHVryTqsEB2+Y8htRXV6ASyeRABnak0KPpSvTSfEWsRH3xb5xJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EkfHX0/w; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1C871DB5;
	Tue, 14 Jul 2026 07:07:55 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB5033F7B4;
	Tue, 14 Jul 2026 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784038080; bh=DQUlXrijxnSdwAI1lj2qunwwpXAiVnOlOXfc6mAyMUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EkfHX0/wndT2DrIlt77R9MduZMLLVHV6MiJ4gGI5CEH0EicTnVS43outHXqKb+9XR
	 AJo1EcRXTyEDah4neKxKZTW1aJvelDeHIKrOeiwCxZJanpWn/hzIrUIMMzTmeF4J8v
	 WK5pqK4bemQaUXT1hIibNUiLONKFHv36szPAaSA8=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:04:11 +0100
Subject: [PATCH 22/22] riscv: mm: drop ctor/dtor calls for kernel page
 tables
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-remove_pgtable_cdtor-v1-22-44be8a7685d7@arm.com>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
In-Reply-To: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
To: linux-mm@kvack.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org, 
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linux-s390@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ning Sun <ning.sun@intel.com>, 
 x86@kernel.org, tboot-devel@lists.sourceforge.net, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org, 
 Vishal Moola <vishal.moola@gmail.com>, Alistair Popple <apopple@nvidia.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=5346;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=DQUlXrijxnSdwAI1lj2qunwwpXAiVnOlOXfc6mAyMUQ=;
 b=SSTFSwZEfFo/6gx/poI9v6VwC/hohk7MtYN3kR3x0tI9+lk1TLQ5HYY8/tkfxij+JZ0fxXtY7
 dmntRxFz1BYAc9h9Vd7P6X3RSa/wxA0dmIO24BbUkIFbso++KHmSKGI
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,linux-foundation.org,kernel.org,infradead.org,google.com,suse.com,soleen.com,armlinux.org.uk,lists.infradead.org,lists.linux.dev,HansenPartnership.com,gmx.de,vger.kernel.org,linux.ibm.com,ellerman.id.au,lists.ozlabs.org,dabbelt.com,eecs.berkeley.edu,davemloft.net,gaisler.com,nod.at,cambridgegreys.com,sipsolutions.net,redhat.com,alien8.de,linux.intel.com,zytor.com,intel.com,lists.sourceforge.net,linaro.org,gmail.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22259-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kevin.brodsky@arm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-mm@kvack.org,m:kevin.brodsky@arm.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:pasha.tatashin@soleen.com,m:linux@armlinux.org.uk,m:catalin.marinas@arm.com,m:will@kernel.org,m:ryan.roberts@arm.com,m:linux-arm-kernel@lists.infradead.org,m:chenhuacai@kernel.org,m:loongarch@lists.linux.dev,m:James.Bottomley@HansenPartnership.com,m:deller@gmx.de,m:linux-parisc@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:linuxppc-dev@lists.ozlabs.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:linux-riscv@lists.infradead.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:linux-s390@vger.kernel.org,m:davem@davemloft.net,m:andreas@gaisler.com,m:sparclinux@vger.kernel.org,m:richard@nod.at,m:anton.ivanov@cambridgegreys.com,m:johannes@sipsolutions.net,m:linux-um@lists.infr
 adead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:luto@kernel.org,m:peterz@infradead.org,m:ning.sun@intel.com,m:x86@kernel.org,m:tboot-devel@lists.sourceforge.net,m:ardb@kernel.org,m:ilias.apalodimas@linaro.org,m:linux-efi@vger.kernel.org,m:vishal.moola@gmail.com,m:apopple@nvidia.com,m:willy@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-arch@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kevin.brodsky@arm.com,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[58];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:from_mime,arm.com:mid,arm.com:email,arm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F165755CAB

Thanks to recent changes:

* pagetable_*_ctor() and pagetable_dtor() do nothing for kernel page
  tables.

* efi_mm is also treated like a kernel mm by the page table logic,
  including ctors.

We can therefore drop the calls to ctors when allocating special
kernel page tables in mmu.c, as well as the dtor call when freeing
hotplug page tables.

The alloc_*_late() helpers are all identical after removing the ctor
calls, so replace them with alloc_pgtable_late().

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/riscv/mm/init.c | 63 ++++++++++++----------------------------------------
 1 file changed, 14 insertions(+), 49 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 5b1b3c88b4d1..e823662be256 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -382,6 +382,14 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
 	local_flush_tlb_page(addr);
 }
 
+static phys_addr_t __meminit alloc_pgtable_late(uintptr_t va)
+{
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
+
+	BUG_ON(!ptdesc);
+	return __pa(ptdesc_address(ptdesc));
+}
+
 static inline pte_t *__init get_pte_virt_early(phys_addr_t pa)
 {
 	return (pte_t *)((uintptr_t)pa);
@@ -412,19 +420,6 @@ static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t __meminit alloc_pte_late(uintptr_t va)
-{
-	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
-
-	/*
-	 * We do not know which mm the PTE page is associated to at this point.
-	 * Passing NULL to the ctor is the safe option, though it may result
-	 * in unnecessary work (e.g. initialising the ptlock for init_mm).
-	 */
-	BUG_ON(!ptdesc || !pagetable_pte_ctor(NULL, ptdesc));
-	return __pa((pte_t *)ptdesc_address(ptdesc));
-}
-
 static void __meminit create_pte_mapping(pte_t *ptep, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
 					 pgprot_t prot)
 {
@@ -479,15 +474,6 @@ static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t __meminit alloc_pmd_late(uintptr_t va)
-{
-	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
-
-	/* See comment in alloc_pte_late() regarding NULL passed the ctor */
-	BUG_ON(!ptdesc || !pagetable_pmd_ctor(NULL, ptdesc));
-	return __pa((pmd_t *)ptdesc_address(ptdesc));
-}
-
 static void __meminit create_pmd_mapping(pmd_t *pmdp,
 					 uintptr_t va, phys_addr_t pa,
 					 phys_addr_t sz, pgprot_t prot)
@@ -544,15 +530,6 @@ static phys_addr_t __init alloc_pud_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t __meminit alloc_pud_late(uintptr_t va)
-{
-	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
-
-	BUG_ON(!ptdesc);
-	pagetable_pud_ctor(ptdesc);
-	return __pa((pud_t *)ptdesc_address(ptdesc));
-}
-
 static p4d_t *__init get_p4d_virt_early(phys_addr_t pa)
 {
 	return (p4d_t *)((uintptr_t)pa);
@@ -582,15 +559,6 @@ static phys_addr_t __init alloc_p4d_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t __meminit alloc_p4d_late(uintptr_t va)
-{
-	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, 0);
-
-	BUG_ON(!ptdesc);
-	pagetable_p4d_ctor(ptdesc);
-	return __pa((p4d_t *)ptdesc_address(ptdesc));
-}
-
 static void __meminit create_pud_mapping(pud_t *pudp, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
 					 pgprot_t prot)
 {
@@ -1003,14 +971,14 @@ static void __init pt_ops_set_fixmap(void)
  */
 static void __init pt_ops_set_late(void)
 {
-	pt_ops.alloc_pte = alloc_pte_late;
+	pt_ops.alloc_pte = alloc_pgtable_late;
 	pt_ops.get_pte_virt = get_pte_virt_late;
 #ifndef __PAGETABLE_PMD_FOLDED
-	pt_ops.alloc_pmd = alloc_pmd_late;
+	pt_ops.alloc_pmd = alloc_pgtable_late;
 	pt_ops.get_pmd_virt = get_pmd_virt_late;
-	pt_ops.alloc_pud = alloc_pud_late;
+	pt_ops.alloc_pud = alloc_pgtable_late;
 	pt_ops.get_pud_virt = get_pud_virt_late;
-	pt_ops.alloc_p4d = alloc_p4d_late;
+	pt_ops.alloc_p4d = alloc_pgtable_late;
 	pt_ops.get_p4d_virt = get_p4d_virt_late;
 #endif
 }
@@ -1488,7 +1456,6 @@ static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
 			return;
 	}
 
-	pagetable_dtor(ptdesc);
 	if (PageReserved(page))
 		free_reserved_page(page);
 	else
@@ -1496,7 +1463,7 @@ static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
 	pmd_clear(pmd);
 }
 
-static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud, bool is_vmemmap)
+static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
 {
 	struct page *page = pud_page(*pud);
 	struct ptdesc *ptdesc = page_ptdesc(page);
@@ -1509,8 +1476,6 @@ static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud, bool is_vmemm
 			return;
 	}
 
-	if (!is_vmemmap)
-		pagetable_dtor(ptdesc);
 	if (PageReserved(page))
 		free_reserved_page(page);
 	else
@@ -1634,7 +1599,7 @@ static void __meminit remove_pud_mapping(pud_t *pud_base, unsigned long addr, un
 		remove_pmd_mapping(pmd_base, addr, next, is_vmemmap, altmap);
 
 		if (pgtable_l4_enabled)
-			free_pmd_table(pmd_base, pudp, is_vmemmap);
+			free_pmd_table(pmd_base, pudp);
 	}
 }
 

-- 
2.51.2


