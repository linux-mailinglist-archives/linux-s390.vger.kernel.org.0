Return-Path: <linux-s390+bounces-21549-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VAzHLsGiR2rFcgAAu9opvQ
	(envelope-from <linux-s390+bounces-21549-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 03 Jul 2026 13:53:37 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BC970210D
	for <lists+linux-s390@lfdr.de>; Fri, 03 Jul 2026 13:53:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=P8lXUCpR;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21549-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21549-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA1D4301F189
	for <lists+linux-s390@lfdr.de>; Fri,  3 Jul 2026 11:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19ED3CAA53;
	Fri,  3 Jul 2026 11:46:59 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE6386440
	for <linux-s390@vger.kernel.org>; Fri,  3 Jul 2026 11:46:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079219; cv=none; b=ktb38AHhWH53M/ko1HOfJweDoeB2+O0lZV7JuPTCITCmGSezcVcabDJNeQI+N+iplS3Y3A3eDSTz3aPRnWoNhA5xr9zm99o48HvD1Mi6GlhdhDgVYQcbducn/ELykMPxyACsGiDBbr4WXKk8beEE3pmlLBL+++fVxoiDFgLoVUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079219; c=relaxed/simple;
	bh=ErVa6O+H+ziQoQxw89SnZ3zm/NmC5i67ydJ72rOS0eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rX76iY3pwHGy2hiB8olsa3XMcX7p6y8PIrujNfn2KXmcm1NtQDS4x/V2Vdkqe0XtDGMEzv/nOOLfomTuuVmq757AiT0vRCIxthTgttjLrc4R15mdXtwA2dW6iT+ZcoJzMkVcIfwyIHTd9KVMAI9nOyeLKSZrYE4fAvaawcVm0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P8lXUCpR; arc=none smtp.client-ip=209.85.160.180
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c08df8513so3452451cf.3
        for <linux-s390@vger.kernel.org>; Fri, 03 Jul 2026 04:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783079217; x=1783684017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GF/dZxM95AsUU1wWK1B0B/CUui/snGJUvA0tIkHl1DM=;
        b=P8lXUCpRvnaDY+6FfT9JPABtwNTX2V75ahNsqzNTSCtjuhmgRPD21n+pe3J8DRuiru
         ByV3eaEXylPtnpSVPFYftLSUoPK+GA7jNQS5zd1r4zpvnCEDy+SG8hA9Yj9CJ0WDde5W
         +NVkchldWVdMztH2zEOpxVQ9ztviz475zAW9dI2ngQ6VPqg3MDlVBLN6WWpP1+Eb1tmS
         TyYvOE9i/4eG6G3d6S2VCzdQhsdmBpb9dUJ5eKCL9nQkT0a54LPYakrpwuXju/iNSxTo
         nQ4fsWFtPy3ex/F6JQH06QHet7nPGIEwQVEIQEeEusWyyJmzA0uPgsUP539qJvSirjza
         ykHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783079217; x=1783684017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GF/dZxM95AsUU1wWK1B0B/CUui/snGJUvA0tIkHl1DM=;
        b=rQMU9SsKxgSTtLLU+Z9snT+8XtsgJzQ20+tVXqFJTZCdVakmuGp3/84pTPUEUCYMOr
         9qZlGTguzfm6K7i8HWPoWmxECRUtBAEWTRNbusmnKqrCZC5ZHOY0YpwVKqmxdNT6EAcH
         iCzcM8cYvc0eYonz3Gcz3QEVWcrz220YsGPvnLWwEInEvlmQLSklvd3TMOV1zuICuTU4
         50xeebDjPw3fEN8ddvDB5Mxs7OEsdrWD2B8+gL3VIQoEduqFS802c3fl4rkYQMdEgzSY
         XFxbrchUG0QqJvHm600R14F57+6FM9ynBwaMce9bcxbfMDpelT1q/A2poYQ/MovFd2un
         hTXg==
X-Forwarded-Encrypted: i=1; AFNElJ9Tm3BLwE4mjxEE8s06/LiXxjpYM0lSrZ3rCMMYmZO8Ok4Kv0dyTtRybEO2i3n/8i3rNXnohCzp0VG4@vger.kernel.org
X-Gm-Message-State: AOJu0YwspnzW1UR6DM4knU/dMqy02JJdnb/2LGhqmGhiSdBlkAUY5Vs2
	uoLLQMBavGTJStm4pKD97O6FEKJsbnm3sdpkPxyqrhFZkG8ls2MufrHoR/HY0hq3ONs=
X-Gm-Gg: AfdE7ckh4JkGlF4DllT4HaUAPzhoMP3FdGTO3s1XduXtt07SwPXyr092qDSQP5Gi+kv
	y885ufkMcllkgekSZWCX4QINCOAxqdTHDXHZkfrOpZJKSnAozWhMKjI2YPwHXFc9VxWaY+KfszB
	m7fjp3j64yr6XxeQCAP7mxP8lv575s1/1ZB9Fu5LJbaBKNEE4gNyJZUagof0ZC5DR2cp8YFDA71
	Tpd6ewtmz2hcJuOb0hNcRm/3/2CkyqTGC99YxjR2xH3XgdPJwsq6pNb3mEVRyho4IAexswlaLBh
	ayMAbhJEpLeMtvRABsNp2gT+pi9AHdFEGUf/W+aKn8nF3usS473gsOxHk18TATGG2c5f1NAmPu+
	l4HpOTbiD3mnRCKHYjjD7rsQcNqkLdR05p63R87YXd4VJdYMy4cqIn/nEUrtMX362oTInCcCmuv
	JtbDZTEy71GKoxAjGXlgt2m4qfiHzAipEVd2w3Os8xWUF+ewYqYiRpIX1agJUOf0rcUGs=
X-Received: by 2002:ac8:59d1:0:b0:51c:555:7dea with SMTP id d75a77b69052e-51c2ad42df1mr112307971cf.30.1783079216951;
        Fri, 03 Jul 2026 04:46:56 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c4202366csm13366551cf.30.2026.07.03.04.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:46:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfcMB-00000007ngp-0vd7;
	Fri, 03 Jul 2026 08:46:55 -0300
Date: Fri, 3 Jul 2026 08:46:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>,
	"Cheloha, Scott" <Scott.Cheloha@amd.com>
Subject: Re: [PATCH v6 03/20] dma-direct: use DMA_ATTR_CC_SHARED in
 alloc/free paths
Message-ID: <20260703114655.GW7525@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-4-aneesh.kumar@kernel.org>
 <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>
 <20260617154101.GE3577091@ziepe.ca>
 <25155bd6-4348-4aa8-ba70-0a882fc84db9@amd.com>
 <20260630160242.GI7525@ziepe.ca>
 <98800d21-18f6-44d6-9ba0-da9b77567d85@amd.com>
 <20260702144729.GP7525@ziepe.ca>
 <58bb92a9-c5ea-47a3-b19a-934573f15305@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58bb92a9-c5ea-47a3-b19a-934573f15305@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21549-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:aik@amd.com,m:aneesh.kumar@kernel.org,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:smostafa@google.com,m:ptesarik@suse.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,m:jiri@nvidia.com,m:mhklinux@outlook.com,m:Scott.Cheloha@amd.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,lists.infradead.org,vger.kernel.org,arm.com,samsung.com,resnulli.us,google.com,suse.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,nvidia.com,outlook.com,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19BC970210D

On Fri, Jul 03, 2026 at 08:15:49PM +1000, Alexey Kardashevskiy wrote:
> On 3/7/26 00:47, Jason Gunthorpe wrote:
> > On Thu, Jul 02, 2026 at 10:25:16AM +1000, Alexey Kardashevskiy wrote:
> > 
> > > > > not externally available so I'll have to trick the DMA layer into
> > > > > using SWIOTLB (which is still all shared, right?) as I specifically
> > > > > want to skip page conversions. Setting low DMA mask won't guarantee
> > > > > that the DMA layer won't allocate a page outside of SWIOTLB and
> > > > > convert it. Manually do
> > > > 
> > > > Why so particular?
> > > 
> > > aahhh I missed "pre-". I need a way to get pre-shared pages for my
> > > sev-guest activities.
> > 
> > It sounds to me like you don't, what you are worried about is
> > optimizing the dma_alloc_coherent flow to avoid fragmentation and all
> > CC architetures require this optimization.
> 
> It is not about fragmentation, it is about unwanted page state
> changes when few pages are shared for a very short time.

That's really basically the same thing. The responsiblity for
optimizing the shared/private conversion lies with the DMA API not the
callers.

> When I needed these pages, I could: get a private page, convert,
> (possibly trigger RMP and IO PDE smashing if that 4K is backed with
> 2M), do the VM<->HV communication, convert back to private (and
> possibly unsmash the page).

IMHO it would be better to use something like dma_pool to amortize the
coherent allocations instead of trying to hack with swiotlb.

Jason

