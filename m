Return-Path: <linux-s390+bounces-21044-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0GBaASUwNWokoQYAu9opvQ
	(envelope-from <linux-s390+bounces-21044-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 14:03:49 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6446A596F
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 14:03:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=JnlQZhcP;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21044-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21044-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87C203047068
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 12:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B4F380FFD;
	Fri, 19 Jun 2026 12:03:16 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286A382374
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 12:03:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781870595; cv=none; b=bjbp+eYRWBzARkB56Zh/98RxNCOc75WrX7RfpmvpUDMK1bQvQO4J+9o4lGAfK2jzjkSfWn9GSGdlPrhrtNZ4k4djeMiSQkHf3FUfXeu4YM2s67wV8wPKgTYJgPBmWn4ZgMVYtRFHEQVJCnEsMeutWFICZzYPBj1aLSrT1j/lIko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781870595; c=relaxed/simple;
	bh=3CfcX4Be+5vi/NadGQc4bvpp+jHS4/eMDxItDtd8Qqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhcBSICwWXZH6XNuzU7MlKmeJ1B2zgIK4Xxtmjwa43lS4vmKLoW2lRGfsmPWxSDPEnS5NWrCBrwZ8svv1v9HYPI6tFld1Wcob+CXiGjgo3lcexZtZ0igbdnEcoe4Eeu80Rdr2xHyx+4+D4SPvYxUsG0ELltfBGLmv2J0Y8X3Yaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JnlQZhcP; arc=none smtp.client-ip=209.85.222.47
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-96392241154so1452715241.1
        for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 05:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781870592; x=1782475392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=StlCUTUicQISJ/bWwbWkmSHhXapLgWFJJHXk0oHb5Ig=;
        b=JnlQZhcPrcDdl8wovnnDNFgGkBfvKrpgM5Tu/1/BgThOeV8hEWrO8YrtMEJ4IkeBux
         7ng0/iFTUZkiqY2gHWWZY7bpw14zb78QfZ6Duu1xWoIcXwmXTE1Zvx3ZK1sISNI1yBW9
         F9nntBptCmnqsOeZCOD7wYSy/61y47zDZqQrAn+Di/a0hn8a7RPiWQC1iA0bLWMc+YN2
         a09dnNGeo6qJ7Q8OJbyFLc83Wxo84P0HLTZkAR2U+8NBD3XBYyblBI6XrAUiVmR8b5Io
         GXWb1poJ36LlkHhoehnX1bMa4dB/QcXL50Mohr/u2h8i5Uq0MCIpT+MhLh42EBK8cnyK
         1Phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781870592; x=1782475392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StlCUTUicQISJ/bWwbWkmSHhXapLgWFJJHXk0oHb5Ig=;
        b=jm+K3d95/4Qe+xdUbnsDDed2LOaVZkGyDEqKgX0YgBACqRKO3L9IbStqA+CdOEE5JC
         rW0l7n9LziVphwIfzTXXdxy/Ej4LzM/WbKbfBi9+bZgoYkjySUhQK2V9l4FoBLtzDj4W
         pt9ZouIe+E60ZV964b6ni+sgUAtNHfUty9+Iw8JWm1yUgD2IGKrUOD0yKH53uOHJfi7r
         f91oB+x+QbjlQDOkUk5xrXWV9OOFuyQcwDkCcPd8YIP8TOOWeXtrMd/Q7ZEr5N2lRRju
         E05j60EheUJAjQXSrt12Rfp6SuVBJ4iA+xXGJXX8Gt+SwYa3/OauHdDRq/DC6asYNNXL
         RYLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CA2XMf8g/UcwZvX5vUnKXz+xM3ftFlSsDDSgkwbe3eTSByrBKbhxUl1ntGFyLufZMlRJKo7cI+q1w@vger.kernel.org
X-Gm-Message-State: AOJu0YwWRRQfOXaxQAuS+d3QJqus/m2jkYgPiwX/GfcuFhu+GKbhKDFD
	q9oNcwvOZaTAHBxLv6zLqpn8/30+4J1O4y0V+EZGFXZrXarCcLyuEzoCZmfZdpg3q44=
X-Gm-Gg: AfdE7cmBOx0JLECotWs5HTajR7Zsba5EcVl7yW9WbiF3mEwNSue0lTvJwH11Tpu1Nh8
	LPqVhl+WI0IZ2b+B3HyM9DiTEuskASp20tP37iA/DMXgElX+ZXxsZ7rI4MSptJ70qWAsXVV9oUa
	qZbIVE61wJqDaQXVluVDedtgaQ6q2g2PlSGvTI7FJe1pLQEB1pN2DsBmgUQ34QV1wuuRHAVNjb/
	j2li4+ow/Z4XJNb4ZNlnLS5i/2CWtGllzcuDPaJlJzPzrSpRDefJexOpFApr20gpkR0VxeXTS0j
	ezGwijKVE5qBdBnx15FMLqSTONPT8krNSCBFyenfMEnKuiuGui9jypoiBcGE1i6NxGyij2BC/y5
	kkczix3SZaIyRfvHtetQ5ttUd2vZWo0bJQee0y5amorubdrxp0H9yBwMwsbr9NCwkn02kF+H6tB
	J5vXMKC/h/UHxJV9bKP57ITUzFgYn/Cl/7sMxyFskIDDZYBuF7/HBk90vap/OSu6mMq8aT+PC8H
	EldVA==
X-Received: by 2002:a05:6102:c89:b0:729:213f:76ca with SMTP id ada2fe7eead31-72a20215eaamr1999509137.29.1781870591985;
        Fri, 19 Jun 2026 05:03:11 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a424f817sm215731985a.22.2026.06.19.05.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 05:03:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1waXwD-00000004SQK-4AfU;
	Fri, 19 Jun 2026 09:03:09 -0300
Date: Fri, 19 Jun 2026 09:03:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
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
Message-ID: <20260619120309.GI231643@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com>
 <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
 <d4ef9a9f-18d9-40e1-9d02-87aeb9cb6540@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4ef9a9f-18d9-40e1-9d02-87aeb9cb6540@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,samsung.com,resnulli.us,google.com,suse.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com];
	TAGGED_FROM(0.00)[bounces-21044-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:aik@amd.com,m:aneesh.kumar@kernel.org,m:catalin.marinas@arm.com,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:jiri@resnulli.us,m:smostafa@google.com,m:ptesarik@suse.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B6446A596F

On Fri, Jun 19, 2026 at 12:05:45PM +1000, Alexey Kardashevskiy wrote:

> > > > > IMHO that's an AMD issue, not with the design of this series..
> > > > > 
> > > > > The series is right, a device that is !force_dma_decrypted() must be
> > > > > considerd to be a trusted device and we must never place any DMA
> > > > > mappings for a trusted device into shared memory.
> > > > 
> > > > swiotlb=force forces swiotlb, not decryption.
> > 
> > If force_dma_decrypted() == true then swiotlb must allocate from a
> > decrypted memory pool. It is right there in the name!
> > 
> > The hypervisor environment should *never* set force_dma_decrypted()
> > because all devices can access all hypervisor memory, up to their IOVA
> > limits.
> 
> True. But we do not have encrypted swiotlb pool today, right?

"encrypted" is just normal struct page memory, that's the default for
swiotlb.

I think it was a big mistake for the AMD SME stuff to overload the
decrypted/encrypted CC stuff which should mean shared/private in a
guest context to also mean things about physical memory encryption in
the host. It is really confusing.

The SME side is just a bad arch choice, the real world doesn't work
well if you set high address bits in your dma_addr_t. I think AMD
needs to use those restricted swiotlb pool where it allocates this
very special "SME Disabled" memory that will have a low
dma_addr_t. Then alloc and bouncing will get memory with a suitable
dma_addr_t. This has nothing to do with force_dma_unencrypted() which
is only a CC guest concept and nothing else in the OS should ever
touch decrypted memory.

> > And this is more insane logic. The right fix is to allocate the
> > swiotlb bounce from the *encrypted* pools when running on the
> > hypervisor which requires undoing this abuse of force_dma_decrypted().
> 
> +1.
> 
> But how does the kernel decide if it is this swiotlb pool or just
> some page which happens to be below the IOVA limit?

You mean in swiotlb_tbl_unmap_single() ? It checks the address against
the pool's range?

> swiotlb can be for bouncing (with all these dma_sync_single_for_cpu)
> or, if dev->dma_io_tlb_mem->for_alloc = true, for coherent
> allocation (no need in dma_sync_single_for_cpu).
> 
> I am looking for a way to set up my "sev-guest" device such as when

Whats a "sev-guest" device?

> dma_alloc_attrs(snp_dev->dev,...) happens, it allocates a page from
> the shared swiotlb pool (with no actual bouncing) and there is no
> obvious way to trick the DMA layer into doing that.

Why do you need this?

Jason

