Return-Path: <linux-s390+bounces-4450-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C820A90DB8C
	for <lists+linux-s390@lfdr.de>; Tue, 18 Jun 2024 20:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0531F2325B
	for <lists+linux-s390@lfdr.de>; Tue, 18 Jun 2024 18:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B7E15E5C3;
	Tue, 18 Jun 2024 18:26:08 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0D213DDDF;
	Tue, 18 Jun 2024 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718735168; cv=none; b=kBIX+iMqPMNSv+T/R1g9Dku5iaf1DmNvePZtinyujXGB3i3bXgKdw+AVgz0n7h9m5qAEFxDfsrXSPYfF2bnEMt49Qe2da72JFyEgU9HbwNLShI9IkDJssNG0mJkp2KJPciZDBHB+VTNbansnr4Jprmz/QrFEy+J0860C9RzGkGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718735168; c=relaxed/simple;
	bh=eIhKmpC3djJFZ9shjBBZf16rVsZJLfZRd1LV9/wQDMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnalVy1l+BCv/mkh/+Co6TsrZZKwW7vdGdFJiVcVvzDaf9baSXtyMM/6LaXpfgym8L+NeuKwsJ5tlYVsQIm0HoqhuuBiGpO7UkS5AaOkmUyoABH21H15Uz/dk9rgOslKjcMtagE3rMbPMQ8DgiCRHyA7V8vkAjSFrjSP4FpdisU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716D2C3277B;
	Tue, 18 Jun 2024 18:26:04 +0000 (UTC)
Date: Tue, 18 Jun 2024 19:26:02 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH RFC v2 1/5] dma-mapping: replace zone_dma_bits by
 zone_dma_limit
Message-ID: <ZnHROk1Xs7KcR4I0@arm.com>
References: <cover.1712642324.git.baruch@tkos.co.il>
 <fda45c91f69e65ec14b9aaec9aa053e6982e5b87.1712642324.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fda45c91f69e65ec14b9aaec9aa053e6982e5b87.1712642324.git.baruch@tkos.co.il>

(finally getting around to looking at this series, sorry for the delay)

On Tue, Apr 09, 2024 at 09:17:54AM +0300, Baruch Siach wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> Hardware DMA limit might not be power of 2. When RAM range starts above
> 0, say 4GB, DMA limit of 30 bits should end at 5GB. A single high bit
> can not encode this limit.
> 
> Use direct phys_addr_t limit address for DMA zone limit.
> 
> Following commits will add explicit base address to DMA zone.
> 
> ---
> Catalin,
> 
> This is taken almost verbatim from your email:
> 
>   https://lore.kernel.org/all/ZZ2HnHJV3gdzu1Aj@arm.com/
> 
> Would you provide your sign-off?

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks for writing a commit log. However, I think more work is needed.
See below.

> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 03efd86dce0a..00508c69ca9e 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -113,36 +113,24 @@ static void __init arch_reserve_crashkernel(void)
>  				    low_size, high);
>  }
>  
> -/*
> - * Return the maximum physical address for a zone accessible by the given bits
> - * limit. If DRAM starts above 32-bit, expand the zone to the maximum
> - * available memory, otherwise cap it at 32-bit.
> - */
> -static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
> +static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
>  {
> -	phys_addr_t zone_mask = DMA_BIT_MASK(zone_bits);
> -	phys_addr_t phys_start = memblock_start_of_DRAM();
> -
> -	if (phys_start > U32_MAX)
> -		zone_mask = PHYS_ADDR_MAX;
> -	else if (phys_start > zone_mask)
> -		zone_mask = U32_MAX;
> -
> -	return min(zone_mask, memblock_end_of_DRAM() - 1) + 1;
> +	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
>  }
>  
>  static void __init zone_sizes_init(void)
>  {
>  	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
> -	unsigned int __maybe_unused acpi_zone_dma_bits;
> -	unsigned int __maybe_unused dt_zone_dma_bits;
> -	phys_addr_t __maybe_unused dma32_phys_limit = max_zone_phys(32);
> +	phys_addr_t __maybe_unused acpi_zone_dma_limit;
> +	phys_addr_t __maybe_unused dt_zone_dma_limit;
> +	phys_addr_t __maybe_unused dma32_phys_limit =
> +		max_zone_phys(DMA_BIT_MASK(32));
>  
>  #ifdef CONFIG_ZONE_DMA
> -	acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
> -	dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL));
> -	zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
> -	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
> +	acpi_zone_dma_limit = acpi_iort_dma_get_max_cpu_address();
> +	dt_zone_dma_limit = of_dma_get_max_cpu_address(NULL);
> +	zone_dma_limit = min(dt_zone_dma_limit, acpi_zone_dma_limit);
> +	arm64_dma_phys_limit = max_zone_phys(zone_dma_limit);
>  	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
>  #endif
>  #ifdef CONFIG_ZONE_DMA32

I think this goes wrong if zone_dma_limit ends up above 32-bit (e.g. no
restrictive dma-ranges properties) but the start of RAM is below 4G.
We'd simply reduce ZONE_DMA32 to zero and ZONE_DMA potentially covering
the whole RAM. Prior to this change, we capped zone_dma_bits to 32 via
min3(). I think we should maintain this cap if memblock_start_of_DRAM()
is below 4G.

We could fix this up in max_zone_phys() above:

	if (memblock_start_of_DRAM() < U32_MAX)
		zone_limit = min(U32_MAX, zone_limit);

	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;

> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4d543b1e9d57..3b2ebcd4f576 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -20,7 +20,7 @@
>   * it for entirely different regions. In that case the arch code needs to
>   * override the variable below for dma-direct to work properly.
>   */
> -unsigned int zone_dma_bits __ro_after_init = 24;
> +phys_addr_t zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
>  
>  static inline dma_addr_t phys_to_dma_direct(struct device *dev,
>  		phys_addr_t phys)
> @@ -59,7 +59,7 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
>  	 * zones.
>  	 */
>  	*phys_limit = dma_to_phys(dev, dma_limit);
> -	if (*phys_limit <= DMA_BIT_MASK(zone_dma_bits))
> +	if (*phys_limit <= zone_dma_limit)
>  		return GFP_DMA;
>  	if (*phys_limit <= DMA_BIT_MASK(32))
>  		return GFP_DMA32;

It's worth noting that if ZONE_DMA ends up entirely above 32-bit, there
won't be any ZONE_DMA32. Thinking about it, this could be a potential
problem. For example, if a device has a 32-bit DMA mask and an offset
that lifts this into the 32-36G range, the above may fail to set
GFP_DMA32.

Actually, I think these checks can go wrong even with the current
implementation, assuming RAM below 4G and no DMA offsets. For example,
we have two devices, one with a coherent mask of 30 bits, the other 31
bits. zone_dma_bits would be set to the smaller of the two, so 30 bit
(as per of_dma_get_max_cpu_address()). For the second device, phys_limit
would be ((1 << 31) - 1) but that's higher than DMA_BIT_MASK(30) so we
fail to set GFP_DMA. We do set GFP_DMA32 because of the second test but
that's not sufficient since that's 32-bit rather than 31-bit as the
device needs. Similarly if we have some weird device with a 33-bit DMA
coherent mask but the RAM is addressed by more bits. We'd fail to set
GFP_DMA32.

Ignoring this patch, I think the checks above in mainline should be
something like:

	if (*phys_limit < DMA_BIT_MASK(32))
		return GFP_DMA;
	if (*phys_limit < memblock_end_of_DRAM())
		return GFP_DMA32;

IOW, zone_dma_bits is pretty useless for this check IMHO. It gives us
the minimum hence not sufficient to test for devices that fall between
ZONE_DMA and ZONE_DMA32 coherent masks.

With your series, the above test wouldn't work since we don't have a
zone_dma32_limit and zone_dma_limit is above DMA_BIT_MASK(32). We might
need to introduce zone_dma32_limit and maybe drop zone_dma_limit
altogether.

-- 
Catalin

