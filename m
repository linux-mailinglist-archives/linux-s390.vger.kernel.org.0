Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B569D17C49F
	for <lists+linux-s390@lfdr.de>; Fri,  6 Mar 2020 18:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCFRjn (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 6 Mar 2020 12:39:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725922AbgCFRjm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Mar 2020 12:39:42 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026HbHjL041466
        for <linux-s390@vger.kernel.org>; Fri, 6 Mar 2020 12:39:40 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ykd4a59g6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 06 Mar 2020 12:39:40 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <nayna@linux.ibm.com>;
        Fri, 6 Mar 2020 17:39:38 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Mar 2020 17:39:37 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 026HdZia58130484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Mar 2020 17:39:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97D424C04E;
        Fri,  6 Mar 2020 17:39:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54BEC4C046;
        Fri,  6 Mar 2020 17:39:33 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.160.48.59])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Mar 2020 17:39:33 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-efi@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v3] ima: add a new CONFIG for loading arch-specific policies
Date:   Fri,  6 Mar 2020 12:39:20 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 20030617-4275-0000-0000-000003A90C33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030617-4276-0000-0000-000038BE1F86
Message-Id: <1583516360-22016-1-git-send-email-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_05:2020-03-06,2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060112
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Every time a new architecture defines the IMA architecture specific
functions - arch_ima_get_secureboot() and arch_ima_get_policy(), the IMA
include file needs to be updated. To avoid this "noise", this patch
defines a new IMA Kconfig IMA_SECURE_AND_OR_TRUSTED_BOOT option, allowing
the different architectures to select it.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
v3:
* Updated and tested the patch with improvements suggested by Michael.
It now uses "imply" instead of "select". Thanks Michael.
* Have missed replacing the CONFIG_IMA in x86 and s390 with new config,
that was resulting in redefinition when the IMA_SECURE_AND_OR_TRUSTED_BOOT
is not enabled. Thanks to Mimi for recognizing the problem.

v2:
* Fixed the issue identified by Mimi. Thanks Mimi, Ard, Heiko and Michael for
discussing the fix.

 arch/powerpc/Kconfig           | 1 +
 arch/s390/Kconfig              | 1 +
 arch/s390/kernel/Makefile      | 2 +-
 arch/x86/Kconfig               | 1 +
 arch/x86/kernel/Makefile       | 2 +-
 include/linux/ima.h            | 3 +--
 security/integrity/ima/Kconfig | 8 ++++++++
 7 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 497b7d0b2d7e..a5cfde432983 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -979,6 +979,7 @@ config PPC_SECURE_BOOT
 	bool
 	depends on PPC_POWERNV
 	depends on IMA_ARCH_POLICY
+	select IMA_SECURE_AND_OR_TRUSTED_BOOT
 	help
 	  Systems with firmware secure boot enabled need to define security
 	  policies to extend secure boot to the OS. This config allows a user
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8abe77536d9d..4a502fbcb800 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -195,6 +195,7 @@ config S390
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select SWIOTLB
 	select GENERIC_ALLOCATOR
+	select IMA_SECURE_AND_OR_TRUSTED_BOOT if IMA_ARCH_POLICY
 
 
 config SCHED_OMIT_FRAME_POINTER
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 2b1203cf7be6..578a6fa82ea4 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -70,7 +70,7 @@ obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_image.o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec_elf.o
 
-obj-$(CONFIG_IMA)		+= ima_arch.o
+obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_cpum_cf_common.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_cpum_cf.o perf_cpum_sf.o
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index beea77046f9b..7f5bfaf0cbd2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -230,6 +230,7 @@ config X86
 	select VIRT_TO_BUS
 	select X86_FEATURE_NAMES		if PROC_FS
 	select PROC_PID_ARCH_STATUS		if PROC_FS
+	select IMA_SECURE_AND_OR_TRUSTED_BOOT	if EFI && IMA_ARCH_POLICY
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 9b294c13809a..7f131ceba136 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -155,5 +155,5 @@ ifeq ($(CONFIG_X86_64),y)
 endif
 
 ifdef CONFIG_EFI
-obj-$(CONFIG_IMA)			+= ima_arch.o
+obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
 endif
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 1659217e9b60..aefe758f4466 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -30,8 +30,7 @@ extern void ima_kexec_cmdline(const void *buf, int size);
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
 
-#if (defined(CONFIG_X86) && defined(CONFIG_EFI)) || defined(CONFIG_S390) \
-	|| defined(CONFIG_PPC_SECURE_BOOT)
+#ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
 extern bool arch_ima_get_secureboot(void);
 extern const char * const *arch_get_ima_policy(void);
 #else
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 3f3ee4e2eb0d..2baaf196c6d8 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -327,3 +327,11 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
 	depends on IMA_MEASURE_ASYMMETRIC_KEYS
 	depends on SYSTEM_TRUSTED_KEYRING
 	default y
+
+config IMA_SECURE_AND_OR_TRUSTED_BOOT
+	bool
+	depends on IMA_ARCH_POLICY
+	default n
+	help
+	   This option is selected by architectures to enable secure and/or
+	   trusted boot based on IMA runtime policies.
-- 
2.18.1

