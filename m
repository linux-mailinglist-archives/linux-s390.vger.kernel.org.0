Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B1F72D4C5
	for <lists+linux-s390@lfdr.de>; Tue, 13 Jun 2023 01:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjFLXHR (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 12 Jun 2023 19:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjFLXHQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 12 Jun 2023 19:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB31BE4
        for <linux-s390@vger.kernel.org>; Mon, 12 Jun 2023 16:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686611192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jzuT5ihaFMxsJ3+RTycHd7EHLIMAzmb3vK/ZKM5/qTg=;
        b=gS/DS3I5EZzhrGcRiFe+wBYqaDSYsg1Irf1xU0cNKKY9r/psN/VGXdABrGtTZqr3YanDfD
        CJhfAYQRWKm99Glaoi9WTXEnUNCauiaA0qmdsV9eEsO3poEDJeQDUKD+0j5IaQejeTcwI7
        v1D0vxDGbk+Gr+dmIhGG7VodYhlMaJA=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-BqXR-rzGOtOQVuBdyd9Y9w-1; Mon, 12 Jun 2023 19:06:31 -0400
X-MC-Unique: BqXR-rzGOtOQVuBdyd9Y9w-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-33bf12b5f95so48806165ab.3
        for <linux-s390@vger.kernel.org>; Mon, 12 Jun 2023 16:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686611191; x=1689203191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzuT5ihaFMxsJ3+RTycHd7EHLIMAzmb3vK/ZKM5/qTg=;
        b=W6hNco1HFSyHhD8qL8RSSzxLO61h5MzNzGYVbokNQlOuzlMzpGP1wOrCo0qU296Jtk
         pkw4vxFdM2ukeoQrhZfEPvwEqbp/ClTgeOzaFrnJjkjSUENvyawERn9vOyIgd062y3zJ
         17eGCMAtFOHDXARhY0CNRss9gksUCC5QjPcvPEfBB55E0p7tKHUWZ3Es0ZoCDmlC9Z9Y
         LQuLSNVaU2zouNWuq5WfgOc2SHVcu62XNW88scZbYjUoEFqkaiYsTogquoTISRq7E6Qa
         j6hIjfCj0EalQG+BBAfVYdrX8AMytbmpeOCT6wjAZbwZlBC3c7/Bt9iLbQCWDO8cOR+k
         w/7A==
X-Gm-Message-State: AC+VfDzT3iezCauiJazIgyILhBPq+ABVrY1qFymykQnD4dtOixrkGtTx
        +P45v4LfZjHT+3inGU9Im5GyjHL8o/0OyDhN4mSTcqqmM8/7paT9t5ukLzcKQQUcn7fNg2iKI2Z
        lAOYY2YR37YyBLge/mQMYkg==
X-Received: by 2002:a05:6e02:6cd:b0:33e:8195:5a4 with SMTP id p13-20020a056e0206cd00b0033e819505a4mr9207716ils.20.1686611190863;
        Mon, 12 Jun 2023 16:06:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6fCZIDEEqrbYB4cary74GxrtYZsk3ZYW38NV3ohTMoXgw2nkM3edVOyo2DnKMZQ9osya4fOA==
X-Received: by 2002:a05:6e02:6cd:b0:33e:8195:5a4 with SMTP id p13-20020a056e0206cd00b0033e819505a4mr9207679ils.20.1686611190566;
        Mon, 12 Jun 2023 16:06:30 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id u12-20020a056e02080c00b0033fdce8e86esm227329ilm.80.2023.06.12.16.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 16:06:29 -0700 (PDT)
Date:   Mon, 12 Jun 2023 17:06:28 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     jgg@nvidia.com, kevin.tian@intel.com, joro@8bytes.org,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        xudong.hao@intel.com, yan.y.zhao@intel.com, terrence.xu@intel.com,
        yanting.jiang@intel.com, zhenzhong.duan@intel.com,
        clegoate@redhat.com
Subject: Re: [PATCH v12 24/24] docs: vfio: Add vfio device cdev description
Message-ID: <20230612170628.661ab2a6.alex.williamson@redhat.com>
In-Reply-To: <20230602121653.80017-25-yi.l.liu@intel.com>
References: <20230602121653.80017-1-yi.l.liu@intel.com>
        <20230602121653.80017-25-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri,  2 Jun 2023 05:16:53 -0700
Yi Liu <yi.l.liu@intel.com> wrote:

> This gives notes for userspace applications on device cdev usage.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  Documentation/driver-api/vfio.rst | 132 ++++++++++++++++++++++++++++++
>  1 file changed, 132 insertions(+)
> 
> diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
> index 363e12c90b87..f00c9b86bda0 100644
> --- a/Documentation/driver-api/vfio.rst
> +++ b/Documentation/driver-api/vfio.rst
> @@ -239,6 +239,130 @@ group and can access them as follows::
>  	/* Gratuitous device reset and go... */
>  	ioctl(device, VFIO_DEVICE_RESET);
>  
> +IOMMUFD and vfio_iommu_type1
> +----------------------------
> +
> +IOMMUFD is the new user API to manage I/O page tables from userspace.
> +It intends to be the portal of delivering advanced userspace DMA
> +features (nested translation [5]_, PASID [6]_, etc.) while also providing
> +a backwards compatibility interface for existing VFIO_TYPE1v2_IOMMU use
> +cases.  Eventually the vfio_iommu_type1 driver, as well as the legacy
> +vfio container and group model is intended to be deprecated.
> +
> +The IOMMUFD backwards compatibility interface can be enabled two ways.
> +In the first method, the kernel can be configured with
> +CONFIG_IOMMUFD_VFIO_CONTAINER, in which case the IOMMUFD subsystem
> +transparently provides the entire infrastructure for the VFIO
> +container and IOMMU backend interfaces.  The compatibility mode can
> +also be accessed if the VFIO container interface, ie. /dev/vfio/vfio is
> +simply symlink'd to /dev/iommu.  Note that at the time of writing, the
> +compatibility mode is not entirely feature complete relative to
> +VFIO_TYPE1v2_IOMMU (ex. DMA mapping MMIO) and does not attempt to
> +provide compatibility to the VFIO_SPAPR_TCE_IOMMU interface.  Therefore
> +it is not generally advisable at this time to switch from native VFIO
> +implementations to the IOMMUFD compatibility interfaces.
> +
> +Long term, VFIO users should migrate to device access through the cdev
> +interface described below, and native access through the IOMMUFD
> +provided interfaces.
> +
> +VFIO Device cdev
> +----------------
> +
> +Traditionally user acquires a device fd via VFIO_GROUP_GET_DEVICE_FD
> +in a VFIO group.
> +
> +With CONFIG_VFIO_DEVICE_CDEV=y the user can now acquire a device fd
> +by directly opening a character device /dev/vfio/devices/vfioX where
> +"X" is the number allocated uniquely by VFIO for registered devices.
> +cdev interface does not support noiommu, so user should use the legacy
> +group interface if noiommu is needed.
> +
> +The cdev only works with IOMMUFD.  Both VFIO drivers and applications
> +must adapt to the new cdev security model which requires using
> +VFIO_DEVICE_BIND_IOMMUFD to claim DMA ownership before starting to
> +actually use the device.  Once BIND succeeds then a VFIO device can
> +be fully accessed by the user.
> +
> +VFIO device cdev doesn't rely on VFIO group/container/iommu drivers.
> +Hence those modules can be fully compiled out in an environment
> +where no legacy VFIO application exists.
> +
> +So far SPAPR does not support IOMMUFD yet.  So it cannot support device
> +cdev neither.

s/neither/either/

Unless I missed it, we've not described that vfio device cdev access is
still bound by IOMMU group semantics, ie. there can be one DMA owner
for the group.  That's a pretty common failure point for multi-function
consumer device use cases, so the why, where, and how it fails should
be well covered.

In general there's been a lot of cross collaboration to get the series
this far.  I see an abundance of Tested-by, but unfortunately not a lot
of Reviewed-by beyond about the first 1/3rd of the series.  Thanks,

Alex

> +
> +Device cdev Example
> +-------------------
> +
> +Assume user wants to access PCI device 0000:6a:01.0::
> +
> +	$ ls /sys/bus/pci/devices/0000:6a:01.0/vfio-dev/
> +	vfio0
> +
> +This device is therefore represented as vfio0.  The user can verify
> +its existence::
> +
> +	$ ls -l /dev/vfio/devices/vfio0
> +	crw------- 1 root root 511, 0 Feb 16 01:22 /dev/vfio/devices/vfio0
> +	$ cat /sys/bus/pci/devices/0000:6a:01.0/vfio-dev/vfio0/dev
> +	511:0
> +	$ ls -l /dev/char/511\:0
> +	lrwxrwxrwx 1 root root 21 Feb 16 01:22 /dev/char/511:0 -> ../vfio/devices/vfio0
> +
> +Then provide the user with access to the device if unprivileged
> +operation is desired::
> +
> +	$ chown user:user /dev/vfio/devices/vfio0
> +
> +Finally the user could get cdev fd by::
> +
> +	cdev_fd = open("/dev/vfio/devices/vfio0", O_RDWR);
> +
> +An opened cdev_fd doesn't give the user any permission of accessing
> +the device except binding the cdev_fd to an iommufd.  After that point
> +then the device is fully accessible including attaching it to an
> +IOMMUFD IOAS/HWPT to enable userspace DMA::
> +
> +	struct vfio_device_bind_iommufd bind = {
> +		.argsz = sizeof(bind),
> +		.flags = 0,
> +	};
> +	struct iommu_ioas_alloc alloc_data  = {
> +		.size = sizeof(alloc_data),
> +		.flags = 0,
> +	};
> +	struct vfio_device_attach_iommufd_pt attach_data = {
> +		.argsz = sizeof(attach_data),
> +		.flags = 0,
> +	};
> +	struct iommu_ioas_map map = {
> +		.size = sizeof(map),
> +		.flags = IOMMU_IOAS_MAP_READABLE |
> +			 IOMMU_IOAS_MAP_WRITEABLE |
> +			 IOMMU_IOAS_MAP_FIXED_IOVA,
> +		.__reserved = 0,
> +	};
> +
> +	iommufd = open("/dev/iommu", O_RDWR);
> +
> +	bind.iommufd = iommufd;
> +	ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
> +
> +	ioctl(iommufd, IOMMU_IOAS_ALLOC, &alloc_data);
> +	attach_data.pt_id = alloc_data.out_ioas_id;
> +	ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
> +
> +	/* Allocate some space and setup a DMA mapping */
> +	map.user_va = (int64_t)mmap(0, 1024 * 1024, PROT_READ | PROT_WRITE,
> +				    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> +	map.iova = 0; /* 1MB starting at 0x0 from device view */
> +	map.length = 1024 * 1024;
> +	map.ioas_id = alloc_data.out_ioas_id;;
> +
> +	ioctl(iommufd, IOMMU_IOAS_MAP, &map);
> +
> +	/* Other device operations as stated in "VFIO Usage Example" */
> +
>  VFIO User API
>  -------------------------------------------------------------------------------
>  
> @@ -566,3 +690,11 @@ This implementation has some specifics:
>  				\-0d.1
>  
>  	00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 90)
> +
> +.. [5] Nested translation is an IOMMU feature which supports two stage
> +   address translations.  This improves the address translation efficiency
> +   in IOMMU virtualization.
> +
> +.. [6] PASID stands for Process Address Space ID, introduced by PCI
> +   Express.  It is a prerequisite for Shared Virtual Addressing (SVA)
> +   and Scalable I/O Virtualization (Scalable IOV).

