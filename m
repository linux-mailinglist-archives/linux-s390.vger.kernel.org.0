Return-Path: <linux-s390+bounces-192-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7308D7FA429
	for <lists+linux-s390@lfdr.de>; Mon, 27 Nov 2023 16:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C62BAB20EDB
	for <lists+linux-s390@lfdr.de>; Mon, 27 Nov 2023 15:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0D330FAE;
	Mon, 27 Nov 2023 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tb6xf7qB"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D39BB
	for <linux-s390@vger.kernel.org>; Mon, 27 Nov 2023 07:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701097870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wiS/QSHyrQLt30DtgLQ/3a1/rZ4tdJUecrIYLVt9a50=;
	b=Tb6xf7qBfg9k6v6Blgef2fjGgkqffdFUZWH8ZAEoZ01lIgSTB7WxHNeDMkrQaxPu5hb9T7
	l1vn8qAZ2aFWmUkZXP/+mmsG14uuPyufc4zXbXEOK15g2HRJxpN/OsDh0Pwx3C8IL1zGUV
	SXS4K9m4u9c9SaA2M8hFHRyws7Fa4U0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-QOpiwV7ENcuOtvy1eafgOw-1; Mon, 27 Nov 2023 10:11:08 -0500
X-MC-Unique: QOpiwV7ENcuOtvy1eafgOw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-332e2e0b98bso3150416f8f.1
        for <linux-s390@vger.kernel.org>; Mon, 27 Nov 2023 07:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701097867; x=1701702667;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiS/QSHyrQLt30DtgLQ/3a1/rZ4tdJUecrIYLVt9a50=;
        b=ildpaaeY+tJIn/QmYF5H9aWWvZNAfCBkzP+eUW8aQ3jAMNObkNgKKVYkdZ0C+iRBxU
         YOZGhhsE2pCSW5u7GHgPNRqY+R6ie+UwTa7r9r61wAezwyKInvcH++17Jdjy/Fe3hml8
         EWY8dvvXsUxuZYC9GBHnXy9FH7JP1jkGpfN5qCtZonST/67YAzyjHOvIA2uNEn3UI3vS
         8Y3PBYnKWzIw0oK7twpmxiXgr/M4ipbmSIWLy1wYXuUcEAEyQvbqDWoey/7xMkjlP/vE
         0cEf+Iac3RV/fN9bw6rj9yEJMNbo1dZ14rOGGct6W+lAtO3JmqPV5hCqIgZAiz1a7coW
         xAeg==
X-Gm-Message-State: AOJu0Yzz5hCYGatlvgFEs7nV+OQ6t+C2xSQ+uN1Nm+xWUrQ7Hh8JZc7+
	6o4iBfwLTAvUz09cv0tOipSUmPSRynzaDQM554rSk2kp+yROesIW35YwXzFxKMp10bWODeXQU90
	GqebnrzMM8f01ZvYrLKcl7g==
X-Received: by 2002:a5d:4843:0:b0:332:fa75:a8ed with SMTP id n3-20020a5d4843000000b00332fa75a8edmr3467276wrs.24.1701097867283;
        Mon, 27 Nov 2023 07:11:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8pSZb/HQRWFQziCuTdC0qDXsah32JbJGmIDFW/3g6eHxXGGPPndHyglepnJOARh/1WN0Nww==
X-Received: by 2002:a5d:4843:0:b0:332:fa75:a8ed with SMTP id n3-20020a5d4843000000b00332fa75a8edmr3467240wrs.24.1701097866715;
        Mon, 27 Nov 2023 07:11:06 -0800 (PST)
Received: from ?IPV6:2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3? (p200300cbc7452a00d74aa8c520b63ec3.dip0.t-ipconnect.de. [2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3])
        by smtp.gmail.com with ESMTPSA id v10-20020adff68a000000b00332c0e934aasm12144905wrp.44.2023.11.27.07.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 07:11:06 -0800 (PST)
Message-ID: <abbe4d53-e944-46cc-90fc-a0a65e50b2fe@redhat.com>
Date: Mon, 27 Nov 2023 16:11:05 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] s390/mm: implement
 MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
Content-Language: en-US
To: Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-mm <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20231127082023.2079810-1-sumanthk@linux.ibm.com>
 <20231127082023.2079810-5-sumanthk@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231127082023.2079810-5-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.11.23 09:20, Sumanth Korikkar wrote:
> MEM_PREPARE_ONLINE memory notifier makes memory block physical
> accessible via sclp assign command. The notifier ensures self-contained
> memory maps are accessible and hence enabling the "memmap on memory" on
> s390.
> 
> MEM_FINISH_OFFLINE memory notifier shifts the memory block to an
> inaccessible state via sclp unassign command.
> 
> Implementation considerations:
> * When MHP_MEMMAP_ON_MEMORY is disabled, the system retains the old
>    behavior. This means the memory map is allocated from default memory.
> * If MACHINE_HAS_EDAT1 is unavailable, MHP_MEMMAP_ON_MEMORY is
>    automatically disabled. This ensures that vmemmap pagetables do not
>    consume additional memory from the default memory allocator.
> * The MEM_GOING_ONLINE notifier has been modified to perform no
>    operation, as MEM_PREPARE_ONLINE already executes the sclp assign
>    command.
> * The MEM_CANCEL_ONLINE/MEM_OFFLINE notifier now performs no operation, as
>    MEM_FINISH_OFFLINE already executes the sclp unassign command.
> 
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>   drivers/s390/char/sclp_cmd.c | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
> index 355e63e44e95..30b829e4c052 100644
> --- a/drivers/s390/char/sclp_cmd.c
> +++ b/drivers/s390/char/sclp_cmd.c
> @@ -18,6 +18,7 @@
>   #include <linux/mm.h>
>   #include <linux/mmzone.h>
>   #include <linux/memory.h>
> +#include <linux/memory_hotplug.h>
>   #include <linux/module.h>
>   #include <asm/ctlreg.h>
>   #include <asm/chpid.h>
> @@ -26,6 +27,7 @@
>   #include <asm/sclp.h>
>   #include <asm/numa.h>
>   #include <asm/facility.h>
> +#include <asm/page-states.h>
>   
>   #include "sclp.h"
>   
> @@ -319,6 +321,7 @@ static bool contains_standby_increment(unsigned long start, unsigned long end)
>   static int sclp_mem_notifier(struct notifier_block *nb,
>   			     unsigned long action, void *data)
>   {
> +	struct memory_block *memory_block;
>   	unsigned long start, size;
>   	struct memory_notify *arg;
>   	unsigned char id;
> @@ -340,18 +343,29 @@ static int sclp_mem_notifier(struct notifier_block *nb,
>   		if (contains_standby_increment(start, start + size))
>   			rc = -EPERM;
>   		break;
> -	case MEM_GOING_ONLINE:
> +	case MEM_PREPARE_ONLINE:
> +		memory_block = find_memory_block(pfn_to_section_nr(arg->start_pfn));
> +		if (!memory_block) {
> +			rc = -EINVAL;
> +			goto out;
> +		}
>   		rc = sclp_mem_change_state(start, size, 1);
> +		if (rc || !memory_block->altmap)
> +			goto out;
> +		/*
> +		 * Set CMMA state to nodat here, since the struct page memory
> +		 * at the beginning of the memory block will not go through the
> +		 * buddy allocator later.
> +		 */
> +		__arch_set_page_nodat((void *)__va(start), memory_block->altmap->free);

Looking up the memory block and grabbing the altmap from there is a bit 
unfortunate.

Why can't we do that when adding the altmap? Will the hypervisor scream 
at us?

... would we want to communicate any altmap start+size via the memory 
notifier instead?

-- 
Cheers,

David / dhildenb


