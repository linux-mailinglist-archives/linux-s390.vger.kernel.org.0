Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04EC562F69
	for <lists+linux-s390@lfdr.de>; Fri,  1 Jul 2022 11:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiGAJDm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 1 Jul 2022 05:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbiGAJDi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 Jul 2022 05:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EF0D2CE3B
        for <linux-s390@vger.kernel.org>; Fri,  1 Jul 2022 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656666215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1b6P6ndaF684cAO7Vh4K15FYuoIpDfb/buQv2cS9+s=;
        b=cwAib/SVcSnosIT6Qru3ZdypKl2x87gVyu/iczePVPCHgqMoqU17FnPOXu9CJ40N7DfNeE
        UG08uHrs8JotRxb2XgSyKIGWcsU8kOt1cNjaoscMrNurejgtME0JK4BK2hNfH4uAsCSUlw
        V5ihda7IAKjpJcVkC1z3fvyQrVKyZGk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-7SqPgskYO-G9UK_4kRiQKw-1; Fri, 01 Jul 2022 05:03:34 -0400
X-MC-Unique: 7SqPgskYO-G9UK_4kRiQKw-1
Received: by mail-pl1-f199.google.com with SMTP id u14-20020a17090341ce00b0016a38ec073aso1166356ple.21
        for <linux-s390@vger.kernel.org>; Fri, 01 Jul 2022 02:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D1b6P6ndaF684cAO7Vh4K15FYuoIpDfb/buQv2cS9+s=;
        b=cL2t+MCV5+uyUgxA0vlJ2gyPeAPr9cJRgL2NzDLlRwe8/hArE6IfM8t7SeKysD1SrR
         SfVUyZ0ZMyz53Rp7HDeCQ9t+GBGmQ1zzxn6wiDB3WLparnPD4wNN8Yg9lAjt0L1gF5ys
         4jP0HJPfKdLOxKvqLddOsWSYXzkxe5FPWvDRfx/uKyq7xIhDnA0J2CyalvtKxU+weJdE
         /FTMIF8eADXWUfgAtvb9/BcFlABm5rTjQQCRBxN8wjlnRH1ylSfV4CCiRviYewWmFYcU
         L632AxqbjZ/zt3EedykBrw33bzdtzTaG2LGuHrF61DtzM7bkiwWbVrtWAehQWjfyUfCl
         fPAw==
X-Gm-Message-State: AJIora/OHa4p5KlHMDLBbPWxlOwy3SiSG5EAINOwOsXUii26bo0KvhfZ
        7G3DMTxYb0IlDy5XYO/pCtKD0JqespJZCsExTgFBBTvM2JzcL2frGdHhYSC1iaLQxGmy9CUaYwY
        5OUg28iOO6VnXgYxk+Bb9nw==
X-Received: by 2002:a17:903:18c:b0:16b:8f8a:335f with SMTP id z12-20020a170903018c00b0016b8f8a335fmr18699029plg.133.1656666212882;
        Fri, 01 Jul 2022 02:03:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1umuzlHjb+AVT8pHf+MDYjA/xytvg2Ww3qrvKeBf7drySw0yZL85wg1m0wVfhF0UW2aCpNd7Q==
X-Received: by 2002:a17:903:18c:b0:16b:8f8a:335f with SMTP id z12-20020a170903018c00b0016b8f8a335fmr18699008plg.133.1656666212635;
        Fri, 01 Jul 2022 02:03:32 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s22-20020a17090aba1600b001ec71be4145sm6020700pjr.2.2022.07.01.02.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 02:03:32 -0700 (PDT)
Message-ID: <e27e4f98-5f3f-6ad5-b612-163cb967fa8a@redhat.com>
Date:   Fri, 1 Jul 2022 17:03:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 13/40] virtio_ring: split: reserve vring_align,
 may_reduce_num
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
 <20220629065656.54420-14-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-14-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


在 2022/6/29 14:56, Xuan Zhuo 写道:
> In vring_create_virtqueue_split() save vring_align, may_reduce_num to
> structure vring_virtqueue_split. Used to create a new vring when
> implementing resize .
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/virtio/virtio_ring.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 4c8972da5423..9c83c5e6d5a9 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -105,6 +105,13 @@ struct vring_virtqueue_split {
>   	/* DMA address and size information */
>   	dma_addr_t queue_dma_addr;
>   	size_t queue_size_in_bytes;
> +
> +	/*
> +	 * The parameters for creating vrings are reserved for creating new
> +	 * vring.
> +	 */
> +	u32 vring_align;
> +	bool may_reduce_num;
>   };
>   
>   struct vring_virtqueue_packed {
> @@ -1098,6 +1105,8 @@ static struct virtqueue *vring_create_virtqueue_split(
>   		return NULL;
>   	}
>   
> +	to_vvq(vq)->split.vring_align = vring_align;
> +	to_vvq(vq)->split.may_reduce_num = may_reduce_num;
>   	to_vvq(vq)->split.queue_dma_addr = vring.queue_dma_addr;
>   	to_vvq(vq)->split.queue_size_in_bytes = vring.queue_size_in_bytes;
>   	to_vvq(vq)->we_own_ring = true;

