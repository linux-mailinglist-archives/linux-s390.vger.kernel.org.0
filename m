Return-Path: <linux-s390+bounces-20776-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HrsoCgqhKmrRtwMAu9opvQ
	(envelope-from <linux-s390+bounces-20776-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 11 Jun 2026 13:50:34 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C29C671879
	for <lists+linux-s390@lfdr.de>; Thu, 11 Jun 2026 13:50:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=ePbyMgN4;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20776-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20776-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4B4C308E67D
	for <lists+linux-s390@lfdr.de>; Thu, 11 Jun 2026 11:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2870D3BE14D;
	Thu, 11 Jun 2026 11:50:18 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A983BB67F
	for <linux-s390@vger.kernel.org>; Thu, 11 Jun 2026 11:50:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178618; cv=none; b=Tj6/ch5wC3bS5a31hO3YBm7Oa7avFRnSQSchrtlT6phlZfEy9ZAw8Qfso5jseJYPy+ManacHpFBp3wf3/O5MjolkuAUfyTA0XMkS8uMycnBZwWNs20UINQmTH97Udbg6acWltH2RueJFY0LibXPM+l2HbtXqlmxyN6gr94bygus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178618; c=relaxed/simple;
	bh=UmW9Vbd3ZtejVIzFUGtLzNmEE0KC+mhPuzfVyC+exsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwbJIz3yzh/QYpZRqlnRgso4BPhsPWJVCnZ9ZErGtufEPIrx3crFXSE8Godh0Nq1c3SBHt4KTJDirZT08N0Hx6Na3BfKh5x9E0SUsjG5FsOTS1zC9FidIjEHKZIhv5UwZOiQ0hhuF7443Si3fDBtL+xO4Q4VpSMWpXxakumtdYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ePbyMgN4; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ee224f5fdso837650f8f.0
        for <linux-s390@vger.kernel.org>; Thu, 11 Jun 2026 04:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781178615; x=1781783415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=By5jxDRfMhWNJ3zdMqbqgKEuQjBAiR2dgY0SOpXrO1o=;
        b=ePbyMgN4/p5PmK4IrIrPgzeiRfypzzATrVlfJ+nvzVpSaugbxCQZkx6vHGGa/yZgll
         D/JOvh+ALQCbHa8WN+inI1G8BWJcJTKFHFz9+MxCvGW8DIWsRWUANJVk0erULeetbZFD
         Lfz9hW6TVZT6X80ompDUwrPS4WBO6pdTFrDvjfYBDjVo6sehCDp+Ze63D32pTcRqy/eK
         wMrhxmzz2GHte1+G9srCHpK/60BN039JF1KLjHi2ZBLhhSPTM2BRrQa3At3erAlnPDjv
         C4timz3+B/wKzV2iwo1cwg2H0YLapiBBCzcN+mqHj7W8MClFjY3pUv+u03rEmXyZzH3/
         tD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781178615; x=1781783415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=By5jxDRfMhWNJ3zdMqbqgKEuQjBAiR2dgY0SOpXrO1o=;
        b=ozOFhyct689htOA4NaC7sOB5NFlxWZ08AR2jwgUYvg6S6gVQo9jP+Gr4o2rXrUXi02
         KGEN24vJ0IOngavvcFBheySMFFQrYl/Qt2uvhMgirrSCIha6olr8rQ2yKEAJdx04E6Ut
         MGKckA3J5MA8B0Mbc9hHslyIpZdoNJTt294H5OBjKzq43YNqM7NwB/LZYUSjCV/BHNeZ
         itFVTnrmEpielXxcBZkmhQcZv0hc0OTfBTEpKnovTAFeOlcTICT6K14W6hub/1z5pU1H
         NJC+D9kTaX9gqp3Lts9xAviuWSVi6cTDsBnlxDUcTi1Ut1+mWjU51l5rbgC7rTzpzVXw
         hFJw==
X-Forwarded-Encrypted: i=1; AFNElJ9cH3T/vC1cr36gw+9n+BCRZbJdZ9bh/IVXOxuUKi5YhAkP4vLjMg8RRGeG0atbWjKQLpXi5dUhmyBn@vger.kernel.org
X-Gm-Message-State: AOJu0YzyeLTPtSVStEoBwVw7TgZUqmGtMFpGNygrVigobgExqt359BRK
	K6yQ+YqCovTvDLg8gTST3M7JXmCmILP5+E2zsI2iVps4xAzxilkVKzvaGAzM+c2vn+g=
X-Gm-Gg: Acq92OGRGhSq8AHehwr+lFn0LXkvadVNOxPT38xz2QFszQLVk1m/ChcI0esxAPPkMG3
	EqKq4iLOkvqfTEbIbLjYpfQVuX6ZTuvUVMVoRrFDzVUrnQSN2LRMllwIRIGfvzYDWKHpsHP8BwQ
	c6nMle6OegokiHEjvKnWneWrpZ0kQSfZw6Q4ncdSz/deczrZ4gu4ZA/UhdGwAEEijsH6U4WHd+b
	sP5RpxgdFu8s2A3gpMeQnV2EJmnTyGvrSdwzIlCvMA1hCnagDF+6IX+SwigjG7bvyy+wwq7z9PW
	8MCIsHTWa2uUHDONvXtj0wiE2hfwgpbSLuMNnSy5cf2dXoK2KnivejlsVuSlcmt00YF3N1RlyFG
	N6aaQ/jJuHKnwxmygn9h3sg4O/3a0pnNGM5++hdW5847EBvW/PONJkEn4QMLIS4McHlovMH05TT
	t9gqhYsbGs18T2OALJ8SvH8mXJEDc+FDr2wV7hYypDirrOHSlhuwh/+3CJmIdj7IqNQx1mb2vlA
	RBp22cUQxrQmEibmhcfgFqzpgPowLmEABzt4Q==
X-Received: by 2002:a05:6000:2508:b0:460:1bf8:c959 with SMTP id ffacd0b85a97d-460673e3ae5mr1690022f8f.0.1781178614930;
        Thu, 11 Jun 2026 04:50:14 -0700 (PDT)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ed944sm83042430f8f.13.2026.06.11.04.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 04:50:14 -0700 (PDT)
Date: Thu, 11 Jun 2026 13:50:04 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, Marc
 Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>, Suzuki K
 Poulose <Suzuki.Poulose@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh
 <smostafa@google.com>, Alexey Kardashevskiy <aik@amd.com>, Dan Williams
 <dan.j.williams@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, x86@kernel.org, Jiri Pirko <jiri@nvidia.com>,
 Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 04/20] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260611135004.70d48daa@mordecai>
In-Reply-To: <20260611113740.GB1066031@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-5-aneesh.kumar@kernel.org>
	<20260609143242.GK2764304@ziepe.ca>
	<yq5aa4t1myw4.fsf@kernel.org>
	<20260611113740.GB1066031@ziepe.ca>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20776-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:aneesh.kumar@kernel.org,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:smostafa@google.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,m:jiri@nvidia.com,m:mhklinux@outlook.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ptesarik@suse.com,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,lists.infradead.org,vger.kernel.org,arm.com,samsung.com,resnulli.us,google.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,nvidia.com,outlook.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ziepe.ca:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C29C671879

On Thu, 11 Jun 2026 08:37:40 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, Jun 11, 2026 at 10:55:47AM +0530, Aneesh Kumar K.V wrote:
> > Jason Gunthorpe <jgg@ziepe.ca> writes:
> >   
> > > The sashiko note does look legit though:
> > >
> > > 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> > > 	    !gfpflags_allow_blocking(gfp) && !coherent) {
> > > 		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
> > > 					   gfp, attrs, NULL);
> > > 		if (!page)
> > > 			return NULL;
> > >
> > > I don't see anything doing the force_dma_unencrypted test along this
> > > callchain..
> > >
> > > I guess it should be done one step up in dma_alloc_attrs() instead of
> > > in dma_direct_alloc()?
> > >  
> > 
> > I think we should do something similar to what dma_map_phys() does here,
> > considering that we only support DMA direct with DMA_ATTR_CC_SHARED/DMA_ATTR_ALLOC_CC_SHARED.  
> 
> Yeah, I think that's the right idea for now..
> 
> > +	if (force_dma_unencrypted(dev))
> > +		attrs |= DMA_ATTR_ALLOC_CC_SHARED;
> > +
> > +	is_cc_shared = attrs & DMA_ATTR_CC_SHARED;
> > +
> >  	if (dma_alloc_direct(dev, ops) || arch_dma_alloc_direct(dev)) {
> >  		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
> > +	} else if (is_cc_shared) {
> > +		trace_dma_alloc(dev, NULL, 0, size, DMA_BIDIRECTIONAL, flag,
> > +				attrs);  
> 
> But it would be clearer to put the test in the iommu_ functions I
> think, since they are the ones that have the issue. We will need to
> fix it someday..
> 
> I think we can ignore the op-> functions, arches cannot support CC and
> still use dma_map_ops..

Hm, sounds reasonable. Should we probably enforce this at configure or
build time?

Petr T

