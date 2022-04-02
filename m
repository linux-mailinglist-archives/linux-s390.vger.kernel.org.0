Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D974F0315
	for <lists+linux-s390@lfdr.de>; Sat,  2 Apr 2022 15:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355904AbiDBNzg (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 2 Apr 2022 09:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355895AbiDBNzd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 2 Apr 2022 09:55:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C005289;
        Sat,  2 Apr 2022 06:53:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8D1A61538;
        Sat,  2 Apr 2022 13:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE208C36AE3;
        Sat,  2 Apr 2022 13:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648907619;
        bh=FAfiKQPv2rMf2wnvwfTmSAfgZPPOLdLw6VtizCjApcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dC/1AnrilUDDmjbRgN5wovz8PikN1Q4I+U5QYvOE0CCwbm5ioloOwXrJvoKbBMd/0
         LUP8BisAbTkKKLFE6wdlUKSoBJVM4FMhBceu1/+4LPVAAHL7zr7cDj/ySVXZskqpi/
         bUYAgvUTxC9nxhYIPbfg69b6JTHweEmswOIwDIPHVaQ6tKcIXgzGPPAD6VhK4DQkov
         CFSR1oTKfykC6l6VL1FwAFhFT+A1tC7WukqGIOWjpBPdXswG9yIAfayun9wCJpGZDT
         B6QLaRxcWC8UZAIbJD8zMO8JlMvO1YhdzxtUZf+jiC761mR3v1sHsUuKf3o+Y06EqH
         Gvk2sQCfXmWOg==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, hch@lst.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, heiko@sntech.de, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V11 05/20] fs: stat: compat: Add __ARCH_WANT_COMPAT_STAT
Date:   Sat,  2 Apr 2022 21:52:41 +0800
Message-Id: <20220402135256.2691868-6-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402135256.2691868-1-guoren@kernel.org>
References: <20220402135256.2691868-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

RISC-V doesn't neeed compat_stat, so using __ARCH_WANT_COMPAT_STAT
to exclude unnecessary SYSCALL functions.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/arm64/include/asm/unistd.h   | 1 +
 arch/mips/include/asm/unistd.h    | 2 ++
 arch/parisc/include/asm/unistd.h  | 1 +
 arch/powerpc/include/asm/unistd.h | 1 +
 arch/s390/include/asm/unistd.h    | 1 +
 arch/sparc/include/asm/unistd.h   | 1 +
 arch/x86/include/asm/unistd.h     | 1 +
 fs/stat.c                         | 2 +-
 8 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 4e65da3445c7..037feba03a51 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -3,6 +3,7 @@
  * Copyright (C) 2012 ARM Ltd.
  */
 #ifdef CONFIG_COMPAT
+#define __ARCH_WANT_COMPAT_STAT
 #define __ARCH_WANT_COMPAT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index c2196b1b6604..25a5253db7f4 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -50,6 +50,8 @@
 # ifdef CONFIG_32BIT
 #  define __ARCH_WANT_STAT64
 #  define __ARCH_WANT_SYS_TIME32
+# else
+#  define __ARCH_WANT_COMPAT_STAT
 # endif
 # ifdef CONFIG_MIPS32_O32
 #  define __ARCH_WANT_SYS_TIME32
diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index cd438e4150f6..14e0668184cb 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -168,6 +168,7 @@ type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)	\
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
+#define __ARCH_WANT_COMPAT_STAT
 
 #ifdef CONFIG_64BIT
 #define __ARCH_WANT_SYS_TIME
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 5eb462af6766..b1129b4ef57d 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -44,6 +44,7 @@
 #define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_NEWFSTATAT
+#define __ARCH_WANT_COMPAT_STAT
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #endif
 #define __ARCH_WANT_SYS_FORK
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index 9e9f75ef046a..4260bc5ce7f8 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -28,6 +28,7 @@
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
 # ifdef CONFIG_COMPAT
+#   define __ARCH_WANT_COMPAT_STAT
 #   define __ARCH_WANT_SYS_TIME32
 #   define __ARCH_WANT_SYS_UTIME32
 # endif
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index 1e66278ba4a5..d6bc76706a7a 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -46,6 +46,7 @@
 #define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
+#define __ARCH_WANT_COMPAT_STAT
 #endif
 
 #ifdef __32bit_syscall_numbers__
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index 80e9d5206a71..761173ccc33c 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -22,6 +22,7 @@
 #  include <asm/unistd_32_ia32.h>
 #  define __ARCH_WANT_SYS_TIME
 #  define __ARCH_WANT_SYS_UTIME
+#  define __ARCH_WANT_COMPAT_STAT
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64V2
diff --git a/fs/stat.c b/fs/stat.c
index 28d2020ba1f4..ffdeb9065d53 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -639,7 +639,7 @@ SYSCALL_DEFINE5(statx,
 	return do_statx(dfd, filename, flags, mask, buffer);
 }
 
-#ifdef CONFIG_COMPAT
+#if defined(CONFIG_COMPAT) && defined(__ARCH_WANT_COMPAT_STAT)
 static int cp_compat_stat(struct kstat *stat, struct compat_stat __user *ubuf)
 {
 	struct compat_stat tmp;
-- 
2.25.1

