Return-Path: <linux-s390+bounces-20589-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oIXGKGWfJmr/ZwIAu9opvQ
	(envelope-from <linux-s390+bounces-20589-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 08 Jun 2026 12:54:29 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB976555A8
	for <lists+linux-s390@lfdr.de>; Mon, 08 Jun 2026 12:54:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b="JoCZ/WKI";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20589-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20589-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=samsung.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9CB83027DA8
	for <lists+linux-s390@lfdr.de>; Mon,  8 Jun 2026 10:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB11234572B;
	Mon,  8 Jun 2026 10:44:52 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CA53B2FFB;
	Mon,  8 Jun 2026 10:44:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915492; cv=none; b=JnkXL0B8QAlHdqc6Jfu/7c29aU1eD1sIzkOfTfy6s8GpzmJtOxCsKTL83a1Yu5q2HwOI1uvmXOTXnLx00ZusQUgCOwmWK13GU/fnrlECPvdMTVRFF7ALFh5kFC/uY6Tq8/EY7pL/eGa28D/i0GkSESczzft81OyvkZXXtXR4A14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915492; c=relaxed/simple;
	bh=S39wh1Aor7xPqz2F0/ELhdZtaK0sGHh/tjvXrBVkkHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=VC8grHNAnMYhfHfMDexi7TV+c+v5bFPKH3npni/v1mfCWkecNWW82+FCyG2SmKAkSS08176mcOzsPaXU+GnyirrEMuzr26Ux/HHO8x1oOfNdEnKC03QbitmKDRm+YI6PlSCIMAbEtBcfAEeq+tLanzy1uw7GYFFUdhBHl3uotao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JoCZ/WKI; arc=none smtp.client-ip=210.118.77.12
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260608104448euoutp02462bcf49bb960e5e74d4dfba6373e0ce~3FTN8Nl8Y2450824508euoutp02S;
	Mon,  8 Jun 2026 10:44:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260608104448euoutp02462bcf49bb960e5e74d4dfba6373e0ce~3FTN8Nl8Y2450824508euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780915488;
	bh=plNYBzzaUu+CjxUfVgmwKMU0d70IRGPw0rK3BmwuPjc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=JoCZ/WKIAI4ynKcKsLsemvNM9WajLCXA73D5zw2xoD7lCL3z54ZkMrkLh/JyPdEyE
	 /kqCaIilwuycoqSIz0z02aXZrhcLMotd35EHMU7drq2vG8mZar/SYgy1xT2vcdWCN6
	 uGoRfxIdzyZOSLqUCzO80yrI3lBIVEMsvs8BDl3o=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260608104448eucas1p1685dd3246a9e2b35613d32758481919c~3FTNnAVOb0713807138eucas1p1-;
	Mon,  8 Jun 2026 10:44:48 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260608104446eusmtip22e466d5ec2468bd35b4ff28e72e16298~3FTMH8FJe2930429304eusmtip2T;
	Mon,  8 Jun 2026 10:44:46 +0000 (GMT)
Message-ID: <4d30ec2d-72e4-4d5d-98aa-d2519ed6737e@samsung.com>
Date: Mon, 8 Jun 2026 12:44:45 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v5 05/20] dma-pool: track decrypted atomic pools and
 select them via attrs
To: Jason Gunthorpe <jgg@ziepe.ca>, "Aneesh Kumar K.V"
	<aneesh.kumar@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, Robin Murphy <robin.murphy@arm.com>, Will
	Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
	<steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
	Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Mostafa
	Saleh <smostafa@google.com>, Petr Tesarik <ptesarik@suse.com>, Alexey
	Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
	Yilun <yilun.xu@linux.intel.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Jiri Pirko
	<jiri@nvidia.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260604182419.GC2487554@ziepe.ca>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260608104448eucas1p1685dd3246a9e2b35613d32758481919c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260604182425eucas1p172fc82b218cbed92f71a093549902d3a
X-EPHeader: CA
X-CMS-RootMailID: 20260604182425eucas1p172fc82b218cbed92f71a093549902d3a
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
	<20260522042815.370873-6-aneesh.kumar@kernel.org>
	<SN6PR02MB415754E94A9505C2B9739E4DD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
	<yq5afr35sciu.fsf@kernel.org>
	<SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20260603005454.GM2487554@ziepe.ca>
	<SN6PR02MB4157F94C902B78E55E99372DD4102@SN6PR02MB4157.namprd02.prod.outlook.com>
	<yq5apl26qrof.fsf@kernel.org>
	<CGME20260604182425eucas1p172fc82b218cbed92f71a093549902d3a@eucas1p1.samsung.com>
	<20260604182419.GC2487554@ziepe.ca>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_CC(0.00)[outlook.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,arm.com,kernel.org,resnulli.us,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-20589-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:aneesh.kumar@kernel.org,m:mhklinux@outlook.com,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:smostafa@google.com,m:ptesarik@suse.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,m:jiri@nvidia.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[m.szyprowski@samsung.com,linux-s390@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.szyprowski@samsung.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:mid,samsung.com:from_mime,samsung.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DB976555A8

On 04.06.2026 20:24, Jason Gunthorpe wrote:
> On Thu, Jun 04, 2026 at 08:27:36PM +0530, Aneesh Kumar K.V wrote:
>> I already sent a v6 in the hope of getting this merged for the next
>> merge window. Should I send a v7, or would you prefer that I do the
>> rename on top of v6?
> I think it is too late for such a major change, but this should be
> imaginged to be for rc2ish next cycle. You also have to spell out how
> the pkvm patch will get sequenced as well, it would be best to push
> that it gets picked up right away.


I would like to give this a bit of time in linux-next so it is a bit too
late for v7.2, but before merging it I would also like to have this code
reviewed by someone with confidential computing knowledge.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


