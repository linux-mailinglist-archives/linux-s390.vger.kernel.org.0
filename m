Return-Path: <linux-s390+bounces-21682-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zBsHEoezTGqWoQEAu9opvQ
	(envelope-from <linux-s390+bounces-21682-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 07 Jul 2026 10:06:31 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F04718E1D
	for <lists+linux-s390@lfdr.de>; Tue, 07 Jul 2026 10:06:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ehzJVAlx;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21682-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-21682-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 062AA301C2C2
	for <lists+linux-s390@lfdr.de>; Tue,  7 Jul 2026 08:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACE8288C2D;
	Tue,  7 Jul 2026 08:06:25 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C381EB5CE;
	Tue,  7 Jul 2026 08:06:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411584; cv=none; b=OjZWradv5Qa72m2BSGyKOX396K3nemZUbGVBEEATK8oZne6tCR2nIu3kQQqqNSwsQOf+TyVIgiSwvddrXZRj8eTuG/TX6OxOWqzz0/UZF9BCEs4HAZuLyEhiezKqdABAfv3y+PT7O3zRQp8B/Z0zo6L9VVWEko2yitMHLShZJaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411584; c=relaxed/simple;
	bh=YObFcIh1tDVXWjQY/EyHvVKx8GEiNlbw2CdpCpbxLDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V0W2HIKzLKDg2euldDtIhLwUqYhnWz/tEGZtc+JzDJOOplwC9isRsj1UJ24hzNw1WC3NzGX9BlfQ65Pd3FR5gRDFzEMsiLB007pbnduLEJsJdDmX7hM4lkX2FVQEqy0wFueT3Og7KhNwXig1V/BeCpnTUU9WdqeZjwYpEmwDvcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehzJVAlx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E980D1F000E9;
	Tue,  7 Jul 2026 08:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783411583;
	bh=ea0IOau1aAltI3DRKVxyYkxeEjLOa5kYpwFj12qVzqc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ehzJVAlxIC/pC2sXhGD1Zd5xyp2mkGV8OuobvUJm80sNhARBCJldhVJnR/fvzUlg8
	 t2QQb326FSv7l+dfyMjQn+q4qi0x/iJZD8qCoLvIATEMQErD8y3iRKIcZPoxzVgszV
	 oRoggpbomDjX7tQZq9G9GaoCtyybcTlqjfRz4+F1rB3X4H4ooSWHLgUZt7CnfLeeFM
	 zwEb6VljE8Xh9Fi9TviWiquZI1cqM+c0j9tSvLQJ700z+8l/66JsCg+ZgzcpDbHZNA
	 MK5IFv5kO6A9ODArwj2zGJLks6KS3/uwYgDXQCaGY1s1PvXpmfKk7P0jRMoD6rRJUF
	 QGcIHGnDYecHw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
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
Subject: Re: [PATCH v7 00/22] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
In-Reply-To: <20260701054926.825925-1-aneesh.kumar@kernel.org>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
Date: Tue, 07 Jul 2026 13:36:10 +0530
Message-ID: <yq5av7argr65.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21682-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:jgg@ziepe.ca,m:smostafa@google.com,m:ptesarik@suse.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aneesh.kumar@kernel.org,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[arm.com,samsung.com,kernel.org,resnulli.us,ziepe.ca,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,vger.kernel.org,linux.ibm.com,ellerman.id.au,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aneesh.kumar@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,arm.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6F04718E1D

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> This series tracks confidential-computing shared DMA state through the
> dma-direct, dma-pool, and swiotlb paths so that encrypted and decrypted
> DMA buffers are handled consistently.
>
> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> shared/decrypted buffer handling. This series consolidates the
> force_dma_unencrypted() checks in the top-level functions and ensures
> that the remaining DMA interfaces use DMA attributes to make the correct
> decisions.
>
> The series separates mapping and allocation state:
> - DMA_ATTR_CC_SHARED describes the DMA address attribute requested for a
>   mapping. It tells the DMA mapping path that the DMA address must target
>   shared/decrypted memory.
> - __DMA_ATTR_ALLOC_CC_SHARED is an internal DMA-mapping attribute used only
>   by allocation paths after the DMA core decides that the backing pages
>   must be allocated as shared/decrypted memory.
>
> The series:
> - moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
> - uses __DMA_ATTR_ALLOC_CC_SHARED through the dma-direct alloc/free paths
> - teaches the atomic DMA pools to track encrypted versus decrypted
>   state
> - tracks swiotlb pool encryption state and enforces strict pool
>   selection
> - centralizes encrypted/decrypted pgprot handling in dma_pgprot() using
>   DMA attributes
> - passes DMA attributes down to dma_capable() so capability checks can
>   validate whether the selected DMA address encoding matches
>   DMA_ATTR_CC_SHARED
> - makes dma_direct_map_phys() choose the DMA address encoding from
>   DMA_ATTR_CC_SHARED and fall back to swiotlb when a shared DMA request
>   cannot use the direct mapping, which lets arm64 and x86 CCA guests stop
>   relying on SWIOTLB_FORCE for DMA mappings
> - use the selected swiotlb pool state to derive the returned DMA
>   address
> - reports CC_ATTR_GUEST_MEM_ENCRYPT for arm64 Realms, powerpc secure
>   guests, and s390 protected virtualization guests.
>
> Dependency:
> This series depends on the pKVM changes posted at:
> https://lore.kernel.org/all/20260603110522.3331819-1-smostafa@google.com
>
> Please merge this series only after the pKVM changes above are merged.
> Otherwise pKVM will be broken.
>

A rebased tree on top of the dependent pKVM changes can be found at:
https://gitlab.arm.com/linux-arm/linux-cca/-/tree/scratch/pkvm/testing?ref_type=heads

The patches had minor conflicts. I am not sure how we want to get this
merged.

Should we ask the pKVM maintainers for a topic branch, and then I can
repost the updated series on top of that?

-aneesh


