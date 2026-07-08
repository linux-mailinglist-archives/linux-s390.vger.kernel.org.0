Return-Path: <linux-s390+bounces-21805-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vE2LBY9cTmosLQIAu9opvQ
	(envelope-from <linux-s390+bounces-21805-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 08 Jul 2026 16:19:59 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBCF7273E6
	for <lists+linux-s390@lfdr.de>; Wed, 08 Jul 2026 16:19:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dY3fvVBG;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21805-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21805-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7867B309FC73
	for <lists+linux-s390@lfdr.de>; Wed,  8 Jul 2026 14:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3FF44A71D;
	Wed,  8 Jul 2026 14:11:16 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE39A44212A;
	Wed,  8 Jul 2026 14:11:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519875; cv=none; b=TFlZ/tDKd7i6N+7O73JY8lwUandKxvDlcjplcTr6vhXTRnwD4ZHrcaDIBLxMoIn5+Upiu7U0834+RcVaAqQY9gx5G411NDEJinjEQGDEuoDT2/oupccjYT2Phd7VVRq6DN0/NEyAZE9C+NfYpXs67t2aoZCCbv0RVWKTybWA5E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519875; c=relaxed/simple;
	bh=A4g9Xi44lgz+jx+bdNzZ1t7Tre6Zm61/fHMa3XFqNZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Npv5TpbToFiLQ3buQdsyjjcq7LcOFmqxx5eWHvvZ7+nN9ueDvUU6Bbf5FwPA/zlB6h9GPZaoxnNAzNP/yhkRrgnqMXmF9lkYn7wY1m3FNMkCwO4kicnYwajF9P8K55qMTL0nJVq6wlEOXu0GZ0HqDYzPeTxcftbCk7FO5Fl74vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dY3fvVBG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E112F1F00A3E;
	Wed,  8 Jul 2026 14:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783519874;
	bh=E+AlVizHAu3WzgjL8uIczk1k7KNNNOBonScKWHpcsCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dY3fvVBGl/2fsM7e1EHOWO7ed5WSNaMRvRaOwku0a6Q27yhD/O0RVg/OSyF+Ygk22
	 Rp/VjvKdYcvRgKOBfjpEcVyucHkbasJ9I8s4ksbOQTI+O4LCdkFPcm746p8SUj+w3G
	 S8ksj55L+O/ElhURv+Wz7hu/jS49UIPERbbQD/hRc1yez2Ylk5+DhBOcrU28HBP6Ud
	 HFR4Rt4NATcRrwlc9HG6RP9wigX4bQdXFSDQlBXljrQ37a2CYQJMqsIhCO64I85Qp9
	 TEqNLOtMtLelimYChR7VsPxs8D+OFpLfRGfycH3VIp5nZCim9Ao1VPcOOvPS8K9Eqx
	 ujlOSmn0L/HTQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 08 Jul 2026 16:10:56 +0200
Subject: [PATCH 01/10] x86/mm: drop order parameter from free_pagetable()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bootmem_info_part2-v1-1-156ce4986598@kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dave.hansen@linux.intel.com,m:luto@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:jackmanb@google.com,m:hannes@cmpxchg.org,m:ziy@nvidia.com,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:muchun.song@linux.dev,m:osalvador@suse.de,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-s390@vger.kernel.org,m:david@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[david@kernel.org,linux-s390@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21805-lists,linux-s390=lfdr.de];
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
X-Rspamd-Queue-Id: 6FBCF7273E6

All callers pass 0, so let's drop the parameter.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/x86/mm/init_64.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index d57f29ca23a5a..69e36f02a663a 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1006,22 +1006,19 @@ static void free_reserved_pages(struct page *page, unsigned long nr_pages)
 		free_reserved_page(page++);
 }
 
-static void __meminit free_pagetable(struct page *page, int order)
+static void __meminit free_pagetable(struct page *page)
 {
 	/* bootmem page has reserved flag */
 	if (PageReserved(page)) {
-		unsigned long nr_pages = 1 << order;
 #ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
 		enum bootmem_type type = bootmem_type(page);
 
-		if (type == MIX_SECTION_INFO) {
-			while (nr_pages--)
-				put_page_bootmem(page++);
-		} else {
-			free_reserved_pages(page, nr_pages);
-		}
+		if (type == MIX_SECTION_INFO)
+			put_page_bootmem(page);
+		else
+			free_reserved_page(page);
 #else
-		free_reserved_pages(page, nr_pages);
+		free_reserved_page(page);
 #endif
 	} else {
 		pagetable_free(page_ptdesc(page));
@@ -1060,7 +1057,7 @@ static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
 	}
 
 	/* free a pte table */
-	free_pagetable(pmd_page(*pmd), 0);
+	free_pagetable(pmd_page(*pmd));
 	spin_lock(&init_mm.page_table_lock);
 	pmd_clear(pmd);
 	spin_unlock(&init_mm.page_table_lock);
@@ -1078,7 +1075,7 @@ static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
 	}
 
 	/* free a pmd table */
-	free_pagetable(pud_page(*pud), 0);
+	free_pagetable(pud_page(*pud));
 	spin_lock(&init_mm.page_table_lock);
 	pud_clear(pud);
 	spin_unlock(&init_mm.page_table_lock);
@@ -1096,7 +1093,7 @@ static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
 	}
 
 	/* free a pud table */
-	free_pagetable(p4d_page(*p4d), 0);
+	free_pagetable(p4d_page(*p4d));
 	spin_lock(&init_mm.page_table_lock);
 	p4d_clear(p4d);
 	spin_unlock(&init_mm.page_table_lock);

-- 
2.43.0


