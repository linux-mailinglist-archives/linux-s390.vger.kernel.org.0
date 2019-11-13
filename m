Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5DE2FB038
	for <lists+linux-s390@lfdr.de>; Wed, 13 Nov 2019 13:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfKMMPX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 13 Nov 2019 07:15:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726973AbfKMMPX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 07:15:23 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADC9Bdm067248
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 07:15:21 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w8hk20bhu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 07:15:21 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 13 Nov 2019 12:15:19 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Nov 2019 12:15:17 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xADCEeRV38994406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 12:14:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42397A405C;
        Wed, 13 Nov 2019 12:15:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 115E9A4062;
        Wed, 13 Nov 2019 12:15:16 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.152.222.55])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Nov 2019 12:15:15 +0000 (GMT)
Subject: Re: [PATCH] s390: vfio-ap: fix some comments
To:     Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org
References: <20191113095319.6154-1-cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 13 Nov 2019 13:15:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191113095319.6154-1-cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19111312-0028-0000-0000-000003B6866E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111312-0029-0000-0000-000024798DF8
Message-Id: <42f63f2b-2fc7-4a68-a86b-886f6a4efc04@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-13_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911130115
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


:) thanks,

Regards,

Pierre

Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>

On 2019-11-13 10:53, Cornelia Huck wrote:
> The functions are called vfio_ap_irq_{en,dis}able.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>
> Just some minor stuff I noted while grepping for something.
>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 5c0f53c6dde7..f8f3f3a4e5fd 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -182,7 +182,7 @@ struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
>   }
>   
>   /**
> - * vfio_ap_setirq: Enable Interruption for a APQN
> + * vfio_ap_irq_enable: Enable Interruption for a APQN
>    *
>    * @dev: the device associated with the ap_queue
>    * @q:	 the vfio_ap_queue holding AQIC parameters
> @@ -265,7 +265,7 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
>    * - AP_RESPONSE_Q_NOT_AVAIL: if the queue is not available
>    * - AP_RESPONSE_DECONFIGURED: if the queue is not configured
>    * - AP_RESPONSE_NORMAL (0) : in case of successs
> - *   Check vfio_ap_setirq() and vfio_ap_clrirq() for other possible RC.
> + *   Check vfio_ap_irq_enable() and vfio_ap_irq_disable() for other possible RC.
>    * We take the matrix_dev lock to ensure serialization on queues and
>    * mediated device access.
>    *

-- 
Pierre Morel
IBM Lab Boeblingen

