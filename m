Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4F672D39A
	for <lists+linux-s390@lfdr.de>; Mon, 12 Jun 2023 23:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjFLVx1 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 12 Jun 2023 17:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238286AbjFLVxJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 12 Jun 2023 17:53:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF8510D8
        for <linux-s390@vger.kernel.org>; Mon, 12 Jun 2023 14:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686606735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=boA3uYLp9Lq3xOIcpkhvQI3DYCAEvrjZcD5trap1f04=;
        b=NLEcMe1SrKj9XrYo5BQRoT9292t4/G+/lTzLlFMV4WIzUOpOvx3vdRwP/dp/JadX+Djg1n
        DUfwXsH5gS4JP+/EtIDLJ9xmMS87cYXJyVKwoNqVd7daX99P7jQvXSUJNTiCoxvIRC4niB
        8qTWG8QNHCZDDLhkx7aLPVIOxW+JRfc=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-fGHaZlZuOjiB6WyOz_7bhQ-1; Mon, 12 Jun 2023 17:52:13 -0400
X-MC-Unique: fGHaZlZuOjiB6WyOz_7bhQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-77ac14e9bc5so585767139f.2
        for <linux-s390@vger.kernel.org>; Mon, 12 Jun 2023 14:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686606733; x=1689198733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boA3uYLp9Lq3xOIcpkhvQI3DYCAEvrjZcD5trap1f04=;
        b=ibDlTNSPhnuV11+MPag4rCoZulUAT2ieIfcd6eKgQjagKkhjMuCsIDDX/sR3YKYyWg
         aolZ/oLj5pCtCFp0uhqDh/g4MLbI01ar/4NdUqA/QxngtpPqJD1FxOJ3UPK9uqm02UQY
         U0p8jRi+LhdHxkPqXeT78dfGruJKVOWmtu2m/XynPGHEArTIFBsNbudgUCoXOdbPo6F2
         XYkBBLaI1H4eSHqDjwfq03/5v/tno0N2wCP4MwdDimF9FxfwP9i/u3N1gVtGUWwqFy7f
         6zdyXHa8TL9YeP8BbsENXQfVE+ANcBxJG9ZOlbKWCmOyZ1giI49QUEmeqiHGQP52HSBC
         63vA==
X-Gm-Message-State: AC+VfDzT/ivoAFzqbiFrT/mBOqqKkCCH/YOAAFcThylnwOnCXgJydcn6
        I2NXILaffesVir81MZ36m4uVOEIHtiO4a2wVCpy6lhRE0Hh+4U/MtO18/8EUgWYzofn+TgUuK2V
        UvGp98NqCBKrne4oJp2p8Xg==
X-Received: by 2002:a6b:7b45:0:b0:77a:ec0c:5907 with SMTP id m5-20020a6b7b45000000b0077aec0c5907mr6931510iop.13.1686606733112;
        Mon, 12 Jun 2023 14:52:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63rekNLLQDnyK8nJOL8AIQHD4qdXRPI2wqFuMCbJroFEC5NjXVpyDmFDmxaenIzEmd4Wxl3A==
X-Received: by 2002:a6b:7b45:0:b0:77a:ec0c:5907 with SMTP id m5-20020a6b7b45000000b0077aec0c5907mr6931503iop.13.1686606732857;
        Mon, 12 Jun 2023 14:52:12 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id u15-20020a02cbcf000000b0040f9af9237asm160026jaq.41.2023.06.12.14.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:52:12 -0700 (PDT)
Date:   Mon, 12 Jun 2023 15:52:10 -0600
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
Subject: Re: [PATCH v12 07/24] vfio: Block device access via device fd until
 device is opened
Message-ID: <20230612155210.5fd3579f.alex.williamson@redhat.com>
In-Reply-To: <20230602121653.80017-8-yi.l.liu@intel.com>
References: <20230602121653.80017-1-yi.l.liu@intel.com>
        <20230602121653.80017-8-yi.l.liu@intel.com>
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

On Fri,  2 Jun 2023 05:16:36 -0700
Yi Liu <yi.l.liu@intel.com> wrote:

> Allow the vfio_device file to be in a state where the device FD is
> opened but the device cannot be used by userspace (i.e. its .open_device()
> hasn't been called). This inbetween state is not used when the device
> FD is spawned from the group FD, however when we create the device FD
> directly by opening a cdev it will be opened in the blocked state.
> 
> The reason for the inbetween state is that userspace only gets a FD but
> doesn't gain access permission until binding the FD to an iommufd. So in
> the blocked state, only the bind operation is allowed. Completing bind
> will allow user to further access the device.
> 
> This is implemented by adding a flag in struct vfio_device_file to mark
> the blocked state and using a simple smp_load_acquire() to obtain the
> flag value and serialize all the device setup with the thread accessing
> this device.
> 
> Following this lockless scheme, it can safely handle the device FD
> unbound->bound but it cannot handle bound->unbound. To allow this we'd
> need to add a lock on all the vfio ioctls which seems costly. So once
> device FD is bound, it remains bound until the FD is closed.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Terrence Xu <terrence.xu@intel.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Tested-by: Yanting Jiang <yanting.jiang@intel.com>
> Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/vfio/group.c     | 11 ++++++++++-
>  drivers/vfio/vfio.h      |  1 +
>  drivers/vfio/vfio_main.c | 16 ++++++++++++++++
>  3 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index caf53716ddb2..088dd34c8931 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -194,9 +194,18 @@ static int vfio_df_group_open(struct vfio_device_file *df)
>  	df->iommufd = device->group->iommufd;
>  
>  	ret = vfio_df_open(df);
> -	if (ret)
> +	if (ret) {
>  		df->iommufd = NULL;
> +		goto out_put_kvm;
> +	}
> +
> +	/*
> +	 * Paired with smp_load_acquire() in vfio_device_fops::ioctl/
> +	 * read/write/mmap and vfio_file_has_device_access()
> +	 */
> +	smp_store_release(&df->access_granted, true);
>  
> +out_put_kvm:
>  	if (device->open_count == 0)
>  		vfio_device_put_kvm(device);
>  
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index f9eb52eb9ed7..fdf2fc73f880 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -18,6 +18,7 @@ struct vfio_container;
>  
>  struct vfio_device_file {
>  	struct vfio_device *device;
> +	bool access_granted;

Should we make this a more strongly defined data type and later move
devid (u32) here to partially fill the hole created?

I think this is being placed towards the front of the data structure
for cache line locality given this is a hot path for file operations.
But bool types have an implementation dependent size, making them
difficult to pack.  Also there will be a tendency to want to make this
a bit field, which is probably not compatible with the smp lockless
operations being used here.  We might get in front of these issues if
we just define it as a u8 now.  Thanks,

Alex

>  	spinlock_t kvm_ref_lock; /* protect kvm field */
>  	struct kvm *kvm;
>  	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index a3c5817fc545..4c8b7713dc3d 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1129,6 +1129,10 @@ static long vfio_device_fops_unl_ioctl(struct file *filep,
>  	struct vfio_device *device = df->device;
>  	int ret;
>  
> +	/* Paired with smp_store_release() following vfio_df_open() */
> +	if (!smp_load_acquire(&df->access_granted))
> +		return -EINVAL;
> +
>  	ret = vfio_device_pm_runtime_get(device);
>  	if (ret)
>  		return ret;
> @@ -1156,6 +1160,10 @@ static ssize_t vfio_device_fops_read(struct file *filep, char __user *buf,
>  	struct vfio_device_file *df = filep->private_data;
>  	struct vfio_device *device = df->device;
>  
> +	/* Paired with smp_store_release() following vfio_df_open() */
> +	if (!smp_load_acquire(&df->access_granted))
> +		return -EINVAL;
> +
>  	if (unlikely(!device->ops->read))
>  		return -EINVAL;
>  
> @@ -1169,6 +1177,10 @@ static ssize_t vfio_device_fops_write(struct file *filep,
>  	struct vfio_device_file *df = filep->private_data;
>  	struct vfio_device *device = df->device;
>  
> +	/* Paired with smp_store_release() following vfio_df_open() */
> +	if (!smp_load_acquire(&df->access_granted))
> +		return -EINVAL;
> +
>  	if (unlikely(!device->ops->write))
>  		return -EINVAL;
>  
> @@ -1180,6 +1192,10 @@ static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
>  	struct vfio_device_file *df = filep->private_data;
>  	struct vfio_device *device = df->device;
>  
> +	/* Paired with smp_store_release() following vfio_df_open() */
> +	if (!smp_load_acquire(&df->access_granted))
> +		return -EINVAL;
> +
>  	if (unlikely(!device->ops->mmap))
>  		return -EINVAL;
>  

