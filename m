Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03763195B7B
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2020 17:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgC0QuY (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 27 Mar 2020 12:50:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727242AbgC0QuW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 12:50:22 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02RGXcZx044218
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 12:50:21 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 300jevhk3q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 12:50:21 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Fri, 27 Mar 2020 16:50:18 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Mar 2020 16:50:15 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02RGoEdp48693478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 16:50:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54017A4051;
        Fri, 27 Mar 2020 16:50:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F055A404D;
        Fri, 27 Mar 2020 16:50:11 +0000 (GMT)
Received: from [9.211.88.160] (unknown [9.211.88.160])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Mar 2020 16:50:11 +0000 (GMT)
Subject: Re: [PATCH 1/2] s390/cio: avoid duplicated 'ADD' uevents
To:     Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Boris Fiuczynski <fiuczy@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>
References: <20200327124503.9794-1-cohuck@redhat.com>
 <20200327124503.9794-2-cohuck@redhat.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Date:   Fri, 27 Mar 2020 17:50:10 +0100
MIME-Version: 1.0
In-Reply-To: <20200327124503.9794-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20032716-0028-0000-0000-000003ECF2AE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032716-0029-0000-0000-000024B26BA4
Message-Id: <0301bea5-521f-21bc-f641-d0f256ddb385@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-27_05:2020-03-27,2020-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=1 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270145
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 27.03.2020 13:45, Cornelia Huck wrote:
> The common I/O layer delays the ADD uevent for subchannels and
> delegates generating this uevent to the individual subchannel
> drivers. The io_subchannel driver will do so when the associated
> ccw_device has been registered -- but unconditionally, so more
> ADD uevents will be generated if a subchannel has been unbound
> from the io_subchannel driver and later rebound.
> 
> To fix this, only generate the ADD event if uevents were still
> suppressed for the device.
> 
> Reported-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
> Fixes: fa1a8c23eb7d ("s390: cio: Delay uevents for subchannels")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Please also add Vineeth on cc of future patches against core CIO code.

This patch looks sane and makes handling of suppressed UDEV events
consistent to what is already implemented for CHSC and EADM subchannel
types.

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>

> ---
>  drivers/s390/cio/device.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
> index 0c6245fc7706..983f9c9e08de 100644
> --- a/drivers/s390/cio/device.c
> +++ b/drivers/s390/cio/device.c
> @@ -849,8 +849,10 @@ static void io_subchannel_register(struct ccw_device *cdev)
>  	 * Now we know this subchannel will stay, we can throw
>  	 * our delayed uevent.
>  	 */
> -	dev_set_uevent_suppress(&sch->dev, 0);
> -	kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> +	if (dev_get_uevent_suppress(&sch->dev)) {
> +		dev_set_uevent_suppress(&sch->dev, 0);
> +		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> +	}
>  	/* make it known to the system */
>  	ret = ccw_device_add(cdev);
>  	if (ret) {
> @@ -1058,8 +1060,11 @@ static int io_subchannel_probe(struct subchannel *sch)
>  		 * Throw the delayed uevent for the subchannel, register
>  		 * the ccw_device and exit.
>  		 */
> -		dev_set_uevent_suppress(&sch->dev, 0);
> -		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> +		if (dev_get_uevent_suppress(&sch->dev)) {
> +			/* should always be the case for the console */
> +			dev_set_uevent_suppress(&sch->dev, 0);
> +			kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> +		}
>  		cdev = sch_get_cdev(sch);
>  		rc = ccw_device_add(cdev);
>  		if (rc) {
> 


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

