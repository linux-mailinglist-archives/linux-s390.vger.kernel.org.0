Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682A5592948
	for <lists+linux-s390@lfdr.de>; Mon, 15 Aug 2022 08:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiHOGHW (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 15 Aug 2022 02:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiHOGHV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 15 Aug 2022 02:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35E1318356
        for <linux-s390@vger.kernel.org>; Sun, 14 Aug 2022 23:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660543639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=miQ+LrhTjrCdn3JmNHg0o7+cx9B77lvSoDGipC2aLoI=;
        b=Lv/XO764VmRAEAi41Fha3sMy44NL2O5QMinNQ3S1MdRDJzsEoyeLHXUKsJxxhS2tLMIbOB
        Ba87IjpHAPWNoHs93Q501rdgUHcb0lxlQYJEpi0rh9XOwEOhxbdKpqrPOwBMTheJyr6af3
        V24AdaiDnXIgs5TT6ykcp8Igt9S2npI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-lQ2wWXL7MtCT7Vo_AVLMtg-1; Mon, 15 Aug 2022 02:07:15 -0400
X-MC-Unique: lQ2wWXL7MtCT7Vo_AVLMtg-1
Received: by mail-ed1-f69.google.com with SMTP id r12-20020a05640251cc00b00440647ec649so4230646edd.21
        for <linux-s390@vger.kernel.org>; Sun, 14 Aug 2022 23:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=miQ+LrhTjrCdn3JmNHg0o7+cx9B77lvSoDGipC2aLoI=;
        b=bTnd49/J8Jk97QHXpiHADVtmAiw/KGvDZ7R6JOyPhaswlhaWW9LuR4vuVA38LSMNdv
         d9bmLgZikjbwhRCX2TH4AG3GkgXmmlx6sVrQK3HBzdVfX/jcOogL3S59GgvpoPXZIcdP
         45ag0pPo2WL6j/UImVZlchHBgA08KJhlwm9KuiYD/PF2COeI0jQCV9UTtCEUiV1dp/x/
         KR41Yu1L4d9Vva/qNNwkk3Owmu+L11Cwm6Bzd65xItcdou8l3cPdZcv6a9xtcbXnsTET
         0L2PFlfhuFyV5kK8QwhXHmp6L77T1URskX+EoiYqNcPqFaL/qmucVUBzWjeC7pG1Ngmv
         5nMQ==
X-Gm-Message-State: ACgBeo1mPlJ61YgZKClH2sK2prY2VFriWpTL4hbnNYREE2Eo4cPo7lqd
        N7yygF2NDg56FudB4+ntJlir5gOOquvUnhKo/wYfBoBnLMML7+iHt5tYe/Aair24EpO6xB5wiS2
        SerZNEnR+B7CansdGgh+T+A==
X-Received: by 2002:a05:6402:40c9:b0:43d:cc0d:e9de with SMTP id z9-20020a05640240c900b0043dcc0de9demr13192947edb.319.1660543634275;
        Sun, 14 Aug 2022 23:07:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5IxHumafujgE9z2U2QiRC8adJ4lPgnG3uYrrXb/EOiabr2Dh6aNojO23Eqns8Uqq534VjGmQ==
X-Received: by 2002:a05:6402:40c9:b0:43d:cc0d:e9de with SMTP id z9-20020a05640240c900b0043dcc0de9demr13192925edb.319.1660543634027;
        Sun, 14 Aug 2022 23:07:14 -0700 (PDT)
Received: from redhat.com ([2.54.169.49])
        by smtp.gmail.com with ESMTPSA id z7-20020a170906d00700b00726c0e63b94sm3688949ejy.27.2022.08.14.23.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:07:13 -0700 (PDT)
Date:   Mon, 15 Aug 2022 02:07:05 -0400
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
Subject: Re: [PATCH v14 30/42] virtio_pci: introduce helper to get/set queue
 reset
Message-ID: <20220815020548-mutt-send-email-mst@kernel.org>
References: <20220801063902.129329-1-xuanzhuo@linux.alibaba.com>
 <20220801063902.129329-31-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801063902.129329-31-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Aug 01, 2022 at 02:38:50PM +0800, Xuan Zhuo wrote:
> Introduce new helpers to implement queue reset and get queue reset
> status.
> 
>  https://github.com/oasis-tcs/virtio-spec/issues/124
>  https://github.com/oasis-tcs/virtio-spec/issues/139
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 39 ++++++++++++++++++++++++++
>  include/linux/virtio_pci_modern.h      |  2 ++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index fa2a9445bb18..869cb46bef96 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -3,6 +3,7 @@
>  #include <linux/virtio_pci_modern.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/delay.h>
>  
>  /*
>   * vp_modern_map_capability - map a part of virtio pci capability
> @@ -474,6 +475,44 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
>  }
>  EXPORT_SYMBOL_GPL(vp_modern_set_status);
>  
> +/*
> + * vp_modern_get_queue_reset - get the queue reset status
> + * @mdev: the modern virtio-pci device
> + * @index: queue index
> + */
> +int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
> +{
> +	struct virtio_pci_modern_common_cfg __iomem *cfg;
> +
> +	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;

This should use container_of, and assignment combined with the
declaration.

> +
> +	vp_iowrite16(index, &cfg->cfg.queue_select);
> +	return vp_ioread16(&cfg->queue_reset);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_get_queue_reset);
> +
> +/*
> + * vp_modern_set_queue_reset - reset the queue
> + * @mdev: the modern virtio-pci device
> + * @index: queue index
> + */
> +void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
> +{
> +	struct virtio_pci_modern_common_cfg __iomem *cfg;
> +
> +	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
> +
> +	vp_iowrite16(index, &cfg->cfg.queue_select);
> +	vp_iowrite16(1, &cfg->queue_reset);
> +
> +	while (vp_ioread16(&cfg->queue_reset))
> +		msleep(1);
> +
> +	while (vp_ioread16(&cfg->cfg.queue_enable))
> +		msleep(1);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
> +
>  /*
>   * vp_modern_queue_vector - set the MSIX vector for a specific virtqueue
>   * @mdev: the modern virtio-pci device
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index 05123b9a606f..c4eeb79b0139 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -113,4 +113,6 @@ void __iomem * vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
>  				       u16 index, resource_size_t *pa);
>  int vp_modern_probe(struct virtio_pci_modern_device *mdev);
>  void vp_modern_remove(struct virtio_pci_modern_device *mdev);
> +int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
> +void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
>  #endif
> -- 
> 2.31.0

