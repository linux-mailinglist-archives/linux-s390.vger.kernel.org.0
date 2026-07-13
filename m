Return-Path: <linux-s390+bounces-22192-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ze2pFo5AVWprmAAAu9opvQ
	(envelope-from <linux-s390+bounces-22192-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 21:46:22 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADEA74EDBC
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 21:46:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b="K/qvTTqN";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22192-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22192-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C2C630A0948
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 19:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D5D359A6D;
	Mon, 13 Jul 2026 19:42:20 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926E357D19
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 19:42:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971740; cv=none; b=lk+q+Ox20qLkAZobQRw2c3pXWG7JXFLuo4zZV5+Akotm0MDkaI9uskw48MvGjfdz5Honm86TfXfjoTZXHMxgkKFfWuWvUYdmitzgiKgK5aP/g2eIg3FBr0isTjLs2OMNpZzHqaBkIs8+QXCGiL6vKN69QUDDpvd68K99j2ZhF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971740; c=relaxed/simple;
	bh=5d6Bc8gkCbSlPfvzi0E/608dMWlnVz1C1iUyYSF7w/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVzcQTOqeOSwNsUeN1sU4nQHYEAtAlx4WHFhKmjqqounHrk2tlfUhLjJpvUDSpZ7+87jbTr1g2Ev21BXgB8Myu6mDM2uuccWDfKXjPjYLiGfmiqdJ82YIcxjZQ5m7vocb9JqXPnJktl0Z81LSS43fDCKmSQvlCnIGvB7nqfOH1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K/qvTTqN; arc=none smtp.client-ip=209.85.222.170
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e85499ffbso21175685a.0
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971738; x=1784576538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q5KluJxuBWim2YOI+gCMldEdZU/bLOQ3tr992AX6OwE=;
        b=K/qvTTqNV9qxStEIt2GJD2Wf6/0r0z9sW9cWUCgNW5gGeAQjbbXSrxxu2Bx2DFxfT8
         DGllO8QzGEousqgXPH65cd9le50bm6uPxlOQgnizfBly/QgnH187G5C1rOdBO830NO7o
         kPTactL8NC/UHK8nW0KOwy+LacaUHWUS0kbL21Eg+BJEyUwpn1tMc9Ge1UWxAX4I8ozi
         hDhOei25p6uEqJci904/XXhjkzbdy+WK7mUmW1biWG8gRrnNYrkRL2YuCjt3rG4Ratvx
         oO8pfQ5H+zLvfeMnJKiXToUjB3PBoLjxEcSIOiAMortJfIDYvnOeQ/BGWyXHS4A0lpcE
         3hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971738; x=1784576538;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5KluJxuBWim2YOI+gCMldEdZU/bLOQ3tr992AX6OwE=;
        b=fXApNf+iW9lwoT1rU4h3Ps4xkyMrk8+At/+aBFNwnwPg7ro6aYMn5e08vn1uSEVrZ6
         DcnpLlkeJIMkg/8pipd8EvEODsbSadvjV6fh+N5xYiHRxdn6owdcBcc4rjjNDls+2bx+
         VoOn2FsjOYppI2gwm2gCTGaEXBvKYGH49siKB3Uf5M7T1MvGfYaz4pRCA7i1D82D3RPQ
         /GHWy0qqdBqTn1BLTScvYckxsMIlE1Z1rR7hAcR67qhxSankaCR87nyZd8dGOp4FpZIz
         aLZsWcYXUPV8OzT31NBOTq0uuWx+liN/naJsKk9CS+9hKy41T/Znr3RrnSJGpRJXTWPq
         WtLg==
X-Forwarded-Encrypted: i=1; AHgh+RorF68lTkYLERVema0uHX1Hq1J9pq+1XjiBVBWkbwoU0WsLpBu/QYVcNsebFWuwtOK5n+rV8diLZQcE@vger.kernel.org
X-Gm-Message-State: AOJu0YzwE9uyL6JfXe/0dFgIIAeZZ72cAnR2Lz9EID6nBp4pbKiwyJAL
	VYiGI4owtj5w3ACmW2SMVziTaLmtZL6oeVz0qKEUuG/gJTIsdxoUPk0TY3bQAy741Uk=
X-Gm-Gg: AfdE7clOIC5pLGN1L44IUTajJazRDO148NlIQ2qDjKgRSf0R5EtJHjiFisxa9fdEwRr
	MkNHo5jZ5XgHhFxKP6IS5XzEpZz77NiwEklfmQJbaG5U62MN9v9BHJu1ocATT5++id3BBJBZvtd
	fobCyYAem40tH+609QlRklqE2qSee5iJgVGlHJyc13lL64mhdkLhrxmVrepewAaULyHFcPCaPjw
	51iNHczVshHCUKdVwkdrsheNhkXrMzy30iAQQlcesqGRh+GphEdox1v9YP+cuqJBkfwOUrUHxga
	tbkadnnd/DjefkzIFnguCJzfNq816KSOGdjqtPrjBhFpXb9MGsOjtHS9ayZZenMUm2Pbm+z3XZp
	0W+o4v3tkbtn75aK1WV4PS6tCtOzDY8xLwIL+8nYIbgqdJtyDvu1Lb9/Lk832
X-Received: by 2002:a05:620a:262a:b0:92b:d4e3:1f08 with SMTP id af79cd13be357-92ef2bcc2e9mr1042196885a.55.1783971738155;
        Mon, 13 Jul 2026 12:42:18 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d37540sm1154048285a.38.2026.07.13.12.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:42:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMXh-0000000E6o6-0etu;
	Mon, 13 Jul 2026 16:42:17 -0300
Date: Mon, 13 Jul 2026 16:42:17 -0300
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
Subject: Re: [PATCH v7 21/22] dma: swiotlb: handle set_memory_decrypted()
 failures
Message-ID: <20260713194217.GA3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-22-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-22-aneesh.kumar@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22192-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,vger.kernel.org:from_smtp,suse.com:email,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9ADEA74EDBC

On Wed, Jul 01, 2026 at 11:19:25AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Check the return value when converting swiotlb pools between encrypted and
> decrypted mappings. If the default pool cannot be decrypted after early
> initialization, mark the pool fully used so it cannot satisfy future bounce
> allocations.
> 
> For late initialization, return the `set_memory_decrypted()` failure. For
> restricted DMA pools, fail device initialization if the reserved pool
> cannot be decrypted.
> 
> This prevents swiotlb from using pools whose encryption attributes do not
> match their metadata, and avoids returning pages with uncertain encryption
> state back to the allocator.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 80 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 65 insertions(+), 15 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

