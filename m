Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2760213B37
	for <lists+linux-s390@lfdr.de>; Fri,  3 Jul 2020 15:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgGCNjs (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 Jul 2020 09:39:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59315 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726048AbgGCNjr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 09:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593783585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3i/7HG3E2Y5FgAWZXKhOsCstaQ5rwPr72fTo1BaNePY=;
        b=QbaN3rbkpsjAsxYiNF76cxrQdqDbk7Iho+impWkQbGs9tLF5ROBwKFIH0fiFWtxvKqFk4/
        r9yt/cABCUGYlCAj0qzrWAXy1B8cgT2SkvG3dJEpmpL5aC+hVmRKAJ1LN9OpqFHiUyZlnB
        Xddit8IfNgOOPwGnLJwcHBOdlISpiUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-FLh4HO9OO-SgYyk7VG0xvQ-1; Fri, 03 Jul 2020 09:39:44 -0400
X-MC-Unique: FLh4HO9OO-SgYyk7VG0xvQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A04642268;
        Fri,  3 Jul 2020 13:39:42 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-0.ams2.redhat.com [10.36.114.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FBA97AC75;
        Fri,  3 Jul 2020 13:39:38 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH v1 9/9] s390/vmemmap: avoid memset(PAGE_UNUSED) when adding consecutive sections
Date:   Fri,  3 Jul 2020 15:39:17 +0200
Message-Id: <20200703133917.39045-10-david@redhat.com>
In-Reply-To: <20200703133917.39045-1-david@redhat.com>
References: <20200703133917.39045-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Let's avoid memset(PAGE_UNUSED) when adding consecutive sections,
whereby the vmemmap of a single section does not span full PMDs.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index a981ff5d47223..9db15fc864fc8 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -74,7 +74,22 @@ static void vmem_pte_free(unsigned long *table)
 
 #define PAGE_UNUSED 0xFD
 
-static void vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
+/*
+ * The unused vmemmap range, which was not yet memset(PAGE_UNUSED) ranges
+ * from unused_pmd_start to next PMD_SIZE boundary.
+ */
+unsigned long unused_pmd_start;
+
+static void vmemmap_flush_unused_pmd(void)
+{
+	if (!unused_pmd_start)
+		return;
+	memset(__va(unused_pmd_start), PAGE_UNUSED,
+	       ALIGN(unused_pmd_start, PMD_SIZE) - unused_pmd_start);
+	unused_pmd_start = 0;
+}
+
+static void __vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
 {
 	/*
 	 * As we expect to add in the same granularity as we remove, it's
@@ -85,18 +100,41 @@ static void vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
 	memset(__va(start), 0, sizeof(struct page));
 }
 
+static void vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
+{
+	/*
+	 * We only optimize if the new used range directly follows the
+	 * previously unused range (esp., when populating consecutive sections).
+	 */
+	if (unused_pmd_start == start) {
+		unused_pmd_start = end;
+		if (likely(IS_ALIGNED(unused_pmd_start, PMD_SIZE)))
+			unused_pmd_start = 0;
+		return;
+	}
+	vmemmap_flush_unused_pmd();
+	__vmemmap_use_sub_pmd(start, end);
+}
+
 static void vmemmap_use_new_sub_pmd(unsigned long start, unsigned long end)
 {
 	void *page = __va(ALIGN_DOWN(start, PMD_SIZE));
 
+	vmemmap_flush_unused_pmd();
+
 	/* Could be our memmap page is filled with PAGE_UNUSED already ... */
-	vmemmap_use_sub_pmd(start, end);
+	__vmemmap_use_sub_pmd(start, end);
 
 	/* Mark the unused parts of the new memmap page PAGE_UNUSED. */
 	if (!IS_ALIGNED(start, PMD_SIZE))
 		memset(page, PAGE_UNUSED, start - __pa(page));
+	/*
+	 * We want to avoid memset(PAGE_UNUSED) when populating the vmemmap of
+	 * consecutive sections. Remember for the last added PMD the last
+	 * unused range in the populated PMD.
+	 */
 	if (!IS_ALIGNED(end, PMD_SIZE))
-		memset(__va(end), PAGE_UNUSED, __pa(page) + PMD_SIZE - end);
+		unused_pmd_start = end;
 }
 
 /* Returns true if the PMD is completely unused and can be freed. */
@@ -104,6 +142,7 @@ static bool vmemmap_unuse_sub_pmd(unsigned long start, unsigned long end)
 {
 	void *page = __va(ALIGN_DOWN(start, PMD_SIZE));
 
+	vmemmap_flush_unused_pmd();
 	memset(__va(start), PAGE_UNUSED, end - start);
 	return !memchr_inv(page, PAGE_UNUSED, PMD_SIZE);
 }
-- 
2.26.2

