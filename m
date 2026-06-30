Return-Path: <linux-s390+bounces-21389-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iYltLv//Q2qJnAoAu9opvQ
	(envelope-from <linux-s390+bounces-21389-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 19:42:23 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EDD6E6FDF
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 19:42:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=LoPUME0f;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21389-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-21389-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A72273037967
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 17:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00E73DCD9B;
	Tue, 30 Jun 2026 17:42:20 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387E03DB635
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 17:42:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841340; cv=none; b=e8WD3QtkeAMCWiSBeCwH3phK3ehtP/7d3Bp4PgaHjZiiITLpzh/UZomSjdWQ04ZFMT/sI7oRxUUaOpEXUD7+p/FMJMOduz2JLIPIw/LvV5uVlfwWcJPwsLVdwal51A70k0lKslNBoDaP1ghs9xKfP11PxIElPJWqD2IL73KU8Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841340; c=relaxed/simple;
	bh=40oEbRtFZjh6zocY8nSse6CdFmdhYjJwkaMk4N2oNpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLZiSksaVXfYhxjtzlPloEcEzyuKFxhbpolKIH8HW4Z6qaDBW5ENDwx/TUZwMuW5uYJaFo7u6ujS+TjO7zX+Fhz+gSe2mQjiqdmH1h36UffPWumvxypEQNoP96kHelntVXbaF/OQFZV8NLKk7jFK7CbK0WtDlDxbz13K/lKpCwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LoPUME0f; arc=none smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c16ac21acso6483191cf.0
        for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1782841338; x=1783446138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zClWOUjkDWFvMHOUBkD6PB+uKy7SGdgOfe7bM5K85sk=;
        b=LoPUME0fs236mT4SLcYuJKCL6x9luWJcJtsrNjOzyzmg603kycR4yh0OUBPVYwtzZY
         S2aV6LLsh0UhKsAmYD6mcU5GKn89yjQSDR8Bz/uqRAMwgKym+9GciB/TFFhNiPFRY9mg
         LOLyV7HIjwDk3KUrefEEFII+08GJZG8p86a8llG0SW7JxT8LI80Tn3B76nlcBNk4/Hj7
         5C3TSRtkDm9EvhDFF0QE20a29NTUXsq4XqzVwUns27n/HAUeU7s9zX3rGjIgD2+q9ZLh
         h9Ujzf8NBkoU5+icJCHrYxOqJ3YjfRDctuA2jSzFM6QIfjflXy1Cnnxhm/+LDIAp/Oxd
         A9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782841338; x=1783446138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zClWOUjkDWFvMHOUBkD6PB+uKy7SGdgOfe7bM5K85sk=;
        b=bM3WX8xF0ZvG/lmWNMOooItvBBn05MCPqD8Pe0/ycArp9u8XGr2RU5ps7vmvjSoDWt
         DWskmX/n7+BUKs8/EZl+yyDTAdDKHysyMBbkWZKXoX/qqzKwVX8sW0LOARqF/Tbv25Vz
         HTrWt8ptncZJXlJOBddTFK08VEFEZwFdHQJ3vwaFkOUEq+4xgX7+bgqQSrTkfyUvlEFQ
         rm50GnqWdj/7R6HL4G5nev/5G9PV7T4MFth4BVZkp6T3ogkqCsvpRYHbAynA3keFUKN+
         gjCRPdFXr9h6JmC8FzRHffrpSMQuOoPqocvDyLDXwpE9t18ThyvxnNc1D6uqK0fFbTD1
         9EJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ked0+5u5q7dPfVStsXAqx40DzU4ibHJBK0dOHKiQpMDL9UyE98AFCdagFMDCyDWtQ6yskA2GJUB5E@vger.kernel.org
X-Gm-Message-State: AOJu0YwHYvYbH1GtIPjyc3iVTsxhXvLvB5TWxaYWQJ5S19seb6eaqY9X
	hYY65APljrvV0C6z2cb2qq4z8h3dZzPQa8xkVl+Il2R90+uxLCoyAPRs5B0ZsV9XIKU=
X-Gm-Gg: AfdE7clCqHSWoxIcSgwHj1KNxWWoaT0ai9x39PkeFWx7QT7+kpdlskmAGJflJwwGe3z
	4pixeO5gFMAewbtkO9E8l2wBe41SMRkXU1BZxCT+JjNAOjjwwEE3V6oMdPuydublLVkz0F7P42i
	pZ+bYZcR9wKDiy5zHPldJ+lEo9Fflzb257Qsh1O+1C2AJNBupcYSm9e0r7JXmgfNV4Hu5rIRoH3
	RLIlF7rUe02kbAS9dz29J2/fuuAr35tl42LJFQ7qghsTHjUJivNK7Z4MULVQjWzvp8tx9sGwCmn
	J2IZKQPJdAc91v21qLLQNPsMoiHHWE3oN/JBRPmyvLC3pNVfDzrNEMZ60NRK92/ASlqBLA0twXp
	xNw4Ee1FcHny2EtQgoVrpdUJdsO9dO89evMVYehbAAt66kzXq0YwgmdcSPO9RWne0uJQ4Z6FHpF
	09vDwpYUWSJ2HD2fxiDRj28oj/mZpnAHotcgcnwYVVv3TuPpD8eKG52pwL+zs8aC/OizM=
X-Received: by 2002:ac8:59d4:0:b0:51a:8c99:1f14 with SMTP id d75a77b69052e-51c108ca48fmr58918701cf.67.1782841337969;
        Tue, 30 Jun 2026 10:42:17 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c1080d4dcsm22942861cf.5.2026.06.30.10.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:42:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wecTQ-00000002FOX-35V1;
	Tue, 30 Jun 2026 14:42:16 -0300
Date: Tue, 30 Jun 2026 14:42:16 -0300
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
Message-ID: <20260630174216.GK7525@ziepe.ca>
References: <aigYbK12D8uKQvJF@arm.com>
 <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
 <yq5ao6h6enhm.fsf@kernel.org>
 <20260619122148.GL231643@ziepe.ca>
 <yq5aldcaejos.fsf@kernel.org>
 <20260619140616.GB1068655@ziepe.ca>
 <yq5ao6gtoncp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5ao6gtoncp.fsf@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21389-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40EDD6E6FDF

On Mon, Jun 29, 2026 at 12:16:30PM +0530, Aneesh Kumar K.V wrote:
> >> Thinking about this more, I guess we should mark the swiotlb as
> >> cc_shared only with  CC_ATTR_GUEST_MEM_ENCRYPT instead of
> >> CC_ATTR_MEM_ENCRYPT as we have below.
> >
> > The name cc_shared should be used for GUEST scenarios only.
> >
> > I guess there is some merit in keeping swiotlb using "decrypted" to
> > mean it usinig pgprot_decrypted and set_memory_decyped() which AMD
> > gives meaning to on both host and guest.
> 
> Are you suggesting to change the struct io_tlb_mem::cc_shared back to
> struct io_tlb_mem::unencrypted?. 

Yes

> > IDK what AMD should do on the host by default. I guess it should setup
> > a swiotlb pool of low dma addrs "unencrypted", but not "cc_shared"?
> >
> 
> If by low DMA address you mean using an address with the C-bit
> cleared. 

Yes

> The current code already does this and uses the swiotlb pool correctly
> on SME.

Well, through the force_dma_unencrypted() hack...

> The challenge arises when we want to force SWIOTLB
> bouncing even for devices that can handle encrypted DMA addresses (more
> on that below). For such a config force_dma_uencrypted(dev) will return
> false and swiotlb will be marked cc_shared/decrypted = true; This trip
> the new check we added.

Yes, because cc_shared (guest) and unencrypted (host) are very
different things and we've mixed them:

> 	if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))

I'm aruging force_dma_unencrypted should mean cc_shared and be
guest_only, but the SME hack breaks this.

> We can also do
> 
> 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> 		/* swiotlb pool is incorrect for this device */
> 		if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
> 			return (phys_addr_t)DMA_MAPPING_ERROR;
> 
> 		/* Force attrs to match the kind of memory in the pool */
> 		if (mem->cc_shared)
> 			*attrs |= DMA_ATTR_CC_SHARED;
> 		else
> 			*attrs &= ~DMA_ATTR_CC_SHARED;
> 	} else {
> 		/*
> 		 * Host memory encryption where device requires an
> 		 * unencrypted dma_addr_t due to dma mask limit
>     		 */
> 		if (force_dma_unencrypted(dev))
> 			*attrs |= DMA_ATTR_CC_SHARED;
> 		else
> 			*attrs &= ~DMA_ATTR_CC_SHARED;
> 	}

If we do this I would like to split the force_dma_.. functions into
guest and host, ie force_dma_cc_shared() and force_host_decrypted()

To make it clear there are two very different things here.

> Here I see value in having DMA_ATTR_UNENCRYPTED. The question is do we
> need to split this into two flags and introduce the resulting code
> duplication.

The external flag name should be DMA_ATTR_CC_SHARED and only used on
CC guest. Internally that turns into using set_memory_decrypted()
which works on guest and host for AMD. I don't know how to make the
host only case clearer and still keep the code efficient..

> > The dma api has to detect, after the driver sets the dma limit, that
> > none of system memory is usable when:
> >  - The direct path is being used
> >  - phys to dma for 0 is outside the dma limit
> >
> > Then it should assume the arch has setup a swiotlb pool for it to use
> > to fix the high memory problem.
> >
> > Similar hackery would be needed in the dma alloc path to know that
> > decrypted can be used to fix the high memory problem like for GUEST.
> >
> > I guess some 'dev_cannot_reach_memory(dev)' sort of test in a
> > few key places? Setup with a static branch to be a nop on everything
> > but AMD, compiled out on every other arch.
> >
> 
> If we are not able to reach the memory because of the memory encryption
> bit, then isn't dev_cannot_reach_memory(dev) the same as
> force_dma_unencrypted(dev)? If so, that is how it is already done.

Sort of yes, but it is properly named to its purpose and not confused
with what should be a guest-only function.

> x86/dma: Disable forced SWIOTLB bouncing for SME IOMMU passthrough

Maybe as a crutch to get this series merged..

Jason

