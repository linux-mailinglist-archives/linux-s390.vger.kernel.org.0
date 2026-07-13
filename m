Return-Path: <linux-s390+bounces-22188-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ajRINYE+VWrJlwAAu9opvQ
	(envelope-from <linux-s390+bounces-22188-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 21:37:37 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C9074EBFC
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 21:37:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=bCH7thWk;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22188-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-22188-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A811300C7E3
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 19:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ED2357CE9;
	Mon, 13 Jul 2026 19:37:26 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E923F357CF8
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 19:37:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971446; cv=none; b=MxvI35HllJOmcHSV5ekA7W60DWv6+JyJUmTy4jmYowz6bXSEA56G728PzSVqaOT56P5ccIZ/V+3p3ZneTQeVqaL+EkQ5F2nyWS+c2Mc/ozhknVFh4C9zKrI+DliibEV+98gIoMAF7tjkQ0/JKqfriQ6zE8dB3ghknvJBClIUufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971446; c=relaxed/simple;
	bh=Xsfi+SO6SJr84aSbkQrUqh5LTCvlYWMyrm0+dQckaBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHfH1F53ztGHofrN3Yj/A1cWY46dntH+hm9P8y8nNa7KcQASKNRO93aagFj4AqQ4hd2eEU5XTLheRyYmJm35MZN4yS9xxTWu4j2lgNopINaIWQpwkuosqc0sSgbDDtGBDGPHAsUk0ua9bi52yxUWymDr+cT07YC2wuYnAJpb71E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bCH7thWk; arc=none smtp.client-ip=209.85.222.176
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e85499ffbso20849785a.0
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971444; x=1784576244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=seRQ4x7WCVBDlRNvM1ESoBfWnXSVwL4ZPJ5Cc52Vq54=;
        b=bCH7thWkHUmHqjRoXeaBgsb3lecl0+IbVkKRPH4GzvVS4UZWsD+3865TdbqG8jpLSP
         SsjWB0DamBr1/ayp5/ZSi7hpGwSkHr35Xxk5Bn9hEraHpLp5mkDXoziSKuanF46obtot
         +6Qm8zvlRIGqaYAmemVVD0BPyR9dH7o9xnRrz8AFyl23uq6meFQ6kbW7nRgdUWJGuLLL
         J7qbilrsVdDj9QfFMcAQBUDhzU8VN1Yk24MGvwXFMWIZwlL4EFi0TUGoKf9o8eRbRIqV
         XF9Fxexa0xMZ6AsBI7tO525l7G3+5BPfasS86Q03YBqjqpUY/twzQg4xpUuXe2wIQPGX
         fsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971444; x=1784576244;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=seRQ4x7WCVBDlRNvM1ESoBfWnXSVwL4ZPJ5Cc52Vq54=;
        b=CB9qJj3lAu5ATVDOMGuuu2uTvSTDuaalYen3eC+TnXNa2PiIyZ74lRiIjrdYeN54pa
         di1V8RTRsJ8y4PYRhrk9vpk7cYw9fdAAoDJByAoD7qAPszL2WenKQo5QGOqPIjUVkvW8
         M8feKl1qinUOtFOx66YOJMFTj23lLu1cIzNMgG0lrP8LeO9Dg5aRH7ePSz1qzgRK/06l
         jcmYVIDmTnc6kn2FXDhsoaXjjbIuu/TO5BMRS/sTN5vt+I1i6rRfeCfunvZZeAECOdzy
         kTJCCZK3dGtEEqQ5L5Xd8SI9P/hclyvFvW0D41H1PnteM8oAJo/vgOJ0PC9iKFuCIRTG
         dtEg==
X-Forwarded-Encrypted: i=1; AHgh+Rpbjc1QTJcIKh0CZKr1wbwJFxAQTax5bbpHVqL4d5Xedyon1qCYi9qVLmky5qitAUp0ZWrE8IOmJBoS@vger.kernel.org
X-Gm-Message-State: AOJu0YzyMrbTY8BnR8E5KixgGsV0Kho2gmybq+VOe/9zsBmP/KtsdFIj
	qW4RNC/6qZJZB99VhfNsfogNTOIYKRffy5aOydZdPok0fADMBy49fcdaIeNZixYy/Vo=
X-Gm-Gg: AfdE7cl9TTMOct7ZoHhKJ7/1k6437RZ3J53Se++YUhQbg/0qDXQXsdsV+24kEX/Elk9
	uMWroaND8poNgl+6yxZ9/4+iqgjNZuxYydypc9hn6MNEz3gZ+OGwmdAnhExs4Z+KuIM8OZOLSsS
	2lkPFOnZLoXJYs7qn9aHxyYYxzPO/apV7JiIcspz7lvMY7GuDflFhSvlmZoh6fjP6vsV5Qp+W3w
	rSxlUvvqSay8Vl+leSQ1gIUp395+UMwU8OWUYgbXD3iQfGvUm3dpqPjaEvLR2hOrqcxPaFz74th
	QNROI6xHgXJGRj9nmL1oNzS8EWwgD7KreCQvgqLdHqxJ8olGjb/6XVe0Nkt2vW01RFOjKKDRoX1
	Aq0hIGI1uwAVCmELrmAOoj4SkD8TO8iGBiT9e6dU2NnQmhIJKhjERrnIwC465LWLI748cvZs=
X-Received: by 2002:a05:620a:2551:b0:915:5930:94e6 with SMTP id af79cd13be357-92ef2bcc91emr1112783085a.51.1783971443832;
        Mon, 13 Jul 2026 12:37:23 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b86276sm1177578085a.11.2026.07.13.12.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:37:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMSw-0000000E6Rs-2gqS;
	Mon, 13 Jul 2026 16:37:22 -0300
Date: Mon, 13 Jul 2026 16:37:22 -0300
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
Subject: Re: [PATCH v7 17/22] dma-direct: set decrypted flag for remapped DMA
 allocations
Message-ID: <20260713193722.GW3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-18-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-18-aneesh.kumar@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22188-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4C9074EBFC

On Wed, Jul 01, 2026 at 11:19:21AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Devices that are DMA non-coherent and require a remap were skipping
> dma_set_decrypted(), leaving DMA buffers encrypted even when the device
> requires unencrypted access. Move the call after the if (remap) branch
> so that both the direct and remapped allocation paths correctly mark the
> allocation as decrypted (or fail cleanly) before use.
> 
> Fix dma_direct_alloc() and dma_direct_free() to apply set_memory_*() to the
> linear-map alias of the backing pages instead of the remapped CPU address.
> Also disallow highmem pages for __DMA_ATTR_ALLOC_CC_SHARED, because highmem
> buffers do not provide a usable linear-map address.
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c | 56 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 44 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

