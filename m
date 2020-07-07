Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA918216B39
	for <lists+linux-s390@lfdr.de>; Tue,  7 Jul 2020 13:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgGGLPA (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 7 Jul 2020 07:15:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47102 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727886AbgGGLPA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Jul 2020 07:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594120498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2SkfEvXWOe57lsdbNZpY7pfaCzkWkPb715oD3Syj+e4=;
        b=WMHSFK/oWenW5qlxMXfVm6FiH328xZ538dKOedLx4P8ppmRoIYe/K7+sITNZhbdjiQd9zM
        nohiAATXO7sx1O2Bj9aABYUMtAULZMEc5VSQdw1o3YqztSW7HxlUw7AMG322Ko31hpwvu0
        L+n20ZQ/fRl2DM0UpZZ0tSrWJkx2ccU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-uUeVhxnuOSK_LiXtUhvgqA-1; Tue, 07 Jul 2020 07:14:57 -0400
X-MC-Unique: uUeVhxnuOSK_LiXtUhvgqA-1
Received: by mail-wr1-f69.google.com with SMTP id d11so30858681wrw.12
        for <linux-s390@vger.kernel.org>; Tue, 07 Jul 2020 04:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2SkfEvXWOe57lsdbNZpY7pfaCzkWkPb715oD3Syj+e4=;
        b=rA7rZt1yrSFpGjywySJpZW89tIUWa/J9Si8yikUBTRZWQ6WLEInKtuyjA4SfysS2Jo
         BUlW8wJx9FV4RknCEl1Uex3+N/d6eIuqJ8oapOwtPkmgKmR7TrgJXtdzE95n2ltjsmbs
         D5/M5ofgJsJVW6mybu5SPno0kzFw+y/s7AoWJ+3ygQgH0Uig1+BXdNM5cphZJJ666LYT
         XK/i5IGUL4Lnm/ystVoZ3utHsq1nFdV7s62ZVLM4YrRp/I6l8KSWEIl5y+E/B4LnUow1
         yL4lp0hAGJrjYRFkUQULcPHC/r85z7J8kIUzS/5cZxYIytYhXOdLz3BOjJiqRTz0XWme
         /tEA==
X-Gm-Message-State: AOAM531asG0uyC4YQdkA9e2RxCof1W/TF0SlTtiFjscWZGt0Xxendl23
        GGWqABV/QBksL+AiSaR3yciRV9JzoZy6VvlDkvw/anCnDEedFoSxFD84n+J6KS/YCpcApPWwdN9
        xa8BNMLtdVa46So4QVN/IrQ==
X-Received: by 2002:adf:de01:: with SMTP id b1mr52165618wrm.305.1594120495913;
        Tue, 07 Jul 2020 04:14:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfrgQVHW0xPEz2qK4WxsyK5VqMd4mfiVNX7Uo+QjneR39/UAS7kA8HbpUGWt9XZF4TGRAOtA==
X-Received: by 2002:adf:de01:: with SMTP id b1mr52165596wrm.305.1594120495667;
        Tue, 07 Jul 2020 04:14:55 -0700 (PDT)
Received: from redhat.com (bzq-79-182-109-139.red.bezeqint.net. [79.182.109.139])
        by smtp.gmail.com with ESMTPSA id 92sm597206wrr.96.2020.07.07.04.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 04:14:54 -0700 (PDT)
Date:   Tue, 7 Jul 2020 07:14:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org,
        pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        jasowang@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        david@gibson.dropbear.id.au, linuxram@us.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v4 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
Message-ID: <20200707060838-mutt-send-email-mst@kernel.org>
References: <1594111477-15401-1-git-send-email-pmorel@linux.ibm.com>
 <1594111477-15401-3-git-send-email-pmorel@linux.ibm.com>
 <20200707114633.68122a00.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707114633.68122a00.cohuck@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jul 07, 2020 at 11:46:33AM +0200, Cornelia Huck wrote:
> On Tue,  7 Jul 2020 10:44:37 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> > S390, protecting the guest memory against unauthorized host access
> > needs to enforce VIRTIO I/O device protection through the use of
> > VIRTIO_F_VERSION_1 and VIRTIO_F_IOMMU_PLATFORM.
> 
> Hm... what about:
> 
> "If protected virtualization is active on s390, the virtio queues are
> not accessible to the host, unless VIRTIO_F_IOMMU_PLATFORM has been
> negotiated. Use the new arch_validate_virtio_features() interface to
> enforce this."

s/enforce this/fail probe if that's not the case, preventing a host error on access attempt/



> > 
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > ---
> >  arch/s390/kernel/uv.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> > index c296e5c8dbf9..106330f6eda1 100644
> > --- a/arch/s390/kernel/uv.c
> > +++ b/arch/s390/kernel/uv.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/memblock.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/swap.h>
> > +#include <linux/virtio_config.h>
> >  #include <asm/facility.h>
> >  #include <asm/sections.h>
> >  #include <asm/uv.h>
> > @@ -413,3 +414,27 @@ static int __init uv_info_init(void)
> >  }
> >  device_initcall(uv_info_init);
> >  #endif
> > +
> > +/*
> > + * arch_validate_virtio_iommu_platform
> 
> s/arch_validate_virtio_iommu_platform/arch_validate_virtio_features/
> 
> > + * @dev: the VIRTIO device being added
> > + *
> > + * Return value: returns -ENODEV if any features of the
> > + *               device breaks the protected virtualization
> > + *               0 otherwise.
> 
> I don't think you need to specify the contract here: that belongs to
> the definition in the virtio core. What about simply adding a sentence
> "Return an error if required features are missing on a guest running
> with protected virtualization." ?
> 
> > + */
> > +int arch_validate_virtio_features(struct virtio_device *dev)
> > +{
> 
> Maybe jump out immediately if the guest is not protected?
> 
> > +	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
> > +		dev_warn(&dev->dev, "device must provide VIRTIO_F_VERSION_1\n");
> > +		return is_prot_virt_guest() ? -ENODEV : 0;
> > +	}
> > +
> > +	if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
> > +		dev_warn(&dev->dev,
> > +			 "device must provide VIRTIO_F_IOMMU_PLATFORM\n");
> > +		return is_prot_virt_guest() ? -ENODEV : 0;
> > +	}
> 
> if (!is_prot_virt_guest())
> 	return 0;
> 
> if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
> 	dev_warn(&dev->dev,
>                  "legacy virtio is incompatible with protected guests");
> 	return -ENODEV;
> }
> 
> if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
> 	dev_warn(&dev->dev,
> 		 "device does not work with limited memory access in protected guests");
> 	return -ENODEV;
> }
> 
> > +
> > +	return 0;
> > +}

