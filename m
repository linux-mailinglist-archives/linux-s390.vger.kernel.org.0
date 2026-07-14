Return-Path: <linux-s390+bounces-22245-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FyU0KURGVmqp2gAAu9opvQ
	(envelope-from <linux-s390+bounces-22245-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:23:00 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AF5755BCF
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:23:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=UsBpoovP;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22245-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-22245-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABB08315F1EA
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 14:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFC747DD6B;
	Tue, 14 Jul 2026 14:06:14 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B728847D94D;
	Tue, 14 Jul 2026 14:06:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037974; cv=none; b=SL6Iok1f+jzxnLQPuTtMdgyrw1wObwY9RxQCmRxpT73ybUwPN4vgU6tJdfgoKlPM9v1LcDOSfHKB8rbh42mfnhnB0F0AZNHfMQthPc+XyuepJnbp9xuvTv+UGRrY2q9tKmTFqapWRpL39vJMfvYaGK6USBiTFrIFEJfmSmKBaB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037974; c=relaxed/simple;
	bh=wjWPKE4gokVm0n43Fz8OrYiTdEX4ZJIt+9rA3rzslZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rw6w7MZJbACmuJgp4s+3IwRtl2R86wwVcDiDfv0+MRpASFYvJtjJ97K/FXDFxeXTEyljNPK+372X6fImBtu8thzzH9s5cSuj+RuvsLdXGjF9CUkcHoTFF//gIUdgWgPW9fhIMFkO6O5rU7wu1Oa2gbyV7eEUs2pPzV4lJ43oG+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UsBpoovP; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBABA1576;
	Tue, 14 Jul 2026 07:06:07 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 923CB3F7B4;
	Tue, 14 Jul 2026 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784037972; bh=wjWPKE4gokVm0n43Fz8OrYiTdEX4ZJIt+9rA3rzslZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UsBpoovPpZ85RSIZfXEnSBfVHOZtFnPkX47Kj5gg3LsgzJNhCVgTUWCtTOeVOPaNp
	 HKjlV2fnQGGYMeGqcjyozlJa7a3QA1IlDMrT8hf3JRzN2w2i+9FSRlqOzr8/QB6/Qf
	 Q0z0BAmzTk1fTpNEZ3NiarWVCe9KoxmszHFZ5aSw=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:03:57 +0100
Subject: [PATCH 08/22] powerpc: mm: use mm_is_kernel() for kernel mm checks
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-remove_pgtable_cdtor-v1-8-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=2458;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=wjWPKE4gokVm0n43Fz8OrYiTdEX4ZJIt+9rA3rzslZA=;
 b=mGXIMwx7mP+wc+PdjO+ERefisoZsiZf5NJNBVQYllixOIGkiZykJ/6wIrBXI36cbJ4lbGAtZA
 wL42KEsLctGAHh95szgDEyWgp6+51aO6Iy65UQOmRkiEbYbzhv701ws
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,linux-foundation.org,kernel.org,infradead.org,google.com,suse.com,soleen.com,armlinux.org.uk,lists.infradead.org,lists.linux.dev,HansenPartnership.com,gmx.de,vger.kernel.org,linux.ibm.com,ellerman.id.au,lists.ozlabs.org,dabbelt.com,eecs.berkeley.edu,davemloft.net,gaisler.com,nod.at,cambridgegreys.com,sipsolutions.net,redhat.com,alien8.de,linux.intel.com,zytor.com,intel.com,lists.sourceforge.net,linaro.org,gmail.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22245-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[58];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:from_mime,arm.com:mid,arm.com:email,arm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46AF5755BCF

The new MMF_KERNEL flag identifies kernel-owned mm's. Checking the
flag with mm_is_kernel() is preferred over comparing directly
against &init_mm.

No functional change, as only init_mm has MMF_KERNEL set for now.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/powerpc/include/asm/pgalloc.h | 2 +-
 arch/powerpc/mm/book3s64/pgtable.c | 2 +-
 arch/powerpc/mm/mmu_context.c      | 2 +-
 arch/powerpc/mm/pgtable.c          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
index 3a971e2a8c73..88acccc5b06e 100644
--- a/arch/powerpc/include/asm/pgalloc.h
+++ b/arch/powerpc/include/asm/pgalloc.h
@@ -7,7 +7,7 @@
 #ifndef MODULE
 static inline gfp_t pgtable_gfp_flags(struct mm_struct *mm, gfp_t gfp)
 {
-	if (unlikely(mm == &init_mm))
+	if (unlikely(mm_is_kernel(mm)))
 		return gfp;
 	return gfp | __GFP_ACCOUNT;
 }
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 85ab6723c8f2..eb365f7c8907 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -395,7 +395,7 @@ static pmd_t *__alloc_for_pmdcache(struct mm_struct *mm)
 	struct ptdesc *ptdesc;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO;
 
-	if (mm == &init_mm)
+	if (mm_is_kernel(mm))
 		gfp &= ~__GFP_ACCOUNT;
 	ptdesc = pagetable_alloc(gfp, 0);
 	if (!ptdesc)
diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
index 3e3af29b4523..b51934c511f3 100644
--- a/arch/powerpc/mm/mmu_context.c
+++ b/arch/powerpc/mm/mmu_context.c
@@ -48,7 +48,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 
 	/* Mark this context has been used on the new CPU */
 	if (!cpumask_test_cpu(cpu, mm_cpumask(next))) {
-		VM_WARN_ON_ONCE(next == &init_mm);
+		VM_WARN_ON_ONCE(mm_is_kernel(next));
 		cpumask_set_cpu(cpu, mm_cpumask(next));
 		inc_mm_active_cpus(next);
 
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index a9be337be3e4..d04f4fecfc7c 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -393,7 +393,7 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 	pte_t *pte;
 	spinlock_t *ptl;
 
-	if (mm == &init_mm)
+	if (mm_is_kernel(mm))
 		return;
 	pgd = mm->pgd + pgd_index(addr);
 	BUG_ON(pgd_none(*pgd));

-- 
2.51.2


