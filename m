Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFF6563025
	for <lists+linux-s390@lfdr.de>; Fri,  1 Jul 2022 11:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiGAJcB (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 1 Jul 2022 05:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiGAJb5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 Jul 2022 05:31:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B0E672ECD
        for <linux-s390@vger.kernel.org>; Fri,  1 Jul 2022 02:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656667916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DCnH+p8P5O1tP//jNNfRvqUnP248atTd06tmppMrMwQ=;
        b=QCOkNVRFaYQhlzj3ZhYGIa8lo0AjBXFpLyDmLGhQedzYlEQjtIp9ODRbGOim5cO8MI/Xkc
        TQti+O9GFO6HmE6srbOWvc1/j819l4AAvI4WsPmHiqZI3gv67Eloi46queYpv67438nwaN
        EHm4aCuIHSumOLemGr4djwPeNyfTZ1w=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-S4nJqHLYMG6szr19Cb2EyA-1; Fri, 01 Jul 2022 05:31:47 -0400
X-MC-Unique: S4nJqHLYMG6szr19Cb2EyA-1
Received: by mail-pl1-f199.google.com with SMTP id a10-20020a170902ecca00b0016a50049af0so1211070plh.10
        for <linux-s390@vger.kernel.org>; Fri, 01 Jul 2022 02:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DCnH+p8P5O1tP//jNNfRvqUnP248atTd06tmppMrMwQ=;
        b=xVBIO41NzRN03NKWrtCEsgrKGg0eVOep6Oo+azGPUhKitRT4wbXT/Pe4YC3YhtVRG2
         3sOSRO8exgPlR9OgnZARVv+CsNA+tE74QUTCd2yD3+8yXUH/jCradzVJFyBo9PKJKBI0
         iWSiP3DwyRY/ShE7eNi0/jOoUzArJVB8cEDBP0jfsfT/Y+uN4BQ8ytvyKB0NZGXwSeum
         IJjHllKZ+/h4kNmj9wUngBawR0Dh6jrz3UP86euidd0quwuHhOibkU7oUGhmYCqJC97U
         8No0NkxUd73RCgeqQo6xMbZQhiJQSZJ/ZdrOdQRqtcTQK/+AYJWSKYGLeNN1+dQp5+NI
         g52A==
X-Gm-Message-State: AJIora+2jeixV/TTR7XKhL4A6I2FuU85otOXlb5mofHSnazFvfkIWv/1
        vIRrn+WfM8kLqjsFZEABZ7YRYPahUpwqD9D8k/P8Nr3iq5Wosyb8RaJjZ3YXdkXqyOjKIkmQqSd
        bv0NMYN1mTeJQqnUE0UcquQ==
X-Received: by 2002:a05:6a00:3006:b0:525:266a:852e with SMTP id ay6-20020a056a00300600b00525266a852emr20298526pfb.60.1656667906363;
        Fri, 01 Jul 2022 02:31:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uKrApfLpVijt+2Yurlxy1RscauWDUj8Cy3/b4ekNnk2oyxMF7zuXLSzduxf7YrkXGtDZvHNA==
X-Received: by 2002:a05:6a00:3006:b0:525:266a:852e with SMTP id ay6-20020a056a00300600b00525266a852emr20298498pfb.60.1656667906086;
        Fri, 01 Jul 2022 02:31:46 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id cu7-20020a056a00448700b00525373aac7csm14994715pfb.26.2022.07.01.02.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 02:31:45 -0700 (PDT)
Message-ID: <d3788739-1c7f-4f1e-a222-f83bd73c14a1@redhat.com>
Date:   Fri, 1 Jul 2022 17:31:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 22/40] virtio_ring: introduce virtqueue_resize()
Content-Language: en-US
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, netdev@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org,
        kangjie.xu@linux.alibaba.com
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-23-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-23-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


在 2022/6/29 14:56, Xuan Zhuo 写道:
> Introduce virtqueue_resize() to implement the resize of vring.
> Based on these, the driver can dynamically adjust the size of the vring.
> For example: ethtool -G.
>
> virtqueue_resize() implements resize based on the vq reset function. In
> case of failure to allocate a new vring, it will give up resize and use
> the original vring.
>
> During this process, if the re-enable reset vq fails, the vq can no
> longer be used. Although the probability of this situation is not high.
>
> The parameter recycle is used to recycle the buffer that is no longer
> used.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   drivers/virtio/virtio_ring.c | 72 ++++++++++++++++++++++++++++++++++++
>   include/linux/virtio.h       |  3 ++
>   2 files changed, 75 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 4860787286db..5ec43607cc15 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2542,6 +2542,78 @@ struct virtqueue *vring_create_virtqueue(
>   }
>   EXPORT_SYMBOL_GPL(vring_create_virtqueue);
>   
> +/**
> + * virtqueue_resize - resize the vring of vq
> + * @_vq: the struct virtqueue we're talking about.
> + * @num: new ring num
> + * @recycle: callback for recycle the useless buffer
> + *
> + * When it is really necessary to create a new vring, it will set the current vq
> + * into the reset state. Then call the passed callback to recycle the buffer
> + * that is no longer used. Only after the new vring is successfully created, the
> + * old vring will be released.
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error.
> + * 0: success.
> + * -ENOMEM: Failed to allocate a new ring, fall back to the original ring size.
> + *  vq can still work normally
> + * -EBUSY: Failed to sync with device, vq may not work properly
> + * -ENOENT: Transport or device not supported
> + * -E2BIG/-EINVAL: num error
> + * -EPERM: Operation not permitted
> + *
> + */
> +int virtqueue_resize(struct virtqueue *_vq, u32 num,
> +		     void (*recycle)(struct virtqueue *vq, void *buf))
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	struct virtio_device *vdev = vq->vq.vdev;
> +	bool packed;
> +	void *buf;
> +	int err;
> +
> +	if (!vq->we_own_ring)
> +		return -EPERM;
> +
> +	if (num > vq->vq.num_max)
> +		return -E2BIG;
> +
> +	if (!num)
> +		return -EINVAL;
> +
> +	packed = virtio_has_feature(vdev, VIRTIO_F_RING_PACKED) ? true : false;


vq->packed_ring?


> +
> +	if ((packed ? vq->packed.vring.num : vq->split.vring.num) == num)
> +		return 0;
> +
> +	if (!vdev->config->reset_vq)
> +		return -ENOENT;
> +
> +	if (!vdev->config->enable_reset_vq)
> +		return -ENOENT;


Not sure this is useful, e.g driver may choose to resize after a reset 
of the device?

Thanks


> +
> +	err = vdev->config->reset_vq(_vq);
> +	if (err)
> +		return err;
> +
> +	while ((buf = virtqueue_detach_unused_buf(_vq)) != NULL)
> +		recycle(_vq, buf);
> +
> +	if (packed)
> +		err = virtqueue_resize_packed(_vq, num);
> +	else
> +		err = virtqueue_resize_split(_vq, num);
> +
> +	if (vdev->config->enable_reset_vq(_vq))
> +		return -EBUSY;
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_resize);
> +
>   /* Only available for split ring */
>   struct virtqueue *vring_new_virtqueue(unsigned int index,
>   				      unsigned int num,
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index a82620032e43..1272566adec6 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -91,6 +91,9 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
>   dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
>   dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
>   
> +int virtqueue_resize(struct virtqueue *vq, u32 num,
> +		     void (*recycle)(struct virtqueue *vq, void *buf));
> +
>   /**
>    * virtio_device - representation of a device using virtio
>    * @index: unique position on the virtio bus

