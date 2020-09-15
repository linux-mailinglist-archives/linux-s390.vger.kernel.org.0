Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7709026A310
	for <lists+linux-s390@lfdr.de>; Tue, 15 Sep 2020 12:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgIOKZk (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 15 Sep 2020 06:25:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726102AbgIOKZk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 06:25:40 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FA1Spn032202
        for <linux-s390@vger.kernel.org>; Tue, 15 Sep 2020 06:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=KdAtynhoxtIDmgWqcuvK73w0oN25NMhnEGUwqDnMef8=;
 b=L7CCIrkzUPYosd/Sxn9L22W8Qf3sudLHjL2PRquKfg3CZCV5WQbZAuvhU+u/ZwKwYYR5
 fJrxmER7pOp4OFDypxZVNG2u4ZPswY6Z/zkNtEg8oama3oNnrz9vU/u6gw7XpP44BcHn
 x/Jo29A9JJLJG+1nBsUrpYq2UNpfVks3Cz9NCaKJidVWirw5CtwA7fbwLeiJj0g0TtBO
 FUNDG0bghnZCz2LQU7NeTSZz5WvHVZQ/BYh8jrCWnhdFQgHQhluYsiaf5UpLLL/fU+z1
 kPYLYRw17Q5cmW4Z04ROEvsAgNHjNlHclcUkYzy0DCmeHSgvog8Lwbr3WUQIktsnNHkr lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33jrqge892-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 15 Sep 2020 06:25:38 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FA1ZR0033017
        for <linux-s390@vger.kernel.org>; Tue, 15 Sep 2020 06:25:37 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33jrqge88e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 06:25:37 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FAOWZD000408;
        Tue, 15 Sep 2020 10:25:36 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 33hjgds4xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 10:25:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08FAPXgo24379806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 10:25:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65CA052052;
        Tue, 15 Sep 2020 10:25:33 +0000 (GMT)
Received: from oc6887364776.ibm.com (unknown [9.145.30.167])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1087E52057;
        Tue, 15 Sep 2020 10:25:33 +0000 (GMT)
Subject: Re: [RFD] uevent handling for subchannels
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Boris Fiuczynski <fiuczy@linux.ibm.com>
References: <20200403124032.5e70603d.cohuck@redhat.com>
 <20200417143811.7e6ecb2c.cohuck@redhat.com>
 <8649ea94-8617-07b6-170e-65c278d9383b@linux.vnet.ibm.com>
 <c69da1c0-d151-257b-fe43-786e47a3cf9b@linux.vnet.ibm.com>
 <20200423182001.40345df8.cohuck@redhat.com>
 <53d7d08d-c1d2-dad3-7f01-a165b24b0359@linux.ibm.com>
 <20200430124316.023a82b0.cohuck@redhat.com>
 <20200629135631.10db3c32.cohuck@redhat.com>
 <20200701112313.62a22156.cohuck@redhat.com>
 <20200914134642.5e2e2c0e.cohuck@redhat.com>
From:   Vineeth Vijayan <vneethv@linux.vnet.ibm.com>
Message-ID: <923020f2-e722-a6ba-fcb4-08dd8228fc00@linux.vnet.ibm.com>
Date:   Tue, 15 Sep 2020 12:25:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914134642.5e2e2c0e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_05:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150087
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Conny,
Thank you for the ping. This is pending for a long time and we just resumed
looking at this approach. Me and Peter had a short discussion on this and we
are trying to do some cleaning as well on the CIO layer while working 
with the
new approach.

There are few uncertainties with the new approach, which we would like 
to clarify
and i am trying to test it.For example, the impact on the way 
cio-console driver works.
So, as discussed with Peter, let me make a smaller draft which will 
consolidate
your approach and the "cleaning" part that we would like to do.

As mentioned, i will resume working on this and get back to you with 
myfindings.

Thank you,
Vineeth



On 9/14/20 1:46 PM, Cornelia Huck wrote:
> <casts "reanimate" on dead thread>
>
> On Wed, 1 Jul 2020 11:23:13 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> On Mon, 29 Jun 2020 13:56:31 +0200
>> Cornelia Huck <cohuck@redhat.com> wrote:
>>
>>> Ok, so I've resumed the thinking process, and I think getting rid of
>>> the "no I/O subchannel without functional device" approach is a good
>>> idea, and allows us to make handling driver matches more similar to
>>> everyone else.
>> As an aside, there's another odd construct: the I/O subchannel driver
>> *always* binds to the subchannel device, even if there is a problem,
>> and schedules an unregistration of the subchannel device on error. This
>> was introduced because events from machine check handling are not
>> processed if there isn't a driver (at least I thought back then that it
>> was a good idea.) I think a more correct way to handle this would be to
>> do the following:
>>
>> * If something doesn't work, clean up and return an error in the probe
>>    function. The subchannel device stays around, it's just not bound.
>> * Have the css bus do some basic processing for subchannels not bound
>>    to any driver (e.g., check dnv/w). This would also make it possible
>>    to unregister dead message subchannels if a machine check is received
>>    for them (don't know if that's an actual problem in pratice.)
>>
>>> What changes would be needed?
>>> * The whole logic to suppress uevents for subchannels and generate one
>>>    later will go. (Touches the various subchannel driver, including
>>>    vfio-ccw.)
>>> * ccw_device_todo() can just unregister the ccw device, and there's no
>>>    longer a need for ccw_device_call_sch_unregister(). (IIUC, this also
>>>    covers setting disconnected devices offline.)
>> I'm actually not sure if unregistration-by-driver is the right thing
>> for most cases (except for something like disconnected device removal),
>> that should be done by the bus. Maybe something for later (don't fear,
>> I don't plan to work on the common I/O layer again :)
>>
>>> * As the I/O subchannel driver now needs to deal with cases where no
>>>    ccw device is available, the code for that needs to be checked.
>>>    (That's probably the most time-consuming task.)
>> Had a quick look, doesn't actually look too bad (most places already
>> check for !cdev.)
>>
>>> Userspace should be fine with I/O subchannels without ccw device,
>>> that's nothing new.
>>>
>>> Does that sound reasonable?
> Is anybody looking at this? The delayed uevent handling is a bit of a
> mess for management of vfio-ccw devices...
>
