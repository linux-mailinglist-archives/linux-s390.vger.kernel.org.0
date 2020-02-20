Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17814166912
	for <lists+linux-s390@lfdr.de>; Thu, 20 Feb 2020 21:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgBTUz3 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 20 Feb 2020 15:55:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32860 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728400AbgBTUz2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 20 Feb 2020 15:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582232127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n59pKOcdTZlkr3iRkuuDYSYR3kx21EL+m/7qJp3dlcc=;
        b=U9aCYgMUmxiHkcmw/s5Z2ZqbmNwaGhkOFw4fEQpD/BY4Obn3VQQkJ025sOkv3P7UgYhmJn
        1Q3KjdMVXMQSGZyPOBbxSrxvBdgZFXnFGn71hqaOLr2CTp8xkTPyb1T9pYrK86x/KlKpx3
        F6U8R8iZP0efEffXvtDUdLBVxlMK2K4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-r8OyWvcZMO2WUHw7vqltmw-1; Thu, 20 Feb 2020 15:55:23 -0500
X-MC-Unique: r8OyWvcZMO2WUHw7vqltmw-1
Received: by mail-qt1-f197.google.com with SMTP id r30so21553qtb.10
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 12:55:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n59pKOcdTZlkr3iRkuuDYSYR3kx21EL+m/7qJp3dlcc=;
        b=aF0cwVDYOVRhNltjTBS4F2mZoHpyjvrVtJHn9t+/8P7dC67fcVYyv+XEZrpwNT7hhC
         I1BRpa/lbxKPMh8HKB1zsVmbmjFZThLCbQAd3BPUdvgaEyeGW/B6utqoQk4RSpmmdy+j
         hRFP64Z5hBWr5q/1jQCSeYTxYqgXXqZ0KRjm6CVCqebVMWO7HtgSenyEoKe4PvgFnvQU
         3GyFOdhr2XDKIWlzJ5o8m9dSno8NQiGGbxuZ+R2WaSCOYo5m75n4oco71u9qznt/sOAT
         zBE6IfNwF0QL4NrkzBrKmOPYPWyQUxs+JclUHwsz++fBcXX/+gR5vfMETBstJLNT7UJF
         Vezg==
X-Gm-Message-State: APjAAAVupG3qVt32uBC8+IyOagIciyck92W1rqNykdfhsY5xwBsEPcZz
        wlN5WEjnhQamkNzghTHMygxtDyitT3UaGY5caD3S5tQEdkijcvOSvTaQVA8aP2w3VQhPsqMY+02
        xOrYIT6/6pKT3sVlzMpX07A==
X-Received: by 2002:a0c:b920:: with SMTP id u32mr26145316qvf.173.1582232123406;
        Thu, 20 Feb 2020 12:55:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYbEyWlyA1CtyLkpPuUF6uywJfTlRwR2s/p8kqFjjrgLX6Ni1df+OO/USj4ggxNDPJ4/sgrw==
X-Received: by 2002:a0c:b920:: with SMTP id u32mr26145171qvf.173.1582232121178;
        Thu, 20 Feb 2020 12:55:21 -0800 (PST)
Received: from redhat.com (bzq-109-67-14-209.red.bezeqint.net. [109.67.14.209])
        by smtp.gmail.com with ESMTPSA id g19sm391571qkk.91.2020.02.20.12.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 12:55:20 -0800 (PST)
Date:   Thu, 20 Feb 2020 15:55:14 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
Message-ID: <20200220154904-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220160606.53156-3-pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Feb 20, 2020 at 05:06:06PM +0100, Halil Pasic wrote:
> Currently the advanced guest memory protection technologies (AMD SEV,
> powerpc secure guest technology and s390 Protected VMs) abuse the
> VIRTIO_F_IOMMU_PLATFORM flag to make virtio core use the DMA API, which
> is in turn necessary, to make IO work with guest memory protection.
> 
> But VIRTIO_F_IOMMU_PLATFORM a.k.a. VIRTIO_F_ACCESS_PLATFORM is really a
> different beast: with virtio devices whose implementation runs on an SMP
> CPU we are still fine with doing all the usual optimizations, it is just
> that we need to make sure that the memory protection mechanism does not
> get in the way. The VIRTIO_F_ACCESS_PLATFORM mandates more work on the
> side of the guest (and possibly he host side as well) than we actually
> need.
> 
> An additional benefit of teaching the guest to make the right decision
> (and use DMA API) on it's own is: removing the need, to mandate special
> VM configuration for guests that may run with protection. This is
> especially interesting for s390 as VIRTIO_F_IOMMU_PLATFORM pushes all
> the virtio control structures into the first 2G of guest memory:
> something we don't necessarily want to do per-default.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Ram Pai <linuxram@us.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>

This might work for you but it's fragile, since without
VIRTIO_F_ACCESS_PLATFORM hypervisor assumes it gets
GPA's, not DMA addresses.



IOW this looks like another iteration of:

	virtio: Support encrypted memory on powerpc secure guests

which I was under the impression was abandoned as unnecessary.


To summarize, the necessary conditions for a hack along these lines
(using DMA API without VIRTIO_F_ACCESS_PLATFORM) are that we detect that:

  - secure guest mode is enabled - so we know that since we don't share
    most memory regular virtio code won't
    work, even though the buggy hypervisor didn't set VIRTIO_F_ACCESS_PLATFORM
  - DMA API is giving us addresses that are actually also physical
    addresses
  - Hypervisor is buggy and didn't enable VIRTIO_F_ACCESS_PLATFORM
 
I don't see how this patch does this.


> ---
>  drivers/virtio/virtio_ring.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 867c7ebd3f10..fafc8f924955 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -243,6 +243,9 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>  	if (!virtio_has_iommu_quirk(vdev))
>  		return true;
>  
> +	if (force_dma_unencrypted(&vdev->dev))
> +		return true;
> +
>  	/* Otherwise, we are left to guess. */
>  	/*
>  	 * In theory, it's possible to have a buggy QEMU-supposed
> -- 
> 2.17.1

