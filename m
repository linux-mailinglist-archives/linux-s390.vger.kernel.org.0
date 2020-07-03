Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD61213B39
	for <lists+linux-s390@lfdr.de>; Fri,  3 Jul 2020 15:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgGCNjt (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 Jul 2020 09:39:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47766 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726645AbgGCNjm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 09:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593783581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XhdIQEjeju2+mfOgkfXLV2kcnvfh1eYCT4zZzF6n5tU=;
        b=LJhYYcZp6BrIER/7OHT+vPIVuuRerxE8R0XnQL0OuqyUaKNNurc7sR/4ced2tCXXGNAlYP
        Bn6Ivd8GZwGbk4pwP266fmLpvw8SOnPueila7dQZl1Mo7uXn/m0rIOjpAz+NEa7TXe1hk2
        J93Zl2RIyvjKHLZG5mhjMsdINUeXTQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-EnIgn5p6OfCK8K-u2RQwKw-1; Fri, 03 Jul 2020 09:39:37 -0400
X-MC-Unique: EnIgn5p6OfCK8K-u2RQwKw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 081BC1054FA2;
        Fri,  3 Jul 2020 13:39:36 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-0.ams2.redhat.com [10.36.114.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6791271690;
        Fri,  3 Jul 2020 13:39:34 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH v1 7/9] s390/vmemmap: fallback to PTEs if mapping large PMD fails
Date:   Fri,  3 Jul 2020 15:39:15 +0200
Message-Id: <20200703133917.39045-8-david@redhat.com>
In-Reply-To: <20200703133917.39045-1-david@redhat.com>
References: <20200703133917.39045-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Let's fallback to single pages if short on huge pages. No need to stop
memory hotplug.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 5239130770b7b..b7fdb9536707f 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -422,23 +422,23 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		}
 
 		pm_dir = pmd_offset(pu_dir, address);
-		if (pmd_none(*pm_dir)) {
+		if (pmd_none(*pm_dir) && MACHINE_HAS_EDAT1) {
+			void *new_page;
+
 			/* Use 1MB frames for vmemmap if available. We always
 			 * use large frames even if they are only partially
 			 * used.
 			 * Otherwise we would have also page tables since
 			 * vmemmap_populate gets called for each section
 			 * separately. */
-			if (MACHINE_HAS_EDAT1) {
-				void *new_page;
-
-				new_page = vmemmap_alloc_block(PMD_SIZE, node);
-				if (!new_page)
-					goto out;
+			new_page = vmemmap_alloc_block(PMD_SIZE, node);
+			if (new_page) {
 				pmd_val(*pm_dir) = __pa(new_page) | sgt_prot;
 				address = (address + PMD_SIZE) & PMD_MASK;
 				continue;
 			}
+		}
+		if (pmd_none(*pm_dir)) {
 			pt_dir = vmem_pte_alloc();
 			if (!pt_dir)
 				goto out;
-- 
2.26.2

