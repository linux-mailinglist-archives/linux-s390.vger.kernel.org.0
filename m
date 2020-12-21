Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD902DFE34
	for <lists+linux-s390@lfdr.de>; Mon, 21 Dec 2020 17:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgLUQwI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 21 Dec 2020 11:52:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725780AbgLUQwI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Dec 2020 11:52:08 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BLGXNl2171473
        for <linux-s390@vger.kernel.org>; Mon, 21 Dec 2020 11:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=0FjEqHVtQ5nc23hLwBe9pEnXnxpvdJB5mKpAfkL4jx4=;
 b=EBCi7txkCNJPtg0AH9jLSEZ8c3Vl2CYXm9RPa6/pNDGMmA+wG6yaEQ1y0U0jtP2FmF0g
 EYwbQFC+CX+fyWynEUbGTGuO1A3eXHW9rv5VlskukMkazKuPbzx11JivrbGFI+2bQYDb
 YPIe5e4btxyKvQ5zGTJAmc+3EcrEv8NMNJ9DLStnm3PlMm1J1qQP7rqlsGvUupGRkkM+
 Awst8ujUqbT2wXD73VZPnX2RJlqDKzGCxDjqYiMybUwHguWz2Nie/jIvzjgFWcgaC5F6
 zfkb/ZAokmLGr4JbKgdA7iF89BPZ6Elu4BYXHiGvMjTYI1UojDj67ltHDDfNwFbFfHWj lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35jy2v0vfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 21 Dec 2020 11:51:27 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BLGXl1M172836
        for <linux-s390@vger.kernel.org>; Mon, 21 Dec 2020 11:51:26 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35jy2v0vep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 11:51:26 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BLGl3El030369;
        Mon, 21 Dec 2020 16:51:24 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 35h95895ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 16:51:24 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BLGpL3628180944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Dec 2020 16:51:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3684A5204E;
        Mon, 21 Dec 2020 16:51:21 +0000 (GMT)
Received: from oc2783563651 (unknown [9.171.5.180])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id B351A52059;
        Mon, 21 Dec 2020 16:51:20 +0000 (GMT)
Date:   Mon, 21 Dec 2020 17:51:17 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.vnet.ibm.com>,
        oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        farman@linux.ibm.com, fiuczy@linux.ibm.com
Subject: Re: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
Message-ID: <20201221175117.2c5f5fcb.pasic@linux.ibm.com>
In-Reply-To: <20201221164634.11cd3813.cohuck@redhat.com>
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
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-21_09:2020-12-21,2020-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012210114
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 21 Dec 2020 16:46:34 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Sat, 19 Dec 2020 07:33:16 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > I finally came around to test this. In my experience driverctl works for
> > subchannels and vfio_ccw without this patch, and continues to work with
> > it. I found the code in driverctl that does the unbind and the implicit
> > bind (via drivers_probe after after driver_override was set).
> > 
> > So now I have to ask, how exactly was the original problem diagnosed?
> > 
> > In https://marc.info/?l=linux-s390&m=158591045732735&w=2 there is a
> > paragraph like:
> > 
> > """
> > So while there's definitely a good reason for wanting to delay uevents,
> > it is also introducing problems. One is udev rules for subchannels that
> > are supposed to do something before a driver binds (e.g. setting
> > driver_override to bind an I/O subchannel to vfio_ccw instead of
> > io_subchannel) are not effective, as the ADD uevent will only be
> > generated when the io_subchannel driver is already done with doing all
> > setup. Another one is that only the ADD uevent is generated after
> > uevent suppression is lifted; any other uevents that might have been
> > generated are lost.
> > """
> > 
> > This is not how driverclt works! I.e. it deals with the situation that
> > the I/O subchannel was already bound to the io_subchannel driver at
> > the time the udev rule installed by driverctl activates (via the
> > mechanism I described above).
> 
> That's... weird. It definitely did not work on the LPAR I initially
> tried it out on!
> 

I think Boris told me some weeks ago that it didn't work for him either.
I will check with him after the winter sleep.

> However, I think removing the suppression still looks like a good idea:
> we still have the "any uevent other than ADD will have been lost"
> problem.
> 

I agree. I didn't look into the details, in general I think removing
quirks specific to 390 (when possible) is a good thing.

Regards,
Halil

