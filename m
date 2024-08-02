Return-Path: <linux-s390+bounces-5323-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B609460F7
	for <lists+linux-s390@lfdr.de>; Fri,  2 Aug 2024 17:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4502281DC5
	for <lists+linux-s390@lfdr.de>; Fri,  2 Aug 2024 15:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EF215C123;
	Fri,  2 Aug 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+cesQTA"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE50166F25
	for <linux-s390@vger.kernel.org>; Fri,  2 Aug 2024 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614162; cv=none; b=lOrXxVaoHzyLWgZjToYLS/+CFOeJbkrLif7S4eJS3XPY57nXCypfrlopMZIfFzqQxWUm0SjCc6ueqRy5qCiG0L+P2Pu5/gis6XZVpemuxNNFDg5UmboFk+J7HLs4Msg2U6QIEPQiIGQU3mHbl9P9yKwyb0BC7cHOaH7MVgsM214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614162; c=relaxed/simple;
	bh=bP6pH0ekuQFtmuSKGa8PXlt8u6jV+CJT+tkCQ3nBDTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ht043NARE5HbWOAqxKQw8T1Ba2Fse8jONy3FdOeRdWr+mTqmsyG0kL6qFsL8TLGHA8wOXlfcOhj6eHGZI8QcV/5uPXx0QXXHLWSpjveR9O6Ibp9+VerSbgdhqsktdamYXq9TpzsYHNL14egDowDOoXcN4bZZ9mTtIEjAi/bFZ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+cesQTA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722614160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bw5wWvDZXB6NwMKpULq7b52Hk472J0+TTnpqg3dn/tg=;
	b=A+cesQTAoJsxY4J7ttbEeGNrojHGELb2inQ658Asa+Jr59h/FmxlENsave0VRSuh5n832n
	On4mzvDdzlgBXupJoja5iXFqlDP6alRCwHQQ/rqOFroCOPQL+nd1T2xWHNKHV88rZ/J1t+
	GAfdTt5arp8cX0nK+eE86dn+otuavPM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-0uIxfBSuNxWDrKG_hH-lfg-1; Fri,
 02 Aug 2024 11:55:55 -0400
X-MC-Unique: 0uIxfBSuNxWDrKG_hH-lfg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2085618B669A;
	Fri,  2 Aug 2024 15:55:53 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A8A8F3000198;
	Fri,  2 Aug 2024 15:55:46 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [PATCH v1 03/11] mm/migrate: convert do_pages_stat_array() from follow_page() to folio_walk
Date: Fri,  2 Aug 2024 17:55:16 +0200
Message-ID: <20240802155524.517137-4-david@redhat.com>
In-Reply-To: <20240802155524.517137-1-david@redhat.com>
References: <20240802155524.517137-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Let's use folio_walk instead, so we can avoid taking a folio reference
just to read the nid and get rid of another follow_page()/FOLL_DUMP
user. Use FW_ZEROPAGE so we can return "-EFAULT" for it as documented.

The possible return values for follow_page() were confusing, especially
with FOLL_DUMP set. We'll handle it like documented in the man page:

* -EFAULT: This is a zero page or the memory area is not mapped by the
   process.
* -ENOENT: The page is not present.

We'll keep setting -ENOENT for ZONE_DEVICE. Maybe not the right thing to
do, but it likely doesn't really matter (just like for weird devmap,
whereby we fake "not present").

Note that the other errors (-EACCESS, -EBUSY, -EIO, -EINVAL, -ENOMEM)
so far only applied when actually moving pages, not when only
querying stats.

We'll effectively drop the "secretmem" check we had in follow_page(), but
that shouldn't really matter here, we're not accessing folio/page content
after all.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index aa482c954cb0..b5365a434ba9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -50,6 +50,7 @@
 #include <linux/random.h>
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
+#include <linux/pagewalk.h>
 
 #include <asm/tlbflush.h>
 
@@ -2331,28 +2332,26 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 	for (i = 0; i < nr_pages; i++) {
 		unsigned long addr = (unsigned long)(*pages);
 		struct vm_area_struct *vma;
-		struct page *page;
+		struct folio_walk fw;
+		struct folio *folio;
 		int err = -EFAULT;
 
 		vma = vma_lookup(mm, addr);
 		if (!vma)
 			goto set_status;
 
-		/* FOLL_DUMP to ignore special (like zero) pages */
-		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
-
-		err = PTR_ERR(page);
-		if (IS_ERR(page))
-			goto set_status;
-
-		err = -ENOENT;
-		if (!page)
-			goto set_status;
-
-		if (!is_zone_device_page(page))
-			err = page_to_nid(page);
-
-		put_page(page);
+		folio = folio_walk_start(&fw, vma, addr, FW_ZEROPAGE);
+		if (folio) {
+			if (is_zero_folio(folio) || is_huge_zero_folio(folio))
+				err = -EFAULT;
+			else if (folio_is_zone_device(folio))
+				err = -ENOENT;
+			else
+				err = folio_nid(folio);
+			folio_walk_end(&fw, vma);
+		} else {
+			err = -ENOENT;
+		}
 set_status:
 		*status = err;
 
-- 
2.45.2


