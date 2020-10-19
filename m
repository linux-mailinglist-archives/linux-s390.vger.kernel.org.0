Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4995429256F
	for <lists+linux-s390@lfdr.de>; Mon, 19 Oct 2020 12:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgJSKSs (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 19 Oct 2020 06:18:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728060AbgJSKSV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 19 Oct 2020 06:18:21 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09JA32JC123863;
        Mon, 19 Oct 2020 06:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=A9ifDutG0veSnAxUl+yq/IQE7zgFZajYU6eoHRkfGUE=;
 b=eymeiZ2XYoW6ndKVuOBooi4D+Hqf0QjIqpyv5FhrlIcYAq+ONr538cP2Hcyzic9TnmOU
 6D/gSyiE2cJQ70vOVGIMt0KjIOWAMqDD8NfyP/XkPSH/JN/NBNsboOhdoCPj4l7auOZz
 yegvx0n5IKpEZLYsHF0HSpHqF9PUV9er3syHAfiO9Ikjwq5vLQF8LDbbnbOOuuLRQ1yM
 i5n/AET4+S6t553kP9qAGOCWcYjRWlXSr8Ip0j1rTX6ajUT//e/lDyZ2T4nNLUdnH7Al
 W/JWp5mtYerKxlEh6nVUw72OPp9KpvQCWtP9UsGQ9v9T7fahGFjZixIvh2NnPGco/yEa UA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3497efj8w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 06:18:17 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09JAIFwJ028164;
        Mon, 19 Oct 2020 10:18:15 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 347r889yaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 10:18:15 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09JAIDBF30015924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Oct 2020 10:18:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EA7F4C046;
        Mon, 19 Oct 2020 10:18:13 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A3C44C04E;
        Mon, 19 Oct 2020 10:18:13 +0000 (GMT)
Received: from ibm (unknown [9.145.46.236])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Oct 2020 10:18:12 +0000 (GMT)
Date:   Mon, 19 Oct 2020 12:18:11 +0200
From:   Philipp Rudo <prudo@linux.ibm.com>
To:     Petr Tesarik <ptesarik@suse.cz>
Cc:     linux-s390@vger.kernel.org,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: Is OS_INFO_VMCOREINFO unimplemented?
Message-ID: <20201019121811.2fd4c598@ibm>
In-Reply-To: <20201016172419.3abfdeda@ezekiel.suse.cz>
References: <20201013145303.6f99fe89@ezekiel.suse.cz>
        <20201016161125.2fcf494d@ibm>
        <20201016172419.3abfdeda@ezekiel.suse.cz>
Organization: IBM
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-19_02:2020-10-16,2020-10-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=708 suspectscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190072
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Petr,

On Fri, 16 Oct 2020 17:24:19 +0200
Petr Tesarik <ptesarik@suse.cz> wrote:

> Hi Philipp,
> 
> On Fri, 16 Oct 2020 16:11:25 +0200
> Philipp Rudo <prudo@linux.ibm.com> wrote:
> 
> > Hi Petr,
> > 
> > sorry for the late reply.  
> 
> No problem. ;-)
> 
> > It's an interface for non-Linux systems for the stand-alone kdump.
> > 
> > But that's all I'm sure of. I'm afraid only Michael knows the full history
> > behind the implementation. Unfortunately he left IBM ~2 years ago so this piece
> > of knowledge is lost...
> > 
> > My theory is that originally it was planned to use this mechanism for the
> > "normal" kdump as well. But for kdump common code "corrupts" the vmcoreinfo by
> > adding the CRASHTIME shortly before kexec'ing the crash kernel. So the crash
> > kernel would refuse to load the os_info anyway and thus it is never set.  
> 
> Sure, the checksum would have to be recalculated after setting CRASHTIME. But that's perfectly possible.

True. But it's not working out of the box and there's a working workaround. So
let's live with the workaround and implement the proper solution at a later
date. You know, the usual stuff... 

> > Hope this helps you at least a little  
> 
> Yes, to some extent. The reason I asked was that I also implemented parsing of OS_INFO_VMCOREINFO in libkdumpfile a few years ago, but it has no test coverage. So, I looked around a bit and to my surprise all dump files contained a NULL pointer there, which looked somewhat suspicious.
> 
> Anyway, if nobody knows for certain, then my plan is to add the necessary code to the Linux kernel. Patch coming soon on the mailing list. ;-)

Not to discourage you, but my long term goal was to remove the mechanism.
Anyhow I'm willing to revisit this plan. You definitely got me curious :)

Thanks
Philipp


> Thanks,
> Petr T
> 
> > Philipp
> > 
> > 
> > On Tue, 13 Oct 2020 14:53:03 +0200
> > Petr Tesarik <ptesarik@suse.cz> wrote:
> >   
> > > Hi all,
> > > 
> > > I've been looking into kernel crash dump analysis for some time now,
> > > and I've noticed that none of my sample dumps for z/Architecture sets
> > > OS_INFO_VMCOREINFO.
> > > 
> > > Commit 4857d4bbe9821c8d732cb84455e18e12b3d79add suggests that the
> > > "os_info" structure should contain vmcoreinfo, but it seems that the
> > > corresponding fields are always zero, and a quick grep for
> > > OS_INFO_VMCOREINFO finds only code that tries to read this entry in the
> > > panic kernel, but no code that would initialize it in the old (crashed)
> > > kernel.
> > > 
> > > In short, the panic kernel always prints an informational message that
> > > entry 0 is not available and falls back to get_vmcoreinfo_old().
> > > 
> > > Is this a bug, or is this interface used by a non-Linux operating
> > > system that I'm not aware of?
> > > 
> > > TIA,
> > > Petr Tesarik
> > > SUSE HW Enablement    
> 
