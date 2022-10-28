Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D4B610786
	for <lists+linux-s390@lfdr.de>; Fri, 28 Oct 2022 03:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiJ1B46 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 27 Oct 2022 21:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbiJ1B45 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 27 Oct 2022 21:56:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F04EAEA1F;
        Thu, 27 Oct 2022 18:56:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7287123A;
        Thu, 27 Oct 2022 18:57:00 -0700 (PDT)
Received: from [192.168.0.146] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86D553F445;
        Thu, 27 Oct 2022 18:56:44 -0700 (PDT)
Message-ID: <55256df4-fff1-fa78-97bc-7aaa9efb7255@arm.com>
Date:   Fri, 28 Oct 2022 07:26:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 2/2] arm64: support batched/deferred tlb shootdown
 during page reclamation
Content-Language: en-US
To:     Barry Song <21cnbao@gmail.com>
Cc:     Yicong Yang <yangyicong@huawei.com>, yangyicong@hisilicon.com,
        corbet@lwn.net, peterz@infradead.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, darren@os.amperecomputing.com,
        huzhanyuan@oppo.com, lipeifeng@oppo.com, zhangshiming@oppo.com,
        guojian@oppo.com, realmz6@gmail.com, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        wangkefeng.wang@huawei.com, xhao@linux.alibaba.com,
        prime.zeng@hisilicon.com, Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>,
        catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org
References: <20220921084302.43631-1-yangyicong@huawei.com>
 <20220921084302.43631-3-yangyicong@huawei.com>
 <168eac93-a6ee-0b2e-12bb-4222eff24561@arm.com>
 <8e391962-4e3a-5a56-64b4-78e8637e3b8c@huawei.com>
 <CAGsJ_4z=dZbrAUD9jczT08S3qi_ep-h+EK35UfayVk1S+Cnp2A@mail.gmail.com>
 <ecd161db-b290-7997-a81e-a0a00bd1c599@arm.com>
 <CAGsJ_4x0KhEjm5a9jhtS+YK1AT49u3sHnp2rHZVSuTGZp4nKzA@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAGsJ_4x0KhEjm5a9jhtS+YK1AT49u3sHnp2rHZVSuTGZp4nKzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 10/28/22 03:37, Barry Song wrote:
> On Thu, Oct 27, 2022 at 11:42 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>>
>>
>> On 9/28/22 05:53, Barry Song wrote:
>>> On Tue, Sep 27, 2022 at 10:15 PM Yicong Yang <yangyicong@huawei.com> wrote:
>>>>
>>>> On 2022/9/27 14:16, Anshuman Khandual wrote:
>>>>> [...]
>>>>>
>>>>> On 9/21/22 14:13, Yicong Yang wrote:
>>>>>> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
>>>>>> +{
>>>>>> +    /* for small systems with small number of CPUs, TLB shootdown is cheap */
>>>>>> +    if (num_online_cpus() <= 4)
>>>>>
>>>>> It would be great to have some more inputs from others, whether 4 (which should
>>>>> to be codified into a macro e.g ARM64_NR_CPU_DEFERRED_TLB, or something similar)
>>>>> is optimal for an wide range of arm64 platforms.
>>>>>
>>>
>>> I have tested it on a 4-cpus and 8-cpus machine. but i have no machine
>>> with 5,6,7
>>> cores.
>>> I saw improvement on 8-cpus machines and I found 4-cpus machines don't need
>>> this patch.
>>>
>>> so it seems safe to have
>>> if (num_online_cpus()  < 8)
>>>
>>>>
>>>> Do you prefer this macro to be static or make it configurable through kconfig then
>>>> different platforms can make choice based on their own situations? It maybe hard to
>>>> test on all the arm64 platforms.
>>>
>>> Maybe we can have this default enabled on machines with 8 and more cpus and
>>> provide a tlbflush_batched = on or off to allow users enable or
>>> disable it according
>>> to their hardware and products. Similar example: rodata=on or off.
>>
>> No, sounds bit excessive. Kernel command line options should not be added
>> for every possible run time switch options.
>>
>>>
>>> Hi Anshuman, Will,  Catalin, Andrew,
>>> what do you think about this approach?
>>>
>>> BTW, haoxin mentioned another important user scenarios for tlb bach on arm64:
>>> https://lore.kernel.org/lkml/393d6318-aa38-01ed-6ad8-f9eac89bf0fc@linux.alibaba.com/
>>>
>>> I do believe we need it based on the expensive cost of tlb shootdown in arm64
>>> even by hardware broadcast.
>>
>> Alright, for now could we enable ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH selectively
>> with CONFIG_EXPERT and for num_online_cpus()  > 8 ?
> 
> Sounds good to me. It is a good start to bring up tlb batched flush in
> ARM64. Later on, we
> might want to see it in both memory reclamation and migration.

Right, that is the idea, CONFIG_EXPERT gives an way to test this out for some time
on various platforms, and later it can be dropped off. Regarding num_online_cpus()
= '8' as the threshold which would potentially give benefit of batched TLB should
be defined as a macro e.g NR_CPUS_FOR_BATCHED_TLB or internal (non user selectable)
config , with a proper in-code comment, explaining the rationale.
