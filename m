Return-Path: <linux-s390+bounces-5160-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D87493FD8D
	for <lists+linux-s390@lfdr.de>; Mon, 29 Jul 2024 20:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDD7281BA3
	for <lists+linux-s390@lfdr.de>; Mon, 29 Jul 2024 18:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71135186E3B;
	Mon, 29 Jul 2024 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2yH0TZu"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC43186E24
	for <linux-s390@vger.kernel.org>; Mon, 29 Jul 2024 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278362; cv=none; b=hscOc5+xi/qTgx/GwLF1++IDRJOP+OqulH2l8pXrLqS5aqwQSEOHCmUSmcnMVrlXOxx6EzFqoPeNA47LNVUOUlfHxtbUQFGt9IYA+uR+QzmufE1iMcJF0skM4ZGxPzL3vGQnYyVre+tG9Javr7bIjlOf8+Q5kHxBIfLxMT3QEkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278362; c=relaxed/simple;
	bh=WS1XPhQwnhOA8zYMUiuwouo9AFcA8auwgelO1865fr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3GTBY6BzwM9t6MuqoKgkLypyBiyWgxmmS4DQIZkQhxtEJ5eRoFZNHAeWD5mWur7BWP7Bx/MdbfbUeNaRU+H6ePzszflyuV8R0iLq0q9jNPlFn4w7n2oolTrlF8xoAKiEF5RVKlDeMS32D1Q6WiA1e8eUUDrbXFfho63HJgKxLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2yH0TZu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722278359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exvRAG2tHq6VgTaD/fmuS7ZLph4K5zUJO/hhwy+FasE=;
	b=a2yH0TZuQ6hg4tyFJV5lmTKiV+gCvMBdyAh5DSIlR1QiChtsYglk+P9cJ6aNiw5SsdNVq0
	jfiC32+sX0NsTJzW8M+kLnbSSf6rThvhzQKjCgOT7SGB6BpOJz8RZhwjTsLa7JTtaXPXz0
	in5L9iD8Uwkpwo0egsH66KM2l0gIVMo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-8rBTIKH0MemeRNuEhQNSCw-1; Mon,
 29 Jul 2024 14:39:15 -0400
X-MC-Unique: 8rBTIKH0MemeRNuEhQNSCw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FB9A1956064;
	Mon, 29 Jul 2024 18:39:13 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 079E61955D45;
	Mon, 29 Jul 2024 18:39:07 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 2/3] mm/gup: convert to arch_make_folio_accessible()
Date: Mon, 29 Jul 2024 20:38:43 +0200
Message-ID: <20240729183844.388481-3-david@redhat.com>
In-Reply-To: <20240729183844.388481-1-david@redhat.com>
References: <20240729183844.388481-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Let's use arch_make_folio_accessible() instead so we can get rid of
arch_make_page_accessible().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 120740cf5a348..3e8484c893aa8 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -819,6 +819,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		struct dev_pagemap **pgmap)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	struct folio *folio;
 	struct page *page;
 	spinlock_t *ptl;
 	pte_t *ptep, pte;
@@ -876,6 +877,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 			goto out;
 		}
 	}
+	folio = page_folio(page);
 
 	if (!pte_write(pte) && gup_must_unshare(vma, flags, page)) {
 		page = ERR_PTR(-EMLINK);
@@ -886,7 +888,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		       !PageAnonExclusive(page), page);
 
 	/* try_grab_folio() does nothing unless FOLL_GET or FOLL_PIN is set. */
-	ret = try_grab_folio(page_folio(page), 1, flags);
+	ret = try_grab_folio(folio, 1, flags);
 	if (unlikely(ret)) {
 		page = ERR_PTR(ret);
 		goto out;
@@ -898,7 +900,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	 * Documentation/core-api/pin_user_pages.rst for details.
 	 */
 	if (flags & FOLL_PIN) {
-		ret = arch_make_page_accessible(page);
+		ret = arch_make_folio_accessible(folio);
 		if (ret) {
 			unpin_user_page(page);
 			page = ERR_PTR(ret);
@@ -2919,7 +2921,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		 * details.
 		 */
 		if (flags & FOLL_PIN) {
-			ret = arch_make_page_accessible(page);
+			ret = arch_make_folio_accessible(folio);
 			if (ret) {
 				gup_put_folio(folio, 1, flags);
 				goto pte_unmap;
-- 
2.45.2


