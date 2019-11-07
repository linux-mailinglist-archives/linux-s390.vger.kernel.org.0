Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8623DF33D7
	for <lists+linux-s390@lfdr.de>; Thu,  7 Nov 2019 16:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388970AbfKGPyi (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 7 Nov 2019 10:54:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfKGPyh (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 7 Nov 2019 10:54:37 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 188D183F42
        for <linux-s390@vger.kernel.org>; Thu,  7 Nov 2019 15:54:37 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id h15so3097342qtn.6
        for <linux-s390@vger.kernel.org>; Thu, 07 Nov 2019 07:54:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BBCrA8jI8FYav5dUH4JsIvDsqU9jbzWbW4UmAoXMTfU=;
        b=irIHRAZIQ9+VhZDpLFGm0Tx28C+hb7HGCKlKc7AP8yztIq9Q1fY8NeTrXwtNV5vF4Z
         q3BI+JQP/TfYTGlMtlHNiqx7S3spkzYpJlOVOV6paPjyA0LOh/xqSxfkIfH66mcLxDQl
         E40x2JhexGyxOpOZT9mpmX/z65R04UANqhrPsJavqsY62HS3RzoCGmrit5X+ndLLCh8y
         su/u/o2a8LU2dcHeWEGRUD9XaxxDDfvoBzzRofdJ/SEIIJc8+RMecqfaztDVz+uIfKEW
         sYCG2CpqlRCCT2kDLTnoJA1Gs9WBRltJt+KqXfzU5r0CGUK3ut92SWlJsV4oFUQVsLWW
         W0lw==
X-Gm-Message-State: APjAAAXnOzDTTafcvwiogCljsLD849DLKatz1pTJB20sEaOEpjOrfuVh
        NRBtLBCTa2uV4HVUt+OX7r+++/wDuLd4crUw05uHKlVmUIHIyxR9NQlu5C23ie1HJnf4pWVs5OC
        7JfUr25iHNIMF/61PVbyf9Q==
X-Received: by 2002:a05:620a:226:: with SMTP id u6mr3459300qkm.393.1573142076271;
        Thu, 07 Nov 2019 07:54:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqxSgLzGIZB2AaYtHaY2RkdEidB2NeRk+OXmCkV1uMYYneoFbHELGewocRRkI4W/JRZGPMhgWA==
X-Received: by 2002:a05:620a:226:: with SMTP id u6mr3459254qkm.393.1573142075868;
        Thu, 07 Nov 2019 07:54:35 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
        by smtp.gmail.com with ESMTPSA id 50sm2019631qtv.88.2019.11.07.07.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 07:54:34 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:54:22 -0500
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
        freude@linux.ibm.com, lingshan.zhu@intel.com, eperezma@redhat.com,
        lulu@redhat.com, parav@mellanox.com,
        christophe.de.dinechin@gmail.com, kevin.tian@intel.com,
        stefanha@redhat.com, rdunlap@infradead.org
Subject: Re: [PATCH V11 0/6] mdev based hardware virtio offloading support
Message-ID: <20191107105412-mutt-send-email-mst@kernel.org>
References: <20191107151109.23261-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107151109.23261-1-jasowang@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Nov 07, 2019 at 11:11:03PM +0800, Jason Wang wrote:
> Hi all:
> 
> There are hardwares that can do virtio datapath offloading while
> having its own control path. This path tries to implement a mdev based
> unified API to support using kernel virtio driver to drive those
> devices. This is done by introducing a new mdev transport for virtio
> (virtio_mdev) and register itself as a new kind of mdev driver. Then
> it provides a unified way for kernel virtio driver to talk with mdev
> device implementation.
> 
> Though the series only contains kernel driver support, the goal is to
> make the transport generic enough to support userspace drivers. This
> means vhost-mdev[1] could be built on top as well by resuing the
> transport.
> 
> A sample driver is also implemented which simulate a virito-net
> loopback ethernet device on top of vringh + workqueue. This could be
> used as a reference implementation for real hardware driver.
> 
> Also a real IFC VF driver was also posted here[2] which is a good
> reference for vendors who is interested in their own virtio datapath
> offloading product.
> 
> Consider mdev framework only support VFIO device and driver right now,
> this series also extend it to support other types. This is done
> through introducing class id to the device and pairing it with
> id_talbe claimed by the driver. On top, this seris also decouple
> device specific ops out of the common ones for implementing class
> specific operations over mdev bus.
> 
> Pktgen test was done with virito-net + mvnet loop back device.
> 
> Please review.
> 
> [1] https://lkml.org/lkml/2019/11/5/424
> [2] https://lkml.org/lkml/2019/11/5/227
> 
> Changes from V10:
> - rename mvnet to mvnet_loopback
> - fix typo in the help text for sample Kconfig

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> Changes from V9:
> - Tweak the help text for virito-mdev kconfig
> 
> Changes from V8:
> - try silent checkpatch, some are still there becuase they were inherited
>   from virtio_config_ops which needs to be resolved in an independent series
> - tweak on the comment and doc
> - remove VIRTIO_MDEV_F_VERSION_1 completely
> - rename CONFIG_VIRTIO_MDEV_DEVICE to CONFIG_VIRTIO_MDEV
> 
> Changes from V7:
> - drop {set|get}_mdev_features for virtio
> - typo and comment style fixes
> 
> Changes from V6:
> - rename ops files and compile guard
> 
> Changes from V5:
> - use dev_warn() instead of WARN(1) when class id is not set
> - validate id_table before trying to do matching between device and
>   driver
> - add wildcard for modpost script
> - use unique name for id_table
> - move get_mdev_features() to be the first member of virtio_device_ops
>   and more comments for it
> - typo fixes for the comments above virtio_mdev_ops
> 
> Changes from V4:
> - keep mdev_set_class() for the device that doesn't use device ops
> - use union for device ops pointer in mdev_device
> - introduce class specific helper for getting is device ops
> - use WARN_ON instead of BUG_ON in mdev_set_virtio_ops
> - explain details of get_mdev_features() and get_vendor_id()
> - distinguish the optional virito device ops from mandatory ones and
>   make get_generation() optional
> - rename vfio_mdev.h to vfio_mdev_ops.h, rename virito_mdev.h to
>   virtio_mdev_ops.h
> - don't abuse version fileds in virtio_mdev structure, use features
>   instead
> - fix warning during device remove
> - style & docs tweaks and typo fixes
> 
> Changes from V3:
> - document that class id (device ops) must be specified in create()
> - add WARN() when trying to set class_id when it has already set
> - add WARN() when class_id is not specified in create() and correctly
>   return an error in this case
> - correct the prototype of mdev_set_class() in the doc
> - add documention of mdev_set_class()
> - remove the unnecessary "class_id_fail" label when class id is not
>   specified in create()
> - convert id_table in vfio_mdev to const
> - move mdev_set_class and its friends after mdev_uuid()
> - suqash the patch of bus uevent into patch of introducing class id
> - tweak the words in the docs per Cornelia suggestion
> - tie class_id and device ops through class specific initialization
>   routine like mdev_set_vfio_ops()
> - typos fixes in the docs of virtio-mdev callbacks
> - document the usage of virtqueues in struct virtio_mdev_device
> - remove the useless vqs array in struct virtio_mdev_device
> - rename MDEV_ID_XXX to MDEV_CLASS_ID_XXX
> 
> Changes from V2:
> - fail when class_id is not specified
> - drop the vringh patch
> - match the doc to the code
> - tweak the commit log
> - move device_ops from parent to mdev device
> - remove the unused MDEV_ID_VHOST
> 
> Changes from V1:
> - move virtio_mdev.c to drivers/virtio
> - store class_id in mdev_device instead of mdev_parent
> - store device_ops in mdev_device instead of mdev_parent
> - reorder the patch, vringh fix comes first
> - really silent compiling warnings
> - really switch to use u16 for class_id
> - uevent and modpost support for mdev class_id
> - vraious tweaks per comments from Parav
> 
> Changes from RFC-V2:
> - silent compile warnings on some specific configuration
> - use u16 instead u8 for class id
> - reseve MDEV_ID_VHOST for future vhost-mdev work
> - introduce "virtio" type for mvnet and make "vhost" type for future
>   work
> - add entries in MAINTAINER
> - tweak and typos fixes in commit log
> 
> Changes from RFC-V1:
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
>   modpost: add support for mdev class id
>   mdev: introduce device specific ops
>   mdev: introduce virtio device and its device ops
>   virtio: introduce a mdev based transport
>   docs: sample driver to demonstrate how to implement virtio-mdev
>     framework
> 
>  .../driver-api/vfio-mediated-device.rst       |  38 +-
>  MAINTAINERS                                   |   3 +
>  drivers/gpu/drm/i915/gvt/kvmgt.c              |  17 +-
>  drivers/s390/cio/vfio_ccw_ops.c               |  17 +-
>  drivers/s390/crypto/vfio_ap_ops.c             |  13 +-
>  drivers/vfio/mdev/mdev_core.c                 |  60 ++
>  drivers/vfio/mdev/mdev_driver.c               |  25 +
>  drivers/vfio/mdev/mdev_private.h              |   8 +
>  drivers/vfio/mdev/vfio_mdev.c                 |  45 +-
>  drivers/virtio/Kconfig                        |  13 +
>  drivers/virtio/Makefile                       |   1 +
>  drivers/virtio/virtio_mdev.c                  | 406 +++++++++++
>  include/linux/mdev.h                          |  57 +-
>  include/linux/mdev_vfio_ops.h                 |  52 ++
>  include/linux/mdev_virtio_ops.h               | 147 ++++
>  include/linux/mod_devicetable.h               |   8 +
>  samples/Kconfig                               |  10 +
>  samples/vfio-mdev/Makefile                    |   1 +
>  samples/vfio-mdev/mbochs.c                    |  19 +-
>  samples/vfio-mdev/mdpy.c                      |  19 +-
>  samples/vfio-mdev/mtty.c                      |  17 +-
>  samples/vfio-mdev/mvnet_loopback.c            | 687 ++++++++++++++++++
>  scripts/mod/devicetable-offsets.c             |   3 +
>  scripts/mod/file2alias.c                      |  11 +
>  24 files changed, 1586 insertions(+), 91 deletions(-)
>  create mode 100644 drivers/virtio/virtio_mdev.c
>  create mode 100644 include/linux/mdev_vfio_ops.h
>  create mode 100644 include/linux/mdev_virtio_ops.h
>  create mode 100644 samples/vfio-mdev/mvnet_loopback.c
> 
> -- 
> 2.19.1
