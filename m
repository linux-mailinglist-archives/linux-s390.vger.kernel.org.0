Return-Path: <linux-s390+bounces-8041-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E459DA04507
	for <lists+linux-s390@lfdr.de>; Tue,  7 Jan 2025 16:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9351665B0
	for <lists+linux-s390@lfdr.de>; Tue,  7 Jan 2025 15:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50711F4295;
	Tue,  7 Jan 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZEsNxIZ"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7BD1F3D31
	for <linux-s390@vger.kernel.org>; Tue,  7 Jan 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264638; cv=none; b=nXe208tv6RTo0rxUoZ20LzoL1GG/yhS8if3FgH2QuBKT9cIyMGhntYX8PMbpINNKjzMoYybxozoCVVdOS5VOXiXa5jMvnzx3rLRjxuB2BrirKBETsjSfTAUqyPiExGNxj6IqdKjlbe3BMf/YCS41KHO2fDPVCmZNxS1akKOHUFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264638; c=relaxed/simple;
	bh=L+CPO+OXcYMowj2nsp4a3RdcFfWPLoQzNe/QJrtHqCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKTfcCUL6X8LeK2EKxABEIDbvwXFzOthImgE4Bxo3okSYMeIWZ043SwhVVv1XO8AtDNDAQ4+GORKOwnBQ/g14sS8aojdiLpJcP6vcFJ6ZzjJCoSSxIC+5+fGJ4ok9Tk8oaq08CTdJZQ8RyIvLDVwdQHGpDm99jRiTr2Ea4Jxp7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZEsNxIZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736264636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuA9xO+YQCmgV3vJM4yzlrCIirQZOm8j6HpoB+CK45c=;
	b=NZEsNxIZZN1+4OVdIhFw+7sQGoiC3eJYHcTOGgZm9o1pnyRLUgdajf5gPzVBwae9h7idwV
	gdDv/qAfr9vazKBJPPVK4CbWfu6NaapOBKLVEuASO4thGhaIHX+U2iMnxeTHbeMMUOnuKS
	T7pbPnJaXZrhzCM5zgFXPbHINWVOBBA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-vgFzjX9sNAGMJhaNihLlQw-1; Tue, 07 Jan 2025 10:43:54 -0500
X-MC-Unique: vgFzjX9sNAGMJhaNihLlQw-1
X-Mimecast-MFC-AGG-ID: vgFzjX9sNAGMJhaNihLlQw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361b090d23so44024465e9.0
        for <linux-s390@vger.kernel.org>; Tue, 07 Jan 2025 07:43:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736264633; x=1736869433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuA9xO+YQCmgV3vJM4yzlrCIirQZOm8j6HpoB+CK45c=;
        b=FEBh8uTs2V6+33y2u/gk/CQIrkyIoEG7+SaY9xs9NdffGyjxr/Dix3878YIFdhNM5A
         Qj8mRHPeYIaQ3jPHVa6bzlTwjzir/IID+sgDMHzmhIUtxq9VHNUM2qHqnpRaXcO3tJpE
         OyJikvX4mbPeyYZulR+k1SkyIpNDrNOzIOJsqYHC6EbvRIvRivoqsl+nku4evV9qWhiS
         3TTEIwsJLUAaE+cU+NNx8ODZWRGIrmeUkPkj3J1hr728fdNHbVV2c7n4l2svOls8Y7fP
         X6ULBpTOr70GrHdOaPtS+SsBMlyAkOxasCS4ckxhAvgIEYIpLWoD8te/IjlljlmXpWo8
         yL8A==
X-Forwarded-Encrypted: i=1; AJvYcCVTR6F/YoORoxLhZjfnd3iCDqysqwACOZ+xYNUK0Lpf5A/aeUeyeCgKUjwdl78jSFpA8Q2xjLx/RWQl@vger.kernel.org
X-Gm-Message-State: AOJu0YyPA7igwFs/HuI0TRpQ0EWj0aiIRHhv4lGs9joG451pYQjspaW9
	bOzFmRSvvEMhUGWVS7aB2xfFW14zZQLhbT5VGSz663qmfw1EUuIoMKZjooGyfPRhxuKdKchWcRN
	iIplGSMY4U8AuXGHl99iV9JxlGHiqLLHpk0Hzy/c16MLw9yy4Wf8LKCTqL44=
X-Gm-Gg: ASbGncv1qOAq9hlv4y/MzUIOCAeQETl/gn0MW6rKXrAFbgvkgTbYr7Pj+SXNpt24Jy9
	0b/lgP7W7eJM4Hp3m+mutXVUg6ao2jHn3PPbHYGt4vKwHd3gsf1Gpgqa+yOcP0iA5/XTE4+BoAg
	odNPqwkCyC3wRzOzuVxgmLiD1sumLsxBkm5HmWj3DC/uXdmBbc0Z2OHXaXWafI85wp1SzPZ9y+8
	DJJ26PCnMGact/4UK74XN8bIXll+NNqS2vMyiIXgmagR+O7u2GLcvNhcztovknPEpRhr5XUdArd
	L7mqJZ4aoowlpMa/a1P/eO3WyPQzD3Xt0anTaPTgLw==
X-Received: by 2002:a05:600c:4f92:b0:436:488f:50a with SMTP id 5b1f17b1804b1-43668646896mr573017705e9.17.1736264633482;
        Tue, 07 Jan 2025 07:43:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh8YfTHFHS4ct6XJT1582QW2xCuoEvw06dxSlo9D6j1V3t/nUHTzhQ92uwlzN3QPUXJktBRA==
X-Received: by 2002:a05:600c:4f92:b0:436:488f:50a with SMTP id 5b1f17b1804b1-43668646896mr573017315e9.17.1736264632960;
        Tue, 07 Jan 2025 07:43:52 -0800 (PST)
Received: from localhost (p200300cbc719170056dc6a88b509d3f3.dip0.t-ipconnect.de. [2003:cb:c719:1700:56dc:6a88:b509:d3f3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43656b013ecsm635054145e9.16.2025.01.07.07.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 07:43:51 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Huth <thuth@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v1 3/4] KVM: s390: vsie: stop messing with page refcount
Date: Tue,  7 Jan 2025 16:43:43 +0100
Message-ID: <20250107154344.1003072-4-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107154344.1003072-1-david@redhat.com>
References: <20250107154344.1003072-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's stop messing with the page refcount, and use a flag that is set /
cleared atomically to remember whether a vsie page is currently in use.

Note that we could use a page flag, or a lower bit of the scb_gpa. Let's
keep it simple for now, we have sufficient space.

While at it, stop passing "struct kvm *" to put_vsie_page(), it's
unused.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/vsie.c | 46 +++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 00cd9a27fd8fc..29fdffeab635d 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -23,6 +23,10 @@
 #include "kvm-s390.h"
 #include "gaccess.h"
 
+enum vsie_page_flags {
+	VSIE_PAGE_IN_USE = 0,
+};
+
 struct vsie_page {
 	struct kvm_s390_sie_block scb_s;	/* 0x0000 */
 	/*
@@ -52,7 +56,12 @@ struct vsie_page {
 	 * radix tree.
 	 */
 	gpa_t scb_gpa;				/* 0x0258 */
-	__u8 reserved[0x0700 - 0x0260];		/* 0x0260 */
+	/*
+	 * Flags: must be set/cleared atomically after the vsie page can be
+	 * looked up by other CPUs.
+	 */
+	unsigned long flags;			/* 0x0260 */
+	__u8 reserved[0x0700 - 0x0268];		/* 0x0268 */
 	struct kvm_s390_crypto_cb crycb;	/* 0x0700 */
 	__u8 fac[S390_ARCH_FAC_LIST_SIZE_BYTE];	/* 0x0800 */
 };
@@ -1351,6 +1360,20 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return rc;
 }
 
+/* Try getting a given vsie page, returning "true" on success. */
+static inline bool try_get_vsie_page(struct vsie_page *vsie_page)
+{
+	if (test_bit(VSIE_PAGE_IN_USE, &vsie_page->flags))
+		return false;
+	return !test_and_set_bit(VSIE_PAGE_IN_USE, &vsie_page->flags);
+}
+
+/* Put a vsie page acquired through get_vsie_page / try_get_vsie_page. */
+static void put_vsie_page(struct vsie_page *vsie_page)
+{
+	clear_bit(VSIE_PAGE_IN_USE, &vsie_page->flags);
+}
+
 /*
  * Get or create a vsie page for a scb address.
  *
@@ -1369,15 +1392,15 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 	rcu_read_unlock();
 	if (page) {
 		vsie_page = page_to_virt(page);
-		if (page_ref_inc_return(page) == 2) {
+		if (try_get_vsie_page(vsie_page)) {
 			if (vsie_page->scb_gpa == addr)
 				return vsie_page;
 			/*
 			 * We raced with someone reusing + putting this vsie
 			 * page before we grabbed it.
 			 */
+			put_vsie_page(vsie_page);
 		}
-		page_ref_dec(page);
 	}
 
 	/*
@@ -1394,7 +1417,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 			return ERR_PTR(-ENOMEM);
 		}
 		vsie_page = page_to_virt(page);
-		page_ref_inc(page);
+		__set_bit(VSIE_PAGE_IN_USE, &vsie_page->flags);
 		kvm->arch.vsie.pages[kvm->arch.vsie.page_count] = page;
 		kvm->arch.vsie.page_count++;
 	} else {
@@ -1402,9 +1425,8 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 		while (true) {
 			page = kvm->arch.vsie.pages[kvm->arch.vsie.next];
 			vsie_page = page_to_virt(page);
-			if (page_ref_inc_return(page) == 2)
+			if (try_get_vsie_page(vsie_page))
 				break;
-			page_ref_dec(page);
 			kvm->arch.vsie.next++;
 			kvm->arch.vsie.next %= nr_vcpus;
 		}
@@ -1417,7 +1439,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 
 	/* Double use of the same address or allocation failure. */
 	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> 9, page)) {
-		page_ref_dec(page);
+		put_vsie_page(vsie_page);
 		mutex_unlock(&kvm->arch.vsie.mutex);
 		return NULL;
 	}
@@ -1431,14 +1453,6 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 	return vsie_page;
 }
 
-/* put a vsie page acquired via get_vsie_page */
-static void put_vsie_page(struct kvm *kvm, struct vsie_page *vsie_page)
-{
-	struct page *page = pfn_to_page(__pa(vsie_page) >> PAGE_SHIFT);
-
-	page_ref_dec(page);
-}
-
 int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 {
 	struct vsie_page *vsie_page;
@@ -1489,7 +1503,7 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 out_unpin_scb:
 	unpin_scb(vcpu, vsie_page, scb_addr);
 out_put:
-	put_vsie_page(vcpu->kvm, vsie_page);
+	put_vsie_page(vsie_page);
 
 	return rc < 0 ? rc : 0;
 }
-- 
2.47.1


