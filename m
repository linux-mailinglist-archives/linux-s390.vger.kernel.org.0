Return-Path: <linux-s390+bounces-212-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB6C7FB908
	for <lists+linux-s390@lfdr.de>; Tue, 28 Nov 2023 12:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A5F2B20B24
	for <lists+linux-s390@lfdr.de>; Tue, 28 Nov 2023 11:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BB34B5C7;
	Tue, 28 Nov 2023 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCoMzaVD"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751931A5
	for <linux-s390@vger.kernel.org>; Tue, 28 Nov 2023 03:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701169744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UIPVo8y8KZ0ojAbIUudW7pm+se9bSpEloSfL5cJFCUs=;
	b=VCoMzaVDBD3+IvGxfeJ97E+kbZhpxbDkizPYR/shUVDOyb05QyTHeWRkjfuIP1T+adwj0c
	3Y1cPcWHERkiqMGlRUAQ1DtrVLXBHmfEMrZzNzTgZCtGKUr56jWdFumGVmKv9UB17AxhnL
	P/BBqw9odExieHMva4CidKy7+sEjBoM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-YOzDg8p7PoW3HIk0gZBxWg-1; Tue, 28 Nov 2023 06:09:01 -0500
X-MC-Unique: YOzDg8p7PoW3HIk0gZBxWg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c9b79125f8so2967261fa.1
        for <linux-s390@vger.kernel.org>; Tue, 28 Nov 2023 03:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701169740; x=1701774540;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIPVo8y8KZ0ojAbIUudW7pm+se9bSpEloSfL5cJFCUs=;
        b=jvjGIETqSDzUrqj/AJ0M71HN5FyrmnLcWty2NX8h+/Xy64ToXAoEgdjWiCBsfHNq4r
         iC+ptu3Pb5T/2gBJPmc+WZOL1ELp7gjB3NXmf3j5o+hdKeXRVAVCskcNuZzatzhYIzJA
         Kg4lvglYR/bSixTcT1oQYqFbADYq1/2403K+gcL3c8b62K+uT2xPTHsfY3NblkHRP+Jl
         mTrp9RhE2q77ZQ5xD1/zh0+KDPRXnFm5jIbVISS9OjCi4GtjmVxri+mAPpJ8C0qpqM6F
         Rsb6Er1RXx6qOi/cfUDJSF4V5s3SaQiSqxkPj6LteYXpDg+pfpiO6gh0nL2LMIGe66rd
         Bydg==
X-Gm-Message-State: AOJu0YwtwGTjAQ5DbRQTlTOBFwSEGLRB3Bpm8K3/sVQiAqT/2up05loK
	HoY4zzrYZO9AKS/RAUSPUSF3GmrH93AbUNJzPySSjXFdqIs8qE6NBgLuGK44TQgdNj3jc9uu1Wp
	obmjMV8P+HU/wJcP/EviX5g==
X-Received: by 2002:ac2:5316:0:b0:50b:bfa7:c7d with SMTP id c22-20020ac25316000000b0050bbfa70c7dmr445727lfh.13.1701169739774;
        Tue, 28 Nov 2023 03:08:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8ppKov+8LEFSSZSXOxrSqWIhOz3Gup2vw+FyzTpwemWIlbH/Mewa/58txGXmuA4WW/KRyLw==
X-Received: by 2002:ac2:5316:0:b0:50b:bfa7:c7d with SMTP id c22-20020ac25316000000b0050bbfa70c7dmr445699lfh.13.1701169739321;
        Tue, 28 Nov 2023 03:08:59 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6b10.dip0.t-ipconnect.de. [91.12.107.16])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b0040b4ccdcffbsm1738543wmq.2.2023.11.28.03.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 03:08:58 -0800 (PST)
Message-ID: <1e15544f-ba35-4be6-b77a-f3e1daafe24a@redhat.com>
Date: Tue, 28 Nov 2023 12:08:58 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] mm/memory_hotplug: introduce
 MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
To: Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-mm <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20231128110342.102096-1-sumanthk@linux.ibm.com>
 <20231128110342.102096-2-sumanthk@linux.ibm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231128110342.102096-2-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.11.23 12:03, Sumanth Korikkar wrote:
> Introduce  MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE memory notifiers to
> prepare the transition of memory to and from a physically accessible
> state. This enhancement is crucial for implementing the "memmap on
> memory" feature for s390 in a subsequent patch.
> 
> Platforms such as x86 can support physical memory hotplug via ACPI. When
> there is physical memory hotplug, ACPI event leads to the memory
> addition with the following callchain:
> acpi_memory_device_add()
>    -> acpi_memory_enable_device()
>       -> __add_memory()
> 
> After this, the hotplugged memory is physically accessible, and altmap
> support prepared, before the "memmap on memory" initialization in
> memory_block_online() is called.
> 
> On s390, memory hotplug works in a different way. The available hotplug
> memory has to be defined upfront in the hypervisor, but it is made
> physically accessible only when the user sets it online via sysfs,
> currently in the MEM_GOING_ONLINE notifier. This is too late and "memmap
> on memory" initialization is performed before calling MEM_GOING_ONLINE
> notifier.
> 
> During the memory hotplug addition phase, altmap support is prepared and
> during the memory onlining phase s390 requires memory to be physically
> accessible and then subsequently initiate the "memmap on memory"
> initialization process.
> 
> The memory provider will handle new MEM_PREPARE_ONLINE /
> MEM_FINISH_OFFLINE notifications and make the memory accessible.
> 
> The mhp_flag MHP_OFFLINE_INACCESSIBLE is introduced and is relevant when
> used along with MHP_MEMMAP_ON_MEMORY, because the altmap cannot be
> written (e.g., poisoned) when adding memory -- before it is set online.
> This allows for adding memory with an altmap that is not currently made
> available by a hypervisor. When onlining that memory, the hypervisor can
> be instructed to make that memory accessible via the new notifiers and
> the onlining phase will not require any memory allocations, which is
> helpful in low-memory situations.
> 
> All architectures ignore unknown memory notifiers.  Therefore, the
> introduction of these new notifiers does not result in any functional
> modifications across architectures.
> 
> Suggested-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>   drivers/base/memory.c          | 23 ++++++++++++++++++++++-
>   include/linux/memory.h         |  9 +++++++++
>   include/linux/memory_hotplug.h | 18 +++++++++++++++++-
>   include/linux/memremap.h       |  1 +
>   mm/memory_hotplug.c            | 13 ++++++++++++-
>   mm/sparse.c                    |  3 ++-
>   6 files changed, 63 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 8a13babd826c..b99bcc70d6e5 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -188,6 +188,7 @@ static int memory_block_online(struct memory_block *mem)
>   	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
>   	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
>   	unsigned long nr_vmemmap_pages = 0;
> +	struct memory_notify arg;
>   	struct zone *zone;
>   	int ret;
>   
> @@ -207,9 +208,19 @@ static int memory_block_online(struct memory_block *mem)
>   	if (mem->altmap)
>   		nr_vmemmap_pages = mem->altmap->free;
>   
> +	arg.altmap_start_pfn = start_pfn;
> +	arg.altmap_nr_pages = nr_vmemmap_pages;
> +	arg.start_pfn = start_pfn + nr_vmemmap_pages;
> +	arg.nr_pages = nr_pages - nr_vmemmap_pages;
>   	mem_hotplug_begin();
> +	ret = memory_notify(MEM_PREPARE_ONLINE, &arg);
> +	ret = notifier_to_errno(ret);
> +	if (ret)
> +		goto out_notifier;
> +
>   	if (nr_vmemmap_pages) {
> -		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages, zone);
> +		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages,
> +						zone, mem->altmap->inaccessible);
>   		if (ret)
>   			goto out;
>   	}
> @@ -231,7 +242,11 @@ static int memory_block_online(struct memory_block *mem)
>   					  nr_vmemmap_pages);
>   
>   	mem->zone = zone;
> +	mem_hotplug_done();
> +	return ret;
>   out:
> +	memory_notify(MEM_FINISH_OFFLINE, &arg);
> +out_notifier:
>   	mem_hotplug_done();
>   	return ret;
>   }
> @@ -244,6 +259,7 @@ static int memory_block_offline(struct memory_block *mem)
>   	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
>   	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
>   	unsigned long nr_vmemmap_pages = 0;
> +	struct memory_notify arg;
>   	int ret;
>   
>   	if (!mem->zone)
> @@ -275,6 +291,11 @@ static int memory_block_offline(struct memory_block *mem)
>   		mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
>   
>   	mem->zone = NULL;
> +	arg.altmap_start_pfn = start_pfn;
> +	arg.altmap_nr_pages = nr_vmemmap_pages;
> +	arg.start_pfn = start_pfn + nr_vmemmap_pages;
> +	arg.nr_pages = nr_pages - nr_vmemmap_pages;
> +	memory_notify(MEM_FINISH_OFFLINE, &arg);
>   out:
>   	mem_hotplug_done();
>   	return ret;
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index f53cfdaaaa41..939a16bd5cea 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -96,8 +96,17 @@ int set_memory_block_size_order(unsigned int order);
>   #define	MEM_GOING_ONLINE	(1<<3)
>   #define	MEM_CANCEL_ONLINE	(1<<4)
>   #define	MEM_CANCEL_OFFLINE	(1<<5)
> +#define	MEM_PREPARE_ONLINE	(1<<6)
> +#define	MEM_FINISH_OFFLINE	(1<<7)
>   
>   struct memory_notify {
> +	/*
> +	 * The altmap_start_pfn and altmap_nr_pages fields are designated for
> +	 * specifying the altmap range and are exclusively intended for use in
> +	 * MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers.
> +	 */
> +	unsigned long altmap_start_pfn;
> +	unsigned long altmap_nr_pages;
>   	unsigned long start_pfn;
>   	unsigned long nr_pages;
>   	int status_change_nid_normal;

Maybe we should do something like:

union {
	/* For MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE ... */
	struct {
		unsigned long altmap_start_pfn;
		unnsigned long altmap_nr_pages;
	};
	/* For all others ... */
	struct {
		int status_change_nid_normal;
		...
	};
}

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


