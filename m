Return-Path: <linux-s390+bounces-22240-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z5PxOktCVmpb2QAAu9opvQ
	(envelope-from <linux-s390+bounces-22240-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:06:03 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9667557C3
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:06:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b="Bm1/z7nw";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22240-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-22240-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C51F300914E
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 14:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16B247D93F;
	Tue, 14 Jul 2026 14:05:35 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C6043F8AF;
	Tue, 14 Jul 2026 14:05:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037935; cv=none; b=DBq+JYZeH/Vaf8JyVSfwKZeA+icRFWqgr5f1/BwMWAyWkKke85LYt6kQ0Iatihz2+f9Ojy1xec9rnHxD60BFPR4cMT2h46INUR1cMAlxx+Ahsp7Q8oyMRmUMNKWX4xliIWxVxw0kqGm2CHB3/HkMlyzLYY9O+NJ+tuLQCtGSee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037935; c=relaxed/simple;
	bh=FInc2gTxhVQc4LYtwtKoJPw43dSvFTnMs+LPVQ5s9u0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EG10cxRB8Da6rsROWmwzv5EQ6K9aYuiY3wrvsLA42nMkUPNo5NCIVbuzLCF1aMP8OF7DYyMBpMk3kZvjItG+Wz3orBMH0JmZa0xw0IJnybVRZhUPhBaU8dfj3D1TznIsI97ZlkMKukWxRktIPNa5Ahs8aRF8SeTFkZyh5Sx0KgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Bm1/z7nw; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DB181516;
	Tue, 14 Jul 2026 07:05:29 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECA813F7B4;
	Tue, 14 Jul 2026 07:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784037933; bh=FInc2gTxhVQc4LYtwtKoJPw43dSvFTnMs+LPVQ5s9u0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bm1/z7nw3ZrVQHSoXKrtxTQs91wc4RUrXfic6nvC1VPB3At2KepfWXr7Aw3HYFpkn
	 ioHo5OCLJkJiU6MHz48diP4nr6YFWtjQg3UL72aeFoQQSfWxPSBxVE10gNTyxwI//k
	 BrtCJZVqyK4Ji57oD58xPcYajyNM3z8AN78Fhrlw=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:03:52 +0100
Subject: [PATCH 03/22] mm: introduce MMF_KERNEL flag and set it for init_mm
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-remove_pgtable_cdtor-v1-3-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=2504;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=FInc2gTxhVQc4LYtwtKoJPw43dSvFTnMs+LPVQ5s9u0=;
 b=LLyApQy3cCX+sEK7+yEv+wdSQwFfqhZ/PtGYmJI+JJbZMoulhtvHZSYrG2onhzlRcBnCeJhTe
 oQ14mia3FhGBEfCDsSpVX5EPWBdyUPXpBCd8WmZOxEP54NLEVWz9CaD
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,linux-foundation.org,kernel.org,infradead.org,google.com,suse.com,soleen.com,armlinux.org.uk,lists.infradead.org,lists.linux.dev,HansenPartnership.com,gmx.de,vger.kernel.org,linux.ibm.com,ellerman.id.au,lists.ozlabs.org,dabbelt.com,eecs.berkeley.edu,davemloft.net,gaisler.com,nod.at,cambridgegreys.com,sipsolutions.net,redhat.com,alien8.de,linux.intel.com,zytor.com,intel.com,lists.sourceforge.net,linaro.org,gmail.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22240-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[58];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:from_mime,arm.com:mid,arm.com:email,arm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A9667557C3

mm code often needs to know whether some mm represents a kernel or
user address space. This is currently done by comparing the mm
pointer with &init_mm; besides not being particularly elegant, this
ignores the fact that other mm's (e.g. efi_mm) may also represent
parts of the kernel address space.

Introduce a new mm flag MMF_KERNEL and set it for init_mm.
Subsequent patches will use this flag to replace comparisons with
&init_mm. No functional change is introduced for now.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/mm_types.h | 10 ++++++++++
 mm/init-mm.c             |  1 +
 2 files changed, 11 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a2e0dc5892ff..7838ea3aac00 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1414,6 +1414,8 @@ struct mm_struct {
 	char flexible_array[] __aligned(__alignof__(unsigned long));
 };
 
+#define MM_FLAGS_INIT(flags)	{ .__mm_flags = { BITMAP_FROM_U64(flags) } }
+
 static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
 {
 	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
@@ -2001,6 +2003,9 @@ enum {
 #define MMF_TOPDOWN		31	/* mm searches top down by default */
 #define MMF_TOPDOWN_MASK	BIT(MMF_TOPDOWN)
 
+#define MMF_KERNEL		32	/* mm belongs to the kernel */
+#define MMF_KERNEL_MASK		BIT_ULL(MMF_KERNEL)
+
 #define MMF_INIT_LEGACY_MASK	(MMF_DUMP_FILTER_MASK |\
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
 				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
@@ -2008,6 +2013,11 @@ enum {
 /* Legacy flags must fit within 32 bits. */
 static_assert((u64)MMF_INIT_LEGACY_MASK <= (u64)UINT_MAX);
 
+static inline bool mm_is_kernel(const struct mm_struct *mm)
+{
+	return mm && mm_flags_test(MMF_KERNEL, mm);
+}
+
 /*
  * Initialise legacy flags according to masks, propagating selected flags on
  * fork. Further flag manipulation can be performed by the caller.
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 3e792aad7626..93773269bf87 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -34,6 +34,7 @@ struct mm_struct init_mm = {
 	.pgd		= swapper_pg_dir,
 	.mm_users	= ATOMIC_INIT(2),
 	.mm_count	= ATOMIC_INIT(1),
+	.flags		= MM_FLAGS_INIT(MMF_KERNEL_MASK),
 	.write_protect_seq = SEQCNT_ZERO(init_mm.write_protect_seq),
 	MMAP_LOCK_INITIALIZER(init_mm)
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),

-- 
2.51.2


