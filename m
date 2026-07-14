Return-Path: <linux-s390+bounces-22217-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 718IJcQJVmpyyQAAu9opvQ
	(envelope-from <linux-s390+bounces-22217-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 12:04:52 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E66E3753313
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 12:04:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=NMjfCsqZ;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22217-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-22217-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=samsung.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17A8830D39AC
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 10:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7AE43FD22;
	Tue, 14 Jul 2026 10:00:21 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9476D4192FE;
	Tue, 14 Jul 2026 10:00:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023221; cv=none; b=Xc0i2ax40Z3o682M2RffHpzqHiQYef/piGxhOnyZtUpZB4hhki2KZUMnNyAl8tE9NKf1+eUllThcoHvz/O83fF1nwZlZVFFhmYzH0IVIttTq/8+z2xrO268OUQbdRXJJNN7k+Cboa0QqRnXtVhRhoQ8GHce2BG6ed/ZfL1DtuBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023221; c=relaxed/simple;
	bh=oe7+UusSV/9zSaGQDbO7QrUpA1hbAEzSMWsSFJ1AoNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=oLR8UCJa1R74Yrk/6PKDk1gIbNdAYIWovEtBKs1viy8jjrTL1ditl8WG5F9xqpZ37tFX6tIafMfgpvygU42tX/iDzOoOsF0kXq9MEIm0xytHFshUSWYfHilZpk0dS89/EOSDaJ8eeVC1J2voB8KCkqRUUSFQXpaZ8S2mc/dAmgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NMjfCsqZ; arc=none smtp.client-ip=210.118.77.11
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260714100016euoutp010b64ed20ec9ba1c6447f10b7abae08b8~CH6nFLiNZ1160011600euoutp01a;
	Tue, 14 Jul 2026 10:00:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260714100016euoutp010b64ed20ec9ba1c6447f10b7abae08b8~CH6nFLiNZ1160011600euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784023216;
	bh=IUra5EJSRaUGl/khGQ/hVpRAn7fp80t3QbcNAonpnHo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=NMjfCsqZ5hnUEU0WETu01Q9nOdFTV987l1OyEpSxVC3qsrjuo+pdKGHJOn1P/uqy9
	 0ML3iTMDQp8jsFJA5eqo2WdyOclP9r+hDHP0Qb9E1dtE0XTKwa/FLLs+p4+9q/ScPz
	 8vhb3Wq8om+OapgJr8LiPPxclNzpInm/pkQwvQpQ=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260714100016eucas1p2bbfe02d5fc02fcf561dc5409c7ecb5ab~CH6mtujgB0401004010eucas1p2d;
	Tue, 14 Jul 2026 10:00:16 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260714100014eusmtip1f8ce1c67533271011f679d0bcf054f91~CH6lJz-Yt2122621226eusmtip1M;
	Tue, 14 Jul 2026 10:00:14 +0000 (GMT)
Message-ID: <6f35eaae-f3d2-48fb-abce-9a2cc124b0ef@samsung.com>
Date: Tue, 14 Jul 2026 12:00:13 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v7 00/22] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Jason Gunthorpe
	<jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy
	<robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier
	<maz@kernel.org>, Steven Price <steven.price@arm.com>, Suzuki K Poulose
	<Suzuki.Poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Jiri
	Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>, Petr Tesarik
	<ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Madhavan
	Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Gerald
	Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian
	Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, x86@kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <yq5aldbdnbj8.fsf@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260714100016eucas1p2bbfe02d5fc02fcf561dc5409c7ecb5ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260707080628eucas1p13fa8a57e60ef5dd3ec651e19e42af0a1
X-EPHeader: CA
X-CMS-RootMailID: 20260707080628eucas1p13fa8a57e60ef5dd3ec651e19e42af0a1
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
	<CGME20260707080628eucas1p13fa8a57e60ef5dd3ec651e19e42af0a1@eucas1p1.samsung.com>
	<yq5av7argr65.fsf@kernel.org>
	<fc804746-4fb8-4ea9-997f-a4cae9ba8c14@samsung.com>
	<20260713194323.GC3133966@ziepe.ca>
	<cd5d0504-1592-4b48-89ea-1efe8aa57968@samsung.com>
	<yq5aldbdnbj8.fsf@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22217-lists,linux-s390=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:aneesh.kumar@kernel.org,m:jgg@ziepe.ca,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:smostafa@google.com,m:ptesarik@suse.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,lists.infradead.org,vger.kernel.org,arm.com,kernel.org,resnulli.us,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[m.szyprowski@samsung.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.szyprowski@samsung.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[samsung.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:from_mime,samsung.com:mid,samsung.com:email,samsung.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E66E3753313

On 14.07.2026 11:52, Aneesh Kumar K.V wrote:
> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>> On 13.07.2026 21:43, Jason Gunthorpe wrote:
>>> On Tue, Jul 07, 2026 at 03:03:48PM +0200, Marek Szyprowski wrote:
>>>> I'm fine with merging on top of the topic branch and I assume that this
>>>> patchset is mature enough to give it a try in linux-next, but first I
>>>> would like to get a review or at least acks from others with good CC
>>>> knowledge or experience.
>>> I think it is good to go from a CC perspective, there are still some
>>> more items to fix up (like the MMIO) but I'd rather they be followups
>>> at this point.
>> Great. Aneesh, any chance You could send v8 with the remaining items
>> fixed till end of this week? I will be happy to push it to
>> dma-mapping-for-next for testing in linux-next asap.
>>
> Sure. You need this rebased on top of the pKVM changes, right?
> Otherwise, we'll end up with conflicts when you do the final pull
> request.
Ah, indeed. I forgot about the pKVM changes. If there is a stable
branch with those patches, please base v8 on top of it.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


