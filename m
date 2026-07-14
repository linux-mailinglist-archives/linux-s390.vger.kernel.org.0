Return-Path: <linux-s390+bounces-22227-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BbwmLKYrVmqS0gAAu9opvQ
	(envelope-from <linux-s390+bounces-22227-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 14:29:26 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCDC7548D2
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 14:29:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=boLAbqr0;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22227-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-22227-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C14C33035981
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 12:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDAB449EB7;
	Tue, 14 Jul 2026 12:26:48 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5C44839B
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 12:26:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032007; cv=none; b=D9shCbPbaVvWqYSwT4gJhRKKWHOs48WLCz3ocOpmJvq+Fg6g+av87QIQVnqhYeL1kjiWpKKv4zF8tGWl/f54MimhRcRV7ZUO4f/cIbW0JmoV0qUbd8uc3qY01UzHTdtaROhU/WGZe2fapCpMYGV/IfDeCj4wbzS0XYr89qI7Gcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032007; c=relaxed/simple;
	bh=EyC6N0xAwYeQ07+jukS70K/lUL1qxajRoHTimoin/A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooKvJkT8qXlhNMmKUlvagiBBWDcaKkKkNM4XfXrwGubkPUk/WU8mK4HSZBVVzrD8RXvdVwxHNonq1Zt529gU2vQWK4/Au7st/32O421+G9O0IMf6qC7YL83dnwx78w9Q75B+9KKcvgC0ZKaeL+YEPVFS1OLWxZz9AwYEl2qXrBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=boLAbqr0; arc=none smtp.client-ip=209.85.219.50
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f18d92172aso12773476d6.2
        for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 05:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784032000; x=1784636800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AuDF+BU2wT5tVoACVa1l/BwLN4UR/axOeynKCGX6Iio=;
        b=boLAbqr0JYcFO7/aj4gJCdrDNMNI7YjDhHvA4Jy05IWte2oWzKhvZXD/pMEOyTzIsm
         aG9nOna/0E/DaefTKfbe2kpuychVOjllXj4qrVvodD6MS/L2toK5GuQHXfhaFC3bsD1z
         DO6lSOtS85tz04ZHNIE3Bxj+42RItmWkrTIr9cp8usqVkjfiOxUcXoJmIVlvMT5oNLmt
         c+XgPgdGXQRlr+1X3gOj5ARBimvDjsuXSlBYzy80kfR9T1ACA7umHPEcYVlvFs7MSsOl
         R+OElYvnBteFGGp0BZn0RAbG/9oUfOEeOyRPjTPD3so9377gTzeoEQdpnIUmmAPVDwqy
         XQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784032000; x=1784636800;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AuDF+BU2wT5tVoACVa1l/BwLN4UR/axOeynKCGX6Iio=;
        b=NwQmsGirTW58hKzB7ogZTdpve6yRc4jxNXQ4aiU6whHISx7fGzlSaPq6ndC0PwPc5R
         g6VHw8sDllbXXYlhNQidu1sM8mAs4hjbHw6Y2QiKhHySmKtIu6CBNA0Xo0lKSXE5jDPo
         ZATEU/sAhXWVS4UpkM+MlfIRrqpJ0u0H2nELT087zO14QpFp0jFXESV9c24Rg8o1ZqUr
         mw/lMArdBZeGwWRvNf/TprmOWMqIZNs7Yndi7UgtMNlyIAN/iER4C0c2wSj8NzxyCC9c
         zgY8Gwn7AdBE9bUJBUWxOVcYudZVcW4AQdFJkBn6JD6BUoprMqi6G8oLCmGTADSWB/fi
         SSug==
X-Forwarded-Encrypted: i=1; AHgh+RqWZ/koDyOeYr9LqJX572spH9mmBHO49QC10ic6ZRfz/mKRP8SobECVsPTsk0LDTZYLjC/Iws7flwuJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzCK+xo45A6y21Ist0x3wxFyGdJMHQyHWbCHgsoViBG8ebYoXLw
	5wxrypsoDJ6lHZd0We5wPojQG1YyxTrOBEqzwFDmulOIIceWAsqVXHVDGAaRi1xiYLM=
X-Gm-Gg: AfdE7ckLXuC0y5Vv+931AqeHij5qTrzqrCFd5DWbeSMN/P++p6KgqEVv5lqEuaFX62L
	vaX+aAhI+P4Wywb+AvgGvTBu/SqR66ypF19V1fYWsbnHoZY5FdGISHx3qDomlmjH6UZupm8Gy21
	qrgjq/E92a4/yZOB8wEF4vBC29o/JRd2iHvFuB5mf02mtHES0jTqdEepr0MKLLhOEVBMJ/E9MBZ
	eA/sXthKpUATOilFS1YD1vjrRuV0IaOF3Yp26aCu9mLYvq6i8jfh8gH81PFTe0IPfS8cfBD6oI2
	1EY/2QiT5ocKSCtdjUJxrUwWSbcHjlbK6wBdBPAaMuVO3eJpxZSgaDlfaRcLWidTHbynZkMXTRF
	8jm4dq9qALaxtWmhhWFrPzYlq5LDWxIbWDfdNdcGZ9O/XjLcLvhG4SakAdA0u
X-Received: by 2002:a05:6214:1cc6:b0:8e9:f5de:d629 with SMTP id 6a1803df08f44-9040423dcecmr141353846d6.56.1784032000167;
        Tue, 14 Jul 2026 05:26:40 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1ec84sm168106996d6.29.2026.07.14.05.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:26:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjcDf-0000000FRvu-0Ugk;
	Tue, 14 Jul 2026 09:26:39 -0300
Date: Tue, 14 Jul 2026 09:26:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 11/22] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260714122639.GH3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-12-aneesh.kumar@kernel.org>
 <20260713184810.GM3133966@ziepe.ca>
 <yq5aqzl6mc00.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aqzl6mc00.fsf@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22227-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:aneesh.kumar@kernel.org,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:smostafa@google.com,m:ptesarik@suse.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,m:jiri@nvidia.com,m:mhklinux@outlook.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[lists.linux.dev,lists.infradead.org,vger.kernel.org,arm.com,samsung.com,kernel.org,resnulli.us,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,nvidia.com,outlook.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4DCDC7548D2

On Tue, Jul 14, 2026 at 09:57:43AM +0530, Aneesh Kumar K.V wrote:
> >
> > But I don't view this as that important, the CC hypervisor is probably
> > going to use the S2 page table to force cachable on all system memory
> > so the non-cached pgprot is a NOP, but the extra vmap is wasteful and
> > it is confusing.. So maybe a little fixme is all that is needed here.
> >
> 
> Something like?

Yeah

Jason

