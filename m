Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901822FBA44
	for <lists+linux-s390@lfdr.de>; Tue, 19 Jan 2021 15:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbhASOua (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 19 Jan 2021 09:50:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392743AbhASMTP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Jan 2021 07:19:15 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10JC1tT2185307
        for <linux-s390@vger.kernel.org>; Tue, 19 Jan 2021 07:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OQfmAHrwEdlpXvRmCC+5sU2qop4lEzXr0hYxiQXwiNA=;
 b=SD6H1QGKn8bRT8MkdCJZ1mtSEVhh+Fuh28zqIGjnbdpW1QBsCUhc47PTeKta33FO76tP
 AKJ1D4HKAT0N1n2AdKZFgXV/pJ0LP5Hdf/2+nmEJu3Po6HKGnL7wGfYWDjQ3ANfPX+MB
 348pJgkrA86yU4SLGi2cVUDHdcjGIgRZUqerUMbcjp5qqLRiEuIdYi0ov7mhpXy/4Glu
 thXSwMKDQeMKBnTQuiCnqgUfoby7WxppReVHsx56Ir83DIwyg9Q5pGmnwJMwtrbzacTI
 Jwjk+2I3OeoKt1PPDzZd/LrAgJDfyO3DGo4iujoyhm6gi6PMnxbnauXh2KHWC+NALA59 SA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 365xwq8rbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 19 Jan 2021 07:18:32 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10JC2hXf189490
        for <linux-s390@vger.kernel.org>; Tue, 19 Jan 2021 07:18:32 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 365xwq8rak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jan 2021 07:18:31 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10JCHxF1007578;
        Tue, 19 Jan 2021 12:18:29 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 363qdh9jyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jan 2021 12:18:29 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10JCIP9E47120892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 12:18:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2B8811C052;
        Tue, 19 Jan 2021 12:18:25 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D18611C050;
        Tue, 19 Jan 2021 12:18:25 +0000 (GMT)
Received: from oc6887364776.ibm.com (unknown [9.145.147.31])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Jan 2021 12:18:25 +0000 (GMT)
Subject: Re: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
To:     Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc:     Boris Fiuczynski <fiuczy@linux.ibm.com>,
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
 <d4dffa29-60b3-db27-fca7-ee4901c77162@linux.ibm.com>
 <20210119124724.4c5cec19.pasic@linux.ibm.com>
 <20210119125952.0737f6a8.cohuck@redhat.com>
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
Message-ID: <6a9c18d0-465a-2fa7-596b-5b2418e351db@linux.ibm.com>
Date:   Tue, 19 Jan 2021 13:18:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210119125952.0737f6a8.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-19_02:2021-01-18,2021-01-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 clxscore=1011 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101190071
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 1/19/21 12:59 PM, Cornelia Huck wrote:
> On Tue, 19 Jan 2021 12:47:24 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
>
>> On Thu, 14 Jan 2021 14:03:25 +0100
>> Boris Fiuczynski <fiuczy@linux.ibm.com> wrote:
>>
>>> On 12/21/20 5:51 PM, Halil Pasic wrote:
>>>> On Mon, 21 Dec 2020 16:46:34 +0100
>>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>>      
>>>>> On Sat, 19 Dec 2020 07:33:16 +0100
>>>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>>>     
>>>>>> I finally came around to test this. In my experience driverctl works for
>>>>>> subchannels and vfio_ccw without this patch, and continues to work with
>>>>>> it. I found the code in driverctl that does the unbind and the implicit
>>>>>> bind (via drivers_probe after after driver_override was set).
>>>>>>
>>>>>> So now I have to ask, how exactly was the original problem diagnosed?
>>>>>>
>>>>>> In https://marc.info/?l=linux-s390&m=158591045732735&w=2 there is a
>>>>>> paragraph like:
>>>>>>
>>>>>> """
>>>>>> So while there's definitely a good reason for wanting to delay uevents,
>>>>>> it is also introducing problems. One is udev rules for subchannels that
>>>>>> are supposed to do something before a driver binds (e.g. setting
>>>>>> driver_override to bind an I/O subchannel to vfio_ccw instead of
>>>>>> io_subchannel) are not effective, as the ADD uevent will only be
>>>>>> generated when the io_subchannel driver is already done with doing all
>>>>>> setup. Another one is that only the ADD uevent is generated after
>>>>>> uevent suppression is lifted; any other uevents that might have been
>>>>>> generated are lost.
>>>>>> """
>>>>>>
>>>>>> This is not how driverclt works! I.e. it deals with the situation that
>>>>>> the I/O subchannel was already bound to the io_subchannel driver at
>>>>>> the time the udev rule installed by driverctl activates (via the
>>>>>> mechanism I described above).
>>>>> That's... weird. It definitely did not work on the LPAR I initially
>>>>> tried it out on!
>>>>>     
>>>> I think Boris told me some weeks ago that it didn't work for him either.
>>>> I will check with him after the winter sleep.
>>> Yesterday I used driverctl successfully for a subchannel on F33.
>>>
>>> Not sure what went wrong a couple of months ago but I cannot reproduce
>>> driverctl not working now.
>> Thanks Boris!
>>
>> @Conny: IMHO driver_override has to work without this patch. Can you
>> figure out, why did you claim it does not (and provide instructions
>> on how to reproduce the problem)?
> This may have been due to other reasons and only looking like a uevent
> issue at the first glance; however, I do not have that particular setup
> anymore, so I guess we'll never know.
>
>>>    
>>>>      
>>>>> However, I think removing the suppression still looks like a good idea:
>>>>> we still have the "any uevent other than ADD will have been lost"
>>>>> problem.
>>>>>     
>>> I totally agree with this.
>> @Vineeth: I think the best way to move forward is to respin this patch
>> with a commit message, that doesn't argue about driver_override.
> That sounds good to me. 
Thank you @Conny, @Halil and @Boris on the insights.
I see that the driver_override works with/without this patch anyway.
But, as mentioned previously, this is more like a cleanup patch.
I shall respin the patch as a cleanup patch for CIO layer.

Regards
Vineeth



