Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958382D0B7E
	for <lists+linux-s390@lfdr.de>; Mon,  7 Dec 2020 09:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgLGIKf (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 7 Dec 2020 03:10:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725905AbgLGIKf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Dec 2020 03:10:35 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B788tBo165705
        for <linux-s390@vger.kernel.org>; Mon, 7 Dec 2020 03:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uV8JfzHdR/TalMBMmI+bwcEvlPWlREVjFzlERtWn3s0=;
 b=OJn/zJFX4mChkHfByp3/6H5nWMH8PSCXZk+OaTD3yjhH2qnf4FBDumBeIK1C1R6pBXF9
 SziaMPKczLcnUBkVEdLdA7NsgPUZP9bNRtfA2ZX9oD03qFBztHUEbbNOaigDQqT3xwUi
 B8/y7SfEF9QgSwFlidn9P5mJMo47B8SHN5aj9o+AZ2R1XbVGzi+75d7iyS9ND7QeU3IA
 PEHklnog8ut25VvXywOozu+iK7V3PBIrEX0mAaEcei4AH+/aBAxxXf0wBab1ihV1dfKl
 dMDaHql8T/8GmuGtRUKFUztUkkNJfgSZkBoIPojIJz/MfOJpVsvF6Q/NA3FG1lv1dNR4 nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 359futh232-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 07 Dec 2020 03:09:53 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B789crM168162
        for <linux-s390@vger.kernel.org>; Mon, 7 Dec 2020 03:09:53 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 359futh22p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 03:09:53 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B786QmH009691;
        Mon, 7 Dec 2020 08:09:51 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3581fhj90a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 08:09:51 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B789m6E63832388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Dec 2020 08:09:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D96A511C052;
        Mon,  7 Dec 2020 08:09:48 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73D7111C04C;
        Mon,  7 Dec 2020 08:09:48 +0000 (GMT)
Received: from oc6887364776.ibm.com (unknown [9.145.49.106])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Dec 2020 08:09:48 +0000 (GMT)
Subject: Re: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
To:     Vineeth Vijayan <vneethv@linux.vnet.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        farman@linux.ibm.com, fiuczy@linux.ibm.com,
        Halil Pasic <pasic@linux.ibm.com>
References: <20201124093407.23189-1-vneethv@linux.ibm.com>
 <20201124093407.23189-2-vneethv@linux.ibm.com>
 <20201124140220.77c65539.cohuck@redhat.com>
 <4be7e163-1118-d365-7d25-df39ba78181f@linux.vnet.ibm.com>
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
Message-ID: <0b4e34b7-7a4e-71b0-8a64-ea909e64f416@linux.ibm.com>
Date:   Mon, 7 Dec 2020 09:09:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <4be7e163-1118-d365-7d25-df39ba78181f@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-07_05:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070046
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Cornelia,

A bit more on this RFC.
I think this is a required change in the CIO layer, especially because there
are lot of validations before we call the probe, which makes sure that we
are not generating the uevent on an invalid (without a ccw-device connected)
subchannel and we dont expect a uevent-storm with the current code-base.
So, in anyway, Removing the suppression in the uevent is a cleaner way 
for the
css driver.

But, the more i look at this patch and discuss on this, i think this is 
not complete.
i.e as you know, the main reason for this RFC was the the below thread.
https://marc.info/?l=linux-s390&m=158591045732735&w=2
We are still not solving the problem that was mentioned in that RFD.

There are couple of things which we needs to consider here. With this 
patch, the uevents
are generated before doing the initialization or before finding the 
ccw-device
connected. Which means, the udev-rules have to manage with a 
non-initialized setup
compared to the previous version (Version without this patch). As you 
mentioned, the
current user-space programs which works with this uevent, especially in 
case of vfio-ccw
will have a problem.
Second point is, there is no guarantee on the current code that the 
uevent generated
will be used by udev-rules of vfio-ccw instead of io-subchannel driver. 
This means, we
need to do some more modifications on the udev-rules, which can then 
decide which
driver should bind with the subchannel. I think that is the only way to 
avoid the
problems we are facing with the driver_override.
I would like to get your expert-opinion on the modifications that can be 
done on the
vfio-ccw udev-rules to make it sync with the current patch.

Regards
Vineeth


On 11/25/20 10:40 AM, Vineeth Vijayan wrote:
> Thank you for looking in to this.
>
> On 11/24/20 2:02 PM, Cornelia Huck wrote:
>> On Tue, 24 Nov 2020 10:34:07 +0100
>> Vineeth Vijayan <vneethv@linux.ibm.com> wrote:
>>
>>> 'commit fa1a8c23eb7d ("s390: cio: Delay uevents for subchannels")'
>>> introduced the uevent suppression of subchannels. Even though there
>>> are reasons for wanting to delay the uevent, it also introduces
>>> problems. i.e On some platforms (qemu), where the udev-rule for the
>>> subchannel needs to do driver_override to bind the vfio-ccw driver
>>> instead of io_subchannel driver, but the suppressed uevent is
>>> generated only when the device is found on the subchannel. By the
>>> time it generates the uevent, it makes it difficult for the vfio-ccw
>>> udev-rules to work.
>>> This patch removes the uevent-suppress logic from the css driver.
>>> The ADD uevent will be generated when there is a valid subchannel
>>> and not after binding the valid device. The uevent generates while
>>> device_add() during css_sch_device_register() function.
>>>
>>> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
>>> ---
>>>   drivers/s390/cio/chsc_sch.c     |  5 -----
>>>   drivers/s390/cio/css.c          | 19 -------------------
>>>   drivers/s390/cio/device.c       | 18 ------------------
>>>   drivers/s390/cio/eadm_sch.c     |  5 -----
>>>   drivers/s390/cio/vfio_ccw_drv.c |  5 -----
>>>   5 files changed, 52 deletions(-)
>> While I really like that diffstat, I hope that this is actually safe 
>> for userspace programs processing uevents. Previously, we generated 
>> the ADD uevent only when all parts were setup and ready to use 
>> (including a child ccw_device, for example). Now, the ADD uevent is 
>> created earlier, before drivers have done their setup. Do existing 
>> udev rules still work as expected? (...)
>
> I am still working on this. I have done minimal tests as of now. 
> Mostly with the available LPARs/zVMs. And it looks ok. But, i know 
> there are many fragile setups out there and the change in the "timing" 
> (The uevents generated earlier) could be a potential issue on that. I 
> will keep you updated on my findings.
>
> About this RFC, i just wanted make sure that we are on same page with 
> regards to the RFD that you shared.
>>> @@ -1055,16 +1047,6 @@ static int io_subchannel_probe(struct 
>>> subchannel *sch)
>>>                         "attributes for subchannel "
>>>                         "0.%x.%04x (rc=%d)\n",
>>>                         sch->schid.ssid, sch->schid.sch_no, rc);
>>> -        /*
>>> -         * The console subchannel already has an associated 
>>> ccw_device.
>>> -         * Throw the delayed uevent for the subchannel, register
>>> -         * the ccw_device and exit.
>> I would keep the comment that we already have a ccw_device here. I.e.
>>
>> /*
>>   * The console subchannel already has an associated ccw_device.
>>   * Register it and exit.
>>   */
>>
>>> -         */
>>> -        if (dev_get_uevent_suppress(&sch->dev)) {
>>> -            /* should always be the case for the console */
>>> -            dev_set_uevent_suppress(&sch->dev, 0);
>>> -            kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
>>> -        }
>>>           cdev = sch_get_cdev(sch);
>>>           rc = ccw_device_add(cdev);
>>>           if (rc) {
>> (...)
>>
