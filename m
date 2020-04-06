Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B185719F545
	for <lists+linux-s390@lfdr.de>; Mon,  6 Apr 2020 13:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgDFL6R (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 6 Apr 2020 07:58:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727489AbgDFL6Q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Apr 2020 07:58:16 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036BXDOs186468
        for <linux-s390@vger.kernel.org>; Mon, 6 Apr 2020 07:58:15 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3082j7jp4r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 06 Apr 2020 07:58:15 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 6 Apr 2020 12:57:48 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Apr 2020 12:57:46 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 036Bw9iK34078756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Apr 2020 11:58:09 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA30A4C04E;
        Mon,  6 Apr 2020 11:58:09 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 200244C040;
        Mon,  6 Apr 2020 11:58:09 +0000 (GMT)
Received: from localhost (unknown [9.145.20.204])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Apr 2020 11:58:09 +0000 (GMT)
Date:   Mon, 6 Apr 2020 13:58:07 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Boris Fiuczynski <fiuczy@linux.ibm.com>
Subject: Re: [PATCH 0/2] s390/cio: correct some uevent issues
References: <20200327124503.9794-1-cohuck@redhat.com>
 <20200406135441.743db659.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200406135441.743db659.cohuck@redhat.com>
X-TM-AS-GCONF: 00
x-cbid: 20040611-0020-0000-0000-000003C29DDF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040611-0021-0000-0000-0000221B56A4
Message-Id: <your-ad-here.call-01586174287-ext-5095@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_07:2020-04-06,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 suspectscore=1 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxlogscore=876 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060102
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Apr 06, 2020 at 01:54:41PM +0200, Cornelia Huck wrote:
> On Fri, 27 Mar 2020 13:45:01 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > For subchannels, we currently delay the initial ADD uevent to a
> > point in time controlled by the driver bound to it (this is to
> > avoid a storm of useless uevents for I/O subchannels that do not
> > have an operational device behind it and will get deregistered
> > again, which are potentially a lot on LPARs.)
> > 
> > If we unbind from the io_subchannel driver and rebind again later,
> > we'll get a duplicate ADD uevent -- not a common workflow, but might
> > happen e.g. when you use a device in the host, then pass it to a
> > guest via vfio-ccw, and then want to use it in the host again. Fixed
> > by the first patch.
> > 
> > The vfio_ccw subchannel driver did not generate any ADD uevent at
> > all -- currently not a problem, as every I/O subchannel will have been
> > bound to the io_subchannel driver before, but let's fix this anyway
> > (second patch).
> > 
> > [As an aside, setting driver_override via a udev rule does not work
> > as expected, due to the uevent delaying -- a specified driver_override
> > works as designed, but userspace won't get the ADD uevent until after
> > the io_subchannel driver has been bound to the device already... we
> > may want to rethink this whole uevent mechanism for subchannels later,
> > but I don't think it's too pressing an issue.]
> > 
> > Probably easiest for both patches to go via the s390 arch maintainers.
> 
> Friendly ping. Anyone taking these?

I've just applied them, thank you!

