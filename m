Return-Path: <linux-s390+bounces-22254-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AMfrNe9EVmo32gAAu9opvQ
	(envelope-from <linux-s390+bounces-22254-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:17:19 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 421CA755AA2
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:17:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=tcs2QjbO;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22254-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-22254-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9F41308C4D5
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 14:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB47F480970;
	Tue, 14 Jul 2026 14:07:24 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E2F47DD62;
	Tue, 14 Jul 2026 14:07:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038044; cv=none; b=ZStobTDGjRSvHCOZHECUWn2pfNynF8YBPaJ34ovaS2O4DV4zh2kaKQcYEP3gZyyXiQkvg9XlaLICc8nZiC3HbFr6z1FvhnPjgI4B+UWUrf78T7BEOcj3CN2jWTwTXawjtCio6hy2RYIumNh0NMbfnB7UrrhEr48uw9mN+f6pv6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038044; c=relaxed/simple;
	bh=W5yMHnXfWcnH1ZpiyUJxzPFiGyzR0nmofTO/4v3XglM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MlQTP0ZY+NjAEcSqlHGDQbM8wsSVTRfQ5ex43qh8btgsG/D/X/lbrsoTMSD4PlGrrLAXrSUUy0sSkVuMQbuluLRZve0TxBr9fkSAWGmXymwqufhupWFMwiZcXnuYCXSD/csPJpJuPbUqkPLjRSEp5QhpxiuEE1wmnZPSqbaB6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tcs2QjbO; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 485791C25;
	Tue, 14 Jul 2026 07:07:17 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 211913FBB1;
	Tue, 14 Jul 2026 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784038041; bh=W5yMHnXfWcnH1ZpiyUJxzPFiGyzR0nmofTO/4v3XglM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tcs2QjbOfi2UrOaEb3Be0yDpY6GZomCe7QbbhuAt79rvxsFv0nPzL+CWkgYpCVks/
	 ogkFHzzFifaJTeH1MCRm+XyD/611Im1Ut2kp5sQ9dzHO1o7eUkGFrrRiH6Z4V/RDtz
	 /vlFqoX8JwYVcEUc2qvYwpr+Gn4LoNg3DQ/uWfI4=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:04:06 +0100
Subject: [PATCH 17/22] mm: pagewalk: drop redundant address check for
 kernel mm walks
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-remove_pgtable_cdtor-v1-17-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=1902;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=W5yMHnXfWcnH1ZpiyUJxzPFiGyzR0nmofTO/4v3XglM=;
 b=TFBgeJD80Ix+w11MAOvfP3+Vh87dI14Hnq0FHr8NrSRBwD9XPKoZw/aAqVJc1+sG5OV8cIA+P
 hlg2L1E8nGiAdR9B4tzknmDLhA26Dhv64+3Fs4YGAcZ8Y3UcdoWIKP6
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,linux-foundation.org,kernel.org,infradead.org,google.com,suse.com,soleen.com,armlinux.org.uk,lists.infradead.org,lists.linux.dev,HansenPartnership.com,gmx.de,vger.kernel.org,linux.ibm.com,ellerman.id.au,lists.ozlabs.org,dabbelt.com,eecs.berkeley.edu,davemloft.net,gaisler.com,nod.at,cambridgegreys.com,sipsolutions.net,redhat.com,alien8.de,linux.intel.com,zytor.com,intel.com,lists.sourceforge.net,linaro.org,gmail.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22254-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_GT_50(0.00)[58];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,arm.com:from_mime,arm.com:mid,arm.com:email,arm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 421CA755AA2

Commit 8b1cb4a2e819 ("mm/pagewalk: fix EFI_PGT_DUMP of
espfix area") made no-VMA page table walks use
pte_offset_kernel() for any address above TASK_SIZE. This avoided
pte_offset_map() validation on EFI page table dumps, where efi_mm
could walk x86 espfix PMDs that intentionally look bad to pmd_bad().

efi_mm is now marked with MMF_KERNEL, and no-VMA walks use
mm_is_kernel() to select pte_offset_kernel() for kernel mm's. As a
result we no longer need to handle the EFI_PGT_DUMP case explicitly.The
address check is therefore redundant for EFI_PGT_DUMP and makes the
condition harder to reason about.

Remove the address check and associated comment; mm_is_kernel()
should be sufficient on its own.

Tested by booting x86 QEMU with CONFIG_EFI_PGT_DUMP=y and reading
/sys/kernel/debug/page_tables/efi.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 mm/pagewalk.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index a3f47d1de3c5..0dd9d4ad9b68 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -68,17 +68,14 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	if (walk->no_vma) {
 		/*
 		 * pte_offset_map() might apply user-specific validation.
-		 * Indeed, on x86_64 the pmd entries set up by init_espfix_ap()
-		 * fit its pmd_bad() check (_PAGE_NX set and _PAGE_RW clear),
-		 * and CONFIG_EFI_PGT_DUMP efi_mm goes so far as to walk them.
 		 */
-		if (mm_is_kernel(walk->mm) || addr >= TASK_SIZE)
+		if (mm_is_kernel(walk->mm))
 			pte = pte_offset_kernel(pmd, addr);
 		else
 			pte = pte_offset_map(pmd, addr);
 		if (pte) {
 			err = walk_pte_range_inner(pte, addr, end, walk);
-			if (!mm_is_kernel(walk->mm) && addr < TASK_SIZE)
+			if (!mm_is_kernel(walk->mm))
 				pte_unmap(pte);
 		}
 	} else {

-- 
2.51.2


