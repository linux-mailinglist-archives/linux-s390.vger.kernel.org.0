Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FD7262995
	for <lists+linux-s390@lfdr.de>; Wed,  9 Sep 2020 10:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgIIIJI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 9 Sep 2020 04:09:08 -0400
Received: from foss.arm.com ([217.140.110.172]:39454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgIIIJC (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 9 Sep 2020 04:09:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 352C71FB;
        Wed,  9 Sep 2020 01:09:01 -0700 (PDT)
Received: from [10.163.71.250] (unknown [10.163.71.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A94593F66E;
        Wed,  9 Sep 2020 01:08:57 -0700 (PDT)
Subject: Re: [PATCH v4 00/13] mm/debug_vm_pgtable fixes
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>
References: <20200902114222.181353-1-aneesh.kumar@linux.ibm.com>
 <bb0f3427-e2bd-f713-3ea8-d264be0e690b@arm.com>
 <20200904172647.002113d3@thinkpad>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d4199cd4-e042-7a05-8a78-703eae958589@arm.com>
Date:   Wed, 9 Sep 2020 13:38:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200904172647.002113d3@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 09/04/2020 08:56 PM, Gerald Schaefer wrote:
> On Fri, 4 Sep 2020 12:18:05 +0530
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>>
>>
>> On 09/02/2020 05:12 PM, Aneesh Kumar K.V wrote:
>>> This patch series includes fixes for debug_vm_pgtable test code so that
>>> they follow page table updates rules correctly. The first two patches introduce
>>> changes w.r.t ppc64. The patches are included in this series for completeness. We can
>>> merge them via ppc64 tree if required.
>>>
>>> Hugetlb test is disabled on ppc64 because that needs larger change to satisfy
>>> page table update rules.
>>>
>>> These tests are broken w.r.t page table update rules and results in kernel
>>> crash as below. 
>>>
>>> [   21.083519] kernel BUG at arch/powerpc/mm/pgtable.c:304!
>>> cpu 0x0: Vector: 700 (Program Check) at [c000000c6d1e76c0]
>>>     pc: c00000000009a5ec: assert_pte_locked+0x14c/0x380
>>>     lr: c0000000005eeeec: pte_update+0x11c/0x190
>>>     sp: c000000c6d1e7950
>>>    msr: 8000000002029033
>>>   current = 0xc000000c6d172c80
>>>   paca    = 0xc000000003ba0000   irqmask: 0x03   irq_happened: 0x01
>>>     pid   = 1, comm = swapper/0
>>> kernel BUG at arch/powerpc/mm/pgtable.c:304!
>>> [link register   ] c0000000005eeeec pte_update+0x11c/0x190
>>> [c000000c6d1e7950] 0000000000000001 (unreliable)
>>> [c000000c6d1e79b0] c0000000005eee14 pte_update+0x44/0x190
>>> [c000000c6d1e7a10] c000000001a2ca9c pte_advanced_tests+0x160/0x3d8
>>> [c000000c6d1e7ab0] c000000001a2d4fc debug_vm_pgtable+0x7e8/0x1338
>>> [c000000c6d1e7ba0] c0000000000116ec do_one_initcall+0xac/0x5f0
>>> [c000000c6d1e7c80] c0000000019e4fac kernel_init_freeable+0x4dc/0x5a4
>>> [c000000c6d1e7db0] c000000000012474 kernel_init+0x24/0x160
>>> [c000000c6d1e7e20] c00000000000cbd0 ret_from_kernel_thread+0x5c/0x6c
>>>
>>> With DEBUG_VM disabled
>>>
>>> [   20.530152] BUG: Kernel NULL pointer dereference on read at 0x00000000
>>> [   20.530183] Faulting instruction address: 0xc0000000000df330
>>> cpu 0x33: Vector: 380 (Data SLB Access) at [c000000c6d19f700]
>>>     pc: c0000000000df330: memset+0x68/0x104
>>>     lr: c00000000009f6d8: hash__pmdp_huge_get_and_clear+0xe8/0x1b0
>>>     sp: c000000c6d19f990
>>>    msr: 8000000002009033
>>>    dar: 0
>>>   current = 0xc000000c6d177480
>>>   paca    = 0xc00000001ec4f400   irqmask: 0x03   irq_happened: 0x01
>>>     pid   = 1, comm = swapper/0
>>> [link register   ] c00000000009f6d8 hash__pmdp_huge_get_and_clear+0xe8/0x1b0
>>> [c000000c6d19f990] c00000000009f748 hash__pmdp_huge_get_and_clear+0x158/0x1b0 (unreliable)
>>> [c000000c6d19fa10] c0000000019ebf30 pmd_advanced_tests+0x1f0/0x378
>>> [c000000c6d19fab0] c0000000019ed088 debug_vm_pgtable+0x79c/0x1244
>>> [c000000c6d19fba0] c0000000000116ec do_one_initcall+0xac/0x5f0
>>> [c000000c6d19fc80] c0000000019a4fac kernel_init_freeable+0x4dc/0x5a4
>>> [c000000c6d19fdb0] c000000000012474 kernel_init+0x24/0x160
>>> [c000000c6d19fe20] c00000000000cbd0 ret_from_kernel_thread+0x5c/0x6c
>>>
>>> Changes from v3:
>>> * Address review feedback
>>> * Move page table depost and withdraw patch after adding pmdlock to avoid bisect failure.
>>
>> This version
>>
>> - Builds on x86, arm64, s390, arc, powerpc and riscv (defconfig with DEBUG_VM_PGTABLE)
>> - Runs on arm64 and x86 without any regression, atleast nothing that I have noticed
>> - Will be great if this could get tested on s390, arc, riscv, ppc32 platforms as well
> 
> When I quickly tested v3, it worked fine, but now it turned out to
> only work fine "sometimes", both v3 and v4. I need to look into it
> further, but so far it seems related to the hugetlb_advanced_tests().
> 
> I guess there was already some discussion on this test, but we did
> not receive all of the thread(s). Please always add at least
> linux-s390@vger.kernel.org and maybe myself and Vasily Gorbik <gor@linux.ibm.com>
> for further discussions.

IIRC, the V3 series previously had all these addresses copied properly
but this version once again missed copying all required addresses.

> 
> That being said, sorry for duplications, this might already have been
> discussed. Preliminary analysis showed that it only seems to go wrong
> for certain random vaddr values. I cannot make any sense of that yet,
> but what seems strange to me is that the hugetlb_advanced_tests()
> take a (real) pte_t pointer as input, and also use that for all
> kinds of operations (set_huge_pte_at, huge_ptep_get_and_clear, etc.).
> 
> Although all the hugetlb code in the kernel is (mis)using pte_t
> pointers instead of the correct pmd/pud_t pointers like THP, that
> is just for historic reasons. The pointers will actually never point
> to a real pte_t (i.e. page table entry), but of course to a pmd
> or pud entry, depending on hugepage size.

HugeTLB logically operates on a PTE entry irrespective of it's real
page table level position. Nonetheless, IIUC, vaddr here should have
been aligned to real page table level in which the entry is being
mapped currently.

> 
> What is passed in as ptep to hugetlb_advanced_tests() seems to be
> the result from the previous ptep = pte_alloc_map(mm, pmdp, vaddr),
> so I would expect that it points to a real page table entry. Need
> to investigate further, but IIUC, using such a pointer for adding
> large pte entries (i.e. pmd/pud entries) at least feels very wrong
> to me, and I assume it is related to the issues we see on s390.
Will look into this further.

> 
> We actually see different issues, e.g. once a panic directly in
> hugetlb_advanced_tests() -> huge_ptep_get_and_clear(), but also
> indirect symptoms after debug_vm_pgtable() completes, like this:
> 
> [   10.533901] BUG task_struct (Not tainted): Padding overwritten. 0x0000000019f798c7-0x0000000019f798c7 @offset=30087
> 
> Last but not least, what I said about the pte vs. pmd/pud of
> course also should apply to the hugetlb_basic_tests(), although
> they are not directly using a pte_t pointer, and especially
> also not writing to it. Still, the pte_aligned pfn parameter
> is not guaranteed to also be pmd/pud_aligned, which doesn't
> feel right.
hugetlb_basic_tests() does not directly operate on real page table
entries. But I do see the point wrt using pmd_aligned pfn instead.
I will look into this in detail and send out something after this
series settles down.

> 
> So, for now, until this is sorted out, I guess we also need
> to exclude s390 at least from the hugetlb_advanced_tests().
> The hugetlb_basic_tests() seem to work fine so far (probably
> by chance :-))
