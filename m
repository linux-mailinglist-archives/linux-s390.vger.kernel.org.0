Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2DBBDDC0
	for <lists+linux-s390@lfdr.de>; Wed, 25 Sep 2019 14:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387930AbfIYMHL (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 25 Sep 2019 08:07:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfIYMHL (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Sep 2019 08:07:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF4B33082131;
        Wed, 25 Sep 2019 12:07:09 +0000 (UTC)
Received: from [10.72.12.148] (ovpn-12-148.pek2.redhat.com [10.72.12.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B716F6012E;
        Wed, 25 Sep 2019 12:06:30 +0000 (UTC)
Subject: Re: [PATCH V2 6/8] mdev: introduce virtio device and its device ops
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com,
        mst@redhat.com, tiwei.bie@intel.com,
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
        freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com,
        eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com,
        christophe.de.dinechin@gmail.com, kevin.tian@intel.com
References: <20190924135332.14160-1-jasowang@redhat.com>
 <20190924135332.14160-7-jasowang@redhat.com>
 <20190924170640.1da03bae@x1.home>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <3bb42d7c-b8d7-87d0-a2e0-52998f502efb@redhat.com>
Date:   Wed, 25 Sep 2019 20:06:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924170640.1da03bae@x1.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 25 Sep 2019 12:07:10 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 2019/9/25 上午7:06, Alex Williamson wrote:
> On Tue, 24 Sep 2019 21:53:30 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> This patch implements basic support for mdev driver that supports
>> virtio transport for kernel virtio driver.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>  include/linux/mdev.h        |   2 +
>>  include/linux/virtio_mdev.h | 145 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 147 insertions(+)
>>  create mode 100644 include/linux/virtio_mdev.h
>>
>> diff --git a/include/linux/mdev.h b/include/linux/mdev.h
>> index 3414307311f1..73ac27b3b868 100644
>> --- a/include/linux/mdev.h
>> +++ b/include/linux/mdev.h
>> @@ -126,6 +126,8 @@ struct mdev_device *mdev_from_dev(struct device *dev);
>>  
>>  enum {
>>  	MDEV_ID_VFIO = 1,
>> +	MDEV_ID_VIRTIO = 2,
>> +	MDEV_ID_VHOST = 3,
> MDEV_ID_VHOST isn't used yet here. 


Yes, just want to reserve one but it look too early to do that.


>  Also, given the strong
> interdependence between the class_id and the ops structure, we might
> wand to define them in the same place.  Thanks,
>
> Alex


Yes, as you suggest in patch 5/8.

Thanks


>
>>  	/* New entries must be added here */
>>  };
>>  
>> diff --git a/include/linux/virtio_mdev.h b/include/linux/virtio_mdev.h
>> new file mode 100644
>> index 000000000000..d1a40a739266
>> --- /dev/null
>> +++ b/include/linux/virtio_mdev.h
>> @@ -0,0 +1,145 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Virtio mediated device driver
>> + *
>> + * Copyright 2019, Red Hat Corp.
>> + *     Author: Jason Wang <jasowang@redhat.com>
>> + */
>> +#ifndef _LINUX_VIRTIO_MDEV_H
>> +#define _LINUX_VIRTIO_MDEV_H
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/mdev.h>
>> +#include <uapi/linux/vhost.h>
>> +
>> +#define VIRTIO_MDEV_DEVICE_API_STRING		"virtio-mdev"
>> +#define VIRTIO_MDEV_VERSION 0x1
>> +
>> +struct virtio_mdev_callback {
>> +	irqreturn_t (*callback)(void *data);
>> +	void *private;
>> +};
>> +
>> +/**
>> + * struct vfio_mdev_device_ops - Structure to be registered for each
>> + * mdev device to register the device to virtio-mdev module.
>> + *
>> + * @set_vq_address:		Set the address of virtqueue
>> + *				@mdev: mediated device
>> + *				@idx: virtqueue index
>> + *				@desc_area: address of desc area
>> + *				@driver_area: address of driver area
>> + *				@device_area: address of device area
>> + *				Returns integer: success (0) or error (< 0)
>> + * @set_vq_num:		Set the size of virtqueue
>> + *				@mdev: mediated device
>> + *				@idx: virtqueue index
>> + *				@num: the size of virtqueue
>> + * @kick_vq:			Kick the virtqueue
>> + *				@mdev: mediated device
>> + *				@idx: virtqueue index
>> + * @set_vq_cb:			Set the interrut calback function for
>> + *				a virtqueue
>> + *				@mdev: mediated device
>> + *				@idx: virtqueue index
>> + *				@cb: virtio-mdev interrupt callback structure
>> + * @set_vq_ready:		Set ready status for a virtqueue
>> + *				@mdev: mediated device
>> + *				@idx: virtqueue index
>> + *				@ready: ready (true) not ready(false)
>> + * @get_vq_ready:		Get ready status for a virtqueue
>> + *				@mdev: mediated device
>> + *				@idx: virtqueue index
>> + *				Returns boolean: ready (true) or not (false)
>> + * @set_vq_state:		Set the state for a virtqueue
>> + *				@mdev: mediated device
>> + *				@idx: virtqueue index
>> + *				@state: virtqueue state (last_avail_idx)
>> + *				Returns integer: success (0) or error (< 0)
>> + * @get_vq_state:		Get the state for a virtqueue
>> + *				@mdev: mediated device
>> + *				@idx: virtqueue index
>> + *				Returns virtqueue state (last_avail_idx)
>> + * @get_vq_align:		Get the virtqueue align requirement
>> + *				for the device
>> + *				@mdev: mediated device
>> + *				Returns virtqueue algin requirement
>> + * @get_features:		Get virtio features supported by the device
>> + *				@mdev: mediated device
>> + *				Returns the features support by the
>> + *				device
>> + * @get_features:		Set virtio features supported by the driver
>> + *				@mdev: mediated device
>> + *				@features: feature support by the driver
>> + *				Returns integer: success (0) or error (< 0)
>> + * @set_config_cb:		Set the config interrupt callback
>> + *				@mdev: mediated device
>> + *				@cb: virtio-mdev interrupt callback structure
>> + * @get_device_id:		Get virtio device id
>> + *				@mdev: mediated device
>> + *				Returns u32: virtio device id
>> + * @get_vendor_id:		Get virtio vendor id
>> + *				@mdev: mediated device
>> + *				Returns u32: virtio vendor id
>> + * @get_status:		Get the device status
>> + *				@mdev: mediated device
>> + *				Returns u8: virtio device status
>> + * @set_status:		Set the device status
>> + *				@mdev: mediated device
>> + *				@status: virtio device status
>> + * @get_config:		Read from device specific confiugration space
>> + *				@mdev: mediated device
>> + *				@offset: offset from the beginning of
>> + *				configuration space
>> + *				@buf: buffer used to read to
>> + *				@len: the length to read from
>> + *				configration space
>> + * @set_config:		Write to device specific confiugration space
>> + *				@mdev: mediated device
>> + *				@offset: offset from the beginning of
>> + *				configuration space
>> + *				@buf: buffer used to write from
>> + *				@len: the length to write to
>> + *				configration space
>> + * @get_version:		Get the version of virtio mdev device
>> + *				@mdev: mediated device
>> + *				Returns integer: version of the device
>> + * @get_generation:		Get device generaton
>> + *				@mdev: mediated device
>> + *				Returns u32: device generation
>> + */
>> +struct virtio_mdev_device_ops {
>> +	/* Virtqueue ops */
>> +	int (*set_vq_address)(struct mdev_device *mdev,
>> +			      u16 idx, u64 desc_area, u64 driver_area,
>> +			      u64 device_area);
>> +	void (*set_vq_num)(struct mdev_device *mdev, u16 idx, u32 num);
>> +	void (*kick_vq)(struct mdev_device *mdev, u16 idx);
>> +	void (*set_vq_cb)(struct mdev_device *mdev, u16 idx,
>> +			  struct virtio_mdev_callback *cb);
>> +	void (*set_vq_ready)(struct mdev_device *mdev, u16 idx, bool ready);
>> +	bool (*get_vq_ready)(struct mdev_device *mdev, u16 idx);
>> +	int (*set_vq_state)(struct mdev_device *mdev, u16 idx, u64 state);
>> +	u64 (*get_vq_state)(struct mdev_device *mdev, u16 idx);
>> +
>> +	/* Device ops */
>> +	u16 (*get_vq_align)(struct mdev_device *mdev);
>> +	u64 (*get_features)(struct mdev_device *mdev);
>> +	int (*set_features)(struct mdev_device *mdev, u64 features);
>> +	void (*set_config_cb)(struct mdev_device *mdev,
>> +			      struct virtio_mdev_callback *cb);
>> +	u16 (*get_queue_max)(struct mdev_device *mdev);
>> +	u32 (*get_device_id)(struct mdev_device *mdev);
>> +	u32 (*get_vendor_id)(struct mdev_device *mdev);
>> +	u8 (*get_status)(struct mdev_device *mdev);
>> +	void (*set_status)(struct mdev_device *mdev, u8 status);
>> +	void (*get_config)(struct mdev_device *mdev, unsigned int offset,
>> +			   void *buf, unsigned int len);
>> +	void (*set_config)(struct mdev_device *mdev, unsigned int offset,
>> +			   const void *buf, unsigned int len);
>> +	int (*get_version)(struct mdev_device *mdev);
>> +	u32 (*get_generation)(struct mdev_device *mdev);
>> +};
>> +
>> +#endif
>> +
