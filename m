Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56EC71625F5
	for <lists+linux-s390@lfdr.de>; Tue, 18 Feb 2020 13:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgBRMRX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 18 Feb 2020 07:17:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24244 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726043AbgBRMRW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 07:17:22 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IC4rSK027009
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 07:17:21 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6dq72qa3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 07:17:21 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 18 Feb 2020 12:17:19 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Feb 2020 12:17:17 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01ICHGAu56098852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 12:17:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0477DA4060;
        Tue, 18 Feb 2020 12:17:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC25BA405B;
        Tue, 18 Feb 2020 12:17:15 +0000 (GMT)
Received: from osiris (unknown [9.152.212.73])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 18 Feb 2020 12:17:15 +0000 (GMT)
Date:   Tue, 18 Feb 2020 13:17:13 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Cleanup removed IOSCHED_DEADLINE
References: <20200217165525.5187-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217165525.5187-1-krzk@kernel.org>
X-TM-AS-GCONF: 00
x-cbid: 20021812-0020-0000-0000-000003AB4423
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021812-0021-0000-0000-000022033F2C
Message-Id: <20200218121713.GA3956@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_02:2020-02-17,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=1 impostorscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180100
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Feb 17, 2020 at 05:55:25PM +0100, Krzysztof Kozlowski wrote:
> CONFIG_IOSCHED_DEADLINE is gone since commit f382fb0bcef4 ("block:
> remove legacy IO schedulers").
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks! I'll leave it up to Stefan and Jan to decide what to do with this.

> ---
>  drivers/s390/block/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
> index a8682f69effc..1f06b19cb290 100644
> --- a/drivers/s390/block/Kconfig
> +++ b/drivers/s390/block/Kconfig
> @@ -26,7 +26,7 @@ config DASD
>  	def_tristate y
>  	prompt "Support for DASD devices"
>  	depends on CCW && BLOCK
> -	select IOSCHED_DEADLINE
> +	select MQ_IOSCHED_DEADLINE
>  	help
>  	  Enable this option if you want to access DASDs directly utilizing
>  	  S/390s channel subsystem commands. This is necessary for running
> -- 
> 2.17.1
> 

