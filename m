Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BF6562BB8
	for <lists+linux-s390@lfdr.de>; Fri,  1 Jul 2022 08:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbiGAG3a (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 1 Jul 2022 02:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbiGAG3X (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 Jul 2022 02:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5327351B33
        for <linux-s390@vger.kernel.org>; Thu, 30 Jun 2022 23:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656656936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ep21GC3WWMrq7ZTqF7foficvymTnhxBLuGKtrZfIeyk=;
        b=SS1HgDTIFVH2zgSXAMsjs2vhgS3F3OCBjq033wDVLO7BHQhtoLmlerdi1uvPEh5NRF87CZ
        fvW6D/it5hbG4HEeNY05+qdqDFPDq0vuvLmTYCmaXnbPRDAfUPm/xAXJKmU1stg5IMTT/f
        +giqnl3ym/jg1Dwn1r1yaj9V0ilhs2Y=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-rNfs9ijEMdqmMlz0qq2SPQ-1; Fri, 01 Jul 2022 02:28:55 -0400
X-MC-Unique: rNfs9ijEMdqmMlz0qq2SPQ-1
Received: by mail-ed1-f70.google.com with SMTP id s1-20020a056402520100b00439658fad14so1096111edd.20
        for <linux-s390@vger.kernel.org>; Thu, 30 Jun 2022 23:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ep21GC3WWMrq7ZTqF7foficvymTnhxBLuGKtrZfIeyk=;
        b=iPcRjftaQOT2dYmmiUGSH2ctxD38XF0e7i/4m3Iyud7/deUY3JxCGXOFgWy/BCDWN5
         aKs8IaW7XsJPJQtWCTMmjJSyP8iSVyUT474CgcxNf2s97j2oiClMt7uB+cTy03PsVv7k
         d9LSmWAzcp0mPUDmYWZ3joRWczl+S1sFcTogaVH79XT84/1hN3DdGf1FYhGjE/hyiO1T
         YZxQaoEQT3SAxY9oWdWlNmulTTZxR78m6f0xgmWAX0k+Tnpq20axYYidSvu09ykeVY5v
         flOp/oMUjhrvP4dl7t82HoqiFxJ2+VNol3KY7BGa/02Rw0azMtT3HhJVDb7d22SnrVjD
         d4eg==
X-Gm-Message-State: AJIora+1MSCEz0Z7Oib1AlNC5Vjwop9ly3W3PDAxuqQiON8IGDgbrL+j
        Z/BL/dzT8AkeAc4lvgF7Oilo79391n41iB8fzkLTULBsW2DirvNYqae67xNvFUCOVKSHofaCVMO
        d6ODbADRo92C28TG2j9sZTg==
X-Received: by 2002:a17:907:a428:b0:726:c9f6:cb72 with SMTP id sg40-20020a170907a42800b00726c9f6cb72mr12254056ejc.663.1656656933876;
        Thu, 30 Jun 2022 23:28:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1slJK/GfjvEb+V/KlSodwyGrJY9IlEvcE76Gj4Vrg2HN6t0BznA8dFZxHAHBftC/lU4lpUOHg==
X-Received: by 2002:a17:907:a428:b0:726:c9f6:cb72 with SMTP id sg40-20020a170907a42800b00726c9f6cb72mr12254030ejc.663.1656656933627;
        Thu, 30 Jun 2022 23:28:53 -0700 (PDT)
Received: from redhat.com ([2.55.3.188])
        by smtp.gmail.com with ESMTPSA id a23-20020aa7d757000000b00437df2444f5sm3589564eds.11.2022.06.30.23.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 23:28:53 -0700 (PDT)
Date:   Fri, 1 Jul 2022 02:28:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     virtualization@lists.linux-foundation.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jason Wang <jasowang@redhat.com>,
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
Subject: Re: [PATCH v11 02/40] virtio: struct virtio_config_ops add callbacks
 for queue_reset
Message-ID: <20220701022728-mutt-send-email-mst@kernel.org>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629065656.54420-3-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 29, 2022 at 02:56:18PM +0800, Xuan Zhuo wrote:
> reset can be divided into the following four steps (example):
>  1. transport: notify the device to reset the queue
>  2. vring:     recycle the buffer submitted
>  3. vring:     reset/resize the vring (may re-alloc)
>  4. transport: mmap vring to device, and enable the queue
> 
> In order to support queue reset, add two callbacks(reset_vq,
> enable_reset_vq) in struct virtio_config_ops to implement steps 1 and 4.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  include/linux/virtio_config.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index b47c2e7ed0ee..ded51b0d4823 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -78,6 +78,16 @@ struct virtio_shm_region {
>   * @set_vq_affinity: set the affinity for a virtqueue (optional).
>   * @get_vq_affinity: get the affinity for a virtqueue (optional).
>   * @get_shm_region: get a shared memory region based on the index.
> + * @reset_vq: reset a queue individually (optional).
> + *	vq: the virtqueue
> + *	Returns 0 on success or error status
> + *	reset_vq will guarantee that the callbacks are disabled and synchronized.
> + *	Except for the callback, the caller should guarantee that the vring is
> + *	not accessed by any functions of virtqueue.
> + * @enable_reset_vq: enable a reset queue
> + *	vq: the virtqueue
> + *	Returns 0 on success or error status
> + *	If reset_vq is set, then enable_reset_vq must also be set.
>   */
>  typedef void vq_callback_t(struct virtqueue *);
>  struct virtio_config_ops {
> @@ -104,6 +114,8 @@ struct virtio_config_ops {
>  			int index);
>  	bool (*get_shm_region)(struct virtio_device *vdev,
>  			       struct virtio_shm_region *region, u8 id);
> +	int (*reset_vq)(struct virtqueue *vq);
> +	int (*enable_reset_vq)(struct virtqueue *vq);
>  };

The names need some tweaking.
I came up with
 	int (*disable_vq_and_reset)(struct virtqueue *vq);
 	int (*enable_vq_after_reset)(struct virtqueue *vq);


>  /* If driver didn't advertise the feature, it will never appear. */
> -- 
> 2.31.0

