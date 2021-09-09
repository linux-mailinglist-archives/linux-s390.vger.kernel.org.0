Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62F74059EA
	for <lists+linux-s390@lfdr.de>; Thu,  9 Sep 2021 17:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbhIIPCO (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 9 Sep 2021 11:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47755 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236677AbhIIPB5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Sep 2021 11:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631199647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6g4VWCrzU/h/qyBDenztolU1cZPMwHWOEhuFKokN2bQ=;
        b=LWnUTFf1c1L4MLe/etiTVDfh7+E+P+UIixJ1KMBIZiPyUyJrmfdkW6y479gN4fh8g0yoPT
        CGfZUw1mgBzmrL5RneULj9GOBJVA/GKpSgcVSLaThD0ql/BWqP7TQirlNHZ1XER5cdb5g8
        t700ZU8eSPMWHNPrLLlfDf7UB1ViVzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-dXg4jKsrNB6-1dnVyaOpqA-1; Thu, 09 Sep 2021 11:00:45 -0400
X-MC-Unique: dXg4jKsrNB6-1dnVyaOpqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CC6BCC626;
        Thu,  9 Sep 2021 15:00:44 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.233])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F09756F80E;
        Thu,  9 Sep 2021 15:00:41 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 7/9] s390/mm: no need for pte_alloc_map_lock() if we know the pmd is present
Date:   Thu,  9 Sep 2021 16:59:43 +0200
Message-Id: <20210909145945.12192-8-david@redhat.com>
In-Reply-To: <20210909145945.12192-1-david@redhat.com>
References: <20210909145945.12192-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

pte_map_lock() is sufficient.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/pgtable.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 5fb409ff7842..4e77b8ebdcc5 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -814,10 +814,7 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 	}
 	spin_unlock(ptl);
 
-	ptep = pte_alloc_map_lock(mm, pmdp, addr, &ptl);
-	if (unlikely(!ptep))
-		return -EFAULT;
-
+	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
 	new = old = pgste_get_lock(ptep);
 	pgste_val(new) &= ~(PGSTE_GR_BIT | PGSTE_GC_BIT |
 			    PGSTE_ACC_BITS | PGSTE_FP_BIT);
@@ -912,10 +909,7 @@ int reset_guest_reference_bit(struct mm_struct *mm, unsigned long addr)
 	}
 	spin_unlock(ptl);
 
-	ptep = pte_alloc_map_lock(mm, pmdp, addr, &ptl);
-	if (unlikely(!ptep))
-		return -EFAULT;
-
+	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
 	new = old = pgste_get_lock(ptep);
 	/* Reset guest reference bit only */
 	pgste_val(new) &= ~PGSTE_GR_BIT;
@@ -977,10 +971,7 @@ int get_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 	}
 	spin_unlock(ptl);
 
-	ptep = pte_alloc_map_lock(mm, pmdp, addr, &ptl);
-	if (unlikely(!ptep))
-		return -EFAULT;
-
+	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
 	pgste = pgste_get_lock(ptep);
 	*key = (pgste_val(pgste) & (PGSTE_ACC_BITS | PGSTE_FP_BIT)) >> 56;
 	paddr = pte_val(*ptep) & PAGE_MASK;
-- 
2.31.1

