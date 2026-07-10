Return-Path: <linux-s390+bounces-22032-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dakFJXTOUGpN5QIAu9opvQ
	(envelope-from <linux-s390+bounces-22032-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 12:50:28 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA8B739D72
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 12:50:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nYLQ+9PR;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22032-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22032-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C2F73001A75
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 10:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5923FA5CC;
	Fri, 10 Jul 2026 10:50:23 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA73242B0;
	Fri, 10 Jul 2026 10:50:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680623; cv=none; b=uLP48w7DXoeOAvak9VUMiTO9pyyZbiKz9xjgTMxDlTqPTHUhtuj8nw8y6EjezN/vhCvDBwoL7cs/fzewXkNrUUFzpN7rX/45XQM8VoHe+HkJxOdnRa5qexTy/uKRBuaggU8LZjxzzvMGrhw5m+kADdGQlO2zaEw8XdmmZMzHJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680623; c=relaxed/simple;
	bh=zHyJL+UXXRt+wdOaEf3ids44w7tin5o0+azcLa1/EYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiyJqbBMyNXOLxblWKHHPilW3BrGWg1EPzBLs5lAN2+6U/R8VmJfbLqxfV/aT0Kl25RLHb9Q142SVMJ9BpmDEIKiGxgdZs4dvsLcJ71Da2us3HwA6TBZWweAVlEBJmPiAWmbmpCRL7brSyggFAnXdJUYEDULh82FgrwnUmIu/fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYLQ+9PR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4B11F000E9;
	Fri, 10 Jul 2026 10:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783680621;
	bh=hfTO3wFu/T6iZFaBLNDZLHaW6Mq653VUZn4uoRS7Zj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nYLQ+9PRsu6pTYa7XveNy4Y0cihb6Lvyb2okOddtnzEDFyhKZMoEp28hrsnAuSs1/
	 mZWLZmRgr8X2MEZjnVFnbhGNKuv/d+Kl4OD/zcri16TTTzcUSRPgbwYMsnlmQYVZ2Q
	 fSNn40vQEBtYdfiI8057+h/qZPp0qDO1qn8JAF++X66Q6YwXY6qHMbRN4akzlqykrG
	 X1sftYbJurNQTvVGQJCWWm50cIkILsstPYP8QSi2lEZ21NAzI0sqPbfqxqtElSQcNS
	 pnRxs8cUNLPGyy81RO4cJUiFw3EmrJ5RSS3AlI20Gr4GlHC1U07tf55AuvCMff4Rs3
	 VIJHcPWynLx/A==
Date: Fri, 10 Jul 2026 11:50:12 +0100
From: Will Deacon <will@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v7 00/22] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
Message-ID: <alDOZAK_reXPQJsN@willie-the-truck>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <CGME20260707080628eucas1p13fa8a57e60ef5dd3ec651e19e42af0a1@eucas1p1.samsung.com>
 <yq5av7argr65.fsf@kernel.org>
 <fc804746-4fb8-4ea9-997f-a4cae9ba8c14@samsung.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc804746-4fb8-4ea9-997f-a4cae9ba8c14@samsung.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:m.szyprowski@samsung.com,m:aneesh.kumar@kernel.org,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:jgg@ziepe.ca,m:smostafa@google.com,m:ptesarik@suse.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER(0.00)[will@kernel.org,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22032-lists,linux-s390=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,lists.infradead.org,vger.kernel.org,arm.com,resnulli.us,ziepe.ca,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CA8B739D72

On Tue, Jul 07, 2026 at 03:03:48PM +0200, Marek Szyprowski wrote:
> On 07.07.2026 10:06, Aneesh Kumar K.V wrote:
> > "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
> >
> >> This series tracks confidential-computing shared DMA state through the
> >> dma-direct, dma-pool, and swiotlb paths so that encrypted and decrypted
> >> DMA buffers are handled consistently.
> >>
> >> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> >> shared/decrypted buffer handling. This series consolidates the
> >> force_dma_unencrypted() checks in the top-level functions and ensures
> >> that the remaining DMA interfaces use DMA attributes to make the correct
> >> decisions.
> >>
> >> The series separates mapping and allocation state:
> >> - DMA_ATTR_CC_SHARED describes the DMA address attribute requested for a
> >>   mapping. It tells the DMA mapping path that the DMA address must target
> >>   shared/decrypted memory.
> >> - __DMA_ATTR_ALLOC_CC_SHARED is an internal DMA-mapping attribute used only
> >>   by allocation paths after the DMA core decides that the backing pages
> >>   must be allocated as shared/decrypted memory.
> >>
> >> The series:
> >> - moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
> >> - uses __DMA_ATTR_ALLOC_CC_SHARED through the dma-direct alloc/free paths
> >> - teaches the atomic DMA pools to track encrypted versus decrypted
> >>   state
> >> - tracks swiotlb pool encryption state and enforces strict pool
> >>   selection
> >> - centralizes encrypted/decrypted pgprot handling in dma_pgprot() using
> >>   DMA attributes
> >> - passes DMA attributes down to dma_capable() so capability checks can
> >>   validate whether the selected DMA address encoding matches
> >>   DMA_ATTR_CC_SHARED
> >> - makes dma_direct_map_phys() choose the DMA address encoding from
> >>   DMA_ATTR_CC_SHARED and fall back to swiotlb when a shared DMA request
> >>   cannot use the direct mapping, which lets arm64 and x86 CCA guests stop
> >>   relying on SWIOTLB_FORCE for DMA mappings
> >> - use the selected swiotlb pool state to derive the returned DMA
> >>   address
> >> - reports CC_ATTR_GUEST_MEM_ENCRYPT for arm64 Realms, powerpc secure
> >>   guests, and s390 protected virtualization guests.
> >>
> >> Dependency:
> >> This series depends on the pKVM changes posted at:
> >> https://lore.kernel.org/all/20260603110522.3331819-1-smostafa@google.com

FYI, I'll probably take the second patch there as a fix, then I can put
the other two on a topic branch in the arm64 tree.

Will

