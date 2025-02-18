Return-Path: <linux-s390+bounces-9049-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A004BA3996B
	for <lists+linux-s390@lfdr.de>; Tue, 18 Feb 2025 11:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B443BA496
	for <lists+linux-s390@lfdr.de>; Tue, 18 Feb 2025 10:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9C01A2C29;
	Tue, 18 Feb 2025 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGHJGA5+"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB6022B8A0
	for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2025 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874676; cv=none; b=o597UrSn/WMpEhTwfCrPPHtvDVzxZkjujWca7cuq8VM94in+GMBamz74REqRjX62igMTtGMwZ9XudByJ8okWSLjnzdw8WaEAN8ArfZkukoOiLMx4D1mRhHtQjJJICBBAAF30qimnzemnUEaZsZJ6qz4dy2qOoxFDAmtucBOaZAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874676; c=relaxed/simple;
	bh=xIKwsVYSeT+yIT+J3E68TcAIy0/z4ZuetsggoO6Qyio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGGxIWw67sK0xOXV+ZqCMoKUbFK0LGnzWWquFITe3Fx28K2vV9vT7MPUM8zEZQJDtlf6hAvjmKhH/CzbyoCflRd1E8qOzvkdaZJHMRM2269r4EyBzl3LrrnffRl2JuETckNZ+3bc2oyAKG7lL1gaMmObHvCJqYLMEmw8ZH82T6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dGHJGA5+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739874673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bYHwcLVWT7ViqDSplojxQnlqWrz/ZE/8JhhVM+wg4bQ=;
	b=dGHJGA5+veMCAHQzd2qJZE1c6v72hHxr1HXmGBVtXXsi5rVuUkzgcvjAsed49KVUBJTOy6
	D5eQ6a/A0BkM0ynXso1bNqalZXFHmidUhYCMsic2pADDm7k+X0VwLfmi1BjWj7q+eywH4/
	Q2FV/JTbgssD+gBP6podK58+1VEY6Iw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-BsCMpir5NH6tUJBpxWVlgA-1; Tue, 18 Feb 2025 05:31:11 -0500
X-MC-Unique: BsCMpir5NH6tUJBpxWVlgA-1
X-Mimecast-MFC-AGG-ID: BsCMpir5NH6tUJBpxWVlgA_1739874671
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43935e09897so44798595e9.1
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2025 02:31:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739874670; x=1740479470;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bYHwcLVWT7ViqDSplojxQnlqWrz/ZE/8JhhVM+wg4bQ=;
        b=mtg7h7GvLh39jnfYVFDwHonhOwecxpP1/xd1rwoR/+xbK5qooTzTq7rtHY9W68Hs1p
         ThPUNZAEZET7zIg0dyjECNdQTj6OX9r7+EADxkIernTana3YV4smrm2mFoFGO9L6cBP4
         SjonKj5WgxJ3jYgGf8Plw7CgHZfJzfIIaNyXpId1raN8KN2i38yGuxn5iEIClWrDhe6D
         Jbup0qfP2uinuQ7gYrqF+wqd+/Bf33d7bhNzax3ChiML5BShe1ynKypSRbUl0qqjLKQy
         MziflS/aBCZepVEBVnYmHUrZ1R5JQP7j6Ek+/dL1bOy8spEqFsCzXf+7rIs5gqn7v1q1
         65iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtQa1+yBlobiYr8w0HZw10w24fWw2YsthzwB+3/zEiGTn5eaIpeSX/XxAwZ8PwFHo4sjKwP8ze2wMY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2EsOVoegxVpR07RscVBsvPF4/Z69wnNCnnTOhFjRRNgXn44zb
	q+/7DhEli46egtFGTIH5shn9hOB3lr8hBLPYh7CM8nNkrwp7C1ypfFgI9BrJsaoCF3PPJOpkHWa
	X/xcg3T0rJ1H+XREADWltTJlYL2S55aJU0ozRFwQLplprt5hai4in/0cQ7RtIZYUZk+fTWg==
X-Gm-Gg: ASbGncsGd8IS1D7eYTN84Af6HyqN73PXOfaETUr/kh938MOQmY7uGPNCMRFa6ApPoCc
	lB6obIgZXZ1kZH0I7AY7YonlRn2l9FR9um51HG7dIGJxomGnl8Dj9qvzmMavsn0W6kk/KQ/HidE
	C48rYu101JSYsHYzLFR2PHEtcTB89f2HWQBh01r3YP+50TPxzh8MZ5kziS8lV7V/WADNAM9Ztd4
	UocnXcZjc8rRC0L0ZUSMKU0UFDXYpTJIJSCdVqRe4Xl0TgTFyoUeHcHC6E+W9fvJPSqd8pmyLfV
	R3SfIDtPPZb+JXwjb/LbP5mOiSprBsmnG9Q8XgABQWuEk2kw2qE8baw/v7ppDDHIcsaeB8JmfdY
	AlGEsdhIai52HAehyTKXGjCg2D2XWhADC
X-Received: by 2002:a05:600c:1912:b0:439:6925:4d42 with SMTP id 5b1f17b1804b1-4396e69a291mr145157695e9.5.1739874670504;
        Tue, 18 Feb 2025 02:31:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKK/d9jTwRaJ76UZdUAwdd23rNzlgGNUJjR7HWeCisU6/6HAcioR2Kkp6B8p+CFTIAPK1yIw==
X-Received: by 2002:a05:600c:1912:b0:439:6925:4d42 with SMTP id 5b1f17b1804b1-4396e69a291mr145157155e9.5.1739874669914;
        Tue, 18 Feb 2025 02:31:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b824dsm176854065e9.34.2025.02.18.02.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 02:31:08 -0800 (PST)
Message-ID: <65da326f-96a0-42ed-95e9-932c598b40f4@redhat.com>
Date: Tue, 18 Feb 2025 11:31:06 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] mm: Set the pte dirty if the folio is already dirty
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org
References: <20250217190836.435039-1-willy@infradead.org>
 <20250217190836.435039-2-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250217190836.435039-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.02.25 20:08, Matthew Wilcox (Oracle) wrote:
> If the first access to a folio is a read that is then followed by a
> write, we can save a page fault.  s390 implemented this in their
> mk_pte() in commit abf09bed3cce ("s390/mm: implement software dirty
> bits"), but other architectures can also benefit from this.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   arch/s390/include/asm/pgtable.h | 7 +------
>   mm/memory.c                     | 2 ++
>   2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 3ca5af4cfe43..3ee495b5171e 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -1451,12 +1451,7 @@ static inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
>   
>   static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
>   {
> -	unsigned long physpage = page_to_phys(page);
> -	pte_t __pte = mk_pte_phys(physpage, pgprot);
> -
> -	if (pte_write(__pte) && PageDirty(page))
> -		__pte = pte_mkdirty(__pte);
> -	return __pte;
> +	return mk_pte_phys(page_to_phys(page), pgprot);
>   }
>   
>   #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
> diff --git a/mm/memory.c b/mm/memory.c
> index 539c0f7c6d54..4330560eee55 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5124,6 +5124,8 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
>   
>   	if (write)
>   		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> +	else if (pte_write(entry) && folio_test_dirty(folio))
> +		entry = pte_mkdirty(entry);
>   	if (unlikely(vmf_orig_pte_uffd_wp(vmf)))
>   		entry = pte_mkuffd_wp(entry);
>   	/* copy-on-write page */

Yes, that looks sane

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


