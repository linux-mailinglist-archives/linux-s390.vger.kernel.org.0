Return-Path: <linux-s390+bounces-22073-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x+L1FLEbUWrr/QIAu9opvQ
	(envelope-from <linux-s390+bounces-22073-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 18:20:01 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4660673C86C
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 18:20:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=AibK41t+;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22073-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-22073-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 337F830055FE
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 16:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F4540E8C2;
	Fri, 10 Jul 2026 16:19:52 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E74368D69
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 16:19:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700392; cv=none; b=aSH86GW0NgwhG8slZshq/cRn1CTuRyZtWVbqIzJCWHETOG+hdfu886MgfNO38EhujlzSRF4s4oKb8WQ+SuRohkT045tU6Rdi9VIPaQyq6JcV/qAWxFRA3qb5GM63uMIE242RmUzOOcHkmNebADgzUKb9kWQRmXIJpUnLGRoxzUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700392; c=relaxed/simple;
	bh=ZcNef127/m6SyCOm4THElfckuZegJcazDJQV119TKbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h396Ur5rEQzkOJ5bG1OvifxXoJ2M6mBSiry4HkS1sXLfMAj1UkGVotrZ6IO0hwWxlGFpY7wTxR+7iyxCi+71OKVbO1usnYdCUchd7q7bAYoZ7G2W6GUkggNcEJhofXxfbT/sFUHUg2FqRao9DhO/cGIzMN4jEMFXTS7nLXUkmcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AibK41t+; arc=none smtp.client-ip=209.85.219.42
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8efcfdb2b43so7348796d6.3
        for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 09:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783700388; x=1784305188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wu7pGf03sdcW+GKZ7Iww7/tPEwPDkL98YpGrOpuCsUc=;
        b=AibK41t+qxxKBFdvZR+wufelu5R20RjAjLDIEMefQl9/0Unyu6Nw/6pcVazJz7x9kJ
         /GffACivLMzMD3pseW/P+GCx8N210zQzr1vKYDlouhWphNn0ZB+ORgLzRoLwk2VWy2h8
         r9Y8hpcWcBUNzBqb2Fa2eFdf68/CAprG5hePbgCiDfUR3ALoHrpjru+sEYptKViEW5JT
         XOv826jQz9nG5t8eSs5aHsDyixCIGIGWVTanxkgV3beW6NPDglpz9goyxXksbQu0k0DM
         Bx1aVG/2dYzyvLE2SzTO/hivubhf58QCFzztcsQhfiFWjTuZ8QSjAlaiK+r+HkAmRece
         0aPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783700388; x=1784305188;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wu7pGf03sdcW+GKZ7Iww7/tPEwPDkL98YpGrOpuCsUc=;
        b=SU9ZaxboCLj009Pv7SRM0zRSWr7bYKQ6xzt6M+G/bPuvlTlarNLcoPWblM95N9mH3R
         ilHDQL7KOoJx2v7TkPJWJqtavDiw+mH9GcYQZkz2jxos2N2BYSbILSZlkimRNKsGhlCV
         QRaB3Mqi1x0yGgQLiSE0C0D5hiyGF/7m9KCLPRjZnN3sXpJtO6xBT7z+0Rnu8OPR+zaR
         TqRJ+5y1Vu6dNkdHEVFTCRsFECVKu3RiOp0u/7IOPYDk5o7qHCdR8IeH+6IUL3oObKY2
         wjEiEJiqUnljysjAFZCFQABnQ9MFaiXiCvlKMUFIye49bPyxsJ8iTfuqJtnycykJmljY
         eLaA==
X-Forwarded-Encrypted: i=1; AHgh+RrXSoGy5GQQ0yA55WlNO7lyUJY2pblZyWL0f9tSCaXbzebFN+hcLyr5WhpNxKnGBXNxOy6q7I65lsIj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn4Vwq8N1sOloPfUNB68ktHJXz03RRdCjD/DZADBKRnHvLwru8
	EQPSKBiUAQpXmufuRb1VP5rjAmeagWbmI3zvWKX7NZXov0yKuksYQRotcUXMLrGuEOs=
X-Gm-Gg: AfdE7cl9/mX/JQvApYKjEaK1g3FWXsab8mcU9INV4fqWkSHSz51JXAaHrZdfwZdNRLM
	wYkHokMu2x58d1dqQAt5exXD25l+NdyjMMDNOPR0Nmk8eBBg0Dt4a9mqfFEqYYCMM9DY31Oz5L9
	jdAKe/ziMYtRDfRFyRDTxmz0ZCz3uW8IhW1VqOHXhJu6Xt1CYCwlk4+jgYX5s/dHKd1BL7Lv0d9
	mT1Ha4ng2EYTSUqu9wI1ZS6x7cS1HieV+ZC5tKRCNWssujGOnKGUugBJnSVB5d3772ns46C27oX
	tJhBZhTShZdSY/Bj4x+f2HdUjU/l8d+G24W1/pl5qK3ghtC8YxZW1vF1qkTM+hq27Ode/Tjo0Nf
	TaS4pcLILNusVcj43yJr4XmZ1opRX+kroZ0ICJMY8an74yIzzZPhr3I+2oiAs
X-Received: by 2002:ad4:5743:0:b0:8f4:870f:72bc with SMTP id 6a1803df08f44-8fec3cf5d44mr142091486d6.51.1783700387612;
        Fri, 10 Jul 2026 09:19:47 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56bf455sm44263206d6.13.2026.07.10.09.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:19:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wiDx3-00000007We8-41pt;
	Fri, 10 Jul 2026 13:19:45 -0300
Date: Fri, 10 Jul 2026 13:19:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
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
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <20260710161945.GO118978@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
 <ak42F240d-53QeFN@arm.com>
 <yq5apl0xgy89.fsf@kernel.org>
 <ak-CT3oanlDfgTy4@arm.com>
 <20260709181336.GM118978@ziepe.ca>
 <yq5ajyr3h106.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5ajyr3h106.fsf@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22073-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:aneesh.kumar@kernel.org,m:catalin.marinas@arm.com,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:jiri@resnulli.us,m:smostafa@google.com,m:ptesarik@suse.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,m:jiri@nvidia.com,m:mhklinux@outlook.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,samsung.com,kernel.org,resnulli.us,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,nvidia.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4660673C86C

On Fri, Jul 10, 2026 at 10:52:49AM +0530, Aneesh Kumar K.V wrote:
> >> > 	/*
> >> > 	 * For host memory encryption and device requiring unencrypted DMA,
> >> > 	 * MMIO memory is treated as shared by default.
> >> > 	 */
> >> > 	if (attrs & DMA_ATTR_MMIO) {
> >> > 		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) || force_dma_unencrypted(dev))
> >> > 			attrs |= DMA_ATTR_CC_SHARED;
> >> > 	}
> >> 
> >> Yes, I think it does the trick, preserves the current semantics for AMD.
> >> I guess you could use a single 'if' for all checks (up to you).
> >
> > Please don't change it, MMIO P2P is broken on CC systems today and it
> > should stay broken. Passing DMA_ATTR_MMIO with DMA_ATTR_CC_SHARED is
> > an error that we need to correct in the drivers not make work in the
> > core code.
> >
> 
> But the above changes are intended to handle HOST_MEM_ENCRYPT. In v7, we
> had the following diff:

To follow how the rest of the decrypted/encrypted stuff works the MMIO
has to be flaged with CC_SHARED for HOST_MEM_ENCRYPT too, just like
the PTEs.

> @@ -88,37 +88,40 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>  {
>  	dma_addr_t dma_addr;
>  
> +	/*
> +	 * For a device requiring unencrypted DMA, MMIO memory is treated
> +	 * as shared by default.
> +	 */
> +	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
> +		attrs |= DMA_ATTR_CC_SHARED;

force_dma_unencrypted() says nothing about the properties of the
address passed in, this was nonsense :\

> As we discussed [1], that can come in a later patch. In the meantime, adding
> the HOST_MEM_ENCRYPT check preserves the previous behavior for SME.

It never worked. When we added ATTR_MMIO it started to have a chance
to work but prior to that it was always broken anyhow. I don't see
there is much merit in preserving the narrow window when we
inadvertantly had a half working ATTR_MMIO.

But if you really want to it should be
cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) *only* and get rid of the wrong
force_dma_unencrypted().

But IMHO, I'd rather this series treat ATTR_MMIO as private MMIO and
ATTR_MMIO|CC_SHARED as shared MMIO and that's the right and correct
thing for the DMA API.

Jason

