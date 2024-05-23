Return-Path: <linux-s390+bounces-4030-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7268CD6E3
	for <lists+linux-s390@lfdr.de>; Thu, 23 May 2024 17:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A1D282D7F
	for <lists+linux-s390@lfdr.de>; Thu, 23 May 2024 15:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AAA6AAD;
	Thu, 23 May 2024 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QxvdT3f0"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B830F9CC
	for <linux-s390@vger.kernel.org>; Thu, 23 May 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477575; cv=none; b=VcHZI+XxzfYfACklGBLKsBcK4hKCMA26own4JuXCRdamAMUyiNxdni++pvwlG6abPJ23Ucj3z1LLCfbMCsok12Ge7h3Br7YEWaz5Hg3gA9ImY7tFhHnPTnBT8PkAVOFc6UEuiKjj5Zd/ve4C4kH4QKU6muq1FuCJQ6ijLKA5q/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477575; c=relaxed/simple;
	bh=rZEd8LdQ6Zv26yckL/PfuFMPfamA+s3S+lytwF/58SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpU90T4DuOt3j2almAWeJ8vG0GazU3VTE/ZVvM7IVPHfeYyH1o9UPTCAbi7Lqc3bhQS3MJQq4p/IpYUrgtCCJKBNmcVGsTElUn4+nFbW3wUU/2FtnKJRemAFWr1dtqGnvuyoILh/aEnQtjSEzJdcnIHlVSRHlg01vkE5Qx7MSTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QxvdT3f0; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6ab8e80775eso7343146d6.1
        for <linux-s390@vger.kernel.org>; Thu, 23 May 2024 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716477573; x=1717082373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C5GM0ixhavCb3lJsnHYS4J/lZEUFFylRa25YYAO3lZY=;
        b=QxvdT3f0OetY2YBgbq6kFihQldxVsBO9P8xWNY7pPU1opsjoRdBtIAJH03jsjk/+Mx
         QI3VQLVd/ISyg5POOJtiJS0QTnytupG4yeRC4GCRHUKF+NO3JcPjGgdAqiY9ZJgDWA+5
         rtVh8Mz4ZW20YZyImMKToYbHqFO6ubmkVyMrklD54ycbWPxwVRMM992VmbzcTTXtYC36
         RpJQK0M8QDVgd0KqJTwk71cP+/dwV6znZSyC3I3deNNVvHbpkRZpMXafujmO7WyN2+hQ
         wcQOtKzY73J0JSYWUpbQW2MY9bVUxtJ/aPoyhpNaGkur/p0ayvx9VUIiwEQ6pHJNa4kW
         NB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716477573; x=1717082373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5GM0ixhavCb3lJsnHYS4J/lZEUFFylRa25YYAO3lZY=;
        b=hiupdzsRW27eR7SlB5ZDUUDRYDq5VjRb5g56AwYClM7GaTwVE5Uj2dZ70YcLU5A9/b
         D8+KAh8m8ahnsbtoFhfA0r/H3CgGTu3mceAOUdc41OvBEgYD8f2yG4UUHya/ypbPmZZk
         Ur+drwBbF8rZQwTzv4kQCzCs2om2XvEj+HyCSwI2iq2YaUf1q9GUebhcAKLnnHyzfY6m
         7z/PLnuVM0vm9OjiJWMwqjJrVSJJwyHQ7ojxSIX9sFwMBwH7JXEd/Ca/GmbnbBhx+WSG
         AlbbiUzqDXGwueG9zSP20n4lvqK1obWlABfYvl23w2Gb+5cWwtlp2r97RKYyqxYR7YZn
         /lzA==
X-Forwarded-Encrypted: i=1; AJvYcCXN2hgE8dntImBDPxMYFp4d2sXqA5eWQgP7eh9DrEgfeWJT1SROZJZSoejiWS1Eq2ccqPOZKjYzzsKwFlSmX7qN+rY2q3DHsvp+vw==
X-Gm-Message-State: AOJu0Yyhq8h5/uzLsRQtoZ4L9WsZutszENIIMpFnWvQXsaTFT5sWDBn0
	xylx56o+ony1cWoS2aZJgp82vg51JJk6iL0tzDDUIYrV4sVdw885SP9q16DqGASfqBhVZu5oKkY
	rVC4=
X-Google-Smtp-Source: AGHT+IFmPxDsj9nLUxgy/gv2BFbjFqLJH4yge1yEpFnhep0gZXO8FyvVSlATXLi0pQDD5PxbIp3m/w==
X-Received: by 2002:a05:6214:3d07:b0:6a0:e690:2f96 with SMTP id 6a1803df08f44-6ab8f5f3c9amr57165256d6.21.1716477573044;
        Thu, 23 May 2024 08:19:33 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab818288f0sm16704726d6.146.2024.05.23.08.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:19:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sAAE7-00Fqd0-BJ;
	Thu, 23 May 2024 12:19:31 -0300
Date: Thu, 23 May 2024 12:19:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] vfio/pci: Enable PCI resource mmap() on s390 and
 remove VFIO_PCI_MMAP
Message-ID: <20240523151931.GK69273@ziepe.ca>
References: <20240523-vfio_pci_mmap-v2-0-0dc6c139a4f1@linux.ibm.com>
 <20240523-vfio_pci_mmap-v2-3-0dc6c139a4f1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523-vfio_pci_mmap-v2-3-0dc6c139a4f1@linux.ibm.com>

On Thu, May 23, 2024 at 01:10:16PM +0200, Niklas Schnelle wrote:
> With the introduction of memory I/O (MIO) instructions enbaled in commit
> 71ba41c9b1d9 ("s390/pci: provide support for MIO instructions") s390
> gained support for direct user-space access to mapped PCI resources.
> Even without those however user-space can access mapped PCI resources
> via the s390 specific MMIO syscalls. Thus mmap() can and should be
> supported on all s390 systems with native PCI. Since VFIO_PCI_MMAP
> enablement for s390 would make it unconditionally true and thus
> pointless just remove it entirely.
> 
> Link: https://lore.kernel.org/all/c5ba134a1d4f4465b5956027e6a4ea6f6beff969.camel@linux.ibm.com/
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/vfio/pci/Kconfig         | 4 ----
>  drivers/vfio/pci/vfio_pci_core.c | 3 ---
>  2 files changed, 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

