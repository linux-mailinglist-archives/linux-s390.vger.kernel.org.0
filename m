Return-Path: <linux-s390+bounces-944-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA8982B1AF
	for <lists+linux-s390@lfdr.de>; Thu, 11 Jan 2024 16:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094B9280F66
	for <lists+linux-s390@lfdr.de>; Thu, 11 Jan 2024 15:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEE84C3DC;
	Thu, 11 Jan 2024 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qYMJGgwr"
X-Original-To: linux-s390@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443354C60A
	for <linux-s390@vger.kernel.org>; Thu, 11 Jan 2024 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=DpHWtj8UeAQGvemXnNL2ch0TeITvLAzMMm0m+IyVsmc=; b=qYMJGgwrJjEPeRzi/f90dt3Ozv
	9PQtyqzziqRJpX+p40XvKLJkluq16ySvHxsi/iO67TMJPEubaqLslIc5g3D4vRdUHJG13tz5Cpdjf
	ghhn4AqibXxTlKUv6JnRmmflcyCGENaiJkF4NuD29SnejdzIXfZSIt9oE6dQblAAmMor022zW43vN
	S7F7ktILemN5A3vIi5n3xNRDerODTZUS2JFmM46GapYJmYSWFtGfNspu0bZ98GgvZJpggwQ3AVNkx
	wYLjOg9D2eiSjbtR+iqteYoh0PJyuqomx9uDeW8CvvHSc0ap4qa1T8TaI2En3zu+SE13VcoatM182
	Da/ZJtHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNwv1-00E9so-L3; Thu, 11 Jan 2024 15:24:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-mm@kvack.org,
	david@redhat.com,
	linux-s390@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 05/10] mm: use pfn_swap_entry_folio() in __split_huge_pmd_locked()
Date: Thu, 11 Jan 2024 15:24:24 +0000
Message-Id: <20240111152429.3374566-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240111152429.3374566-1-willy@infradead.org>
References: <20240111152429.3374566-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Call pfn_swap_entry_folio() in __split_huge_pmd_locked() as preparation
for converting mm counter functions to take a folio.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/huge_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5b2da360ae0c..4ad1416b60e3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2432,7 +2432,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			swp_entry_t entry;
 
 			entry = pmd_to_swp_entry(old_pmd);
-			page = pfn_swap_entry_to_page(entry);
+			folio = pfn_swap_entry_folio(entry);
 		} else {
 			page = pmd_page(old_pmd);
 			folio = page_folio(page);
@@ -2443,7 +2443,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			folio_remove_rmap_pmd(folio, page, vma);
 			folio_put(folio);
 		}
-		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
+		add_mm_counter(mm, mm_counter_file(&folio->page), -HPAGE_PMD_NR);
 		return;
 	}
 
-- 
2.43.0


