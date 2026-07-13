Return-Path: <linux-s390+bounces-22187-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KWUAF1o9VWqElwAAu9opvQ
	(envelope-from <linux-s390+bounces-22187-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 21:32:42 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B9274EB8B
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 21:32:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=inMOxye9;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22187-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22187-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3747307FC08
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 19:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4597135675B;
	Mon, 13 Jul 2026 19:32:38 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BF2308F0A
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 19:32:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971158; cv=none; b=FByxbpk1JY35PZBhsLEx9kgiOaLYKiQX2bT3vr/EaAlz2VFWD5yvY9AV0h4xDL1fWlSFiwyyQRHY52sRBa4H5I7ArNhzUl66PDMVIl42RMUepe2tt9lxqzkLX4ggtzIp48hZs8LLmu+BGivh0TCuQcFtrKK2Exm72OxCi77pMOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971158; c=relaxed/simple;
	bh=dY77Qv0+81lzwLVi7S75dyv+70oXXvgqRD8f0qnW9jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+jok26kOFJyuQ1x402Nj6XZbZ0yaAuX5uxnmixZd0lb/iefX9kfDKf7mnd5E835fua6G8oK4S2KBcoGTFmzNN4pRG+HJxfKO01JUDrvm9+WPMWOw4v4ckELRzOYBFNJmUXi8o1tv87f1rtxtbVgFGir0KUjNiuY0j4txrgVIiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=inMOxye9; arc=none smtp.client-ip=209.85.160.175
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51a868b6962so33558121cf.2
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971155; x=1784575955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hGsZNW66zFo4mTPQ6ULtWG3KXt/fdlFbCgUmJIue0mw=;
        b=inMOxye9VtNDwffxWsKVp4mhSB13/q2dGQtDHN0OO3t7T9o86yNp+XAS28wm2nHWMr
         u+cgwVdVR9XpgiXRbB40jlB+pRIKzrXFpVliDM1r8TVg8r6qvkZMr/2V1rxVQkux91Ln
         kjyylpJe1sOtKC2PglhEFJvachqt9PuHn7wHkZGshuKZrvaq2x5cWZHk/aInNzRMc+ol
         Xxk/U+0Ta4OU/1QFYJf/k5svCBT/w9tPZ97ngPhYxru2j/EQn/+MEIfkrpeySimj++cy
         ZVesCYW3fTDTjuS3ZBy/KoO+CfVN6cQECq0eA4qsjmshk2nwuwcp1c3Wg7I+btS4DZgn
         5Y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971155; x=1784575955;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hGsZNW66zFo4mTPQ6ULtWG3KXt/fdlFbCgUmJIue0mw=;
        b=SpPND2g6Rs5CG+D5eCOmxUHftYMKc/6ektOGf82SB+CQLR9/7Y3m6+i9Ui1TDXdmmG
         JJVn/kQWWAnjclRz25JoeiPaNhMcwJAuKr7kd0It9EDahKIb4XvcmymCOAZ9kqTK82Qz
         haexGLPbfPYVm6fxcKpXoSOMR5wRT6cajtQSN9eHDileV0grDQAnYxvxJj+Zkd5P81ZG
         btVdy56CmblhrbeImUyfKm/yZy4Q3Xk1aBxnCBHY/yWro0OOTls6Vg3zeLoixN+//SI9
         I4qo5Lgly2trboDoSLnoSG4vup/sRokKdWwLpkPusqj4DyN7hgeOLhRtFyRJ31gTgSHY
         Vibg==
X-Forwarded-Encrypted: i=1; AHgh+Rok5z/YmWeEK1HK1Ue+vDbCdzVY+viHdBcMqQCL2A5g0ObsB6s4ad/rm1JRbOdYsgghFPgDaRA4S8Pr@vger.kernel.org
X-Gm-Message-State: AOJu0YzNx4uG2omsAtChtjrEzWHjqQGx4uQPDcSv0AY4w7t29sYxn8Jl
	qqSOLolKbohzXbb3d7Tv8z+ceS7T2VJzLm1wXLEDoeGQpoiI9xnT6GWa6pBKvzHyJ8JjNVYGr9S
	lJSg+
X-Gm-Gg: AfdE7ckKtGS3hPIBXv6PFeh7m4hWXGw9wLO4x60eM7XcJDLmQWNXlD7U9MdA8ynxHQI
	nExEI+Ym6O/LH0PZ1riHCNZFQqW1snLM+hh4W4MLH9U2ZE5giJFq44jS3+Ddkn1upEa4mJzfH9w
	aChr4ymRlaOrztGJr8sPZWlalSvjBoF6FU7eX/B9xl+h/CH3tKWsmaQGu6eknD/Bydhjbsdz5cr
	qyqkiHXXkjgc3xVdcrCYAUnSxB00eIc2Vt2gzJMCGV0x3bJoG7EvkPRNFL0xfVCYeUiQPjKssW4
	8s2qUc8Gedg11FoLVYx8+BxMXlzossnoAsZ8GRTdTBXCt/B2RKucBvZzsGWpQx13Ct3hLFuEKBK
	maZQfiCUullWqcGejlepLDcqpP8oc4Rvx9LKraC7IfqV6UBKda8SlsetLHbup
X-Received: by 2002:a05:622a:1b22:b0:51c:18e4:38ab with SMTP id d75a77b69052e-51cbf2ee945mr103155851cf.66.1783971155509;
        Mon, 13 Jul 2026 12:32:35 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1ec84sm138505026d6.29.2026.07.13.12.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:32:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMOI-0000000E5wx-1usj;
	Mon, 13 Jul 2026 16:32:34 -0300
Date: Mon, 13 Jul 2026 16:32:34 -0300
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
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <20260713193234.GV3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-17-aneesh.kumar@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,lists.infradead.org,vger.kernel.org,arm.com,samsung.com,kernel.org,resnulli.us,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,nvidia.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-22187-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:aneesh.kumar@kernel.org,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:smostafa@google.com,m:ptesarik@suse.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,m:jiri@nvidia.com,m:mhklinux@outlook.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3B9274EB8B

On Wed, Jul 01, 2026 at 11:19:20AM +0530, Aneesh Kumar K.V (Arm) wrote:
> @@ -88,37 +88,40 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>  {
>  	dma_addr_t dma_addr;
>  
> +	/*
> +	 * For a device requiring unencrypted DMA, MMIO memory is treated
> +	 * as shared by default.
> +	 */
> +	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
> +		attrs |= DMA_ATTR_CC_SHARED;
> +
>  	if (is_swiotlb_force_bounce(dev)) {
> -		if (!(attrs & DMA_ATTR_CC_SHARED)) {
> -			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> -				return DMA_MAPPING_ERROR;
> +		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> +			return DMA_MAPPING_ERROR;
>  
> -			return swiotlb_map(dev, phys, size, dir, attrs);
> -		}
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> -		return DMA_MAPPING_ERROR;
> +		return swiotlb_map(dev, phys, size, dir, attrs);
>  	}
>  
> -	if (attrs & DMA_ATTR_MMIO) {
> -		dma_addr = phys;
> -		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
> -			goto err_overflow;
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> +	if (attrs & DMA_ATTR_CC_SHARED)
>  		dma_addr = phys_to_dma_unencrypted(dev, phys);
> +	else
> +		dma_addr = phys_to_dma_encrypted(dev, phys);

Maybe things should be adjusted so this can be
  phys_to_dma_direct(dev, phys, (attrs & DMA_ATTR_CC_SHARED) 

?

It would also be nice if swiotlb.c could do the same

Stated another way, maybe we should get rid of
phys_to_dma_unencrypted/encrypted() entirely and just have the bool
variation since that seems to be what everyone wants.

Jason

