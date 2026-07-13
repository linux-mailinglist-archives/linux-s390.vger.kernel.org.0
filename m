Return-Path: <linux-s390+bounces-22191-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KuMJB/8/VWpVmAAAu9opvQ
	(envelope-from <linux-s390+bounces-22191-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 21:43:59 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F7174ED7F
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 21:43:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=h19Ux+5R;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22191-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22191-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31FAE30429B7
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 19:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF1F359A6B;
	Mon, 13 Jul 2026 19:41:35 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6C5357D12
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 19:41:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971695; cv=none; b=IUSb9deLs0xeFGNqfJf0pYRA6wfDEkn+GJpwcusc2ghExBmlWmSLiN+EaHHSTgE3va4QwH4e6zGSa87V2uhvqBVssHaaT9ALrzWyysILpPmifutkX2DDhjbGWtc+v318s4lZoHKHtmmUxd1S0qP1+nUkdDHVmUL6jmYXZzGPeBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971695; c=relaxed/simple;
	bh=B2Rb2Qu3H6K9h4z3M1wOOTBejPY5tvykheBX1AXjDsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8iHL1xFfay0CT79sMOrSxfG5ECYZqizJwmvTN32nmmFiTCKoxYSI/8ej+iI9LAwNHFJCQ3eOTowT6Rib+EsF3R5lgx58vOri1gtNHgX1N00bcmGAoVHvHfUN9em4a2Mn8XisLP97qL54PD+nUo1DRbO5buMiL1jGYJiQsdbj9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=h19Ux+5R; arc=none smtp.client-ip=209.85.160.178
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c29b46382so23068211cf.3
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971693; x=1784576493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RaFiCRG6TDd5hbIwyaOKkhGT65gZ81YsG2fbaxJfaHI=;
        b=h19Ux+5RrIt2Qj37Ey0Ugc8JC3GtEyjgueBFjgbu1ab57PiPF016jCyccKLgUITV5L
         yaOWYx1pB+y76f9O3vSw/VFXyBbrRXiOLnyoGtDOe1QUqUChHHJwxQKxFujCa4OZMrON
         sgwbwCC2Y52Z5VHMQnGY2+Q2RWfIu9G71LUIctHzyYuMoGMuXZpI0bEmN5jvoD2XuKDq
         UDYx2BgVFFJC7Q1XwlLgvZprnu/vfsAjp/2FDQlg3I2SNYZiSEJHhuNIG80I0NqItGbT
         CPDd05RlVlHU14ySmBtCwUlDjhphdwgr/BaiB04YDvIpbhmVrcHRlNW+un4hSyqoBS9a
         MQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971693; x=1784576493;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RaFiCRG6TDd5hbIwyaOKkhGT65gZ81YsG2fbaxJfaHI=;
        b=sklDQB+N4K//1OpSLn7mEqqFUvuxaC4+AeAqZvC9wT44ZJHWZHKpLhMJCSshOzYfZT
         +O37dwdBGrWxlYDxCL3NXfJeUdcqocmGmufmR4pOw0o/ityqaN2g7qdZOVVAnQx1PYop
         QgPScU0kJ80rowRqlllcbeAff+SBaXeUqJ0GBpmWABs2cMJhhAMjvvR87j/vW1YrTHrz
         9Jz8gcmm5RjpO2Ciu1VKSKN6n+KR2Cfe9rsGXIf9Kb+4hAS7p8Go3UWXXStl1kmxu4XQ
         ZWJ0Xxu/dWqBQNRrqLlmSlz50O0RBb9RlxEcUD+rHtJs3G+Gv25bBd4+cL+kIoFMBzoe
         Q8Iw==
X-Forwarded-Encrypted: i=1; AHgh+RrRLZIRVXqwuA5Xpp/xSc6stC1xgcEzS1Y/75CA7a3xmucvY575WK9IzgrG17co9o4eddY4Aib+FegO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7cMQ/Jo2UYKfrJs0ymD5+Qt/ewpZgWSwkKfn4vzr3O5D6Vgsl
	tzSqxn59nhJEosPSiWh4WRVIptzsznunS4VMXxuzITt7HsMM9kXjHkhjYh9wLbcbeww=
X-Gm-Gg: AfdE7cmt/xOXHKi3/VJ1aBsIeVuD8cytUrfM9rxCZpMCF5oOROlsLgg4eQzCn7SEO8f
	Gc+s39qO/Q0dE21c+qLkqXZtsNr1bYm2+9CNHNwaqVD/GT0bbHLYXUKxewwNkQA81twlbt6Q5wc
	vZjOOpMcCLCgi5I+V8LzA3Y2GhGHXq59508jaPA5Ojt01rtZaiMxtIY+/ezpKqqCwcJMZL/QmMr
	hoVj/QAoOp3cFQtnH5zCA+oTPjV29H04+asI0lb8AZwExggyKAnAnT6N2vX0fLAjboLS5OiAawp
	vXxROPMxD6iXEk8BravaTM9TmLY5K0iUYIqCY5ml6wtPQL5Z0apBYIFfBE12S3Jo8goj/+MxiZZ
	3F6IWFSDZg6oY6OZLcROtb8dQfDbqW0YzyTVAmOxaixgweyjn4AASpKGjCvUn
X-Received: by 2002:ac8:5fcf:0:b0:517:8711:d46c with SMTP id d75a77b69052e-51cbf0f3fa9mr100726891cf.31.1783971692761;
        Mon, 13 Jul 2026 12:41:32 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caafd8b44sm90213801cf.30.2026.07.13.12.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:41:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMWx-0000000E6nC-2kaU;
	Mon, 13 Jul 2026 16:41:31 -0300
Date: Mon, 13 Jul 2026 16:41:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 20/22] dma: swiotlb: free dynamic pools from process
 context
Message-ID: <20260713194131.GZ3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-21-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-21-aneesh.kumar@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22191-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:aneesh.kumar@kernel.org,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:smostafa@google.com,m:ptesarik@suse.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[lists.linux.dev,lists.infradead.org,vger.kernel.org,arm.com,samsung.com,kernel.org,resnulli.us,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73F7174ED7F

On Wed, Jul 01, 2026 at 11:19:24AM +0530, Aneesh Kumar K.V (Arm) wrote:

> @@ -840,7 +843,7 @@ static void swiotlb_del_pool(struct device *dev, struct io_tlb_pool *pool)
>  	list_del_rcu(&pool->node);
>  	spin_unlock_irqrestore(&dev->dma_io_tlb_lock, flags);
>  
> -	call_rcu(&pool->rcu, swiotlb_dyn_free);
> +	swiotlb_schedule_dyn_free(pool);

This knows if the pool has cc_shared memory in it since there is now a
flag tracking that? So should the work queue version be conditional on
that flag?

Jason

