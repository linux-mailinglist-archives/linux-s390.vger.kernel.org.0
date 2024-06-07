Return-Path: <linux-s390+bounces-4160-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526A890065C
	for <lists+linux-s390@lfdr.de>; Fri,  7 Jun 2024 16:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0404B288423
	for <lists+linux-s390@lfdr.de>; Fri,  7 Jun 2024 14:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59281990AA;
	Fri,  7 Jun 2024 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aZn8PRZE"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A94197A97
	for <linux-s390@vger.kernel.org>; Fri,  7 Jun 2024 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770206; cv=none; b=JfNbB30KJTE5bMEIg2vuZBIy7F0IN36wAoX+Y+As5lXR7CZO4lWJDqY7QrWri4hACqjHNS/8RSPBw7IYg2IdZxFbIDtDvwMnFmPQ6b+hJhQ4+6SjpCdLbH8BD5xYfeuHvEQ6NyjOeDWgPPbaPF+ozqCdoqVt7kHZwaMc3xYcvJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770206; c=relaxed/simple;
	bh=9uSFqKq6A5tx4EDxZg0A4Ok2ttHiSrOW7pHu+dwRWsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppM9jrG735rng2BzGV8ADQkI4TSqG8EbK9BbUwbMdthQT0/tzi8IwBYy+utouYm/5zs5BJ0vBhXGUBbYo3OWPiSHljWpRL6f5NJjKBGF1PfcDHbw7qVnZ1teLyRSklx7G3/yfHGwzwKrX06uC1645cgXTvu+jj6F45H9lH6aQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aZn8PRZE; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5bacd59e562so98948eaf.2
        for <linux-s390@vger.kernel.org>; Fri, 07 Jun 2024 07:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1717770204; x=1718375004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9uSFqKq6A5tx4EDxZg0A4Ok2ttHiSrOW7pHu+dwRWsk=;
        b=aZn8PRZEzvYw3OPX9L4kAqiZtk11JC8r3iHMh0KQMaIsIvBupuLfNZaXR1OnUslM5j
         L1pNLrz7fw8JOCIy9jWPEHcSJzcvyIm+e8scGVT1kYgCbKqsKTwWQk9ILtX1RPLoyqyP
         I4mVPIBaEq5e+oUJ5YbwI8rNc2wRWHeLI9Tue6zLraUvZKdrTWZxpcvPlI+D8YlBzgU1
         kws4reb8Edq+nrjua5ERdHSCgGs8F2c0+Jlm08OoMWAh0bzYA2WcoR8v4f1eZ0pXL4Kr
         HKO+Gzyeq1k3HDfiWWPjaQ3HjzhBab5GY0jr+KFMYNcFDmgQB9rrhilFL8Vbm7IpysgD
         IqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770204; x=1718375004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uSFqKq6A5tx4EDxZg0A4Ok2ttHiSrOW7pHu+dwRWsk=;
        b=W33Ilu1jfSCZObUsgsc4Rdv0SLLFjDp/cnftT//0LAy43iobUv5UZjGLW2QS/WcgrA
         O2h3Y8tz9s2EfzXmwm4lEQA5zp5KD5MxJXfgsBYOSy0ekpWYgjFjCW6hVEbmy842rHX6
         HlWTfu6Gx9QT2vOv1dovvK2du7F9nUL72UyuxaAK0F1xxWnL8++0Zj8qXCXT/K5O9Dxn
         /IefGOqzIKVbbbid695Bk/dgK2LTKrQBrayoyv2xkIH7j7IQosuS+w4rl77oJHeaQdBT
         YevZMf7uKbsuaHy+hHYcBe7uXM+CxnjvY7zhCTJ2V1joH0Z8mtVwaJ4A7paX9hqgbB68
         hroA==
X-Forwarded-Encrypted: i=1; AJvYcCX16+Th+HYRhNjw4CAKZ/GHsjglia/Ozwga47Q6WkhXHBvj7c3mgXtN7cxwJLcIIAvYZKPWP2kl/Z0rBJEJamQzsDmGy6zGMel8Ow==
X-Gm-Message-State: AOJu0Yy9KB+EFDNv1nbDxaKV7UrFeNqt9R4tkNNHOrYR4DUaMa+MdJ6u
	XS6Y8b6EnUhheHl/PiQeet0c9n9s9K8IW+eAZ9AzA+D4VIiuqeClsgRNwj9IBo0=
X-Google-Smtp-Source: AGHT+IEYBH3CtxDu4dbsDzAN1DWtvB+cuRNa24JGoVi0WdJUEcHjRF5hyvMCPysCTXu63T9/KKN+VQ==
X-Received: by 2002:a05:6358:5e13:b0:186:1abe:611e with SMTP id e5c5f4694b2df-19f1ffa7eb0mr279382855d.30.1717770203833;
        Fri, 07 Jun 2024 07:23:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f655121sm17491526d6.30.2024.06.07.07.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:23:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sFaV0-00H9uo-5V;
	Fri, 07 Jun 2024 11:23:22 -0300
Date: Fri, 7 Jun 2024 11:23:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 0/3] vfio/pci: s390: Fix issues preventing
 VFIO_PCI_MMAP=y for s390 and enable it
Message-ID: <20240607142322.GF791043@ziepe.ca>
References: <20240529-vfio_pci_mmap-v3-0-cd217d019218@linux.ibm.com>
 <0a4622ce-3826-4b08-ab81-375887ab6a46@linux.ibm.com>
 <20240606112718.0171f5b3.alex.williamson@redhat.com>
 <e15ead25812a34e62367422bfd88e5b82bbd85fe.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e15ead25812a34e62367422bfd88e5b82bbd85fe.camel@linux.ibm.com>

On Fri, Jun 07, 2024 at 09:47:08AM +0200, Niklas Schnelle wrote:
> I trust your judgement and was unsure too. I think for the
> s390_mmio_read/write syscalls the only existing users out there are via
> rdma-core, so unless Jason tells us that he thinks they could also be
> affected by the lack of page fault handling I see no problem in going
> upstream only.

rdma doesn't use the fault path for the doorbell mmio.

Jason

