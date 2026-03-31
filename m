Return-Path: <linux-s390+bounces-18326-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEeKO2YPy2lCDgYAu9opvQ
	(envelope-from <linux-s390+bounces-18326-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 31 Mar 2026 02:03:50 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B12FA36289E
	for <lists+linux-s390@lfdr.de>; Tue, 31 Mar 2026 02:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45D8B303D727
	for <lists+linux-s390@lfdr.de>; Tue, 31 Mar 2026 00:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DFF175A89;
	Tue, 31 Mar 2026 00:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SLP4FRdH"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B4E1A840A
	for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2026 00:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774915419; cv=none; b=fE5Ag9vxXemav5NHDPXnq+geoZdeR5xi0o0UW0aE4lATZeZrhX7rlzbTzCJTg7TJ0IcseclZ/2zSOnyixUOazKZIrUF6KpEM+CJMAZXdq+WuTiTuwNu6+06FsSYx0y/wby7oaI9NqQWog8vzqCGXW5Y83vkVGwCylfJtxAN33Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774915419; c=relaxed/simple;
	bh=tGFV2VhgTREgrfP98G0uJ3HUP/CSGaSbu+qGayezE0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BA7ibaY0B9EhLmKwkuWODjqrUuo4DKwlo6qud9Xm5i79TImzcMLoQzykRAqmoWULJmp1+CMcRo1xgNjLQ8UBpN2iACnPxjAoyAcC1rpFj/MRUwCONiO/moRwia3L8+bnSA61o8imlvnZDCJEM41BqSslWA+nFkiXWr6MdejSZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SLP4FRdH; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cd77786e97so511593785a.3
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2026 17:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774915416; x=1775520216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4YBgDlQG7t09O0fcPskt9PfuzfmSkfNvE01lxkkeEk=;
        b=SLP4FRdHz+CzxQ6VGVwelbz2oEWoQ1X35DiIGfJpcj0QPxlYn/KmJAsUuNzt6fcjDS
         oWFof3bAvc5j9KdXtQI9f0VMQa0DvcYaweoG2FV3kW+pV2IW7exO/w0Jq5JoXb7RzBFU
         +adMRpEIOxmBYmoJ6Cd4CIPGogUaGjpgg9R7KlEUEusODFVhLu9PmurFQGEwwH568in0
         /c3nKwBolvQhoYhiQw+G+W9H4e+vTwj4jenX2n+3SNc/Hx90+MZzdERumY/6y3+1RkKq
         xHRskO965ayYetBnW41UBqBIEHmT4XK4G3bUOJVLeZZjQms3kAdDJ6ChpuO093uiFxnf
         Q5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774915416; x=1775520216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4YBgDlQG7t09O0fcPskt9PfuzfmSkfNvE01lxkkeEk=;
        b=jARW6nBGJKazbt9WfiqHqZmuVpj+vzkLu7MilOvQBiD68j1+soGC1rQWWsPFgcDsAp
         GB015V25lrX+bBNH0NGeaPwu2f164zoem3U38Smp55PMnpVQasynNN07BmUzFQazv9Sc
         apBcpx/9hpjhw0YfBjw6w7ZLYUl9HBmWsuZSO/q46lucUgaYfK5OW2V+EPHDHKP86WGA
         1PtlrwbbeU/QSh9lB31VEoD23iAs+GO52Si2QDkHLjFTjO+WjXOJGxovdr47XpWY/Zqt
         siLup2dA44YiC+fivL19SLU68fRyccj8HytZ2w7BAHBVWL/I1B3ftlzKlw+CAHO4GrRQ
         5QFA==
X-Forwarded-Encrypted: i=1; AJvYcCXd9vj0UTchEc5nO7dJ0Ys+qkC/dlesFWfS2FJt+DX414qXDoOtqaAdk+6oIWA+hh4/Y5JMAWkWFXOC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0m4G0JMl+2is2jmqex+vZQAgHB6NfhiowxgpiC8NQy1RUdVP6
	f+l+4+Ueb+eoY8OglTdB0KR+jgNjBvq5QQ1j1ossHmmeb0rB7YWnUcIiLyMXulRjH8o=
X-Gm-Gg: ATEYQzyUJ2MvTnBFbI3vvZKFMPFhS0KEuYNGsWQ1v28ua4RoiEIwGckxmNwledTXIrf
	BbznwIcq1vhRKKOYX20t6xiIOiVRG9Uw+li64fgogi/xiGPFMw/H5QlcJVY9KQw39ctbCgP24zs
	Vxonz2BmjefORjt8iLNZdDm8ZT1aiJvxdQwx583iwdAM+a8KAmemZlJcuX3o9LqNDurZO2H56+M
	pCl6nb66KhcqHbQfTvKDTqMEwrGnZ4mVoNXztAnbwX8nTvkiO965dGjb39ypm+CzAtUsHsYZEO8
	O2uM3Rcish6H9xew4KkzoBbBjhrHUX5NpwXHe5+da0dJUY/XUMI4FyjYZUf7BioqfOOeSJlzMXN
	cnyqy5OUGFA1M63ZcSo0nlVVXU87IqmlJesobIYZM6aZAm0tBpd9GElgLERevreXmQCZu4jn2Eh
	Xrg7CxnoiF5XaBUwll/EpN6ugTwgtM0JaAFXnpv2L9oj7IglmloXghfE39cwhjThyzoam1+A==
X-Received: by 2002:a05:620a:4482:b0:8ca:fe5c:ea6d with SMTP id af79cd13be357-8d01c842aa8mr1753223385a.59.1774915415598;
        Mon, 30 Mar 2026 17:03:35 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d02806a37bsm712637385a.34.2026.03.30.17.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 17:03:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w7MZy-00000005rSd-0n0u;
	Mon, 30 Mar 2026 21:03:34 -0300
Date: Mon, 30 Mar 2026 21:03:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>, wintera@linux.ibm.com,
	ts@linux.ibm.com, oberpar@linux.ibm.com, gbayer@linux.ibm.com,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, mjrosato@linux.ibm.com,
	raspl@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
	gor@linux.ibm.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
Message-ID: <20260331000334.GI246076@ziepe.ca>
References: <20260325-vfio_pci_ism-v8-0-ddc504cde914@linux.ibm.com>
 <20260325-vfio_pci_ism-v8-2-ddc504cde914@linux.ibm.com>
 <4096cb9d402b1aabc9667d450221cb0922e78d90.camel@linux.ibm.com>
 <3d6457b9-715a-4cbb-9c69-d8a7e7473c89@linux.ibm.com>
 <64e3158a441c79c55febead9aac956c31f034fb9.camel@linux.ibm.com>
 <20260330093646.03b0455f@shazbot.org>
 <20260330155651.GD246076@ziepe.ca>
 <20260330120945.023b2295@shazbot.org>
 <20260330181645.GE246076@ziepe.ca>
 <20260330123925.713edac4@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330123925.713edac4@shazbot.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18326-lists,linux-s390=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B12FA36289E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 12:39:25PM -0600, Alex Williamson wrote:
> Yes, that would be the ideal balance of enabling larger BARs while
> retaining compatibility for existing devices.  Sounds like we'll
> continue down the variant driver path for this one-off device for
> now.  It remains fairly self contained so long as we don't add more
> regions for vfio-pci-core to manage.
> 
> This could be a good project if someone is looking though, especially
> if it had a build-time config option to set the minimum region size so
> we can exercise it before we hit 1TB BARs.  Thanks,

Well, it took claude an hour to vibe code a draft from a four sentence
prompt.. I see many things that need changing/cleaning in here, but
the patch strategy and general idea looks sound.

I guess another day of effort would probably get things into something
presentable. We are not so far away - maybe the variant driver path is
not necessary?

https://github.com/jgunthorpe/linux/commits/vfio_maple_tree/

Jason

