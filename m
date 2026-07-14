Return-Path: <linux-s390+bounces-22198-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IZT3DqSzVWoxrwAAu9opvQ
	(envelope-from <linux-s390+bounces-22198-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 05:57:24 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BCC750B7F
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 05:57:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=liTaKP1C;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22198-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-22198-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 565D83015176
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 03:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771C139F162;
	Tue, 14 Jul 2026 03:57:16 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D3C3655F0;
	Tue, 14 Jul 2026 03:57:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784001436; cv=none; b=J+KMdJS1inRQG4BSoGZTscwrbev8YsYhLXBQjmnKyEyuH3/rMdHUBLCK+uQy1hMoe8XWV50qfIkFaBc1jszy8kd+5IAvy1lU6tC/CNRLqqoRrvAWCnpcwdZazA5TUZmABswDsOk3wzJ9+9VFLe2VnkshaOmZSQ1miuJiyvnj+tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784001436; c=relaxed/simple;
	bh=StS7UKvJ/np+93VrnACK0jk1cBXTnkp0ijBgNiHgeYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j2mbUobtJle4wJIgwoaY1V+5OxX+dMnP4jqr5uLGzUCcgzi/wuY4/c95MY9N/oZXZECBSLtRhBKEU6jzxdgLgeOMld2uDVQsRdf0vB5sJUGsW2WrxKbmuWk9tBvNC4XxAxkBhbYx02Nwhzyr+3aHdWF49AqPFP0sCqBDDiNE2aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liTaKP1C; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0781F000E9;
	Tue, 14 Jul 2026 03:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784001434;
	bh=0DTF91RjgvUm3CkB4plK9HEQr87d/ix1i757jTGkFXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=liTaKP1CyQrmvF0csupiCFTNVzXrIF4DX9PY42lGELqbECDbZSqXHFZ9ZmTU2m0e9
	 5KWxINF9sfknPV5nVNQ1W/TliVFmJMCkEjFEYGHUfMP22YLVwQTk3GvT9OKdkoUmd7
	 O6t/MMHc03XpwRzKpXb5NBzNwRLz6dmuIH1uOX5bFJfbq9eOuqVSgWUPXIHBRMH22u
	 AmQ2hRYMtzI26BCCfdviKKLYvAzWyATOKECrGshO0bgqaHnTSbVIB7dcZWobY+G5/R
	 hXLxwzKEw2QW/46MBn1MokgBPlijaMw8orHsIzchJadQjcBC1HAK2Epj4bNYTUnO6g
	 2ZAHiwxtlSCjQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 04/22] dma: free atomic pool pages by physical address
In-Reply-To: <20260713181059.GL3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-5-aneesh.kumar@kernel.org>
 <20260713181059.GL3133966@ziepe.ca>
Date: Tue, 14 Jul 2026 09:27:01 +0530
Message-ID: <yq5awluymdf6.fsf@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22198-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:smostafa@google.com,m:ptesarik@suse.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aneesh.kumar@kernel.org,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,lists.infradead.org,vger.kernel.org,arm.com,samsung.com,kernel.org,resnulli.us,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,outlook.com];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:email,ziepe.ca:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37BCC750B7F

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Wed, Jul 01, 2026 at 11:19:08AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> dma_direct_alloc_pages() may satisfy atomic allocations from the coherent
>> atomic pools. The pool allocation is keyed by the virtual address stored in
>> the gen_pool, but the pages API returns only the backing struct page.
>> 
>> On architectures with CONFIG_DMA_DIRECT_REMAP, atomic pool chunks are added
>> to the gen_pool using their remapped virtual address.
>> dma_direct_free_pages() reconstructs a linear-map address with
>> page_address(page) and passes that to dma_free_from_pool(). That address
>> does not match the gen_pool virtual range, so the pool lookup can fail and
>> the code can fall through to freeing a pool-owned page through the normal
>> page allocator path.
>> 
>> Add a page-based pool free helper that looks up the owning pool chunk by
>> physical address, translates it back to the gen_pool virtual address, and
>> frees that address to the pool. Use it from dma_direct_free_pages() while
>> keeping the existing virtual-address helper for coherent allocation frees.
>> 
>> Tested-by: Michael Kelley <mhklinux@outlook.com>
>> Tested-by: Mostafa Saleh <smostafa@google.com>
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>  include/linux/dma-map-ops.h |  1 +
>>  kernel/dma/direct.c         |  4 +--
>>  kernel/dma/pool.c           | 54 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 57 insertions(+), 2 deletions(-)
>
> This seems pretty suboptimal?
>
> If !CONFIG_DMA_DIRECT_REMAP then page_to_virt() was used to compute
> the genpool's addr so dma_free_from_pool_page() can use the same
> logic, which is how things must be working at all today
>
> The CONFIG_DMA_DIRECT_REMAP scenario does look broken, so I'm
> surprised there isn't a Fixes line on this commit? I don't have an
> opinion on the search, but since alloc_pages() is used there is 8
> bytes in the struct page that could be used to store the remapped
> vaddr to avoid the search if someday someone wants to improve
> this. Maybe a small comment hinting that direction would be a nice
> addition.
>
> Jason
>

Something like

+/*
+ * FIXME!! We could avoid this by storing the remapped virtual address in
+ * struct page and using that for lookup.
+ */
 bool dma_free_from_pool_page(struct device *dev, struct page *page, size_t size)

-aneesh

