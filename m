Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DD11C71D4
	for <lists+linux-s390@lfdr.de>; Wed,  6 May 2020 15:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgEFNkb (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 6 May 2020 09:40:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728058AbgEFNkb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 09:40:31 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 046DWD1k009533;
        Wed, 6 May 2020 09:40:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30u8t06eq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 09:40:30 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 046DWSfd011042;
        Wed, 6 May 2020 09:40:30 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30u8t06epp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 09:40:29 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 046DeEcd021566;
        Wed, 6 May 2020 13:40:28 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01dal.us.ibm.com with ESMTP id 30s0g6sxex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 13:40:28 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 046DeQxG19071444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 May 2020 13:40:26 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BF41BE053;
        Wed,  6 May 2020 13:40:27 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41E6CBE04F;
        Wed,  6 May 2020 13:40:26 +0000 (GMT)
Received: from [9.160.6.78] (unknown [9.160.6.78])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  6 May 2020 13:40:26 +0000 (GMT)
Subject: Re: [PATCH v3 1/1] vfio-ccw: Enable transparent CCW IPL from DASD
To:     Jared Rossi <jrossi@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200506001544.16213-1-jrossi@linux.ibm.com>
 <20200506001544.16213-2-jrossi@linux.ibm.com>
From:   Eric Farman <farman@linux.ibm.com>
Message-ID: <6ef4e1f1-ebbd-2b62-7d0e-947a3e07cbd5@linux.ibm.com>
Date:   Wed, 6 May 2020 09:40:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200506001544.16213-2-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-06_06:2020-05-05,2020-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060103
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 5/5/20 8:15 PM, Jared Rossi wrote:
> Remove the explicit prefetch check when using vfio-ccw devices.
> This check does not trigger in practice as all Linux channel programs
> are intended to use prefetch.
> 
> It is expected that all ORBs issued by Linux will request prefetch.
> Although non-prefetching ORBs are not rejected, they will prefetch
> nonetheless. A warning is issued up to once per 5 seconds when a
> forced prefetch occurs.
> 
> A non-prefetch ORB does not necessarily result in an error, however
> frequent encounters with non-prefetch ORBs indicate that channel
> programs are being executed in a way that is inconsistent with what
> the guest is requesting. While there is currently no known case of an
> error caused by forced prefetch, it is possible in theory that forced
> prefetch could result in an error if applied to a channel program that
> is dependent on non-prefetch.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  Documentation/s390/vfio-ccw.rst |  6 ++++++
>  drivers/s390/cio/vfio_ccw_cp.c  | 19 ++++++++++++-------
>  2 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-ccw.rst
> index fca9c4f5bd9c..23e7d136f8b4 100644
> --- a/Documentation/s390/vfio-ccw.rst
> +++ b/Documentation/s390/vfio-ccw.rst
> @@ -335,6 +335,12 @@ device.
>  The current code allows the guest to start channel programs via
>  START SUBCHANNEL, and to issue HALT SUBCHANNEL and CLEAR SUBCHANNEL.
>  
> +Currently all channel programs are prefetched, regardless of the
> +p-bit setting in the ORB.  As a result, self modifying channel
> +programs are not supported.  For this reason, IPL has to be handled as
> +a special case by a userspace/guest program; this has been implemented
> +in QEMU's s390-ccw bios as of QEMU 4.1.
> +
>  vfio-ccw supports classic (command mode) channel I/O only. Transport
>  mode (HPF) is not supported.
>  
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 3645d1720c4b..d423ca934779 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -8,6 +8,7 @@
>   *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
>   */
>  
> +#include <linux/ratelimit.h>
>  #include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/iommu.h>
> @@ -625,23 +626,27 @@ static int ccwchain_fetch_one(struct ccwchain *chain,
>   * the target channel program from @orb->cmd.iova to the new ccwchain(s).
>   *
>   * Limitations:
> - * 1. Supports only prefetch enabled mode.
> - * 2. Supports idal(c64) ccw chaining.
> - * 3. Supports 4k idaw.
> + * 1. Supports idal(c64) ccw chaining.
> + * 2. Supports 4k idaw.
>   *
>   * Returns:
>   *   %0 on success and a negative error value on failure.
>   */
>  int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
>  {
> +	static DEFINE_RATELIMIT_STATE(ratelimit_state, 5 * HZ, 1);

This looks peculiar, being static and on the stack.  But I guess it is
fine.  And as Conny mentions, a comment about the boot messages would be
good.

>  	int ret;
>  
>  	/*
> -	 * XXX:
> -	 * Only support prefetch enable mode now.
> +	 * We only support prefetching the channel program. We assume all channel
> +	 * programs executed by supported guests (i.e. Linux) likewise support

s/(i.e. Linux) //

> +	 * prefetching. 

Even if prefetching is not specified the channel program
> +	 * is still executed using prefetch. 

The above sentence seems redundant, and can be removed.

Executing a channel program that
> +	 * does not specify prefetching will typically not cause an error, but a
> +	 * warning is issued to help identify the problem if something does break.
>  	 */
> -	if (!orb->cmd.pfch)
> -		return -EOPNOTSUPP;
> +	if (!orb->cmd.pfch && __ratelimit(&ratelimit_state))
> +		dev_warn(mdev, "executing channel program with prefetch, but prefetch isn't specified");

Works well enough (with QEMU patch, obviously).

Almost-r-b: me :)

>  
>  	INIT_LIST_HEAD(&cp->ccwchain_list);
>  	memcpy(&cp->orb, orb, sizeof(*orb));
> 
