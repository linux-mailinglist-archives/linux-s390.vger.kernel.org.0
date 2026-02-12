Return-Path: <linux-s390+bounces-16306-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIqvIwrhjWlI8QAAu9opvQ
	(envelope-from <linux-s390+bounces-16306-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 12 Feb 2026 15:17:46 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 201B612E363
	for <lists+linux-s390@lfdr.de>; Thu, 12 Feb 2026 15:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 118D43013DC4
	for <lists+linux-s390@lfdr.de>; Thu, 12 Feb 2026 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEAD35B642;
	Thu, 12 Feb 2026 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q3uRx0oV"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04E2261573
	for <linux-s390@vger.kernel.org>; Thu, 12 Feb 2026 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770905862; cv=none; b=UE/Zdq7SagsQwUvlyVJ2HNkECdw3TjRl/0yj8+lqiGYUIBNpXQfhd9+6e+UIaNmDBL5Aj5AvXtkf+qHn9WdrM1dPSkReEWh9bfyNbqLr/ykY16XuL2hiAZcTmk5SOLmc/LwJ5h8jVCTTdktwXOMJD34j1V5TkVovqxy0w7ohPAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770905862; c=relaxed/simple;
	bh=3b3igbvjtC6TzOflHJmS47zTEL8ymbacN0YsKIuJxWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMVkWiTj8N2h6bKGBRzQ/ShHWRkw/w/d5G+QLs6SkvqbaSaWlY6xllJhVe1WEASOfRMQ6ZJR68Unf/GDSU7JNIW2wasavJT0Ss/KggR8LYOF3RXB1EkU+P3izXM8hCXDVkxmmOLVI8uL2MvaHBJh3tlesgL65oBEMjliLv7iAmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q3uRx0oV; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c5384ee23fso696291985a.1
        for <linux-s390@vger.kernel.org>; Thu, 12 Feb 2026 06:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770905860; x=1771510660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3b3igbvjtC6TzOflHJmS47zTEL8ymbacN0YsKIuJxWU=;
        b=Q3uRx0oVkpBtjZMZbSndCvl0/QfZMt7MAbI3D53Txnr5ruSGu9lv2TFV5MAf2viUVP
         DBTTpZdyOU0CG9x13bvE8QdJ1Ws1qPBvvtbXzd3CGRZ/jPPL8wabZgieEAYpzhRGMF/O
         YPNOJTeSNw+dkZ/VtglpsW0d50nHTNJyHM+tyGNLHF+MRSikENW+5UT0wSzONaWcbioI
         0ySfyGpJ+0eaQEwRJrsNaAljb6ddCr+R4BrrICxJgWeaY8Ja6zeTgfwm7v9Cn/dmSKsy
         uuMMALbstQPH3dip8zt8iFv9o1DHdy4Mq3g+Srd2i9qde8R7TpaO/L1Q3TtoJxdNPstJ
         IS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770905860; x=1771510660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3b3igbvjtC6TzOflHJmS47zTEL8ymbacN0YsKIuJxWU=;
        b=aKFVoGLV4wQdYNYq7GLmOsrhtGqLK6vCrcxr7aZxrfwGhjQ52W3CdG/gbycrwbGyYl
         utzqRL02rWH4Q1McuQj0sZ2VXB841t8A7K2jXLbYXSkT+vFE+LgNNJZzUO6Q6F/Ma8Vs
         jnGbEm6GyH3Ddmx248lICd56V1JX8UF2vqXM5jeMNgWZZdH2Fq1vq9hQpUChv6F5msiE
         c6O8ksmpyY8dQ5QmSnD580HRA/U7BiuGVKYVV7geIHw33JK4CeH/H69Nbt0y4g7CEJLL
         C/OeDb1wtQzAUpMzkqi+VAqOyJNZ7vRyBBXfmLIRkT3V6k7IdbOngjP29Q2FNiEE9RJB
         rGyw==
X-Forwarded-Encrypted: i=1; AJvYcCVGA0PrbiIqZpPtlFT4Yw8zX5voJaT8A4Xjg36C2fY/gAIKbxV/D2NAWKqZHjEbCGcI51j0ga4H09KZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzSv/dd0Rt0uDIhdmMKPzrm2rKi8BY0v08vkvhMdKWugxv9r8/2
	MK8GvsTtf1Ig+nbsHNt877x3B6ZOD4tF06PCbUBWanndIFgnAL9XRJJIZm7pCvsT91A=
X-Gm-Gg: AZuq6aLsjTUUEWanLUHuHbYGKXJVOltiCfUDoVHzMEAgE0fj91i5enNDPd05D45lvpn
	gVXjMBlt80hx+5Gm4pI8LjjwVoAq2eZeUq9h5erGZB0wNTY2WdCHF+XWfpdUyw7B5xW2YPGdoFQ
	0mz8L+jhFOoYzXKgQdwGHPmdImeXdnFVn7CpghkCcNI9AMC6jMpJzUl0UpUF/FGeDK8y8DmzyhG
	qTs5pi/dwd2iTPxFM+xrmwuYoc4xGwx/InEiooxAOz4dWfXETs6qtbQ4cvV8fbtxbQS6oJ+aTg0
	hIFSbfhyA6PwslAZY0k8u9q4rIzZRNchyg89Fx6ub1CW6+P7woqAkQ3E4aHRtERfmON12LCZcu2
	OcbLSHRZRNHrID/ryLKB1mUrwlDd4qry5cc53RQmXDtA4hb1pPA/erBJsT+h4USbjKKqS8I4B4n
	qVUumZ4f/K+6EaWiJxk5A07w5svNz46jLhloYBay/zY6cxUNpHvPcuPhOWKUZ0Kd2YbZfUheBEG
	RPjpIc=
X-Received: by 2002:a05:6214:b6d:b0:888:4939:c29 with SMTP id 6a1803df08f44-89727b28033mr38655036d6.71.1770905859509;
        Thu, 12 Feb 2026 06:17:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cddb9efsm45048286d6.51.2026.02.12.06.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 06:17:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vqXVi-000000013HU-0xrD;
	Thu, 12 Feb 2026 10:17:38 -0400
Date: Thu, 12 Feb 2026 10:17:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Julian Ruess <julianr@linux.ibm.com>
Cc: schnelle@linux.ibm.com, wintera@linux.ibm.com, ts@linux.ibm.com,
	oberpar@linux.ibm.com, gbayer@linux.ibm.com,
	Alex Williamson <alex@shazbot.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, mjrosato@linux.ibm.com,
	alifm@linux.ibm.com, raspl@linux.ibm.com, hca@linux.ibm.com,
	agordeev@linux.ibm.com, gor@linux.ibm.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] vfio/pci: Set VFIO_PCI_OFFSET_SHIFT to 48
Message-ID: <20260212141738.GM750753@ziepe.ca>
References: <20260212-vfio_pci_ism-v1-0-333262ade074@linux.ibm.com>
 <20260212-vfio_pci_ism-v1-1-333262ade074@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212-vfio_pci_ism-v1-1-333262ade074@linux.ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16306-lists,linux-s390=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 201B612E363
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 03:02:15PM +0100, Julian Ruess wrote:
> Extend VFIO_PCI_OFFSET_SHIFT to 48 to use the vfio-pci
> VFIO_PCI_OFFSET_TO_INDEX() mechanism with the 256 TiB pseudo-BAR 0 of
> the ISM device on s390. This bar is never mapped.

Woah, this is dangerous, the size was selected to fit within a pgoff
of a 32bit system.. Does this entirely break vfio on 32 bit?

Jason

