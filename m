Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAE5BB391
	for <lists+linux-s390@lfdr.de>; Mon, 23 Sep 2019 14:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbfIWMVv (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 23 Sep 2019 08:21:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfIWMVv (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Sep 2019 08:21:51 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B1CA89AC4
        for <linux-s390@vger.kernel.org>; Mon, 23 Sep 2019 12:21:51 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id x77so17287900qka.11
        for <linux-s390@vger.kernel.org>; Mon, 23 Sep 2019 05:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a9/IjKSOTtP+H0DwvJWJwjvwhzIswSQaCoNDgf8fYiY=;
        b=qlDEH0n8E48eCzDBtCNatrOS0pjUi+qFFfEDNC7KNeyyvidWaRsQCTAqKyPNTVrMd+
         oeWyDc+w7au62J0COsPfUV5iHe5ngXIz76t+IeKHXasF63MKXDSWkt3uMUzvn1tWmlC6
         L+KxxO39meFYcZfyNnZ8+bfjk9zm4FvoTncYri8Xq1uUZaEfcWg0zqt2Bm35vRuzevUi
         v+q2lkLdwGoUs3NzXWWzEJf4F7LxxHPgzg1clRkUVCFrzlXcwGbdVArOvqrnmbz1+sXQ
         jFyD0c+mxqKhGcqU6yvSMQZzm1o3y5u2Bd+gvueoXQGj70u8HLheo/pQJiE0zjv7OKXh
         Cuqg==
X-Gm-Message-State: APjAAAUihhvjjqvLBBI+rc2+n3JGxKl/3/pYDOQpNnUpYJMG+gUAO0h1
        PumDBq4JU8gE57/wwrj4kvQujCJtGjdEbO4YAVx3vuZO33aoeUN+lPx7k7ei4snnm+vz80K27No
        kMRanlj3B40NV3Kd7Ovt0Nw==
X-Received: by 2002:ac8:7117:: with SMTP id z23mr16276190qto.309.1569241310357;
        Mon, 23 Sep 2019 05:21:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy19kCOwHbgejDjIiixAFXfW0feeppk9Ux+t6GtFmBM+eqf5FZ/rCyZVT2dupdlVrgcrW4SDA==
X-Received: by 2002:ac8:7117:: with SMTP id z23mr16276147qto.309.1569241310042;
        Mon, 23 Sep 2019 05:21:50 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id o38sm6573805qtc.39.2019.09.23.05.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 05:21:48 -0700 (PDT)
Date:   Mon, 23 Sep 2019 08:21:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com,
        alex.williamson@redhat.com, tiwei.bie@intel.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        cohuck@redhat.com, maxime.coquelin@redhat.com,
        cunming.liang@intel.com, zhihong.wang@intel.com,
        rob.miller@broadcom.com, xiao.w.wang@intel.com,
        haotian.wang@sifive.com, zhenyuw@linux.intel.com,
        zhi.a.wang@intel.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com,
        pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, akrowiak@linux.ibm.com,
        pmorel@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com,
        idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com
Subject: Re: [RFC PATCH V2 0/6] mdev based hardware virtio offloading support
Message-ID: <20190923074913-mutt-send-email-mst@kernel.org>
References: <20190920082050.19352-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920082050.19352-1-jasowang@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Sep 20, 2019 at 04:20:44PM +0800, Jason Wang wrote:
> Hi all:
> 
> There are hardware that can do virtio datapath offloading while having
> its own control path. This path tries to implement a mdev based
> unified API to support using kernel virtio driver to drive those
> devices. This is done by introducing a new mdev transport for virtio
> (virtio_mdev) and register itself as a new kind of mdev driver. Then
> it provides a unified way for kernel virtio driver to talk with mdev
> device implementation.

This is actually simple enough that I'm inclined to just
put this into linux-next.
This mixes virtio and vfio so the code can thinkably
be merged through either tree.
Alex, any strong opinions on any of this?

> Though the series only contain kernel driver support, the goal is to
> make the transport generic enough to support userspace drivers. This
> means vhost-mdev[1] could be built on top as well by resuing the
> transport.
> 
> A sample driver is also implemented which simulate a virito-net
> loopback ethernet device on top of vringh + workqueue. This could be
> used as a reference implementation for real hardware driver.
> 
> Consider mdev framework only support VFIO device and driver right now,
> this series also extend it to support other types. This is done
> through introducing class id to the device and pairing it with
> id_talbe claimed by the driver. On top, this seris also decouple
> device specific parents ops out of the common ones.
> 
> Pktgen test was done with virito-net + mvnet loop back device.
> 
> Please review.
> 
> Changes from V1:
> 
> - rename device id to class id
> - add docs for class id and device specific ops (device_ops)
> - split device_ops into seperate headers
> - drop the mdev_set_dma_ops()
> - use device_ops to implement the transport API, then it's not a part
>   of UAPI any more
> - use GFP_ATOMIC in mvnet sample device and other tweaks
> - set_vring_base/get_vring_base support for mvnet device
> 
> Jason Wang (6):
>   mdev: class id support
>   mdev: introduce device specific ops
>   mdev: introduce virtio device and its device ops
>   virtio: introudce a mdev based transport
>   vringh: fix copy direction of vringh_iov_push_kern()
>   docs: Sample driver to demonstrate how to implement virtio-mdev
>     framework
> 
>  .../driver-api/vfio-mediated-device.rst       |  11 +-
>  drivers/gpu/drm/i915/gvt/kvmgt.c              |  17 +-
>  drivers/s390/cio/vfio_ccw_ops.c               |  17 +-
>  drivers/s390/crypto/vfio_ap_ops.c             |  14 +-
>  drivers/vfio/mdev/Kconfig                     |   7 +
>  drivers/vfio/mdev/Makefile                    |   1 +
>  drivers/vfio/mdev/mdev_core.c                 |  21 +-
>  drivers/vfio/mdev/mdev_driver.c               |  14 +
>  drivers/vfio/mdev/mdev_private.h              |   1 +
>  drivers/vfio/mdev/vfio_mdev.c                 |  37 +-
>  drivers/vfio/mdev/virtio_mdev.c               | 418 +++++++++++
>  drivers/vhost/vringh.c                        |   8 +-
>  include/linux/mdev.h                          |  46 +-
>  include/linux/mod_devicetable.h               |   8 +
>  include/linux/vfio_mdev.h                     |  50 ++
>  include/linux/virtio_mdev.h                   | 141 ++++
>  samples/Kconfig                               |   7 +
>  samples/vfio-mdev/Makefile                    |   1 +
>  samples/vfio-mdev/mbochs.c                    |  19 +-
>  samples/vfio-mdev/mdpy.c                      |  19 +-
>  samples/vfio-mdev/mtty.c                      |  17 +-
>  samples/vfio-mdev/mvnet.c                     | 688 ++++++++++++++++++
>  22 files changed, 1473 insertions(+), 89 deletions(-)
>  create mode 100644 drivers/vfio/mdev/virtio_mdev.c
>  create mode 100644 include/linux/vfio_mdev.h
>  create mode 100644 include/linux/virtio_mdev.h
>  create mode 100644 samples/vfio-mdev/mvnet.c
> 
> -- 
> 2.19.1
