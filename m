Return-Path: <linux-s390+bounces-122-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 784B87F609E
	for <lists+linux-s390@lfdr.de>; Thu, 23 Nov 2023 14:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F59F1F20F02
	for <lists+linux-s390@lfdr.de>; Thu, 23 Nov 2023 13:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EEF25561;
	Thu, 23 Nov 2023 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CWH0WcI5"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DB7199B;
	Thu, 23 Nov 2023 05:43:12 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANCqhr1021827;
	Thu, 23 Nov 2023 13:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=KRR7/FLcHHfVYwLFqhd7C1q8EsSoikY6fbR7WzttxZ0=;
 b=CWH0WcI541sXHITD98nZFLJRSHvY/2sZviXkWIExTTJkEDFE6RyYbe2Fn28iSJkwDHOx
 bp+4nuH6IfU2T+PmhoHoZyCTaLcu5UVqTScD17TmhAai1hod4sMQze9TRP9Y1Ig/3xcl
 vG8MWUOCxQV3vLgRqDAplyQtocFuHZnVHyqS5V4uGb+dQF/As8Yqx9AsUpbWRGy2ueEV
 BhIHh0gi/UOdZ4QDwomCxJkc49TLQ1IH3Nq87gzfk/LVudCq4mTIpYF0tuAQaPI9e/0f
 OPlRLB2ADxfbnpDimwPXJd/LAt/Tqxse+z/lxeKZ+B4clUbYX4ZGivGV6QcY0ep8gEnJ jw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj74k15td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 13:43:05 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ANDh5Id032355;
	Thu, 23 Nov 2023 13:43:05 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj74k15t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 13:43:05 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANBIg1p003481;
	Thu, 23 Nov 2023 13:43:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf7ktfp4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 13:43:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ANDh2jE8913568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Nov 2023 13:43:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C4F120040;
	Thu, 23 Nov 2023 13:43:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCBDE20043;
	Thu, 23 Nov 2023 13:43:01 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.80.84])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Nov 2023 13:43:01 +0000 (GMT)
Date: Thu, 23 Nov 2023 14:43:00 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        akpm@linux-foundation.org, ignat@cloudflare.com,
        eric_devolder@yahoo.com
Subject: Re: [PATCH 3/3] s390/Kconfig: drop select of KEXEC
Message-ID: <ZV9W5AmmYhCFmN9e@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20231123073652.507034-1-bhe@redhat.com>
 <20231123073652.507034-4-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123073652.507034-4-bhe@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p97UOpER7j1y6xI193PSMYOEsM0_ReRh
X-Proofpoint-ORIG-GUID: Q8_fDX5_sC5i010zY_FRtWNuycP5JyR9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 mlxlogscore=357
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230098

On Thu, Nov 23, 2023 at 03:36:52PM +0800, Baoquan He wrote:

Hi Baoquan,

> No proof is found to require that S390 architecture has to select
> KEXEC. At least from my testing at below, dropping select of KEXEC won't
> impact anything.

It does impact the outcome of defconfigs.
Namely, CONFIG_KEXEC is not set with this patch.

> ===testing 1===
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_CRASH_DUMP=y
> ===
> 
> ===testing 2===
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_KEXEC_FILE=y
> CONFIG_CRASH_DUMP=y
> ===

Unfortunately, I do not quite realize what these testings were
and what is the difference between the two.

> So drop the select of KEXEC now.

I suggest dropping this patch. Once the previous two are upstream
we would remove 'select KEXEC' from Kconfig together with defconfig
updates.

> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/s390/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 3bec98d20283..1aec2e692dca 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -217,7 +217,6 @@ config S390
>  	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
>  	select IOMMU_HELPER		if PCI
>  	select IOMMU_SUPPORT		if PCI
> -	select KEXEC
>  	select MMU_GATHER_MERGE_VMAS
>  	select MMU_GATHER_NO_GATHER
>  	select MMU_GATHER_RCU_TABLE_FREE
> -- 

Thanks!

