Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7354315ED9
	for <lists+linux-s390@lfdr.de>; Tue,  7 May 2019 10:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfEGIKw (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 7 May 2019 04:10:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726620AbfEGIKv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 May 2019 04:10:51 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4782VWM003434
        for <linux-s390@vger.kernel.org>; Tue, 7 May 2019 04:10:50 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sb40edtps-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 07 May 2019 04:10:50 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 7 May 2019 09:10:48 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 May 2019 09:10:44 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x478AgSw59244598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 May 2019 08:10:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A06E0AE045;
        Tue,  7 May 2019 08:10:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05D71AE055;
        Tue,  7 May 2019 08:10:42 +0000 (GMT)
Received: from [9.152.222.136] (unknown [9.152.222.136])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 May 2019 08:10:41 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 1/7] s390: vfio-ap: wait for queue empty on queue reset
To:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com
References: <1556918073-13171-1-git-send-email-akrowiak@linux.ibm.com>
 <1556918073-13171-2-git-send-email-akrowiak@linux.ibm.com>
 <0bdb1655-4c4e-1982-a842-9dfc7c02a576@linux.ibm.com>
 <ecc5d1d5-a1ea-64ed-2af0-b2a6ca00d748@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Tue, 7 May 2019 10:10:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ecc5d1d5-a1ea-64ed-2af0-b2a6ca00d748@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19050708-0020-0000-0000-0000033A1254
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050708-0021-0000-0000-0000218CAC19
Message-Id: <23915628-a517-1749-a0c0-e73e6e20f911@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905070053
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 06/05/2019 21:37, Tony Krowiak wrote:
> On 5/6/19 2:41 AM, Pierre Morel wrote:
>> On 03/05/2019 23:14, Tony Krowiak wrote:
>>> Refactors the AP queue reset function to wait until the queue is empty
>>> after the PQAP(ZAPQ) instruction is executed to zero out the queue as
>>> required by the AP architecture.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> ---
>>>   drivers/s390/crypto/vfio_ap_ops.c | 35 
>>> ++++++++++++++++++++++++++++++++---
>>>   1 file changed, 32 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>>> b/drivers/s390/crypto/vfio_ap_ops.c
>>> index 900b9cf20ca5..b88a2a2ba075 100644
>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>> @@ -271,6 +271,32 @@ static int vfio_ap_mdev_verify_no_sharing(struct 
>>> ap_matrix_mdev *matrix_mdev)
>>>       return 0;
>>>   }
>>> +static void vfio_ap_mdev_wait_for_qempty(unsigned long apid, 
>>> unsigned long apqi)
>>> +{
>>> +    struct ap_queue_status status;
>>> +    ap_qid_t qid = AP_MKQID(apid, apqi);
>>> +    int retry = 5;
>>> +
>>> +    do {
>>> +        status = ap_tapq(qid, NULL);
>>> +        switch (status.response_code) {
>>> +        case AP_RESPONSE_NORMAL:
>>> +            if (status.queue_empty)
>>> +                return;
>>> +            msleep(20);
>>
>> NIT:     Fall through ?
> 
> Yes
> 
>>
>>> +            break;
>>> +        case AP_RESPONSE_RESET_IN_PROGRESS:
>>> +        case AP_RESPONSE_BUSY:
>>> +            msleep(20);
>>> +            break;
>>> +        default:
>>> +            pr_warn("%s: tapq err %02x: %04lx.%02lx may not be 
>>> empty\n",
>>> +                __func__, status.response_code, apid, apqi);
>>
>> I do not thing the warning sentence is appropriate:
>> The only possible errors here are if the AP is not available due to AP 
>> checkstop, deconfigured AP or invalid APQN.
> 
> Right you are! I'll work on a new message.
> 
>>
>>
>>> +            return;
>>> +        }
>>> +    } while (--retry);
>>> +}
>>> +
>>>   /**
>>>    * assign_adapter_store
>>>    *
>>> @@ -790,15 +816,18 @@ static int vfio_ap_mdev_group_notifier(struct 
>>> notifier_block *nb,
>>>       return NOTIFY_OK;
>>>   }
>>> -static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int 
>>> apqi,
>>> -                    unsigned int retry)
>>> +int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi)
>>>   {
>>>       struct ap_queue_status status;
>>> +    int retry = 5;
>>>       do {
>>>           status = ap_zapq(AP_MKQID(apid, apqi));
>>>           switch (status.response_code) {
>>>           case AP_RESPONSE_NORMAL:
>>> +            vfio_ap_mdev_wait_for_qempty(apid, apqi);
>>> +            return 0;
>>> +        case AP_RESPONSE_DECONFIGURED:
>>
>> Since you modify the switch, you can return for all the following cases:
>> AP_RESPONSE_DECONFIGURE
>> ..._CHECKSTOP
>> ..._INVALID_APQN
>>
>>
>> And you should wait for qempty on AP_RESET_IN_PROGRESS along with 
>> AP_RESPONSE_NORMAL
> 
> If a queue reset is in progress, we retry the zapq. Are you saying we
> should wait for qempty then reissue the zapq?


Yes, I fear that if we reissue the zapq while RESET is in progress we 
could fall in a loop depending on the reset hardware time and the 
software retry .

> 
>>
>>>               return 0;
>>>           case AP_RESPONSE_RESET_IN_PROGRESS:
>>>           case AP_RESPONSE_BUSY:
>>
>> While at modifying this function, the AP_RESPONSE_BUSY is not a valid 
>> code for ZAPQ, you can remove this.
> 
> Okay
> 
>>
>>> @@ -824,7 +853,7 @@ static int vfio_ap_mdev_reset_queues(struct 
>>> mdev_device *mdev)
>>>                    matrix_mdev->matrix.apm_max + 1) {
>>>           for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
>>>                        matrix_mdev->matrix.aqm_max + 1) {
>>> -            ret = vfio_ap_mdev_reset_queue(apid, apqi, 1);
>>> +            ret = vfio_ap_mdev_reset_queue(apid, apqi);
>>
>> IMHO, since you are at changing this call, passing the apqn as 
>> parameter would be a good simplification.
> 
> Okay.

Sorry, I should have add: NIT.

> 
>>
>>
>>
>>>               /*
>>>                * Regardless whether a queue turns out to be busy, or
>>>                * is not operational, we need to continue resetting
>>
>> Depends on why the reset failed, but this is out of scope.
> 
> I'm not sure what you mean by out of scope here, but you do make a valid
> point. If the response code for the zapq is AP_RESPONSE_DECONFIGURED,
> there is probably no sense in continuing to reset queues for that
> particular adapter. I'll consider a change here.

Yes, this was the point, but I consider this as a enhancement, trying a 
reset on bad queues AFAIK do no arm.

> 
>>
>>>
>>
>>
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

