Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD242F6179
	for <lists+linux-s390@lfdr.de>; Thu, 14 Jan 2021 14:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbhANNEN (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 14 Jan 2021 08:04:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726579AbhANNEN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Jan 2021 08:04:13 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10ED2wQ9074497
        for <linux-s390@vger.kernel.org>; Thu, 14 Jan 2021 08:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NKXYlOmMAXS26mMmaXRY2IBFebq/eB9PCDMhNT9qAT0=;
 b=aW00QlwP6/ZQXKSAcUS1l58g5RYpmynPJnLfi8WEN54GdfxNpsx6Tu5zbgv6qtvswmLW
 tFwPtNrk8HOIg49IEC+h/ThtSDTx64Eqqb2q2GTvRSG9ayVQPEmeipzPWue8FBEOi7se
 QZLzggD0B+A69IN2HplXG3D5NJvRRk0hkc7Qpp2Vzxk00Bogcn0ilfI2wdk5ukSuEZDj
 YTQdXiTOKGMClPH13JA6nI0JdKrvc6hZ5+SUJapUMlRz09TLc7XmDEQli26DiNw/FTKf
 A0gG7LSCWte5tgYT9IfOLCTu1vEknWQQUPjXQO8jRSYY4HJlBNsEZLqnrxL6ksXNd6xA eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 362p9prch8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Jan 2021 08:03:32 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10ED3TNB079056
        for <linux-s390@vger.kernel.org>; Thu, 14 Jan 2021 08:03:31 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 362p9prcfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 08:03:31 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10ECgCTR022225;
        Thu, 14 Jan 2021 13:03:29 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 35ydrde1ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 13:03:29 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10ED3Qan23265540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jan 2021 13:03:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5663FA4051;
        Thu, 14 Jan 2021 13:03:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C857A406D;
        Thu, 14 Jan 2021 13:03:26 +0000 (GMT)
Received: from [10.0.2.15] (unknown [9.145.156.122])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Jan 2021 13:03:25 +0000 (GMT)
Subject: Re: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
To:     Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.vnet.ibm.com>,
        oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        farman@linux.ibm.com
References: <20201124093407.23189-1-vneethv@linux.ibm.com>
 <20201124093407.23189-2-vneethv@linux.ibm.com>
 <20201124140220.77c65539.cohuck@redhat.com>
 <4be7e163-1118-d365-7d25-df39ba78181f@linux.vnet.ibm.com>
 <0b4e34b7-7a4e-71b0-8a64-ea909e64f416@linux.ibm.com>
 <20201208183054.44f4fc2d.cohuck@redhat.com>
 <20201209135203.0008ab18.pasic@linux.ibm.com>
 <20201215191307.281c6e6f.cohuck@redhat.com>
 <20201219073316.1be609d5.pasic@linux.ibm.com>
 <20201221164634.11cd3813.cohuck@redhat.com>
 <20201221175117.2c5f5fcb.pasic@linux.ibm.com>
From:   Boris Fiuczynski <fiuczy@linux.ibm.com>
Message-ID: <d4dffa29-60b3-db27-fca7-ee4901c77162@linux.ibm.com>
Date:   Thu, 14 Jan 2021 14:03:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201221175117.2c5f5fcb.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_04:2021-01-14,2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 mlxscore=0 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101140074
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/21/20 5:51 PM, Halil Pasic wrote:
> On Mon, 21 Dec 2020 16:46:34 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Sat, 19 Dec 2020 07:33:16 +0100
>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>>> I finally came around to test this. In my experience driverctl works for
>>> subchannels and vfio_ccw without this patch, and continues to work with
>>> it. I found the code in driverctl that does the unbind and the implicit
>>> bind (via drivers_probe after after driver_override was set).
>>>
>>> So now I have to ask, how exactly was the original problem diagnosed?
>>>
>>> In https://marc.info/?l=linux-s390&m=158591045732735&w=2 there is a
>>> paragraph like:
>>>
>>> """
>>> So while there's definitely a good reason for wanting to delay uevents,
>>> it is also introducing problems. One is udev rules for subchannels that
>>> are supposed to do something before a driver binds (e.g. setting
>>> driver_override to bind an I/O subchannel to vfio_ccw instead of
>>> io_subchannel) are not effective, as the ADD uevent will only be
>>> generated when the io_subchannel driver is already done with doing all
>>> setup. Another one is that only the ADD uevent is generated after
>>> uevent suppression is lifted; any other uevents that might have been
>>> generated are lost.
>>> """
>>>
>>> This is not how driverclt works! I.e. it deals with the situation that
>>> the I/O subchannel was already bound to the io_subchannel driver at
>>> the time the udev rule installed by driverctl activates (via the
>>> mechanism I described above).
>>
>> That's... weird. It definitely did not work on the LPAR I initially
>> tried it out on!
>>
> 
> I think Boris told me some weeks ago that it didn't work for him either.
> I will check with him after the winter sleep.

Yesterday I used driverctl successfully for a subchannel on F33.

Not sure what went wrong a couple of months ago but I cannot reproduce 
driverctl not working now.

> 
>> However, I think removing the suppression still looks like a good idea:
>> we still have the "any uevent other than ADD will have been lost"
>> problem.
>>
I totally agree with this.

> 
> I agree. I didn't look into the details, in general I think removing
> quirks specific to 390 (when possible) is a good thing.
> 
> Regards,
> Halil
> 


-- 
Mit freundlichen Grüßen/Kind regards
    Boris Fiuczynski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
