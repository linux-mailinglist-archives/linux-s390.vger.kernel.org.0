Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFF97AAA50
	for <lists+linux-s390@lfdr.de>; Fri, 22 Sep 2023 09:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjIVHdl (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 22 Sep 2023 03:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjIVHdk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 22 Sep 2023 03:33:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BC1E195;
        Fri, 22 Sep 2023 00:33:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B091CDA7;
        Fri, 22 Sep 2023 00:34:09 -0700 (PDT)
Received: from [10.57.65.11] (unknown [10.57.65.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 412E53F5A1;
        Fri, 22 Sep 2023 00:33:09 -0700 (PDT)
Message-ID: <597e7496-ef99-4505-88ee-91701af02835@arm.com>
Date:   Fri, 22 Sep 2023 08:33:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/8] powerpc: hugetlb: Convert set_huge_pte_at() to
 take vma
Content-Language: en-GB
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20230921162007.1630149-1-ryan.roberts@arm.com>
 <20230921162007.1630149-3-ryan.roberts@arm.com>
 <0f2dd31a-a361-24ba-154d-4e614c0eff73@csgroup.eu>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <0f2dd31a-a361-24ba-154d-4e614c0eff73@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 22/09/2023 07:56, Christophe Leroy wrote:
> 
> 
> Le 21/09/2023 à 18:20, Ryan Roberts a écrit :
>> In order to fix a bug, arm64 needs access to the vma inside it's
>> implementation of set_huge_pte_at(). Provide for this by converting the
>> mm parameter to be a vma. Any implementations that require the mm can
>> access it via vma->vm_mm.
>>
>> This commit makes the required powerpc modifications. Separate commits
>> update the other arches and core code, before the actual bug is fixed in
>> arm64.
>>
>> No behavioral changes intended.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h | 3 ++-
>>   arch/powerpc/mm/book3s64/hugetlbpage.c           | 2 +-
>>   arch/powerpc/mm/book3s64/radix_hugetlbpage.c     | 2 +-
>>   arch/powerpc/mm/nohash/8xx.c                     | 2 +-
>>   arch/powerpc/mm/pgtable.c                        | 7 ++++++-
>>   5 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
>> index de092b04ee1a..fff8cd726bc7 100644
>> --- a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
>> +++ b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
>> @@ -46,7 +46,8 @@ static inline int check_and_get_huge_psize(int shift)
>>   }
>>   
>>   #define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
>> -void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte);
>> +void set_huge_pte_at(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep, pte_t pte);
>> +void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte);
> 
> Don't add the burden of an additional function, see below
> 
>>   
>>   #define __HAVE_ARCH_HUGE_PTE_CLEAR
>>   static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>> diff --git a/arch/powerpc/mm/book3s64/hugetlbpage.c b/arch/powerpc/mm/book3s64/hugetlbpage.c
>> index 3bc0eb21b2a0..ae7fd7c90eb8 100644
>> --- a/arch/powerpc/mm/book3s64/hugetlbpage.c
>> +++ b/arch/powerpc/mm/book3s64/hugetlbpage.c
>> @@ -147,7 +147,7 @@ void huge_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr
>>   	if (radix_enabled())
>>   		return radix__huge_ptep_modify_prot_commit(vma, addr, ptep,
>>   							   old_pte, pte);
>> -	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
>> +	set_huge_pte_at(vma, addr, ptep, pte);
>>   }
>>   
>>   void __init hugetlbpage_init_defaultsize(void)
>> diff --git a/arch/powerpc/mm/book3s64/radix_hugetlbpage.c b/arch/powerpc/mm/book3s64/radix_hugetlbpage.c
>> index 17075c78d4bc..7cd40a334c3a 100644
>> --- a/arch/powerpc/mm/book3s64/radix_hugetlbpage.c
>> +++ b/arch/powerpc/mm/book3s64/radix_hugetlbpage.c
>> @@ -58,5 +58,5 @@ void radix__huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
>>   	    atomic_read(&mm->context.copros) > 0)
>>   		radix__flush_hugetlb_page(vma, addr);
>>   
>> -	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
>> +	set_huge_pte_at(vma, addr, ptep, pte);
>>   }
>> diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
>> index dbbfe897455d..650a7a8496b6 100644
>> --- a/arch/powerpc/mm/nohash/8xx.c
>> +++ b/arch/powerpc/mm/nohash/8xx.c
>> @@ -91,7 +91,7 @@ static int __ref __early_map_kernel_hugepage(unsigned long va, phys_addr_t pa,
>>   	if (new && WARN_ON(pte_present(*ptep) && pgprot_val(prot)))
>>   		return -EINVAL;
>>   
>> -	set_huge_pte_at(&init_mm, va, ptep, pte_mkhuge(pfn_pte(pa >> PAGE_SHIFT, prot)));
>> +	__set_huge_pte_at(&init_mm, va, ptep, pte_mkhuge(pfn_pte(pa >> PAGE_SHIFT, prot)));
> 
> Call set_huge_pte_at() with a NULL vma instead.

I'm happy to take your proposed approach if that's your preference. Another
option is to use a dummy VMA, as I have done in the core code, for the one call
site that calls set_huge_pte_at() with init_mm:

struct vm_area_struct vma = TLB_FLUSH_VMA(&init_mm, 0);

This is an existing macro that creates a dummy vma with vma->vm_mm filled in.
Then I pass &vma to the function.

Or yet another option would be to keep the mm param as is in set_huge_pte_at(),
and add a size param to the function. But then all call sites have the burden of
figuring out the size of the huge pte (although I think most know already).

Thanks,
Ryan

> 
>>   
>>   	return 0;
>>   }
>> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
>> index 3f86fd217690..9cbcb561a4d8 100644
>> --- a/arch/powerpc/mm/pgtable.c
>> +++ b/arch/powerpc/mm/pgtable.c
>> @@ -288,7 +288,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>>   }
>>   
>>   #if defined(CONFIG_PPC_8xx)
>> -void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte)
>> +void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte)
> 
> Keep it as set_huge_pte_at() with vma argument.
> 
>>   {
>>   	pmd_t *pmd = pmd_off(mm, addr);
> 
> Change to:
> 
> 	pmd_t *pmd = vma ? pmd_off(vma->vm_mm, addr) : pmd_off_k(addr);
> 
>>   	pte_basic_t val;
>> @@ -310,6 +310,11 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_
>>   	for (i = 0; i < num; i++, entry++, val += SZ_4K)
>>   		*entry = val;
>>   }
>> +
>> +void set_huge_pte_at(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep, pte_t pte)
>> +{
>> +	__set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
>> +}
> 
> Remove this burden.
> 
>>   #endif
>>   #endif /* CONFIG_HUGETLB_PAGE */
>>   
> 
> 
> Christophe

