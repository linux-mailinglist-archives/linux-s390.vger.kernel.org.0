Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF54F730019
	for <lists+linux-s390@lfdr.de>; Wed, 14 Jun 2023 15:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbjFNNa5 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 14 Jun 2023 09:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245003AbjFNNaz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 14 Jun 2023 09:30:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F8F1BEF
        for <linux-s390@vger.kernel.org>; Wed, 14 Jun 2023 06:30:53 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EDQOFZ024625;
        Wed, 14 Jun 2023 13:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=nsX9PD6z0Vr1t2k/zctOzdfz6tE9lDT17C1OS5mz8AY=;
 b=BiMEO9amPek17ysTrrBgzQbYd7LAKLAuboIuI147QrqMziPep9sk2oQCsmUajE/5y5cM
 BoVX1iK61VC/mXqCbrwtsbW8JVu2SPf4DEdD9GLXurrQ/fV5AJuUviOqs49qRLiwv9nP
 utnnMpEec91h/hGGCxfdUwHZQ4Ao2R4+iajAb5tf0s5sfy27cGs7ATsMcJM9f4Gzz33F
 uoVbGFiJcsk5n8c/z8jBKxYgMb/fsm0Id6ASIi+pJ9iv6tdss7E7WxsOHxMCT7ve80Dg
 ZGBVl8o4LcqxeFAdboLNa3ohOEEP1Cn+FGO1vfAlcjQnpvBkDikd48SnvM4K3NbJhbF1 RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7ee60378-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 13:30:52 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35EDUq2t008236;
        Wed, 14 Jun 2023 13:30:52 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7ee6035x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 13:30:51 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35ECp0gI012129;
        Wed, 14 Jun 2023 13:30:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3r4gt525hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 13:30:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35EDUjAB62062866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 13:30:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 820E520043;
        Wed, 14 Jun 2023 13:30:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE9BD20040;
        Wed, 14 Jun 2023 13:30:44 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.171.65.118])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
        Wed, 14 Jun 2023 13:30:44 +0000 (GMT)
Date:   Wed, 14 Jun 2023 15:30:42 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 07/12] s390: add pte_free_defer(), with use of
 mmdrop_async()
Message-ID: <20230614153042.43a52187@thinkpad-T15>
In-Reply-To: <a948f24b-4fe6-8bc0-221a-65e9ccc8371a@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
        <6dd63b39-e71f-2e8b-7e0-83e02f3bcb39@google.com>
        <175ebec8-761-c3f-2d98-6c3bd87161c8@google.com>
        <20230606214037.09c6b280@thinkpad-T15>
        <dbed4c5-1d-f278-d03a-66f5eff5e48e@google.com>
        <20230608174756.27cace18@thinkpad-T15>
        <a948f24b-4fe6-8bc0-221a-65e9ccc8371a@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -m4kxTqlmtXcJZcsAhVVUa7UyXGFzHoz
X-Proofpoint-GUID: lHsA84McZkOG29qkb2jW03_1hIrYwyCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_08,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 12 Jun 2023 23:34:08 -0700 (PDT)
Hugh Dickins <hughd@google.com> wrote:

> On Thu, 8 Jun 2023, Gerald Schaefer wrote:
> > On Wed, 7 Jun 2023 20:35:05 -0700 (PDT)
> > Hugh Dickins <hughd@google.com> wrote:  
> > > 
> > > My current thinking (but may be proved wrong) is along the lines of:
> > > why does something on its way to being freed need to be on any list
> > > than the rcu_head list?  I expect the current answer is, that the
> > > other half is allocated, so the page won't be freed; but I hope that
> > > we can put it back on that list once we're through with the rcu_head.  
> > 
> > Yes, that looks promising. Such a fragment would not necessarily need
> > to be on the list, because while it is on its way, i.e. before the
> > RCU call-back finished, it cannot be re-used anyway.
> > 
> > page_table_alloc() could currently find such a fragment on the list, but
> > only to see the PP bits set, so it will not use it. Only after
> > __tlb_remove_table() in the RCU call-back resets the bits, it would be
> > usable again.
> > 
> > In your case, that could correspond to adding it back to the list.
> > That could even be an improvement, because page_table_alloc() would
> > not be bothered by such unusable fragments.  
> 
> Cutting down the Ccs for now, to just the most interested parties:
> here's what I came up with.  Which is entirely unbuilt and untested,
> and I may have got several of those tricky mask conditionals wrong;
> but seems a good way forward, except for the admitted unsolved flaw
> (I do not want to mmgrab() for every single page table).
> 
> I don't think you're at all likely to hit that flaw in practice,
> so if you have time, please do try reviewing and building and running
> (a wrong mask conditional may stop it from even booting, but I hope
> you'll be able to spot what's wrong without wasting too much time).
> And maybe someone can come up with a good solution to the flaw.
> 
> Thanks!
> Hugh
> 
> [PATCH 07/12] s390: add pte_free_defer() for pgtables sharing page
> 
> Add s390-specific pte_free_defer(), to call pte_free() via call_rcu().
> pte_free_defer() will be called inside khugepaged's retract_page_tables()
> loop, where allocating extra memory cannot be relied upon.  This precedes
> the generic version to avoid build breakage from incompatible pgtable_t.
> 
> This version is more complicated than others: because s390 fits two 2K
> page tables into one 4K page (so page->rcu_head must be shared between
> both halves), and already uses page->lru (which page->rcu_head overlays)
> to list any free halves; with clever management by page->_refcount bits.
> 
> Build upon the existing management, adjusted to follow a new rule that
> a page is not linked to mm_context_t::pgtable_list while either half is
> pending free, by either tlb_remove_table() or pte_free_defer(); but is
> afterwards either relinked to the list (if other half is allocated), or
> freed (if other half is free): by __tlb_remove_table() in both cases.
> 
> Set the page->pt_mm field to help with this.  But there is an unsolved
> flaw: although reading that the other half is allocated guarantees that
> the mm is still valid at that instant, what guarantees that it has not
> already been freed before we take its context.lock?

I fear this will not work, the stored mm might not only have been freed,
but even re-used as a different mm, in the worst case. We do hit the
strangest races in Linux when running under z/VM hypervisor, which could
stop CPUs for quite some time...

It would be much more acceptable to simply not add back such fragments
to the list, and therefore risking some memory waste, than risking to
use an unstable mm in __tlb_remove_table(). The amount of wasted memory
in practice might also not be a lot, depending on whether the fragments
belong to the same and contiguous mapping.

Also, we would not need to use page->pt_mm, and therefore make room for
page->pt_frag_refcount, which for some reason is (still) being used
in new v4 from Vishals "Split ptdesc from struct page" series...

See also my modified version of your patch at the end of this somewhat
lengthy mail.

> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  arch/s390/include/asm/pgalloc.h |   4 +
>  arch/s390/mm/pgalloc.c          | 185 +++++++++++++++++++++++---------
>  include/linux/mm_types.h        |   2 +-
>  3 files changed, 142 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
> index 17eb618f1348..89a9d5ef94f8 100644
> --- a/arch/s390/include/asm/pgalloc.h
> +++ b/arch/s390/include/asm/pgalloc.h
> @@ -143,6 +143,10 @@ static inline void pmd_populate(struct mm_struct *mm,
>  #define pte_free_kernel(mm, pte) page_table_free(mm, (unsigned long *) pte)
>  #define pte_free(mm, pte) page_table_free(mm, (unsigned long *) pte)
>  
> +/* arch use pte_free_defer() implementation in arch/s390/mm/pgalloc.c */
> +#define pte_free_defer pte_free_defer
> +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
> +
>  void vmem_map_init(void);
>  void *vmem_crst_alloc(unsigned long val);
>  pte_t *vmem_pte_alloc(void);
> diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
> index 66ab68db9842..b40b2c0008ca 100644
> --- a/arch/s390/mm/pgalloc.c
> +++ b/arch/s390/mm/pgalloc.c
> @@ -172,7 +172,7 @@ void page_table_free_pgste(struct page *page)
>   * When a parent page gets fully allocated it contains 2KB-pgtables in both
>   * upper and lower halves and is removed from mm_context_t::pgtable_list.
>   *
> - * When 2KB-pgtable is freed from to fully allocated parent page that
> + * When 2KB-pgtable is freed from the fully allocated parent page that
>   * page turns partially allocated and added to mm_context_t::pgtable_list.
>   *
>   * If 2KB-pgtable is freed from the partially allocated parent page that
> @@ -182,16 +182,24 @@ void page_table_free_pgste(struct page *page)
>   * As follows from the above, no unallocated or fully allocated parent
>   * pages are contained in mm_context_t::pgtable_list.
>   *
> + * NOTE NOTE NOTE: The commentary above and below has not yet been updated:
> + * the new rule is that a page is not linked to mm_context_t::pgtable_list
> + * while either half is pending free by any method; but afterwards is
> + * either relinked to it, or freed, by __tlb_remove_table().  This allows
> + * pte_free_defer() to use the page->rcu_head (which overlays page->lru).
> + *
>   * The upper byte (bits 24-31) of the parent page _refcount is used
>   * for tracking contained 2KB-pgtables and has the following format:
>   *
> - *   PP  AA
> - * 01234567    upper byte (bits 24-31) of struct page::_refcount
> - *   ||  ||
> - *   ||  |+--- upper 2KB-pgtable is allocated
> - *   ||  +---- lower 2KB-pgtable is allocated
> - *   |+------- upper 2KB-pgtable is pending for removal
> - *   +-------- lower 2KB-pgtable is pending for removal
> + *   PPHHAA
> + * 76543210    upper byte (bits 24-31) of struct page::_refcount

Hmm, big-endian? BTW, the existing (bits 24-31) notation also seems to be
somehow misleading, I guess it should rather read "bits 0-7 of the 32bit
value", but I also often get confused by this, so maybe it is correct.

> + *   ||||||
> + *   |||||+--- lower 2KB-pgtable is allocated
> + *   ||||+---- upper 2KB-pgtable is allocated
> + *   |||+----- lower 2KB-pgtable is pending free by page->rcu_head
> + *   ||+------ upper 2KB-pgtable is pending free by page->rcu_head
> + *   |+------- lower 2KB-pgtable is pending free by any method
> + *   +-------- upper 2KB-pgtable is pending free by any method
>   *
>   * (See commit 620b4e903179 ("s390: use _refcount for pgtables") on why
>   * using _refcount is possible).
> @@ -200,7 +208,7 @@ void page_table_free_pgste(struct page *page)
>   * The parent page is either:
>   *   - added to mm_context_t::pgtable_list in case the second half of the
>   *     parent page is still unallocated;
> - *   - removed from mm_context_t::pgtable_list in case both hales of the
> + *   - removed from mm_context_t::pgtable_list in case both halves of the
>   *     parent page are allocated;
>   * These operations are protected with mm_context_t::lock.
>   *
> @@ -244,25 +252,15 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
>  			page = list_first_entry(&mm->context.pgtable_list,
>  						struct page, lru);
>  			mask = atomic_read(&page->_refcount) >> 24;
> -			/*
> -			 * The pending removal bits must also be checked.
> -			 * Failure to do so might lead to an impossible
> -			 * value of (i.e 0x13 or 0x23) written to _refcount.
> -			 * Such values violate the assumption that pending and
> -			 * allocation bits are mutually exclusive, and the rest
> -			 * of the code unrails as result. That could lead to
> -			 * a whole bunch of races and corruptions.
> -			 */
> -			mask = (mask | (mask >> 4)) & 0x03U;
> -			if (mask != 0x03U) {
> -				table = (unsigned long *) page_to_virt(page);
> -				bit = mask & 1;		/* =1 -> second 2K */
> -				if (bit)
> -					table += PTRS_PER_PTE;
> -				atomic_xor_bits(&page->_refcount,
> -							0x01U << (bit + 24));
> -				list_del(&page->lru);
> -			}
> +			/* Cannot be on this list if either half pending free */
> +			WARN_ON_ONCE(mask & ~0x03U);
> +			/* One or other half must be available, but not both */
> +			WARN_ON_ONCE(mask == 0x00U || mask == 0x03U);
> +			table = (unsigned long *)page_to_virt(page);
> +			bit = mask & 0x01U;	/* =1 -> second 2K available */
> +			table += bit * PTRS_PER_PTE;
> +			atomic_xor_bits(&page->_refcount, 0x01U << (bit + 24));
> +			list_del(&page->lru);

I hope we can do w/o changing page_table_alloc() code, and as little of the
existing, very fragile and carefully tuned, code as possible. At least when
we use the approach of not adding back fragments from pte_free_defer() to
the list.

>  		}
>  		spin_unlock_bh(&mm->context.lock);
>  		if (table)
> @@ -278,6 +276,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
>  	}
>  	arch_set_page_dat(page, 0);
>  	/* Initialize page table */
> +	page->pt_mm = mm;
>  	table = (unsigned long *) page_to_virt(page);
>  	if (mm_alloc_pgste(mm)) {
>  		/* Return 4K page table with PGSTEs */
> @@ -295,7 +294,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
>  	return table;
>  }
>  
> -static void page_table_release_check(struct page *page, void *table,
> +static void page_table_release_check(struct page *page, unsigned long *table,
>  				     unsigned int half, unsigned int mask)
>  {
>  	char msg[128];
> @@ -314,24 +313,22 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
>  	struct page *page;
>  
>  	page = virt_to_page(table);
> +	WARN_ON_ONCE(page->pt_mm != mm);
>  	if (!mm_alloc_pgste(mm)) {
>  		/* Free 2K page table fragment of a 4K page */
>  		bit = ((unsigned long) table & ~PAGE_MASK)/(PTRS_PER_PTE*sizeof(pte_t));
>  		spin_lock_bh(&mm->context.lock);
>  		/*
> -		 * Mark the page for delayed release. The actual release
> -		 * will happen outside of the critical section from this
> -		 * function or from __tlb_remove_table()
> +		 * Mark the page for release. The actual release will happen
> +		 * below from this function, or later from __tlb_remove_table().
>  		 */
> -		mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
> +		mask = atomic_xor_bits(&page->_refcount, 0x01U << (bit + 24));

Uh oh, I have a bad feeling about this. It seems as it would somehow revert
the subtle race fix from commit c2c224932fd0 ("s390/mm: fix 2KB pgtable
release race").

>  		mask >>= 24;
> -		if (mask & 0x03U)
> +		if (mask & 0x03U)		/* other half is allocated */
>  			list_add(&page->lru, &mm->context.pgtable_list);
> -		else
> +		else if (!(mask & 0x30U))	/* other half not pending */
>  			list_del(&page->lru);
>  		spin_unlock_bh(&mm->context.lock);
> -		mask = atomic_xor_bits(&page->_refcount, 0x10U << (bit + 24));
> -		mask >>= 24;
>  		if (mask != 0x00U)
>  			return;
>  		half = 0x01U << bit;
> @@ -355,6 +352,7 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
>  
>  	mm = tlb->mm;
>  	page = virt_to_page(table);
> +	WARN_ON_ONCE(page->pt_mm != mm);
>  	if (mm_alloc_pgste(mm)) {
>  		gmap_unlink(mm, table, vmaddr);
>  		table = (unsigned long *) ((unsigned long)table | 0x03U);
> @@ -364,15 +362,13 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
>  	bit = ((unsigned long) table & ~PAGE_MASK) / (PTRS_PER_PTE*sizeof(pte_t));
>  	spin_lock_bh(&mm->context.lock);
>  	/*
> -	 * Mark the page for delayed release. The actual release will happen
> -	 * outside of the critical section from __tlb_remove_table() or from
> -	 * page_table_free()
> +	 * Mark the page for delayed release.
> +	 * The actual release will happen later, from __tlb_remove_table().
>  	 */
>  	mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
>  	mask >>= 24;
> -	if (mask & 0x03U)
> -		list_add_tail(&page->lru, &mm->context.pgtable_list);

I guess we want to keep this list_add(), if we do not add back fragments in
__tlb_remove_table() instead.

> -	else
> +	/* Other half not allocated? Other half not already pending free? */
> +	if ((mask & 0x03U) == 0x00U && (mask & 0x30U) != 0x30U)
>  		list_del(&page->lru);
>  	spin_unlock_bh(&mm->context.lock);
>  	table = (unsigned long *) ((unsigned long) table | (0x01U << bit));
> @@ -382,17 +378,38 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
>  void void *_table)
>  {
>  	unsigned int mask = (unsigned long) _table & 0x03U, half = mask;
> -	void *table = (void *)((unsigned long) _table ^ mask);
> +	unsigned long *table = (unsigned long *)((unsigned long) _table ^ mask);
>  	struct page *page = virt_to_page(table);
> +	struct mm_struct *mm;
>  
>  	switch (half) {
>  	case 0x00U:	/* pmd, pud, or p4d */
> -		free_pages((unsigned long)table, CRST_ALLOC_ORDER);
> +		__free_pages(page, CRST_ALLOC_ORDER);
>  		return;
>  	case 0x01U:	/* lower 2K of a 4K page table */
> -	case 0x02U:	/* higher 2K of a 4K page table */
> -		mask = atomic_xor_bits(&page->_refcount, mask << (4 + 24));
> -		mask >>= 24;
> +	case 0x02U:	/* upper 2K of a 4K page table */
> +		/*
> +		 * If the other half is marked as allocated, page->pt_mm must
> +		 * still be valid, page->rcu_head no longer in use so page->lru
> +		 * good for use, so now make the freed half available for reuse.
> +		 * But be wary of races with that other half being freed.
> +		 */
> +		if (atomic_read(&page->_refcount) & (0x03U << 24)) {
> +			mm = page->pt_mm;
> +			/*
> +			 * But what guarantees that mm has not been freed now?!
> +			 * It's very unlikely, but we want certainty...
> +			 */
> +			spin_lock_bh(&mm->context.lock);
> +			mask = atomic_xor_bits(&page->_refcount, mask << 28);
> +			mask >>= 24;
> +			if (mask & 0x03U)
> +				list_add(&page->lru, &mm->context.pgtable_list);
> +			spin_unlock_bh(&mm->context.lock);
> +		} else {
> +			mask = atomic_xor_bits(&page->_refcount, mask << 28);
> +			mask >>= 24;
> +		}

Same as for page_table_alloc(), I hope we can avoid touching existing
__tlb_remove_table() code, and certainly not expose also the existing
code to the "unstable mm" risk. So page_table_free_rcu() should stick to
its list_add(), and pte_free_defer() should do w/o adding back.

>  		if (mask != 0x00U)
>  			return;
>  		break;
> @@ -407,6 +424,78 @@ void __tlb_remove_table(void *_table)
>  	__free_page(page);
>  }
>  
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static void pte_free_now0(struct rcu_head *head);
> +static void pte_free_now1(struct rcu_head *head);
> +
> +static void pte_free_pgste(struct rcu_head *head)
> +{
> +	unsigned long *table;
> +	struct page *page;
> +
> +	page = container_of(head, struct page, rcu_head);
> +	table = (unsigned long *)page_to_virt(page);
> +	table = (unsigned long *)((unsigned long)table | 0x03U);
> +	__tlb_remove_table(table);
> +}
> +
> +static void pte_free_half(struct rcu_head *head, unsigned int bit)
> +{
> +	unsigned long *table;
> +	struct page *page;
> +	unsigned int mask;
> +
> +	page = container_of(head, struct page, rcu_head);
> +	mask = atomic_xor_bits(&page->_refcount, 0x04U << (bit + 24));
> +
> +	table = (unsigned long *)page_to_virt(page);
> +	table += bit * PTRS_PER_PTE;
> +	table = (unsigned long *)((unsigned long)table | (0x01U << bit));
> +	__tlb_remove_table(table);
> +
> +	/* If pte_free_defer() of the other half came in, queue it now */
> +	if (mask & 0x0CU)
> +		call_rcu(&page->rcu_head, bit ? pte_free_now0 : pte_free_now1);
> +}
> +
> +static void pte_free_now0(struct rcu_head *head)
> +{
> +	pte_free_half(head, 0);
> +}
> +
> +static void pte_free_now1(struct rcu_read *head)
> +{
> +	pte_free_half(head, 1);
> +}
> +
> +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
> +{
> +	unsigned int bit, mask;
> +	struct page *page;
> +
> +	page = virt_to_page(pgtable);
> +	WARN_ON_ONCE(page->pt_mm != mm);
> +	if (mm_alloc_pgste(mm)) {
> +		call_rcu(&page->rcu_head, pte_free_pgste)

Hmm, in page_table_free_rcu(), which is somewhat similar to this, we
also do a "gmap_unlink(mm, table, vmaddr)" for the mm_alloc_pgste(mm)
case.

Not familiar with this, and also e.g. why we do not care about this
in the non-RCU page_table_free() code. But it might be required here,
and we have no addr here. However, that could probably be passed along
from retract_page_tables(), I guess, if needed.

Christian, Claudio, any idea about gmap_unlink() usage in
page_table_free_rcu() (and why not in page_table_free()), and if
it would also be required here?

IIUC, this whole series would at least ATM only affect THP collapse,
and for KVM, in particular qemu process in the host, we seem to somehow
prevent THP usage in s390_enable_sie():

        /* split thp mappings and disable thp for future mappings */
        thp_split_mm(mm);

So mm_alloc_pgste(mm) might not be a valid case here ATM, but in case
this framework would later also be used for other things, it would be
good to be prepared, i.e. by either passing along the addr, or clarify
that we do not need it...

> +		return;
> +	}
> +	bit = ((unsigned long)pgtable & ~PAGE_MASK) /
> +			(PTRS_PER_PTE * sizeof(pte_t));
> +
> +	spin_lock_bh(&mm->context.lock);
> +	mask = atomic_xor_bits(&page->_refcount, 0x15U << (bit + 24));
> +	mask >>= 24;
> +	/* Other half not allocated? Other half not already pending free? */
> +	if ((mask & 0x03U) == 0x00U && (mask & 0x30U) != 0x30U)
> +		list_del(&page->lru);
> +	spin_unlock_bh(&mm->context.lock);
> +
> +	/* Do not relink on rcu_head if other half already linked on rcu_head */
> +	if ((mask & 0x0CU) != 0x0CU)
> +		call_rcu(&page->rcu_head, bit ? pte_free_now1 : pte_free_now0);

I dot not fully understand if / why we need the new HH bits. While working
on my patch it seemed to be useful for sorting out list_add/del in the
various cases. Here it only seems to be used for preventing double rcu_head
usage, is this correct, or am I missing something?

Not needing the page->pt_mm any more would make room for page->pt_frag_refcount,
and possibly a similar approach like on powerpc, for the double rcu_head
issue. But of course not if Vishal grabs it in his "Split ptdesc from struct
page" series...

So, here is some alternative approach, w/o the "unstable mm" flaw, by not
putting fragments back on the list for the pte_free_defer() case, but
with some risk of (temporarily) wasting an uncertain amount of memory with
half-filled 4K pages for pagetables.

There is unfortunately also very likely another flaw with getting the
list_add() and list_del() right, in page_table_free[_rcu]() vs.
pte_free_defer(). The problem is that pte_free_defer() can only do a
list_del(), and not also list_add(), because it must make sure that
page->lru will not be used any more. This is now asymmetrical to the
other cases. So page_table_free[_rcu](), and also pte_free_defer(),
must avoid list_del() w/o previous list_add().

My approach with checking the new HH bits (0x0CU) is likely racy, when
pte_free_half() clears its H bit. At least for the case where we have
two allocated fragments, and both should be freed via pte_free_defer(),
we might end up with a list_del() although there never was a list_add().

Instead of using the HH bits for synchronizing, it might be possible
to use list_del_init() instead of list_del(), probably in all places,
and check with list_empty() to avoid such a list_del() w/o previous
list_add().

Or alternatively, we could stop adding back fragments to the list
in general, risking some more memory waste. It could also allow to
get rid of the list as a whole, and e.g. only keep some pointer to the
most recent free 2K fragment from a freshly allocated 4K page, for
one-time use. Alexander was playing around with such an idea.

The current code is apparently simply too clever for us, and it only
seems to get harder with every change, like in this case. But maybe we
can handle it one more time...

---
 arch/s390/include/asm/pgalloc.h |    4 +
 arch/s390/mm/pgalloc.c          |  108 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 104 insertions(+), 8 deletions(-)

--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -143,6 +143,10 @@ static inline void pmd_populate(struct m
 #define pte_free_kernel(mm, pte) page_table_free(mm, (unsigned long *) pte)
 #define pte_free(mm, pte) page_table_free(mm, (unsigned long *) pte)
 
+/* arch use pte_free_defer() implementation in arch/s390/mm/pgalloc.c */
+#define pte_free_defer pte_free_defer
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
+
 void vmem_map_init(void);
 void *vmem_crst_alloc(unsigned long val);
 pte_t *vmem_pte_alloc(void);
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -185,11 +185,13 @@ void page_table_free_pgste(struct page *
  * The upper byte (bits 24-31) of the parent page _refcount is used
  * for tracking contained 2KB-pgtables and has the following format:
  *
- *   PP  AA
+ *   PPHHAA
  * 01234567    upper byte (bits 24-31) of struct page::_refcount
- *   ||  ||
- *   ||  |+--- upper 2KB-pgtable is allocated
- *   ||  +---- lower 2KB-pgtable is allocated
+ *   ||||||
+ *   |||||+--- upper 2KB-pgtable is allocated
+ *   ||||+---- lower 2KB-pgtable is allocated
+ *   |||+----- upper 2KB-pgtable is pending free by page->rcu_head
+ *   ||+------ lower 2KB-pgtable is pending free by page->rcu_head
  *   |+------- upper 2KB-pgtable is pending for removal
  *   +-------- lower 2KB-pgtable is pending for removal
  *
@@ -229,6 +231,8 @@ void page_table_free_pgste(struct page *
  * logic described above. Both AA bits are set to 1 to denote a 4KB-pgtable
  * while the PP bits are never used, nor such a page is added to or removed
  * from mm_context_t::pgtable_list.
+ *
+ * TODO: Add comments for HH bits
  */
 unsigned long *page_table_alloc(struct mm_struct *mm)
 {
@@ -325,13 +329,18 @@ void page_table_free(struct mm_struct *m
 		 */
 		mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
 		mask >>= 24;
-		if (mask & 0x03U)
+		/*
+		 * If pte_free_defer() marked other half for delayed release,
+		 * w/o list_add(), we must _not_ do list_del()
+		 */
+		if (mask & 0x03U)		/* other half is allocated */
 			list_add(&page->lru, &mm->context.pgtable_list);
-		else
+		else if (!(mask & 0x0CU))	/* no pte_free_defer() pending */
 			list_del(&page->lru);
 		spin_unlock_bh(&mm->context.lock);
 		mask = atomic_xor_bits(&page->_refcount, 0x10U << (bit + 24));
 		mask >>= 24;
+		/* Return if other half is allocated, or delayed release pending */
 		if (mask != 0x00U)
 			return;
 		half = 0x01U << bit;
@@ -370,9 +379,13 @@ void page_table_free_rcu(struct mmu_gath
 	 */
 	mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
 	mask >>= 24;
-	if (mask & 0x03U)
+	/*
+	 * If pte_free_defer() marked other half for delayed release,
+	 * w/o list_add(), we must _not_ do list_del()
+	 */
+	if (mask & 0x03U)		/* other half is allocated */
 		list_add_tail(&page->lru, &mm->context.pgtable_list);
-	else
+	else if (!(mask & 0x0CU))	/* no pte_free_defer() pending */
 		list_del(&page->lru);
 	spin_unlock_bh(&mm->context.lock);
 	table = (unsigned long *) ((unsigned long) table | (0x01U << bit));
@@ -407,6 +420,85 @@ void __tlb_remove_table(void *_table)
 	__free_page(page);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static void pte_free_now0(struct rcu_head *head);
+static void pte_free_now1(struct rcu_head *head);
+
+static void pte_free_pgste(struct rcu_head *head)
+{
+	unsigned long *table;
+	struct page *page;
+
+	page = container_of(head, struct page, rcu_head);
+	table = (unsigned long *)page_to_virt(page);
+	table = (unsigned long *)((unsigned long)table | 0x03U);
+	__tlb_remove_table(table);
+}
+
+static void pte_free_half(struct rcu_head *head, unsigned int bit)
+{
+	unsigned long *table;
+	struct page *page;
+	unsigned int mask;
+
+	page = container_of(head, struct page, rcu_head);
+	mask = atomic_xor_bits(&page->_refcount, 0x04U << (bit + 24));
+
+	table = (unsigned long *)page_to_virt(page);
+	table += bit * PTRS_PER_PTE;
+	table = (unsigned long *)((unsigned long)table | (0x01U << bit));
+	__tlb_remove_table(table);
+
+	/* If pte_free_defer() of the other half came in, queue it now */
+	if (mask & 0x0CU)
+		call_rcu(&page->rcu_head, bit ? pte_free_now0 : pte_free_now1);
+}
+
+static void pte_free_now0(struct rcu_head *head)
+{
+	pte_free_half(head, 0);
+}
+
+static void pte_free_now1(struct rcu_head *head)
+{
+	pte_free_half(head, 1);
+}
+
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
+{
+	unsigned int bit, mask;
+	struct page *page;
+
+	page = virt_to_page(pgtable);
+	if (mm_alloc_pgste(mm)) {
+		/*
+		 * Need gmap_unlink(mm, pgtable, addr), like in
+		 * page_table_free_rcu() ???
+		 * If yes -> need addr parameter here, like in pte_free_tlb().
+		 */
+		call_rcu(&page->rcu_head, pte_free_pgste);
+		return;
+}
+	bit = ((unsigned long)pgtable & ~PAGE_MASK) / (PTRS_PER_PTE * sizeof(pte_t));
+
+	spin_lock_bh(&mm->context.lock);
+	mask = atomic_xor_bits(&page->_refcount, 0x15U << (bit + 24));
+	mask >>= 24;
+	/*
+	 * Other half not allocated?
+	 * If pte_free_defer() marked other half for delayed release,
+	 * w/o list_add(), we must _not_ do list_del()
+	 */
+	if ((mask & 0x03U) == 0x00U && (mask & 0x0CU) != 0x0CU)
+		list_del(&page->lru);
+	spin_unlock_bh(&mm->context.lock);
+
+	/* Do not relink on rcu_head if other half already linked on rcu_head */
+	if ((mask & 0x0CU) != 0x0CU)
+		call_rcu(&page->rcu_head, bit ? pte_free_now1 : pte_free_now0);
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 /*
  * Base infrastructure required to generate basic asces, region, segment,
  * and page tables that do not make use of enhanced features like EDAT1.

