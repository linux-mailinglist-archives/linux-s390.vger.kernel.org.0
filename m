Return-Path: <linux-s390+bounces-21806-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l8X6C+xbTmoGLQIAu9opvQ
	(envelope-from <linux-s390+bounces-21806-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 08 Jul 2026 16:17:16 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1120727375
	for <lists+linux-s390@lfdr.de>; Wed, 08 Jul 2026 16:17:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ckeOtBFV;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21806-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21806-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A25F930C1690
	for <lists+linux-s390@lfdr.de>; Wed,  8 Jul 2026 14:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25A9449EB8;
	Wed,  8 Jul 2026 14:11:23 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84388477E4B;
	Wed,  8 Jul 2026 14:11:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519883; cv=none; b=grZUfuI0C5Yg679Wq3d0oZ+9IpRhw+Bwp3/Yxnl9QsVuHc2W+2PZfvmfXMEMzzXnKJqTG+uaXi/qZA3W/+kv4lWeOMeoK+lmxPo73FhXiHQBzrusgklRI9eE1lbrLHYEWfDDmNYDQ6SzcWm5ew7JB1a4R1RK+njzCN14oOzQZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519883; c=relaxed/simple;
	bh=R6RRxAe6UnpB4HUgVrDT8mxjhDhatyd6BNWiNfIDF2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EHKrxfxzQobuzixkfGKVsC4A9C3nRHKAZRvpZLpt37Crt3CApJEyLpf2Zf6rlGz+h4ixnWcZmPRLNJ69INua3FbNwxW71Ao6rh55noqxsicz5ewTX6NuCu54IGBffUTJNw86A1/T+WR12JMcYml54bjvDbKcgrJDjfS94mPg2vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckeOtBFV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A861F00A3A;
	Wed,  8 Jul 2026 14:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783519882;
	bh=tFyxPJ20nGKU5oJlQlEyooEUxC7eruHMjD4D5VqWTN4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ckeOtBFVWD1BusC3wMJcCqaTHmmEoHVgbLMGflu6kKlHozSqdtjnGzjb+7zJJ6VW9
	 VXatpfZhH7LW8uxrhnywjtXc9clRoKAbB0EVZrK1HS/SY+c0KemZnwjlTeEsFH84jR
	 EHlR2ZitN+nlpIq7ZuM6mQyNUKLWaTNi2N7sKIQ7R0RseEEv7tUp0Fa8Z6LH97lhs8
	 +vvd80Nsy3C83H6H/PjuIHWfxiug6bK3hh/G9GT+ml8eB++m4oxmamKJwmHM0XPzTq
	 2e2oCRenybfCBPgg0qnZfUCpbQasLxBDNtCd/WKsHmfAQGoowgExk56GdvNe3nmnNe
	 V5JUngawtF9kg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 08 Jul 2026 16:10:57 +0200
Subject: [PATCH 02/10] mm: provide free_reserved_pages(), removing x86
 variant
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bootmem_info_part2-v1-2-156ce4986598@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-21806-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: C1120727375

Let's extend free_reserved_page() in page_alloc.c to free_reserved_pages(),
dropping the custom x86 variant. The common-code variant will consume an
order, so adjust the x86 callers accordingly.

Make free_reserved_pages() assume that we are freeing ordinary
high-order pages, just with the special "reserved" flavor. The target
use case for now is freeing vmemmap PMD pages.

Set the refcount directly to 0 (instead of 1) and call
__free_frozen_pages(). Add some kerneldoc. Use a single
adjust_managed_page_count() call.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/x86/mm/init_64.c |  8 +-------
 include/linux/mm.h    |  8 ++++++--
 mm/page_alloc.c       | 33 ++++++++++++++++++++++++++-------
 3 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 69e36f02a663a..320e742b0bb3f 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1000,12 +1000,6 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	return add_pages(nid, start_pfn, nr_pages, params);
 }
 
-static void free_reserved_pages(struct page *page, unsigned long nr_pages)
-{
-	while (nr_pages--)
-		free_reserved_page(page++);
-}
-
 static void __meminit free_pagetable(struct page *page)
 {
 	/* bootmem page has reserved flag */
@@ -1038,7 +1032,7 @@ static void __meminit free_vmemmap_pages(struct page *page, unsigned int order,
 			while (nr_pages--)
 				put_page_bootmem(page++);
 		} else {
-			free_reserved_pages(page, nr_pages);
+			free_reserved_pages(page, order);
 		}
 	} else {
 		__free_pages(page, order);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 113e1752548c2..62b261cccf16f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3993,8 +3993,12 @@ extern unsigned long free_reserved_area(void *start, void *end,
 
 extern void adjust_managed_page_count(struct page *page, long count);
 
-/* Free the reserved page into the buddy system, so it gets managed. */
-void free_reserved_page(struct page *page);
+void free_reserved_pages(struct page *page, unsigned int order);
+
+static inline void free_reserved_page(struct page *page)
+{
+	free_reserved_pages(page, 0);
+}
 
 static inline void mark_page_reserved(struct page *page)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a63733dac659e..9311d1f3793ad 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6381,15 +6381,34 @@ void adjust_managed_page_count(struct page *page, long count)
 }
 EXPORT_SYMBOL(adjust_managed_page_count);
 
-void free_reserved_page(struct page *page)
+/**
+ * free_reserved_pages - free reserved pages
+ * @page: First page to free.
+ * @order: The page order to free.
+ *
+ * Free pages allocated through memblock during boot, letting the buddy
+ * manage them from now on.
+ *
+ * @page must be naturally aligned to the order and the order must not
+ * exceed MAX_PAGE_ORDER. All pages must be reserved.
+ */
+void free_reserved_pages(struct page *page, unsigned int order)
 {
-	clear_page_tag_ref(page);
-	ClearPageReserved(page);
-	init_page_count(page);
-	__free_page(page);
-	adjust_managed_page_count(page, 1);
+	const unsigned long nr_pages = 1UL << order;
+	int i;
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(page_to_pfn(page), nr_pages));
+	VM_WARN_ON_ONCE(order > MAX_PAGE_ORDER);
+
+	for (i = 0; i < nr_pages; i++) {
+		clear_page_tag_ref(page + i);
+		ClearPageReserved(page + i);
+		set_page_count(page + i, 0);
+	}
+	adjust_managed_page_count(page, nr_pages);
+	__free_frozen_pages(page, order, FPI_NONE);
 }
-EXPORT_SYMBOL(free_reserved_page);
+EXPORT_SYMBOL(free_reserved_pages);
 
 static int page_alloc_cpu_dead(unsigned int cpu)
 {

-- 
2.43.0


