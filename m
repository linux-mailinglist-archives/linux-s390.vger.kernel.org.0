Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C36E53BE9C
	for <lists+linux-s390@lfdr.de>; Thu,  2 Jun 2022 21:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbiFBTUw (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 2 Jun 2022 15:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238565AbiFBTUD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Jun 2022 15:20:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0241929D;
        Thu,  2 Jun 2022 12:19:49 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252J2AQY001905;
        Thu, 2 Jun 2022 19:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DgsBHx9IzQz0gKh7wg/SYVVq1u+u8lL7fYTKGTKWJYY=;
 b=gIdkVXHhJCAjBbZ9s0J4sd3sjP/YEaX9VKB48B+zDg2SV+EUF+OV1xSStKardn5QE9HD
 6mrJeFWxeRa2LEM0fT84C1seiGAThWmkyv1IF2h4B6GjU/0LBcQSdBUf3pq8Q27Tawip
 AORaVZPikGzTpyDiYkK1Duw4xUNEB8fcSD+8wk5RbkSNimxzwUUV5pungDZNKJvOnhyY
 hYip1f0kXYxOHCj8zfFTkTMmR3d45IXy2oYgpKuj8oyMOdE04idJcyrJAYX8+mjYm9Mr
 tqFKw1BAi+f2Vhx3e7dh44yxB5O4Q6e7A3R5js/GUGJNniUmeUESx1gYjDYaaYTW/haS 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gf30v89cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 19:19:47 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 252JAiU4034651;
        Thu, 2 Jun 2022 19:19:46 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gf30v89cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 19:19:46 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 252J5iD8007634;
        Thu, 2 Jun 2022 19:19:45 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma05wdc.us.ibm.com with ESMTP id 3gds40e9d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 19:19:45 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 252JJiT79830688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Jun 2022 19:19:44 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC8F013605E;
        Thu,  2 Jun 2022 19:19:44 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8743D136061;
        Thu,  2 Jun 2022 19:19:43 +0000 (GMT)
Received: from [9.160.37.241] (unknown [9.160.37.241])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  2 Jun 2022 19:19:43 +0000 (GMT)
Message-ID: <e1ee7b53-9522-6a8a-463b-329bdab0dd30@linux.ibm.com>
Date:   Thu, 2 Jun 2022 15:19:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v19 15/20] s390/vfio-ap: implement in-use callback for
 vfio_ap driver
Content-Language: en-US
To:     jjherne@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com
References: <20220404221039.1272245-1-akrowiak@linux.ibm.com>
 <20220404221039.1272245-16-akrowiak@linux.ibm.com>
 <6a574d7e-c390-3764-a57c-23c7653f2f69@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <6a574d7e-c390-3764-a57c-23c7653f2f69@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6_uWuS3Wv6BwcNhPdbQCMwLD6Zbk1zAC
X-Proofpoint-ORIG-GUID: CxBK6P8bLHASdqS1p5y7v-t2HKi3x5zM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_05,2022-06-02_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 clxscore=1015 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206020081
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 6/2/22 2:16 PM, Jason J. Herne wrote:
> On 4/4/22 18:10, Tony Krowiak wrote:
>> Let's implement the callback to indicate when an APQN
>> is in use by the vfio_ap device driver. The callback is
>> invoked whenever a change to the apmask or aqmask would
>> result in one or more queue devices being removed from the driver. The
>> vfio_ap device driver will indicate a resource is in use
>> if the APQN of any of the queue devices to be removed are assigned to
>> any of the matrix mdevs under the driver's control.
>>
>> There is potential for a deadlock condition between the
>> matrix_dev->guests_lock used to lock the guest during assignment of
>> adapters and domains and the ap_perms_mutex locked by the AP bus when
>> changes are made to the sysfs apmask/aqmask attributes.
>>
>> The AP Perms lock controls access to the objects that store the adapter
>> numbers (ap_perms) and domain numbers (aq_perms) for the sysfs
>> /sys/bus/ap/apmask and /sys/bus/ap/aqmask attributes. These attributes
>> identify which queues are reserved for the zcrypt default device 
>> drivers.
>> Before allowing a bit to be removed from either mask, the AP bus must 
>> check
>> with the vfio_ap device driver to verify that none of the queues are
>> assigned to any of its mediated devices.
>>
>> The apmask/aqmask attributes can be written or read at any time from
>> userspace, so care must be taken to prevent a deadlock with asynchronous
>> operations that might be taking place in the vfio_ap device driver. For
>> example, consider the following:
>>
>> 1. A system administrator assigns an adapter to a mediated device 
>> under the
>>     control of the vfio_ap device driver. The driver will need to 
>> first take
>>     the matrix_dev->guests_lock to potentially hot plug the adapter into
>>     the KVM guest.
>> 2. At the same time, a system administrator sets a bit in the sysfs
>>     /sys/bus/ap/ap_mask attribute. To complete the operation, the AP bus
>>     must:
>>     a. Take the ap_perms_mutex lock to update the object storing the 
>> values
>>        for the /sys/bus/ap/ap_mask attribute.
>>     b. Call the vfio_ap device driver's in-use callback to verify 
>> that the
>>        queues now being reserved for the default zcrypt drivers are not
>>        assigned to a mediated device owned by the vfio_ap device 
>> driver. To
>>        do the verification, the in-use callback function takes the
>>        matrix_dev->guests_lock, but has to wait because it is already 
>> held
>>        by the operation in 1 above.
>> 3. The vfio_ap device driver calls an AP bus function to verify that the
>>     new queues resulting from the assignment of the adapter in step 1 
>> are
>>     not reserved for the default zcrypt device driver. This AP bus 
>> function
>>     tries to take the ap_perms_mutex lock but gets stuck waiting for the
>>     waiting for the lock due to step 2a above.
>>
>> Consequently, we have the following deadlock situation:
>>
>> matrix_dev->guests_lock locked (1)
>> ap_perms_mutex lock locked (2a)
>> Waiting for matrix_dev->gusts_lock (2b) which is currently held (1)
>> Waiting for ap_perms_mutex lock (3) which is currently held (2a)
>>
>> To prevent this deadlock scenario, the function called in step 3 will no
>> longer take the ap_perms_mutex lock and require the caller to take the
>> lock. The lock will be the first taken by the adapter/domain assignment
>> functions in the vfio_ap device driver to maintain the proper locking
>> order.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/ap_bus.c          | 31 ++++++++----
>>   drivers/s390/crypto/vfio_ap_drv.c     |  1 +
>>   drivers/s390/crypto/vfio_ap_ops.c     | 68 +++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |  2 +
>>   4 files changed, 94 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
>> index fdf16cb70881..f48552e900a2 100644
>> --- a/drivers/s390/crypto/ap_bus.c
>> +++ b/drivers/s390/crypto/ap_bus.c
>> @@ -817,6 +817,17 @@ static void ap_bus_revise_bindings(void)
>>       bus_for_each_dev(&ap_bus_type, NULL, NULL, __ap_revise_reserved);
>>   }
>>   +/**
>> + * ap_apqn_in_matrix_owned_by_def_drv: indicates whether an APQN c 
>> is reserved
>> + *                       for the host drivers or not.
>> + * @card: the APID of the adapter card to check
>> + * @queue: the APQI of the queue to check
>> + *
>> + * Note: the ap_perms_mutex must be locked by the caller of this 
>> function.
>> + *
>> + * Return: an int specifying whether the APQN is reserved for the 
>> host (1) or
>> + *       not (0)
>> + */
>
> Comment's function name does not match real function name. Also APQN 
> "c", from
> description does not appear to exist.

No, it definitely does not match and the 'c' is an extraneous typo. I'll 
fix both.

>
>
>
>>   int ap_owned_by_def_drv(int card, int queue)
>>   {
>>       int rc = 0;
>> @@ -824,25 +835,31 @@ int ap_owned_by_def_drv(int card, int queue)
>>       if (card < 0 || card >= AP_DEVICES || queue < 0 || queue >= 
>> AP_DOMAINS)
>>           return -EINVAL;
>>   -    mutex_lock(&ap_perms_mutex);
>> -
>>       if (test_bit_inv(card, ap_perms.apm)
>>           && test_bit_inv(queue, ap_perms.aqm))
>>           rc = 1;
>>   -    mutex_unlock(&ap_perms_mutex);
>> -
>>       return rc;
>>   }
>>   EXPORT_SYMBOL(ap_owned_by_def_drv);
>>   +/**
>> + * ap_apqn_in_matrix_owned_by_def_drv: indicates whether every APQN 
>> contained in
>> + *                       a set is reserved for the host drivers
>> + *                       or not.
>> + * @apm: a bitmap specifying a set of APIDs comprising the APQNs to 
>> check
>> + * @aqm: a bitmap specifying a set of APQIs comprising the APQNs to 
>> check
>> + *
>> + * Note: the ap_perms_mutex must be locked by the caller of this 
>> function.
>> + *
>> + * Return: an int specifying whether each APQN is reserved for the 
>> host (1) or
>> + *       not (0)
>> + */
>>   int ap_apqn_in_matrix_owned_by_def_drv(unsigned long *apm,
>>                          unsigned long *aqm)
>>   {
>>       int card, queue, rc = 0;
>>   -    mutex_lock(&ap_perms_mutex);
>> -
>>       for (card = 0; !rc && card < AP_DEVICES; card++)
>>           if (test_bit_inv(card, apm) &&
>>               test_bit_inv(card, ap_perms.apm))
>> @@ -851,8 +868,6 @@ int ap_apqn_in_matrix_owned_by_def_drv(unsigned 
>> long *apm,
>>                       test_bit_inv(queue, ap_perms.aqm))
>>                       rc = 1;
>>   -    mutex_unlock(&ap_perms_mutex);
>> -
>>       return rc;
>>   }
>>   EXPORT_SYMBOL(ap_apqn_in_matrix_owned_by_def_drv);
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c 
>> b/drivers/s390/crypto/vfio_ap_drv.c
>> index c258e5f7fdfc..2c3084589347 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -107,6 +107,7 @@ static const struct attribute_group 
>> vfio_queue_attr_group = {
>>   static struct ap_driver vfio_ap_drv = {
>>       .probe = vfio_ap_mdev_probe_queue,
>>       .remove = vfio_ap_mdev_remove_queue,
>> +    .in_use = vfio_ap_mdev_resource_in_use,
>>       .ids = ap_queue_ids,
>>   };
>>   diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index 49ed54dc9e05..3ece2cd9f1e7 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -902,6 +902,21 @@ static int 
>> vfio_ap_mdev_verify_no_sharing(unsigned long *mdev_apm,
>>       return 0;
>>   }
>>   +/**
>> + * vfio_ap_mdev_validate_masks - verify that the APQNs assigned to 
>> the mdev are
>> + *                 not reserved for the default zcrypt driver and
>> + *                 are not assigned to another mdev.
>> + *
>> + * @matrix_mdev: the mdev to which the APQNs being validated are 
>> assigned.
>> + *
>> + * Return: One of the following values:
>> + * o the error returned from the 
>> ap_apqn_in_matrix_owned_by_def_drv() function,
>> + *   most likely -EBUSY indicating the ap_perms_mutex lock is 
>> already held.
>> + * o EADDRNOTAVAIL if an APQN assigned to @matrix_mdev is reserved 
>> for the
>> + *           zcrypt default driver.
>> + * o EADDRINUSE if an APQN assigned to @matrix_mdev is assigned to 
>> another mdev
>> + * o A zero indicating validation succeeded.
>> + */
>>   static int vfio_ap_mdev_validate_masks(struct ap_matrix_mdev 
>> *matrix_mdev)
>>   {
>>       if (ap_apqn_in_matrix_owned_by_def_drv(matrix_mdev->matrix.apm,
>> @@ -951,6 +966,10 @@ static void vfio_ap_mdev_link_adapter(struct 
>> ap_matrix_mdev *matrix_mdev,
>>    *       An APQN derived from the cross product of the APID being 
>> assigned
>>    *       and the APQIs previously assigned is being used by another 
>> mediated
>>    *       matrix device
>> + *
>> + *    5. -EAGAIN
>> + *       A lock required to validate the mdev's AP configuration 
>> could not
>> + *       be obtained.
>>    */
>>   static ssize_t assign_adapter_store(struct device *dev,
>>                       struct device_attribute *attr,
>> @@ -961,6 +980,7 @@ static ssize_t assign_adapter_store(struct device 
>> *dev,
>>       DECLARE_BITMAP(apm_delta, AP_DEVICES);
>>       struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
>>   +    mutex_lock(&ap_perms_mutex);
>>       get_update_locks_for_mdev(matrix_mdev);
>>         ret = kstrtoul(buf, 0, &apid);
>> @@ -991,6 +1011,7 @@ static ssize_t assign_adapter_store(struct 
>> device *dev,
>>       ret = count;
>>   done:
>>       release_update_locks_for_mdev(matrix_mdev);
>> +    mutex_unlock(&ap_perms_mutex);
>>         return ret;
>>   }
>> @@ -1144,6 +1165,10 @@ static void vfio_ap_mdev_link_domain(struct 
>> ap_matrix_mdev *matrix_mdev,
>>    *       An APQN derived from the cross product of the APQI being 
>> assigned
>>    *       and the APIDs previously assigned is being used by another 
>> mediated
>>    *       matrix device
>> + *
>> + *    5. -EAGAIN
>> + *       The lock required to validate the mdev's AP configuration 
>> could not
>> + *       be obtained.
>>    */
>>   static ssize_t assign_domain_store(struct device *dev,
>>                      struct device_attribute *attr,
>> @@ -1154,6 +1179,7 @@ static ssize_t assign_domain_store(struct 
>> device *dev,
>>       DECLARE_BITMAP(aqm_delta, AP_DOMAINS);
>>       struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
>>   +    mutex_lock(&ap_perms_mutex);
>>       get_update_locks_for_mdev(matrix_mdev);
>>         ret = kstrtoul(buf, 0, &apqi);
>> @@ -1184,6 +1210,7 @@ static ssize_t assign_domain_store(struct 
>> device *dev,
>>       ret = count;
>>   done:
>>       release_update_locks_for_mdev(matrix_mdev);
>> +    mutex_unlock(&ap_perms_mutex);
>>         return ret;
>>   }
>> @@ -1868,3 +1895,44 @@ void vfio_ap_mdev_remove_queue(struct 
>> ap_device *apdev)
>>       kfree(q);
>>       release_update_locks_for_mdev(matrix_mdev);
>>   }
>> +
>> +/**
>> + * vfio_ap_mdev_resource_in_use: check whether any of a set of APQNs is
>> + *                 assigned to a mediated device under the control
>> + *                 of the vfio_ap device driver.
>> + *
>> + * @apm: a bitmap specifying a set of APIDs comprising the APQNs to 
>> check.
>> + * @aqm: a bitmap specifying a set of APQIs comprising the APQNs to 
>> check.
>> + *
>> + * This function is invoked by the AP bus when changes to the 
>> apmask/aqmask
>> + * attributes will result in giving control of the queue devices 
>> specified via
>> + * @apm and @aqm to the default zcrypt device driver. Prior to 
>> calling this
>> + * function, the AP bus locks the ap_perms_mutex. If this function 
>> is called
>> + * while an adapter or domain is being assigned to a mediated 
>> device, the
>> + * assignment operations will take the matrix_dev->guests_lock and
>> + * matrix_dev->mdevs_lock then call the 
>> ap_apqn_in_matrix_owned_by_def_drv
>> + * function, which also locks the ap_perms_mutex. This could result 
>> in a
>> + * deadlock.
>> + *
>> + * To avoid a deadlock, this function will verify that the
>> + * matrix_dev->guests_lock and matrix_dev->mdevs_lock are not 
>> currently held and
>> + * will return -EBUSY if the locks can not be obtained.
>
> This part of the comment does not seem to match reality. Unless I'm 
> missing
> something? Did you mean to call mutex_trylock? Or is the comment stale?

The comment was written prior to the changes introduced to avoid the locking
dependency (i.e., taking the ap_perms_mutex lock by the assignment functions
which I believe was your suggestion). I shall remove the comment.

>
>> + * Return:
>> + *    * -EBUSY if the locks required by this function are already 
>> locked.
>> + *    * -EADDRINUSE if one or more of the APQNs specified via 
>> @apm/@aqm are
>> + *      assigned to a mediated device under the control of the vfio_ap
>> + *      device driver.
>> + */
>> +int vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long 
>> *aqm)
>> +{
>> +    int ret;
>> +
>> +    mutex_lock(&matrix_dev->guests_lock);
>> +    mutex_lock(&matrix_dev->mdevs_lock);
>> +    ret = vfio_ap_mdev_verify_no_sharing(apm, aqm);
>> +    mutex_unlock(&matrix_dev->mdevs_lock);
>> +    mutex_unlock(&matrix_dev->guests_lock);
>> +
>> +    return ret;
>> +}
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h 
>> b/drivers/s390/crypto/vfio_ap_private.h
>> index 6d4ca39f783b..cbffa0bd01da 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -147,4 +147,6 @@ void vfio_ap_mdev_unregister(void);
>>   int vfio_ap_mdev_probe_queue(struct ap_device *queue);
>>   void vfio_ap_mdev_remove_queue(struct ap_device *queue);
>>   +int vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long 
>> *aqm);
>> +
>>   #endif /* _VFIO_AP_PRIVATE_H_ */
>
>

