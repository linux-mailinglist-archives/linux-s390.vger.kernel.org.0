Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09DBA334B3
	for <lists+linux-s390@lfdr.de>; Mon,  3 Jun 2019 18:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfFCQR1 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 3 Jun 2019 12:17:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfFCQR1 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 3 Jun 2019 12:17:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA7AF30860AD;
        Mon,  3 Jun 2019 16:17:26 +0000 (UTC)
Received: from gondolin (ovpn-204-96.brq.redhat.com [10.40.204.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C92DD10013D9;
        Mon,  3 Jun 2019 16:17:19 +0000 (UTC)
Date:   Mon, 3 Jun 2019 18:17:16 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Michael Mueller <mimu@linux.ibm.com>
Cc:     KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        virtualization@lists.linux-foundation.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Huth <thuth@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v3 7/8] virtio/s390: use DMA memory for ccw I/O and
 classic notifiers
Message-ID: <20190603181716.325101d9.cohuck@redhat.com>
In-Reply-To: <20190529122657.166148-8-mimu@linux.ibm.com>
References: <20190529122657.166148-1-mimu@linux.ibm.com>
        <20190529122657.166148-8-mimu@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 03 Jun 2019 16:17:26 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 29 May 2019 14:26:56 +0200
Michael Mueller <mimu@linux.ibm.com> wrote:

> From: Halil Pasic <pasic@linux.ibm.com>
> 
> Before virtio-ccw could get away with not using DMA API for the pieces of
> memory it does ccw I/O with. With protected virtualization this has to
> change, since the hypervisor needs to read and sometimes also write these
> pieces of memory.
> 
> The hypervisor is supposed to poke the classic notifiers, if these are
> used, out of band with regards to ccw I/O. So these need to be allocated
> as DMA memory (which is shared memory for protected virtualization
> guests).
> 
> Let us factor out everything from struct virtio_ccw_device that needs to
> be DMA memory in a satellite that is allocated as such.
> 
> Note: The control blocks of I/O instructions do not need to be shared.
> These are marshalled by the ultravisor.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 177 +++++++++++++++++++++------------------
>  1 file changed, 96 insertions(+), 81 deletions(-)
> 

(...)

> @@ -176,6 +180,22 @@ static struct virtio_ccw_device *to_vc_device(struct virtio_device *vdev)
>  	return container_of(vdev, struct virtio_ccw_device, vdev);
>  }
>  
> +static inline void *__vc_dma_alloc(struct virtio_device *vdev, size_t size)
> +{
> +	return ccw_device_dma_zalloc(to_vc_device(vdev)->cdev, size);
> +}
> +
> +static inline void __vc_dma_free(struct virtio_device *vdev, size_t size,
> +				 void *cpu_addr)
> +{
> +	return ccw_device_dma_free(to_vc_device(vdev)->cdev, cpu_addr, size);
> +}
> +
> +#define vc_dma_alloc_struct(vdev, ptr) \
> +	({ptr = __vc_dma_alloc(vdev, sizeof(*(ptr))); })
> +#define vc_dma_free_struct(vdev, ptr) \
> +	__vc_dma_free(vdev, sizeof(*(ptr)), (ptr))
> +

I *still* don't like these #defines (and the __vc_dma_* functions), as I
already commented last time. I think they make it harder to follow the
code.

>  static void drop_airq_indicator(struct virtqueue *vq, struct airq_info *info)
>  {
>  	unsigned long i, flags;
> @@ -336,8 +356,7 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
>  	struct airq_info *airq_info = vcdev->airq_info;
>  
>  	if (vcdev->is_thinint) {
> -		thinint_area = kzalloc(sizeof(*thinint_area),
> -				       GFP_DMA | GFP_KERNEL);
> +		vc_dma_alloc_struct(&vcdev->vdev, thinint_area);

Last time I wrote:

"Any reason why this takes a detour via the virtio device? The ccw
 device is already referenced in vcdev, isn't it?

thinint_area = ccw_device_dma_zalloc(vcdev->cdev, sizeof(*thinint_area));

 looks much more obvious to me."

It still seems more obvious to me.

>  		if (!thinint_area)
>  			return;
>  		thinint_area->summary_indicator =
