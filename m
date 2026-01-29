Return-Path: <linux-s390+bounces-16108-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJuhF8Nee2kdEQIAu9opvQ
	(envelope-from <linux-s390+bounces-16108-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 29 Jan 2026 14:21:07 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 065BEB0551
	for <lists+linux-s390@lfdr.de>; Thu, 29 Jan 2026 14:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 754A03002915
	for <lists+linux-s390@lfdr.de>; Thu, 29 Jan 2026 13:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EB61F4C8E;
	Thu, 29 Jan 2026 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P91dyL7G"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A771E0B86
	for <linux-s390@vger.kernel.org>; Thu, 29 Jan 2026 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769692862; cv=none; b=Zkl9NU215Jx0j2Z5nJqEehi+tfFClIS7yqQsW0zn1pxpFj9XDaHKnwu+qoKGhEMQTpJ2VYIS1/K87HvQHPN5vQeZEkJQgxl8vZCpdBFQnYDw8yzUAFZRuBMBHA78YxYJgflWURvs0NfiDTeHMd2eDKRt3RMZ+EZG56yzpDVWZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769692862; c=relaxed/simple;
	bh=vh7VpdWClqvupBRtUyQ4oaehf0QJg+QlY6j9lsmTLm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGbyMEwnqFcmWK9ZMRpjqbG3IhAXwd075Df8LkRiSwxcvGrazjLnXhvQHCmg/0DDaIBYiR/CQHx0S5FpB9DpqAWEvgAkKpwGPR4n6/0yGEDdpokSyqduTJs0e9H0lBgZun8gVuIOdOKnAdAQHfu4OrFqmqrqJh6DLZ9Cx3yE8zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P91dyL7G; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c710439535so76341285a.1
        for <linux-s390@vger.kernel.org>; Thu, 29 Jan 2026 05:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769692860; x=1770297660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vh7VpdWClqvupBRtUyQ4oaehf0QJg+QlY6j9lsmTLm0=;
        b=P91dyL7GH3Q3LC1VWC0ggnpPNgv2Ft+cnx2Jr0aJlCZFs9gQAU9NwkQiHHUhx+lXBj
         /zDrpCaRR/VC4OEg21KoY57JaR3Lt/ArETPe9W+zwQxZATbLOzUq/GZ4H1e12lo6tYYp
         Je9ouB5/T1ePvvGCr91wVQGBHGInWtK9m/Kh1WdC8qvd663Vw9OobOtqjbCejw82R3jj
         a+oqHZkjTK27Qs9WslKpOG/HZH6gWVC1y6gKf/i66lflCwYxfKEdka6ZUp76liThwQG2
         QH3Ikpom6eUTKGcDL4FyUWc/rm5/C/Pk0XSCmsXTKgaDRv6n0u0Dp8jOlc2P0Pbeck5e
         /I2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769692860; x=1770297660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vh7VpdWClqvupBRtUyQ4oaehf0QJg+QlY6j9lsmTLm0=;
        b=TPpk4/DdSPxBum08zv4mP6O0a6D+WUCJztoUFD/UeY4Nk5cdKO7dh0kxFFkrKtul7C
         48Fvcb68JPBIumQIwQXCQidq0g48IvBFSUkp38m+tIVrq2nxAkSQK0KwVSECP3JS96xk
         Z096feb21qDnB7EiTwMUdCkoAY/8Q1CxB5sKiGG89xp1LzVTVBKKGf+cSBj2XgShSqd+
         VMOMZgMwBBm422x3ifktbp2DwBJBONM9ksGPMIhuWI7y+cH9Q8nZjS8SHLfJZf3X4nFw
         2PwbChP3kNvrhRbIdBVUiUSnFNeGAp313p9bPYnnJMK70hU7OfDVrEtEarpG6JN+Wann
         t7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0swtPdH9OvmZu7jC8FEeCw2M2ZFQgQIwktA/B8CPDHNo5ktPdyqrjKRgRwCpr/4WmqUn7CI3mVrH1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy07GEv1rkZB9jryWeWi1TYoi62R0kSgZIpDLhm1eOG5gzPpeyV
	L2mzqKl8JcksZn4hcupWQLQGg8mxS4f+5UJu44xLhONtwE4RnQF31pQPv0aBrhPQkxA=
X-Gm-Gg: AZuq6aIrvR80MkEGGvDjMxAjbKJ60HsVZNCDJhUHV+Pwyx4/r0HXCS2D/nDQv57ALHk
	fVxi5OV2gZWBP0/b/hV393sfpN4JGr+wnLqhYGz7VVz9dUw22CveWu8xGdPJglQSLSTGNm/8ENi
	bYVGf1Jt4o+OAEZ0Tz4VUVq6E4FGzfEjqRgZ4UtdZmdVWi2DFuN4oWF+vFjdtojAGAyslfaRidt
	UNz4q93Y9PL8hBLFvNkCNL8FKqoFVO/TNc8302p1rozYaCN+VZbDhEheVE6o+a4lGRZmQMWY6kS
	WkG5c/i8Ymn4s7GdpvC3SBw/qB+BCjc+SQL5Ga0eji3JFKkbJyRh9HV/OYM+YIv88B2oIm4txzb
	s59+8TbgVChqjHZWFFQLuk0calBQl3ZTeEvs73QgASoWc1Gw1punTPESaR6XygkPtxtBOPJyGHm
	OjwjIOK/YDdTggF9cxqU4ItHgTqmEflYVNnO915P/DD6U7kh8dV62xJ2BRVSDs5QLb/6Q=
X-Received: by 2002:a05:620a:444d:b0:8c7:177f:cc17 with SMTP id af79cd13be357-8c7177fcf62mr589344485a.46.1769692859712;
        Thu, 29 Jan 2026 05:20:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36a5fb1sm37087576d6.9.2026.01.29.05.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 05:20:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlRxC-00000009joR-3Dw2;
	Thu, 29 Jan 2026 09:20:58 -0400
Date: Thu, 29 Jan 2026 09:20:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Leon Romanovsky <leon@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH net-next 2/3] mm: vmalloc: export find_vm_area()
Message-ID: <20260129132058.GC2307128@ziepe.ca>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-3-alibuda@linux.alibaba.com>
 <aXPEFdEdtSmd6AzF@milan>
 <20260124093505.GA98529@j66a10360.sqa.eu95>
 <aXSjm1DXm6yP62tD@pc636>
 <20260124145754.GA57116@j66a10360.sqa.eu95>
 <20260127133417.GU13967@unreal>
 <20260128034558.GA126415@j66a10360.sqa.eu95>
 <20260128180629.GT1641016@ziepe.ca>
 <20260129113609.GA37734@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129113609.GA37734@j66a10360.sqa.eu95>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,linux-foundation.org,linux.alibaba.com,google.com,redhat.com,linux.ibm.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-16108-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 065BEB0551
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 07:36:09PM +0800, D. Wythe wrote:

> > From there you can check the resulting scatterlist and compute the
> > page_size to pass to ib_map_mr_sg().

I should clarify this is done after DMA mapping the scatterlist. dma
mapping can improve the page size.

And maybe the core code should be helping compute the MR's target page
size for a scatterlist.. We already have code to do this in umem, and
it is a pretty bit tricky considering the IOVA related rules.

Jason

