Return-Path: <linux-s390+bounces-6065-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 239AA9780BB
	for <lists+linux-s390@lfdr.de>; Fri, 13 Sep 2024 15:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B98284275
	for <lists+linux-s390@lfdr.de>; Fri, 13 Sep 2024 13:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2AA1DB94D;
	Fri, 13 Sep 2024 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YfgKJfd7"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183321DB525;
	Fri, 13 Sep 2024 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726232755; cv=none; b=JVJh73ZA6BXM9SeU14R5djQOnb5mVZy4rti7RPkubfedrkkItqSYggDLn0xuJU4ni0Boyorm40an1MMrnqjitNazA5/cub67X7zy9jXEgqHNa1wsrwzIyT5lCQfVQyxgFMd8wm7gpYRpCdnNC1n5YUPW4yF4Bi0qx44YCscLNc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726232755; c=relaxed/simple;
	bh=Hvq74IJKuTL2xHYEpZP2WVdFbo7BrLFFMZAacfNziqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsykiBHlarsC26Hhqvae3eIiemyY5UilVt9nNpVJqqJh9P9dnGO/ZeM48edvHmbrzE5Bj7m+6V9ZHUAq1c/4eTfizJnzh3yCiGJa5e8uuzJAUMW5X32ysmLrAQFAix+USvQouxqGj1wQuVeacigRyll78Sh2V0qcbGSzgaiQtxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YfgKJfd7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D73Pjl000999;
	Fri, 13 Sep 2024 13:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=m7CQeHPkblrP9
	mMZeWG5GnosbjlA6zZDSH1NJ2A+Jcw=; b=YfgKJfd70eUPOua07aPvBFlOpLvUN
	T6bk9XpfQfa9aD8yTfSldFfRT3J6UeK5SLatZ7WD2hQ/IbPnm9JfF3iQErZ0EXKu
	CiLp13ZcRoWy+vOECAbc+345ggTbv+aWKer34sgeLWuX3OTdTrAtuDLwaNDdZwkJ
	+EoUBV+kroi5DrI0SyglEztPQFle/4QVnoGqYmIEO+zOKwfayyqgGsqybpxGlQGj
	zUojADWpMcYJ9xRgPLZ1WgzZHRhjulRWJAefQ2mswOs1iRvrALsGoxNTrWNt4RME
	sCs52X6maskvbeUa5FyZS2BqPIJ5/XDjIZDjpf5gP9RDCkymm1lCqn2eg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41geg01ugn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 13:05:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48D9u9kC027297;
	Fri, 13 Sep 2024 13:05:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3v3nxuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 13:05:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48DD5lN649807798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 13:05:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC79F20040;
	Fri, 13 Sep 2024 13:05:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 979512004B;
	Fri, 13 Sep 2024 13:05:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Sep 2024 13:05:46 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Stefan Liebler <stli@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 7/7] s390/vdso: Wire up getrandom() vdso implementation
Date: Fri, 13 Sep 2024 15:05:43 +0200
Message-ID: <20240913130544.2398678-8-hca@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913130544.2398678-1-hca@linux.ibm.com>
References: <20240913130544.2398678-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zLiDSlZ9YgD4_5zJVgBAV7Irvhj0xw_d
X-Proofpoint-ORIG-GUID: zLiDSlZ9YgD4_5zJVgBAV7Irvhj0xw_d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_09,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130087

Provide the s390 specific vdso getrandom() architecture backend.

_vdso_rng_data required data is placed within the _vdso_data vvar page, by
using a hardcoded offset larger than vdso_data.

As required the chacha20 implementation does not write to the stack.

The implementation follows more or less the arm64 implementations and
makes use of vector instructions. It has a fallback to the getrandom()
system call for machines where the vector facility is not
installed.
The check if the vector facility is installed, as well as an
optimization for machines with the vector-enhancements facility 2,
is implemented with alternatives, avoiding runtime checks.

Note that __kernel_getrandom() is implemented without the vdso user wrapper
which would setup a stack frame for odd cases (aka very old glibc variants)
where the caller has not done that. All callers of __kernel_getrandom() are
required to setup a stack frame, like the C ABI requires it.

The vdso testcases vdso_test_getrandom and vdso_test_chacha pass.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig                           |   1 +
 arch/s390/include/asm/fpu-insn-asm.h        |  22 +++
 arch/s390/include/asm/vdso/getrandom.h      |  40 +++++
 arch/s390/include/asm/vdso/vsyscall.h       |  15 ++
 arch/s390/kernel/vdso.c                     |   7 +-
 arch/s390/kernel/vdso64/Makefile            |   9 +-
 arch/s390/kernel/vdso64/vdso.h              |   1 +
 arch/s390/kernel/vdso64/vdso64.lds.S        |   3 +
 arch/s390/kernel/vdso64/vgetrandom-chacha.S | 184 ++++++++++++++++++++
 arch/s390/kernel/vdso64/vgetrandom.c        |  14 ++
 tools/arch/s390/vdso                        |   1 +
 tools/testing/selftests/vDSO/Makefile       |   2 +-
 12 files changed, 290 insertions(+), 9 deletions(-)
 create mode 100644 arch/s390/include/asm/vdso/getrandom.h
 create mode 100644 arch/s390/kernel/vdso64/vgetrandom-chacha.S
 create mode 100644 arch/s390/kernel/vdso64/vgetrandom.c
 create mode 120000 tools/arch/s390/vdso

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c60e699e99f5..b0d0b3a8d196 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -243,6 +243,7 @@ config S390
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY
 	select USER_STACKTRACE_SUPPORT
+	select VDSO_GETRANDOM
 	select VIRT_CPU_ACCOUNTING
 	select ZONE_DMA
 	# Note: keep the above list sorted alphabetically
diff --git a/arch/s390/include/asm/fpu-insn-asm.h b/arch/s390/include/asm/fpu-insn-asm.h
index 02ccfe46050a..d296322be4bc 100644
--- a/arch/s390/include/asm/fpu-insn-asm.h
+++ b/arch/s390/include/asm/fpu-insn-asm.h
@@ -407,6 +407,28 @@
 	MRXBOPC	0, 0x0E, v1
 .endm
 
+/* VECTOR STORE BYTE REVERSED ELEMENTS */
+	.macro	VSTBR	vr1, disp, index="%r0", base, m
+	VX_NUM	v1, \vr1
+	GR_NUM	x2, \index
+	GR_NUM	b2, \base
+	.word	0xE600 | ((v1&15) << 4) | (x2&15)
+	.word	(b2 << 12) | (\disp)
+	MRXBOPC	\m, 0x0E, v1
+.endm
+.macro	VSTBRH	vr1, disp, index="%r0", base
+	VSTBR	\vr1, \disp, \index, \base, 1
+.endm
+.macro	VSTBRF	vr1, disp, index="%r0", base
+	VSTBR	\vr1, \disp, \index, \base, 2
+.endm
+.macro	VSTBRG	vr1, disp, index="%r0", base
+	VSTBR	\vr1, \disp, \index, \base, 3
+.endm
+.macro	VSTBRQ	vr1, disp, index="%r0", base
+	VSTBR	\vr1, \disp, \index, \base, 4
+.endm
+
 /* VECTOR STORE MULTIPLE */
 .macro	VSTM	vfrom, vto, disp, base, hint=3
 	VX_NUM	v1, \vfrom
diff --git a/arch/s390/include/asm/vdso/getrandom.h b/arch/s390/include/asm/vdso/getrandom.h
new file mode 100644
index 000000000000..36355af7160b
--- /dev/null
+++ b/arch/s390/include/asm/vdso/getrandom.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_VDSO_GETRANDOM_H
+#define __ASM_VDSO_GETRANDOM_H
+
+#ifndef __ASSEMBLY__
+
+#include <vdso/datapage.h>
+#include <asm/vdso/vsyscall.h>
+#include <asm/syscall.h>
+#include <asm/unistd.h>
+#include <asm/page.h>
+
+/**
+ * getrandom_syscall - Invoke the getrandom() syscall.
+ * @buffer:	Destination buffer to fill with random bytes.
+ * @len:	Size of @buffer in bytes.
+ * @flags:	Zero or more GRND_* flags.
+ * Returns:	The number of random bytes written to @buffer, or a negative value indicating an error.
+ */
+static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)
+{
+	return syscall3(__NR_getrandom, (long)buffer, (long)len, (long)flags);
+}
+
+static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
+{
+	/*
+	 * The RNG data is in the real VVAR data page, but if a task belongs to a time namespace
+	 * then VVAR_DATA_PAGE_OFFSET points to the namespace-specific VVAR page and VVAR_TIMENS_
+	 * PAGE_OFFSET points to the real VVAR page.
+	 */
+	if (IS_ENABLED(CONFIG_TIME_NS) && _vdso_data->clock_mode == VDSO_CLOCKMODE_TIMENS)
+		return (void *)&_vdso_rng_data + VVAR_TIMENS_PAGE_OFFSET * PAGE_SIZE;
+	return &_vdso_rng_data;
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/s390/include/asm/vdso/vsyscall.h b/arch/s390/include/asm/vdso/vsyscall.h
index 6c67c08cefdd..3c5d5e47814e 100644
--- a/arch/s390/include/asm/vdso/vsyscall.h
+++ b/arch/s390/include/asm/vdso/vsyscall.h
@@ -2,12 +2,21 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
 
+#define __VDSO_RND_DATA_OFFSET	768
+
 #ifndef __ASSEMBLY__
 
 #include <linux/hrtimer.h>
 #include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
 #include <asm/vdso.h>
+
+enum vvar_pages {
+	VVAR_DATA_PAGE_OFFSET,
+	VVAR_TIMENS_PAGE_OFFSET,
+	VVAR_NR_PAGES
+};
+
 /*
  * Update the vDSO data page to keep in sync with kernel timekeeping.
  */
@@ -18,6 +27,12 @@ static __always_inline struct vdso_data *__s390_get_k_vdso_data(void)
 }
 #define __arch_get_k_vdso_data __s390_get_k_vdso_data
 
+static __always_inline struct vdso_rng_data *__s390_get_k_vdso_rnd_data(void)
+{
+	return (void *)vdso_data + __VDSO_RND_DATA_OFFSET;
+}
+#define __arch_get_k_vdso_rng_data __s390_get_k_vdso_rnd_data
+
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
 
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 8e4e6b316337..598b512cde01 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -19,6 +19,7 @@
 #include <linux/time_namespace.h>
 #include <linux/random.h>
 #include <vdso/datapage.h>
+#include <asm/vdso/vsyscall.h>
 #include <asm/alternative.h>
 #include <asm/vdso.h>
 
@@ -31,12 +32,6 @@ static union vdso_data_store vdso_data_store __page_aligned_data;
 
 struct vdso_data *vdso_data = vdso_data_store.data;
 
-enum vvar_pages {
-	VVAR_DATA_PAGE_OFFSET,
-	VVAR_TIMENS_PAGE_OFFSET,
-	VVAR_NR_PAGES,
-};
-
 #ifdef CONFIG_TIME_NS
 struct vdso_data *arch_get_vdso_data(void *vvar_page)
 {
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index ba19c0ca7c87..37bb4b761229 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -3,12 +3,17 @@
 
 # Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
-obj-vdso64 = vdso_user_wrapper.o note.o
-obj-cvdso64 = vdso64_generic.o getcpu.o
+obj-vdso64 = vdso_user_wrapper.o note.o vgetrandom-chacha.o
+obj-cvdso64 = vdso64_generic.o getcpu.o vgetrandom.o
 VDSO_CFLAGS_REMOVE := -pg $(CC_FLAGS_FTRACE) $(CC_FLAGS_EXPOLINE) $(CC_FLAGS_CHECK_STACK)
 CFLAGS_REMOVE_getcpu.o = $(VDSO_CFLAGS_REMOVE)
+CFLAGS_REMOVE_vgetrandom.o = $(VDSO_CFLAGS_REMOVE)
 CFLAGS_REMOVE_vdso64_generic.o = $(VDSO_CFLAGS_REMOVE)
 
+ifneq ($(c-getrandom-y),)
+	CFLAGS_vgetrandom.o += -include $(c-getrandom-y)
+endif
+
 # Build rules
 
 targets := $(obj-vdso64) $(obj-cvdso64) vdso64.so vdso64.so.dbg
diff --git a/arch/s390/kernel/vdso64/vdso.h b/arch/s390/kernel/vdso64/vdso.h
index 34c7a2312f9d..9e5397e7b590 100644
--- a/arch/s390/kernel/vdso64/vdso.h
+++ b/arch/s390/kernel/vdso64/vdso.h
@@ -10,5 +10,6 @@ int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unuse
 int __s390_vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
 int __s390_vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
 int __s390_vdso_clock_getres(clockid_t clock, struct __kernel_timespec *ts);
+ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len);
 
 #endif /* __ARCH_S390_KERNEL_VDSO64_VDSO_H */
diff --git a/arch/s390/kernel/vdso64/vdso64.lds.S b/arch/s390/kernel/vdso64/vdso64.lds.S
index fa02c6ae3cac..753040a4b5ab 100644
--- a/arch/s390/kernel/vdso64/vdso64.lds.S
+++ b/arch/s390/kernel/vdso64/vdso64.lds.S
@@ -4,6 +4,7 @@
  * library
  */
 
+#include <asm/vdso/vsyscall.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
 
@@ -13,6 +14,7 @@ OUTPUT_ARCH(s390:64-bit)
 SECTIONS
 {
 	PROVIDE(_vdso_data = . - __VVAR_PAGES * PAGE_SIZE);
+	PROVIDE(_vdso_rng_data = _vdso_data + __VDSO_RND_DATA_OFFSET);
 #ifdef CONFIG_TIME_NS
 	PROVIDE(_timens_data = _vdso_data + PAGE_SIZE);
 #endif
@@ -144,6 +146,7 @@ VERSION
 		__kernel_restart_syscall;
 		__kernel_rt_sigreturn;
 		__kernel_sigreturn;
+		__kernel_getrandom;
 	local: *;
 	};
 }
diff --git a/arch/s390/kernel/vdso64/vgetrandom-chacha.S b/arch/s390/kernel/vdso64/vgetrandom-chacha.S
new file mode 100644
index 000000000000..ecd44cf0eaba
--- /dev/null
+++ b/arch/s390/kernel/vdso64/vgetrandom-chacha.S
@@ -0,0 +1,184 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/linkage.h>
+#include <asm/alternative.h>
+#include <asm/fpu-insn.h>
+
+#define STATE0	%v0
+#define STATE1	%v1
+#define STATE2	%v2
+#define STATE3	%v3
+#define COPY0	%v4
+#define COPY1	%v5
+#define COPY2	%v6
+#define COPY3	%v7
+#define PERM4	%v16
+#define PERM8	%v17
+#define PERM12	%v18
+#define BEPERM	%v19
+#define TMP0	%v20
+#define TMP1	%v21
+#define TMP2	%v22
+#define TMP3	%v23
+
+	.section .rodata
+
+	.balign 128
+.Lconstants:
+	.long	0x61707865,0x3320646e,0x79622d32,0x6b206574 # endian-neutral
+	.long	0x04050607,0x08090a0b,0x0c0d0e0f,0x00010203 # rotl  4 bytes
+	.long	0x08090a0b,0x0c0d0e0f,0x00010203,0x04050607 # rotl  8 bytes
+	.long	0x0c0d0e0f,0x00010203,0x04050607,0x08090a0b # rotl 12 bytes
+	.long	0x03020100,0x07060504,0x0b0a0908,0x0f0e0d0c # byte swap
+
+	.text
+/*
+ * s390 ChaCha20 implementation meant for vDSO. Produces a given positive
+ * number of blocks of output with nonce 0, taking an input key and 8-bytes
+ * counter. Does not spill to the stack.
+ *
+ * void __arch_chacha20_blocks_nostack(uint8_t *dst_bytes,
+ *				       const uint8_t *key,
+ *				       uint32_t *counter,
+ *				       size_t nblocks)
+ */
+SYM_FUNC_START(__arch_chacha20_blocks_nostack)
+	larl	%r1,.Lconstants
+
+	/* COPY0 = "expand 32-byte k" */
+	VL	COPY0,0,,%r1
+
+	/* PERM4-PERM12,BEPERM = byte selectors for VPERM */
+	VLM	PERM4,BEPERM,16,%r1
+
+	/* COPY1,COPY2 = key */
+	VLM	COPY1,COPY2,0,%r3
+
+	/* COPY3 = counter || zero nonce  */
+	lg	%r3,0(%r4)
+	VZERO	COPY3
+	VLVGG	COPY3,%r3,0
+
+	lghi	%r1,0
+.Lblock:
+	VLR	STATE0,COPY0
+	VLR	STATE1,COPY1
+	VLR	STATE2,COPY2
+	VLR	STATE3,COPY3
+
+	lghi	%r0,10
+.Ldoubleround:
+	/* STATE0 += STATE1, STATE3 = rotl32(STATE3 ^ STATE0, 16) */
+	VAF	STATE0,STATE0,STATE1
+	VX	STATE3,STATE3,STATE0
+	VERLLF	STATE3,STATE3,16
+
+	/* STATE2 += STATE3, STATE1 = rotl32(STATE1 ^ STATE2, 12) */
+	VAF	STATE2,STATE2,STATE3
+	VX	STATE1,STATE1,STATE2
+	VERLLF	STATE1,STATE1,12
+
+	/* STATE0 += STATE1, STATE3 = rotl32(STATE3 ^ STATE0, 8) */
+	VAF	STATE0,STATE0,STATE1
+	VX	STATE3,STATE3,STATE0
+	VERLLF	STATE3,STATE3,8
+
+	/* STATE2 += STATE3, STATE1 = rotl32(STATE1 ^ STATE2, 7) */
+	VAF	STATE2,STATE2,STATE3
+	VX	STATE1,STATE1,STATE2
+	VERLLF	STATE1,STATE1,7
+
+	/* STATE1[0,1,2,3] = STATE1[1,2,3,0] */
+	VPERM	STATE1,STATE1,STATE1,PERM4
+	/* STATE2[0,1,2,3] = STATE2[2,3,0,1] */
+	VPERM	STATE2,STATE2,STATE2,PERM8
+	/* STATE3[0,1,2,3] = STATE3[3,0,1,2] */
+	VPERM	STATE3,STATE3,STATE3,PERM12
+
+	/* STATE0 += STATE1, STATE3 = rotl32(STATE3 ^ STATE0, 16) */
+	VAF	STATE0,STATE0,STATE1
+	VX	STATE3,STATE3,STATE0
+	VERLLF	STATE3,STATE3,16
+
+	/* STATE2 += STATE3, STATE1 = rotl32(STATE1 ^ STATE2, 12) */
+	VAF	STATE2,STATE2,STATE3
+	VX	STATE1,STATE1,STATE2
+	VERLLF	STATE1,STATE1,12
+
+	/* STATE0 += STATE1, STATE3 = rotl32(STATE3 ^ STATE0, 8) */
+	VAF	STATE0,STATE0,STATE1
+	VX	STATE3,STATE3,STATE0
+	VERLLF	STATE3,STATE3,8
+
+	/* STATE2 += STATE3, STATE1 = rotl32(STATE1 ^ STATE2, 7) */
+	VAF	STATE2,STATE2,STATE3
+	VX	STATE1,STATE1,STATE2
+	VERLLF	STATE1,STATE1,7
+
+	/* STATE1[0,1,2,3] = STATE1[3,0,1,2] */
+	VPERM	STATE1,STATE1,STATE1,PERM12
+	/* STATE2[0,1,2,3] = STATE2[2,3,0,1] */
+	VPERM	STATE2,STATE2,STATE2,PERM8
+	/* STATE3[0,1,2,3] = STATE3[1,2,3,0] */
+	VPERM	STATE3,STATE3,STATE3,PERM4
+	brctg	%r0,.Ldoubleround
+
+	/* OUTPUT0 = STATE0 + STATE0 */
+	VAF	STATE0,STATE0,COPY0
+	/* OUTPUT1 = STATE1 + STATE1 */
+	VAF	STATE1,STATE1,COPY1
+	/* OUTPUT2 = STATE2 + STATE2 */
+	VAF	STATE2,STATE2,COPY2
+	/* OUTPUT2 = STATE3 + STATE3 */
+	VAF	STATE3,STATE3,COPY3
+
+	/*
+	 * 32 bit wise little endian store to OUTPUT. If the vector
+	 * enhancement facility 2 is not installed use the slow path.
+	 */
+	ALTERNATIVE "brc 0xf,.Lstoreslow", "nop", ALT_FACILITY(148)
+	VSTBRF	STATE0,0,,%r2
+	VSTBRF	STATE1,16,,%r2
+	VSTBRF	STATE2,32,,%r2
+	VSTBRF	STATE3,48,,%r2
+.Lstoredone:
+
+	/* ++COPY3.COUNTER */
+	alsih	%r3,1
+	alcr	%r3,%r1
+	VLVGG	COPY3,%r3,0
+
+	/* OUTPUT += 64, --NBLOCKS */
+	aghi	%r2,64
+	brctg	%r5,.Lblock
+
+	/* COUNTER = COPY3.COUNTER */
+	stg	%r3,0(%r4)
+
+	/* Zero out potentially sensitive regs */
+	VZERO	STATE0
+	VZERO	STATE1
+	VZERO	STATE2
+	VZERO	STATE3
+	VZERO	COPY1
+	VZERO	COPY2
+
+	/* Early exit if TMP0-TMP3 have not been used */
+	ALTERNATIVE "nopr", "br %r14", ALT_FACILITY(148)
+
+	VZERO	TMP0
+	VZERO	TMP1
+	VZERO	TMP2
+	VZERO	TMP3
+
+	br	%r14
+
+.Lstoreslow:
+	/* Convert STATE to little endian format and store to OUTPUT */
+	VPERM	TMP0,STATE0,STATE0,BEPERM
+	VPERM	TMP1,STATE1,STATE1,BEPERM
+	VPERM	TMP2,STATE2,STATE2,BEPERM
+	VPERM	TMP3,STATE3,STATE3,BEPERM
+	VSTM	TMP0,TMP3,0,%r2
+	j	.Lstoredone
+SYM_FUNC_END(__arch_chacha20_blocks_nostack)
diff --git a/arch/s390/kernel/vdso64/vgetrandom.c b/arch/s390/kernel/vdso64/vgetrandom.c
new file mode 100644
index 000000000000..b5268b507fb5
--- /dev/null
+++ b/arch/s390/kernel/vdso64/vgetrandom.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <asm/facility.h>
+#include <uapi/asm-generic/errno.h>
+#include "vdso.h"
+
+ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len)
+{
+	if (test_facility(129))
+		return __cvdso_getrandom(buffer, len, flags, opaque_state, opaque_len);
+	if (unlikely(opaque_len == ~0UL && !buffer && !len && !flags))
+		return -ENOSYS;
+	return getrandom_syscall(buffer, len, flags);
+}
diff --git a/tools/arch/s390/vdso b/tools/arch/s390/vdso
new file mode 120000
index 000000000000..6cf4c1cebdcd
--- /dev/null
+++ b/tools/arch/s390/vdso
@@ -0,0 +1 @@
+../../../arch/s390/kernel/vdso64
\ No newline at end of file
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 86ebc4115eda..af9cedbf5357 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -9,7 +9,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
 TEST_GEN_PROGS += vdso_standalone_test_x86
 endif
 TEST_GEN_PROGS += vdso_test_correctness
-ifeq ($(ARCH)$(CONFIG_X86_32),$(filter $(ARCH)$(CONFIG_X86_32),x86 x86_64 loongarch arm64 powerpc))
+ifeq ($(ARCH)$(CONFIG_X86_32),$(filter $(ARCH)$(CONFIG_X86_32),x86 x86_64 loongarch arm64 powerpc s390))
 TEST_GEN_PROGS += vdso_test_getrandom
 TEST_GEN_PROGS += vdso_test_chacha
 endif
-- 
2.43.0


