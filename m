Return-Path: <linux-s390+bounces-13983-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EE4BEBF00
	for <lists+linux-s390@lfdr.de>; Sat, 18 Oct 2025 00:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1675C356602
	for <lists+linux-s390@lfdr.de>; Fri, 17 Oct 2025 22:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D4832AADB;
	Fri, 17 Oct 2025 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Blo3pKxs"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8D12D9EEF
	for <linux-s390@vger.kernel.org>; Fri, 17 Oct 2025 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760740894; cv=none; b=u9Z2//0YwO2HGcbv8EFCZHbUkZNzgW2ty1a1R1G1rUYavfGkNBugNhgB+EDRQSDtqKYtONlNBDau0EQjLZp79jSrrEEQ8acWxHHqhQ+m/SvxPni3V7Mq9f9zhrjISAsrDqRiYShoP9TQ1D5bDctDRMveMOLZBzuU5/8R+xxg5qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760740894; c=relaxed/simple;
	bh=I+vLvWX9tt3ZjPonM8Tn9nuLD6RlJN9iZ3xM1BPuumg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sO3XzY2+DrK9YgPONZ4w2itrUCDCQQvpsjJhNVaaTHg/zs6ax1mykoQBWrXjJQpun0/y0xJs7E6e24yyffZ2iH8Gj3qvnEKHpnHtxK9zXXWzO6g5wO3xlsWqPDqwRpeGJrI5+sf+Jp66/f+F9WMdChl47Za2U/gutujxlzBMMsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Blo3pKxs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760740891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uH8LJn4ypQODNYJ3orBEKrIWWsg1DgFIAiLDa76fO34=;
	b=Blo3pKxs18jhTgFvk2/j/HB6dt+QQ1QHlto+KkeCac5JX9rFE7g4Q19YycQNwMuPLGyxSU
	syIJ1kAPKPEfQ6qFUUq3wgigaJtSrunPiX7gDntQIVdxQX9OG2Ade7FkhcyseURh0pclk8
	DtVaNhNMyLEoGJ29SF/5kTB/vaPDooY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-DiVMYDY-POq2ko1cgGkNpw-1; Fri, 17 Oct 2025 18:41:28 -0400
X-MC-Unique: DiVMYDY-POq2ko1cgGkNpw-1
X-Mimecast-MFC-AGG-ID: DiVMYDY-POq2ko1cgGkNpw_1760740887
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4710c04a403so23357235e9.3
        for <linux-s390@vger.kernel.org>; Fri, 17 Oct 2025 15:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760740887; x=1761345687;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uH8LJn4ypQODNYJ3orBEKrIWWsg1DgFIAiLDa76fO34=;
        b=SMNUDZt6iQrg0TqEm61/aLbjA8LehnPgq2SQFHcB4MdGCIXYBu1W/yUoN8kgMn6hsx
         OaDC/ZGviycirMurXUv211RiBd/6K84KZoCJHeh3Q7v66Yq1xW87TwPsQ1Ox3yDO6HHt
         4QN6N5l5JVmM3oHMMtWmmuvtstGnE2NCm5RX9pek5X+0SRXR03BahKj8u21DzVC55ZRm
         e0P7bi2fp9H8sMp9rNnZdz/N84WsCttYnwt/OrpJ4ZqZ4o6ieJT0fpRJtxsjeEM0o7P/
         U7UQcdveaAgta6uYpdZRGWcKiQHmVwM27TTQtvyVQubGYWYoTeIbNRkEysfbILDmiEd/
         0UsA==
X-Forwarded-Encrypted: i=1; AJvYcCV+kTgMIhwt6nBdZYCB8z5g737doP9NR8XpwG3Pz/h7WJ0Jg5xIaqLwoslbFIFwMnz/GJZNQMRcl2bm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy78OcmRs0welK5L1Tz676XdQfGB2Mcd3H4eQcl5wThRwYjrvvq
	vUP8b5rxi54zJ3rTuvAMKLLhlwRf7OmYqDWewsL6vdmp8oIWJEmhMA6aoF/4o2WZDzyaHwAB/y7
	SmvEQRrL2ww5kLxexGBHBA2L0rGJJP1j7UPtZCY9IPmMLJfqxo0nWcr+ROf/HbHA=
X-Gm-Gg: ASbGncuEMTz82sPUIofK17nUkp+6kKGD8EofBdeDHuoDLhmUOOqNK8O1JZMVuchlS+p
	rj2I8QcSN0WT2na74oT4JX2EkrIjviqRdNOCN8doWTIylO4Mh9ptzXt8Al55GuHpR2PP+YkZ8Dt
	rKA5NuBwqS1RGampHk+9zg2i9gPYf1yy5UdGM7fCliecv/+LmXuNHc8e8sXY0KyFkeFch2ugoBb
	xbjQAjxHPeWVpX9wbNBSWNp9il6wC2xItY8o4DotxUDVHYqFDnfR1SQ+dqYYOGvVvDra6whmx1z
	cl0+1cblkl68Pd/XQaP8S6wyVOaWv0NCsJstzDo8NwuPhKjx9DkanN5Fnh8gJTgcgD8FvdQ23jA
	Fyh39PMKy/JXoMimYWNI3yqtlvhuhukg1WXME8egpp+kWUEw3Q2dq3Udcdibb55l9ONppp8E963
	JhTyg3V6vwDyWyv9m7bIrtIFbE7JM=
X-Received: by 2002:a05:600c:681b:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-47117925e39mr44634025e9.36.1760740887435;
        Fri, 17 Oct 2025 15:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOhQlU/0jutSd2tKVW+63SmQtJ+uWLZ1QBUrTpaFXK1fSJ1MmohMxqY5ZVQykyp7L0xHjr7w==
X-Received: by 2002:a05:600c:681b:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-47117925e39mr44633605e9.36.1760740886944;
        Fri, 17 Oct 2025 15:41:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f19sm1596288f8f.9.2025.10.17.15.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 15:41:26 -0700 (PDT)
Message-ID: <cb85aaa3-e456-4fd8-b323-46c75d453a02@redhat.com>
Date: Sat, 18 Oct 2025 00:41:23 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: KVM/s390x regression
From: David Hildenbrand <david@redhat.com>
To: Balbir Singh <balbirs@nvidia.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Liam.Howlett@oracle.com, airlied@gmail.com, akpm@linux-foundation.org,
 apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 byungchul@sk.com, dakr@kernel.org, dev.jain@arm.com,
 dri-devel@lists.freedesktop.org, francois.dugast@intel.com,
 gourry@gourry.net, joshua.hahnjy@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, lyude@redhat.com,
 matthew.brost@intel.com, mpenttil@redhat.com, npache@redhat.com,
 osalvador@suse.de, rakie.kim@sk.com, rcampbell@nvidia.com,
 ryan.roberts@arm.com, simona@ffwll.ch, ying.huang@linux.alibaba.com,
 ziy@nvidia.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-next@vger.kernel.org
References: <20251001065707.920170-4-balbirs@nvidia.com>
 <20251017144924.10034-1-borntraeger@linux.ibm.com>
 <9beff9d6-47c7-4a65-b320-43efd1e12687@redhat.com>
 <c67386be-5278-411d-97e7-43fc34bf7c98@linux.ibm.com>
 <8c778cd0-5608-4852-9840-4d98828d7b33@redhat.com>
 <74272098-cfb7-424b-a55e-55e94f04524e@linux.ibm.com>
 <84349344-b127-41f6-99f1-10f907c2bd07@redhat.com>
 <c9f28d0c-6b06-47a2-884d-7533f7b49c45@nvidia.com>
 <3a2db8fc-d289-415b-ae67-5a35c9c32a76@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <3a2db8fc-d289-415b-ae67-5a35c9c32a76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.10.25 00:15, David Hildenbrand wrote:
> On 17.10.25 23:56, Balbir Singh wrote:
>> On 10/18/25 04:07, David Hildenbrand wrote:
>>> On 17.10.25 17:20, Christian Borntraeger wrote:
>>>>
>>>>
>>>> Am 17.10.25 um 17:07 schrieb David Hildenbrand:
>>>>> On 17.10.25 17:01, Christian Borntraeger wrote:
>>>>>> Am 17.10.25 um 16:54 schrieb David Hildenbrand:
>>>>>>> On 17.10.25 16:49, Christian Borntraeger wrote:
>>>>>>>> This patch triggers a regression for s390x kvm as qemu guests can no longer start
>>>>>>>>
>>>>>>>> error: kvm run failed Cannot allocate memory
>>>>>>>> PSW=mask 0000000180000000 addr 000000007fd00600
>>>>>>>> R00=0000000000000000 R01=0000000000000000 R02=0000000000000000 R03=0000000000000000
>>>>>>>> R04=0000000000000000 R05=0000000000000000 R06=0000000000000000 R07=0000000000000000
>>>>>>>> R08=0000000000000000 R09=0000000000000000 R10=0000000000000000 R11=0000000000000000
>>>>>>>> R12=0000000000000000 R13=0000000000000000 R14=0000000000000000 R15=0000000000000000
>>>>>>>> C00=00000000000000e0 C01=0000000000000000 C02=0000000000000000 C03=0000000000000000
>>>>>>>> C04=0000000000000000 C05=0000000000000000 C06=0000000000000000 C07=0000000000000000
>>>>>>>> C08=0000000000000000 C09=0000000000000000 C10=0000000000000000 C11=0000000000000000
>>>>>>>> C12=0000000000000000 C13=0000000000000000 C14=00000000c2000000 C15=0000000000000000
>>>>>>>>
>>>>>>>> KVM on s390x does not use THP so far, will investigate. Does anyone have a quick idea?
>>>>>>>
>>>>>>> Only when running KVM guests and apart from that everything else seems to be fine?
>>>>>>
>>>>>> We have other weirdness in linux-next but in different areas. Could that somehow be
>>>>>> related to use disabling THP for the kvm address space?
>>>>>
>>>>> Not sure ... it's a bit weird. I mean, when KVM disables THPs we essentially just remap everything to be mapped by PTEs. So there shouldn't be any PMDs in that whole process.
>>>>>
>>>>> Remapping a file THP (shmem) implies zapping the THP completely.
>>>>>
>>>>>
>>>>> I assume in your kernel config has CONFIG_ZONE_DEVICE and CONFIG_ARCH_ENABLE_THP_MIGRATION set, right?
>>>>
>>>> yes.
>>>>
>>>>>
>>>>> I'd rule out copy_huge_pmd(), zap_huge_pmd() a well.
>>>>>
>>>>>
>>>>> What happens if you revert the change in mm/pgtable-generic.c?
>>>>
>>>> That partial revert seems to fix the issue
>>>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>>>> index 0c847cdf4fd3..567e2d084071 100644
>>>> --- a/mm/pgtable-generic.c
>>>> +++ b/mm/pgtable-generic.c
>>>> @@ -290,7 +290,7 @@ pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
>>>>                if (pmdvalp)
>>>>                     *pmdvalp = pmdval;
>>>> -       if (unlikely(pmd_none(pmdval) || !pmd_present(pmdval)))
>>>> +       if (unlikely(pmd_none(pmdval) || is_pmd_migration_entry(pmdval)))
>>>
>>> Okay, but that means that effectively we stumble over a PMD entry that is not a migration entry but still non-present.
>>>
>>> And I would expect that it's a page table, because otherwise the change
>>> wouldn't make a difference.
>>>
>>> And the weird thing is that this only triggers sometimes, because if
>>> it would always trigger nothing would ever work.
>>>
>>> Is there some weird scenario where s390x might set a left page table mapped in a PMD to non-present?
>>>
>>
>> Good point
>>
>>> Staring at the definition of pmd_present() on s390x it's really just
>>>
>>>       return (pmd_val(pmd) & _SEGMENT_ENTRY_PRESENT) != 0;
>>>
>>>
>>> Maybe this is happening in the gmap code only and not actually in the core-mm code?
>>>
>>
>>
>> I am not an s390 expert, but just looking at the code
>>
>> So the check on s390 effectively
>>
>> segment_entry/present = false or segment_entry_empty/invalid = true
> 
> pmd_present() == true iff _SEGMENT_ENTRY_PRESENT is set
> 
> because
> 
> 	return (pmd_val(pmd) & _SEGMENT_ENTRY_PRESENT) != 0;
> 
> is the same as
> 
> 	return pmd_val(pmd) & _SEGMENT_ENTRY_PRESENT;
> 
> But that means we have something where _SEGMENT_ENTRY_PRESENT is not set.
> 
> I suspect that can only be the gmap tables.
> 
> Likely __gmap_link() does not set _SEGMENT_ENTRY_PRESENT, which is fine
> because it's a software managed bit for "ordinary" page tables, not gmap
> tables.
> 
> Which raises the question why someone would wrongly use
> pte_offset_map()/__pte_offset_map() on the gmap tables.
> 
> I cannot immediately spot any such usage in kvm/gmap code, though.
> 

Ah, it's all that pte_alloc_map_lock() stuff in gmap.c.

Oh my.

So we're mapping a user PTE table that is linked into the gmap tables 
through a PMD table that does not have the right sw bits set we would 
expect in a user PMD table.

What's also scary is that pte_alloc_map_lock() would try to pte_alloc() 
a user page table in the gmap, which sounds completely wrong?

Yeah, when walking the gmap and wanting to lock the linked user PTE 
table, we should probably never use the pte_*map variants but obtain
the lock through pte_lockptr().

All magic we end up doing with RCU etc in __pte_offset_map_lock()
does not apply to the gmap PMD table.

-- 
Cheers

David / dhildenb


