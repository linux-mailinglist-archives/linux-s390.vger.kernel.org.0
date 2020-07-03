Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F13213B2A
	for <lists+linux-s390@lfdr.de>; Fri,  3 Jul 2020 15:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgGCNje (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 Jul 2020 09:39:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30758 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726437AbgGCNjd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 09:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593783572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D86OWdb4G6MO930dgyd1RKO5SzKtAc9UC151Da6XFJ0=;
        b=HdjYw85hx/bcFfAgV3mKuHXsjAe2kbaafyAei9u1G2q89BqsSPlhrnSsNgWdsVEH5FRL+e
        V1t9+KY8s6ST0PbazYSlBp4M0oI+61/d7oebovc0x2JmD4LJRy+AOtBvAmyWAB4mP1fQiW
        b4MwDY2hLJ9HE3INDdvs7KOa/PB+N+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-KjYCCmWQMYK1zMsbayvs5w-1; Fri, 03 Jul 2020 09:39:29 -0400
X-MC-Unique: KjYCCmWQMYK1zMsbayvs5w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 579798015FB;
        Fri,  3 Jul 2020 13:39:28 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-0.ams2.redhat.com [10.36.114.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6CEE71690;
        Fri,  3 Jul 2020 13:39:26 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH v1 3/9] s390/vmemmap: implement vmemmap_free()
Date:   Fri,  3 Jul 2020 15:39:11 +0200
Message-Id: <20200703133917.39045-4-david@redhat.com>
In-Reply-To: <20200703133917.39045-1-david@redhat.com>
References: <20200703133917.39045-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Reuse the shiny new remove_pagetable(), tweaking it to handle freeing of
vmemmap pages, similar to the x86-64 variant (passing "bool direct" to
distinguish).

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 46 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 6fe156c3f035c..16e109c292bf5 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -29,6 +29,15 @@ static void __ref *vmem_alloc_pages(unsigned int order)
 	return (void *) memblock_phys_alloc(size, size);
 }
 
+static void vmem_free_pages(unsigned long addr, int order)
+{
+	/* We don't expect boot memory to be removed ever. */
+	if (!slab_is_available() ||
+	    WARN_ON_ONCE(PageReserved(phys_to_page(addr))))
+		return;
+	free_pages(addr, order);
+}
+
 void *vmem_crst_alloc(unsigned long val)
 {
 	unsigned long *table;
@@ -139,7 +148,7 @@ static int vmem_add_range(unsigned long start, unsigned long size)
 }
 
 static void remove_pte_table(pmd_t *pmd, unsigned long addr,
-			     unsigned long end)
+			     unsigned long end, bool direct)
 {
 	unsigned long pages = 0;
 	pte_t *pte;
@@ -149,15 +158,18 @@ static void remove_pte_table(pmd_t *pmd, unsigned long addr,
 		if (pte_none(*pte))
 			continue;
 
+		if (!direct)
+			vmem_free_pages(pfn_to_phys(pte_pfn(*pte)), 0);
 		pte_clear(&init_mm, addr, pte);
 		pages++;
 	}
 
-	update_page_count(PG_DIRECT_MAP_4K, -pages);
+	if (direct)
+		update_page_count(PG_DIRECT_MAP_4K, -pages);
 }
 
 static void remove_pmd_table(pud_t *pud, unsigned long addr,
-			     unsigned long end)
+			     unsigned long end, bool direct)
 {
 	unsigned long next, pages = 0;
 	pmd_t *pmd;
@@ -172,20 +184,24 @@ static void remove_pmd_table(pud_t *pud, unsigned long addr,
 		if (pmd_large(*pmd)) {
 			if (IS_ALIGNED(addr, PMD_SIZE) &&
 			    IS_ALIGNED(next, PMD_SIZE)) {
+				if (!direct)
+					vmem_free_pages(pmd_deref(*pmd),
+							get_order(PMD_SIZE));
 				pmd_clear(pmd);
 				pages++;
 			}
 			continue;
 		}
 
-		remove_pte_table(pmd, addr, next);
+		remove_pte_table(pmd, addr, next, direct);
 	}
 
-	update_page_count(PG_DIRECT_MAP_1M, -pages);
+	if (direct)
+		update_page_count(PG_DIRECT_MAP_1M, -pages);
 }
 
 static void remove_pud_table(p4d_t *p4d, unsigned long addr,
-			     unsigned long end)
+			     unsigned long end, bool direct)
 {
 	unsigned long next, pages = 0;
 	pud_t *pud;
@@ -200,20 +216,22 @@ static void remove_pud_table(p4d_t *p4d, unsigned long addr,
 		if (pud_large(*pud)) {
 			if (IS_ALIGNED(addr, PUD_SIZE) &&
 			    IS_ALIGNED(next, PUD_SIZE)) {
+				WARN_ON_ONCE(!direct);
 				pud_clear(pud);
 				pages++;
 			}
 			continue;
 		}
 
-		remove_pmd_table(pud, addr, next);
+		remove_pmd_table(pud, addr, next, direct);
 	}
 
-	update_page_count(PG_DIRECT_MAP_2G, -pages);
+	if (direct)
+		update_page_count(PG_DIRECT_MAP_2G, -pages);
 }
 
 static void remove_p4d_table(pgd_t *pgd, unsigned long addr,
-			     unsigned long end)
+			     unsigned long end, bool direct)
 {
 	unsigned long next;
 	p4d_t *p4d;
@@ -225,11 +243,12 @@ static void remove_p4d_table(pgd_t *pgd, unsigned long addr,
 		if (p4d_none(*p4d))
 			continue;
 
-		remove_pud_table(p4d, addr, next);
+		remove_pud_table(p4d, addr, next, direct);
 	}
 }
 
-static void remove_pagetable(unsigned long start, unsigned long end)
+static void remove_pagetable(unsigned long start, unsigned long end,
+			     bool direct)
 {
 	unsigned long addr, next;
 	pgd_t *pgd;
@@ -244,7 +263,7 @@ static void remove_pagetable(unsigned long start, unsigned long end)
 		if (pgd_none(*pgd))
 			continue;
 
-		remove_p4d_table(pgd, addr, next);
+		remove_p4d_table(pgd, addr, next, direct);
 	}
 
 	flush_tlb_kernel_range(start, end);
@@ -256,7 +275,7 @@ static void remove_pagetable(unsigned long start, unsigned long end)
  */
 static void vmem_remove_range(unsigned long start, unsigned long size)
 {
-	remove_pagetable(start, start + size);
+	remove_pagetable(start, start + size, true);
 }
 
 /*
@@ -351,6 +370,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 void vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap)
 {
+	remove_pagetable(start, end, false);
 }
 
 void vmem_remove_mapping(unsigned long start, unsigned long size)
-- 
2.26.2

