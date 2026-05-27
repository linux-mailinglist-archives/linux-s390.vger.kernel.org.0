Return-Path: <linux-s390+bounces-20098-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANKZNK3pFmruvgcAu9opvQ
	(envelope-from <linux-s390+bounces-20098-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 27 May 2026 14:55:09 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A095E479D
	for <lists+linux-s390@lfdr.de>; Wed, 27 May 2026 14:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57CF73016804
	for <lists+linux-s390@lfdr.de>; Wed, 27 May 2026 12:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD4D3E92B6;
	Wed, 27 May 2026 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ga8Z/CNj"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148BC261B92
	for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886308; cv=none; b=FpmkmawtrcKWuDprUlE4l56W/gyJXUP3Q8wHQhSIp7iS4xzx01XYU1YGjIuVDU3PSW7D/59XCDlGatlB96bl1bHpi6TAImBoY0xd0UOqEKVix2I+ZbsrlgwMLT8bTMgDXj37mcTNR5vog7DVj2bSU/c4/+XBH3Ya20AO20XiQHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886308; c=relaxed/simple;
	bh=3YV519fCLQr/dcnqiYK/3hUmKBEJM/JaljBjBD9SBqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSZVyIBmHjNUs4Oy8pFMTH+wM5WH4eOztDUaolsun/kWtR7OqxKAjNbevD2Sdn0Uo+ftL6LZLuFFxKgGJhLj5M04Uq0pOXlC15s1O33TwehULZqmOA8I4ObihADEy7IobiBDZz0RFnEHXu3CmxchRSyR9rHe3JtTrjDnZDAiv44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ga8Z/CNj; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-516cc5471bdso84303131cf.2
        for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779886306; x=1780491106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4NRS1K5QNG7yp7e4rqW6uFiLphCUgs0ec2fYNP5HFo=;
        b=ga8Z/CNj2OS4OZUoQ7hZbQxPmeemYh6Oxdkmcga+jXSdDruZktqy07KkA+8H1hzLF5
         +WmCfq4cf5StLpEEA3PVZZe/Il626JLXImJFVEKPS7N2Y691LNTKhA9UYEm0DZA6Ww21
         x7r0wPpze3y+wlOhQMbNtCtTcNHdxer1LutrJNn4NdPeN0xNWj5AZqGYv1yPY0/O7/Qq
         7o4ex5vz001epBrK4uQEQ5p2XD+fWXgF8ensCN1fOOepngfG0V2qCyUlt3xetrFePNDn
         Z7xktNI9dSge5kzq/tDArXcDRhe1X0Tif8UdK1JfCga0rLCy9t6xGCS9QvbDfx/bXySE
         Ac2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886306; x=1780491106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4NRS1K5QNG7yp7e4rqW6uFiLphCUgs0ec2fYNP5HFo=;
        b=Tl1H21SYkvGlL63SWfet2nU+MIXJSZ+aEAxXatm9Jsq1qpMhmFvHYvGn8CAMasyWbW
         FK9SDcodnAta4YwZUHLdf9NpXw6oztdC/SLbf0zLM8Dg9e9WdnP4C1aqB1mfqmWG2Pvh
         kPuUOJFbWK8gg4odZzxRT23aIGya2g1pWN6Wt1CzhM3Rhg2D8FspFtgvimmZ5HVwjE6J
         iP6jKNtS1V4V8S+cS0Xx+PKoFIAMahfduBtQgRiimSHk6zluGdbhCRX/Ohm7//9VEO4Y
         JeJ0gsF7tB9IxLgmxKUxYmRf4pJ4jKLuS/KIngwNNSelPfqgoAFQPjJm+Uam6FnZglRa
         bC8w==
X-Forwarded-Encrypted: i=1; AFNElJ8DWo+rIIKOLKLlYAMVOn/f8MbjShAVoLUNqQYN46MeqBZSlEWC3f1Q8HiUqrjV6KF5HMcXmqh8Sb5j@vger.kernel.org
X-Gm-Message-State: AOJu0YyEQTUW6ASUPMxHKU+cFpLkrHnzsYUKpan/ugiPlHcxbM025umw
	QbPWn6mCWPgNRuzvFkbzwsgyR7OkmQBx9YnEZON9UjYCSkCeCll9zx6wHmyLKw5I5FQ=
X-Gm-Gg: Acq92OFZJ8vedi7BrW8nymtM+WDtRVr31FPJiNGPPjUYoHi5jZo3udVe2WonwCYvuAB
	gRVwcbxCicC0gj+w8yR969f/HKCoBr4pl5iuu2v8TOJ8LhQTKGjIgG7bNTY8KSkOCkH/+YBJYVp
	YQ3IHcutq9WnH7IgjDBW0VAvOgEJ5QXO8Rur/Zdv61PgsXd8sduM4As/QmLVGGnydKZGoDXZ9kb
	NSyfjVitT+CorUvJYa+HRGSI9XndakbrXuW3fsx9ffqsZdtwRLrD9kLtgGq1baKRwrVsSTiRL9G
	RlvN27RARyO1lPfF/PtefJrQCXz9cdzhxGhesh9WLOasGqqo9jlhDdgN4gouaU1uVR+Z1iZXYTc
	B+r2apN+7uiDQhESvvj/9+40aHxSVUrtmu2Rwbjj8Uf+eSiAjvzEYBV+cHaYavyKWKD4vhyxIBp
	2FfvotsX8ROjDBAzn4cbHe7PQKrQky+y2LYzWrBxjfBDku40Jj3fybaJwsz5GOHtcOmOz4shrp1
	EsY3SRMFA0r+2ST
X-Received: by 2002:a05:622a:1809:b0:517:1481:54a with SMTP id d75a77b69052e-51714810844mr23315551cf.53.1779886301081;
        Wed, 27 May 2026 05:51:41 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517069f2464sm41772341cf.2.2026.05.27.05.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 05:51:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSDjX-0000000EOpm-3BXO;
	Wed, 27 May 2026 09:51:39 -0300
Date: Wed, 27 May 2026 09:51:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tony Krowiak <akrowiak@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 5/5] iommufd/vdevice: add TSM request ioctl
Message-ID: <20260527125139.GL2487554@ziepe.ca>
References: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
 <20260525154816.1029642-6-aneesh.kumar@kernel.org>
 <becd865d-09a4-4ac3-b719-4a0deae2692a@amd.com>
 <6a168c8ea7d10_2129b2100e@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a168c8ea7d10_2129b2100e@djbw-dev.notmuch>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20098-lists,linux-s390=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 41A095E479D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:17:50PM -0700, Dan Williams (nvidia) wrote:

> In that case pci_tsm_req_scope becomes tsm_req_type and is just:
> 
> TSM_REQ_TYPE_CCA
> TSM_REQ_TYPE_SEV
> TSM_REQ_TYPE_TDX
> 
> I am leaning towards the latter at this point.

Yeah, this sounds good. I would also include an common op field that
can be decoded by the TSM driver based on the TYPE above, and the
usual in/out message buffers.

Jason

