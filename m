Return-Path: <linux-s390+bounces-21811-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WizTL6dcTmozLQIAu9opvQ
	(envelope-from <linux-s390+bounces-21811-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 08 Jul 2026 16:20:23 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD6B7273F8
	for <lists+linux-s390@lfdr.de>; Wed, 08 Jul 2026 16:20:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hoctbuLL;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21811-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21811-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8A2A30BE155
	for <lists+linux-s390@lfdr.de>; Wed,  8 Jul 2026 14:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E03E47B438;
	Wed,  8 Jul 2026 14:12:03 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47CC47A0B5;
	Wed,  8 Jul 2026 14:12:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519922; cv=none; b=hPsqcCrqsc3Ln3Ca+uGxy8RXKQqMsGXRhKO1xAfgJAq/EB3i2AtsR5vIRs6i+dWdwUXj9QB32i4veVuQ0n3nWBJzyE9jHlBb6G50g9iS/TATCRgP9WNFnfq2CjJ30GF+ffqMHCF1FkWTU1kXSXHI3qR/9/KrfS9LIiM7bEaU8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519922; c=relaxed/simple;
	bh=njYtM8tFZh4NI2w0Rw/9oho1ipNomvnTKb6lrTd4S4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTmnYP7Nl+DODQR6HO9KxiZf9WH3Licx4xJWP/PIoDJxDKVOxteR/BXoEgxC6Uf00pYTazFE8hTWZppgeJZ40xxL1H9HLn+iGiw1H8MeNNjD3eS/6IYG2clyQjKr4s8xi1/y7em6cL8z4Z+Ji3c8SAdrarcjBkkI0/zXNs+SMGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoctbuLL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F981F00A3D;
	Wed,  8 Jul 2026 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783519921;
	bh=QogqO2vhwb6p7TEPdjCvspK5sajQUWVpqTDoqs/yB/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hoctbuLLxdAC0N3FiscXIkIWyHz6YjDTXPz2zjNd4PHHqRA7EJc7+9JjaG/85/OEC
	 yZcBMEZoWWd+WtlXsolZSDhHxC3ED4nWpLgC6jUF+MMlWqhjeKbnzdBDQscW4gw9tD
	 VsACB1aJb6TstaZWXgRr3EizWOYvP7FCdl1113zmR7X6JbFd666nd0C/zk1mHn3xhW
	 VJRt6yPyFnkkMau/q5Hq2TmljEIwtE6dEduKYT9Gf9Gzh1Sxm8IlAae8zFL8kjazsk
	 7EJcIukUE+gYmvRHjqpSvPWNmDG9LAYYKUftJ5tZv74xtD925scZRMh35w8SvA3v94
	 jvx2m2o4Emd5Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 08 Jul 2026 16:11:02 +0200
Subject: [PATCH 07/10] x86/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bootmem_info_part2-v1-7-156ce4986598@kernel.org>
References: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
In-Reply-To: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-s390@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dave.hansen@linux.intel.com,m:luto@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:jackmanb@google.com,m:hannes@cmpxchg.org,m:ziy@nvidia.com,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:muchun.song@linux.dev,m:osalvador@suse.de,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-s390@vger.kernel.org,m:david@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[david@kernel.org,linux-s390@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21811-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DD6B7273F8

CONFIG_HAVE_BOOTMEM_INFO_NODE now essentially doesn't do anything.

So let's remove support for CONFIG_HAVE_BOOTMEM_INFO_NODE.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/x86/mm/init_64.c | 26 --------------------------
 mm/Kconfig            |  1 -
 2 files changed, 27 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 1b17dcf781e66..ab4c5a02326f7 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -33,7 +33,6 @@
 #include <linux/nmi.h>
 #include <linux/gfp.h>
 #include <linux/kcore.h>
-#include <linux/bootmem_info.h>
 
 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
@@ -1286,16 +1285,6 @@ void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap,
 
 static struct kcore_list kcore_vsyscall;
 
-static void __init register_page_bootmem_info(void)
-{
-#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP)
-	int i;
-
-	for_each_online_node(i)
-		register_page_bootmem_info_node(NODE_DATA(i));
-#endif
-}
-
 /*
  * Pre-allocates page-table pages for the vmalloc area in the kernel page-table.
  * Only the level which needs to be synchronized between all page-tables is
@@ -1358,14 +1347,6 @@ void __init mem_init(void)
 	after_bootmem = 1;
 	x86_init.hyper.init_after_bootmem();
 
-	/*
-	 * Must be done after boot memory is put on freelist, because here we
-	 * might set fields in deferred struct pages that have not yet been
-	 * initialized, and memblock_free_all() initializes all the reserved
-	 * deferred pages for us.
-	 */
-	register_page_bootmem_info();
-
 	/* Register memory areas for /proc/kcore */
 	if (get_gate_vma(&init_mm))
 		kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR, PAGE_SIZE, KCORE_USER);
@@ -1564,13 +1545,6 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	return err;
 }
 
-#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
-void register_page_bootmem_memmap(unsigned long section_nr,
-				  struct page *start_page, unsigned long nr_pages)
-{
-}
-#endif
-
 void __meminit vmemmap_populate_print_last(void)
 {
 	if (p_start) {
diff --git a/mm/Kconfig b/mm/Kconfig
index f794a341d7422..592003a258bad 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -590,7 +590,6 @@ endchoice
 
 config MEMORY_HOTREMOVE
 	bool "Allow for memory hot remove"
-	select HAVE_BOOTMEM_INFO_NODE if X86_64
 	depends on MEMORY_HOTPLUG
 	select MIGRATION
 

-- 
2.43.0


