Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93991BA0D4
	for <lists+linux-s390@lfdr.de>; Mon, 27 Apr 2020 12:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgD0KK2 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 27 Apr 2020 06:10:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726604AbgD0KK2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Apr 2020 06:10:28 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RA23dD064766
        for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2020 06:10:28 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mggt01b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2020 06:10:27 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03RA2K27066244
        for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2020 06:10:27 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mggt01a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 06:10:27 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03RA5EOX027830;
        Mon, 27 Apr 2020 10:10:25 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 30mcu8bnhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 10:10:24 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03RAALdo5963836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 10:10:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97B6FA4062;
        Mon, 27 Apr 2020 10:10:21 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35C6EA405B;
        Mon, 27 Apr 2020 10:10:19 +0000 (GMT)
Received: from [9.163.51.206] (unknown [9.163.51.206])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Apr 2020 10:10:18 +0000 (GMT)
Subject: Re: [RFD] uevent handling for subchannels
To:     Cornelia Huck <cohuck@redhat.com>,
        Vineeth Vijayan <vneethv@linux.vnet.ibm.com>
Cc:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Boris Fiuczynski <fiuczy@linux.ibm.com>
References: <20200403124032.5e70603d.cohuck@redhat.com>
 <20200417143811.7e6ecb2c.cohuck@redhat.com>
 <8649ea94-8617-07b6-170e-65c278d9383b@linux.vnet.ibm.com>
 <c69da1c0-d151-257b-fe43-786e47a3cf9b@linux.vnet.ibm.com>
 <20200423182001.40345df8.cohuck@redhat.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <53d7d08d-c1d2-dad3-7f01-a165b24b0359@linux.ibm.com>
Date:   Mon, 27 Apr 2020 12:10:17 +0200
MIME-Version: 1.0
In-Reply-To: <20200423182001.40345df8.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_05:2020-04-24,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=1 mlxscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 mlxlogscore=653 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270086
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 23.04.2020 18:20, Cornelia Huck wrote:
> On Thu, 23 Apr 2020 16:52:24 +0200
> Vineeth Vijayan <vneethv@linux.vnet.ibm.com> wrote:
>> Then we could also change the way ccw_device_call_sch_unregister() 
>> works, where
>> the subchannel-unregister is happening from an upper layer.
> 
> Hm, what's the problem here? This seems to be mostly a case of "we did
> I/O to the device and it appeared not operational; so we go ahead and
> unregister the subchannel"? Childless I/O subchannels are a bit useless.

Hey Conny,

sparked by your proposal, Vineeth and myself looked at the corresponding
CIO code and wondered if things couldn't be done in a generally
better/cleaner way. So here we'd like to get your opinion.

In particular, as it is currently, a child-driver (IO subchannel driver,
vfio-ccw, etc.) unregisters a device owned by a parent-device-driver
(CSS), which feels from a high-level-view like a layering violation:
only the parent driver should register and unregister the parent device.
Also in case no subchannel driver is available (e.g. due to
driver_override=none), there would be no subchannel ADD event at all.

So, tapping into you historical expertise about CIO, is there any reason
for doing it this way beyond being nice to userspace tooling that
subchannels with non-working CCW devices are automatically hidden by
unregistering them?

Removing the child-unregisters-parent logic this would also enable
manual rebind of subchannels for which only a different driver than the
default one can successfully talk to the child device, though I'm
unaware of any current application for that.


Regards,
  Peter

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
