Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD0CBAC4A
	for <lists+linux-s390@lfdr.de>; Mon, 23 Sep 2019 03:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389406AbfIWBHB (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 22 Sep 2019 21:07:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388986AbfIWBHB (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 22 Sep 2019 21:07:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90431C051688;
        Mon, 23 Sep 2019 01:06:59 +0000 (UTC)
Received: from [10.72.12.112] (ovpn-12-112.pek2.redhat.com [10.72.12.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A96FC6092F;
        Mon, 23 Sep 2019 01:06:38 +0000 (UTC)
Subject: Re: [RFC PATCH V2 0/6] mdev based hardware virtio offloading support
To:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com,
        alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
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
        idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com,
        parav@mellanox.com
References: <20190920082050.19352-1-jasowang@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <0cea96a3-f941-3181-d320-7c15b33ad552@redhat.com>
Date:   Mon, 23 Sep 2019 09:06:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920082050.19352-1-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 23 Sep 2019 01:07:00 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 2019/9/20 下午4:20, Jason Wang wrote:
> Hi all:
>
> There are hardware that can do virtio datapath offloading while having
> its own control path. This path tries to implement a mdev based
> unified API to support using kernel virtio driver to drive those
> devices. This is done by introducing a new mdev transport for virtio
> (virtio_mdev) and register itself as a new kind of mdev driver. Then
> it provides a unified way for kernel virtio driver to talk with mdev
> device implementation.
>
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


CC Parav.

Thanks


>
> Changes from V1:
>
> - rename device id to class id
> - add docs for class id and device specific ops (device_ops)
> - split device_ops into seperate headers
> - drop the mdev_set_dma_ops()
> - use device_ops to implement the transport API, then it's not a part
>    of UAPI any more
> - use GFP_ATOMIC in mvnet sample device and other tweaks
> - set_vring_base/get_vring_base support for mvnet device
>
> Jason Wang (6):
>    mdev: class id support
>    mdev: introduce device specific ops
>    mdev: introduce virtio device and its device ops
>    virtio: introudce a mdev based transport
>    vringh: fix copy direction of vringh_iov_push_kern()
>    docs: Sample driver to demonstrate how to implement virtio-mdev
>      framework
>
>   .../driver-api/vfio-mediated-device.rst       |  11 +-
>   drivers/gpu/drm/i915/gvt/kvmgt.c              |  17 +-
>   drivers/s390/cio/vfio_ccw_ops.c               |  17 +-
>   drivers/s390/crypto/vfio_ap_ops.c             |  14 +-
>   drivers/vfio/mdev/Kconfig                     |   7 +
>   drivers/vfio/mdev/Makefile                    |   1 +
>   drivers/vfio/mdev/mdev_core.c                 |  21 +-
>   drivers/vfio/mdev/mdev_driver.c               |  14 +
>   drivers/vfio/mdev/mdev_private.h              |   1 +
>   drivers/vfio/mdev/vfio_mdev.c                 |  37 +-
>   drivers/vfio/mdev/virtio_mdev.c               | 418 +++++++++++
>   drivers/vhost/vringh.c                        |   8 +-
>   include/linux/mdev.h                          |  46 +-
>   include/linux/mod_devicetable.h               |   8 +
>   include/linux/vfio_mdev.h                     |  50 ++
>   include/linux/virtio_mdev.h                   | 141 ++++
>   samples/Kconfig                               |   7 +
>   samples/vfio-mdev/Makefile                    |   1 +
>   samples/vfio-mdev/mbochs.c                    |  19 +-
>   samples/vfio-mdev/mdpy.c                      |  19 +-
>   samples/vfio-mdev/mtty.c                      |  17 +-
>   samples/vfio-mdev/mvnet.c                     | 688 ++++++++++++++++++
>   22 files changed, 1473 insertions(+), 89 deletions(-)
>   create mode 100644 drivers/vfio/mdev/virtio_mdev.c
>   create mode 100644 include/linux/vfio_mdev.h
>   create mode 100644 include/linux/virtio_mdev.h
>   create mode 100644 samples/vfio-mdev/mvnet.c
>
