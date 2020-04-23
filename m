Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBAC1B5BFB
	for <lists+linux-s390@lfdr.de>; Thu, 23 Apr 2020 14:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgDWM4y (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 23 Apr 2020 08:56:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728286AbgDWM4x (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 08:56:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NCsEEv066965
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 08:56:52 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30kb4brjya-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 08:56:46 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Thu, 23 Apr 2020 13:53:34 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Apr 2020 13:53:31 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03NCsOx162914906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 12:54:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7B90A404D;
        Thu, 23 Apr 2020 12:54:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B0C0A4053;
        Thu, 23 Apr 2020 12:54:24 +0000 (GMT)
Received: from localhost (unknown [9.145.82.112])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 23 Apr 2020 12:54:23 +0000 (GMT)
Date:   Thu, 23 Apr 2020 14:54:22 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, cohuck@redhat.com, david@redhat.com,
        kbuild test robot <lkp@intel.com>,
        Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] s390/protvirt: fix compilation issue
References: <20200423120114.2027410-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423120114.2027410-1-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20042312-0020-0000-0000-000003CD2B98
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042312-0021-0000-0000-000022262C5B
Message-Id: <your-ad-here.call-01587646462-ext-4177@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_10:2020-04-22,2020-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0
 suspectscore=1 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230099
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Apr 23, 2020 at 02:01:14PM +0200, Claudio Imbrenda wrote:
> The kernel fails to compile with CONFIG_PROTECTED_VIRTUALIZATION_GUEST
> set but CONFIG_KVM unset.
> 
> This patch fixes the issue by making the needed variable always available.

This statement confuses me a bit.

It's worth to mention that both arch/s390/boot/uv.c (for the
decompressor) and arch/s390/kernel/uv.c (for the main kernel) are only
built when either CONFIG_PROTECTED_VIRTUALIZATION_GUEST or
CONFIG_KVM is enabled.
Both arch/s390/boot/Makefile and arch/s390/kernel/Makefile contain:
obj-$(findstring y, $(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) $(CONFIG_PGSTE))   += uv.o

So this makes the variable available when
CONFIG_PROTECTED_VIRTUALIZATION_GUEST or CONFIG_KVM (expressed via
CONFIG_PGSTE) is enabled. Hence no need for extra conditions for variable
declaration.

> Fixes: a0f60f8431999bf5 ("s390/protvirt: Add sysfs firmware interface for Ultravisor information")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Philipp Rudo <prudo@linux.ibm.com>
> Suggested-by: Philipp Rudo <prudo@linux.ibm.com>
> CC: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/boot/uv.c   | 2 --
>  arch/s390/kernel/uv.c | 3 ++-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
> index 8fde561f1d07..f887a479cdc7 100644
> --- a/arch/s390/boot/uv.c
> +++ b/arch/s390/boot/uv.c
> @@ -7,9 +7,7 @@
>  #ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
>  int __bootdata_preserved(prot_virt_guest);
>  #endif
> -#if IS_ENABLED(CONFIG_KVM)
>  struct uv_info __bootdata_preserved(uv_info);
> -#endif
>  
>  void uv_query_info(void)
>  {
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index c86d654351d1..4c0677fc8904 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -23,10 +23,11 @@
>  int __bootdata_preserved(prot_virt_guest);
>  #endif
>  
> +struct uv_info __bootdata_preserved(uv_info);
> +
>  #if IS_ENABLED(CONFIG_KVM)
>  int prot_virt_host;
>  EXPORT_SYMBOL(prot_virt_host);
> -struct uv_info __bootdata_preserved(uv_info);
>  EXPORT_SYMBOL(uv_info);

hm, EXPORT_SYMBOL(uv_info) is not needed without CONFIG_KVM and this saves
1 symbol export, but I'd still made EXPORT_SYMBOL follow the declaration
immediately. Documentation/process/coding-style.rst mentions that only
for function declarations though.

Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>

