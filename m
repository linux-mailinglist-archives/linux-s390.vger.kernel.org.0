Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89E157C2D5
	for <lists+linux-s390@lfdr.de>; Thu, 21 Jul 2022 05:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiGUDjh (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 20 Jul 2022 23:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGUDjf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 20 Jul 2022 23:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10C9578213
        for <linux-s390@vger.kernel.org>; Wed, 20 Jul 2022 20:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658374773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/J4B4qcC/O6PCOtnZhz1fVwUIt6mfKVcFfx+S26Hn1w=;
        b=PzjjwtQAOq2sS3wdzhV1HjWPBaASbS944qdfw8GTnGcyK1lIYmzfa9pzKF3iML09NBH7tU
        nxY+JW+u++S1IylLlRz2TiZrDsONOsfN2JEqW7fRj8hFB1dkoaft/PqcxrlZXG8/63VDID
        T8G6cGT+91j1gCJbopZdVO7BIIcWBh0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-e_xcyUFgP1qMWYENc7c7kg-1; Wed, 20 Jul 2022 23:39:32 -0400
X-MC-Unique: e_xcyUFgP1qMWYENc7c7kg-1
Received: by mail-pl1-f199.google.com with SMTP id u12-20020a170902e5cc00b0016c20d40ec1so452704plf.10
        for <linux-s390@vger.kernel.org>; Wed, 20 Jul 2022 20:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/J4B4qcC/O6PCOtnZhz1fVwUIt6mfKVcFfx+S26Hn1w=;
        b=R4H3GqClPGcoInMczgtN7QI2sYgm4qWMhLmWCeOIqpo00bZa0XsElvAw+qzbZpkwjQ
         jCJta/P4H4ezAJpSt1+m79rrTJ1qiXA8EjAPaVjJzoCey1s6XU/w/+cItJgD7pOfk9Y6
         aBjyIpF0vEN5DbKbyd1wkNsacvsSEUII7WKkUS0CfufKGLyVP9BV19LXt87SU68lYlFy
         BNXKws9Z7FOEIv8dhnb96ycKHaZ3hmCiRIqx40MVm1Bq4buLBqrbKBXc03wu5f4g1K1s
         wVTbx0Q0gpmDkfab7KwGuoeOQLApulVTUeC492qJ9OTgnMxBJaPwmWajoKZY+OkU+eCd
         sjzA==
X-Gm-Message-State: AJIora8PmcSEvJx72t1PvloiGc6yiMdUlUOuvA5Q9bIYIYlzO0KdJZkg
        BV5+dMFHji96KF/F5UDlFqSg/55ji2S+u2+Dweo1ILbwd1YZ49DDq5huERHbGH51BGcOrtQolM5
        yukxL15RmdS/bX8EviMWPDA==
X-Received: by 2002:a17:902:6943:b0:16c:ba81:1842 with SMTP id k3-20020a170902694300b0016cba811842mr34513140plt.24.1658374770936;
        Wed, 20 Jul 2022 20:39:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u1VrQwD/Z1oboj3J8gyT4oRNKMLENwwF8aDJAS3C/huxjXfcUqUKDMCERwkdW74rqe0+fCQA==
X-Received: by 2002:a17:902:6943:b0:16c:ba81:1842 with SMTP id k3-20020a170902694300b0016cba811842mr34513102plt.24.1658374770599;
        Wed, 20 Jul 2022 20:39:30 -0700 (PDT)
Received: from [10.72.12.47] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v12-20020aa799cc000000b00528f9597fb3sm401825pfi.197.2022.07.20.20.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 20:39:30 -0700 (PDT)
Message-ID: <226ab2d4-0b3f-3a18-bed4-be5d278d2069@redhat.com>
Date:   Thu, 21 Jul 2022 11:39:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v12 02/40] virtio: struct virtio_config_ops add callbacks
 for queue_reset
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
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-3-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-3-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


在 2022/7/20 11:03, Xuan Zhuo 写道:
> reset can be divided into the following four steps (example):
>   1. transport: notify the device to reset the queue
>   2. vring:     recycle the buffer submitted
>   3. vring:     reset/resize the vring (may re-alloc)
>   4. transport: mmap vring to device, and enable the queue
>
> In order to support queue reset, add two callbacks in struct
> virtio_config_ops to implement steps 1 and 4.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   include/linux/virtio_config.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index b47c2e7ed0ee..36ec7be1f480 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -78,6 +78,18 @@ struct virtio_shm_region {
>    * @set_vq_affinity: set the affinity for a virtqueue (optional).
>    * @get_vq_affinity: get the affinity for a virtqueue (optional).
>    * @get_shm_region: get a shared memory region based on the index.
> + * @disable_vq_and_reset: reset a queue individually (optional).
> + *	vq: the virtqueue
> + *	Returns 0 on success or error status
> + *	disable_vq_and_reset will guarantee that the callbacks are disabled and
> + *	synchronized.
> + *	Except for the callback, the caller should guarantee that the vring is
> + *	not accessed by any functions of virtqueue.
> + * @enable_vq_after_reset: enable a reset queue
> + *	vq: the virtqueue
> + *	Returns 0 on success or error status
> + *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
> + *	set.
>    */
>   typedef void vq_callback_t(struct virtqueue *);
>   struct virtio_config_ops {
> @@ -104,6 +116,8 @@ struct virtio_config_ops {
>   			int index);
>   	bool (*get_shm_region)(struct virtio_device *vdev,
>   			       struct virtio_shm_region *region, u8 id);
> +	int (*disable_vq_and_reset)(struct virtqueue *vq);
> +	int (*enable_vq_after_reset)(struct virtqueue *vq);
>   };
>   
>   /* If driver didn't advertise the feature, it will never appear. */

