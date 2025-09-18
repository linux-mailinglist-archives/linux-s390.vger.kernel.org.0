Return-Path: <linux-s390+bounces-12110-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FC3B304DB
	for <lists+linux-s390@lfdr.de>; Thu, 21 Aug 2025 22:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3E916E1F8
	for <lists+linux-s390@lfdr.de>; Thu, 21 Aug 2025 20:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B90D350D66;
	Thu, 21 Aug 2025 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Khicoxdz"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB7436CC9B
	for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 20:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806897; cv=none; b=hr5ZfhKzSg5C2mJdEh1dUu4TzYls+xfPTSXac6APjCdgIDfpJmslg+L8Xj20lxzd9L85NXf+sgS1MUR+yTc9pgbisp9e98kiLhTir9ojWGUa2bgBIRH5LHHt75m9uHkhqEP5Gt1ZkC4XMeqUFZVuMBRAj+hYYFD8DwZyDDTSkbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806897; c=relaxed/simple;
	bh=kURokXQjB5Kuo7a6U8usTL1aQ1tfaOTG2Bf9aj2NBoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGpqePNEOsOgo8CVtPszDmo05IfohZrnOptARl3LwCHhINcFmgze3lOMU5nDarFc4RR2MkwEaLQrCxDy9dNeTbuoG4WJpGhUAvx/Q6OyFDTAc0jiqkrxSqhbxFVAwDny4HqMT6hT//l5OKjFc4S83YH0+HCH16jyvxxP+pKoZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Khicoxdz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NKFS9/TuG2v9AIcAoooIJr3bGKW6zmP0XL+5izT5Y+4=;
	b=KhicoxdzduubvKuf9Iix+KNDtDzlxsA85V/w/CkCqx1xtIvlyjeP3gOZ/UnD/kHm56z7up
	eS44Wa9teIG8fACDAtSRj0kPBZVX2cqe191Dx4vfjIoobrYjhQVYZW022ea1CcbPdqagcY
	qnSL7AEaR1rOqyOpAnE/tpK//DFlKbQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-QmjZLB51NGWrSL4IVJRWLw-1; Thu, 21 Aug 2025 16:08:13 -0400
X-MC-Unique: QmjZLB51NGWrSL4IVJRWLw-1
X-Mimecast-MFC-AGG-ID: QmjZLB51NGWrSL4IVJRWLw_1755806892
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b05d251so7744145e9.1
        for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 13:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806892; x=1756411692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKFS9/TuG2v9AIcAoooIJr3bGKW6zmP0XL+5izT5Y+4=;
        b=rk7nbczazcalZ95iiTpweVJGPSqxDyx4dWBaiWxtS3616MlyQzV9fJl57d9iZKzmr6
         aQYQcHNHOxFk8+YJHpG0VczIc1YmYK9qHOupQ91wKRRQTb7igrBRLuP4KoZCAj/9iUEY
         ie3+nTORtSosdMJ3tgdbfOHkN+AnyHCo2NYIGK5USuPn2tMFb2HV8z7at/1FpSMbLEDy
         OR0YN3IXTgQh0wYfBmxsBPQqxFhOSaj8/y0O7xj4+CF39ZJAZu/Yh2qsdSt3UsuEfRQo
         HPABAZ/mW9yeVs5tr21Lje9qeaSiJToPhWY20auGhFtXcm91pn09ZT8thbrvbnLYYPWG
         Cq4g==
X-Forwarded-Encrypted: i=1; AJvYcCXlx3ExpAUFA/n4jUsNwe/akChfUINRpz/gYRbg8WbyBm91sbaqfqkV3vEqVIC8jUQ7iI7IhfmwNXGc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbaw9PgZ1sdP0NlqA+2sS2TrczCwFOloyGq27ECEd9LkCxYtlT
	AJ7afVg7tNcFYNJSdvV5Un8oGQXeLCDaTnZFoYt5mLWYFjdMOnWN3qt+feofwNScTu7mggNstl8
	LEkd+PzWGn8p2eJr9rQTkAP5l2Do0GBwSlGDtVDFojtNFVcZO7Do17mBDSiRJqWs=
X-Gm-Gg: ASbGnctN9751UKYjIjt14CfQr6yi5of4AsH+hnycD4MSfZ50cnwZ3vx+0/Ovzqy0Y61
	drgm6KIgM/tQUuOsN8m2hYE9lZkE/3zvqQmwW/PMvJX1QjQTMqEvpiLXkEuq2aji+DuCeE5y3bp
	SrO8ckkyLIz+Gtk7Z3xKgXzk4yuMrh/aCVILYqUDWUC9FIjExKsJsGIuJG3Xg1DRvqWAicH7rU+
	7Jrt6X7IhiJcIcYDrYrR2yUpMPYFcFHYnkPk/McypbcYzZ+Eauk5ED+ytb1u71bCw8lVtN2smoG
	CcHMFVZeAXhfvO8tRorNdrYJIQlRh5dnZT3M7ee7gkhYrfnjWHNnzA40B6XMiw2Zg+8Nl6oXMqC
	NngB6NBUh0LUX/4RypjwMkQ==
X-Received: by 2002:a05:600c:1f1a:b0:45b:43cc:e557 with SMTP id 5b1f17b1804b1-45b517cbee2mr2552765e9.34.1755806891791;
        Thu, 21 Aug 2025 13:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/z26sBz7JGLAktk/cnLNnmvA2KmHoRy5M1TseKC0NpCNohvOWfWbiwnk6fyruz4Gv4BdEig==
X-Received: by 2002:a05:600c:1f1a:b0:45b:43cc:e557 with SMTP id 5b1f17b1804b1-45b517cbee2mr2552235e9.34.1755806891155;
        Thu, 21 Aug 2025 13:08:11 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c0748797acsm12277591f8f.10.2025.08.21.13.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:10 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 23/35] scatterlist: disallow non-contigous page ranges in a single SG entry
Date: Thu, 21 Aug 2025 22:06:49 +0200
Message-ID: <20250821200701.1329277-24-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The expectation is that there is currently no user that would pass in
non-contigous page ranges: no allocator, not even VMA, will hand these
out.

The only problematic part would be if someone would provide a range
obtained directly from memblock, or manually merge problematic ranges.
If we find such cases, we should fix them to create separate
SG entries.

Let's check in sg_set_page() that this is really the case. No need to
check in sg_set_folio(), as pages in a folio are guaranteed to be
contiguous.

We can now drop the nth_page() usage in sg_page_iter_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/scatterlist.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 6f8a4965f9b98..8196949dfc82c 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <linux/bug.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <asm/io.h>
 
 struct scatterlist {
@@ -158,6 +159,7 @@ static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
 static inline void sg_set_page(struct scatterlist *sg, struct page *page,
 			       unsigned int len, unsigned int offset)
 {
+	VM_WARN_ON_ONCE(!page_range_contiguous(page, ALIGN(len + offset, PAGE_SIZE) / PAGE_SIZE));
 	sg_assign_page(sg, page);
 	sg->offset = offset;
 	sg->length = len;
@@ -600,7 +602,7 @@ void __sg_page_iter_start(struct sg_page_iter *piter,
  */
 static inline struct page *sg_page_iter_page(struct sg_page_iter *piter)
 {
-	return nth_page(sg_page(piter->sg), piter->sg_pgoffset);
+	return sg_page(piter->sg) + piter->sg_pgoffset;
 }
 
 /**
-- 
2.50.1


