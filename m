Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B1F3D23A1
	for <lists+linux-s390@lfdr.de>; Thu, 22 Jul 2021 14:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhGVMIh (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 22 Jul 2021 08:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231971AbhGVMIf (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 22 Jul 2021 08:08:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A72DD61364;
        Thu, 22 Jul 2021 12:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626958150;
        bh=65tsEwW3CSKPEMHE16jlRd63QonTaTSPGaWpCNuisBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Umcn3aLdmT58YL25nQIdnojBjQ0tfYBM41/WDsdS4dXmBGYMjrkkDTPCWjF/reSIX
         wtiHyhC8LTgCD/Ekg4z8p52KSPagGnExoOvySs1pJOdYjwAVlp5aYzkXpxMrK7vUzV
         mFcbj+edq2DS8NNCU4yUnnnefDBrPz/XYjyobnB77tc7YOgFGNlfI8UP+tmAFaHN46
         yHXT41GcFDbZCJfGypi8G8DOsdDRA88nY83zsQRLeDJsizmzeIiVUPdsohzuFHPrrk
         y6QhM3j3X6ow4iG+90w9dmFSgURM6lBybCHHlN/PK7+hb2yxdz3PCWUUw89+2W79o8
         ekpwk10Ct+RKQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Brian Cain <bcain@codeaurora.org>,
        Chris Zankel <chris@zankel.net>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        uclinux-h8-devel@lists.sourceforge.jp
Subject: [PATCH v3 3/9] hexagon: use generic strncpy/strnlen from_user
Date:   Thu, 22 Jul 2021 14:48:08 +0200
Message-Id: <20210722124814.778059-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210722124814.778059-1-arnd@kernel.org>
References: <20210722124814.778059-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Remove the hexagon implementation of strncpy/strnlen and instead use
the generic version.  The hexagon version reads the data twice for
strncpy() by doing an extra strnlen(), and it apparently lacks a check
for user_addr_max().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/hexagon/Kconfig                |   2 +
 arch/hexagon/include/asm/uaccess.h  |  33 +-------
 arch/hexagon/kernel/hexagon_ksyms.c |   1 -
 arch/hexagon/mm/Makefile            |   2 +-
 arch/hexagon/mm/strnlen_user.S      | 126 ----------------------------
 5 files changed, 5 insertions(+), 159 deletions(-)
 delete mode 100644 arch/hexagon/mm/strnlen_user.S

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index e5a852080730..3bf4845fed4b 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -19,6 +19,8 @@ config HEXAGON
 	# GENERIC_ALLOCATOR is used by dma_alloc_coherent()
 	select GENERIC_ALLOCATOR
 	select GENERIC_IRQ_SHOW
+	select GENERIC_STRNCPY_FROM_USER
+	select GENERIC_STRNLEN_USER
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select NEED_SG_DMA_LENGTH
diff --git a/arch/hexagon/include/asm/uaccess.h b/arch/hexagon/include/asm/uaccess.h
index 59aa3a50744f..d950df12d8c5 100644
--- a/arch/hexagon/include/asm/uaccess.h
+++ b/arch/hexagon/include/asm/uaccess.h
@@ -57,42 +57,13 @@ unsigned long raw_copy_to_user(void __user *to, const void *from,
 __kernel_size_t __clear_user_hexagon(void __user *dest, unsigned long count);
 #define __clear_user(a, s) __clear_user_hexagon((a), (s))
 
-extern long __strnlen_user(const char __user *src, long n);
-
-static inline strnlen_user(const char __user *src, long n)
-{
-        if (!access_ok(src, 1))
-		return 0;
-
-	return __strnlen_user(src, n);
-}
-/*  get around the ifndef in asm-generic/uaccess.h  */
+extern long strnlen_user(const char __user *src, long n);
 #define strnlen_user strnlen_user
 
-static inline long strncpy_from_user(char *dst, const char __user *src, long n);
+extern long strncpy_from_user(char *dst, const char __user *src, long n)
 #define strncpy_from_user strncpy_from_user
 
 #include <asm-generic/uaccess.h>
 
-/*  Todo:  an actual accelerated version of this.  */
-static inline long strncpy_from_user(char *dst, const char __user *src, long n)
-{
-	long res = strnlen_user(src, n);
-
-	if (unlikely(!res))
-		return -EFAULT;
-
-	if (res > n) {
-		long left = raw_copy_from_user(dst, src, n);
-		if (unlikely(left))
-			memset(dst + (n - left), 0, left);
-		return n;
-	} else {
-		long left = raw_copy_from_user(dst, src, res);
-		if (unlikely(left))
-			memset(dst + (res - left), 0, left);
-		return res-1;
-	}
-}
 
 #endif
diff --git a/arch/hexagon/kernel/hexagon_ksyms.c b/arch/hexagon/kernel/hexagon_ksyms.c
index 35545a7386a0..ec56ce2d92a2 100644
--- a/arch/hexagon/kernel/hexagon_ksyms.c
+++ b/arch/hexagon/kernel/hexagon_ksyms.c
@@ -15,7 +15,6 @@ EXPORT_SYMBOL(__clear_user_hexagon);
 EXPORT_SYMBOL(raw_copy_from_user);
 EXPORT_SYMBOL(raw_copy_to_user);
 EXPORT_SYMBOL(iounmap);
-EXPORT_SYMBOL(__strnlen_user);
 EXPORT_SYMBOL(__vmgetie);
 EXPORT_SYMBOL(__vmsetie);
 EXPORT_SYMBOL(__vmyield);
diff --git a/arch/hexagon/mm/Makefile b/arch/hexagon/mm/Makefile
index 893838499591..49911a906fd0 100644
--- a/arch/hexagon/mm/Makefile
+++ b/arch/hexagon/mm/Makefile
@@ -4,4 +4,4 @@
 #
 
 obj-y := init.o ioremap.o uaccess.o vm_fault.o cache.o
-obj-y += copy_to_user.o copy_from_user.o strnlen_user.o vm_tlb.o
+obj-y += copy_to_user.o copy_from_user.o vm_tlb.o
diff --git a/arch/hexagon/mm/strnlen_user.S b/arch/hexagon/mm/strnlen_user.S
deleted file mode 100644
index 4b5574a7cc9c..000000000000
--- a/arch/hexagon/mm/strnlen_user.S
+++ /dev/null
@@ -1,126 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * User string length functions for kernel
- *
- * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
- */
-
-#define isrc	r0
-#define max	r1	/*  Do not change!  */
-
-#define end	r2
-#define tmp1	r3
-
-#define obo	r6	/*  off-by-one  */
-#define start	r7
-#define mod8	r8
-#define dbuf    r15:14
-#define dcmp	r13:12
-
-/*
- * The vector mask version of this turned out *really* badly.
- * The hardware loop version also turned out *really* badly.
- * Seems straight pointer arithmetic basically wins here.
- */
-
-#define fname __strnlen_user
-
-	.text
-	.global fname
-	.type fname, @function
-	.p2align 5  /*  why?  */
-fname:
-	{
-		mod8 = and(isrc,#7);
-		end = add(isrc,max);
-		start = isrc;
-	}
-	{
-		P0 = cmp.eq(mod8,#0);
-		mod8 = and(end,#7);
-		dcmp = #0;
-		if (P0.new) jump:t dw_loop;	/*  fire up the oven  */
-	}
-
-alignment_loop:
-fail_1:	{
-		tmp1 = memb(start++#1);
-	}
-	{
-		P0 = cmp.eq(tmp1,#0);
-		if (P0.new) jump:nt exit_found;
-		P1 = cmp.gtu(end,start);
-		mod8 = and(start,#7);
-	}
-	{
-		if (!P1) jump exit_error;  /*  hit the end  */
-		P0 = cmp.eq(mod8,#0);
-	}
-	{
-		if (!P0) jump alignment_loop;
-	}
-
-
-
-dw_loop:
-fail_2:	{
-		dbuf = memd(start);
-		obo = add(start,#1);
-	}
-	{
-		P0 = vcmpb.eq(dbuf,dcmp);
-	}
-	{
-		tmp1 = P0;
-		P0 = cmp.gtu(end,start);
-	}
-	{
-		tmp1 = ct0(tmp1);
-		mod8 = and(end,#7);
-		if (!P0) jump end_check;
-	}
-	{
-		P0 = cmp.eq(tmp1,#32);
-		if (!P0.new) jump:nt exit_found;
-		if (!P0.new) start = add(obo,tmp1);
-	}
-	{
-		start = add(start,#8);
-		jump dw_loop;
-	}	/*  might be nice to combine these jumps...   */
-
-
-end_check:
-	{
-		P0 = cmp.gt(tmp1,mod8);
-		if (P0.new) jump:nt exit_error;	/*  neverfound!  */
-		start = add(obo,tmp1);
-	}
-
-exit_found:
-	{
-		R0 = sub(start,isrc);
-		jumpr R31;
-	}
-
-exit_error:
-	{
-		R0 = add(max,#1);
-		jumpr R31;
-	}
-
-	/*  Uh, what does the "fixup" return here?  */
-	.falign
-fix_1:
-	{
-		R0 = #0;
-		jumpr R31;
-	}
-
-	.size fname,.-fname
-
-
-.section __ex_table,"a"
-.long fail_1,fix_1
-.long fail_2,fix_1
-.previous
-- 
2.29.2

