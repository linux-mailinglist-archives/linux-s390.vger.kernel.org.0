Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430C0578CC7
	for <lists+linux-s390@lfdr.de>; Mon, 18 Jul 2022 23:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbiGRVdu (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 18 Jul 2022 17:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbiGRVdn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Jul 2022 17:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A84AB32476
        for <linux-s390@vger.kernel.org>; Mon, 18 Jul 2022 14:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658180021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=McBcNHr9RW9GxlAu+UJlcdP1dYuV9WY6CAhxiggXqkA=;
        b=bj+g3v+xxlhVzd5TTwBjGl+3/N0pYoI5t0Tix1m7eYOabfJ3k07cHjtxMhMwl49kl0UG/S
        kTcA3MScVSAQggNl6etPOiqjzGaYo9AKDPZsej+sGaCB9HsjMoqqoNy3ZZyDQa6kzxtfTv
        q7hxkv2KFxUwKNVx9u4mmTpvH3hsh3g=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-D45myUqyNSi0L9yj__4enw-1; Mon, 18 Jul 2022 17:33:34 -0400
X-MC-Unique: D45myUqyNSi0L9yj__4enw-1
Received: by mail-il1-f197.google.com with SMTP id n16-20020a056e02141000b002dabb875f0aso8249425ilo.10
        for <linux-s390@vger.kernel.org>; Mon, 18 Jul 2022 14:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=McBcNHr9RW9GxlAu+UJlcdP1dYuV9WY6CAhxiggXqkA=;
        b=PJgHot0wh+kmq4otBCW96jy7aOTgoxxGMwZu/cBmv8jBmOxIfPwBi+LteZZ2Qxx5Gs
         PjyFhn95HJGBYZzthX+jDFKJ5sKyW7Iz2lWtTEh5UpNqXqDzdz5R9wBYrZhFIoR5qfi1
         QOiG02gfWCWjPtfqF+3py8lEl+yPyEOv497M08ULh8fe7KoGeGocKbNZGoPFa/y8erEw
         5UQGF83OtljIOe3s0R3OYQ2TmUgUfpeVI9cMonZq7d/Z96Z5jaM2SrSHwMZsMToWdk6+
         g5NPKR0JQif/EW0ecpQaKbTDtyJxhE5N/e2oqTQLjGatxWVNs+2F822kgmfkbotXF9Q3
         Mfaw==
X-Gm-Message-State: AJIora8iHb+tMvchU8GimfbMZOL/26nVsaRHz0AHSzRQcUfN8aNWKHcc
        iDyJrUsHY6pWDWAnB9mZXCO3LZAHnNihwhTzHoqKmnlPz4yGuOX84n01DwEfrBOC8hZdguoVLl6
        8TeDvkyllYfrfc/PbZgithA==
X-Received: by 2002:a6b:3e83:0:b0:678:e63b:355d with SMTP id l125-20020a6b3e83000000b00678e63b355dmr13719285ioa.134.1658180014077;
        Mon, 18 Jul 2022 14:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sDrGa8ze2j/q2lwFrndLWdf63qIpnOAVsNqsBc/gBPGdJhX41ARLJ2Yuy3bl7gy/bKR3KwsA==
X-Received: by 2002:a6b:3e83:0:b0:678:e63b:355d with SMTP id l125-20020a6b3e83000000b00678e63b355dmr13719265ioa.134.1658180013803;
        Mon, 18 Jul 2022 14:33:33 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id d190-20020a6bb4c7000000b0066961821575sm6386751iof.34.2022.07.18.14.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 14:33:33 -0700 (PDT)
Date:   Mon, 18 Jul 2022 15:33:31 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org
Subject: Re: simplify the mdev interface v6
Message-ID: <20220718153331.18a52e31.alex.williamson@redhat.com>
In-Reply-To: <20220718054348.GA22345@lst.de>
References: <20220709045450.609884-1-hch@lst.de>
        <20220718054348.GA22345@lst.de>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 18 Jul 2022 07:43:48 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Alex, does this series look good to you now?

It does.  I was hoping we'd get a more complete set acks from the mdev
driver owners, but I'll grab this within the next day or two with
whatever additional reviews come in by then.  Thanks,

Alex

> On Sat, Jul 09, 2022 at 06:54:36AM +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series signigicantly simplies the mdev driver interface by following
> > the patterns for device model interaction used elsewhere in the kernel.
> > 
> > Changes since v5:
> >  - rebased to the latest vfio/next branch
> >  - drop the last patch again
> >  - make sure show_available_instances works properly for the internallly
> >    tracked case
> > 
> > Changes since v4:
> >  - move the kobject_put later in mdev_device_release 
> >  - add a Fixes tag for the first patch
> >  - add another patch to remove an extra kobject_get/put
> > 
> > Changes since v3:
> >  - make the sysfs_name and pretty_name fields pointers instead of arrays
> >  - add an i915 cleanup to prepare for the above
> > 
> > Changes since v2:
> >  - rebased to vfio/next
> >  - fix a pre-existing memory leak in i915 instead of making it worse
> >  - never manipulate if ->available_instances if drv->get_available is
> >    provided
> >  - keep a parent reference for the mdev_type
> >  - keep a few of the sysfs.c helper function around
> >  - improve the documentation for the parent device lifetime
> >  - minor spellig / formatting fixes
> > 
> > Changes since v1:
> >  - embedd the mdev_parent into a different sub-structure in i916
> >  - remove headers now inclued by mdev.h from individual source files
> >  - pass an array of mdev_types to mdev_register_parent
> >  - add additional patches to implement all attributes on the
> >    mdev_type in the core code
> > 
> > Diffstat:
> >  Documentation/driver-api/vfio-mediated-device.rst |   26 +-
> >  Documentation/s390/vfio-ap.rst                    |    2 
> >  Documentation/s390/vfio-ccw.rst                   |    2 
> >  drivers/gpu/drm/i915/gvt/aperture_gm.c            |   20 +-
> >  drivers/gpu/drm/i915/gvt/gvt.h                    |   42 ++--
> >  drivers/gpu/drm/i915/gvt/kvmgt.c                  |  168 ++++-------------
> >  drivers/gpu/drm/i915/gvt/vgpu.c                   |  210 +++++++---------------
> >  drivers/s390/cio/cio.h                            |    4 
> >  drivers/s390/cio/vfio_ccw_drv.c                   |   12 -
> >  drivers/s390/cio/vfio_ccw_ops.c                   |   51 -----
> >  drivers/s390/cio/vfio_ccw_private.h               |    2 
> >  drivers/s390/crypto/vfio_ap_ops.c                 |   68 +------
> >  drivers/s390/crypto/vfio_ap_private.h             |    6 
> >  drivers/vfio/mdev/mdev_core.c                     |  190 ++++---------------
> >  drivers/vfio/mdev/mdev_driver.c                   |    7 
> >  drivers/vfio/mdev/mdev_private.h                  |   32 ---
> >  drivers/vfio/mdev/mdev_sysfs.c                    |  189 ++++++++++---------
> >  include/linux/mdev.h                              |   77 ++++----
> >  samples/vfio-mdev/mbochs.c                        |  103 +++-------
> >  samples/vfio-mdev/mdpy.c                          |  115 +++---------
> >  samples/vfio-mdev/mtty.c                          |   94 +++------
> >  21 files changed, 463 insertions(+), 957 deletions(-)  
> ---end quoted text---
> 

