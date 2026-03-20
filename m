Return-Path: <linux-s390+bounces-17718-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF/TMXG6vGnQ2QIAu9opvQ
	(envelope-from <linux-s390+bounces-17718-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 20 Mar 2026 04:09:37 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AAB2D559D
	for <lists+linux-s390@lfdr.de>; Fri, 20 Mar 2026 04:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C2553013EFF
	for <lists+linux-s390@lfdr.de>; Fri, 20 Mar 2026 03:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D502DB7B7;
	Fri, 20 Mar 2026 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iqDiujGz"
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5F7B652;
	Fri, 20 Mar 2026 03:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773976174; cv=none; b=F1YRU8naRZkcjM2wsAE4bqldora9lccRgZqFP0iiafZueOhEdlM27HGYBGEyfrimDt3EMZMxO5tN7yHbF2Xdm2LRzTRT9Y3QEoSb+KoPaq9ehWiHywLO53GBNmPspb6rCI+bk1UCYkJA00OeA3WPjpKLKFxUfBshU6gNMnuUDR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773976174; c=relaxed/simple;
	bh=eHrcfrgXzyDt00lG3GNmZ0POlq8wVkQEsXGYIDm81sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ac0okXbg430rV6SLJlLZQ4nsweWxfEyThHd0/V0Dz54bsozD+0qLHjFK5O6scDTen/Z48ILYNPU0PtNW/cPieDGhlGspBH1LpRr8KP0HhvzIn0RUdQrgK7YOS+xN9lYHzXHE7seyKE8CaODlW9XZ8Nj3djeaWz+xXbj7/C2IVgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iqDiujGz; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773976169; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VWrUuwn6/3D2jBpHTBrix7nCaDc+sDPWfC/Ra1XXa8Q=;
	b=iqDiujGz1qka3lINjoa+J+eYyGvSa4NQGAhSgi9MnEwGYQdWEk1fEEpU/LUBh8Y1kjDmM3wGN7NIrO1U3i39P8DpIAGxQV5p6UsNNcykWy/QjhHFj2306h/DtU0Qps4CGfIbMQped4rblzIrzbIwtpOikFqs36OfXrwzAzyp0SA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X.K9Y71_1773976168;
Received: from 30.74.144.136(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.K9Y71_1773976168 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Mar 2026 11:09:29 +0800
Message-ID: <a745d7ad-5d6b-4bef-b102-09139f56556c@linux.alibaba.com>
Date: Fri, 20 Mar 2026 11:09:28 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] mm: change to return bool for
 pmdp_clear_flush_young()
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, Liam.Howlett@oracle.com,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <eb513ed809685f78e0abdeb7f7b6ebdec0fcca18.1773890510.git.baolin.wang@linux.alibaba.com>
 <60e7cc1b-1459-44d8-8088-30b7ba3e9b44@lucifer.local>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <60e7cc1b-1459-44d8-8088-30b7ba3e9b44@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17718-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 46AAB2D559D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/19/26 7:33 PM, Lorenzo Stoakes (Oracle) wrote:
> On Thu, Mar 19, 2026 at 11:24:03AM +0800, Baolin Wang wrote:
>> The pmdp_clear_flush_young() is used to clear the young flag and flush the
>> TLB, returning whether the young flag was set for this PMD entry. Change
>> the return type to bool to make the intention clearer.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Some nits, but otherwise LGTM, so:
> 
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> 
>> ---
>>   arch/s390/include/asm/pgtable.h |  4 ++--
>>   arch/x86/include/asm/pgtable.h  |  4 ++--
>>   arch/x86/mm/pgtable.c           |  6 +++---
>>   include/linux/pgtable.h         | 10 +++++-----
>>   mm/pgtable-generic.c            |  7 ++++---
>>   5 files changed, 16 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
>> index 1f5efb7be71d..90bba85ca4b8 100644
>> --- a/arch/s390/include/asm/pgtable.h
>> +++ b/arch/s390/include/asm/pgtable.h
>> @@ -1693,8 +1693,8 @@ static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
>>   }
>>
>>   #define __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
>> -static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
>> -					 unsigned long addr, pmd_t *pmdp)
>> +static inline bool pmdp_clear_flush_young(struct vm_area_struct *vma,
>> +					  unsigned long addr, pmd_t *pmdp)
> 
> Same indentation comment as with other patches, 2 tabs you know the drill :)
> applies to all such in this patch.
> 
>>   {
>>   	VM_BUG_ON(addr & ~HPAGE_MASK);
>>   	return pmdp_test_and_clear_young(vma, addr, pmdp);
>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>> index bd02ee730a23..f9439449c9bd 100644
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -1301,8 +1301,8 @@ extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
>>   				     unsigned long addr, pud_t *pudp);
>>
>>   #define __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
>> -extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
>> -				  unsigned long address, pmd_t *pmdp);
>> +extern bool pmdp_clear_flush_young(struct vm_area_struct *vma,
>> +				   unsigned long address, pmd_t *pmdp);
> 
> Drop the extern please!

Ack.

>>   #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
>> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>> index 10a5e0b2be36..8c336edf0e65 100644
>> --- a/arch/x86/mm/pgtable.c
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -503,10 +503,10 @@ bool ptep_clear_flush_young(struct vm_area_struct *vma,
>>   }
>>
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -int pmdp_clear_flush_young(struct vm_area_struct *vma,
>> -			   unsigned long address, pmd_t *pmdp)
>> +bool pmdp_clear_flush_young(struct vm_area_struct *vma,
>> +			    unsigned long address, pmd_t *pmdp)
>>   {
>> -	int young;
>> +	bool young;
>>
>>   	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>>
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index e53220b0a9a3..8b8838f19af3 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -536,18 +536,18 @@ bool ptep_clear_flush_young(struct vm_area_struct *vma,
>>
>>   #ifndef __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
>> -				  unsigned long address, pmd_t *pmdp);
>> +bool pmdp_clear_flush_young(struct vm_area_struct *vma,
>> +		unsigned long address, pmd_t *pmdp);
> 
> Ahh! Here you drop the extern :) AND use 2 tabs :)) thanks!

Right. Because this is the mm subsystem, and I know the maintainers' 
preferences:)

