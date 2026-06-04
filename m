Return-Path: <linux-s390+bounces-20498-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZtkyKouGIWpqIAEAu9opvQ
	(envelope-from <linux-s390+bounces-20498-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 16:07:07 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5C8640AB3
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 16:07:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=Fp6fnAL7;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20498-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-20498-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D41C630BE328
	for <lists+linux-s390@lfdr.de>; Thu,  4 Jun 2026 13:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBB047CC67;
	Thu,  4 Jun 2026 13:57:15 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1B42314F
	for <linux-s390@vger.kernel.org>; Thu,  4 Jun 2026 13:57:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581435; cv=none; b=inIkJjrYgzFmk425xS2pcN6CthZjVoCciZlxHYkzhUC3EpBxyz5e6c4NlH0bS/iTIgDOW4VrLSifGKM9wn0jKk0QXfq5XXh310Da7yKRU9ohZz9ExZrS2Vw8+iIGQQ1dhx3yzZuOnyA5i4de1428EkK910VX368csVAJxnioaBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581435; c=relaxed/simple;
	bh=xdOeHpgtDPCXpgtRakSCpJbRBMD6e6ZeQ1aGekC0AxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3fNdG41q03s0OU1n+wSy97v3rHI/VSkQZ/t7DA2kmIBiapS7FOqPh/MzUJHfioAQ+MNc+8CQ6rXQCDCylLvpFzeMDYFb60+wFXLeQA8fgrHY7fqm5LIEolhXT9R8jn2R+oui+NHZroPdboND42PwkDUFhNKeEK4b/kIcoueHDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Fp6fnAL7; arc=none smtp.client-ip=209.85.219.53
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ccdef9f3d4so7641896d6.2
        for <linux-s390@vger.kernel.org>; Thu, 04 Jun 2026 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780581434; x=1781186234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xdOeHpgtDPCXpgtRakSCpJbRBMD6e6ZeQ1aGekC0AxI=;
        b=Fp6fnAL77gldcPHHGCxeqKc+OSaVfBOWfn7bMYW7TXK+xX92vVXhWPcYWvVhsT4Tbn
         PyVuDYfLlUJVjrPN5sac4JT2iy3BhPqvMLwjQQ6p0KClBtcimoODSoQRSe0+Q0uNNhcj
         D/xMZfdtSmCOt06KjXcS7pQbg+dNwbHE2+DTpF2t0YgheHJQ/dPKh6A0Eqlgqmf8ZWuY
         dlPWlWxOuCJq5VKbtWTyfL93TvDWfHxH37/JmUnHOV+c82/CHer6tVJtpfZhTGi0tI2g
         qIz6kv/HNJWme+MXIZuUeTTgcKbn9QQpaGjGpYXaBNsEGq4bnw6kHZp+GtcZo0R/TIO1
         zmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581434; x=1781186234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdOeHpgtDPCXpgtRakSCpJbRBMD6e6ZeQ1aGekC0AxI=;
        b=os/Jf6l7495ZPKmwXXsT5UJ7e8/VHFA/gbupL4qwwHeUh8UPzTrwkbjsWWAL4wj0XV
         3LQlfL7zYt2vT3t+2eX5e+fuJXMdh1bl+Ozbo8X6ZG3XNnexQIo8z/ui3SVyj0qeDCST
         FiiO0x/jFFst9RBViHTqKnk63038/Ny4qL/mMInP35x122STHIPeqBv+Qhi7VfliYkfq
         nA199Q55NV7tYA9s+6sfE2qKz5tnv3Ine6XXq/7LRhEP9PVO9rXYD2oRVcFVWbZOVTRR
         cTc5YRWtlKGuzQRFIJNrmApK85YghNbKm4999k8nNINsBw6Q8fpqxAq4FwKTA3M+HiVt
         mLgA==
X-Forwarded-Encrypted: i=1; AFNElJ/NAbPPzkCjM9QvU+WGiVMlIwquQjnj5UYzAIk9+UpLjs/ER1rzp/X4SJMXSfS++li1VRnNLjqIvVGK@vger.kernel.org
X-Gm-Message-State: AOJu0YzmWfnYo5nOyMrwN8/3zVl1Af2yjEHLQwgfooxazF6pOI3gB+vS
	y0IVAROeY9ZJqlTOMxPuLhUDsnTlT7pWZffw2F9CaiWkQXJL1Z1pAPd/PJAPxErAzuM=
X-Gm-Gg: Acq92OHeJswXGtEVI93NIyCioBweZWcF/kZaKfdaAa++XmuJQIIDmFqLpEUhRWVIKZT
	AJRnQUol2bgMMSRFv4HoLKDM/0Ns7q785M1I8x1JrsrtICGGHIcJufspMG0eAqBP4Cty6o/M+uN
	F4nJyh+WzBKaFFXYnPmNdbSHHrx9Bxge/6nI/NtDbIm/1o9Sx2+iVtPU/537OC6CLphr/r8aQg5
	Qp0RHv9D9Ln6stO24TunJ2rbHgYla8Y6hvyn5RfaoD9GWhbO9Q4RJ3FO7RVDzdFp1QVeDg000zB
	XqNXryi5RMEfc8kdBGkow3E27WcxzQ9ek2SBkCDQC+V4reGUjyG2wWvWJOiIgBnoA5lVHehn8g2
	yoelgwHnKOTxPk/e5nbxBC/O8BZtUCq0k1mHvtYZ3xZ3TUWLZ9F/h/rknkiwzQwdkVmkziKidaV
	OhltI/4Ydwq+b1rezP18nB0TRNUnRDrhBOZUqjpqJ1VGdRqsohfWCSmWagtXyL7DYWUbDMxq3VQ
	T4KBTSOp0TrWfpHgC/okJFzuYE=
X-Received: by 2002:a05:6214:800c:b0:8ce:e098:d974 with SMTP id 6a1803df08f44-8cee098dc5emr22722786d6.6.1780581433691;
        Thu, 04 Jun 2026 06:57:13 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd07629dsm53598296d6.39.2026.06.04.06.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:57:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wV8ZM-00000008FiY-2nrt;
	Thu, 04 Jun 2026 10:57:12 -0300
Date: Thu, 4 Jun 2026 10:57:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Christoph Hellwig <hch@infradead.org>,
	"T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <20260604135712.GV2487554@ziepe.ca>
References: <20260522225853.878411-1-tjmercier@google.com>
 <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca>
 <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
 <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20498-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sumit.semwal@linaro.org,m:mripard@kernel.org,m:jiri@resnulli.us,m:hch@infradead.org,m:tjmercier@google.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:lkp@intel.com,m:linux-kernel@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-mm@kvack.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:linux-s390@vger.kernel.org,m:djbw@kernel.org,m:thomas.lendacky@amd.com,m:x86@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,resnulli.us,infradead.org,google.com,linux.ibm.com,ellerman.id.au,gmail.com,lists.ozlabs.org,intel.com,vger.kernel.org,lists.linux.dev,kvack.org,amd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:from_mime,ziepe.ca:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E5C8640AB3

On Thu, Jun 04, 2026 at 12:51:49PM +0530, Sumit Semwal wrote:

> Given that Christoph's objection is not really about the modules part,
> but that the set_memory_{encrypted,decrypted} should not be used here,
> one option is to revert 78b30c50a7ac until that issue is sorted out?

Please no, we have stuff already using this so it would be a
functional regression. Revert making heaps into a module since that
doesn't have a functional regression.

Jason

