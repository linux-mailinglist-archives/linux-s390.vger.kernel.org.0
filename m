Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A805D2C3C71
	for <lists+linux-s390@lfdr.de>; Wed, 25 Nov 2020 10:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgKYJky (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 25 Nov 2020 04:40:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgKYJky (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Nov 2020 04:40:54 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AP9Wwq7181432
        for <linux-s390@vger.kernel.org>; Wed, 25 Nov 2020 04:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LhYLceOWnX/hoJ9o3xHvO1W/4bSdeLT0uRCHvrTNZJ0=;
 b=ry01hPiIEZqdfHoE3NKfAOnryJoGfhqV6u/p8mblp65F6o5Ea4av02+UCJY+5Imt2Auw
 scqiZ3htA9bk8KekCcxDHywBEyHbVYtrjFkP5hIzf+JGcvvC0Uxsk6Itv1rAvN15g59x
 PN+elIEDtMSoBxpKKwWQtJcRhdxxu96vsf9iKo+gdyLnpr45GNtbd/MvCpAcFGTOuPCA
 9jd4MARWespKMJDWqWM11OrQJ3qNDOf4gVfJyhZPuKTplygL3ENcwrbXz1uxMCf0Fj0s
 idDOLynKpdv6cjSKlIXoVtumm1N//wF95F5NoOu8I88GN90v+3AS69z+FgZkDZbGAe6S YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 351ddb4cfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 25 Nov 2020 04:40:53 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AP9Xb9e187699
        for <linux-s390@vger.kernel.org>; Wed, 25 Nov 2020 04:40:52 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 351ddb4cej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 04:40:52 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AP9SWx8026994;
        Wed, 25 Nov 2020 09:40:50 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 34xth8cg0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 09:40:50 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AP9elwK48366074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Nov 2020 09:40:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C8A7AE055;
        Wed, 25 Nov 2020 09:40:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44DB2AE051;
        Wed, 25 Nov 2020 09:40:47 +0000 (GMT)
Received: from oc6887364776.ibm.com (unknown [9.145.33.140])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 Nov 2020 09:40:47 +0000 (GMT)
Subject: Re: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
To:     Cornelia Huck <cohuck@redhat.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>
Cc:     oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        farman@linux.ibm.com, fiuczy@linux.ibm.com
References: <20201124093407.23189-1-vneethv@linux.ibm.com>
 <20201124093407.23189-2-vneethv@linux.ibm.com>
 <20201124140220.77c65539.cohuck@redhat.com>
From:   Vineeth Vijayan <vneethv@linux.vnet.ibm.com>
Message-ID: <4be7e163-1118-d365-7d25-df39ba78181f@linux.vnet.ibm.com>
Date:   Wed, 25 Nov 2020 10:40:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201124140220.77c65539.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_04:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250057
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Thank you for looking in to this.

On 11/24/20 2:02 PM, Cornelia Huck wrote:
> On Tue, 24 Nov 2020 10:34:07 +0100
> Vineeth Vijayan <vneethv@linux.ibm.com> wrote:
>
>> 'commit fa1a8c23eb7d ("s390: cio: Delay uevents for subchannels")'
>> introduced the uevent suppression of subchannels. Even though there
>> are reasons for wanting to delay the uevent, it also introduces
>> problems. i.e On some platforms (qemu), where the udev-rule for the
>> subchannel needs to do driver_override to bind the vfio-ccw driver
>> instead of io_subchannel driver, but the suppressed uevent is
>> generated only when the device is found on the subchannel. By the
>> time it generates the uevent, it makes it difficult for the vfio-ccw
>> udev-rules to work.
>> This patch removes the uevent-suppress logic from the css driver.
>> The ADD uevent will be generated when there is a valid subchannel
>> and not after binding the valid device. The uevent generates while
>> device_add() during css_sch_device_register() function.
>>
>> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
>> ---
>>   drivers/s390/cio/chsc_sch.c     |  5 -----
>>   drivers/s390/cio/css.c          | 19 -------------------
>>   drivers/s390/cio/device.c       | 18 ------------------
>>   drivers/s390/cio/eadm_sch.c     |  5 -----
>>   drivers/s390/cio/vfio_ccw_drv.c |  5 -----
>>   5 files changed, 52 deletions(-)
> While I really like that diffstat, I hope that this is actually safe 
> for userspace programs processing uevents. Previously, we generated 
> the ADD uevent only when all parts were setup and ready to use 
> (including a child ccw_device, for example). Now, the ADD uevent is 
> created earlier, before drivers have done their setup. Do existing 
> udev rules still work as expected? (...)

I am still working on this. I have done minimal tests as of now. Mostly 
with the available LPARs/zVMs. And it looks ok. But, i know there are 
many fragile setups out there and the change in the "timing" (The 
uevents generated earlier) could be a potential issue on that. I will 
keep you updated on my findings.

About this RFC, i just wanted make sure that we are on same page with 
regards to the RFD that you shared.
>> @@ -1055,16 +1047,6 @@ static int io_subchannel_probe(struct subchannel *sch)
>>   				      "attributes for subchannel "
>>   				      "0.%x.%04x (rc=%d)\n",
>>   				      sch->schid.ssid, sch->schid.sch_no, rc);
>> -		/*
>> -		 * The console subchannel already has an associated ccw_device.
>> -		 * Throw the delayed uevent for the subchannel, register
>> -		 * the ccw_device and exit.
> I would keep the comment that we already have a ccw_device here. I.e.
>
> /*
>   * The console subchannel already has an associated ccw_device.
>   * Register it and exit.
>   */
>
>> -		 */
>> -		if (dev_get_uevent_suppress(&sch->dev)) {
>> -			/* should always be the case for the console */
>> -			dev_set_uevent_suppress(&sch->dev, 0);
>> -			kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
>> -		}
>>   		cdev = sch_get_cdev(sch);
>>   		rc = ccw_device_add(cdev);
>>   		if (rc) {
> (...)
>
