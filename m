Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFFA22F244
	for <lists+linux-s390@lfdr.de>; Mon, 27 Jul 2020 16:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgG0OKY (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 27 Jul 2020 10:10:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729829AbgG0OKX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Jul 2020 10:10:23 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RE0qlp162323;
        Mon, 27 Jul 2020 10:10:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32hvhdqhmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 10:10:04 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06RE0uYE162713;
        Mon, 27 Jul 2020 10:10:03 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32hvhdqhm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 10:10:03 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06RDoQQ0032136;
        Mon, 27 Jul 2020 14:10:02 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 32gcy6p1qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 14:10:02 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06RE9xjE41419180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 14:09:59 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75B786A05A;
        Mon, 27 Jul 2020 14:09:59 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 288766A057;
        Mon, 27 Jul 2020 14:09:58 +0000 (GMT)
Received: from cpe-172-100-175-116.stny.res.rr.com (unknown [9.85.167.215])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jul 2020 14:09:57 +0000 (GMT)
Subject: Re: [PATCH v9 02/15] s390/vfio-ap: use new AP bus interface to search
 for queue devices
To:     Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, kernel test robot <lkp@intel.com>
References: <20200720150344.24488-1-akrowiak@linux.ibm.com>
 <20200720150344.24488-3-akrowiak@linux.ibm.com>
 <a946e992-ff36-ca45-1811-7c6b0aaa161f@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <4b0bd2a8-4c28-7daa-8ea4-397926c9054b@linux.ibm.com>
Date:   Mon, 27 Jul 2020 10:09:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a946e992-ff36-ca45-1811-7c6b0aaa161f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_08:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=3 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270096
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 7/24/20 4:38 AM, Pierre Morel wrote:
>
>
> On 2020-07-20 17:03, Tony Krowiak wrote:
>> This patch refactor's the vfio_ap device driver to use the AP bus's
>> ap_get_qdev() function to retrieve the vfio_ap_queue struct containing
>> information about a queue that is bound to the vfio_ap device driver.
>> The bus's ap_get_qdev() function retrieves the queue device from a
>> hashtable keyed by APQN. This is much more efficient than looping over
>> the list of devices attached to the AP bus by several orders of
>> magnitude.
>
> The patch does much more than modifying this line. ;)
>
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_drv.c     | 27 ++-------
>>   drivers/s390/crypto/vfio_ap_ops.c     | 86 +++++++++++++++------------
>>   drivers/s390/crypto/vfio_ap_private.h |  8 ++-
>>   3 files changed, 59 insertions(+), 62 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c 
>> b/drivers/s390/crypto/vfio_ap_drv.c
>> index f4ceb380dd61..24cdef60039a 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -53,15 +53,9 @@ MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>>    */
>>   static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
>>   {
>> -    struct vfio_ap_queue *q;
>> -
>> -    q = kzalloc(sizeof(*q), GFP_KERNEL);
>> -    if (!q)
>> -        return -ENOMEM;
>> -    dev_set_drvdata(&apdev->device, q);
>> -    q->apqn = to_ap_queue(&apdev->device)->qid;
>> -    q->saved_isc = VFIO_AP_ISC_INVALID;
>> -    return 0;
>> +    struct ap_queue *queue = to_ap_queue(&apdev->device);
>> +
>> +    return vfio_ap_mdev_probe_queue(queue);
>>   }
>
> You should explain the reason why this function is modified.
>
>>     /**
>> @@ -72,18 +66,9 @@ static int vfio_ap_queue_dev_probe(struct 
>> ap_device *apdev)
>>    */
>>   static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
>>   {
>> -    struct vfio_ap_queue *q;
>> -    int apid, apqi;
>> -
>> -    mutex_lock(&matrix_dev->lock);
>> -    q = dev_get_drvdata(&apdev->device);
>> -    dev_set_drvdata(&apdev->device, NULL);
>> -    apid = AP_QID_CARD(q->apqn);
>> -    apqi = AP_QID_QUEUE(q->apqn);
>> -    vfio_ap_mdev_reset_queue(apid, apqi, 1);
>> -    vfio_ap_irq_disable(q);
>> -    kfree(q);
>> -    mutex_unlock(&matrix_dev->lock);
>> +    struct ap_queue *queue = to_ap_queue(&apdev->device);
>> +
>> +    vfio_ap_mdev_remove_queue(queue);
>>   }
>
> ... and this one?
>
>>     static void vfio_ap_matrix_dev_release(struct device *dev)
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index e0bde8518745..ad3925f04f61 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -26,43 +26,26 @@
>>     static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev);
>>   -static int match_apqn(struct device *dev, const void *data)
>> -{
>> -    struct vfio_ap_queue *q = dev_get_drvdata(dev);
>> -
>> -    return (q->apqn == *(int *)(data)) ? 1 : 0;
>> -}
>> -
>>   /**
>> - * vfio_ap_get_queue: Retrieve a queue with a specific APQN from a list
>> - * @matrix_mdev: the associated mediated matrix
>> + * vfio_ap_get_queue: Retrieve a queue with a specific APQN.
>>    * @apqn: The queue APQN
>>    *
>> - * Retrieve a queue with a specific APQN from the list of the
>> - * devices of the vfio_ap_drv.
>> - * Verify that the APID and the APQI are set in the matrix.
>> + * Retrieve a queue with a specific APQN from the AP queue devices 
>> attached to
>> + * the AP bus.
>>    *
>> - * Returns the pointer to the associated vfio_ap_queue
>> + * Returns the pointer to the vfio_ap_queue with the specified APQN, 
>> or NULL.
>>    */
>> -static struct vfio_ap_queue *vfio_ap_get_queue(
>> -                    struct ap_matrix_mdev *matrix_mdev,
>> -                    int apqn)
>> +static struct vfio_ap_queue *vfio_ap_get_queue(unsigned long apqn)
>>   {
>> +    struct ap_queue *queue;
>>       struct vfio_ap_queue *q;
>> -    struct device *dev;
>>   -    if (!test_bit_inv(AP_QID_CARD(apqn), matrix_mdev->matrix.apm))
>> -        return NULL;
>> -    if (!test_bit_inv(AP_QID_QUEUE(apqn), matrix_mdev->matrix.aqm))
>> +    queue = ap_get_qdev(apqn);
>> +    if (!queue)
>>           return NULL;
>>   -    dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
>> -                 &apqn, match_apqn);
>> -    if (!dev)
>> -        return NULL;
>> -    q = dev_get_drvdata(dev);
>> -    q->matrix_mdev = matrix_mdev;
>> -    put_device(dev);
>> +    q = dev_get_drvdata(&queue->ap_dev.device);
>> +    put_device(&queue->ap_dev.device);
>>         return q;
>>   }
>
> this function changed a lot too, you should explain the goal in the 
> patch comment.

This is precisely what the current patch comment describes.

>
> ...snip...
>
> Regards,
> Pierre
>

