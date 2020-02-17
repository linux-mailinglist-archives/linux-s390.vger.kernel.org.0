Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFB9D161883
	for <lists+linux-s390@lfdr.de>; Mon, 17 Feb 2020 18:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgBQRIO (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 17 Feb 2020 12:08:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726977AbgBQRIN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 12:08:13 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HH4uBH026018
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 12:08:12 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6adr29st-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 12:08:12 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 17 Feb 2020 17:08:10 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Feb 2020 17:08:07 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01HH85D838207536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 17:08:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEA2C4C040;
        Mon, 17 Feb 2020 17:08:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B23A4C059;
        Mon, 17 Feb 2020 17:08:05 +0000 (GMT)
Received: from localhost (unknown [9.152.212.204])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 17 Feb 2020 17:08:05 +0000 (GMT)
Date:   Mon, 17 Feb 2020 18:08:04 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     qiwuchen55@gmail.com
Cc:     sebott@linux.ibm.com, oberpar@linux.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH v2] s390/cio: use kobj_to_dev() API
References: <1581688293-17283-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1581688293-17283-1-git-send-email-qiwuchen55@gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 20021717-0008-0000-0000-00000353D6EF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021717-0009-0000-0000-00004A74DDB2
Message-Id: <your-ad-here.call-01581959284-ext-3641@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-17_11:2020-02-17,2020-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=3 priorityscore=1501 adultscore=0 mlxlogscore=854
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002170139
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Feb 14, 2020 at 09:51:33PM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Use kobj_to_dev() API instead of container_of().
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> Signed-off-by: chenqiwu <qiwuchen55@gmail.com>
> ---
> changes in v2:
>  - add signed off for my gmail adderss.
> --- 
>  drivers/s390/cio/chp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
> index 51038ec..dfcbe54 100644
> --- a/drivers/s390/cio/chp.c
> +++ b/drivers/s390/cio/chp.c
> @@ -135,7 +135,7 @@ static ssize_t chp_measurement_chars_read(struct file *filp,
>  	struct channel_path *chp;
>  	struct device *device;
>  
> -	device = container_of(kobj, struct device, kobj);
> +	device = kobj_to_dev(kobj);
>  	chp = to_channelpath(device);
>  	if (chp->cmg == -1)
>  		return 0;
> @@ -184,7 +184,7 @@ static ssize_t chp_measurement_read(struct file *filp, struct kobject *kobj,
>  	struct device *device;
>  	unsigned int size;
>  
> -	device = container_of(kobj, struct device, kobj);
> +	device = kobj_to_dev(kobj);
>  	chp = to_channelpath(device);
>  	css = to_css(chp->dev.parent);
>  
> -- 
> 1.9.1
> 
Applied, thanks

