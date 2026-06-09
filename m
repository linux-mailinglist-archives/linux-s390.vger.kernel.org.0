Return-Path: <linux-s390+bounces-20689-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T0EwNIgmKGqE/AIAu9opvQ
	(envelope-from <linux-s390+bounces-20689-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 16:43:20 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7E8661461
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 16:43:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=n8qnK6p+;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20689-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20689-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49D8830A3096
	for <lists+linux-s390@lfdr.de>; Tue,  9 Jun 2026 14:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C17932B12D;
	Tue,  9 Jun 2026 14:32:47 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCD234389A
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 14:32:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015567; cv=none; b=Iy2YGr5SaRYAEPL3faMyxkisUaVdUqFEw42YL4CnF3EVRCsR1PO27Cj84jF7nTAmK/9n+88UMwvBBrQrQdODMeEsmR+GAnTl1tNmu+/pEKnHFTJNy2P2ERROSo7qf1QS62LH5OIMmr47VLvAcahtTtZgib2YnyAmitSq9/PHieA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015567; c=relaxed/simple;
	bh=HZyPOuiNCQ2/FcFDihBMt8c7vcnJQS9bgoylFwsrqHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/l0pCGpP2g91jPavIZYgnemKR4MWk3Pt5SdLHCi4Tc3gvAVXHaqD3dBb+iX3oneDHdxECnA/upLe1KPZc1OBDH0mt+ny+R5kqQ1Vnf4Tv2gO9z5wcbFAZS1meBOBZQ3izlzGJshBriyJzs9HfrR5p38gn5I3RI0C+3FN934yh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=n8qnK6p+; arc=none smtp.client-ip=209.85.222.177
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9157f7c1c0eso565059085a.1
        for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781015564; x=1781620364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D9KAUhO8tYdZLzMRayCE9PmCg2//sOlzvRLMvdEyREI=;
        b=n8qnK6p+KO7bWPvXpr3bPdLdsGEm6uFfxLLUL5nx1+cKD7haoS+2BZI2faHYpDGl6b
         1mytzGCEhcYaz8XrTrk/kja+LrVnJxvnMGZUts66G5I30P/64MXlTYtajDPZN4GaBrp4
         UNKUiYTZ59D7c98iscS2KVyhSapehs7ZbQnAp5c52rWP+4ADlUchNY4pOEYMiwICA/m/
         jBsjbr+gCed8skrQTa4VdtQb5uJm8NLD1bhVIm0N+cDur86FptuhCZLpPH7JLaAGGyap
         RcrYKnA0ojQyw25Y11mxBlmdpRY16jKiE2ujNyWS/FNzCG/fAQFixxswgtU4Be+rJA4n
         xlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015564; x=1781620364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9KAUhO8tYdZLzMRayCE9PmCg2//sOlzvRLMvdEyREI=;
        b=f8372SrRFP9Zu28GTAi6Z2Rbi3UKVUf+CSn8CeSev6gmHqUAwQnihMfwWLLkk1XhP4
         RfTBZnnLfWmZ4dnus8W4FbMpXw3CrPO/gozl0JJhK3nRiqUwua6nxGDNGH65A6mdC9lL
         h4B+LiVvXyV3OQYHG2IKEeV1q3G10uGzmyd4LBMQ6f2gVoCPU157ukkCz9zc6yG/d6XS
         Y//s5a5hWJ2HPerJZ3Td2umcTugOy6NkJCF4PjCoTIyGEY0FZq4nBr5djiSOJsP/n0km
         fJxPa+gqZ7c+O2/qciub+ZahebP7Rg8JvrOtdR9VQZPa2W3ku1QepO6o773XiD/yEFiq
         s8fQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1n3PuHwzeBvxiczJcd9oMUVH8T+CeDf0UsvhEQGzQJCHQ7gKUnos5saWVi2qgvt47it7yrDSU73C6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/KeXYvlMoVKMJn71VmerbJIXQ8ck40F0jNFAJ79FanRc5WYlR
	xutaA6WM1sHjrqeli4JfTxbONR5P0PSMgxDv8G0eK6ggoGQTb7LBiynHLj5hrkyrPzg=
X-Gm-Gg: Acq92OF23DMJMZ5vGH0WbXSMJMdxi6oTnSm8ow+/JxAmZqtxpcVyCD32Qv5feAQ9aew
	LYFYu/ZdDB1Nup9jxaY96xlRPbi/dzvFrf5JLTFo6RIaVQP5fgBrIrg3xzw8U/M07EgqnCr+VFS
	rPuUh2jL/4Qi4G0pJK7GTHmWVIabS82hqcZTKQgNSRGeqx72EDsl46F7tPs23GKlVVepXlFmUYq
	bugUiOXXwqracja/uScImOTYOXaE8dTGosmY8EuKWyWco7zle5wXzDgHQ+B7tnNsYvCqvChAIfp
	Ur65PGgoJtN+Jyh1qQqUcG5HWALPXmHjqCx4NsppXAl5t4X4D+yRtI8SN8IcKBSd2QPdUF3vX4h
	gJCNIKaKxaxK02UTsZIZEJ4Z4KwMsM6x8dGhwuJHbpiAeVAxxdOlxM6604sDHS3pYdg1t7DvZwx
	5WUz3ZEC3jVjpqADqLJx58cdEym4FwdwCC12LyK3/PpslmlZ9sDd1hRyNlKnQcGQo3N5Nqv1PNj
	rsSK9+YT6Smg8y5
X-Received: by 2002:a05:620a:c46:b0:915:9f28:6748 with SMTP id af79cd13be357-915a9cdcf02mr3443110085a.23.1781015564257;
        Tue, 09 Jun 2026 07:32:44 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00afafsm2106743685a.2.2026.06.09.07.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:32:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWxVS-0000000241b-3Vv0;
	Tue, 09 Jun 2026 11:32:42 -0300
Date: Tue, 9 Jun 2026 11:32:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
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
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 04/20] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260609143242.GK2764304@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-5-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604083959.1265923-5-aneesh.kumar@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20689-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:aneesh.kumar@kernel.org,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:smostafa@google.com,m:ptesarik@suse.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,m:jiri@nvidia.com,m:mhklinux@outlook.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[lists.linux.dev,lists.infradead.org,vger.kernel.org,arm.com,samsung.com,kernel.org,resnulli.us,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,nvidia.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B7E8661461

On Thu, Jun 04, 2026 at 02:09:43PM +0530, Aneesh Kumar K.V (Arm) wrote:
>  struct page *dma_alloc_from_pool(struct device *dev, size_t size,
> -		void **cpu_addr, gfp_t gfp,
> +		void **cpu_addr, gfp_t gfp, unsigned long attrs,
>  		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
>  {
> -	struct gen_pool *pool = NULL;
> +	struct dma_gen_pool *dma_pool = NULL;
>  	struct page *page;
>  	bool pool_found = false;
>  
> -	while ((pool = dma_guess_pool(pool, gfp))) {
> +	while ((dma_pool = dma_guess_pool(dma_pool, gfp))) {
> +
> +		if (dma_pool->unencrypted != !!(attrs & DMA_ATTR_CC_SHARED))
> +			continue;

I don't think you should be overloading DMA_ATTR_CC_SHARED like this.

	/*
	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
	 * attribute. The direct allocator uses it internally after it has
	 * decided that the backing pages must be shared/decrypted, so the
	 * rest of the allocation path can consistently select DMA addresses,
	 * choose compatible pools and restore encryption on free.
	 */
	if (attrs & DMA_ATTR_CC_SHARED)
		return NULL;

	if (force_dma_unencrypted(dev)) {
		attrs |= DMA_ATTR_CC_SHARED;
		mark_mem_decrypt = true;
	}

It is fine to have a bit inside the attrs that is only used by the
internal logic, but it needs to have a clearer name
__DMA_ATTR_REQUIRE_CC_SHARED perhaps.

The sashiko note does look legit though:

	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
	    !gfpflags_allow_blocking(gfp) && !coherent) {
		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
					   gfp, attrs, NULL);
		if (!page)
			return NULL;

I don't see anything doing the force_dma_unencrypted test along this
callchain..

I guess it should be done one step up in dma_alloc_attrs() instead of
in dma_direct_alloc()?

Jason

