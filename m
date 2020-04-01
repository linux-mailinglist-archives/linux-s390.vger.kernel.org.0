Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD4A619A63D
	for <lists+linux-s390@lfdr.de>; Wed,  1 Apr 2020 09:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbgDAHas (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 1 Apr 2020 03:30:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49346 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731849AbgDAHar (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Apr 2020 03:30:47 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03175pka170487
        for <linux-s390@vger.kernel.org>; Wed, 1 Apr 2020 03:30:46 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304mcb3ju6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 01 Apr 2020 03:30:46 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <fiuczy@linux.ibm.com>;
        Wed, 1 Apr 2020 08:30:35 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Apr 2020 08:30:34 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0317Ud1S44957776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 07:30:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3797AE045;
        Wed,  1 Apr 2020 07:30:39 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F4D6AE051;
        Wed,  1 Apr 2020 07:30:39 +0000 (GMT)
Received: from [10.0.2.15] (unknown [9.145.61.132])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Apr 2020 07:30:39 +0000 (GMT)
Subject: Re: [PATCH 1/2] s390/cio: avoid duplicated 'ADD' uevents
To:     Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20200327124503.9794-1-cohuck@redhat.com>
 <20200327124503.9794-2-cohuck@redhat.com>
From:   Boris Fiuczynski <fiuczy@linux.ibm.com>
Date:   Wed, 1 Apr 2020 09:30:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327124503.9794-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040107-0012-0000-0000-0000039C23C9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040107-0013-0000-0000-000021D93286
Message-Id: <ce487cdf-fd2a-e466-8234-b2591967eb50@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004010059
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The code changes look good and I was able to test this fix successfully.
Reviewed-by: Boris Fiuczynski <fiuczy@linux.ibm.com>


On 3/27/20 1:45 PM, Cornelia Huck wrote:
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
> ---
>   drivers/s390/cio/device.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
> index 0c6245fc7706..983f9c9e08de 100644
> --- a/drivers/s390/cio/device.c
> +++ b/drivers/s390/cio/device.c
> @@ -849,8 +849,10 @@ static void io_subchannel_register(struct ccw_device *cdev)
>   	 * Now we know this subchannel will stay, we can throw
>   	 * our delayed uevent.
>   	 */
> -	dev_set_uevent_suppress(&sch->dev, 0);
> -	kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> +	if (dev_get_uevent_suppress(&sch->dev)) {
> +		dev_set_uevent_suppress(&sch->dev, 0);
> +		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> +	}
>   	/* make it known to the system */
>   	ret = ccw_device_add(cdev);
>   	if (ret) {
> @@ -1058,8 +1060,11 @@ static int io_subchannel_probe(struct subchannel *sch)
>   		 * Throw the delayed uevent for the subchannel, register
>   		 * the ccw_device and exit.
>   		 */
> -		dev_set_uevent_suppress(&sch->dev, 0);
> -		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> +		if (dev_get_uevent_suppress(&sch->dev)) {
> +			/* should always be the case for the console */
> +			dev_set_uevent_suppress(&sch->dev, 0);
> +			kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> +		}
>   		cdev = sch_get_cdev(sch);
>   		rc = ccw_device_add(cdev);
>   		if (rc) {
> 


-- 
Mit freundlichen Grüßen/Kind regards
    Boris Fiuczynski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

