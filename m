Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA1D5F5648
	for <lists+linux-s390@lfdr.de>; Wed,  5 Oct 2022 16:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJEOWC (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 5 Oct 2022 10:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJEOWB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Oct 2022 10:22:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1952678BDF;
        Wed,  5 Oct 2022 07:22:00 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295E6s7J011082;
        Wed, 5 Oct 2022 14:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JXODhngn69fuyIengh30MKf8QEzdpEwWrdzqJ+QKi6A=;
 b=I4R7+c3HIJfjlbDweSCaAW67nsTDXU1M5U1JGDeyP9px5akRW91a5nDvope1SPXUpb5W
 qaysaDA7otEiHb2c3a6Jgi4KEI6zflNmiHgl40EJ1HEzfWDXgRbYJH18vs+votGyR8MR
 lkEl5w++ik4JlnTK9ZoptSqbp4htMQt4L/RJzSyK4EJoZtAgDv6wOuBqNvAHEZN5y3hd
 KL5jOEWrok+5nDjI6LMKuJ+RHLpb9cGF1A0stf5l2+7b3WwRpDkw06EUv+0/yUQbuPVB
 k39d3FH3sB0mtD+91ctyHd668SBmy+JnZnU+Zz+4rSjUxLw40L3DATrfiN0mCBcCao6G /A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k1aukssym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 14:21:54 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 295E8AR1016933;
        Wed, 5 Oct 2022 14:21:54 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k1aukssxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 14:21:54 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 295ELFYr007211;
        Wed, 5 Oct 2022 14:21:52 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 3jxd69m0ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 14:21:52 +0000
Received: from smtpav02.wdc07v.mail.ibm.com ([9.208.128.114])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 295ELpGw26673508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Oct 2022 14:21:52 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45DDE5805E;
        Wed,  5 Oct 2022 14:21:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96D965805C;
        Wed,  5 Oct 2022 14:21:49 +0000 (GMT)
Received: from [9.160.167.172] (unknown [9.160.167.172])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Oct 2022 14:21:49 +0000 (GMT)
Message-ID: <f449699f-38e3-9e15-cc1b-7213014e52ca@linux.ibm.com>
Date:   Wed, 5 Oct 2022 10:21:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2] vfio: Follow a strict lifetime for struct iommu_group
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        "Jason J . Herne" <jjherne@linux.ibm.com>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        Qian Cai <cai@lca.pw>, Joerg Roedel <jroedel@suse.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-s390 <linux-s390@vger.kernel.org>
References: <4cb6e49e-554e-57b3-e2d3-bc911d99083f@linux.ibm.com>
 <20220927140541.6f727b01.alex.williamson@redhat.com>
 <52545d8b-956b-8934-8a7e-212729ea2855@linux.ibm.com>
 <YzxT6Suu+272gDvP@nvidia.com>
 <1aebfa84-8310-5dff-1862-3d143878d9dd@linux.ibm.com>
 <YzxfK/e14Bx9yNyo@nvidia.com>
 <0a0d7937-316a-a0e2-9d7d-df8f3f8a38e3@linux.ibm.com>
 <33bc5258-5c95-99ee-a952-5b0b2826da3a@linux.ibm.com>
 <8982bc22-9afa-dde4-9f4e-38948db58789@linux.ibm.com>
 <Yz2NSDa3E6LpW1c5@nvidia.com> <Yz2OH5wJUi8kI/FF@ziepe.ca>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <Yz2OH5wJUi8kI/FF@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: g1XlWAT2dco7rF3c2DI8NfL_gvMEERc1
X-Proofpoint-GUID: T7lqSDiAiBaNiBjaigVfW-IaWx1msUtO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_03,2022-10-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210050088
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/5/22 10:01 AM, Jason Gunthorpe wrote:
> On Wed, Oct 05, 2022 at 10:57:28AM -0300, Jason Gunthorpe wrote:
>> On Wed, Oct 05, 2022 at 09:46:45AM -0400, Matthew Rosato wrote:
>>
>>  
>>> (again, with the follow-up applied) Besides the panic above I just
>>> noticed there is also this warning that immediately precedes and is
>>> perhaps more useful.  Re: what triggers the WARN, both group->owner
>>> and group->owner_cnt are already 0
>>
>> And this is after the 2nd try that fixes the locking?
>>
>> This shows that vfio_group_detach_container() is called twice (which
>> was my guess), hoever this looks to be impossible as both calls are
>> protected by 'if (group->container)' and the function NULL's
>> group->container and it is all under the proper lock.
>>
>> My guess was that missing locking caused the two cases to race and
>> trigger WARN, but the locking should fix that.
>>
>> So I'm at a loss, can you investigate a bit?
> 
> Huh, perhaps I'm loosing my mind, but I'm sure I sent this out, but it
> is not in the archive. This v2 fixes the missing locking and the rest
> of the remarks.

Ah, here we go.  OK, initial testing with vfio-pci on this version and I note that

1) the warning/crash is gone
2) the iommu group ID no longer increments

I next will take it through the longer series of tests that would crash before 'vfio: Follow a strict lifetime for struct iommu_group' but this looks good so far.

> 
> commit f8b993620af72fa5f15bd4c1515868013c1c173d
> Author: Jason Gunthorpe <jgg@ziepe.ca>
> Date:   Tue Oct 4 13:14:37 2022 -0300
> 
>     vfio: Make the group FD disassociate from the iommu_group
>     
>     Allow the vfio_group struct to exist with a NULL iommu_group pointer. When
>     the pointer is NULL the vfio_group users promise not to touch the
>     iommu_group. This allows a driver to be hot unplugged while userspace is
>     keeping the group FD open.
>     
>     SPAPR mode is excluded from this behavior because of how it wrongly hacks
>     part of its iommu interface through KVM. Due to this we loose control over
>     what it is doing and cannot revoke the iommu_group usage in the IOMMU
>     layer via vfio_group_detach_container().
>     
>     Thus, for SPAPR the group FDs must still be closed before a device can be
>     hot unplugged.
>     
>     This fixes a userspace regression where we learned that virtnodedevd
>     leaves a group FD open even though the /dev/ node for it has been deleted
>     and all the drivers for it unplugged.
>     
>     Fixes: ca5f21b25749 ("vfio: Follow a strict lifetime for struct iommu_group")
>     Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>     Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 59a28251bb0b97..badc9d828cac20 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1313,7 +1313,7 @@ static int vfio_pci_ioctl_pci_hot_reset(struct vfio_pci_core_device *vdev,
>  		}
>  
>  		/* Ensure the FD is a vfio group FD.*/
> -		if (!vfio_file_iommu_group(file)) {
> +		if (!vfio_file_is_group(file)) {
>  			fput(file);
>  			ret = -EINVAL;
>  			break;
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 4d2de02f2ced6e..4e10a281420e66 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -59,6 +59,7 @@ struct vfio_group {
>  	struct mutex			group_lock;
>  	struct kvm			*kvm;
>  	struct file			*opened_file;
> +	bool				preserve_iommu_group;
>  	struct swait_queue_head		opened_file_wait;
>  	struct blocking_notifier_head	notifier;
>  };
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 9b1e5fd5f7b73c..13d22bd84afc47 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -133,6 +133,10 @@ __vfio_group_get_from_iommu(struct iommu_group *iommu_group)
>  {
>  	struct vfio_group *group;
>  
> +	/*
> +	 * group->iommu_group from the vfio.group_list cannot be NULL
> +	 * under the vfio.group_lock.
> +	 */
>  	list_for_each_entry(group, &vfio.group_list, vfio_next) {
>  		if (group->iommu_group == iommu_group) {
>  			refcount_inc(&group->drivers);
> @@ -159,7 +163,7 @@ static void vfio_group_release(struct device *dev)
>  
>  	mutex_destroy(&group->device_lock);
>  	mutex_destroy(&group->group_lock);
> -	iommu_group_put(group->iommu_group);
> +	WARN_ON(group->iommu_group);
>  	ida_free(&vfio.group_ida, MINOR(group->dev.devt));
>  	kfree(group);
>  }
> @@ -248,6 +252,7 @@ static struct vfio_group *vfio_create_group(struct iommu_group *iommu_group,
>  static void vfio_device_remove_group(struct vfio_device *device)
>  {
>  	struct vfio_group *group = device->group;
> +	struct iommu_group *iommu_group;
>  
>  	if (group->type == VFIO_NO_IOMMU || group->type == VFIO_EMULATED_IOMMU)
>  		iommu_group_remove_device(device->dev);
> @@ -265,13 +270,36 @@ static void vfio_device_remove_group(struct vfio_device *device)
>  	 */
>  	cdev_device_del(&group->cdev, &group->dev);
>  
> +	mutex_lock(&group->group_lock);
> +	/*
> +	 * These data structures all have paired operations that can only be
> +	 * undone when the caller holds a live reference on the device. Since
> +	 * all pairs must be undone these WARN_ON's indicate some caller did not
> +	 * properly hold the group reference.l.
> +	 */
> +	WARN_ON(!list_empty(&group->device_list));
> +	WARN_ON(group->notifier.head);
> +
> +	/*
> +	 * Revoke all users of group->iommu_group. At this point we know there
> +	 * are no devices active because we are unplugging the last one. Setting
> +	 * iommu_group to NULL blocks all new users.
> +	 */
> +	if (group->container)
> +		vfio_group_detach_container(group);
> +	iommu_group = group->iommu_group;
> +	group->iommu_group = NULL;
> +	mutex_unlock(&group->group_lock);
> +
>  	/*
> -	 * Before we allow the last driver in the group to be unplugged the
> -	 * group must be sanitized so nothing else is or can reference it. This
> -	 * is because the group->iommu_group pointer should only be used so long
> -	 * as a device driver is attached to a device in the group.
> +	 * Normally we can set the iommu_group to NULL above and that will
> +	 * prevent any users from touching it. However, the SPAPR kvm path takes
> +	 * a reference to the iommu_group and keeps using it in arch code out
> +	 * side our control. So if this path is triggred we have no choice but
> +	 * to wait for the group FD to be closed to be sure everyone has stopped
> +	 * touching the group.
>  	 */
> -	while (group->opened_file) {
> +	while (group->preserve_iommu_group && group->opened_file) {
>  		mutex_unlock(&vfio.group_lock);
>  		swait_event_idle_exclusive(group->opened_file_wait,
>  					   !group->opened_file);
> @@ -279,17 +307,7 @@ static void vfio_device_remove_group(struct vfio_device *device)
>  	}
>  	mutex_unlock(&vfio.group_lock);
>  
> -	/*
> -	 * These data structures all have paired operations that can only be
> -	 * undone when the caller holds a live reference on the group. Since all
> -	 * pairs must be undone these WARN_ON's indicate some caller did not
> -	 * properly hold the group reference.
> -	 */
> -	WARN_ON(!list_empty(&group->device_list));
> -	WARN_ON(group->container || group->container_users);
> -	WARN_ON(group->notifier.head);
> -	group->iommu_group = NULL;
> -
> +	iommu_group_put(iommu_group);
>  	put_device(&group->dev);
>  }
>  
> @@ -531,6 +549,10 @@ static int __vfio_register_dev(struct vfio_device *device,
>  
>  	existing_device = vfio_group_get_device(group, device->dev);
>  	if (existing_device) {
> +		/*
> +		 * group->iommu_group is non-NULL because we hold the drivers
> +		 * refcount.
> +		 */
>  		dev_WARN(device->dev, "Device already exists on group %d\n",
>  			 iommu_group_id(group->iommu_group));
>  		vfio_device_put_registration(existing_device);
> @@ -702,6 +724,11 @@ static int vfio_group_ioctl_set_container(struct vfio_group *group,
>  		ret = -EINVAL;
>  		goto out_unlock;
>  	}
> +	if (!group->iommu_group) {
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +
>  	container = vfio_container_from_file(f.file);
>  	ret = -EINVAL;
>  	if (container) {
> @@ -862,6 +889,11 @@ static int vfio_group_ioctl_get_status(struct vfio_group *group,
>  	status.flags = 0;
>  
>  	mutex_lock(&group->group_lock);
> +	if (!group->iommu_group) {
> +		mutex_unlock(&group->group_lock);
> +		return -ENODEV;
> +	}
> +
>  	if (group->container)
>  		status.flags |= VFIO_GROUP_FLAGS_CONTAINER_SET |
>  				VFIO_GROUP_FLAGS_VIABLE;
> @@ -938,13 +970,6 @@ static int vfio_group_fops_release(struct inode *inode, struct file *filep)
>  	filep->private_data = NULL;
>  
>  	mutex_lock(&group->group_lock);
> -	/*
> -	 * Device FDs hold a group file reference, therefore the group release
> -	 * is only called when there are no open devices.
> -	 */
> -	WARN_ON(group->notifier.head);
> -	if (group->container)
> -		vfio_group_detach_container(group);
>  	group->opened_file = NULL;
>  	mutex_unlock(&group->group_lock);
>  	swake_up_one(&group->opened_file_wait);
> @@ -1553,17 +1578,41 @@ static const struct file_operations vfio_device_fops = {
>   * @file: VFIO group file
>   *
>   * The returned iommu_group is valid as long as a ref is held on the file.
> + * This function is deprecated, only the SPAPR path in kvm should call it.
>   */
>  struct iommu_group *vfio_file_iommu_group(struct file *file)
>  {
>  	struct vfio_group *group = file->private_data;
> +	struct iommu_group *iommu_group = NULL;
> +
> +	if (!IS_ENABLED(CONFIG_SPAPR_TCE_IOMMU))
> +		return NULL;
>  
>  	if (file->f_op != &vfio_group_fops)
>  		return NULL;
> -	return group->iommu_group;
> +
> +	mutex_lock(&vfio.group_lock);
> +	mutex_lock(&group->group_lock);
> +	if (group->iommu_group) {
> +		iommu_group = group->iommu_group;
> +		group->preserve_iommu_group = true;
> +	}
> +	mutex_unlock(&group->group_lock);
> +	mutex_unlock(&vfio.group_lock);
> +	return iommu_group;
>  }
>  EXPORT_SYMBOL_GPL(vfio_file_iommu_group);
>  
> +/**
> + * vfio_file_is_group - True if the file is usable with VFIO aPIS
> + * @file: VFIO group file
> + */
> +bool vfio_file_is_group(struct file *file)
> +{
> +	return file->f_op == &vfio_group_fops;
> +}
> +EXPORT_SYMBOL_GPL(vfio_file_is_group);
> +
>  /**
>   * vfio_file_enforced_coherent - True if the DMA associated with the VFIO file
>   *        is always CPU cache coherent
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 73bcb92179a224..bd9faaab85de18 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -199,6 +199,7 @@ int vfio_mig_get_next_state(struct vfio_device *device,
>   * External user API
>   */
>  struct iommu_group *vfio_file_iommu_group(struct file *file);
> +bool vfio_file_is_group(struct file *file);
>  bool vfio_file_enforced_coherent(struct file *file);
>  void vfio_file_set_kvm(struct file *file, struct kvm *kvm);
>  bool vfio_file_has_dev(struct file *file, struct vfio_device *device);
> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> index ce1b01d02c5197..54aec3b0559c70 100644
> --- a/virt/kvm/vfio.c
> +++ b/virt/kvm/vfio.c
> @@ -61,6 +61,23 @@ static bool kvm_vfio_file_enforced_coherent(struct file *file)
>  	return ret;
>  }
>  
> +static bool kvm_vfio_file_is_group(struct file *file)
> +{
> +	bool (*fn)(struct file *file);
> +	bool ret;
> +
> +	fn = symbol_get(vfio_file_is_group);
> +	if (!fn)
> +		return false;
> +
> +	ret = fn(file);
> +
> +	symbol_put(vfio_file_is_group);
> +
> +	return ret;
> +}
> +
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>  static struct iommu_group *kvm_vfio_file_iommu_group(struct file *file)
>  {
>  	struct iommu_group *(*fn)(struct file *file);
> @@ -77,7 +94,6 @@ static struct iommu_group *kvm_vfio_file_iommu_group(struct file *file)
>  	return ret;
>  }
>  
> -#ifdef CONFIG_SPAPR_TCE_IOMMU
>  static void kvm_spapr_tce_release_vfio_group(struct kvm *kvm,
>  					     struct kvm_vfio_group *kvg)
>  {
> @@ -136,7 +152,7 @@ static int kvm_vfio_group_add(struct kvm_device *dev, unsigned int fd)
>  		return -EBADF;
>  
>  	/* Ensure the FD is a vfio group FD.*/
> -	if (!kvm_vfio_file_iommu_group(filp)) {
> +	if (!kvm_vfio_file_is_group(filp)) {
>  		ret = -EINVAL;
>  		goto err_fput;
>  	}

