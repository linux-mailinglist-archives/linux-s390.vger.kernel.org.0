Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 266C21989C6
	for <lists+linux-s390@lfdr.de>; Tue, 31 Mar 2020 04:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgCaCCU (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 30 Mar 2020 22:02:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727698AbgCaCCT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Mar 2020 22:02:19 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02V1Wrc5018082
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 22:02:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 303v2s8scb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 22:02:17 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02V1omNH021012
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 22:02:17 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 303v2s8sbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 22:02:17 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02V1pUSX028803;
        Tue, 31 Mar 2020 02:02:16 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 301x76n890-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 02:02:16 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02V22C6e20709680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 02:02:12 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3D326E053;
        Tue, 31 Mar 2020 02:02:11 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F4486E04E;
        Tue, 31 Mar 2020 02:02:10 +0000 (GMT)
Received: from [9.65.243.214] (unknown [9.65.243.214])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 31 Mar 2020 02:02:10 +0000 (GMT)
Subject: Re: [PATCH 2/2] s390/cio: generate delayed uevent for vfio-ccw
 subchannels
To:     Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Boris Fiuczynski <fiuczy@linux.ibm.com>
References: <20200327124503.9794-1-cohuck@redhat.com>
 <20200327124503.9794-3-cohuck@redhat.com>
From:   Eric Farman <farman@linux.ibm.com>
Message-ID: <486c1d51-2736-cf2f-8b82-2203b45cd928@linux.ibm.com>
Date:   Mon, 30 Mar 2020 22:02:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200327124503.9794-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-30_07:2020-03-30,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=965
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310011
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 3/27/20 8:45 AM, Cornelia Huck wrote:
> The common I/O layer delays the ADD uevent for subchannels and
> delegates generating this uevent to the individual subchannel
> drivers. The vfio-ccw I/O subchannel driver, however, did not
> do that, and will not generate an ADD uevent for subchannels
> that had not been bound to a different driver (or none at all,
> which also triggers the uevent).
> 
> Generate the ADD uevent at the end of the probe function if
> uevents were still suppressed for the device.
> 
> Fixes: 63f1934d562d ("vfio: ccw: basic implementation for vfio_ccw driver")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

This seems to line up with the other drivers.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

> ---
>  drivers/s390/cio/vfio_ccw_drv.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index e401a3d0aa57..339a6bc0339b 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -167,6 +167,11 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
>  	if (ret)
>  		goto out_disable;
>  
> +	if (dev_get_uevent_suppress(&sch->dev)) {
> +		dev_set_uevent_suppress(&sch->dev, 0);
> +		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> +	}
> +
>  	VFIO_CCW_MSG_EVENT(4, "bound to subchannel %x.%x.%04x\n",
>  			   sch->schid.cssid, sch->schid.ssid,
>  			   sch->schid.sch_no);
> 
