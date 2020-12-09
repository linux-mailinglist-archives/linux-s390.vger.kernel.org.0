Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D732D4276
	for <lists+linux-s390@lfdr.de>; Wed,  9 Dec 2020 13:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbgLIMwy (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 9 Dec 2020 07:52:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731892AbgLIMww (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Dec 2020 07:52:52 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B9C5IuG123188
        for <linux-s390@vger.kernel.org>; Wed, 9 Dec 2020 07:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=xYZWKc4TWwxzieOAaZwRPaYxvpaFYHS7i2WV9WtxPds=;
 b=ePSr6D+LSUohVZacKy/3ZNAa8gBfCSDVuCttQk0RVe0t1vRWJsHvQIA0bcCLVylDmI+x
 N0FztkAO+2Jx+91GgQT6K+R9qCNQJ9919fHP14HjVKSBlNYrDSUiyBu1IdTS7ySvsaD8
 g6VH07UnojWSQW1jQUbF4JlwYzCbFD3mOPa+HGlllexmJeVDfO+E6UCjvXihX73GnF8c
 Z3BSMG/UvnrySQ+rSkkxsNZpwgtJYbu/V2mg2QjqcakqxeRrusw6ElTY1T7cpVaG4gwN
 9p/lydbwIh+EXUlF5CvYK1HWk+zszgf4WgFnVQBppvM9r/6v9oBYaZQ9CtCP2WXspdwf Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35ax9chast-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 09 Dec 2020 07:52:11 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B9ChdOD079706
        for <linux-s390@vger.kernel.org>; Wed, 9 Dec 2020 07:52:11 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35ax9chary-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 07:52:11 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B9Cq6U9014806;
        Wed, 9 Dec 2020 12:52:09 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3583svmgnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 12:52:08 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B9Cq68d30081356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Dec 2020 12:52:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E75AD5204F;
        Wed,  9 Dec 2020 12:52:05 +0000 (GMT)
Received: from oc2783563651 (unknown [9.171.89.146])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 82CAD5204E;
        Wed,  9 Dec 2020 12:52:05 +0000 (GMT)
Date:   Wed, 9 Dec 2020 13:52:03 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.vnet.ibm.com>,
        oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        farman@linux.ibm.com, fiuczy@linux.ibm.com
Subject: Re: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
Message-ID: <20201209135203.0008ab18.pasic@linux.ibm.com>
In-Reply-To: <20201208183054.44f4fc2d.cohuck@redhat.com>
References: <20201124093407.23189-1-vneethv@linux.ibm.com>
        <20201124093407.23189-2-vneethv@linux.ibm.com>
        <20201124140220.77c65539.cohuck@redhat.com>
        <4be7e163-1118-d365-7d25-df39ba78181f@linux.vnet.ibm.com>
        <0b4e34b7-7a4e-71b0-8a64-ea909e64f416@linux.ibm.com>
        <20201208183054.44f4fc2d.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_09:2020-12-09,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012090085
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 8 Dec 2020 18:30:54 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> > 
> > But, the more i look at this patch and discuss on this, i think this is 
> > not complete.
> > i.e as you know, the main reason for this RFC was the the below thread.
> > https://marc.info/?l=linux-s390&m=158591045732735&w=2
> > We are still not solving the problem that was mentioned in that RFD.
> > 
> > There are couple of things which we needs to consider here. With this 
> > patch, the uevents
> > are generated before doing the initialization or before finding the 
> > ccw-device
> > connected. Which means, the udev-rules have to manage with a 
> > non-initialized setup
> > compared to the previous version (Version without this patch). As you 
> > mentioned, the
> > current user-space programs which works with this uevent, especially in 
> > case of vfio-ccw
> > will have a problem.  
> 
> IIUC, we'll get the "normal" ADD uevent when the subchannel device is
> registered (i.e. made visible). For the vfio-ccw case, we want the
> driverctl rule to match in this case, so that the driver override can
> be set before the subchannel device ends up being bound to the I/O
> subchannel driver. So I think that removing the suppression is giving
> us exactly what we want? Modulo any errors in the initialization
> sequence we might currently have in the css bus code, of course.
>

I believe, I'm the originator of these concerns, yet I find my
concern hard to recognize in the comment of Vineeth, so let me
please try to explain this in a different way.

AFAIK the uevent handling is asynchronous with regards to matching and
probing, in a sense that there is no synchronization mechanism that
ensures, the userspace has had the ADD event handled (e.g.
driver_override set_ before the kernel proceeds with matching and
probing of the device. Am I wrong about this?

If I'm, with the suppression gone we end up with race, where userspace
may or may not set driver_override in time.

The man page of driverctl
(https://manpages.debian.org/testing/driverctl/driverctl.8.en.html)
claims that: "driverctl integrates with udev to support overriding driver
selection for both cold- and hotplugged devices from the moment of discovery, ..."
and "The driver overrides created by driverctl are persistent across
system reboots by default."

Writing to the driver_override sysfs attribute does not auto-rebind. So
if we can't ensure being in time to set driver_override for the
subchannel before the io_subchannel driver binds, then the userspace
should handle this situation (by unbind and bind) to ensure the
effectiveness of 'driver override'. I couldn't find that code in
driverctl, and I assume if we had that, driver override would work
without this patch. Conny, does that sound about right?

My argument is purely speculative. I didn't try this out, but trying
stuff out is of limited value with races anyway. Vineeth did you try?
If not, I could check this out myself some time later.
 
> I'm not sure how many rules actually care about events for the
> subchannel device; the ccw device seems like the more helpful device to
> watch out for.

I tend to agree, but the problem with vfio-ccw is that (currently) we
don't have a ccw device in the host, because we pass-through the
subchannel. When we interrogate the subchannel, we do learn if there
is a device and if, what is its devno. If I were to run a system with
vfio-ccw passthrough, I would want to passthrough the subchannel that
talks to the DASD (identified by devno) I need passed through to my
guest.

Regards,
Halil
