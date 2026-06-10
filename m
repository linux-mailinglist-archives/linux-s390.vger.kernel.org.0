Return-Path: <linux-s390+bounces-20716-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YVVUJeAlKWoaRgMAu9opvQ
	(envelope-from <linux-s390+bounces-20716-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 10 Jun 2026 10:52:48 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7AD667724
	for <lists+linux-s390@lfdr.de>; Wed, 10 Jun 2026 10:52:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gqceO5Wt;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20716-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-20716-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8850B31BED7D
	for <lists+linux-s390@lfdr.de>; Wed, 10 Jun 2026 08:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCC5371CEE;
	Wed, 10 Jun 2026 08:46:32 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB001DED5C;
	Wed, 10 Jun 2026 08:46:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081192; cv=none; b=hkV9tEkfqisSol5X365Jexd+JqBE+AxTg22jX6shGda5ZLfaGvz0sO/JMLWzSIAOgsJ8Bp1x0EMftKMdKlSY2Sfy6keZcDQOcNl5caz1B8Z1np+pPCQRF8hj78X2Mtj53L/0vZT75TdY2gipxl80Zi/q511iJGcPCnCCMeroJWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081192; c=relaxed/simple;
	bh=CW7D2KmFoUyODNxdFyyPKcB7Pvi/YhHuRsdONjhmuQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YCyPkjD7pD7sZFif8nJ2b98vPpicJEJ/tSkbJ/aE6UJBsbAJic4szDwKVh1YoAA05kt+zAuu6trurHsLnCmHezciT0THVAwMFPd44J+PHGk9vbjbDQUolbN8OHxb3sqtnm9vq8toRGyrb54VnWTUlhs4qLxE12/c+H10OeH6qBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqceO5Wt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954211F00893;
	Wed, 10 Jun 2026 08:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781081191;
	bh=GIu5mk7+fDzBkFE8LUyyxyRKu1YjSQcW0/cQDtsXGSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gqceO5WtU+8o4iRLg+54E8X01VwOX/Pcl7CIT39DQ0pqmrHHo/vBxeK7jsaOAcCaS
	 YBgcKllYIQj1HWF/hPyROXVFlBBcsVf7biqD1SoLBFLlOCDPz2cSZKwrkPq2JjJeON
	 Ktk7ZoQL/je6Tm7V0x4WHLl6FPfnSFgfRLowvXIjL0V6x/Z73L5zTuiKuUCUObt8VJ
	 vIsqW9AMwRWNEkg0dDhmgKSYTJ0+WlZY+fHkDiYP/mNT/IAr5DJi+PSaHxr1QXu7ax
	 U6yoqsWAiXT9wxpMsRUn8xlVD4N61bGUJO8A/UMw01rLgt/SDu1HpcZ4IbOjfgm+V1
	 vidQTXP2nKKgg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Petr Tesarik <ptesarik@suse.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 06/20] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
In-Reply-To: <20260609144836.4ecea34e@mordecai>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-7-aneesh.kumar@kernel.org>
 <20260609144836.4ecea34e@mordecai>
Date: Wed, 10 Jun 2026 14:16:17 +0530
Message-ID: <yq5acxxyzsti.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20716-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ptesarik@suse.com,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:jgg@ziepe.ca,m:smostafa@google.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,m:jiri@nvidia.com,m:mhklinux@outlook.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aneesh.kumar@kernel.org,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,lists.infradead.org,vger.kernel.org,arm.com,samsung.com,kernel.org,resnulli.us,ziepe.ca,google.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,nvidia.com,outlook.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aneesh.kumar@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F7AD667724

Petr Tesarik <ptesarik@suse.com> writes:

> On Thu,  4 Jun 2026 14:09:45 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
>

...

>>  /*
>>   * If memory encryption is supported, phys_to_dma will set the memory encryption
>>   * bit in the DMA address, and dma_to_phys will clear it.
>> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
>> index 29187cec90d8..4dcbf3931be1 100644
>> --- a/include/linux/swiotlb.h
>> +++ b/include/linux/swiotlb.h
>> @@ -81,6 +81,7 @@ struct io_tlb_pool {
>>  	struct list_head node;
>>  	struct rcu_head rcu;
>>  	bool transient;
>> +	bool unencrypted;
>
> IIUC this is a copy of the unencrypted member in the corresponding
> struct io_tlb_mem. In other words, if pools are allocated dynamically,
> all pools must have the same encryption state, correct?
>

That is correct. The reason we have the unencrypted member in struct
io_tlb_pool is that we need it in swiotlb_dyn_free().

When freeing memory from an unencrypted pool, we need to convert the
memory back to private/encrypted

>
>>  #endif
>>  };
>>  
>> @@ -111,6 +112,7 @@ struct io_tlb_mem {
>>  	struct dentry *debugfs;
>>  	bool force_bounce;
>>  	bool for_alloc;
>> +	bool unencrypted;
>>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>>  	bool can_grow;
>>  	u64 phys_limit;
>> @@ -282,7 +284,8 @@ static inline void swiotlb_sync_single_for_cpu(struct device *dev,
>>  extern void swiotlb_print_info(void);

....

>> @@ -604,30 +621,26 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
>>   * @dev:	Device for which a memory pool is allocated.
>>   * @bytes:	Size of the buffer.
>>   * @phys_limit:	Maximum allowed physical address of the buffer.
>> + * @attrs:	DMA attributes for the allocation.
>>   * @gfp:	GFP flags for the allocation.
>>   *
>>   * Return: Allocated pages, or %NULL on allocation failure.
>>   */
>>  static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
>> -		u64 phys_limit, gfp_t gfp)
>> +		u64 phys_limit, unsigned long attrs, gfp_t gfp)
>
> If my assumption above is correct, then I prefer to add a struct
> io_tlb_mem *mem parameter here and calculate the allocation attributes
> inside this function, so you don't have to repeat it in the callers.
>

Will switch to that. That is, we will use struct io_tlb_mem->unencrypted
to determine the pool attribute instead of using unsigned long attrs

>
>>  {
>>  	struct page *page;
>> -	unsigned long attrs = 0;
>>  
>>  	/*
>>  	 * Allocate from the atomic pools if memory is encrypted and
>>  	 * the allocation is atomic, because decrypting may block.
>>  	 */
>> -	if (!gfpflags_allow_blocking(gfp) && dev && force_dma_unencrypted(dev)) {
>> +	if (!gfpflags_allow_blocking(gfp) && (attrs & DMA_ATTR_CC_SHARED)) {
>
> You're removing the check that dev is non-NULL. This is fine, because
> the only call with dev == NULL is from swiotlb_dyn_alloc(), and that one
> uses GFP_KERNEL (i.e. allows blocking). However, if this is an intended
> optimization, I'd rather have it in a separate commit, with this
> explanation why it's OK to do it.
>
> The rest of the patch looks good to me.
>

I'll add that back.

-aneesh

