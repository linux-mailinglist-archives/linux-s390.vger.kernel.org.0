Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F242F1B5FFD
	for <lists+linux-s390@lfdr.de>; Thu, 23 Apr 2020 17:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgDWP4P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-s390@lfdr.de>); Thu, 23 Apr 2020 11:56:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729176AbgDWP4P (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 11:56:15 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NFbfTR043763
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 11:56:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30gc30jbr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 11:56:14 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03NFbhcY043866
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 11:56:13 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30gc30jbqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Apr 2020 11:56:13 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03NFka3X029859;
        Thu, 23 Apr 2020 15:56:12 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 30fs6581pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Apr 2020 15:56:11 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03NFt1ZU66191862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 15:55:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2215DAE057;
        Thu, 23 Apr 2020 15:56:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA7DDAE05F;
        Thu, 23 Apr 2020 15:56:08 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.58.187])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Apr 2020 15:56:08 +0000 (GMT)
Date:   Thu, 23 Apr 2020 17:55:59 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
        Boris Fiuczynski <fiuczy@linux.ibm.com>
Subject: Re: [RFD] uevent handling for subchannels
Message-ID: <20200423175559.309cc924.pasic@linux.ibm.com>
In-Reply-To: <20200417143811.7e6ecb2c.cohuck@redhat.com>
References: <20200403124032.5e70603d.cohuck@redhat.com>
        <20200417143811.7e6ecb2c.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_11:2020-04-23,2020-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230121
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 17 Apr 2020 14:38:11 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> Friendly ping.
> 

Sorry for the late answer. I prefer to let Vineeth give us his opinion
first. I did invest some 30 minutes in understanding the problem, but
I'm not sure I understood it properly. According to my current
understanding, the current state of affairs is a mess, and the proposed
change wouldn't make the situation substantially cleaner, but it would
help with the problem at hand.

Conny, do you have more background information on uevent suppression
(is there some sort of a generic contract between kernel and userspace
for uevent suppression)?

From a quick grep it seems to me that most of the uses are about being
nice to userspace in a sense, that we want to make sure that when
event is received by userspace it can do it's thing, and does not have
to wait until the kernel has finished with the stuff that needs to be
done to reach a state of affairs that can be considered normal.

Regards,
Halil



> On Fri, 3 Apr 2020 12:40:32 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > Hi,
> > 
> > this is kind-of-a-followup to the uevent patches I sent in
> > <20200327124503.9794-1-cohuck@redhat.com> last Friday.
> > 
> > Currently, the common I/O layer will suppress uevents for subchannels
> > that are being registered, delegating generating a delayed ADD uevent
> > to the driver that actually binds to it and only generating the uevent
> > itself if no driver gets bound. The initial version of that delaying
> > was introduced in fa1a8c23eb7d ("s390: cio: Delay uevents for
> > subchannels"); from what I remember, we were seeing quite bad storms of
> > uevents on LPARs that had a lot of I/O subchannels with no device
> > accessible through them.
[..]
> > Thoughts?
> > 
> 

