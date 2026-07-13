Return-Path: <linux-s390+bounces-22190-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FRUFNbg/VWpCmAAAu9opvQ
	(envelope-from <linux-s390+bounces-22190-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 21:42:48 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2528574ED44
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 21:42:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=HfW9hKND;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22190-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22190-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 277A8301F1AA
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 19:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59CA35838A;
	Mon, 13 Jul 2026 19:40:09 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486F8357D19
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 19:40:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971609; cv=none; b=rGjZq6hOq7aL6n8QcE+rValn9z/2W9DHDWNrMpJCWEhg0C+cf81e2/GpvORwF+sH//l9j4ghfHXkcAu71Ss9AEqdrHPmobxpPrATehSzcb+eTOeoy6CsE9UHEBWdmg80+ppzfG9mJ3Yx7O+SSvk0yYxn1+xDAU09WLrhEw2tDvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971609; c=relaxed/simple;
	bh=M9QKRtZ168nKUwDynjsu2QK6gybRC0iEdsj+58oUPCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYj7j/4eUOUAVNSTgudohlnV3kBlTQ5080ZyzRDIVgDYuRLq2IScLuaTPfo49JvryYKyinGCn9zUP+s4+vVOyHJf0BwdOgQgoqzO47c+V4TzMqIYs4DokHLC6rfge0MeyuOd9E9yni3ge3adtsfGsLkBFQVDfxloDqBnfgIfc3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HfW9hKND; arc=none smtp.client-ip=209.85.219.46
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8f0e5e36912so26112166d6.2
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971607; x=1784576407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3axe3nHsSV3pW5ca03j1xpTM6jT4Lmr5n6MpYvrruyI=;
        b=HfW9hKNDpymyiIMSBx4HRryKCvQXWkDHlUcPQW6z21HbfbcJtdPfuD5MWCkYlK/J98
         Oy8skTAAI5OX+axnlZpHugSeK9YIhJ/9Biyw9v8OOjovj8AvIYhZqY1dziOgq+jrw/ey
         H5+PY+PQJJ7w03Ehe5JCy/URs2nIgvKGVeJRyHHmriImOXNxfgfklXASNcGjRW5AclTM
         JJ/T2phxhSijThY+1CHT7wNloWn4LvmvtIqvx5LiAtjKp393gCJe6HQWNxhzIwGQbc50
         B4qvwte+1T6AFq2RCHjTCY9Ih3H3kNS+KQacCiTwZFrzI++wn1ZFmIybYE+ZqLOjGrmJ
         GN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971607; x=1784576407;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3axe3nHsSV3pW5ca03j1xpTM6jT4Lmr5n6MpYvrruyI=;
        b=op9NhYfgEshUAGhRMbtnYh3zP/YKDwcLasxRPm9d9zk6/v8ktw7rbeJZ1OwTevUW8J
         w3oJ6ehgZymFwXD+SSDAz6xwVKbTB38WCXEz+TQtdPRR+wIYeI4Lx/apsJeNsnF1Fhun
         LJxfSskKLEVoHbavpXY1THUbDfrTMTlHmElwCxEiThfVZcjv37DnXyZLkUDRExBZAY7a
         l0bCNr4xZwkgtWtHZ4bqqP4OMsgoLiCySkAE3b+Ds9/gZmhDcYqjT23qO6zm3diN5BZU
         gCoL0CioLDY+j9BmPzk1+qycWbRGkzL7i/MVgaU24A/OBwtg4V1hBcQsW3HMQxoAvt1W
         DYqQ==
X-Forwarded-Encrypted: i=1; AHgh+RrH/D4Hn6aj6eYtV/AUhOzWPURW4zmeCdLjbgit+1pzShlxB23cvubcSG5CyAx4DASP3atyMWp9Zc9M@vger.kernel.org
X-Gm-Message-State: AOJu0YzeSlV7qZmFoeoXxyLsphN7bXRXr2A28BJXrEq/F0Khe4z+Rxnf
	9enVHzPExyjm4Qv9z/f/Qhcp1bdvMFwz2+yeUlfLLT2NDobKPuckf7ba9QNw1V2CZ1c=
X-Gm-Gg: AfdE7clvf9RcdCDycqWWPllVzZ1w5q8B6nvmsG9ILxB/KSzaGF7llUQ3xtBdmgrc/uV
	7/z98HRbr8hw6DOBa2i2H//2E8ShnJ00gLtNQqaPBFjhdL49sPJbqK5XMBqybH0H3NDBlDWQ3qt
	nBKAf1oWLCfQsI80wk0TLQm7zvIPbUSRSxVolMZo0/QGWRO26rvF59etj18NUE999rveLexWEir
	pqDdx+I2TiZeoOB53OCd9kcg+Bb2IIdip79fSRcoA4VU1b2n/mX+C4ENqKHvgYiIhUONxnpMSd9
	IGG9Qv0bgVPobEr+/yYW+LhUC4Som2XjXYk/Zq43NwwqZmFx0y3W+G58SOZqvP09FX8Z+ovMIb4
	HN9u+Dl61sk35q5hFkBaMmEukLIvOQKwGsZCFC+MLrTVnY94Ko4RN3XIwAmUe
X-Received: by 2002:a05:6214:e8c:b0:8fd:6e12:9711 with SMTP id 6a1803df08f44-90747d1c8bbmr12839976d6.63.1783971607034;
        Mon, 13 Jul 2026 12:40:07 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56c06e1sm136829916d6.14.2026.07.13.12.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:40:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMVa-0000000E6cV-053d;
	Mon, 13 Jul 2026 16:40:06 -0300
Date: Mon, 13 Jul 2026 16:40:06 -0300
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
Subject: Re: [PATCH v7 19/22] dma-direct: rename ret to cpu_addr in alloc
 helpers
Message-ID: <20260713194006.GY3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-20-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-20-aneesh.kumar@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,lists.infradead.org,vger.kernel.org,arm.com,samsung.com,kernel.org,resnulli.us,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-22190-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:aneesh.kumar@kernel.org,m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:smostafa@google.com,m:ptesarik@suse.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[32];
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
X-Rspamd-Queue-Id: 2528574ED44

On Wed, Jul 01, 2026 at 11:19:23AM +0530, Aneesh Kumar K.V (Arm) wrote:
> ret in dma_direct_alloc() and dma_direct_alloc_pages() holds the returned
> CPU mapping, not a generic return value. Rename it to cpu_addr and update
> the remaining uses to match.
> 
> This makes the allocation paths easier to follow and keeps the local naming
> consistent with what the variable actually represents.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

