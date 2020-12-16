Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDBD2DBFDD
	for <lists+linux-s390@lfdr.de>; Wed, 16 Dec 2020 12:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgLPLy3 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 16 Dec 2020 06:54:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgLPLy2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Dec 2020 06:54:28 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BGBW4mF020116
        for <linux-s390@vger.kernel.org>; Wed, 16 Dec 2020 06:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=F/WPsBUzYkI3BO1JV0/JguB7Mv8Px1ksw7SLcMeKbcw=;
 b=j7LzRPtRQqsx5AH1umPJY87VU4FcTese+Cseqhz3jFam1Il4E5egyW4rlgiC48sgttVK
 q/TU+79jBTf+b0SjflLSE+LPFudvbflIC0/kYXi96Wqs0ZMUfsf9VFrIaBEGnOEZm3Ir
 P+d88PtYQAayXqbEytEZOctCzbd6tPGz5gMWivmHakORGKK1ap3StjtU9stSHnWTnCmD
 nismPnS77ochnEIbrIfiTvI+d/XDkEKTcHvufY/f1oU4q2eq6Oc2RYHo4a06QSzks9M2
 8ZHwMmRSSMwttMrPuOIxVtPA/YSdSNqCwcl9LeetV45sCTwDZmelk3oB4z1BSqCK9sdr ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35fdn5fawx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 16 Dec 2020 06:53:47 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BGBl90J075117
        for <linux-s390@vger.kernel.org>; Wed, 16 Dec 2020 06:53:47 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35fdn5faw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 06:53:47 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BGBr6MH023742;
        Wed, 16 Dec 2020 11:53:45 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 35cng848m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 11:53:45 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BGBrgmX19988938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 11:53:42 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FA4E11C04C;
        Wed, 16 Dec 2020 11:53:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F21C611C050;
        Wed, 16 Dec 2020 11:53:41 +0000 (GMT)
Received: from [10.0.2.15] (unknown [9.145.54.210])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Dec 2020 11:53:41 +0000 (GMT)
Subject: Re: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
To:     Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
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
From:   Boris Fiuczynski <fiuczy@linux.ibm.com>
Message-ID: <89146a87-371a-f148-057b-d3b7ce0cc21e@linux.ibm.com>
Date:   Wed, 16 Dec 2020 12:53:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201215191307.281c6e6f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_04:2020-12-15,2020-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 mlxlogscore=999 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160071
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/15/20 7:13 PM, Cornelia Huck wrote:
>>   
>>> I'm not sure how many rules actually care about events for the
>>> subchannel device; the ccw device seems like the more helpful device to
>>> watch out for.
>> I tend to agree, but the problem with vfio-ccw is that (currently) we
>> don't have a ccw device in the host, because we pass-through the
>> subchannel. When we interrogate the subchannel, we do learn if there
>> is a device and if, what is its devno. If I were to run a system with
>> vfio-ccw passthrough, I would want to passthrough the subchannel that
>> talks to the DASD (identified by devno) I need passed through to my
>> guest.
> I think that can be solved by simply adding the devno as a variable to
> the uevent (valid if it's an I/O subchannel; we don't register the
> subchannel in the first place if dnv is not set.)
> 
Providing the devno in the context of the udev event certainly helps if 
the event consumer would base its actions on it.
As far as I understand the driver_override mechanics driverctl sets the 
override based on a specified device. In that case the devno would not 
be looked at and the subchannel would end up with a vfio-ccw driver even 
so the ccw device might not be the one we want to use as pass-through 
device.

-- 
Mit freundlichen Grüßen/Kind regards
    Boris Fiuczynski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
