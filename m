Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4F56169F78
	for <lists+linux-s390@lfdr.de>; Mon, 24 Feb 2020 08:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgBXHtM (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 24 Feb 2020 02:49:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44051 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726452AbgBXHtL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Feb 2020 02:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582530549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UJzRHJfOvqED/QVB11a8FY9iUPPI3dbD0rzXCYDhwc0=;
        b=AYKvfRb+dvh6s+nQSmNoJs8I1zakq3ANxT7qmg3OQ9x8xSYIGp37vt7XY9Q+s7pasiRO5A
        6fXkjTdH8Z3IUDrDZg4G17d4/IaI8cpVoBNJCONynES7jzuoirW6jnEu7TdEnBkZshkVpU
        oCYA/PT3WSjBF+xgi562N/8xSkPeZIs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-TPgPnIfaPm6UlB2N5qYh8A-1; Mon, 24 Feb 2020 02:49:08 -0500
X-MC-Unique: TPgPnIfaPm6UlB2N5qYh8A-1
Received: by mail-qk1-f200.google.com with SMTP id r142so9725258qke.3
        for <linux-s390@vger.kernel.org>; Sun, 23 Feb 2020 23:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UJzRHJfOvqED/QVB11a8FY9iUPPI3dbD0rzXCYDhwc0=;
        b=cqrnDV2TWb8SggPLNlCbTtsljzZ0El0grMieAo4qjkzFvoBQZEELPcvN0oiPNhrbgV
         +O8UPW36j1drzsXr3id1rbR34zbr89qtjWip9l1R9nQYubPDkGr6ClmOQ+mqbRDKddsP
         NoJD3NDDaElATxX5X1dEHxRDMAnGoVQHpU82pJ14+00PkH4ode7L8uFGbX8aQR9knkvS
         6F7TsuwEGV7Jk6OOzqC4w5t+AeZhOnt2R3p5880JclqeeUvS55pF0z/27dHFIv+Sr9L0
         hZ89cAxuJa/Ghr1O8pFs9ocYQ5wWS1hCWI3sADtpEJxN/X4sRInxDlfVe7Pa7GHtYCUr
         rUbA==
X-Gm-Message-State: APjAAAXuKJ9lSNxK1oeWZ3HeLNIWkt3NsJ3QS5kWlbbtBR8OmPWYBWzC
        oPNWXvFnXxPSqiuSa3kfhGrSbEgm0nbsQ/e9K1fXBAyyJFUfo4jnjZJNBTUbayhA8PEJ3af243E
        8VQpT4xuoPscFmWoR0A3oIg==
X-Received: by 2002:a05:620a:95c:: with SMTP id w28mr44288185qkw.428.1582530547830;
        Sun, 23 Feb 2020 23:49:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqzzBrfPKkWekVzDtkE3twmNvbfgy+awAYxrqVqXXAqxHi9BwToMW+Zbt9HgNgV5bAhK+LRpaQ==
X-Received: by 2002:a05:620a:95c:: with SMTP id w28mr44288158qkw.428.1582530547478;
        Sun, 23 Feb 2020 23:49:07 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
        by smtp.gmail.com with ESMTPSA id r37sm5593220qtj.44.2020.02.23.23.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 23:49:06 -0800 (PST)
Date:   Mon, 24 Feb 2020 02:48:59 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
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
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200224024641-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
 <20200221155602.4de41fa7.pasic@linux.ibm.com>
 <0181712c-e533-fcfd-2638-8a0649d713dd@redhat.com>
 <20200224010607-mutt-send-email-mst@kernel.org>
 <b3c52c67-c740-a50e-2595-fe04d179c881@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3c52c67-c740-a50e-2595-fe04d179c881@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Feb 24, 2020 at 02:45:03PM +0800, Jason Wang wrote:
> 
> On 2020/2/24 下午2:06, Michael S. Tsirkin wrote:
> > On Mon, Feb 24, 2020 at 12:01:57PM +0800, Jason Wang wrote:
> > > On 2020/2/21 下午10:56, Halil Pasic wrote:
> > > > On Fri, 21 Feb 2020 14:22:26 +0800
> > > > Jason Wang <jasowang@redhat.com> wrote:
> > > > 
> > > > > On 2020/2/21 上午12:06, Halil Pasic wrote:
> > > > > > Currently if one intends to run a memory protection enabled VM with
> > > > > > virtio devices and linux as the guest OS, one needs to specify the
> > > > > > VIRTIO_F_IOMMU_PLATFORM flag for each virtio device to make the guest
> > > > > > linux use the DMA API, which in turn handles the memory
> > > > > > encryption/protection stuff if the guest decides to turn itself into
> > > > > > a protected one. This however makes no sense due to multiple reasons:
> > > > > > * The device is not changed by the fact that the guest RAM is
> > > > > > protected. The so called IOMMU bypass quirk is not affected.
> > > > > > * This usage is not congruent with  standardised semantics of
> > > > > > VIRTIO_F_IOMMU_PLATFORM. Guest memory protected is an orthogonal reason
> > > > > > for using DMA API in virtio (orthogonal with respect to what is
> > > > > > expressed by VIRTIO_F_IOMMU_PLATFORM).
> > > > > > 
> > > > > > This series aims to decouple 'have to use DMA API because my (guest) RAM
> > > > > > is protected' and 'have to use DMA API because the device told me
> > > > > > VIRTIO_F_IOMMU_PLATFORM'.
> > > > > > 
> > > > > > Please find more detailed explanations about the conceptual aspects in
> > > > > > the individual patches. There is however also a very practical problem
> > > > > > that is addressed by this series.
> > > > > > 
> > > > > > For vhost-net the feature VIRTIO_F_IOMMU_PLATFORM has the following side
> > > > > > effect The vhost code assumes it the addresses on the virtio descriptor
> > > > > > ring are not guest physical addresses but iova's, and insists on doing a
> > > > > > translation of these regardless of what transport is used (e.g. whether
> > > > > > we emulate a PCI or a CCW device). (For details see commit 6b1e6cc7855b
> > > > > > "vhost: new device IOTLB API".) On s390 this results in severe
> > > > > > performance degradation (c.a. factor 10).
> > > > > Do you see a consistent degradation on the performance, or it only
> > > > > happen when for during the beginning of the test?
> > > > > 
> > > > AFAIK the degradation is consistent.
> > > > 
> > > > > > BTW with ccw I/O there is
> > > > > > (architecturally) no IOMMU, so the whole address translation makes no
> > > > > > sense in the context of virtio-ccw.
> > > > > I suspect we can do optimization in qemu side.
> > > > > 
> > > > > E.g send memtable entry via IOTLB API when vIOMMU is not enabled.
> > > > > 
> > > > > If this makes sense, I can draft patch to see if there's any difference.
> > > > Frankly I would prefer to avoid IOVAs on the descriptor ring (and the
> > > > then necessary translation) for virtio-ccw altogether. But Michael
> > > > voiced his opinion that we should mandate F_IOMMU_PLATFORM for devices
> > > > that could be used with guests running in protected mode. I don't share
> > > > his opinion, but that's an ongoing discussion.
> > > > 
> > > > Should we end up having to do translation from IOVA in vhost, we are
> > > > very interested in that translation being fast and efficient.
> > > > 
> > > > In that sense we would be very happy to test any optimization that aim
> > > > into that direction.
> > > > 
> > > > Thank you very much for your input!
> > > 
> > > Using IOTLB API on platform without IOMMU support is not intended. Please
> > > try the attached patch to see if it helps.
> > > 
> > > Thanks
> > > 
> > > 
> > > > Regards,
> > > > Halil
> > > > 
> > > > > Thanks
> > > > > 
> > > > > 
> > > > > > Halil Pasic (2):
> > > > > >      mm: move force_dma_unencrypted() to mem_encrypt.h
> > > > > >      virtio: let virtio use DMA API when guest RAM is protected
> > > > > > 
> > > > > >     drivers/virtio/virtio_ring.c |  3 +++
> > > > > >     include/linux/dma-direct.h   |  9 ---------
> > > > > >     include/linux/mem_encrypt.h  | 10 ++++++++++
> > > > > >     3 files changed, 13 insertions(+), 9 deletions(-)
> > > > > > 
> > > > > > 
> > > > > > base-commit: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2
> > > >From 66fa730460875ac99e81d7db2334cd16bb1d2b27 Mon Sep 17 00:00:00 2001
> > > From: Jason Wang <jasowang@redhat.com>
> > > Date: Mon, 24 Feb 2020 12:00:10 +0800
> > > Subject: [PATCH] virtio: turn on IOMMU_PLATFORM properly
> > > 
> > > When transport does not support IOMMU, we should clear IOMMU_PLATFORM
> > > even if the device and vhost claims to support that. This help to
> > > avoid the performance overhead caused by unnecessary IOTLB miss/update
> > > transactions on such platform.
> > > 
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >   hw/virtio/virtio-bus.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> > > index d6332d45c3..2741b9fdd2 100644
> > > --- a/hw/virtio/virtio-bus.c
> > > +++ b/hw/virtio/virtio-bus.c
> > > @@ -47,7 +47,6 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
> > >       VirtioBusState *bus = VIRTIO_BUS(qbus);
> > >       VirtioBusClass *klass = VIRTIO_BUS_GET_CLASS(bus);
> > >       VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
> > > -    bool has_iommu = virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> > >       Error *local_err = NULL;
> > >       DPRINTF("%s: plug device.\n", qbus->name);
> > > @@ -77,10 +76,11 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
> > >           return;
> > >       }
> > > -    if (klass->get_dma_as != NULL && has_iommu) {
> > > -        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
> > > +    if (false && klass->get_dma_as != NULL &&
> > > +        virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
> > >           vdev->dma_as = klass->get_dma_as(qbus->parent);
> > >       } else {
> > > +        virtio_clear_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
> > >           vdev->dma_as = &address_space_memory;
> > >       }
> > >   }
> > 
> > This seems to clear it unconditionally. I guess it's just a debugging
> > patch, the real one will come later?
> 
> 
> My bad, here's the correct one.
> 
> Thanks
> 
> 
> > 
> > > -- 
> > > 2.19.1
> > > 

> >From b8a8b582f46bb86c7a745b272db7b744779e5cc7 Mon Sep 17 00:00:00 2001
> From: Jason Wang <jasowang@redhat.com>
> Date: Mon, 24 Feb 2020 12:00:10 +0800
> Subject: [PATCH] virtio: turn on IOMMU_PLATFORM properly
> 
> When transport does not support IOMMU, we should clear IOMMU_PLATFORM
> even if the device and vhost claims to support that. This help to
> avoid the performance overhead caused by unnecessary IOTLB miss/update
> transactions on such platform.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/virtio/virtio-bus.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> index d6332d45c3..4be64e193e 100644
> --- a/hw/virtio/virtio-bus.c
> +++ b/hw/virtio/virtio-bus.c
> @@ -47,7 +47,6 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
>      VirtioBusState *bus = VIRTIO_BUS(qbus);
>      VirtioBusClass *klass = VIRTIO_BUS_GET_CLASS(bus);
>      VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
> -    bool has_iommu = virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
>      Error *local_err = NULL;
>  
>      DPRINTF("%s: plug device.\n", qbus->name);
> @@ -77,10 +76,11 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
>          return;
>      }
>  
> -    if (klass->get_dma_as != NULL && has_iommu) {
> -        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);

So it looks like this line is unnecessary, but it's an unrelated
cleanup, right?

> +    if (klass->get_dma_as != NULL &&
> +        virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
>          vdev->dma_as = klass->get_dma_as(qbus->parent);
>      } else {
> +        virtio_clear_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);


Of course any change like that will have to affect migration compat, etc.
Can't we clear the bit when we are sending the features to vhost
instead?


>          vdev->dma_as = &address_space_memory;
>      }
>  }
> -- 
> 2.19.1
> 

