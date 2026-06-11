Return-Path: <linux-s390+bounces-20773-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NFRSI6+cKmpstgMAu9opvQ
	(envelope-from <linux-s390+bounces-20773-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 11 Jun 2026 13:31:59 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D84D96715A1
	for <lists+linux-s390@lfdr.de>; Thu, 11 Jun 2026 13:31:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=XGJBL5os;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20773-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-20773-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 631C2307D3D2
	for <lists+linux-s390@lfdr.de>; Thu, 11 Jun 2026 11:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F89A3E6DD8;
	Thu, 11 Jun 2026 11:30:48 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659B33E8338
	for <linux-s390@vger.kernel.org>; Thu, 11 Jun 2026 11:30:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177448; cv=none; b=UzyCSyKGilb2OiEvkZ16Sw7BLRDq47CjMxiHoywBG3yNKrQpoql4rcZ5aiR261LOC9hXSMAWaZLiPKI3WzCGAMgsFnJaT6Q1jDU5c0baVzAaE4i/Q7FQau338W4nOLZE0WAzZ8f7p30RLT82EsPJNRQ36NbxASfQ9dmULgJjfS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177448; c=relaxed/simple;
	bh=haH/H6OcYua3Z5rTl0sktjLmKVSLqKAqacU21OYuo/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvYN/uswfFQdBG+u7Kt9qrfhWPbT73angRNNJhZalg5CdJMWO/JAaA30qTqjbeRkuMK/a/EbfTnKN8hw8zWSKfv+Jo3OeEIaZafW3EsqY0y0MX7RXbwOGD4c4cgUkFKYV4kkIlzYEu21RD72G1uAJ6h50ZyxXTDhg/CeQIKQAGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XGJBL5os; arc=none smtp.client-ip=209.85.160.182
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5177b9a02bdso108925171cf.1
        for <linux-s390@vger.kernel.org>; Thu, 11 Jun 2026 04:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781177445; x=1781782245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=haH/H6OcYua3Z5rTl0sktjLmKVSLqKAqacU21OYuo/8=;
        b=XGJBL5os4DVaFiv5GV9/V+Nwn4AKPOoWgMshjsoi+NGc7cMK/XQVGbgXSTf25QFDbI
         qvarjcNpPZK+kxSgp7f03EM6mDGDGyoe/MpgvPrna3Y9PfSKPEOOtXb9ultWWqce95uX
         0RYZ3zaWBf4eOGsmHvnUhPPilQaNdNSZ/xm22crBgupbgw+xh3VOLDcd1caDssogAwKv
         Ef3ppoKRFs/yO4CRP5wFJ6z2eipTnGTNlGq1vIZIE+EbAK9Cmvwh/rVwt1VzHVT+r2Jp
         1az+m5WOE4NCUXdQ2Fvcr30Kqp9Dscn636V6YHa2gZEM1PzK6f5l2ZA0Ac5Xi7if/PkL
         vyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781177445; x=1781782245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haH/H6OcYua3Z5rTl0sktjLmKVSLqKAqacU21OYuo/8=;
        b=KZslu3lvU4x1J1i7+JvpnCOFPPtsJWZuvprK260GimthRzYB5hhWOH9U7g/egTKfkI
         m0+cfntelO+oqpKVvVpwLeJhEYC1JdSRxXaYN7jOmkME+qBBOC2zZQOv8KVpQ6HQo9Gb
         wGjv+38pfN6FiMCYH1vqcLx2IABz+RbZ0SgDkbWH78pIZauFRQCg5mwv2X3KD07ShdKH
         rn5bk/xLElbDzIokWH9A/Z62KaV2onXAvIX0UMTC2HFAzH8KZgx/CXSV6Cp6YsDoF1YZ
         rEfYLKFxUKJL7pF8S1EJpI6mv3JP7rMyEMhilugZB4Bc4gwxweKl4KRqFHlAjSF4Ouxk
         FqzQ==
X-Forwarded-Encrypted: i=1; AFNElJ9oq9Y3+U3LKGXq28ggzXikyu9He/Z3ig2XEP5dYWLWZsWfO4dXXFGhj2M7YmvkRxl8px5KQi5xFwit@vger.kernel.org
X-Gm-Message-State: AOJu0YwzW9gCONViJbTF2Wwc/r7iqpPQgQrI93Rqx8ecitdloXjQyLxu
	IcoMophsVG1V/nhM8Ng3pd3EqdVBjy4Y9u5OnjaYhAOd+LYwLea8k4L+G36o7PFoAQ8=
X-Gm-Gg: Acq92OHCgn4ALZMbXcyFE+UzXZCtH7ksPOXTIi+KdhWxS9UWj9OkCjLzSDABqX4hP27
	z3kbM9l7eJ6OLb8+gZRf9on6LRXJX3Luiw7RqP8AY8khq6x6+eFbby5PlQ7EvXnzQUvD0I50bJj
	UD7zJhcFTcqJpoCQXw/LMMEGCBQEVu7HBlPdY/jMY1zHcq8XiNAoYbSR8bDC/Z4mcXpqv8UxGd5
	03md0QAEWxkzmtsQaB+E39GHtnFEXK9HqX90IR/LcRrkXbJU3SjS4A/xhhXARSXy3EQfauLrez0
	uZJlEul22jiaNglP5qSPg+QtDcrP5cTza0d0wCYo0xnQhFvJze5sYuoukEEJj/qlf/EMKLueI5U
	MKPgc75KaGBzTApOejOduQTsijeLwBHhhLQDkGX4FCSUb9ajccHPbgGaHnfXMKWR7e27tV7NdiO
	I3C6ohGUkI+B1GKmrDtzBhUGK/3RQ5WwzaghQtnuM+mwDtUsRIi6xQp4aik0OQ/biPc7IylZGx4
	MsNRrV9VB/RTjQJ
X-Received: by 2002:a05:622a:354:b0:517:875a:d619 with SMTP id d75a77b69052e-517ede4125cmr35159281cf.6.1781177440327;
        Thu, 11 Jun 2026 04:30:40 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517ef61dfeasm14521801cf.24.2026.06.11.04.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 04:30:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXdcM-00000005deq-1WZO;
	Thu, 11 Jun 2026 08:30:38 -0300
Date: Thu, 11 Jun 2026 08:30:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
Message-ID: <20260611113038.GA1066031@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-5-aneesh.kumar@kernel.org>
 <20260609143242.GK2764304@ziepe.ca>
 <yq5afr2uzum9.fsf@kernel.org>
 <20260610164153.GQ2764304@ziepe.ca>
 <yq5acxxxn0gp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5acxxxn0gp.fsf@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,lists.infradead.org,vger.kernel.org,arm.com,samsung.com,kernel.org,resnulli.us,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,nvidia.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-20773-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:aneesh.kumar@kernel.org,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:smostafa@google.com,m:ptesarik@suse.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,m:jiri@nvidia.com,m:mhklinux@outlook.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: D84D96715A1

On Thu, Jun 11, 2026 at 10:21:50AM +0530, Aneesh Kumar K.V wrote:

> If we are adding DMA_ATTR_ALLOC_SHARED, should we also allow
> dma_alloc_attrs() to take that attribute value?

I don't think we should..

It is hard to see any reason to allocate shared memory through the DMA
API. The way the DMA API works only the device that it is allocated
for can access that memory, so it is effectively private to the
device. Thus what purpose is shared device private memory?

> +DMA_ATTR_CC_SHARED
> +------------------
> +
> +This attribute indicates that a DMA mapping is shared, or decrypted, for
> +confidential computing guests. For normal system memory, the caller must
> +already have marked the memory decrypted with set_memory_decrypted(). CPU
> +PTEs for the mapping must use pgprot_decrypted(), and the same shared
> +semantic may be passed to a vIOMMU when it sets up the IOPTE.
> +
> +This attribute describes an existing mapping. It does not allocate shared
> +backing pages and must not be passed to dma_alloc_attrs(). For MMIO, use
> +this together with DMA_ATTR_MMIO to indicate shared MMIO. Unless
> +DMA_ATTR_MMIO is provided, the mapping requires a struct page.

Yes, though we need to fix a few ATTR_MMIO users to make this
statement true

> +DMA_ATTR_ALLOC_CC_SHARED
> +------------------------
> +
> +This attribute indicates that a dma_alloc_attrs() allocation must use
> +shared, or decrypted, backing pages for confidential computing guests.
> +Allocation paths use this request when they select shared DMA pools,
> +decrypt newly allocated pages or restore encryption on free.
> +
> +DMA_ATTR_ALLOC_CC_SHARED differs from DMA_ATTR_CC_SHARED in that it
> +requests shared backing memory from the allocation path. DMA_ATTR_CC_SHARED
> +describes an already-shared mapping and requires the caller to have
> +prepared normal system memory before mapping it. Callers that need shared
> +memory from dma_alloc_attrs() should request DMA_ATTR_ALLOC_CC_SHARED
> +instead of DMA_ATTR_CC_SHARED.

The semantic is right, but I would make it a private attribute since
no driver should use it.

Jason

