Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3021C8AD4
	for <lists+linux-s390@lfdr.de>; Thu,  7 May 2020 14:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEGMdm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 7 May 2020 08:33:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725947AbgEGMdm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 May 2020 08:33:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047CWFSK031817;
        Thu, 7 May 2020 08:33:36 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30s1t08nqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 08:33:35 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 047CUFm4029845;
        Thu, 7 May 2020 12:33:34 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 30s0g5ubxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 12:33:34 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 047CWLeE56754496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 May 2020 12:32:21 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EFADA4051;
        Thu,  7 May 2020 12:33:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F36EA404D;
        Thu,  7 May 2020 12:33:31 +0000 (GMT)
Received: from oc5311105230.ibm.com (unknown [9.145.25.186])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 May 2020 12:33:30 +0000 (GMT)
Subject: Re: [PATCH -next] s390/ism: fix error return code in ism_probe()
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
References: <20200507094307.14102-1-weiyongjun1@huawei.com>
From:   Ursula Braun <ubraun@linux.ibm.com>
Message-ID: <f4a7bc6b-75f1-73a9-5351-3af876a50dec@linux.ibm.com>
Date:   Thu, 7 May 2020 14:33:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200507094307.14102-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_06:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 clxscore=1011 suspectscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070099
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 5/7/20 11:43 AM, Wei Yongjun wrote:
> Fix to return negative error code -ENOMEM from the smcd_alloc_dev()
> error handling case instead of 0, as done elsewhere in this function.
> 
> Fixes: 684b89bc39ce ("s390/ism: add device driver for internal shared memory")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks Wei Yongjun - your patch is fine. It will be part of our next patch submission.

Regards, Ursula

> ---
>  drivers/s390/net/ism_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
> index c75112ee7b97..c7fade836d83 100644
> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
> @@ -521,8 +521,10 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	ism->smcd = smcd_alloc_dev(&pdev->dev, dev_name(&pdev->dev), &ism_ops,
>  				   ISM_NR_DMBS);
> -	if (!ism->smcd)
> +	if (!ism->smcd) {
> +		ret = -ENOMEM;
>  		goto err_resource;
> +	}
>  
>  	ism->smcd->priv = ism;
>  	ret = ism_dev_init(ism);
> 
> 
> 
