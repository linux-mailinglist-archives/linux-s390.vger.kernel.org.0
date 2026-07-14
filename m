Return-Path: <linux-s390+bounces-22246-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2xn+IVhGVmqs2gAAu9opvQ
	(envelope-from <linux-s390+bounces-22246-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:23:20 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1C0755BDB
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:23:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=g68p8jn2;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22246-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22246-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09CF032F4876
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 14:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB01B47D95E;
	Tue, 14 Jul 2026 14:06:21 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B8547D931;
	Tue, 14 Jul 2026 14:06:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037981; cv=none; b=S+JQKclxjjfhhhFAtJD2EAMT6lCaHTncKrsrTs1Br/3V6fmNh2PbU/JpySfa8zw2vzfyuITfDEGl37auJ+r6vnlo96b19lOLf1RzHrBXS87LVDkChTUi/tEVQvCbZdr/tVcsPbIlFQiNkkqmy6MuihzaNezuivFeHUqYnyRnBM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037981; c=relaxed/simple;
	bh=NDusZRNCWoEozZsjG5aWosyCUDI8Y1KKdd/tV+nqCY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lH7Q43amPVPrBiVbRlr17kpUvc+HjxiTG+SlmZziwQbReWn6m/DyqGv7ajMlkKvhfiaIvukgXiBOPnNdrYBiT5ftn8WWJVsbJEV6xNVQrouCRnClf8VWxtapW0HZGPA7VYovsk0H75s/wUnDcG0ewNbmrFM+i/26Go9z09zdqIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=g68p8jn2; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78E4E1576;
	Tue, 14 Jul 2026 07:06:15 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FE263F7B4;
	Tue, 14 Jul 2026 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784037979; bh=NDusZRNCWoEozZsjG5aWosyCUDI8Y1KKdd/tV+nqCY0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g68p8jn2r/BRs15OVDSJM5PC0vX+xZEjL9qs6O4bNrlLAmFr23nxaTMwPJrtgFVSe
	 PO42BSv3F1n/0/KY29fSo68pViH3svUbemsg+2g8ZALHR7Gb34DvnaAe4yB7K0yUyn
	 X1Qg4PRgk23qfvxdXOP4RJxy06FeoAcjmt/U8Rmo=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:03:58 +0100
Subject: [PATCH 09/22] s390: mm: use mm_is_kernel() for kernel mm checks
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-remove_pgtable_cdtor-v1-9-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=2701;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=NDusZRNCWoEozZsjG5aWosyCUDI8Y1KKdd/tV+nqCY0=;
 b=EN7VJwlPWQ2mLOV0RQXIAGmFgLbZqozbS12jiAz8t5flCb4LBC8CQLf9qAbAsIdiWxuJ/h34z
 +bgdLqbZMrPAgQeOceVSuzYyrvq4LTVvYRTcF4wG9fcsRmwk6IO2SXA
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
	TAGGED_FROM(0.00)[bounces-22246-lists,linux-s390=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,arm.com:from_mime,arm.com:mid,arm.com:email,arm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC1C0755BDB

The new MMF_KERNEL flag identifies kernel-owned mm's. Checking the
flag with mm_is_kernel() is preferred over comparing directly
against &init_mm.

No functional change, as only init_mm has MMF_KERNEL set for now.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/s390/include/asm/mmu_context.h | 2 +-
 arch/s390/include/asm/pgtable.h     | 6 +++---
 arch/s390/mm/pgalloc.c              | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index bd1ef5e2d2eb..675f270d0b70 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -69,7 +69,7 @@ static inline void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *
 {
 	int cpu = smp_processor_id();
 
-	if (next == &init_mm)
+	if (mm_is_kernel(next))
 		get_lowcore()->user_asce = s390_invalid_asce;
 	else
 		get_lowcore()->user_asce.val = next->context.asce;
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index e882663a58e7..f7741e6b417e 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1836,21 +1836,21 @@ static inline int has_transparent_hugepage(void)
 #ifdef CONFIG_PAGE_TABLE_CHECK
 static inline bool pte_user_accessible_page(struct mm_struct *mm, unsigned long addr, pte_t pte)
 {
-	VM_BUG_ON(mm == &init_mm);
+	VM_BUG_ON(mm_is_kernel(mm));
 
 	return pte_present(pte);
 }
 
 static inline bool pmd_user_accessible_page(struct mm_struct *mm, unsigned long addr, pmd_t pmd)
 {
-	VM_BUG_ON(mm == &init_mm);
+	VM_BUG_ON(mm_is_kernel(mm));
 
 	return pmd_leaf(pmd) && (pmd_val(pmd) & _SEGMENT_ENTRY_READ);
 }
 
 static inline bool pud_user_accessible_page(struct mm_struct *mm, unsigned long addr, pud_t pud)
 {
-	VM_BUG_ON(mm == &init_mm);
+	VM_BUG_ON(mm_is_kernel(mm));
 
 	return pud_leaf(pud);
 }
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 7ac44543e051..d0456b7e73d4 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -20,7 +20,7 @@ unsigned long *crst_table_alloc_noprof(struct mm_struct *mm)
 	struct ptdesc *ptdesc;
 	unsigned long *table;
 
-	if (mm == &init_mm)
+	if (mm_is_kernel(mm))
 		gfp &= ~__GFP_ACCOUNT;
 	ptdesc = pagetable_alloc_noprof(gfp, CRST_ALLOC_ORDER);
 	if (!ptdesc)
@@ -120,7 +120,7 @@ unsigned long *page_table_alloc_noprof(struct mm_struct *mm)
 	struct ptdesc *ptdesc;
 	unsigned long *table;
 
-	if (mm == &init_mm)
+	if (mm_is_kernel(mm))
 		gfp &= ~__GFP_ACCOUNT;
 	ptdesc = pagetable_alloc_noprof(gfp, 0);
 	if (!ptdesc)

-- 
2.51.2


