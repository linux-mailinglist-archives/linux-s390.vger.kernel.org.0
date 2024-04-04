Return-Path: <linux-s390+bounces-3031-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B101D898C49
	for <lists+linux-s390@lfdr.de>; Thu,  4 Apr 2024 18:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CCDD28A602
	for <lists+linux-s390@lfdr.de>; Thu,  4 Apr 2024 16:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820A312D759;
	Thu,  4 Apr 2024 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FuiPsrtU"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F4A12BEBC
	for <linux-s390@vger.kernel.org>; Thu,  4 Apr 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248642; cv=none; b=Tn0echeRzYgie9Yqn6Qfu7sQlpiw+WuWvPdi4syQ1I6d7EfVX/k4fFmy5PKfZIcAFdhN4FcA2p0TD+G9pbniFW9ScD+bpBt8DDm9fKmDp+O5sR7yHoy/z1CzQu6ajd7wAQW+FA2lsDf64WUDywombSvleiaUmpvZ/DwIcFpQVBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248642; c=relaxed/simple;
	bh=czE5N/0J5tmfJlu8WYjn9+LYDN7w0lpHFxch4r4j6P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FT57HMquIAS3h0Qnku2Lqj7ZaDtki8262IHp8/4EMz3t658v2AG+0wQYYN8u8MOf1LW0t3zA0lJiRCDxPhwPHM/INrFWsOuxoqgRKk9ep4S8DmE2aHxi+qsT+i92XicDaIrSVfRJv7Zm6IHScAdzMY/XYu2+KcdwBVAGP2Gp3Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FuiPsrtU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712248639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zaZWU0YkYnbWySa48R8KGwWh1EeftVOr0gzeEuzgbNQ=;
	b=FuiPsrtUEwS56klququJYrgovxyDGt4bRJ5DKftQ+RKYjnziA3xWI4vxMe8ZNW5oGSYGlS
	8+8wl5WdeqIWH7oUIeS9yqRK5cN4hQk7piq2P4ulkQ5v8xyV8h0iLfSBmkWErJ6QAAmeQb
	Vv0mx55/UUSTIdQll1dA13SMtagakWk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-telD-LxGMoCt6ciulojX3A-1; Thu,
 04 Apr 2024 12:37:14 -0400
X-MC-Unique: telD-LxGMoCt6ciulojX3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41945282479F;
	Thu,  4 Apr 2024 16:37:13 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8064E3C24;
	Thu,  4 Apr 2024 16:37:08 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v1 1/5] s390/uv: don't call wait_on_page_writeback() without a reference
Date: Thu,  4 Apr 2024 18:36:38 +0200
Message-ID: <20240404163642.1125529-2-david@redhat.com>
In-Reply-To: <20240404163642.1125529-1-david@redhat.com>
References: <20240404163642.1125529-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

wait_on_page_writeback() requires that no spinlocks are held and that
a page reference is held, as documented for folio_wait_writeback(). After
we dropped the PTL, the page could get freed concurrently. So grab a
temporary reference.

Fixes: 214d9bbcd3a6 ("s390/mm: provide memory management functions for protected KVM guests")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kernel/uv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index fc07bc39e698..7401838b960b 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -314,6 +314,13 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 			rc = make_page_secure(page, uvcb);
 			unlock_page(page);
 		}
+
+		/*
+		 * Once we drop the PTL, the page may get unmapped and
+		 * freed immediately. We need a temporary reference.
+		 */
+		if (rc == -EAGAIN)
+			get_page(page);
 	}
 	pte_unmap_unlock(ptep, ptelock);
 out:
@@ -325,6 +332,7 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 		 * completion, this is just a useless check, but it is safe.
 		 */
 		wait_on_page_writeback(page);
+		put_page(page);
 	} else if (rc == -EBUSY) {
 		/*
 		 * If we have tried a local drain and the page refcount
-- 
2.44.0


