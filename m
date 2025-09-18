Return-Path: <linux-s390+bounces-12561-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F20CFB3E630
	for <lists+linux-s390@lfdr.de>; Mon,  1 Sep 2025 15:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E696189D1FC
	for <lists+linux-s390@lfdr.de>; Mon,  1 Sep 2025 13:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB6E338F50;
	Mon,  1 Sep 2025 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bk+Uu3uF"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138473375C0
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734873; cv=none; b=XHUtG8xPTXybkStYlrEctekV3rQXaym6bP6M/JmgWtWPTxDNntq3F1xbPwRq+cqrAXSX5HAAv9i+RIqF/8lV23xyqfIWwIJ76qi5AMw0lB+lV/2GjbExTeqCj1+6ujv/Neh+ah067tbtPbTGZrQXWc/GcAdt0aBsPgiI7FpeRYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734873; c=relaxed/simple;
	bh=7sJXU+F5zTloTS0kBJT1dReHDHNTsNheaixrdfLA7eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cvszU+YIpnwS5TlSW1bR7gZCL2+L6J2TSKZebEwiWRsjE2RQyEqU5GAY71TvxSuVubxZU0Nbg0HunkVw5GZITNvnK8ZG+JJKRdFFacjQNSJ4e/aRi8DWjWjjMzXOz0u/tHUi7wtdk1JkbDx++7rLudKRCuTQ7WvxWqdf71mAPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bk+Uu3uF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756734871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rkOxHsJ9lyozFAluE91xfQ0cGnpBD4cOEv8yb086+4A=;
	b=bk+Uu3uF3+SMahdA8lqQj/bUH6EI8N6F1LjeJzaM+nKKqt25J+fzluzf2Pa5M/gFAxh7tB
	T53NId8AO3eVxXFCmdinDfIARH+sVdjAaudLQ3eKsZ9ECGEzs87IShRsYqtWV0DNKKv2nK
	Bir7vckDYLZl5NWnz4JZLchKyh8sZr0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-df3_vuobOl2fJru27PL3ww-1; Mon, 01 Sep 2025 09:54:30 -0400
X-MC-Unique: df3_vuobOl2fJru27PL3ww-1
X-Mimecast-MFC-AGG-ID: df3_vuobOl2fJru27PL3ww_1756734869
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b7d84d8a0so11146635e9.1
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 06:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756734869; x=1757339669;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rkOxHsJ9lyozFAluE91xfQ0cGnpBD4cOEv8yb086+4A=;
        b=KC7eDF3Z2bXjTzlVBtReAtn+3LpZUAbARmEp7aMliiJO1QVwobd+i30EpVd3MRiZH7
         vG33aAR8GIngoN3X45RE/+lepBS5EkOc+uMIRhSLcSQTk9HdW/Pl475UM+3y8NCZnx4y
         Y+69UGc5rO0zIrXVp8yjq+iTU8wu5FGOl5ib6uGGUXdnqNfoxkzYCx4/uLHuP/wk7afW
         Rfmewqr4zlvvutiyMe6ZzsOeQxwKC9fl6FSUS6KbKDHFbLlXJAv86gE3VrU6jM9v81AL
         BYUxyugn2Im9dKk1Ff1gP5t81Z0dOepv4BWPMNoIXQr/HZmf6L8ejbzHl3I3STdT9K+d
         PqkA==
X-Forwarded-Encrypted: i=1; AJvYcCVp3/DMhNApWfeEr6D0M0JryCT3gig73SKYtWVo9nzMTS0PvKy8P1iWijnadYTFXtGAMkD/F/fUxNsc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn5esqgBv3NRBP1FsQ9z7h9sKTxerI0SjVvEsmiQI+i1q9CFtV
	065WRpzhMruSJed+7/LKQlcehVkcWxUz6b3rlUfJFYF/RHLd0z9Xqq3SNtQ4E389jlxAOqr86Qq
	5ubgIy8m4IMng/xnx7u/yibNUdoAGy5rgJu6uLFzIuRZpI33V1k61xZ5bFG7ix7k=
X-Gm-Gg: ASbGncsARThw133Ov+K/1XBXJU67wbct1oKH9T2hPUSOuuWZaT9hzjNzLuAXshl11th
	VJnJVdeEh1S0rKwfTwk3K7BApKIH91fv3TdgMvbOWKsENRyrUEp/gjipLc2g5YV6LmkSFTjYMNP
	h5OdRY8xNx9TTzP939aCY3CVjGrH7aeqCaoW/YJyDtrWI5eh9ZT+KjHhcNEVhZSxSM1IhFHp3f9
	McsyIyLn6yKILbf/6g8l3QLUUUnx/DsQ7UJpcPfrRq2A8iHlGlI9kHh5gnXxmCRJQFSWkWt99eE
	HiJFxIaLxmI9gXpLdm2kUUm3iT7UyKUZ8nQVf6+Nc24V1JTDT+Gvkab40ff0S9Lbhgn510VATbm
	XDp7t2zQK9uvQ+5wuerifY0Kcg2f2m4rXwrkCePTSTwF8D0EnSRDD5akaFuefWDaoOwg=
X-Received: by 2002:a05:600c:8b23:b0:459:d5d1:d602 with SMTP id 5b1f17b1804b1-45b8553f3ffmr57688605e9.3.1756734868743;
        Mon, 01 Sep 2025 06:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHApjNVFtZLYlxrGhbhPyzStDf2OCbwaNXEbdwjI5RqViWE8PiPULdnUBK5NJLWAEltUwK4fQ==
X-Received: by 2002:a05:600c:8b23:b0:459:d5d1:d602 with SMTP id 5b1f17b1804b1-45b8553f3ffmr57688155e9.3.1756734868174;
        Mon, 01 Sep 2025 06:54:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm15536277f8f.15.2025.09.01.06.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:54:27 -0700 (PDT)
Message-ID: <ce720df8-cdf2-492a-9eeb-e7b643bffa91@redhat.com>
Date: Mon, 1 Sep 2025 15:54:25 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] mm, s390: constify mapping related test
 functions for improved const-correctness
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
 axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
 hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
 linux@armlinux.org.uk, James.Bottomley@HansenPartnership.com, deller@gmx.de,
 agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 davem@davemloft.net, andreas@gaisler.com, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net,
 jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, weixugc@google.com, baolin.wang@linux.alibaba.com,
 rientjes@google.com, shakeel.butt@linux.dev, thuth@redhat.com,
 broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com,
 mpe@ellerman.id.au, nysal@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-7-max.kellermann@ionos.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901123028.3383461-7-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 14:30, Max Kellermann wrote:
> We select certain test functions which either invoke each other,
> functions that are already const-ified, or no further functions.
> 
> It is therefore relatively trivial to const-ify them, which
> provides a basis for further const-ification further up the call
> stack.
> 
> (Even though seemingly unrelated, this also constifies the pointer
> parameter of mmap_is_legacy() in arch/s390/mm/mmap.c because a copy of
> the function exists in mm/util.c.)
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Also here, some getters hiding.

> ---
>   arch/s390/mm/mmap.c     |  2 +-
>   include/linux/mm.h      |  6 +++---
>   include/linux/pagemap.h |  2 +-
>   mm/util.c               | 11 ++++++-----
>   4 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
> index 547104ccc22a..c0f619fb9ab3 100644
> --- a/arch/s390/mm/mmap.c
> +++ b/arch/s390/mm/mmap.c
> @@ -27,7 +27,7 @@ static unsigned long stack_maxrandom_size(void)
>   	return STACK_RND_MASK << PAGE_SHIFT;
>   }
>   
> -static inline int mmap_is_legacy(struct rlimit *rlim_stack)
> +static inline int mmap_is_legacy(const struct rlimit *const rlim_stack)
>   {
>   	if (current->personality & ADDR_COMPAT_LAYOUT)
>   		return 1;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f70c6b4d5f80..23864c3519d6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -986,7 +986,7 @@ static inline bool vma_is_shmem(const struct vm_area_struct *vma) { return false
>   static inline bool vma_is_anon_shmem(const struct vm_area_struct *vma) { return false; }
>   #endif
>   
> -int vma_is_stack_for_current(struct vm_area_struct *vma);
> +int vma_is_stack_for_current(const struct vm_area_struct *vma);

Should this also be *const ?

>   
>   /* flush_tlb_range() takes a vma, not a mm, and can care about flags */
>   #define TLB_FLUSH_VMA(mm,flags) { .vm_mm = (mm), .vm_flags = (flags) }
> @@ -2585,7 +2585,7 @@ void folio_add_pin(struct folio *folio);
>   
>   int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc);
>   int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
> -			struct task_struct *task, bool bypass_rlim);
> +			const struct task_struct *task, bool bypass_rlim);
>   


Dito.

>   struct kvec;
>   struct page *get_dump_page(unsigned long addr, int *locked);
> @@ -3348,7 +3348,7 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
>   	     avc; avc = anon_vma_interval_tree_iter_next(avc, start, last))
>   
>   /* mmap.c */
> -extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
> +extern int __vm_enough_memory(const struct mm_struct *mm, long pages, int cap_sys_admin);
>   extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
>   extern void exit_mmap(struct mm_struct *);
>   bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 1d35f9e1416e..968b58a97236 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -551,7 +551,7 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
>   #endif
>   }
>   
> -struct address_space *folio_mapping(struct folio *);
> +struct address_space *folio_mapping(const struct folio *folio);

And this one?

-- 
Cheers

David / dhildenb


