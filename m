Return-Path: <linux-s390+bounces-21047-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pJ7/BeNFNWqEqwYAu9opvQ
	(envelope-from <linux-s390+bounces-21047-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 15:36:35 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 652E16A621B
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 15:36:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kAH1+xXX;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21047-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21047-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 338D43034B32
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 13:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54502274B5C;
	Fri, 19 Jun 2026 13:36:30 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458A615E97;
	Fri, 19 Jun 2026 13:36:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781876190; cv=none; b=plBIeswuIIVENdeUbzekBRwboQKGHs8uWgFy2QqFm99vSktAuA7PqSj3FfRfWy7gI0EL2JvSPt5ps8vzs7wWbcQtPbDreOQdVc0yf6FoVg01eZcn6TPzJGYF14Z/5qwPeP9cxdme1ngFI6IX6tH+bU8ERNGoaWkR0X3nkYU3bDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781876190; c=relaxed/simple;
	bh=kgWTjM0lLkQqHxifyD8GjM7GhU9P2lQzVwhyK1YpcwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N9bcwm/EFoW5i5VeBT+y/MM/DmmOg/Asri8l7BMWlhhz3aXEoTa5zsJvJXqh18bho89e/IHtdH7mus6k1CoBrF/6pcSU8JT2+fzKFln/4AGxgR9SLd4BEYD7kZsHeNtwRRE+FyiDY6H4ycqdnkfkWNmU7RbjXJDS8N613De05V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAH1+xXX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF291F000E9;
	Fri, 19 Jun 2026 13:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781876189;
	bh=MBitVv/Wp6PuH6BWLvxBrPjtZ76g3L5KKs3NVrBh8ZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kAH1+xXXWAZrnqaGD7/jcVVJZXKo1zqhlJeoVFzORJVb9aVkw/eIs71MOGxdZcaTO
	 gLj5qu44i7FTmN2rf5o3o/3j1qWmECbRssq5GeQm2sT4GmMMGH4Lse//y80zxxhIqT
	 eyzkJU4bptugVm248QSCRQqo6wkaBO5MtCdvWI+LkKIpVqimUNwXQyk7VRJgm6IXk3
	 ndmjfdpm/R6nLX5ltoS7VekJgvgsRGw66rPjZVRqav3g0KHKladHM/yUbPDEHAuJZV
	 RUHs/hLvB02W/2/PHdotsxouWvZD8zoQIaFae5QnDu6Xlklqdeh3wTLyYSkbez2bG/
	 fcXGVjxDeiEiw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
In-Reply-To: <20260619122148.GL231643@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com> <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org> <20260618153705.GH231643@ziepe.ca>
 <yq5ao6h6enhm.fsf@kernel.org> <20260619122148.GL231643@ziepe.ca>
Date: Fri, 19 Jun 2026 14:36:19 +0100
Message-ID: <yq5aldcaejos.fsf@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21047-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:aik@amd.com,m:catalin.marinas@arm.com,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:jiri@resnulli.us,m:smostafa@google.com,m:ptesarik@suse.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aneesh.kumar@kernel.org,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[amd.com,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,samsung.com,kernel.org,resnulli.us,google.com,suse.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,ziepe.ca:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 652E16A621B

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Fri, Jun 19, 2026 at 01:14:13PM +0100, Aneesh Kumar K.V wrote:
>> > And this is more insane logic. The right fix is to allocate the
>> > swiotlb bounce from the *encrypted* pools when running on the
>> > hypervisor which requires undoing this abuse of force_dma_decrypted().
>> >
>> 
>> Agreed. If the device can do encrypted DMA and requires bouncing, it
>> should bounce through encrypted pools. We don't support encrypted pools
>> now and that means, we mark the option ("mem_encrypt=on iommu=pt
>> swiotlb=force") not supported for now? 
>
> ?? if you don't have a CC system then the swiotlb is "encrypted"
> meaning ordinary struct page system memory.
>
> The hypervisor should not be triggering any CC special stuff here, it
> is not a CC guest.
>
> Agree we don't need to worry about swiotlb=force with a trusted device
> in the GUEST for now, but it should be something to fix eventually.
>

If i understand this correctly, the setup Alexey is referring to here is
bare metal system with memory encryption enabled and dma address doesn't
need C bit cleared because it is handled in iommu. ( I consider this as
memory encryption that is handled transparently, device can access any
address because that encryption details are now managed by iommu).

Thinking about this more, I guess we should mark the swiotlb as
cc_shared only with  CC_ATTR_GUEST_MEM_ENCRYPT instead of
CC_ATTR_MEM_ENCRYPT as we have below.


	/*
	 * if platform support memory encryption, swiotlb buffers are
	 * shared by default.
	 */
	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
		io_tlb_default_mem.cc_shared = true;
	else
		io_tlb_default_mem.cc_shared = false;

....
	if (io_tlb_default_mem.cc_shared)
		set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PAGE_SHIFT);

So we consider swiotlb as encrypted pool in such config.

Now we have the case of host memory encryption where the C-bit needs to
be cleared in dma_addr_t. That requires special handling in the kernel, and
I believe we need to mark swiotlb as unencrypted in this configuration.

I am still not clear whether there is a config option or runtime check
we can use to identify this case.

-aneesh

