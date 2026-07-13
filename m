Return-Path: <linux-s390+bounces-22185-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uwCdBws8VWpAlwAAu9opvQ
	(envelope-from <linux-s390+bounces-22185-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 21:27:07 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 664BB74EB52
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 21:27:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=M0pyKfyd;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22185-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-22185-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 107A430A2990
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 19:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2F0356757;
	Mon, 13 Jul 2026 19:26:34 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ED3356771
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 19:26:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783970794; cv=none; b=hpslR1P6qN3NIy5PsEObC05duPRx4oFDCf7/rI3oh1T7LcfITE7jEThQzkOYnxCyVvX5DCPSnpaHBHYujkulGrlNIGMRGHs0lIPZ+YBOZspms3d/DTzLbEZEbMe+1iDbmrMspTUFvWthvNjujM0pSNy2NXdonWd7Fkxsi1BliIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783970794; c=relaxed/simple;
	bh=3hYUesku0XYcq9M5Lzu0X2CUae3t5wbu+UMwDadhKgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHqytL6VZm7rTHpsYJ3oR4EwWEMvPoQJ7j04X3mD9WZj+u7WeC9PlU+CjJGuzpeT7ZAgNCaRMZOfY7VlkXga+wDR/KzcoAAdHhsv1+BPFCn57arZ7tAIIyoeJouGqb1bapmWwveQZMMVj/JfrailxY3+eAl63yEHo7mMc2fKjI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=M0pyKfyd; arc=none smtp.client-ip=209.85.160.174
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c167c58f2so23313191cf.0
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783970792; x=1784575592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WcYJlt5p9Qz8AXWYIObijachKEBwhFuSBSepR8dnD2g=;
        b=M0pyKfydb9XHMjRbiMmXPvPXbvEChos6qwAjT0J6vo/6oq3+cGQmn6VVEhr0o3Tf5R
         FIyCFjURk0t2kVTuSePz761X5id5lsq8C5ef+fYb48DS3Eo6StWtFC49SCds8UtGJxKG
         KRemr6zGNHeYk0aDcgIttFxeZLXaF/y6I4QLPXTcxP5aC8FCrjk9MVe34iHL5V8ZMfEH
         dKULx/kWe0+VO1ZeMHLS7Me/bW7/hVu6LX7S+baNAwkI0tGRAZVvKqbHTiDWsl5hwLgx
         G0DKGc7IPRBLKDPMuY4tKWHCvJ6fN+V7V02NoNz8vmVzH1r2ntsxCzpjTdBlRXlT6K10
         niuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970792; x=1784575592;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WcYJlt5p9Qz8AXWYIObijachKEBwhFuSBSepR8dnD2g=;
        b=n3t/+MM/V0c8pJRolsESMTo8Ke89nm/2GCISi8RSqpiDEQGMUTBGykQjc3NizWRzhE
         dpB3GSqcR3JG3b0fK3BBBnLQLwKOaNr+9OPgiY4svNSk5jI5gYXo3Kv+JR4UV0kbaNdu
         o59ikh62A2hVJSM2pXoQYSmkq81SMkNtT8Tx/Gpzv6U5hW3391ej2di3LhFwy4wU4CK8
         b0Oluc64UOSO2LFFwBxfIbJrQC6ACYaGi23OKqA8UsflIOTK+9ZFI9hbvYXTNnGGJjMh
         5F5fR1rnfCtjBOfQ1u2zkhowKr+hn9Lgk/3RFMweWAlKjBSJKM/oCiVbQVhHbtyuRaAB
         caTQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbXBem/JpohBUanJjC+ogwEA1nERxmDpDtWW2JfUyjW+r9HsXcXZCldp/7zYU0ztTPbadqvIxIIIty@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ5EHMB8fecCz7buWmYOsqvL/zZBvo5alL4SHW1RyaZXrbmiFV
	zENV7O8FKQAJYGhCbgNjMzkgLQPwCAvRFzatTIVtQ84b9HpADhXx1IOWuMbCyveqLqk=
X-Gm-Gg: AfdE7clzmWQcO8B/uWSaoLbH48u4wv+ckZjqohh033f8/qWM0Zq4t7prG/pyHjjpFxF
	LRYg8wrizaLPsoVQtMLhdTLvhXRLfJo6SE+UymYsBfGK/Gu/8ZKV9VlzFWFRJVWChOfi4z37o0t
	ndGd5H4W3Nj7BHTkObYPaKZ8C0V48MzSOOydZc6JNvmEuIBPjUw1N7qD9oLANc/2NlFQ3s7iF5r
	fKnTuW3dHBd6UDleEH/JJBixMB2n5+abfcivRi+GFH4qFp64uxwL3uyaf3HaXijNPILHF/1a2CZ
	xO+yP+bkfOsW9fR+rvO+AnA0VSuYvfbIqvG/Fb7Z13YB2yYAGqNQk4gcxwY2nMlI10F3VeA7cDY
	nRATnUEspzTs/TU8GKZ76x6l6Rkm3bzsbbJJ6hMnAnM8MSpDyjJd6m/YbqUm6RZ2lTzyjkeE=
X-Received: by 2002:ac8:5906:0:b0:51c:83ee:e430 with SMTP id d75a77b69052e-51cbf27d077mr95594101cf.75.1783970792197;
        Mon, 13 Jul 2026 12:26:32 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51cbd8efab4sm70831241cf.1.2026.07.13.12.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:26:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMIR-0000000E5Pw-0MTy;
	Mon, 13 Jul 2026 16:26:31 -0300
Date: Mon, 13 Jul 2026 16:26:31 -0300
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
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 14/22] dma-mapping: make dma_pgprot() honor
 __DMA_ATTR_ALLOC_CC_SHARED
Message-ID: <20260713192631.GT3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-15-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-15-aneesh.kumar@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22185-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,vger.kernel.org:from_smtp,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 664BB74EB52

On Wed, Jul 01, 2026 at 11:19:18AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Fold encrypted/decrypted pgprot selection into dma_pgprot() so callers
> do not need to adjust the page protection separately.
> 
> Update dma_pgprot() to apply pgprot_decrypted() when DMA_ATTR_CC_SHARED or
> __DMA_ATTR_ALLOC_CC_SHARED is set and pgprot_encrypted() otherwise Convert
> the dma-direct mmap paths to pass DMA_ATTR_CC_SHARED instead of open-coding
> force_dma_unencrypted() handling around dma_pgprot().
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c  |  8 +++-----
>  kernel/dma/mapping.c | 16 ++++++++++++----
>  2 files changed, 15 insertions(+), 9 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

