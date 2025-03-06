Return-Path: <linux-s390+bounces-9389-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE24EA5598C
	for <lists+linux-s390@lfdr.de>; Thu,  6 Mar 2025 23:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45FBB16DB15
	for <lists+linux-s390@lfdr.de>; Thu,  6 Mar 2025 22:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7B920969B;
	Thu,  6 Mar 2025 22:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byl9Q0g8"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798D279338
	for <linux-s390@vger.kernel.org>; Thu,  6 Mar 2025 22:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299495; cv=none; b=rXgRlQVF/0JEzuwgcaGO6IBV0CPdWhCsYCCr6pBaYd/GYcTPljnZcqNt+/kkzmEQm90ucNOn/jld6u9bVIDmPEDIwpHM7qzKP4HaiG1sxyXHk0CNlQuicJhnscceMl8bbYfjG41LatDVXvREFSOaujc1Zvx1RZV4wxmtU7k+uVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299495; c=relaxed/simple;
	bh=lK4O1jfGdmHUc2z6JoK3/xWd8qkNBslpJWwsvBDqXzw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nOQhD8nGWlsr/Z8XwxpJJju8U3sIeAkGG/K670BBaj9IWQk5mrawntVQf/vkEoxnJZBP2vhdXituyFa3jsoONQmQRrDXWFoP3w6r75nyKYC6DJ9mE6U6mreCU+LiUcLncedVUm8x6vYU6e//Dm831LlBCOCkmh5SkRJswFXpZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=byl9Q0g8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741299492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fa0nevrfXmxszmsnK4mRY4GxFzPPQGrH49rOdswYLkQ=;
	b=byl9Q0g8nXJNvLXywfQXcnaDUwQf/PEF21RCM9s3i8+Sj6vDQIrX+peVg+4NXtYD31E9FE
	HmrB7z3g1Y/KlWHhypTxxwaxl7mQzWsDANM0RkJ/BEZD0UftRQ+FbMf1pBug1Xa2Tl0AZw
	w9EX0Qur3Zqbaso/joumPD9KIrwx89s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-sfacHspROa-elrKSeM08Gw-1; Thu, 06 Mar 2025 17:18:05 -0500
X-MC-Unique: sfacHspROa-elrKSeM08Gw-1
X-Mimecast-MFC-AGG-ID: sfacHspROa-elrKSeM08Gw_1741299484
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43bc1aa0673so4942955e9.2
        for <linux-s390@vger.kernel.org>; Thu, 06 Mar 2025 14:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741299484; x=1741904284;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fa0nevrfXmxszmsnK4mRY4GxFzPPQGrH49rOdswYLkQ=;
        b=F0qZvtl72Ieajg0P4ej7B3wz7kQwXRopw/IW/qfjmAPkUgiftKAX0SAC3XzjivVu06
         hIRmy7Fcgu0L5CfwfCMTuEWb9JL7RPve0nJUF2XHiLNfRnoebPxF6JdKWn274FTLvUw2
         aVTfJ6/PxYXA/arh+8/Gsy4CzDy9J1GVcvuG0LrU3AuuGtyoR+zXllML/djJ4PewniVy
         wVzE0YQJB0wz1RR0MZKya3NLaMdGuo0+odA/ueZYbykvMk1TyBGkIt+NK7HyRauj9JWN
         /biF5utZav3NHUHy3quJQd1bfVDMXYt1tcKUqgnNKFqkspNvw7e3LlgqNPjQYY/i0WnJ
         zp4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfrg7gC8X9WADoexEBa+Zmy3LDHFKoccEQ1gmeOxtvti5MSIXWvp/d2FxkuzMb4TDXrpT0t26953U9@vger.kernel.org
X-Gm-Message-State: AOJu0YzHIbsAt2TOD3jc5ZlHTfhCbOZa9gVfT/7lujJo09jNkqjYP8wq
	ruHBuwOd+VlxoWkepzx1ygw6daGjAICkE7yWsfVluQp9XOABqQOiBbH/NP/5gXk4gUBFpJ3HIGB
	xQyPpUJM2lQBWewDRgzFYQy6xO5hxztnnMPOqBsZK5B7AUYqUN7CTUHILXe8=
X-Gm-Gg: ASbGncvTbYndZr2iigPJjMajI4D9t1xW1URLSNzho78kZ8K66N5E4E8E/H38Zbe4c8m
	1kabtJ1eYbJ6tQk3CBpGubZxbcz+jyhoI9JO4MigqLx/7jNkwITE32E3fEUGooj/ZYGsm9yUZSM
	srX+tHFno9baBj39Vsi0CnkxX86PWOJQ+Z4dgpBbXq0AoQpZGPB/tlrioU7/mCTH5Hleq6IgJ62
	rR0JPCW6vYgxN106vRFz0kbYLIeLVz26Z407Xo9kqNUcB/XKaZsCW4xLo4b5nR4187WmOIKi/PD
	lvhBIHLyTD1JfgNDMrvia/ik/76Fnsh83cWz2O5vJslauS6t1WDNwsfrn2ogIRxbOr2jI2wvw6z
	dO1wINR+A+geFFK72kBH1W6eoRvzIUAEbs2IyFmYsSgg=
X-Received: by 2002:a05:6000:4108:b0:390:df6c:592a with SMTP id ffacd0b85a97d-39132d38302mr538559f8f.29.1741299482750;
        Thu, 06 Mar 2025 14:18:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4t8z3slrJMeyZX3Y/YdrNdWwXBJQ2YTtf0cp3DrxD28+nRhzE70t7ckJV48mYTfhnnQBvcA==
X-Received: by 2002:a05:6000:4108:b0:390:df6c:592a with SMTP id ffacd0b85a97d-39132d38302mr538522f8f.29.1741299480866;
        Thu, 06 Mar 2025 14:18:00 -0800 (PST)
Received: from ?IPV6:2003:cb:c74d:4400:2f98:9b35:6822:ce54? (p200300cbc74d44002f989b356822ce54.dip0.t-ipconnect.de. [2003:cb:c74d:4400:2f98:9b35:6822:ce54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfc96sm3317578f8f.31.2025.03.06.14.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 14:18:00 -0800 (PST)
Message-ID: <f0f242cc-1e9a-41f5-a1e7-6618a0025117@redhat.com>
Date: Thu, 6 Mar 2025 23:17:58 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] KVM: s390: pv: fix race when making a page secure
From: David Hildenbrand <david@redhat.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 frankja@linux.ibm.com, borntraeger@de.ibm.com, nrb@linux.ibm.com,
 seiden@linux.ibm.com, nsg@linux.ibm.com, schlameuss@linux.ibm.com,
 hca@linux.ibm.com
References: <20250304182304.178746-1-imbrenda@linux.ibm.com>
 <20250304182304.178746-2-imbrenda@linux.ibm.com>
 <c60e60a2-07ed-4692-8952-c125c34122f8@redhat.com>
 <af3739da-771a-4987-86b7-d6f7f82252f6@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <af3739da-771a-4987-86b7-d6f7f82252f6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.03.25 23:07, David Hildenbrand wrote:
> On 06.03.25 11:23, David Hildenbrand wrote:
>>>     /**
>>> - * make_folio_secure() - make a folio secure
>>> + * __make_folio_secure() - make a folio secure
>>>      * @folio: the folio to make secure
>>>      * @uvcb: the uvcb that describes the UVC to be used
>>>      *
>>> @@ -243,14 +276,13 @@ static int expected_folio_refs(struct folio *folio)
>>>      *         -EINVAL if the UVC failed for other reasons.
>>>      *
>>>      * Context: The caller must hold exactly one extra reference on the folio
>>> - *          (it's the same logic as split_folio())
>>> + *          (it's the same logic as split_folio()), and the folio must be
>>> + *          locked.
>>>      */
>>> -int make_folio_secure(struct folio *folio, struct uv_cb_header *uvcb)
>>> +static int __make_folio_secure(struct folio *folio, struct uv_cb_header *uvcb)
>>
>> One more nit: -EBUSY can no longer be returned from his function, so you
>> might just remove it from the doc above.
>>
>>
>> While chasing a very weird folio split bug that seems to result in late
>> validation issues (:/), I was wondering if __gmap_destroy_page could
>> similarly be problematic.
>>
>> We're now no longer holding the PTL while performing the operation.
>>
>> (not that that would explain the issue I am chasing, because
>> gmap_destroy_page() is never called in my setup)
>>
> 
> Okay, I've been debugging for way to long the weird issue I am seeing, and I
> did not find the root cause yet. But the following things are problematic:
> 
> 1) To walk the page tables, we need the mmap lock in read mode.
> 
> 2) To walk the page tables, we must know that a VMA exists
> 
> 3) get_locked_pte() must not be used on hugetlb areas.
> 
> Further, the following things should be cleaned up
> 
> 4) s390_wiggle_split_folio() is only used in that file
> 
> 5) gmap_make_secure() likely should be returning -EFAULT
> 
> 
> See below, I went with a folio_walk (which also checks for pte_present()
> like the old code did, but that should not matter here) so we can get rid of the
> get_locked_pte() usage completely.
> 
> 
>   From 1b9a4306b79a352daf80708252d166114e7335de Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Thu, 6 Mar 2025 22:43:43 +0100
> Subject: [PATCH] merge
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>    arch/s390/include/asm/uv.h |  1 -
>    arch/s390/kernel/uv.c      | 41 ++++++++++++++++++--------------------
>    arch/s390/kvm/gmap.c       |  2 +-
>    3 files changed, 20 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index fa33a6ff2fabf..46fb0ef6f9847 100644
> --- a/arch/s390/include/asm/uv.h
> +++ b/arch/s390/include/asm/uv.h
> @@ -634,7 +634,6 @@ int uv_convert_from_secure_pte(pte_t pte);
>    int make_hva_secure(struct mm_struct *mm, unsigned long hva, struct uv_cb_header *uvcb);
>    int uv_convert_from_secure(unsigned long paddr);
>    int uv_convert_from_secure_folio(struct folio *folio);
> -int s390_wiggle_split_folio(struct mm_struct *mm, struct folio *folio, bool split);
>    
>    void setup_uv(void);
>    
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index 63420a5f3ee57..11a1894e63405 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -270,7 +270,6 @@ static int expected_folio_refs(struct folio *folio)
>     *
>     * Return: 0 on success;
>     *         -EBUSY if the folio is in writeback or has too many references;
> - *         -E2BIG if the folio is large;
>     *         -EAGAIN if the UVC needs to be attempted again;
>     *         -ENXIO if the address is not mapped;
>     *         -EINVAL if the UVC failed for other reasons.
> @@ -324,17 +323,6 @@ static int make_folio_secure(struct mm_struct *mm, struct folio *folio, struct u
>    	return rc;
>    }
>    
> -static pte_t *get_locked_valid_pte(struct mm_struct *mm, unsigned long hva, spinlock_t **ptl)
> -{
> -	pte_t *ptep = get_locked_pte(mm, hva, ptl);
> -
> -	if (ptep && (pte_val(*ptep) & _PAGE_INVALID)) {
> -		pte_unmap_unlock(ptep, *ptl);
> -		ptep = NULL;
> -	}
> -	return ptep;
> -}
> -
>    /**
>     * s390_wiggle_split_folio() - try to drain extra references to a folio and optionally split
>     * @mm:    the mm containing the folio to work on
> @@ -344,7 +332,7 @@ static pte_t *get_locked_valid_pte(struct mm_struct *mm, unsigned long hva, spin
>     * Context: Must be called while holding an extra reference to the folio;
>     *          the mm lock should not be held.
>     */
> -int s390_wiggle_split_folio(struct mm_struct *mm, struct folio *folio, bool split)
> +static int s390_wiggle_split_folio(struct mm_struct *mm, struct folio *folio, bool split)
>    {
>    	int rc;
>    
> @@ -361,20 +349,28 @@ int s390_wiggle_split_folio(struct mm_struct *mm, struct folio *folio, bool spli
>    	}
>    	return -EAGAIN;
>    }
> -EXPORT_SYMBOL_GPL(s390_wiggle_split_folio);
>    
>    int make_hva_secure(struct mm_struct *mm, unsigned long hva, struct uv_cb_header *uvcb)
>    {
> +	struct vm_area_struct *vma;
> +	struct folio_walk fw;
>    	struct folio *folio;
> -	spinlock_t *ptelock;
> -	pte_t *ptep;
>    	int rc;
>    
> -	ptep = get_locked_valid_pte(mm, hva, &ptelock);
> -	if (!ptep)
> +	mmap_read_lock(mm);
> +
> +	vma = vma_lookup(mm, hva);
> +	if (!vma) {
> +		mmap_read_unlock(mm);
> +		return -EFAULT;
> +	}
> +
> +	folio = folio_walk_start(&fw, vma, hva, 0);
> +	if (!folio) {
> +		mmap_read_unlock(mm);
>    		return -ENXIO;
> +	}
>    
> -	folio = page_folio(pte_page(*ptep));
>    	folio_get(folio);
>    	/*
>    	 * Secure pages cannot be huge and userspace should not combine both.
> @@ -385,14 +381,15 @@ int make_hva_secure(struct mm_struct *mm, unsigned long hva, struct uv_cb_header
>    	 * KVM_RUN will return -EFAULT.
>    	 */
>    	if (folio_test_hugetlb(folio))
> -		rc =  -EFAULT;
> +		rc = -EFAULT;
>    	else if (folio_test_large(folio))
>    		rc = -E2BIG;
> -	else if (!pte_write(*ptep))
> +	else if (!pte_write(fw.pte) || (pte_val(fw.pte) & _PAGE_INVALID))
>    		rc = -ENXIO;
>    	else
>    		rc = make_folio_secure(mm, folio, uvcb);
> -	pte_unmap_unlock(ptep, ptelock);
> +	folio_walk_end(&fw, vma);
> +	mmap_read_unlock(mm);
>    
>    	if (rc == -E2BIG || rc == -EBUSY)
>    		rc = s390_wiggle_split_folio(mm, folio, rc == -E2BIG);
> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
> index 21580cfecc6ac..1a88b32e7c134 100644
> --- a/arch/s390/kvm/gmap.c
> +++ b/arch/s390/kvm/gmap.c
> @@ -41,7 +41,7 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
>    
>    	vmaddr = gfn_to_hva(kvm, gpa_to_gfn(gaddr));
>    	if (kvm_is_error_hva(vmaddr))
> -		rc = -ENXIO;
> +		rc = -EFAULT;
>    	else
>    		rc = make_hva_secure(gmap->mm, vmaddr, uvcb);
>    

The following likely on top as a cleanup as well:
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 1a88b32e7c134..6d8944d1b4a0c 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -35,17 +35,13 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
  {
         struct kvm *kvm = gmap->private;
         unsigned long vmaddr;
-       int rc = 0;
  
         lockdep_assert_held(&kvm->srcu);
  
         vmaddr = gfn_to_hva(kvm, gpa_to_gfn(gaddr));
         if (kvm_is_error_hva(vmaddr))
-               rc = -EFAULT;
-       else
-               rc = make_hva_secure(gmap->mm, vmaddr, uvcb);
-
-       return rc;
+               return -EFAULT;
+       return make_hva_secure(gmap->mm, vmaddr, uvcb);
  }
  
  int gmap_convert_to_secure(struct gmap *gmap, unsigned long gaddr)



-- 
Cheers,

David / dhildenb


