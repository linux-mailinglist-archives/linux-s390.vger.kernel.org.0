Return-Path: <linux-s390+bounces-22239-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H6DRI/ZFVmqU2gAAu9opvQ
	(envelope-from <linux-s390+bounces-22239-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:21:42 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14535755B8E
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:21:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b="L/UyKrDH";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22239-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22239-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 167DC30A1CB3
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 14:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC0747D922;
	Tue, 14 Jul 2026 14:05:28 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4198447D921;
	Tue, 14 Jul 2026 14:05:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037928; cv=none; b=KkV8MmsFhz+zFygW9USYd175yvLipw1vwSu18jUH0j61z8oJAbdoFsNr1wppztPUsCgxgA0GUaj3ub7ZLC/SdlhKfGPibDRIzKcACGUh/NzGH+kp7bFdf0SZmN7AlvSCCmUApHNg41H52jOL+dMmZFxB/33VxJ+dcFLVHSDGYLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037928; c=relaxed/simple;
	bh=xWJCKsvCSbOTf1MrL+nqfsWcuzx4IBI4MMfjRE6PTH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AE3iFcNViK58TP2en4quy+k4RhoootMeyU/YnlM8g9mEs7ugJi06NHiGDf4zYlG4wANLP60k/9cVBjKaYsov54+hFAoZ3gD4XQT9rFXOumWztwFBq6WdVUxnsteSwEW+yNSJL/P710xK9jwsyQwgO/c+UL8B66WUADC2Gj8iDYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=L/UyKrDH; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6425C1516;
	Tue, 14 Jul 2026 07:05:21 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A07F3F7B4;
	Tue, 14 Jul 2026 07:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784037925; bh=xWJCKsvCSbOTf1MrL+nqfsWcuzx4IBI4MMfjRE6PTH4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L/UyKrDH31P2AxfsB5zaY1mh6o9sykjNj6yB/yMXG8ePSNTlccGqvWENIvdaG1tfJ
	 Wk0YZEQWyX1mVS8XhODJBz5n9MI25kkc+YIk8/N9y9yuoLWoSBYTDhb1fyTBkqd7HI
	 cav7VW0lg3rVkGLnx2wAlICXEbNLvp2RP9uBMl74=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:03:51 +0100
Subject: [PATCH 02/22] mm: move mm_flags helpers to mm_types.h
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-remove_pgtable_cdtor-v1-2-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=3490;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=xWJCKsvCSbOTf1MrL+nqfsWcuzx4IBI4MMfjRE6PTH4=;
 b=hjHVW6q/l9oVND5egfxNDc6FE64eNht6hv1NYHcLYYfk3GK4zKlatRLYEID3yBr+Cr2y6GvLX
 wE73qcbXnDpDJQn8OyUXgdNbqTA1wZVDqiAytR24UH8BGEWoTGJECyr
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
	TAGGED_FROM(0.00)[bounces-22239-lists,linux-s390=lfdr.de];
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
X-Rspamd-Queue-Id: 14535755B8E

Some of the mm_flags helpers are defined in <linux/mm_types.h>,
while others are defined in <linux/mm.h>. We will soon need to call
one of the latter helpers from mm_types.h.

Regroup all the helpers in mm_types.h to keep things simple.

Also remove #include's that were added specifically for these
helpers in mm.h.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/mm.h       | 32 --------------------------------
 include/linux/mm_types.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 32bb723ffbb9..7a4b8e7ac8f4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -34,8 +34,6 @@
 #include <linux/slab.h>
 #include <linux/cacheinfo.h>
 #include <linux/rcuwait.h>
-#include <linux/bitmap.h>
-#include <linux/bitops.h>
 #include <linux/iommu-debug-pagealloc.h>
 #include <linux/kcsan-checks.h>
 
@@ -948,36 +946,6 @@ static inline void assert_fault_locked(const struct vm_fault *vmf)
 }
 #endif /* CONFIG_PER_VMA_LOCK */
 
-static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
-{
-	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
-}
-
-static inline bool mm_flags_test_and_set(int flag, struct mm_struct *mm)
-{
-	return test_and_set_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
-}
-
-static inline bool mm_flags_test_and_clear(int flag, struct mm_struct *mm)
-{
-	return test_and_clear_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
-}
-
-static inline void mm_flags_set(int flag, struct mm_struct *mm)
-{
-	set_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
-}
-
-static inline void mm_flags_clear(int flag, struct mm_struct *mm)
-{
-	clear_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
-}
-
-static inline void mm_flags_clear_all(struct mm_struct *mm)
-{
-	bitmap_zero(ACCESS_PRIVATE(&mm->flags, __mm_flags), NUM_MM_FLAG_BITS);
-}
-
 extern const struct vm_operations_struct vma_dummy_vm_ops;
 
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b4129beb9c4a..a2e0dc5892ff 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1414,6 +1414,36 @@ struct mm_struct {
 	char flexible_array[] __aligned(__alignof__(unsigned long));
 };
 
+static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
+{
+	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
+}
+
+static inline bool mm_flags_test_and_set(int flag, struct mm_struct *mm)
+{
+	return test_and_set_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
+}
+
+static inline bool mm_flags_test_and_clear(int flag, struct mm_struct *mm)
+{
+	return test_and_clear_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
+}
+
+static inline void mm_flags_set(int flag, struct mm_struct *mm)
+{
+	set_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
+}
+
+static inline void mm_flags_clear(int flag, struct mm_struct *mm)
+{
+	clear_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
+}
+
+static inline void mm_flags_clear_all(struct mm_struct *mm)
+{
+	bitmap_zero(ACCESS_PRIVATE(&mm->flags, __mm_flags), NUM_MM_FLAG_BITS);
+}
+
 /* Copy value to the first system word of mm flags, non-atomically. */
 static inline void __mm_flags_overwrite_word(struct mm_struct *mm, unsigned long value)
 {

-- 
2.51.2


