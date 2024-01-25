Return-Path: <linux-s390+bounces-1178-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C368B83CC41
	for <lists+linux-s390@lfdr.de>; Thu, 25 Jan 2024 20:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026C91C22F4C
	for <lists+linux-s390@lfdr.de>; Thu, 25 Jan 2024 19:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64521350F2;
	Thu, 25 Jan 2024 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaQ7wxje"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420D0135405
	for <linux-s390@vger.kernel.org>; Thu, 25 Jan 2024 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211208; cv=none; b=L1QgvGS/IqCpcrCod95VN+rn02IzJDbGF5LcDHlMB6xFWxWLprkIjuC/prRfqX3/asQ0WBT61CgtAQVVdnIV8vzk3iaWRO1jHOXdzGpaoykipA3gT7oz0joMCzFWJWmf0LyMpD26XtN+upU8FriQNJD9dVg3fIaJ+7+syNW5ikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211208; c=relaxed/simple;
	bh=ND89z77MFR+zvpNlTF7OTYgSP6ZPtepphjakoIxc3F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEBZE5VLTMRPM/ZBoAbm7NeFyxAXHyk4BkZaGvfNci9GssClLLJjlgHx/yIS84WwPP+Kl/2rw74HilVYzEZaWpSVfxMjef97s+/kM3kIXMmD1LX57M4xsXVJYCHie5/mHwm8nBpmWHyEDqOb3RtBsi/OQ7DciM6bcar2kayJ0qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MaQ7wxje; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706211206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+md2pmrHp48BftcWE7oPMr3+y6qzWNOJ1IOyjx24C4k=;
	b=MaQ7wxjepuddR8lxE8oQ6lAAnDFZ0ar41559IlqraJvzNFYz7Eq5mpDdx24bO4BWz5knNz
	TplxOeY9sL65KW/DC1WKWnUSs7tS04OLrwh2XUYCWThDYzCVqcrQCQS5fXwF9Iu7iGUGGP
	MIxQyUJOMKtW4DUO7bh0y9snC8qmhn4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-07MQqOk2OR24s5b8tCmCuA-1; Thu, 25 Jan 2024 14:33:24 -0500
X-MC-Unique: 07MQqOk2OR24s5b8tCmCuA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 658038432A2;
	Thu, 25 Jan 2024 19:33:22 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.154])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A4DC1492BC6;
	Thu, 25 Jan 2024 19:33:15 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v2 08/15] mm/pgtable: make pte_next_pfn() independent of set_ptes()
Date: Thu, 25 Jan 2024 20:32:20 +0100
Message-ID: <20240125193227.444072-9-david@redhat.com>
In-Reply-To: <20240125193227.444072-1-david@redhat.com>
References: <20240125193227.444072-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Let's provide pte_next_pfn(), independently of set_ptes(). This allows for
using the generic pte_next_pfn() version in some arch-specific set_ptes()
implementations, and prepares for reusing pte_next_pfn() in other context.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index f6d0e3513948a..351cd9dc7194f 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -212,7 +212,6 @@ static inline int pmd_dirty(pmd_t pmd)
 #define arch_flush_lazy_mmu_mode()	do {} while (0)
 #endif
 
-#ifndef set_ptes
 
 #ifndef pte_next_pfn
 static inline pte_t pte_next_pfn(pte_t pte)
@@ -221,6 +220,7 @@ static inline pte_t pte_next_pfn(pte_t pte)
 }
 #endif
 
+#ifndef set_ptes
 /**
  * set_ptes - Map consecutive pages to a contiguous range of addresses.
  * @mm: Address space to map the pages into.
-- 
2.43.0


