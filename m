Return-Path: <linux-s390+bounces-22183-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A/oaGDg7VWoKlwAAu9opvQ
	(envelope-from <linux-s390+bounces-22183-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 21:23:36 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC02B74EB0A
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 21:23:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b="k2ZC/jy6";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22183-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22183-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7A0330D0BBA
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 19:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD7A353A7E;
	Mon, 13 Jul 2026 19:22:38 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A5D353A92
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 19:22:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783970558; cv=none; b=DTysHGowHpHTKyFexl18bftwqhTKNHegGTRHnNyae3WMOio3Pri6sVW1eNgpwkpZUEJwbYhFOSf4xXQgHAF45EuzrHSNFmRIs8tI4QT6s4IPP4b2pdO4i59H2VfOB7/AOOOCbWPT2aqJcGEJIMFPUCDIQmqcBbIOQFAU425EdJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783970558; c=relaxed/simple;
	bh=KcyjZz0/U3mbq57knc0VdAahTqdco+ieDuECz56azZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBNnKMdyHP5yEscmarwaIGY/xe3Cb8SQU/X0dhwyFG6at27aNOBOxTfxcVqv+euTlcT/ympfakQQomjGeJsqE8FUDPM3xsbYVx1GZ5zkbUhxOVFcEYURgM+eCN+Wcws1gryhWIRSq1sEs05OOiaQFh98D+nf2/+qYwowUQ3Rkfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=k2ZC/jy6; arc=none smtp.client-ip=209.85.219.54
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ee88fce572so2383286d6.1
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783970555; x=1784575355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rTUChJSUQ7qBnpi6xNUNbqkdyOGkeoHtaVMHI6/gjvI=;
        b=k2ZC/jy65UQBjn2FY3oHQ+DKZpR6PJbh5QF3zE/KrPXjdEkxaICG+ewycrxnV4Q2vb
         6E2n1T/S+buWNMK1A+ci0MuVP8goFT6TVkeK59m1RgtpVThFBwaDr1wyt1j2iRYuqJCm
         XFnKjdBqopfxiRY4FE3ZNUxfCmapAbhClc1OrZz7OP9Qw0mHngs+u6dSvfZ08eTzvN7h
         maTzVVk95EcYWijs1tOUpErVSNlWdqKKXXvzJJ2vA0iZngUe/QpxfMvzvHvc/4hAicvb
         6hnCxHhyGv4dSc7huPCBsInsujHwi5ZYXyar79BOOdprS+xRyIyHMJslrjuQusAF5IpC
         OD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970555; x=1784575355;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rTUChJSUQ7qBnpi6xNUNbqkdyOGkeoHtaVMHI6/gjvI=;
        b=rzh0wG9IGvov8eznpIqcgeVz6nv+K1ka+VrmexFNtzd81yLbwxJbFHT0AU//aa5FmQ
         0z7RpyIVW/V2ru/8Y3c+jDHaCCEt67KJ4PaQSqk77v8O38Vvh1IWzK5HfjE2YUnws/wk
         zja1OUo6gL0Z71TIzyMhPd27fWcQ/duoaNdjE2QzAc94hIlJnr2hwYxdob2/aunN0jpC
         X05RwSS9ApLv5LgPj2WSeSKGZ1a7jF8NGVbcroOnyq+XRiELOWqRjKt1ZOom6ziuB6X/
         VneaOBgd+LYydyaO0xJaQKtfsr52L5XqPHcuvd5KJaVn/eP57mQ5+h59217ZmVSdyDup
         iB8Q==
X-Forwarded-Encrypted: i=1; AHgh+RpiEO+QKYbIJpwvXjK5EhR3IxLmYaZ3UKrOmyWmylB5u29a6hjQEe/YbUr0xNdijlILgocQH6mlBcNL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw08oP4HCfFQsQHJxrwYL+GtLkvdIZzWBFp51Muo+vzf0a1crNa
	L0TANsMvY4fXhqCejRxrBfmFtZ2rszle1vZ90KxKkcABu0t9qCdFQZePa9qlnZ34WQQ=
X-Gm-Gg: AfdE7cln3jsEVPD0vR0APtSmbcK3B/MzS75DH/NdPcHylnCmn/UWlIniRRdqV1oAc2P
	ZluQ8rB1BX8GFN0eLfVM9GdwJJVcUaJIZ9Eg4lcz/SVop+pDrb7KjfDGRdpuxbV5eyHjT1fk282
	/m3H1xg0SRJ0DPVzxg1XLzhhcQtXwoAZeEcBBer+GCetfStxedgR7T3BszCTwXxKECkyPpTEQpk
	OSRHvegZEpyFJp0RKBP7dL5C8UzpXOKpS/AHheS/KmMMXvy9SJOT+Ve6i6O7a41EerPe/33VB+l
	yGO3Wye3gFVduypVJ5ifKOp1ZqaYGhxCQouqO9uZS6MI38hAcK+6ryPsj7svGovtDMx+oCt8svY
	AAsn0B5ZRKrNcFyYfiOequ01vUHAx8+O78+SCUgS02IhFtuTnj0EzSZ6mERj1/Je3Pf3uinA=
X-Received: by 2002:ad4:5caf:0:b0:8f1:2607:ad86 with SMTP id 6a1803df08f44-90400b8b562mr134619656d6.4.1783970554874;
        Mon, 13 Jul 2026 12:22:34 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50df5e2sm138736336d6.4.2026.07.13.12.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:22:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMEb-0000000E54I-3Zkq;
	Mon, 13 Jul 2026 16:22:33 -0300
Date: Mon, 13 Jul 2026 16:22:33 -0300
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
Subject: Re: [PATCH v7 12/22] dma: swiotlb: pass mapping attributes by
 reference
Message-ID: <20260713192233.GR3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-13-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-13-aneesh.kumar@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22183-lists,linux-s390=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,outlook.com:email,vger.kernel.org:from_smtp,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC02B74EB0A

On Wed, Jul 01, 2026 at 11:19:16AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Change swiotlb_tbl_map_single() to take the DMA mapping attributes by
> reference and update the direct callers accordingly.
> 
> This is a preparatory change for a follow-up patch which updates the
> attributes based on the selected swiotlb pool. Keeping the signature change
> separate makes the follow-up patch easier to review.
> 
> No functional change in this patch.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/dma-iommu.c | 2 +-
>  drivers/xen/swiotlb-xen.c | 2 +-
>  include/linux/swiotlb.h   | 2 +-
>  kernel/dma/swiotlb.c      | 6 +++---
>  4 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

