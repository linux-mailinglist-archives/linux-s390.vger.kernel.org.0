Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F29A3DC19E
	for <lists+linux-s390@lfdr.de>; Fri, 18 Oct 2019 11:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392502AbfJRJqf (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 18 Oct 2019 05:46:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389411AbfJRJqf (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Oct 2019 05:46:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 14030C057F31;
        Fri, 18 Oct 2019 09:46:34 +0000 (UTC)
Received: from gondolin (dhcp-192-202.str.redhat.com [10.33.192.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD75B600C1;
        Fri, 18 Oct 2019 09:46:16 +0000 (UTC)
Date:   Fri, 18 Oct 2019 11:46:14 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com,
        alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        maxime.coquelin@redhat.com, cunming.liang@intel.com,
        zhihong.wang@intel.com, rob.miller@broadcom.com,
        xiao.w.wang@intel.com, haotian.wang@sifive.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com,
        oberpar@linux.ibm.com, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com,
        freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com,
        eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com,
        christophe.de.dinechin@gmail.com, kevin.tian@intel.com,
        stefanha@redhat.com
Subject: Re: [PATCH V4 4/6] mdev: introduce virtio device and its device ops
Message-ID: <20191018114614.6f1e79dc.cohuck@redhat.com>
In-Reply-To: <20191017104836.32464-5-jasowang@redhat.com>
References: <20191017104836.32464-1-jasowang@redhat.com>
        <20191017104836.32464-5-jasowang@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 18 Oct 2019 09:46:34 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 17 Oct 2019 18:48:34 +0800
Jason Wang <jasowang@redhat.com> wrote:

> This patch implements basic support for mdev driver that supports
> virtio transport for kernel virtio driver.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vfio/mdev/mdev_core.c |  12 +++
>  include/linux/mdev.h          |   4 +
>  include/linux/virtio_mdev.h   | 151 ++++++++++++++++++++++++++++++++++
>  3 files changed, 167 insertions(+)
>  create mode 100644 include/linux/virtio_mdev.h
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index d0f3113c8071..5834f6b7c7a5 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -57,6 +57,18 @@ void mdev_set_vfio_ops(struct mdev_device *mdev,
>  }
>  EXPORT_SYMBOL(mdev_set_vfio_ops);
>  
> +/* Specify the virtio device ops for the mdev device, this
> + * must be called during create() callback for virtio mdev device.
> + */

Change this as for the vfio comment (last patch?)

> +void mdev_set_virtio_ops(struct mdev_device *mdev,
> +			 const struct virtio_mdev_device_ops *virtio_ops)
> +{
> +	BUG_ON(mdev->class_id);

s/BUG_ON/WARN_ON/

> +	mdev->class_id = MDEV_CLASS_ID_VIRTIO;
> +	mdev->device_ops = virtio_ops;
> +}
> +EXPORT_SYMBOL(mdev_set_virtio_ops);
> +
>  const void *mdev_get_dev_ops(struct mdev_device *mdev)
>  {
>  	return mdev->device_ops;

(...)

> diff --git a/include/linux/virtio_mdev.h b/include/linux/virtio_mdev.h
> new file mode 100644
> index 000000000000..b965b50f9b24
> --- /dev/null
> +++ b/include/linux/virtio_mdev.h
> @@ -0,0 +1,151 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Virtio mediated device driver
> + *
> + * Copyright 2019, Red Hat Corp.
> + *     Author: Jason Wang <jasowang@redhat.com>
> + */
> +#ifndef _LINUX_VIRTIO_MDEV_H
> +#define _LINUX_VIRTIO_MDEV_H
> +
> +#include <linux/interrupt.h>
> +#include <linux/mdev.h>
> +#include <uapi/linux/vhost.h>
> +
> +#define VIRTIO_MDEV_DEVICE_API_STRING		"virtio-mdev"
> +#define VIRTIO_MDEV_F_VERSION_1 0x1
> +
> +struct virtio_mdev_callback {
> +	irqreturn_t (*callback)(void *data);
> +	void *private;
> +};
> +
> +/**
> + * struct vfio_mdev_device_ops - Structure to be registered for each
> + * mdev device to register the device to virtio-mdev module.
> + *
> + * @set_vq_address:		Set the address of virtqueue
> + *				@mdev: mediated device
> + *				@idx: virtqueue index
> + *				@desc_area: address of desc area
> + *				@driver_area: address of driver area
> + *				@device_area: address of device area
> + *				Returns integer: success (0) or error (< 0)

Probably dumb question (have not read the next patches yet): Is this
agnostic regarding split or packed queues?

> + * @set_vq_num:		Set the size of virtqueue
> + *				@mdev: mediated device
> + *				@idx: virtqueue index
> + *				@num: the size of virtqueue
> + * @kick_vq:			Kick the virtqueue
> + *				@mdev: mediated device
> + *				@idx: virtqueue index
> + * @set_vq_cb:			Set the interrupt callback function for
> + *				a virtqueue
> + *				@mdev: mediated device
> + *				@idx: virtqueue index
> + *				@cb: virtio-mdev interrupt callback structure
> + * @set_vq_ready:		Set ready status for a virtqueue
> + *				@mdev: mediated device
> + *				@idx: virtqueue index
> + *				@ready: ready (true) not ready(false)
> + * @get_vq_ready:		Get ready status for a virtqueue
> + *				@mdev: mediated device
> + *				@idx: virtqueue index
> + *				Returns boolean: ready (true) or not (false)
> + * @set_vq_state:		Set the state for a virtqueue
> + *				@mdev: mediated device
> + *				@idx: virtqueue index
> + *				@state: virtqueue state (last_avail_idx)
> + *				Returns integer: success (0) or error (< 0)
> + * @get_vq_state:		Get the state for a virtqueue
> + *				@mdev: mediated device
> + *				@idx: virtqueue index
> + *				Returns virtqueue state (last_avail_idx)
> + * @get_vq_align:		Get the virtqueue align requirement
> + *				for the device
> + *				@mdev: mediated device
> + *				Returns virtqueue algin requirement
> + * @get_features:		Get virtio features supported by the device
> + *				@mdev: mediated device
> + *				Returns the virtio features support by the
> + *				device
> + * @get_features:		Set virtio features supported by the driver

s/get_features/set_features/

> + *				@mdev: mediated device
> + *				@features: feature support by the driver
> + *				Returns integer: success (0) or error (< 0)
> + * @set_config_cb:		Set the config interrupt callback
> + *				@mdev: mediated device
> + *				@cb: virtio-mdev interrupt callback structure
> + * @get_vq_num_max:		Get the max size of virtqueue
> + *				@mdev: mediated device
> + *				Returns u16: max size of virtqueue
> + * @get_device_id:		Get virtio device id
> + *				@mdev: mediated device
> + *				Returns u32: virtio device id
> + * @get_vendor_id:		Get virtio vendor id
> + *				@mdev: mediated device
> + *				Returns u32: virtio vendor id

How is the vendor id defined? As for normal virtio-pci devices?

> + * @get_status: 		Get the device status
> + *				@mdev: mediated device
> + *				Returns u8: virtio device status
> + * @set_status: 		Set the device status
> + *				@mdev: mediated device
> + *				@status: virtio device status
> + * @get_config: 		Read from device specific configuration space
> + *				@mdev: mediated device
> + *				@offset: offset from the beginning of
> + *				configuration space
> + *				@buf: buffer used to read to
> + *				@len: the length to read from
> + *				configration space
> + * @set_config: 		Write to device specific configuration space
> + *				@mdev: mediated device
> + *				@offset: offset from the beginning of
> + *				configuration space
> + *				@buf: buffer used to write from
> + *				@len: the length to write to
> + *				configration space
> + * @get_mdev_features:		Get the feature of virtio mdev device
> + *				@mdev: mediated device
> + *				Returns the mdev features (API) support by
> + *				the device.

What kind of 'features' are supposed to go in there? Are these bits,
like you defined for VIRTIO_MDEV_F_VERSION_1 above?

> + * @get_generation:		Get device generaton
> + *				@mdev: mediated device
> + *				Returns u32: device generation

Is that callback mandatory?

> + */
> +struct virtio_mdev_device_ops {
> +	/* Virtqueue ops */
> +	int (*set_vq_address)(struct mdev_device *mdev,
> +			      u16 idx, u64 desc_area, u64 driver_area,
> +			      u64 device_area);
> +	void (*set_vq_num)(struct mdev_device *mdev, u16 idx, u32 num);
> +	void (*kick_vq)(struct mdev_device *mdev, u16 idx);
> +	void (*set_vq_cb)(struct mdev_device *mdev, u16 idx,
> +			  struct virtio_mdev_callback *cb);
> +	void (*set_vq_ready)(struct mdev_device *mdev, u16 idx, bool ready);
> +	bool (*get_vq_ready)(struct mdev_device *mdev, u16 idx);
> +	int (*set_vq_state)(struct mdev_device *mdev, u16 idx, u64 state);
> +	u64 (*get_vq_state)(struct mdev_device *mdev, u16 idx);
> +
> +	/* Device ops */
> +	u16 (*get_vq_align)(struct mdev_device *mdev);
> +	u64 (*get_features)(struct mdev_device *mdev);
> +	int (*set_features)(struct mdev_device *mdev, u64 features);
> +	void (*set_config_cb)(struct mdev_device *mdev,
> +			      struct virtio_mdev_callback *cb);
> +	u16 (*get_vq_num_max)(struct mdev_device *mdev);
> +	u32 (*get_device_id)(struct mdev_device *mdev);
> +	u32 (*get_vendor_id)(struct mdev_device *mdev);
> +	u8 (*get_status)(struct mdev_device *mdev);
> +	void (*set_status)(struct mdev_device *mdev, u8 status);
> +	void (*get_config)(struct mdev_device *mdev, unsigned int offset,
> +			   void *buf, unsigned int len);
> +	void (*set_config)(struct mdev_device *mdev, unsigned int offset,
> +			   const void *buf, unsigned int len);
> +	u64 (*get_mdev_features)(struct mdev_device *mdev);
> +	u32 (*get_generation)(struct mdev_device *mdev);
> +};
> +
> +void mdev_set_virtio_ops(struct mdev_device *mdev,
> +			 const struct virtio_mdev_device_ops *virtio_ops);
> +
> +#endif

