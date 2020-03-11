Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0C11820EB
	for <lists+linux-s390@lfdr.de>; Wed, 11 Mar 2020 19:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbgCKSfz (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 11 Mar 2020 14:35:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730903AbgCKSfz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Mar 2020 14:35:55 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BIVLgp070938
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 14:35:54 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yq4ggb8kp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 14:35:54 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <prudo@linux.ibm.com>;
        Wed, 11 Mar 2020 18:35:52 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Mar 2020 18:35:48 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02BIZlvR42729688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 18:35:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 201334203F;
        Wed, 11 Mar 2020 18:35:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B723C4204F;
        Wed, 11 Mar 2020 18:35:46 +0000 (GMT)
Received: from laptop2-ibm.local (unknown [9.152.212.60])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Mar 2020 18:35:46 +0000 (GMT)
Date:   Wed, 11 Mar 2020 19:35:45 +0100
From:   Philipp Rudo <prudo@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-efi@vger.kernel.org, linux-s390@vger.kernel.org,
        x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, zohar@linux.ibm.com,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] ima: add a new CONFIG for loading arch-specific
 policies
In-Reply-To: <1583715471-15525-1-git-send-email-nayna@linux.ibm.com>
References: <1583715471-15525-1-git-send-email-nayna@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20031118-0028-0000-0000-000003E33C88
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031118-0029-0000-0000-000024A881D7
Message-Id: <20200311193545.2f0e5ea3@laptop2-ibm.local>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_09:2020-03-11,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110105
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun,  8 Mar 2020 20:57:51 -0400
Nayna Jain <nayna@linux.ibm.com> wrote:

> From: Nayna Jain <nayna@linux.vnet.ibm.com>
> 
> Every time a new architecture defines the IMA architecture specific
> functions - arch_ima_get_secureboot() and arch_ima_get_policy(), the IMA
> include file needs to be updated. To avoid this "noise", this patch
> defines a new IMA Kconfig IMA_SECURE_AND_OR_TRUSTED_BOOT option, allowing
> the different architectures to select it.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Philipp Rudo <prudo@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
> v3:
> * Removes CONFIG_IMA dependency. Thanks Ard.
> * Updated the patch with improvements suggested by Michael. It now uses
> "imply" instead of "select". Thanks Michael.
> * Replaced the CONFIG_IMA in x86 and s390 with new config, else it was
> resulting in redefinition when the IMA_SECURE_AND_OR_TRUSTED_BOOT
> is not enabled. Thanks to Mimi for identifying the problem.
> * Removed "#ifdef EFI" check in the arch/x86/Makefile for compiling
> ima_arch.c file.
> * Ard, Thanks for your Acked-by. I have changed the arch/x86/Makefile in
> this version. Can you please review again and confirm ?
> * Rudo, Thanks for your review. I have changed arch/s390/Makefile as well.
> Can you also please review again ?

Looks good to me

for the s390 part
Acked-by: Philipp Rudo <prudo@linux.ibm.com>

Thanks
Philipp

> 
> v2:
> * Fixed the issue identified by Mimi. Thanks Mimi, Ard, Heiko and Michael for
> discussing the fix.
> 
>  arch/powerpc/Kconfig           | 1 +
>  arch/s390/Kconfig              | 1 +
>  arch/s390/kernel/Makefile      | 2 +-
>  arch/x86/Kconfig               | 1 +
>  arch/x86/kernel/Makefile       | 4 +---
>  include/linux/ima.h            | 3 +--
>  security/integrity/ima/Kconfig | 7 +++++++
>  7 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 497b7d0b2d7e..5b9f1cba2a44 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -979,6 +979,7 @@ config PPC_SECURE_BOOT
>  	bool
>  	depends on PPC_POWERNV
>  	depends on IMA_ARCH_POLICY
> +	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
>  	help
>  	  Systems with firmware secure boot enabled need to define security
>  	  policies to extend secure boot to the OS. This config allows a user
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 8abe77536d9d..59c216af6264 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -195,6 +195,7 @@ config S390
>  	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
>  	select SWIOTLB
>  	select GENERIC_ALLOCATOR
> +	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
>  
>  
>  config SCHED_OMIT_FRAME_POINTER
> diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
> index 2b1203cf7be6..578a6fa82ea4 100644
> --- a/arch/s390/kernel/Makefile
> +++ b/arch/s390/kernel/Makefile
> @@ -70,7 +70,7 @@ obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
>  obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_image.o
>  obj-$(CONFIG_KEXEC_FILE)	+= kexec_elf.o
>  
> -obj-$(CONFIG_IMA)		+= ima_arch.o
> +obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
>  
>  obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_cpum_cf_common.o
>  obj-$(CONFIG_PERF_EVENTS)	+= perf_cpum_cf.o perf_cpum_sf.o
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index beea77046f9b..dcf5b1729f7c 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -230,6 +230,7 @@ config X86
>  	select VIRT_TO_BUS
>  	select X86_FEATURE_NAMES		if PROC_FS
>  	select PROC_PID_ARCH_STATUS		if PROC_FS
> +	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>  
>  config INSTRUCTION_DECODER
>  	def_bool y
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 9b294c13809a..cfef37a27def 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -154,6 +154,4 @@ ifeq ($(CONFIG_X86_64),y)
>  	obj-y				+= vsmp_64.o
>  endif
>  
> -ifdef CONFIG_EFI
> -obj-$(CONFIG_IMA)			+= ima_arch.o
> -endif
> +obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 1659217e9b60..aefe758f4466 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -30,8 +30,7 @@ extern void ima_kexec_cmdline(const void *buf, int size);
>  extern void ima_add_kexec_buffer(struct kimage *image);
>  #endif
>  
> -#if (defined(CONFIG_X86) && defined(CONFIG_EFI)) || defined(CONFIG_S390) \
> -	|| defined(CONFIG_PPC_SECURE_BOOT)
> +#ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
>  extern bool arch_ima_get_secureboot(void);
>  extern const char * const *arch_get_ima_policy(void);
>  #else
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 3f3ee4e2eb0d..edde88dbe576 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -327,3 +327,10 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
>  	depends on IMA_MEASURE_ASYMMETRIC_KEYS
>  	depends on SYSTEM_TRUSTED_KEYRING
>  	default y
> +
> +config IMA_SECURE_AND_OR_TRUSTED_BOOT
> +       bool
> +       depends on IMA_ARCH_POLICY
> +       help
> +          This option is selected by architectures to enable secure and/or
> +          trusted boot based on IMA runtime policies.

