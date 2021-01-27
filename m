Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF21C305BD1
	for <lists+linux-s390@lfdr.de>; Wed, 27 Jan 2021 13:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbhA0Mn7 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 27 Jan 2021 07:43:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237064AbhA0MnH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 Jan 2021 07:43:07 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10RCX6ls023505;
        Wed, 27 Jan 2021 07:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=nmacoeARocRclPfMAaLs8pc4myPMb8ANBAnUYgc9Y5M=;
 b=K0M0WUsAOR4Vvpm2M9GDvXxTmvk6PywggAuTKPekJr/+Lr5Xl7iavnO883jdpR7eFNiA
 dNq6lYxaXcGnhBS0mXVvGbLJF9KdfVyGzh56DqDSLg7/REQcxWI2V+FjYUWXeE7g7cAy
 C/HDTEvXoKv3tge/4Im8yBUVy4OGSZQy/5zwnb6EMAj0X2oScEg0AcJ4g8Ig55C2+roT
 BC18aSMKZWsu8ylYOnTelg7QgMJsjSQ3NbqzlfpS5hzILXF/nBq1dCOyj8UYJflEBa+9
 S2RFfBTXlDN8SG3KDv65zdsPPmVUwVdhKXVY5hd7BWPIhfnTODdxgZiM3WesiIIQfOwT dA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36b3kfrm9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 07:41:07 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10RCWuUa024766;
        Wed, 27 Jan 2021 12:41:05 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 368be89yty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 12:41:05 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10RCf2TX41681178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 12:41:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B11E4204C;
        Wed, 27 Jan 2021 12:41:02 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF1694203F;
        Wed, 27 Jan 2021 12:41:01 +0000 (GMT)
Received: from localhost (unknown [9.171.68.8])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 27 Jan 2021 12:41:01 +0000 (GMT)
Date:   Wed, 27 Jan 2021 13:41:00 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Chengyang Fan <cy.fan@huawei.com>
Cc:     hca@linux.ibm.com, linux-s390@vger.kernel.org, joe@perches.com,
        Harald Freudenberger <freude@linux.ibm.com>
Subject: Re: [PATCH] s390/ap: remove unneeded semicolon
Message-ID: <your-ad-here.call-01611751260-ext-3517@work.hours>
References: <20210125095839.1720265-1-cy.fan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210125095839.1720265-1-cy.fan@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_05:2021-01-27,2021-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101270069
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jan 25, 2021 at 05:58:39PM +0800, Chengyang Fan wrote:
> Remove a superfluous semicolon after function definition.
> 
> Signed-off-by: Chengyang Fan <cy.fan@huawei.com>
> ---
>  arch/s390/include/asm/ap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
> index aea32dda3d14..837d1699b109 100644
> --- a/arch/s390/include/asm/ap.h
> +++ b/arch/s390/include/asm/ap.h
> @@ -368,7 +368,7 @@ static inline struct ap_queue_status ap_dqap(ap_qid_t qid,
>  #if IS_ENABLED(CONFIG_ZCRYPT)
>  void ap_bus_cfg_chg(void);
>  #else
> -static inline void ap_bus_cfg_chg(void){};
> +static inline void ap_bus_cfg_chg(void){}
>  #endif
>  
>  #endif /* _ASM_S390_AP_H_ */
> -- 

Applied, thanks.
