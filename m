Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA712DEDB1
	for <lists+linux-s390@lfdr.de>; Sat, 19 Dec 2020 08:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgLSHUz (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 19 Dec 2020 02:20:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6746 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbgLSHUz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 19 Dec 2020 02:20:55 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BJ7131W128920
        for <linux-s390@vger.kernel.org>; Sat, 19 Dec 2020 02:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=NEREyErVRbGO08BYi/AwxLtbferyPT5jOhW1Lu1eEsk=;
 b=MIcsdkaQwwDyvF+2195baj4DPmKr7JijkmjNpvM0uwoCWn4uL5/T5H40trt9kzPydfaG
 RDhC/4hck0xVOsnzNvxpMjcrqvS1LF0e6jYNJqqmFmgKWpTzoZEPoo5Xa9lt6hmGUnhw
 N28EVdIlDwD5QgsaHHq7TSUe3l2F5ag7L8moO8pPqg8zLiKdLqGTT0MYN5miV8SMjQ0O
 lBSvU6aK44LVrcLaRKDL5w6RaaZ1uC5IWceddxKbiNGFeGMyd2g+WG+JEyrFW18Uupr5
 hOxyjCojXaq6UsfQpgJp9anOLRxX9NMVYXP4W0wgSLB8DQzBR0XYrj/pm6UyFuUx8OAh wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35hb5d1w8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 19 Dec 2020 02:20:14 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BJ72EGS132464
        for <linux-s390@vger.kernel.org>; Sat, 19 Dec 2020 02:20:13 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35hb5d1w8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Dec 2020 02:20:13 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BJ7CfJa001872;
        Sat, 19 Dec 2020 07:20:12 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 35h958g2c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Dec 2020 07:20:11 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BJ7K85926870026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Dec 2020 07:20:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D51B5AE04D;
        Sat, 19 Dec 2020 07:20:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F657AE055;
        Sat, 19 Dec 2020 07:20:08 +0000 (GMT)
Received: from oc2783563651 (unknown [9.171.38.200])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Sat, 19 Dec 2020 07:20:08 +0000 (GMT)
Date:   Sat, 19 Dec 2020 08:20:06 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Boris Fiuczynski <fiuczy@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.vnet.ibm.com>,
        oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        farman@linux.ibm.com
Subject: Re: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
Message-ID: <20201219082006.2529bcec.pasic@linux.ibm.com>
In-Reply-To: <20201216130710.5aa6a933.cohuck@redhat.com>
References: <20201124093407.23189-1-vneethv@linux.ibm.com>
        <20201124093407.23189-2-vneethv@linux.ibm.com>
        <20201124140220.77c65539.cohuck@redhat.com>
        <4be7e163-1118-d365-7d25-df39ba78181f@linux.vnet.ibm.com>
        <0b4e34b7-7a4e-71b0-8a64-ea909e64f416@linux.ibm.com>
        <20201208183054.44f4fc2d.cohuck@redhat.com>
        <20201209135203.0008ab18.pasic@linux.ibm.com>
        <20201215191307.281c6e6f.cohuck@redhat.com>
        <89146a87-371a-f148-057b-d3b7ce0cc21e@linux.ibm.com>
        <20201216130710.5aa6a933.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-19_01:2020-12-18,2020-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012190044
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 16 Dec 2020 13:07:10 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 16 Dec 2020 12:53:41 +0100
> Boris Fiuczynski <fiuczy@linux.ibm.com> wrote:
> 
> > On 12/15/20 7:13 PM, Cornelia Huck wrote:
> > >>     
> > >>> I'm not sure how many rules actually care about events for the
> > >>> subchannel device; the ccw device seems like the more helpful device to
> > >>> watch out for.  
> > >> I tend to agree, but the problem with vfio-ccw is that (currently) we
> > >> don't have a ccw device in the host, because we pass-through the
> > >> subchannel. When we interrogate the subchannel, we do learn if there
> > >> is a device and if, what is its devno. If I were to run a system with
> > >> vfio-ccw passthrough, I would want to passthrough the subchannel that
> > >> talks to the DASD (identified by devno) I need passed through to my
> > >> guest.  
> > > I think that can be solved by simply adding the devno as a variable to
> > > the uevent (valid if it's an I/O subchannel; we don't register the
> > > subchannel in the first place if dnv is not set.)
> > >   
> > Providing the devno in the context of the udev event certainly helps if 
> > the event consumer would base its actions on it.
> > As far as I understand the driver_override mechanics driverctl sets the 
> > override based on a specified device. In that case the devno would not 
> > be looked at and the subchannel would end up with a vfio-ccw driver even 
> > so the ccw device might not be the one we want to use as pass-through 
> > device.
> 
> Hm, maybe we need to make a change in driverctl that allows per-bus
> custom rules?
> 

The issue with that is, that this problem ain't bus specific. I.e. it
could make perfect sense to driver_override a certain ccw tape device to
an alternative tape driver.

The problem is, that the only way driverctl can identify a device is a
(name_of_the_bus), device_name_on_the bus) pair. Currently the udev rule
installed by driverctl simply ooks fora file 
/etc/driverctl.d/$env{SUBSYSTEM}-$kernel
which basically encodes the current selection criteria.

Can yo please elaborate on your idea? How would you extend the driverctl
cli and how would persistence look like for these custom rules? Would
you make driverctl write an udev rule for each such device/custom rule
on 'set-override' command instead of file in /etc/driverctl.d?

Regards,
Halil
