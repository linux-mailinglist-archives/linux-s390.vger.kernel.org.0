Return-Path: <linux-s390+bounces-21005-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c5HcIJ4RNGpNNQYAu9opvQ
	(envelope-from <linux-s390+bounces-21005-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 17:41:18 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D86036A14C6
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 17:41:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b="G+TcTu/Z";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21005-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21005-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8E6D302768B
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 15:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD92C33D6F8;
	Thu, 18 Jun 2026 15:37:09 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495FD32B134
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 15:37:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797029; cv=none; b=CzJJk0AYaBxYp8Bppjt08QwBPKcivRPHJQ3uSSf8YifrXhgWiPcw1/llftI4qZIjYCxe8LDlcLTLqmptHGqivT5WShAMyZ1pYlCa78F0W9UdCABX01iRNwA9yPsXaI3mtHRRrAAp5mY/HDRG+y9eedtPgKUl9HoZ8fT0Nx8NrQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797029; c=relaxed/simple;
	bh=HppPOGKgKIoggGCewCbUbyU4i7DooaPcpXs3DkDXKHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaGC+ar9i3ZaivU6Su4s0FCSci93UoXbV4RuMrNcilfDF+LFBZVtPBA9KMvbRUK21/c67gxAczlVEuIqJY11Vm83fMmrp5RdBMcrTN9icLYjd9Ga2EGvNGv8+Zxp11oFN5MLIZ4PI7cPCbhVdRPC5KhtTIEEv7Lhao7Rlr0Uz/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G+TcTu/Z; arc=none smtp.client-ip=209.85.222.171
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-915aa0a9293so241746785a.1
        for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 08:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781797027; x=1782401827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tm+jP+3WfoLtXaL6gn2l0sQY+Wj2XqJdxBBXikZyHQE=;
        b=G+TcTu/ZhrHoc9wpAmEr51Y3+GW/8PyEppBS2TYDtbHgaAUxUMJnxPUvc4NPC9cDad
         Gg5NBBVuuh1+oobmh1OsqMU62CMsp0k8IxJ8lYehE8stMxsATv1SYaJvcuWtkShKxP/j
         un9RR4j7G/7WXG6WQ1FFgEL56b/3NoSMiR1TE8uPy9U51VCcZhCzzZQgM1dUak/nT2SB
         jv3zjnbDUXnjloIwrrUPGXutVc6B2NrSGuCoOkiovagtkjVPHVdTxf/lHFFpKsuds0j0
         Nly2bdVSu8Zm6iXuIooKZDzGdSQSMw9k8W+X+HVyswQ0B1e8GNYdbItyT86LqV8q2E+n
         sc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781797027; x=1782401827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tm+jP+3WfoLtXaL6gn2l0sQY+Wj2XqJdxBBXikZyHQE=;
        b=ceOn3OQTJnKr0B2Km8uslKXaQhWQGCnM6QuLp9FYHTrZlwEphViq/JNcCcNmP9iZlz
         Cp9BtJYlF9Ov98Pq5hCfws84fLteA+E9AVS8XyF0ZOx4ntzL2fgGIv24vaFQf3ONtqvb
         sPThIBOaOIdMtEVV/9++2brEVlREtN7j13wWWYMQGognEON1WONDBcxMad2BJJlacUNR
         569YrxzbhM+q/D5Rluu4CkYr1RCegICxxLqiJ5qm0g0OGYmu7Oy+6Q89yNA2aeCxaY51
         LdDGFYHRKFEk+I3t8h9O+UAGAhWvzoxEvqDQMzeo8IrS/wEvQDhHsCEs3Iqp5VEA3MJd
         82kg==
X-Forwarded-Encrypted: i=1; AFNElJ+5HaOTpPIpqE0gm1NgYd8Etyz6LRFcNeCw3rRcqKLaSHsSSYVR8yMzh/V6mlV6HnanyuwzTthhh4K9@vger.kernel.org
X-Gm-Message-State: AOJu0YwL9lU9MBXsbrISkuO3MgBjpF/+OTXNcdqAx9pTiWAOQC9CjtJ1
	eY1XR4mwKjUAkEWQ2QQL/PALZM45lxs7ELKbt0JnFp1tjlhf8vuBmYVxPMbWrMDZsVk=
X-Gm-Gg: AfdE7cl+tgVTxcSK/cvQ9er6KSsRBSn95LuUS++V1iPCaxKc/VuCWvIfjUHJef2AtMO
	0JPcMmnoNqNk5iBUWqIIbwZFvAHR98i7YSou6ta6chJM+rfSx119fbo/ZvT5gQW5kFurdJqSt+6
	4DFIOFmw52QxdPu54OPOvhm3BWVfr1bzbGDWh0yiSCq5zIHH3Os5ShiWfyAMI4T6pGmxYJtNFX9
	tYE2FCak2M0vvrSuKDteR9JJrc0DP2ScMHb4hqCrm5FpuZJ9uapADH4GozqRdCuMkIxjLoFT0wu
	qzYvDo8nhGI4CqC/v8MFUrkziESvtjYqk/n5m2WhY67qfN6KrcOuVExZaIN2Bvk5AecDDH4sQj8
	OuNJRYEtc9k6KF+gEJS+QEt+h0/p1xuG6HwAvQ4x8IPynqArAiZyGjUeVqpyLmbezOppVqgxnK6
	En1UG6nyHxTOEVLO/GVCbTUQ6+M8uqLqCixrGoxVv5QW+ge43Dieg7oAzC7aHkY3nA5OI=
X-Received: by 2002:a05:620a:469e:b0:915:8f64:604c with SMTP id af79cd13be357-91f082ff425mr678605385a.15.1781797026718;
        Thu, 18 Jun 2026 08:37:06 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f3c324sm2104263685a.21.2026.06.18.08.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 08:37:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1waEnh-00000002tSw-24HO;
	Thu, 18 Jun 2026 12:37:05 -0300
Date: Thu, 18 Jun 2026 12:37:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <20260618153705.GH231643@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com>
 <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aqzm4dz25.fsf@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21005-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:aneesh.kumar@kernel.org,m:aik@amd.com,m:catalin.marinas@arm.com,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:jiri@resnulli.us,m:smostafa@google.com,m:ptesarik@suse.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[amd.com,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,samsung.com,kernel.org,resnulli.us,google.com,suse.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,ziepe.ca:dkim,ziepe.ca:mid,ziepe.ca:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D86036A14C6

On Thu, Jun 18, 2026 at 09:37:22AM +0100, Aneesh Kumar K.V wrote:
> Alexey Kardashevskiy <aik@amd.com> writes:
> 
> > On 10/6/26 00:47, Jason Gunthorpe wrote:
> >> On Tue, Jun 09, 2026 at 02:43:08PM +0100, Catalin Marinas wrote:
> >>> On Thu, Jun 04, 2026 at 02:09:39PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >>>> This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
> >>>> dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
> >>>> are handled consistently.
> >>>>
> >>>> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> >>>> shared/decrypted buffer handling. This series consolidates the
> >>>> force_dma_unencrypted() checks in the top-level functions and ensures
> >>>> that the remaining DMA interfaces use DMA attributes to make the correct
> >>>> decisions.
> >>>
> >>> Please check Sashiko's reports, it has some good points:
> >>>
> >>> https://sashiko.dev/#/patchset/20260604083959.1265923-1-aneesh.kumar@kernel.org
> >>>
> >>> I think the main one is the swiotlb_tbl_map_single() changes which break
> >>> AMD SME host support. There cc_platform_has(CC_ATTR_MEM_ENCRYPT) is true
> >>> but force_dma_unencrypted() is false. Normally you'd not end up on this
> >>> path but you can have swiotlb=force.
> >> 
> >> IMHO that's an AMD issue, not with the design of this series..
> >> 
> >> The series is right, a device that is !force_dma_decrypted() must be
> >> considerd to be a trusted device and we must never place any DMA
> >> mappings for a trusted device into shared memory.
> >
> > swiotlb=force forces swiotlb, not decryption.

If force_dma_decrypted() == true then swiotlb must allocate from a
decrypted memory pool. It is right there in the name!

The hypervisor environment should *never* set force_dma_decrypted()
because all devices can access all hypervisor memory, up to their IOVA
limits.

> > So when I try "mem_encrypt=on iommu=pt swiotlb=force" with this
> > patchset, it fails to boot. But it boots with a hack like this:

On the host side I expect this to cause swiotlb to allocate encrypted
memory and bounce to it.

>  		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
>  		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
>  						dev->bus_dma_limit);
> +		/*
> +		 * With memory encryption enabled, SWIOTLB is marked decrypted.
> +		 * If SWIOTLB bouncing is forced, treat the device as requiring
> +		 * decrypted DMA.
> +		 */

And this is more insane logic. The right fix is to allocate the
swiotlb bounce from the *encrypted* pools when running on the
hypervisor which requires undoing this abuse of force_dma_decrypted().

Jason

