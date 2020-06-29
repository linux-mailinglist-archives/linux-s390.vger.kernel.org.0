Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9401920D360
	for <lists+linux-s390@lfdr.de>; Mon, 29 Jun 2020 21:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgF2S6Y (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 29 Jun 2020 14:58:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46364 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730227AbgF2S6R (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 29 Jun 2020 14:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593457095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oy5l01hfztOMplxTNHhOMx7JM2vgkWGI3b7lgHWBSLA=;
        b=ICVLkiQ5mbdv4StNz03UrThm2RjOefTyhg8tJVwN9hv9LZdmrmsbmCEfbrYURGkPy6xvdQ
        RKgPIyovulq75JoheXAlS1AXYR2MCN8IJhB+8++bxjxzYOW0vD/BxLG16SwkR2XehmCSJJ
        QFVRf+5abnDnK1MbrGIBb+ioOhJ+gek=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-tAAJDRidOWCt-Yc72Jo8AA-1; Mon, 29 Jun 2020 11:57:22 -0400
X-MC-Unique: tAAJDRidOWCt-Yc72Jo8AA-1
Received: by mail-wm1-f70.google.com with SMTP id t18so18578334wmj.5
        for <linux-s390@vger.kernel.org>; Mon, 29 Jun 2020 08:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oy5l01hfztOMplxTNHhOMx7JM2vgkWGI3b7lgHWBSLA=;
        b=auNVS2V4i2lv9vghCkArTSQvTAiij4zq2AorqmHhS5BVJ/qFjeMb9DFyVEXykJdMks
         Yls67LG9QnHpwS7as0YiZZcgFA16zfM77GIk0FSjkXqJhGWvNBfMI+p2IurXjYp2UM8v
         wKBpmaNQEYrYomY28fDEQi8w1AJJdSe64JfdT7ENaWKw+p1pb3MFuGKmh5qaDtNYuScZ
         9nGjGXjcnCZH7eKzYMP6mK8PQ43WkHFN0dZ6VpylsKdCqAyfzBa3BP6OkkRyj/9X3CAL
         uxTFTdarIRuGyG+QnFgFZAqs3+0tZ7dlEqRpUsBBcl/Jn26F4xnIFsawSDA31mrhgXnk
         uogQ==
X-Gm-Message-State: AOAM5322s1Yf5Y0CRUTe6T3nQ9hj7XLOe8KqTS3eXsW/c1CG2YJqNBfQ
        lz9J31mN/hYnr90N7V/nfvm0Yfwu8DTUZkVwXzMYIFGU2Np9gGdsslpp7cmaTfvwIb6j765Ha6d
        rvmmZtQRzyKu47WuTIpx2Lg==
X-Received: by 2002:a1c:a589:: with SMTP id o131mr16317493wme.12.1593446241168;
        Mon, 29 Jun 2020 08:57:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3Q991U1StDDA7B+9BT+HZk+cVYRj7n2VJpgHLiwVYyouUoA4w6BqhRBNFB4h0zTI9ALDIzg==
X-Received: by 2002:a1c:a589:: with SMTP id o131mr16317466wme.12.1593446240963;
        Mon, 29 Jun 2020 08:57:20 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id d18sm241639wrj.8.2020.06.29.08.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 08:57:17 -0700 (PDT)
Date:   Mon, 29 Jun 2020 11:57:14 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, pasic@linux.ibm.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, jasowang@redhat.com,
        cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        david@gibson.dropbear.id.au, linuxram@us.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v3 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
Message-ID: <20200629115651-mutt-send-email-mst@kernel.org>
References: <1592390637-17441-1-git-send-email-pmorel@linux.ibm.com>
 <1592390637-17441-2-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592390637-17441-2-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 17, 2020 at 12:43:57PM +0200, Pierre Morel wrote:
> An architecture protecting the guest memory against unauthorized host
> access may want to enforce VIRTIO I/O device protection through the
> use of VIRTIO_F_IOMMU_PLATFORM.
> 
> Let's give a chance to the architecture to accept or not devices
> without VIRTIO_F_IOMMU_PLATFORM.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/mm/init.c     |  6 ++++++
>  drivers/virtio/virtio.c | 22 ++++++++++++++++++++++
>  include/linux/virtio.h  |  2 ++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 6dc7c3b60ef6..215070c03226 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -45,6 +45,7 @@
>  #include <asm/kasan.h>
>  #include <asm/dma-mapping.h>
>  #include <asm/uv.h>
> +#include <linux/virtio.h>
>  
>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
>  
> @@ -161,6 +162,11 @@ bool force_dma_unencrypted(struct device *dev)
>  	return is_prot_virt_guest();
>  }
>  
> +int arch_needs_virtio_iommu_platform(struct virtio_device *dev)
> +{
> +	return is_prot_virt_guest();
> +}
> +
>  /* protected virtualization */
>  static void pv_init(void)
>  {
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index a977e32a88f2..aa8e01104f86 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -167,6 +167,21 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
>  }
>  EXPORT_SYMBOL_GPL(virtio_add_status);
>  
> +/*
> + * arch_needs_virtio_iommu_platform - provide arch specific hook when finalizing
> + *				      features for VIRTIO device dev
> + * @dev: the VIRTIO device being added
> + *
> + * Permits the platform to provide architecture specific functionality when
> + * devices features are finalized. This is the default implementation.
> + * Architecture implementations can override this.
> + */
> +
> +int __weak arch_needs_virtio_iommu_platform(struct virtio_device *dev)
> +{
> +	return 0;
> +}
> +
>  int virtio_finalize_features(struct virtio_device *dev)
>  {
>  	int ret = dev->config->finalize_features(dev);
> @@ -179,6 +194,13 @@ int virtio_finalize_features(struct virtio_device *dev)
>  	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
>  		return 0;
>  
> +	if (arch_needs_virtio_iommu_platform(dev) &&
> +		!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
> +		dev_warn(&dev->dev,
> +			 "virtio: device must provide VIRTIO_F_IOMMU_PLATFORM\n");
> +		return -ENODEV;
> +	}
> +
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
>  	status = dev->config->get_status(dev);
>  	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {

Well don't you need to check it *before* VIRTIO_F_VERSION_1, not after?



> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index a493eac08393..e8526ae3463e 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -195,4 +195,6 @@ void unregister_virtio_driver(struct virtio_driver *drv);
>  #define module_virtio_driver(__virtio_driver) \
>  	module_driver(__virtio_driver, register_virtio_driver, \
>  			unregister_virtio_driver)
> +
> +int arch_needs_virtio_iommu_platform(struct virtio_device *dev);
>  #endif /* _LINUX_VIRTIO_H */
> -- 
> 2.25.1

