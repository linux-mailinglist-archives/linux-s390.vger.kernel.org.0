Return-Path: <linux-s390+bounces-1115-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD308390F9
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jan 2024 15:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60864B257B1
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jan 2024 14:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305115FEF3;
	Tue, 23 Jan 2024 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXJIhTW2"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBFE5FDD5
	for <linux-s390@vger.kernel.org>; Tue, 23 Jan 2024 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019224; cv=none; b=uKNbJmj5vcNSlafq0qqprFlIHKwbtxQxUIJcwzCiwLFx5TV28NmJvwFu7Z2XDgaT1M5c9HC1cBeo0oKi0DZWQElRl089m4oHMrO/KtLc7xaqvkPVj8guofKAup+lYVAY2azyd5Bb7r4Z4hsaku+q4Ty35gR/vUc8fZP85Au2DpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019224; c=relaxed/simple;
	bh=JXniqWhpXjjSE85A2+O+umaCKvwDugv6FvrDPXKER24=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=M3HeH43Xd2LeZP2nAX9yNryTWQK5bhQB2bboSa5+yQOlt3r39j9CE3OJams7nR+KIC6T0+Bp11HxvuzkbgYkdjlrmwqvwi+XuaATxabSWWBpOYGYxED+nQUpdvpzB7F8NK7w71qfJmXON5nYhe5ZQnC/W8uyUBfceAx1QIe40OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YXJIhTW2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706019221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RwS+5giCvfOuuu1oeULF7LgReztaNbk26JYEakmOz0E=;
	b=YXJIhTW2rVwMkZ+Y2uCNe+wxGcoYpqtKfRabTOTP1hDH4GpSI0C315E8IxjUo9tV0GB8RO
	kX7RtsvR1peykNe9PnRcp81H3rg1MqOOBDd8dKB5Vsf6kp/ALaq0ieMOMJDnf98hueaZ7W
	ACq8Ijbtalr3T5XiVd9Lu82mepx/uM0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-TPtmzN1BN4qM-Oix4XJV8Q-1; Tue, 23 Jan 2024 09:13:39 -0500
X-MC-Unique: TPtmzN1BN4qM-Oix4XJV8Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-337c6828d84so2879462f8f.0
        for <linux-s390@vger.kernel.org>; Tue, 23 Jan 2024 06:13:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706019218; x=1706624018;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RwS+5giCvfOuuu1oeULF7LgReztaNbk26JYEakmOz0E=;
        b=EmBeUIsQYCr5aTCO30Hn7jo71COWS8+j4Xh4ExcEysS3z29XnRJqa3e6lE+hFeY2zM
         18Jpki0rqhf+DurAvPfElVy0q5d/HGg6/1cNdKAFcD0lFoZ5QvKVpohv3OjdHjrZhea5
         HM4DBqFkb/vL3X9DWkzAiYIGYsTD00SsoIgWLoxoEKRV9AkUb5uGiWAjrN0O5w5LsMWR
         QC7tol10Sen3MgLtj3hTvOQh55niAzxdumW4GdjvfZf7Z2cL17ejBejUIcw162YLKsVA
         lzgSXzUJSXD8gtBtdmGfLsGTgy1ewpMyu/zkndGBeSOHxKnIqEJDkfvI6N6z/37D3S8P
         dXnw==
X-Gm-Message-State: AOJu0YxenAeP1CAoy/0vUPjFPT0d3TMB8xMUF3MSuXTCBWZuM+e+k5Cd
	fCyLIROhkPSIxo+oo18BkPcDrPu6Ph1ZraEagFjEnabL5WjcM+rtkHJz1Kq/UtsHUOflzraw6vm
	/XEJaQFBUWdk1Fp6EWAcu8pceQT4EOjKru8NBTxIpxSp4WpcgRXkM43OYLi4=
X-Received: by 2002:a5d:5886:0:b0:337:bf93:7596 with SMTP id n6-20020a5d5886000000b00337bf937596mr3834965wrf.85.1706019217858;
        Tue, 23 Jan 2024 06:13:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5/PbDrLZ9d9AkhvRX6ylFfb0yt8+nxq8gN+w1JFxvjbUHyNqGdzjNBj/Blc446v26+82bXA==
X-Received: by 2002:a5d:5886:0:b0:337:bf93:7596 with SMTP id n6-20020a5d5886000000b00337bf937596mr3834939wrf.85.1706019217481;
        Tue, 23 Jan 2024 06:13:37 -0800 (PST)
Received: from ?IPV6:2003:cb:c741:de00:bf0f:cd46:dc1c:2de9? (p200300cbc741de00bf0fcd46dc1c2de9.dip0.t-ipconnect.de. [2003:cb:c741:de00:bf0f:cd46:dc1c:2de9])
        by smtp.gmail.com with ESMTPSA id cg13-20020a5d5ccd000000b0033927ccc725sm9100696wrb.50.2024.01.23.06.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 06:13:37 -0800 (PST)
Message-ID: <8eb5db8e-33cc-4cbf-a1bf-0da7af230fab@redhat.com>
Date: Tue, 23 Jan 2024 15:13:35 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/11] mm/memory: ignore dirty/accessed/soft-dirty bits
 in folio_pte_batch()
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
References: <20240122194200.381241-1-david@redhat.com>
 <20240122194200.381241-11-david@redhat.com>
 <59592b50-fe89-4b32-8490-2e6c296f972f@arm.com>
 <76740e33-9b52-4e23-b407-8ae38bac15ec@redhat.com>
 <94d33a07-c59a-4315-9c64-8b4d959ca1f4@arm.com>
 <c92c2460-c66a-46c7-b84f-0732965dcf73@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c92c2460-c66a-46c7-b84f-0732965dcf73@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Although now I'm wondering if there is a race here... What happens if a page in
>> the parent becomes dirty after you have checked it but before you write protect
>> it? Isn't that already a problem with the current non-batched version? Why do we
>> even to preserve dirty in the child for private mappings?
> 
> I suspect, because the parent could zap the anon folio. If the folio is
> clean, but the PTE dirty, I suspect that we could lose data of the child
> if we were to evict that clean folio (swapout).
> 
> So I assume we simply copy the dirty PTE bit, so the system knows that
> that folio is actually dirty, because one PTE is dirty.

Oh, and regarding your race concern: it's undefined which page state
would see if some write is racing with fork, so it also doesn't matter
if we would copy the PTE dirty bit or not, if it gets set in a racy fashion.

I'll not experiment with:

 From 14e83ff2a422a96ce5701f9c8454a49f9ed947e3 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Sat, 30 Dec 2023 12:54:35 +0100
Subject: [PATCH] mm/memory: ignore dirty/accessed/soft-dirty bits in
  folio_pte_batch()

Let's always ignore the accessed/young bit: we'll always mark the PTE
as old in our child process during fork, and upcoming users will
similarly not care.

Ignore the dirty bit only if we don't want to duplicate the dirty bit
into the child process during fork. Maybe, we could just set all PTEs
in the child dirty if any PTE is dirty. For now, let's keep the behavior
unchanged.

Ignore the soft-dirty bit only if the bit doesn't have any meaning in
the src vma.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/memory.c | 34 ++++++++++++++++++++++++++++++----
  1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7690994929d26..9aba1b0e871ca 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -953,24 +953,44 @@ static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
  	set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
  }
  
+/* Flags for folio_pte_batch(). */
+typedef int __bitwise fpb_t;
+
+/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
+#define FPB_IGNORE_DIRTY		((__force fpb_t)BIT(0))
+
+/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
+#define FPB_IGNORE_SOFT_DIRTY		((__force fpb_t)BIT(1))
+
+static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
+{
+	if (flags & FPB_IGNORE_DIRTY)
+		pte = pte_mkclean(pte);
+	if (likely(flags & FPB_IGNORE_SOFT_DIRTY))
+		pte = pte_clear_soft_dirty(pte);
+	return pte_mkold(pte);
+}
+
  /*
   * Detect a PTE batch: consecutive (present) PTEs that map consecutive
   * pages of the same folio.
   *
   * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN.
+ * the accessed bit, dirty bit (with FPB_IGNORE_DIRTY) and soft-dirty bit
+ * (with FPB_IGNORE_SOFT_DIRTY).
   */
  static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
-		pte_t *start_ptep, pte_t pte, int max_nr)
+		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags)
  {
  	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
  	const pte_t *end_ptep = start_ptep + max_nr;
-	pte_t expected_pte = pte_next_pfn(pte);
+	pte_t expected_pte = __pte_batch_clear_ignored(pte_next_pfn(pte), flags);
  	pte_t *ptep = start_ptep + 1;
  
  	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
  
  	while (ptep != end_ptep) {
-		pte = ptep_get(ptep);
+		pte = __pte_batch_clear_ignored(ptep_get(ptep), flags);
  
  		if (!pte_same(pte, expected_pte))
  			break;
@@ -1004,6 +1024,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
  {
  	struct page *page;
  	struct folio *folio;
+	fpb_t flags = 0;
  	int err, nr;
  
  	page = vm_normal_page(src_vma, addr, pte);
@@ -1018,7 +1039,12 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
  	 * by keeping the batching logic separate.
  	 */
  	if (unlikely(!*prealloc && folio_test_large(folio) && max_nr != 1)) {
-		nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr);
+		if (src_vma->vm_flags & VM_SHARED)
+			flags |= FPB_IGNORE_DIRTY;
+		if (!vma_soft_dirty_enabled(src_vma))
+			flags |= FPB_IGNORE_SOFT_DIRTY;
+
+		nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr, flags);
  		folio_ref_add(folio, nr);
  		if (folio_test_anon(folio)) {
  			if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page,
-- 
2.43.0


-- 
Cheers,

David / dhildenb


