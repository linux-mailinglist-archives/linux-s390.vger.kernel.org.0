Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62221BF8AF
	for <lists+linux-s390@lfdr.de>; Thu, 26 Sep 2019 20:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfIZSFY (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 26 Sep 2019 14:05:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45640 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbfIZSFY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 26 Sep 2019 14:05:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id q7so1943063pgi.12
        for <linux-s390@vger.kernel.org>; Thu, 26 Sep 2019 11:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kVlu3UytET+u7KQ09fcnqnLvPl+cN9h82jlVZJfZjTo=;
        b=gU8LOxxBAqu4ZMjhqcg6B9uvdO+JQKFvVezAsT+/Z7xLV5dDBIvhPco78+OYSHATWV
         5vKgvlD1/TWtGQnwfCk7wZ0RsQP6sq6fpYz7/tPJNPScWJo/6tHPyc/NVqe/1uVViJiu
         QG4qyMvzq9mF+nTaLfsPuABbMBGU0f1v5ZdH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kVlu3UytET+u7KQ09fcnqnLvPl+cN9h82jlVZJfZjTo=;
        b=Hw2R8khJ8/WdAhxtK2G8ibm40kpdJ42ZLdqgvyXbJp7YpvEh7+Hm8LreObOUd1VUll
         vOAEeimxH8tOohepeniUXaJ9PkZDFm3LJmPCT27uAZWFaAKQvdYdLwI0d23wEvIRU77x
         OoBFojzIQMcHy+Goo5KLrPnkkjFdivqECzeniJCbkuE4QFVMg8esqUEMaYFpMGN7GwZf
         9EtNJEfzAAiHlxD1DPgv3WyYzLrkMmHAsi1cBiF0Xie+Lmz7sQxRifLEG4veJxcgs7eW
         lqynZtsTr/BYa2nuZBDTQMlTnQT1zp/f1bVMovjvU1XWropZqkN1XcsDz1dsicBgKMt5
         z1BA==
X-Gm-Message-State: APjAAAXQGlm+7IRIofNSmJ37fQdPS1JGM13ggcJT8gOVq4Ki2aztzRKg
        EBSVdVJEiPu/ZpWkkprcO58JNw==
X-Google-Smtp-Source: APXvYqzhP1wlAEJn46lkdHp/9E6c8bJo+91ZhySivB8e8kdz5lOe0JajZRG4VPh/2MGrflPoMMhIIQ==
X-Received: by 2002:a17:90a:3483:: with SMTP id p3mr4996354pjb.108.1569521123591;
        Thu, 26 Sep 2019 11:05:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 193sm3956718pfc.59.2019.09.26.11.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 11:05:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/29] vmlinux.lds.h: Replace RODATA with RO_DATA
Date:   Thu, 26 Sep 2019 10:55:44 -0700
Message-Id: <20190926175602.33098-12-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926175602.33098-1-keescook@chromium.org>
References: <20190926175602.33098-1-keescook@chromium.org>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

There's no reason to keep the RODATA macro: just replace the callers
with the expected RO_DATA macro.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/alpha/kernel/vmlinux.lds.S      | 2 +-
 arch/ia64/kernel/vmlinux.lds.S       | 2 +-
 arch/microblaze/kernel/vmlinux.lds.S | 2 +-
 arch/mips/kernel/vmlinux.lds.S       | 2 +-
 arch/um/include/asm/common.lds.S     | 2 +-
 arch/xtensa/kernel/vmlinux.lds.S     | 2 +-
 include/asm-generic/vmlinux.lds.h    | 4 +---
 7 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/alpha/kernel/vmlinux.lds.S b/arch/alpha/kernel/vmlinux.lds.S
index bf28043485f6..af411817dd7d 100644
--- a/arch/alpha/kernel/vmlinux.lds.S
+++ b/arch/alpha/kernel/vmlinux.lds.S
@@ -34,7 +34,7 @@ SECTIONS
 	swapper_pg_dir = SWAPPER_PGD;
 	_etext = .;	/* End of text section */
 
-	RODATA
+	RO_DATA(4096)
 	EXCEPTION_TABLE(16)
 
 	/* Will be freed after init */
diff --git a/arch/ia64/kernel/vmlinux.lds.S b/arch/ia64/kernel/vmlinux.lds.S
index ad3578924589..0d86fc8e88d5 100644
--- a/arch/ia64/kernel/vmlinux.lds.S
+++ b/arch/ia64/kernel/vmlinux.lds.S
@@ -104,7 +104,7 @@ SECTIONS {
 	code_continues2 : {
 	} :text
 
-	RODATA
+	RO_DATA(4096)
 
 	.opd : AT(ADDR(.opd) - LOAD_OFFSET) {
 		__start_opd = .;
diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index d008e50bb212..2299694748ea 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -51,7 +51,7 @@ SECTIONS {
 	}
 
 	. = ALIGN(16);
-	RODATA
+	RO_DATA(4096)
 	EXCEPTION_TABLE(16)
 
 	/*
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 91e566defc16..a5f00ec73ea6 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -82,7 +82,7 @@ SECTIONS
 	}
 
 	_sdata = .;			/* Start of data section */
-	RODATA
+	RO_DATA(4096)
 
 	/* writeable */
 	.data : {	/* Data */
diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index a24b284f5135..eca6c452a41b 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -9,7 +9,7 @@
   _sdata = .;
   PROVIDE (sdata = .);
 
-  RODATA
+  RO_DATA(4096)
 
   .unprotected : { *(.unprotected) }
   . = ALIGN(4096);
diff --git a/arch/xtensa/kernel/vmlinux.lds.S b/arch/xtensa/kernel/vmlinux.lds.S
index a0a843745695..b97e5798b9cf 100644
--- a/arch/xtensa/kernel/vmlinux.lds.S
+++ b/arch/xtensa/kernel/vmlinux.lds.S
@@ -124,7 +124,7 @@ SECTIONS
 
   . = ALIGN(16);
 
-  RODATA
+  RO_DATA(4096)
 
   /*  Relocation table */
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3a4c1cb971da..9520dede6c7a 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -513,9 +513,7 @@
 	. = ALIGN((align));						\
 	__end_rodata = .;
 
-/* RODATA & RO_DATA provided for backward compatibility.
- * All archs are supposed to use RO_DATA() */
-#define RODATA          RO_DATA_SECTION(4096)
+/* All archs are supposed to use RO_DATA() */
 #define RO_DATA(align)  RO_DATA_SECTION(align)
 
 /*
-- 
2.17.1

