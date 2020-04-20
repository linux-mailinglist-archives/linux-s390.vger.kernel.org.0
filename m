Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266A51B100F
	for <lists+linux-s390@lfdr.de>; Mon, 20 Apr 2020 17:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgDTP3T (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 20 Apr 2020 11:29:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbgDTP3T (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Apr 2020 11:29:19 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KFBBsj005520
        for <linux-s390@vger.kernel.org>; Mon, 20 Apr 2020 11:29:17 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ghu5xc9q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 20 Apr 2020 11:29:17 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <vneethv@linux.vnet.ibm.com>;
        Mon, 20 Apr 2020 16:28:53 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Apr 2020 16:28:51 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03KFTBVp31588498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 15:29:11 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D147BA4057;
        Mon, 20 Apr 2020 15:29:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 564AAA404D;
        Mon, 20 Apr 2020 15:29:11 +0000 (GMT)
Received: from oc6887364776.ibm.com (unknown [9.145.82.187])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Apr 2020 15:29:11 +0000 (GMT)
Subject: Re: [RFD] uevent handling for subchannels
To:     Cornelia Huck <cohuck@redhat.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Boris Fiuczynski <fiuczy@linux.ibm.com>
References: <20200403124032.5e70603d.cohuck@redhat.com>
 <20200417143811.7e6ecb2c.cohuck@redhat.com>
From:   Vineeth Vijayan <vneethv@linux.vnet.ibm.com>
Date:   Mon, 20 Apr 2020 17:29:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417143811.7e6ecb2c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20042015-0012-0000-0000-000003A803CC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042015-0013-0000-0000-000021E54E11
Message-Id: <8649ea94-8617-07b6-170e-65c278d9383b@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_05:2020-04-20,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200123
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Thank you.

Looks like a reasonable idea. But a bit worried about the consequences of
this change. So i am trying to do some tests on LPARs and play around a
bit before i reply to you. For example, testing it on an LPAR which has 
got a large
number of ccw-devices which are DEV_STATE_NOT_OPER.

Let me get back to you after couple of tests.

On 4/17/20 2:38 PM, Cornelia Huck wrote:
> Friendly ping.
>
> On Fri, 3 Apr 2020 12:40:32 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> Hi,
>>
>> this is kind-of-a-followup to the uevent patches I sent in
>> <20200327124503.9794-1-cohuck@redhat.com> last Friday.
>>
>> Currently, the common I/O layer will suppress uevents for subchannels
>> that are being registered, delegating generating a delayed ADD uevent
>> to the driver that actually binds to it and only generating the uevent
>> itself if no driver gets bound. The initial version of that delaying
>> was introduced in fa1a8c23eb7d ("s390: cio: Delay uevents for
>> subchannels"); from what I remember, we were seeing quite bad storms of
>> uevents on LPARs that had a lot of I/O subchannels with no device
>> accessible through them.
>>
>> So while there's definitely a good reason for wanting to delay uevents,
>> it is also introducing problems. One is udev rules for subchannels that
>> are supposed to do something before a driver binds (e.g. setting
>> driver_override to bind an I/O subchannel to vfio_ccw instead of
>> io_subchannel) are not effective, as the ADD uevent will only be
>> generated when the io_subchannel driver is already done with doing all
>> setup. Another one is that only the ADD uevent is generated after
>> uevent suppression is lifted; any other uevents that might have been
>> generated are lost.
>>
>> So, what to do about this, especially in the light of vfio-ccw handling?
>>
>> One idea I had is to call css_sch_is_valid() from
>> css_register_subchannel(); this would exclude the largest class of
>> non-operational subchannels already (those that don't have a valid
>> device; I'm not quite sure if there's also something needed for EADM
>> subchannels?) If we got rid of the uevent delaying, we would still get
>> ADD/REMOVE events for subchannels where the device turns out to be
>> non-accessible, but I believe (hope) that those are not too many in a
>> sane system at least. As a bonus, we could also add additional values
>> from the pmcw to the uevent; the device number, for example, could be
>> helpful for vfio-ccw matching rules.
>>
>> A drawback is that we change the timing (not the sequence, AFAICS) of
>> the uevents, which might break brittle setups.
>>
>> Thoughts?
>>

