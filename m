Return-Path: <linux-s390+bounces-5328-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FF8946110
	for <lists+linux-s390@lfdr.de>; Fri,  2 Aug 2024 17:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81721F21B98
	for <lists+linux-s390@lfdr.de>; Fri,  2 Aug 2024 15:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16DD166F10;
	Fri,  2 Aug 2024 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ez6dU6sU"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8653DABF4
	for <linux-s390@vger.kernel.org>; Fri,  2 Aug 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614193; cv=none; b=MUe45DFupWGn6wKXTDmJ8qmSt1//xqiSabva3xl2aXEwLeWAPJYvL4KGM5iWyDKSF6m+vIjJflhiIj2IculfBfREkyajJJz1ejWROKpQKc/k+oQqBWCJ0QCqgaY1jEUvUwCuf6MfW5ThxU5L1rKWoY9vYlZ+h/UtdDET4f8p2fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614193; c=relaxed/simple;
	bh=2IhrE8Vmt4VK8rVWOEfE0I0BvwytyEl+f20lNv5wS/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upDqZ2FAtR5jo6qDGQpaCENF/6mrgYxObIULvzx979bOiNzTLZDUSBbCC91jkp0utu5bp7LQM07skbhiAZ/qs/J3r2I4XOKO5c7mI0OhV29jJmn6shDYgBuN6eyLNAdDFi7XNNAOlNfasLtpAp9IC1FTtctgkjEJ8X5fr3281v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ez6dU6sU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722614191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjcECCTgCmWZTwab+g/RP394PBHLh37fGlT1XvTATXs=;
	b=Ez6dU6sUUVKUBcMTfOOZmSldxqoqDpnZNwF3ugBJLfqJpP5wMK2L/nJR3kt70Ry6jCME+I
	XOQ/vEoDJKzzJcjTyBMuuNx+cDsiuV+W40wfJlobC65B6Vo83THEfYRvkE7hV84pAoS83m
	xLoLB8eLD3NQdugJHDQAqbZXMncT8U8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-WFy2ItSoPW6bK_LvEE1k_Q-1; Fri,
 02 Aug 2024 11:56:29 -0400
X-MC-Unique: WFy2ItSoPW6bK_LvEE1k_Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95BE31910417;
	Fri,  2 Aug 2024 15:56:26 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11D163000198;
	Fri,  2 Aug 2024 15:56:19 +0000 (UTC)
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
Subject: [PATCH v1 08/11] s390/uv: convert gmap_destroy_page() from follow_page() to folio_walk
Date: Fri,  2 Aug 2024 17:55:21 +0200
Message-ID: <20240802155524.517137-9-david@redhat.com>
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

Let's get rid of another follow_page() user and perform the UV calls
under PTL -- which likely should be fine.

No need for an additional reference while holding the PTL:
uv_destroy_folio() and uv_convert_from_secure_folio() raise the
refcount, so any concurrent make_folio_secure() would see an unexpted
reference and cannot set PG_arch_1 concurrently.

Do we really need a writable PTE? Likely yes, because the "destroy"
part is, in comparison to the export, a destructive operation. So we'll
keep the writability check for now.

We'll lose the secretmem check from follow_page(). Likely we don't care
about that here.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kernel/uv.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 35ed2aea8891..9646f773208a 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -14,6 +14,7 @@
 #include <linux/memblock.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
+#include <linux/pagewalk.h>
 #include <asm/facility.h>
 #include <asm/sections.h>
 #include <asm/uv.h>
@@ -462,9 +463,9 @@ EXPORT_SYMBOL_GPL(gmap_convert_to_secure);
 int gmap_destroy_page(struct gmap *gmap, unsigned long gaddr)
 {
 	struct vm_area_struct *vma;
+	struct folio_walk fw;
 	unsigned long uaddr;
 	struct folio *folio;
-	struct page *page;
 	int rc;
 
 	rc = -EFAULT;
@@ -483,11 +484,15 @@ int gmap_destroy_page(struct gmap *gmap, unsigned long gaddr)
 		goto out;
 
 	rc = 0;
-	/* we take an extra reference here */
-	page = follow_page(vma, uaddr, FOLL_WRITE | FOLL_GET);
-	if (IS_ERR_OR_NULL(page))
+	folio = folio_walk_start(&fw, vma, uaddr, 0);
+	if (!folio)
 		goto out;
-	folio = page_folio(page);
+	/*
+	 * See gmap_make_secure(): large folios cannot be secure. Small
+	 * folio implies FW_LEVEL_PTE.
+	 */
+	if (folio_test_large(folio) || !pte_write(fw.pte))
+		goto out_walk_end;
 	rc = uv_destroy_folio(folio);
 	/*
 	 * Fault handlers can race; it is possible that two CPUs will fault
@@ -500,7 +505,8 @@ int gmap_destroy_page(struct gmap *gmap, unsigned long gaddr)
 	 */
 	if (rc)
 		rc = uv_convert_from_secure_folio(folio);
-	folio_put(folio);
+out_walk_end:
+	folio_walk_end(&fw, vma);
 out:
 	mmap_read_unlock(gmap->mm);
 	return rc;
-- 
2.45.2


