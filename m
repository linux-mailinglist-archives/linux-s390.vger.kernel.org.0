Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A3849E57F
	for <lists+linux-s390@lfdr.de>; Thu, 27 Jan 2022 16:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242741AbiA0PKo (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 27 Jan 2022 10:10:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54316 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237375AbiA0PKo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Jan 2022 10:10:44 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RF0m8g022031;
        Thu, 27 Jan 2022 15:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=s9iAbQPH5wdGGfkZEdZ6Ebgb4dldfIHHHbM5S9sJpwY=;
 b=fULlVQxahgLtMsOGZU90H4XaoADJct5xA/XQ53oAp2/wO+4y4zC0UNtWkB/2lJWA46Ab
 aLYfLskBi7JSH/V3ANzYL5uRXJapRqbJfhA0ed1/ziZFu3MwbnjzoDwjJb/9JheKLEpU
 52YuKcmwS75SB+l/bSKSjbIgJPC1gPxyuaYDJKYc5lQbPstPy5febSLevYCbdkl791++
 THDsXwaPVT1ITi2T+JxqL+xjnUc9txTiGrCrTX2xtO8apRg+jRAjPWEIWG7nVVdmjB8l
 FHpnVDRCswmRYzTxdGXrhqzYKvVP6fEOUQBhkjv/FZgQqoAYQa97edEWP52FOfMHl6HA FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duvh0t6am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 15:10:43 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20RF1340023632;
        Thu, 27 Jan 2022 15:10:42 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duvh0t6aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 15:10:42 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20RF8Yfx015443;
        Thu, 27 Jan 2022 15:10:41 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 3dr9jcncu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 15:10:41 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20RFAcQ17996046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 15:10:38 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3515B28065;
        Thu, 27 Jan 2022 15:10:38 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C28D2805A;
        Thu, 27 Jan 2022 15:10:37 +0000 (GMT)
Received: from [9.65.230.214] (unknown [9.65.230.214])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jan 2022 15:10:36 +0000 (GMT)
Message-ID: <f986c509-adea-ed8c-36a6-24715362661c@linux.ibm.com>
Date:   Thu, 27 Jan 2022 10:10:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20211201141110.94636-1-thuth@redhat.com>
 <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
 <e0558344-54a0-eebb-44e0-af61575a4769@linux.ibm.com>
 <345cc07e-e654-2607-57ff-95e78dbfe12d@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <345cc07e-e654-2607-57ff-95e78dbfe12d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 16rFtcabWZeBcxek1IH2bxj0JaXoxTUk
X-Proofpoint-GUID: NgoBdxy-QnIukt4D5m5hXxdr-l8NikWS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201270092
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 1/27/22 05:33, Thomas Huth wrote:
> On 14/12/2021 22.28, Tony Krowiak wrote:
>>
>>
>> On 12/13/21 10:44, Harald Freudenberger wrote:
>>> On 01.12.21 15:11, Thomas Huth wrote:
>>>> The crypto devices that we can use with the vfio_ap module are sitting
>>>> on the "ap" bus, not on the "vfio_ap" bus that the module defines
>>>> itself. With this change, the vfio_ap module now gets automatically
>>>> loaded if a supported crypto adapter is available in the host.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>   Note: Marked as "RFC" since I'm not 100% sure about it ...
>>>>         please review carefully!
>>>>
>>>>   drivers/s390/crypto/vfio_ap_drv.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c 
>>>> b/drivers/s390/crypto/vfio_ap_drv.c
>>>> index 4d2556bc7fe5..5580e40608a4 100644
>>>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>>>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>>>> @@ -39,7 +39,7 @@ static struct ap_device_id ap_queue_ids[] = {
>>>>       { /* end of sibling */ },
>>>>   };
>>>> -MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>>>> +MODULE_DEVICE_TABLE(ap, ap_queue_ids);
>>>>   /**
>>>>    * vfio_ap_queue_dev_probe:
>>> I had a chance to check this now.
>>> First I have to apologize about the dispute with vfio devices 
>>> appearing on the ap bus.
>>> That's not the case with this patch. As Connie states the 
>>> MODULE_DEVICE_TABLE() does not
>>> change the parent of a device and vfio_ap_drv is a driver for ap 
>>> devices and thus
>>> belongs to the ap bus anyway.
>>> So what's left is that with this change the vfio_ap kernel module is 
>>> automatically loaded
>>> when an ap device type 10-13 is recognized by the ap bus. So the 
>>> intention of the patch
>>> is fulfilled.
>>> Yet another kernel module which may occupy memory but will never get 
>>> used by most customers.
>>> This may not be a problem but I had a glance at the list of kernel 
>>> modules loaded on my
>>> LPAR with and without the patch and the difference is:
>>> ...
>>> kvm                   512000  1 vfio_ap
>>> vfio_ap                28672  0
>>> ...
>>> So the vfio_ap module has a dependency to the biggest kernel module 
>>> ever - kvm.
>>> Do I need to say something more?
>>>
>>> If this dependency is removed then I would not hesitate to accept 
>>> this patch. However
>>> this is up to Tony as he is the maintainer of the vfio ap device 
>>> driver.
>>
>> The vfio_ap device driver has a dependency on kvm, it can not be 
>> removed.
>> If the user base for vfio_ap is minimal, then I see no reason why the 
>> vfio_ap
>> module should be automatically loaded when an AP device type 10-13 is
>> recognized by the AP bus. The module is needed only to pass through AP
>> queue devices to a KVM guest.
>
> To continue the discussion here - it seems like my patch here won't be 
> accepted? Shall I send another one instead to remove the bad 
> MODLE_DEVICE_TABLE from the vfio_ap_drv.c file?
>
>  Thomas

After re-reviewing all of the comments, I am okay with this patch:

Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>

If there are any other objections, speak now or forever hold your peace:)

