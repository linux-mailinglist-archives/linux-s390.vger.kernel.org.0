Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52CF2D54CB
	for <lists+linux-s390@lfdr.de>; Thu, 10 Dec 2020 08:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgLJHla (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 10 Dec 2020 02:41:30 -0500
Received: from foss.arm.com ([217.140.110.172]:54170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgLJHla (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Dec 2020 02:41:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB2CC1FB;
        Wed,  9 Dec 2020 23:40:43 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D4AC3F68F;
        Wed,  9 Dec 2020 23:40:39 -0800 (PST)
Subject: Re: [PATCH 3/3] s390/mm: Define arch_get_mappable_range()
To:     David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20201210065845.GA20691@osiris>
 <E026809E-4624-4ACE-B309-0443704C637B@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0a2f6eb1-c38b-9cc2-5c45-16f6c8999ce2@arm.com>
Date:   Thu, 10 Dec 2020 13:10:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <E026809E-4624-4ACE-B309-0443704C637B@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 12/10/20 12:34 PM, David Hildenbrand wrote:
> 
>> Am 10.12.2020 um 07:58 schrieb Heiko Carstens <hca@linux.ibm.com>:
>>
>> ﻿On Thu, Dec 10, 2020 at 09:48:11AM +0530, Anshuman Khandual wrote:
>>>>> Alternatively leaving __segment_load() and vmem_add_memory() unchanged
>>>>> will create three range checks i.e two memhp_range_allowed() and the
>>>>> existing VMEM_MAX_PHYS check in vmem_add_mapping() on all the hotplug
>>>>> paths, which is not optimal.
>>>>
>>>> Ah, sorry. I didn't follow this discussion too closely. I just thought
>>>> my point of view would be clear: let's not have two different ways to
>>>> check for the same thing which must be kept in sync.
>>>> Therefore I was wondering why this next version is still doing
>>>> that. Please find a way to solve this.
>>>
>>> The following change is after the current series and should work with
>>> and without memory hotplug enabled. There will be just a single place
>>> i.e vmem_get_max_addr() to update in case the maximum address changes
>>> from VMEM_MAX_PHYS to something else later.
>>
>> Still not. That's way too much code churn for what you want to achieve.
>> If the s390 specific patch would look like below you can add
>>
>> Acked-by: Heiko Carstens <hca@linux.ibm.com>
>>
>> But please make sure that the arch_get_mappable_range() prototype in
>> linux/memory_hotplug.h is always visible and does not depend on
>> CONFIG_MEMORY_HOTPLUG. I'd like to avoid seeing sparse warnings
>> because of this.
>>
>> Thanks.
>>
>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>> index 77767850d0d0..e0e78234ae57 100644
>> --- a/arch/s390/mm/init.c
>> +++ b/arch/s390/mm/init.c
>> @@ -291,6 +291,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>    if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
>>        return -EINVAL;
>>
>> +    VM_BUG_ON(!memhp_range_allowed(start, size, 1));
>>    rc = vmem_add_mapping(start, size);
>>    if (rc)
>>        return rc;
>> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
>> index b239f2ba93b0..ccd55e2f97f9 100644
>> --- a/arch/s390/mm/vmem.c
>> +++ b/arch/s390/mm/vmem.c
>> @@ -4,6 +4,7 @@
>>  *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
>>  */
>>
>> +#include <linux/memory_hotplug.h>
>> #include <linux/memblock.h>
>> #include <linux/pfn.h>
>> #include <linux/mm.h>
>> @@ -532,11 +533,23 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
>>    mutex_unlock(&vmem_mutex);
>> }
>>
>> +struct range arch_get_mappable_range(void)
>> +{
>> +    struct range range;
>> +
>> +    range.start = 0;
>> +    range.end = VMEM_MAX_PHYS;
>> +    return range;
>> +}
>> +
>> int vmem_add_mapping(unsigned long start, unsigned long size)
>> {
>> +    struct range range;
>>    int ret;
>>
>> -    if (start + size > VMEM_MAX_PHYS ||
>> +    range = arch_get_mappable_range();
>> +    if (start < range.start ||
>> +        start + size > range.end ||
>>        start + size < start)
>>        return -ERANGE;
>>
>>
> 
> Right, what I had in mind as reply to v1. Not sure if we really need new checks in common code. Having a new memhp_get_pluggable_range() would be sufficient for my use case (virtio-mem).
Didn't quite understand "Not sure if we really need new checks in common code".
Could you please be more specific. New checks as in pagemap_range() ? Because
other places it is either replacing erstwhile check_hotplug_memory_addressable()
or just moving existing checks from platform arch_add_memory() to the beginning
of various hotplug paths.
