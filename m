Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82ECF26CDE5
	for <lists+linux-s390@lfdr.de>; Wed, 16 Sep 2020 23:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgIPVG5 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 16 Sep 2020 17:06:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbgIPQOr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:47 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GEgVqm062803;
        Wed, 16 Sep 2020 10:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : cc : references :
 from : subject : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1XdWDKJ1NeP8AhSpm4Yb5XtcZ2XxoAh/5UuayE6YtBw=;
 b=FydIjQiIUX/En1jxkL6Cz038y5T3Hys5jnUqhRHs7e5HH38B+2FxBxXLCPFp+d8Iq897
 kkBIt3Z8hknnXRUdCRJ0iHvhbLl400sHmMZi0EjrkDaYIQtRwpCQXOkUQPI9ginU2RD4
 xDb6KaQnEQNTEytoRS8NEhZyCz9UFHrkknmQvfu3njMDLy6nQ78TyQ3ErBKPB4kFRjNf
 1k8fukiw8VTiv16sJAxfg3UZpx9m3JMkHNJrXx1CzSchhRfny4ENXLwmuh9veoUD2FOI
 ZfVGzGqCC4zJDiK9SbR9fswDgRZn8QPgoADV8XC3GuIdNF0zRBP8tiKqwgZPXr70gdrQ pA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33kmpv8a2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 10:52:37 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08GEmZDW002206;
        Wed, 16 Sep 2020 14:52:35 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 33k6esgr82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 14:52:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08GEox8C28443012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 14:50:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DF1F4C040;
        Wed, 16 Sep 2020 14:52:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E49A14C046;
        Wed, 16 Sep 2020 14:52:32 +0000 (GMT)
Received: from linux.fritz.box (unknown [9.145.46.180])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Sep 2020 14:52:32 +0000 (GMT)
To:     Christoph Hellwig <hch@lst.de>, hoeppner@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200903083018.507894-1-hch@lst.de>
From:   Stefan Haberland <sth@linux.ibm.com>
Autocrypt: addr=sth@linux.ibm.com; keydata=
 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
 cH4TNHyhiR0KAbxE8qKx3Jc=
Subject: Re: [PATCH] dasd: remove the unused dasd_enable_device export
Message-ID: <20b28960-9c80-349e-c10f-bf45aae804e2@linux.ibm.com>
Date:   Wed, 16 Sep 2020 16:52:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903083018.507894-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_10:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=991 spamscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1011 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160106
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 03.09.20 um 10:30 schrieb Christoph Hellwig:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by:Stefan Haberland <sth@linux.ibm.com>

> ---
>  drivers/s390/block/dasd.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index eb17fea8075c6f..6ab992b3eed004 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
> @@ -683,7 +683,6 @@ void dasd_enable_device(struct dasd_device *device)=

>  	if (device->discipline->kick_validate)
>  		device->discipline->kick_validate(device);
>  }
> -EXPORT_SYMBOL(dasd_enable_device);
> =20
>  /*
>   * SECTION: device operation (interrupt handler, start i/o, term i/o .=
=2E.)


