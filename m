Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E17B8E91D5
	for <lists+linux-s390@lfdr.de>; Tue, 29 Oct 2019 22:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfJ2VUi (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 29 Oct 2019 17:20:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34834 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbfJ2VUi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 29 Oct 2019 17:20:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id x6so4267387pln.2
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 14:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NdxCafKKRqXAoKJS3a+7E7MX2efPsfhraTr7Vwa5zkA=;
        b=hhCoQlU/RqWYXSDAgYDtKFJXYKcb6qrbw7jBqPb2fpXCNS/P4SloLxb2oxafKyWrIF
         GX2Ot3WmEW9lQeaBfn0szm1nDvHZNofcDLvnvXdaDntDWUzpodPTd3ih+raPbjPXxcxM
         WgkYtZ3rXDIzN73cHQs6xO88GMbYTnIRrCvGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NdxCafKKRqXAoKJS3a+7E7MX2efPsfhraTr7Vwa5zkA=;
        b=EoguJlOIPy7znYa5/jhnzZBr0ZZ0LkLbm1wZQAUwe9cHnaci+TKVBNBvarbZMn+/jc
         eNKeudmmuc+1SnLTlVVrZ7ovisSsUgxXEJfGdlVfZycdaP7AYVK5KZN+P5AolFwZQz/I
         i9kYPy4lNEI0ril0sdRUzfbguvs0bXjywO+BZRoXDDsFQpAoKt/7kJoCqIDPiDnJIFN9
         zROeqK2dRFyG6bJZnBOQxho9vLpP/6H3W4a6tHfkHXkqwJo2hEd3Rltv1BaqZS4T7hAg
         /pMMUYA10YM6aOHmAJFnBkYLV4FALpVApmCuI+seDp50smFuDhvihw9sN+Tv7x2bPpNb
         njAQ==
X-Gm-Message-State: APjAAAVsNZTQTtNx5SVDdkpnxlDGzo8OYIARgF/iZG6r3czdaHHlRGyp
        ffM39owlRKs41Wb7vv4el8mtVQ==
X-Google-Smtp-Source: APXvYqxq7MA+00PHoEN1PSXXlIGJme1iQdbf14Kx3IMK7u8g4eayCObjCuHqRWWMsmJ4J2bnyVMPWQ==
X-Received: by 2002:a17:902:d90f:: with SMTP id c15mr751124plz.157.1572384037729;
        Tue, 29 Oct 2019 14:20:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c9sm41937pfb.114.2019.10.29.14.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:20:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH v3 11/29] vmlinux.lds.h: Replace RODATA with RO_DATA
Date:   Tue, 29 Oct 2019 14:13:33 -0700
Message-Id: <20191029211351.13243-12-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029211351.13243-1-keescook@chromium.org>
References: <20191029211351.13243-1-keescook@chromium.org>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

There's no reason to keep the RODATA macro: replace the callers with
the expected RO_DATA macro.

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
index fae077595756..11d5115bc44d 100644
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
index 91aca356095f..7145ce699982 100644
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
index dc3390ec6b60..a0a989fbe411 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -518,9 +518,7 @@
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

