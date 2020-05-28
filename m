Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BEC1E5740
	for <lists+linux-s390@lfdr.de>; Thu, 28 May 2020 08:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgE1GGX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 28 May 2020 02:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgE1GGW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 28 May 2020 02:06:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851E8C05BD1E;
        Wed, 27 May 2020 23:06:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nu7so2597808pjb.0;
        Wed, 27 May 2020 23:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRjmGZLeTYEO4i6MoF3PtMzQtXAOSemrWcRExVPUhU0=;
        b=qzQNmOjJMfx76fCYwTzEmTuVwMGge0fL0GWMupqX0HLjuKhR49C7IW0linuKLYMFff
         pT9IgB7pfjGuI9MGGOsNafL/gpkZxX0sO+68ICAkIeIYY9Cj+Cg/4FLq1i1cLiHVBNba
         ME5L2kT617ELN+gNFH1URELQdmrhHJnIXJNaC4bU9a3mycImgez61p/gBrVzqmmu1WuL
         pTLgmOjqEwGZoFvWR9UxP8CLtNKobiWraqdwe9AAlR+8aIRcWtGrQmt+MFYTtq4GAk+S
         3ehH+LX/hC9ip2ZPrTomrcn2ecq4NR1RBJ7e3TQi3gkuyMnU1m4z/10Wem9GCg2+AznL
         +HZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRjmGZLeTYEO4i6MoF3PtMzQtXAOSemrWcRExVPUhU0=;
        b=UMXYpFQafUQa0r9dSR789IEUX5n+XV3ysFqlUE7mGzYQHiMt4NsEX5C+fErjmjx3FT
         qFLvMYXruxGiXwEBTSxfOAvuXpFCY7TUZfqglNTQXoJzZ+lLFMTRqDEsnsu7kq79Yyqk
         wvlo0423+dq/SCzHGncWVGplC0+Cc0dvCvQZ5af7uobMQulCcnWvWAzE1pO7W/o94hg8
         nmPe4wO4wZNVmbjiyIVqd61XVjCxLJNSdZt8Rn7GzJrXg3oN1auPm5Fu4twTo6av5zYt
         9DCrx4A4uS79ciULOAkKJKu5PRs/FuOCVXBFjbUWL0eaYiIzQS9hxKARps7x54vOohpp
         DI+w==
X-Gm-Message-State: AOAM531Cr0IVihVCgJ/6XAyDyIKPumd3Arws3kUe54WiA/szjzrdBYLa
        9nllDgfyWHBdK5HOxAexNFQ=
X-Google-Smtp-Source: ABdhPJwgQh/1+ElEZy/GFWA/I0TiUP5DNcoygK4OlSyCCkgMjGUipBHyCB8x1THDdNmuLIZxE5pa7g==
X-Received: by 2002:a17:902:7d89:: with SMTP id a9mr1924897plm.309.1590645980888;
        Wed, 27 May 2020 23:06:20 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id w73sm3698863pfd.113.2020.05.27.23.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 23:06:20 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] s390: vdso: Use $(LD) instead of $(CC) to link vDSO
Date:   Wed, 27 May 2020 23:06:01 -0700
Message-Id: <20200528060600.2732012-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Currently, the VDSO is being linked through $(CC). This does not match
how the rest of the kernel links objects, which is through the $(LD)
variable.

When clang is built in a default configuration, it first attempts to use
the target triple's default linker, which is just ld. However, the user
can override this through the CLANG_DEFAULT_LINKER cmake define so that
clang uses another linker by default, such as LLVM's own linker, ld.lld.
This can be useful to get more optimized links across various different
projects.

However, this is problematic for the s390 vDSO because ld.lld does not
have any s390 emulatiom support:

https://github.com/llvm/llvm-project/blob/llvmorg-10.0.1-rc1/lld/ELF/Driver.cpp#L132-L150

Thus, if a user is using a toolchain with ld.lld as the default, they
will see an error, even if they have specified ld.bfd through the LD
make variable:

$ make -j"$(nproc)" -s ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- LLVM=1 \
                       LD=s390x-linux-gnu-ld \
                       defconfig arch/s390/kernel/vdso64/
ld.lld: error: unknown emulation: elf64_s390
clang-11: error: linker command failed with exit code 1 (use -v to see invocation)

Normally, '-fuse-ld=bfd' could be used to get around this; however, this
can be fragile, depending on paths and variable naming. The cleaner
solution for the kernel is to take advantage of the fact that $(LD) can
be invoked directly, which bypasses the heuristics of $(CC) and respects
the user's choice. Similar changes have been done for ARM, ARM64, and
MIPS.

Link: https://github.com/ClangBuiltLinux/linux/issues/1041
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/s390/kernel/vdso64/Makefile | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index bec19e7e6e1c..b8db1ffbc2b9 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -18,8 +18,8 @@ KBUILD_AFLAGS_64 += -m64 -s
 
 KBUILD_CFLAGS_64 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_64 += -m64 -fPIC -shared -fno-common -fno-builtin
-KBUILD_CFLAGS_64 += -nostdlib -Wl,-soname=linux-vdso64.so.1 \
-		    -Wl,--hash-style=both
+ldflags-y := -shared -nostdlib -soname=linux-vdso64.so.1 \
+	     --hash-style=both -T
 
 $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_64)
 $(targets:%=$(obj)/%.dbg): KBUILD_AFLAGS = $(KBUILD_AFLAGS_64)
@@ -37,8 +37,8 @@ KASAN_SANITIZE := n
 $(obj)/vdso64_wrapper.o : $(obj)/vdso64.so
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64) FORCE
-	$(call if_changed,vdso64ld)
+$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) FORCE
+	$(call if_changed,ld)
 
 # strip rule for the .so file
 $(obj)/%.so: OBJCOPYFLAGS := -S
@@ -50,8 +50,6 @@ $(obj-vdso64): %.o: %.S FORCE
 	$(call if_changed_dep,vdso64as)
 
 # actual build commands
-quiet_cmd_vdso64ld = VDSO64L $@
-      cmd_vdso64ld = $(CC) $(c_flags) -Wl,-T $(filter %.lds %.o,$^) -o $@
 quiet_cmd_vdso64as = VDSO64A $@
       cmd_vdso64as = $(CC) $(a_flags) -c -o $@ $<
 

base-commit: 9cb1fd0efd195590b828b9b865421ad345a4a145
-- 
2.27.0.rc0

