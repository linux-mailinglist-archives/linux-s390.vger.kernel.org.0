Return-Path: <linux-s390+bounces-22126-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X527LsPvVGo8hgAAu9opvQ
	(envelope-from <linux-s390+bounces-22126-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 16:01:39 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6006E74C08B
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 16:01:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=cPtHzfqI;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22126-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-22126-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7185E30A236E
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 13:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5589243711F;
	Mon, 13 Jul 2026 13:56:42 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D10437107
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 13:56:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951002; cv=none; b=ngt08IewgEJk+3M7eE74x0zXxV7bDGbfBkf/+MbYRM3KCe1NBTZX9MaIyz27nxFaHHqxYeE7RNtBL0BJmIJdkL8iYcPPLpmkA0XvptaB8iOp/qa2lm0gGTHtXzaBb5f/TF8hBrXkeYZhTXdbp0J2cNZj4qm9ElgDz8A8+8scTC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951002; c=relaxed/simple;
	bh=9KihY4IsvKVp0Oht8qbc03FAQfSZWEfFvdyOwhTMNR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTywzvqRs7RNj6Mm25nMLAw2xqazAX1V9NT9Vm64Qvc3VLwNBbfzT74Ws96S+YviiK3HdICwRFW2+xbWknSIL0rf6SNKB9vZ7shUSFURZNSccGqd0S4E+lSRa9iwbXy3xsp9EJIKpGplXgUSgEByItz/R2rPok/adS35SJcfOR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cPtHzfqI; arc=none smtp.client-ip=209.85.219.51
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ff88549786so37445856d6.3
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 06:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783950999; x=1784555799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dThHBkWDs48b/2hz2YL35z2V9VnPq+MKY/40ZoZ5a/U=;
        b=cPtHzfqIQjqh+NB0ql9PGtQ2EemR+sv6Y0OM3XORKwPNyH+E15ga3F+nl6ggD70hWu
         Y5q/fxnZaC71dt+mq1ngLZxiGI5ON+i1yrAhcRvIALpOeSnbLO0hYHixEl/EGC8+rPmr
         YPsfYhI70q/zAjAhbWO7L62wj+hwbpKFUY2mwcSgBFFGWFEVwh/ki38wPI3ncc6tZTSo
         JY9N5FRWBGkGiKD3M3Jw31cd41NEEcT9ttWYEJrqad0jGstRLfADyhMtWr+zXbeVfUDe
         uuDZRlbZRuE2LBh+t7QfeNeO4Tu+OoLQZX0ZQ17Gyd4Bg+P4vaPI0YH9X/5s+PjnnWoo
         5ECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783950999; x=1784555799;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dThHBkWDs48b/2hz2YL35z2V9VnPq+MKY/40ZoZ5a/U=;
        b=EV0pkTf77igZujYu2OifzLAUSetuvNbYXYb1+Z4bVfAdPOG7KHA0MOJXu2w0gYnaeE
         THb/fptzjrCNaiJzTBhsPReo3iYWltamt3PTAn5GO/AUQYkneA7OuCqcykhYVnTOlMn1
         CwZfv9VLaD3fYmWe7w+tWA0gG6BVN4eSNoKXJ1GDR2Zmg4bKJOih4ke4biC9IgEF5WWX
         y7bxNDmLVRe9bAlpxNMDyzK7LeXxM43vpOVBZmulcD0PvTdjDC4yO9iSGSweehh7wMsS
         bcqO++LgwX833IU1J0CEQ4yu4un0XESlJk+NhffJGimYvWsgtEG8cnWMAFue/J5J3StM
         I8BA==
X-Forwarded-Encrypted: i=1; AHgh+RpP1WhF0BXptcOrlslR4kpIVPbwjQC7+sBsGpndxdrIXiHtNM5ryP5pPACE7I223ZS2hsZnDzSCq79+@vger.kernel.org
X-Gm-Message-State: AOJu0YxlPjTVE8LzxM82dCSCoDhOMrSICRav9b1IMuR98q/W43NJ7Xba
	d6VLaFGFc/AkJRNk2YVKrPujdHygy1QI8aY81YvbOb3KD6A5IZXPpIuGN2zbl2PM3cE=
X-Gm-Gg: AfdE7ckt8jQA4bVK2AhvLEvO+VCJsMQzzsyNzUj/NwhGeO6G42TIkFpRFrno/2hbglE
	8dwPJvRxhj5S4FLuk0BDFl2mzHZriynRrUSR1iM3r4eLfcGBOAEtkkx1NJgMCpDrrGdyXX6IaG2
	qV+UdoxNgb6+9B9/5/6A/pc2HMtYwAKZQ6WziVlnjWuELCTgrU+Qi0hO+cyUrFU35H5EBTUbejs
	i/9wTdXYMl0kuk5Zs6njvmER2qaPxf/oIpLsRxbtDsbkERjtIfGyGihPJzLn/vPcMfB7ttTC7M5
	G2y9ODK9qvb2/TCBRxt3XMJeymXeREqW9VNv6esa0BT+SurUA5tEurxHLfVY5w2HKEQ89F505pd
	n1RwO9NQ5YCo9HQmJP88w4Yfe/JX7F7k0AakbGNN9L76IH44aH2Nb+WiZPlG0
X-Received: by 2002:a05:6214:da9:b0:8ee:756a:f1d3 with SMTP id 6a1803df08f44-903ffc638e5mr98221496d6.28.1783950999687;
        Mon, 13 Jul 2026 06:56:39 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd81f4bbdsm126704796d6.36.2026.07.13.06.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:56:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjH9C-0000000DL9o-26N7;
	Mon, 13 Jul 2026 10:56:38 -0300
Date: Mon, 13 Jul 2026 10:56:38 -0300
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
Message-ID: <20260713135638.GB3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
 <ak42F240d-53QeFN@arm.com>
 <yq5apl0xgy89.fsf@kernel.org>
 <ak-CT3oanlDfgTy4@arm.com>
 <20260709181336.GM118978@ziepe.ca>
 <yq5ajyr3h106.fsf@kernel.org>
 <20260710161945.GO118978@ziepe.ca>
 <yq5atsq6hdaa.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5atsq6hdaa.fsf@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22126-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,samsung.com,kernel.org,resnulli.us,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,nvidia.com,outlook.com];
	FORGED_RECIPIENTS(0.00)[m:aneesh.kumar@kernel.org,m:catalin.marinas@arm.com,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:jiri@resnulli.us,m:smostafa@google.com,m:ptesarik@suse.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,m:jiri@nvidia.com,m:mhklinux@outlook.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[linux-s390@vger.kernel.org:query timed out];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6006E74C08B

On Sat, Jul 11, 2026 at 12:39:49AM +0530, Aneesh Kumar K.V wrote:

> > But if you really want to it should be
> > cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) *only* and get rid of the wrong
> > force_dma_unencrypted().
> >
> 
> Ok, I will update the changes to so we preserve the previous behaviour
> for SME?
> 
> 	if (attrs & DMA_ATTR_MMIO) {
> 		/*
> 		 * For host memory encryption treat MMIO memory as shared
> 		 */
> 		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
> 			attrs |= DMA_ATTR_CC_SHARED;
> 	}

I'm OK with this, with the expectation we should aim to remove it when
fixing the callers.

> > But IMHO, I'd rather this series treat ATTR_MMIO as private MMIO and
> > ATTR_MMIO|CC_SHARED as shared MMIO and that's the right and correct
> > thing for the DMA API.
> >
> 
> If you think the rest of the series is ready for upstream, could you
> please ack it so it can be picked up for the next merge window? I'll
> repost v8, rebased on top of the pKVM topic branch.

Yeah

Jason

