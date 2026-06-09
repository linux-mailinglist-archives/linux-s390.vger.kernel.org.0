Return-Path: <linux-s390+bounces-20687-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id afIZCUQiKGor+gIAu9opvQ
	(envelope-from <linux-s390+bounces-20687-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 16:25:08 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87585660FC8
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 16:25:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=aaM+VksD;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20687-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20687-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A70AA310E542
	for <lists+linux-s390@lfdr.de>; Tue,  9 Jun 2026 14:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C90D33F5B1;
	Tue,  9 Jun 2026 14:15:54 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465B33F599
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 14:15:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014554; cv=none; b=fPrEVLb292vNK+0qp+CtmTB7nxk5HXJUwLTe5Ge9AGgeZn+DEwMMIqv4hTJZ5AfyxNiYiqzwE+blkWiuXkCLq5vMTnhsBA7RaUpSCJIdeRgNjGbfRyLqRrRnFFPWm1CGtIjQPmJIf9+bPPIB42mus8PqbG76+6H9895hgd21Q9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014554; c=relaxed/simple;
	bh=MmkUJTtuyXY3s/7sXM+BP/PzWFzsXVq+eKe6PElRRWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uglIWKDbIT7mEAy5LGe63Kiej0SlRR4tDAyckMQNfGsSomDSwXJb4Bss5ObOY6HKCzBY7qc5q2LnYq0NudMUdtzr2YgSwPgHkW7bpgS8hI5wP9VKXD56Rm2l77rHRca0f0bHzPm9yi5PQzW2PlP1LBzxE3WJtxMOsOz1PkKR1uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aaM+VksD; arc=none smtp.client-ip=209.85.219.53
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ce9df31130so87736086d6.1
        for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 07:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781014552; x=1781619352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/t/KVtkqwokTt2oNchcdf4xUUArUEApR4RsM4t4GGaI=;
        b=aaM+VksD81FwB9qeScW7Sviahb1dkjb/ysJ4WiEyEGLyTs0Z6cGucYu+dxVqbdpXRi
         f8gbU9i+o6e3FfWrmod8ExT89VcRLxM2HRnfSfDDzhaduA3uN4cR4Vd0tWpLyYtguRHR
         boHXaNm4jeKhWgSqym8XL+I7kQxM37q/Hctx7UNd9wCj0vbFATeAYasZ+qkq4WEdzXHH
         5xdTUaUOLnZKWZG0z4Tu/QKNDdjdQT+oR74Il5Vmx3mmgs58Be40v5pIqu6YzMnzzInY
         hjSMgGOfFHBJocJUiljwGsMNozPcr0jeQdE6Q2PLAcQtj/hi+jwCnC0dTaLYm+rkFccJ
         VYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781014552; x=1781619352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/t/KVtkqwokTt2oNchcdf4xUUArUEApR4RsM4t4GGaI=;
        b=D/Kh4cMBSs6HkxHq93Fsmn2Wh/m1NNXltySWo8NBI90c2Bwkz05wG+7XUPp5+2EVvM
         wdvlmaR5Cv49KnarK+88JDk/9les0Rs3igCDDpAQJPKzU7ArxXRTG2g09ylGVQfOyipW
         GywKH4h+Oilm9BgfR9C1gv1Bq7YHVuLIOVHA2VAVMo89oyct15fN3wQcccL8d3kri295
         XKyhED+PQZ67+NIon04EU9qeN26rt5nM/gjn1C5+QWFi+tYcp+GNeEXh/vfHAIWM7yDn
         O9vdVdPTUX1N0k/Ep3ST+rkCCfu+6spiNxllpTPmJsTbdSDMkcY4wDYsFIRumrrf/DiD
         iM6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9waFie/g7U3JThVklkrBWVWDIaGRvsY9lSDydBKHYfmOYwV7CDzXlgk34KFy7KLZJ4CsaaWVYjRByk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7fhNNhzCOkrudzBVZ9geDOOo8KLb8uLuzIcBvwyt7yJA8mgyD
	9PNRGT9V/xQIEv5Gd+Dp6smfBGqtc3qFJAFhinsHV4WX4MXUhBsJAtg9dfWm5xCy1rU=
X-Gm-Gg: Acq92OGl4AZr0iS7PPZ9uWk8vdHUxa8LLyEDaBqYK/9lAaJ8kXY4YZR4rr2i5Gdxn9o
	JMhy3qsiOtNl7OdiL2wrDJwwIUsqBJPHfneGEsJTVddopIggEhqyDf3KucJjqQkAM7hK4XJ1GRZ
	WlVRYLioyoJP+V2qV5DIYNZlhimP5LWuOyyQ9flPWJeptTPKX+7GsUIyhFHOcJSERBFnG0r19ut
	iaoIKs8gZIfKXHdJXL9Fw0K1u3jKi6PnrCNMSzrK+BJr2oUxib2AQDY+ybATy2UAOaQIr6R6NEt
	xv4lxMeCEkhvjSuDSBcswDf2eNczBq7WXqsZ6agGly7zk2kVY9lwFSY2wahrivkzFCAW+UipUYU
	1M1MUWyNEzQ/ydnRTpNGSIC7z5ygVWJLnOisVTYLajSifHr1bQ+1buYegUY98n0WBZuKuHy9POj
	68TSr6jdAbgDyBSDjid5BR7yUWvMMLtgbRBmZcXt7q987FxpgQC7QKCbtJm/ASLSYsrN2FWiZod
	CkjMe8Ys5jOwjNQ
X-Received: by 2002:a05:6214:626:b0:8ce:ba04:7bc2 with SMTP id 6a1803df08f44-8cee626f0eamr293032506d6.38.1781014535341;
        Tue, 09 Jun 2026 07:15:35 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd077be8sm204702746d6.40.2026.06.09.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:15:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWxEs-000000021xL-0mOX;
	Tue, 09 Jun 2026 11:15:34 -0300
Date: Tue, 9 Jun 2026 11:15:34 -0300
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
	stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 14/20] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
Message-ID: <20260609141534.GJ2764304@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-15-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604083959.1265923-15-aneesh.kumar@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20687-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:aneesh.kumar@kernel.org,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:smostafa@google.com,m:ptesarik@suse.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,m:stable@vger.kernel.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[lists.linux.dev,lists.infradead.org,vger.kernel.org,arm.com,samsung.com,kernel.org,resnulli.us,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87585660FC8

On Thu, Jun 04, 2026 at 02:09:53PM +0530, Aneesh Kumar K.V (Arm) wrote:
> @@ -270,9 +270,12 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	 * the atomic pools instead if we aren't allowed block.
>  	 */
>  	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
> -	    dma_direct_use_pool(dev, gfp))
> -		return dma_direct_alloc_from_pool(dev, size, dma_handle,
> -						  gfp, attrs);
> +	    dma_direct_use_pool(dev, gfp)) {
> +		page = dma_direct_alloc_from_pool(dev, size,
> +					dma_handle, &cpu_addr,
> +					gfp, attrs);
> +		return page ? cpu_addr : NULL;
> +	}

You should probably put this at the start of the series so it can be
backported

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

To Petr's question I think this just shows nobody is really stressing
the PCI dma paths on CC VMs today.

	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);

For instance the places even calling dma_alloc_pages() don't look like
things people would use in a CC VM.

Jason

