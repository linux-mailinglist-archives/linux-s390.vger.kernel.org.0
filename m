Return-Path: <linux-s390+bounces-20673-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jff2GbcXKGpT9wIAu9opvQ
	(envelope-from <linux-s390+bounces-20673-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 15:40:07 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 626AE660A9D
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 15:40:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=JqwJYwP5;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20673-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-20673-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B838309DD3B
	for <lists+linux-s390@lfdr.de>; Tue,  9 Jun 2026 13:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ECA2E737E;
	Tue,  9 Jun 2026 13:26:49 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734A92C158A
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 13:26:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011608; cv=none; b=OlQmD+RTHcwmlXo0/Djc1dVd2rJPVmB9yU+oE64fUQzd5m+rxGXAy7QkkeEoa3RRF7cpi4NpUA6U0fnSqGwVrjf5zMyU50Di6skcUYPeWdungY1n9kFZvEL3KUJDsJabRMac8FQLgISDV+Hw01mGw6nZZrj9fBspvDwn4TGJ9nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011608; c=relaxed/simple;
	bh=twwp9hFllxfAH5zTiaxs+mflqhqxD3N7oFJ/LghNab4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ol4RMTz5LXtt7A479T0xLHEdqrM75Z2pf4T0NEL4UIM3Z/ryuN02zVuWb1RXrmQ3fZApFm6wlgdfcK6PTaHrvS8T19mwpx339basbo95xHTdzRkMQpmxv/UifojiIEtSELZyG3AinF6PFZdci+sreVEzdu88hRvF2LXDYtJG6IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JqwJYwP5; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b8adf813so6028615e9.1
        for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 06:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781011606; x=1781616406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Mb3ECCQF4KDrnD1oEZunr+tebvyQKuHVVgCgeE/hK8=;
        b=JqwJYwP5rsw5mLds8y/xfXTBC4ZsdPTXG57lP+trT+Nq8qLLXF1IeBaqqTGs5JnIAv
         1nfzR2K5zqGxc01dJfyEw20tAeoxz9tZWTjLhRldM1l/6e0G9vFl7C7ezD+/Zc0Cb/TD
         yyrxJjD0U7S6HoTgohT0l0r0QApXMa8obNj9sNrzZ/8kWqKMBu3O4wMj1jrW9wIX2s4V
         BzLHkTWhE1u9E3wRwD31JWFmqS8DJ4X+ofKSkS2DLhGfFcPZf1uDJBVKEEVHoQCydYvE
         cxLHIsbQUmFKfwB9qmVifKiuONS4QzSUyCjNEPpA4n26S9mq6j2+8FDJSefwH2OR+dFc
         TL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011606; x=1781616406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Mb3ECCQF4KDrnD1oEZunr+tebvyQKuHVVgCgeE/hK8=;
        b=LhGaadPrwOLYgt2udrg7EaR656Dkgt92lhUPTgCHiuyMa8kLdX+eHtizCy6NtRO4mj
         rPvyMvLBntBJPVJBhTXyJNLE3ud3CK9nm1yKFmOqwvTcrBy2AOFPL9QcWzt91sv18/Re
         38TiZ5M2JyJTkeraMJrlm1HTXnoroRZTeo44hrt98U2g6C4V7MAFrbPT7gT/Gt5PzNo1
         g31YubCn3KV8AL7Aks33XZb3L7tkpSnWrroJeGZ6n+BKlerBx+jloGYeO9skjPg25gUR
         rGmVA8O4vXyw6zvjM3W152lLaOOqSaL8/Xs5vnqpuhfQ/N6u/7LxyCVLTwu4fhK0AeFn
         0VhQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cs/uDjxNh9NEhHiMn/JX4bX+jud2ZmjfUmB3f9E5HjJXVzDiR1lI5/kl7IOBV/jAyLBu8NB+UyZMv@vger.kernel.org
X-Gm-Message-State: AOJu0YyHXMM/dlr444w3w+A2hNz08MQBw5nHa4PjDRKNYyMqgtx7ULsW
	de4cC2d3hCPbQpYyOwqSR3CAZHUtZdog7lcsMLpPAHr62HH1oWkrHPOT6gBcVsorvak=
X-Gm-Gg: Acq92OFwUFDfUTLeXGjzYJBZs//ZL/tPxr4pVpY94oKpnNEATtB5AWWs0crGmycIh7Y
	sfd+Wd9/DmMjpTk/lD2T3X8XviDerfgmgx9YdkE+BRYa+KgvYD89wNtB1TyfrpyD7ZkBknoqcFw
	nMQltiKEyotoCZYpH3NZu59Ru4amYiQsCBMx2as4VakoKhaAFACg62r7pFEVgDIWrNOa1nEWvoc
	8zf/bF0cUuI4s8384851HJ5tmXMxh3xiY3xAsQ8BDnPsbB2CWXR5aBNmQVpljHgvGIoS99iJlgT
	GTYFMsVA40BeRHVlNnNmOeWEikskEpMKXpwu27s20jwBv0BZx3bvzW2hw6VThq0sqg2Ibreg/RJ
	7//HlTUKv6yM+lDO+xOSQJnA39UOigKa9zLQhmVt/ghRZwsVvAV5WZlqQywY6+2HxaB+eUSTieJ
	04yAT1uNQF7lV3p/NbmPbYeA4=
X-Received: by 2002:a05:600c:8705:b0:490:3fdd:d344 with SMTP id 5b1f17b1804b1-490c25897eamr150306735e9.1.1781011605912;
        Tue, 09 Jun 2026 06:26:45 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm469464095e9.5.2026.06.09.06.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:26:45 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:13:54 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Will
 Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
 <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Alexey
 Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
 Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, x86@kernel.org, Michael Kelley
 <mhklinux@outlook.com>
Subject: Re: [PATCH v6 15/20] iommu/dma: Check atomic pool allocation result
 directly
Message-ID: <20260609151354.534bb18d@mordecai>
In-Reply-To: <20260604083959.1265923-16-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-16-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20673-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:aneesh.kumar@kernel.org,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:jgg@ziepe.ca,m:smostafa@google.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ptesarik@suse.com,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,lists.infradead.org,vger.kernel.org,arm.com,samsung.com,kernel.org,resnulli.us,ziepe.ca,google.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,outlook.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ptesarik@suse.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mordecai:mid,outlook.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 626AE660A9D

On Thu,  4 Jun 2026 14:09:54 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> The non-blocking, non-coherent allocation path uses dma_alloc_from_pool(),
> which returns the allocated page and fills cpu_addr only on success.
> 
> Do not rely on cpu_addr to detect allocation failure in this path. Check
> the returned page directly before using it for the IOMMU mapping.
> 
> Fixes: 9420139f516d ("dma-pool: fix coherent pool allocations for IOMMU mappings")
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
>  drivers/iommu/dma-iommu.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 725c7adb0a8d..52c599f4472c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1671,13 +1671,16 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>  	}
>  
>  	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> -	    !gfpflags_allow_blocking(gfp) && !coherent)
> +	    !gfpflags_allow_blocking(gfp) && !coherent) {
>  		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
>  					   gfp, attrs, NULL);
> -	else
> +		if (!page)
> +			return NULL;
> +	} else {
>  		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
> -	if (!cpu_addr)
> -		return NULL;
> +		if (!cpu_addr)
> +			return NULL;
> +	}
>  
>  	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
>  			dev->coherent_dma_mask);


