Return-Path: <linux-s390+bounces-21812-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VwQ8Dc9dTmp5LQIAu9opvQ
	(envelope-from <linux-s390+bounces-21812-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 08 Jul 2026 16:25:19 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A40307274E4
	for <lists+linux-s390@lfdr.de>; Wed, 08 Jul 2026 16:25:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VVKeExoV;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21812-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21812-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA16630E63D0
	for <lists+linux-s390@lfdr.de>; Wed,  8 Jul 2026 14:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041DC47A0B5;
	Wed,  8 Jul 2026 14:12:11 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF83481226;
	Wed,  8 Jul 2026 14:12:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519930; cv=none; b=tInFr4wbMKpquTXU0pAvw2I8yR/9D19uEMJca8tL03nyubb1FJal/vnZL35uWaoMFwOc+2765JSNKr+Pi2UZSj/R3Eeo11dvXVSyx1MOlLCDqibeDkx/CnRohcBehKccW9I2f8HMPWR5KRkoJyeqdM3uBiu1qw78NkA9SkIS4XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519930; c=relaxed/simple;
	bh=eaFkEAKx4m1JxYiS0xVBoqKX8fGDxxr14xHvFmK2qQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mIzi9jnunsFqfCn3L/wkx3BmUXsIQPaOVCvQzTRlAoAMOg123ZtBqisbAh3XqcssFkazJVZMhzxiwnfJbQHmRKLW8b+YqpvlxBbTyZfIU8v9ad0rtye5NEeI4viDz99icYfwNh2sRdN55pHxc0h0lvuHILXGRrrhjbwHmCqrERY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVKeExoV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C525E1F000E9;
	Wed,  8 Jul 2026 14:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783519929;
	bh=WWLUsYbDG7mGiwVJlzgDyy16xOy76zogl1g8GKgt0OE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VVKeExoVskhmb7x1k+V/281l4+bx71A5EAtpLvXXnhLBnmo/wXh3+iZtgRsaaKtXV
	 SMMuJ0OkPqB7pypW7SaC8grlPMVEDZ19latunSwoGyvts5gag3mmstusguhvCkTcea
	 TfoFB2v2S486O94fWOMmjfkoBXlH6LmYdxd3OP8uMx119/akp9FSVdqORbQgjt2YIx
	 NVnukUkX+UL7vuZMnBf0DQc7cUeTJFMTMwj3YOZQWd3L50cZCpjzgbMu105rzDVcno
	 ajYPGXNTNr5g0jfiD6JIZHbRZoPUX9vS65XSFYfZWFsCyM1ESZ6iWmUjMtEw4TCkvr
	 8qn56UFNuKDjw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 08 Jul 2026 16:11:03 +0200
Subject: [PATCH 08/10] mm/hugetlb_vmemmap: remove bootmem_info leftovers
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bootmem_info_part2-v1-8-156ce4986598@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dave.hansen@linux.intel.com,m:luto@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:jackmanb@google.com,m:hannes@cmpxchg.org,m:ziy@nvidia.com,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:muchun.song@linux.dev,m:osalvador@suse.de,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-s390@vger.kernel.org,m:david@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[david@kernel.org,linux-s390@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21812-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: A40307274E4

We never set CONFIG_HAVE_BOOTMEM_INFO_NODE, so we can just switch to
free_reserved_page() and drop the register_page_bootmem_memmap() call.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb_vmemmap.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 1430a5aa2de57..917db0984143c 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -12,7 +12,6 @@
 
 #include <linux/pgtable.h>
 #include <linux/moduleparam.h>
-#include <linux/bootmem_info.h>
 #include <linux/mmdebug.h>
 #include <linux/pagewalk.h>
 #include <linux/pgalloc.h>
@@ -177,13 +176,13 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
  * Free a vmemmap page. A vmemmap page can be allocated from the memblock
  * allocator or buddy allocator. If the PG_reserved flag is set, it means
  * that it allocated from the memblock allocator, just free it via the
- * free_bootmem_page(). Otherwise, use __free_page().
+ * free_reserved_page(). Otherwise, use __free_page().
  */
 static inline void free_vmemmap_page(struct page *page)
 {
 	if (PageReserved(page)) {
 		memmap_boot_pages_add(-1);
-		free_bootmem_page(page);
+		free_reserved_page(page);
 	} else {
 		memmap_pages_add(-1);
 		__free_page(page);
@@ -641,9 +640,6 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 			epfn = spfn + hugetlb_vmemmap_size(h);
 			vmemmap_wrprotect_hvo(spfn, epfn, folio_nid(folio),
 					HUGETLB_VMEMMAP_RESERVE_SIZE);
-			register_page_bootmem_memmap(pfn_to_section_nr(folio_pfn(folio)),
-					&folio->page,
-					HUGETLB_VMEMMAP_RESERVE_PAGES);
 			continue;
 		}
 

-- 
2.43.0


