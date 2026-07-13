Return-Path: <linux-s390+bounces-22172-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2oEaOl0nVWpekgAAu9opvQ
	(envelope-from <linux-s390+bounces-22172-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 19:58:53 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6207674E3A4
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 19:58:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=VwE9LL26;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22172-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-22172-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED43530D7EC6
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 17:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7913F34D916;
	Mon, 13 Jul 2026 17:54:38 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8C334BA28
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 17:54:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965278; cv=none; b=JVZzS14pnBUj84LOcqye6k4UHE7PtxoBgEbniAZwI69IWa+Mcq/rs8Ab5043wEfcfeGxQiSaNmIhqykv0jV6dFBcoFkrOCqOz94TFj3SgnA01bFl5rcpJPHMJbY++jFGcA0RXUxGCimght1RsXGRF3lHeE938Ip0r39iRNcypVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965278; c=relaxed/simple;
	bh=K2KZlv8DzBtV03E/TVL3MeUwYAAgOJe/Vo9Rt0OvASs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhxoOuyKKNhiDlOQ983thX5PzKx+Gxu7ghRCInoFWqrQ1xS9PxFP89kW62dhBu34yJBMs6XakmCnw0nK2i4S7PlPwa1yfRJjUtElezkJmOpAlywW+ET2mHJkTzk5bYPnRwL2SRyCORfxx0JXz7F3T+gcVznoyfLBH6pygjIEE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VwE9LL26; arc=none smtp.client-ip=209.85.222.175
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e855da580so273322485a.1
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 10:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783965275; x=1784570075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yflr35iQtozkrKsWPSXMB3haiCYqPE+VDxf/660hH9k=;
        b=VwE9LL26Wmj3Bic97jnDe0FdhlxJKNHI8GF5oPUVFEzjHop6rveZn25da/L2GWKkXr
         sSnBTm7wvTMgjGmMCwv6qvZJP4hUUADTspmHja544fGTlGVAxs1fJRp19KPWi+jDJFTg
         cm+sm6zVXebpXv3cNYFdQzmd66mejtVPfokoETaVS49213pzGpJ5CzRMihCvh/kXJuUu
         /8w2V1ZaSCBbYS0W1PxynFlBIjoKn1fM6X5myfw+amdRuSpsYq7Qe3dCd+V2qoCY9iug
         bzU60uHdF8XiEUZ3MzWyy3mMUVU9i8EQS0Xx70hgHbrxZvnROMHz1ZJA5P4EXhkTIfVX
         I/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965275; x=1784570075;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yflr35iQtozkrKsWPSXMB3haiCYqPE+VDxf/660hH9k=;
        b=kr6BlrvOdaxdzIds6paht+9LPNXbmUiz6W6npMCENPeToWg8IyZ6M0vue1trq3wsxJ
         +Z8hSoSbfwgSBR5kdCQf7XR5W/0DjZX2XppsjZb3nOubG0UpHOoLGmUyUxPuTawS4UXG
         EYfr6LfKw2SnoiLeawoAG6v4Dx49rNFwQbJZKudLVToGUlhWJ6QF/7gO8pviGPAxe0EF
         2Qfhhh4HxmP0Q5axPDgkWLEFF4VNyUP01SfgcX7wvWfcnT2ewU7UMHTenTcQM0N4X0tE
         PAp/5ZYXSt/wafKp09BqRTCT4GlZwj6bQiei/LVQP274CNJvtqwMCDpK/SynwtXNxdeR
         8CBg==
X-Forwarded-Encrypted: i=1; AHgh+RrmMILd646ACVaAeKpH4mh14/Vl/1HZGUFbS4EErVCdqePvbxvKDnx6v/OxHnzr8D0A/pSnl2gHyHr4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1n4nYtOckJf9IYuNIEbOs/eSgKbrX2WZYgeV9elcOvS8zX09
	tY3lvlFyn++147snGwMI38cNsUKso/+EsBGoCFQGMbB4P2mHVMG0Zj+wLUqJMmcP/EI=
X-Gm-Gg: AfdE7cmHC9xp2g+DrK6Xqq1w6/R5ZAb74/Bq1Tve7FQLK4lVBe0CG2u41v2erbFkdlC
	oqLTmdYPIO+th0RUTX1vUasz2TnyZjntmP8nyhCKNYx1cHWt4HFUwsJmK6rHMrUXSE0a5bwOp0b
	hHpvd6tgD8MlEzez22jX4ogW/8DibyZEMow+MkpuZtyO2166erjgAoO8QAYIHG4N/oIskU9yJOQ
	w3Abjrs/AqrjOkRGLLZfB4cTzznqxAnpCTIIP2JRtntpDMccRKjKMrXC3RlRLpjmspTIicyy1H5
	euNcYv3ketL0XtzloY7N1BZYTyW06ky5t0bSNP3qErShEP/8XQkl0p7hdbSgqG+1fS60jgIpShb
	2RBAi/w3u1jNh0V/R7iuWY7LTdUjCZlwFjsuP9Dg5pLg5/AK+IO4fkjQtyEd4
X-Received: by 2002:a05:620a:469e:b0:915:94f7:55df with SMTP id af79cd13be357-92ef2bd609cmr983527785a.20.1783965274729;
        Mon, 13 Jul 2026 10:54:34 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cfdf6fsm1229104285a.24.2026.07.13.10.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:54:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjKrR-0000000DwzJ-2as1;
	Mon, 13 Jul 2026 14:54:33 -0300
Date: Mon, 13 Jul 2026 14:54:33 -0300
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
Subject: Re: [PATCH v7 02/22] dma-pool: fix page leak in atomic_pool_expand()
 cleanup
Message-ID: <20260713175433.GI3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-3-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-3-aneesh.kumar@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22172-lists,linux-s390=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6207674E3A4

On Wed, Jul 01, 2026 at 11:19:06AM +0530, Aneesh Kumar K.V (Arm) wrote:
> @@ -115,8 +116,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  	 */
>  	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
>  				   1 << order);
> -	if (ret)
> +	if (ret) {
> +		leak_pages = true;
>  		goto remove_mapping;
> +	}

Truely these _set_memory_decrypted() things are an insane API. So a if
it fails to decrypt it can be in any messy state?

> @@ -130,14 +133,15 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  				   1 << order);
>  	if (WARN_ON_ONCE(ret)) {
>  		/* Decrypt succeeded but encrypt failed, purposely leak */
> -		goto out;
> +		leak_pages = true;

At least this one makes some sense..

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

