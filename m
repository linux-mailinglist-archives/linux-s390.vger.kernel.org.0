Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 564EBE9182
	for <lists+linux-s390@lfdr.de>; Tue, 29 Oct 2019 22:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfJ2VOW (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 29 Oct 2019 17:14:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45939 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729657AbfJ2VOV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 29 Oct 2019 17:14:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id y24so8286592plr.12
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 14:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MEsYo+M8tYJs19WnuB4vdd58NV32mqrr8UAWRisKZTU=;
        b=f2FbJvCtFWHO/PiUM7kk3jgX43oU4XmC9+BVH030UEoubuOC35/yq1Vxz3YIyzzX4X
         9vSX2ek3xx8SYe8xfqNt6w2OHUse3QV5HiMflSjNVd1ZV9FIFgw/svZgxkboibuub7UK
         TkhzTDzbbW0G+NnReGf7SnuowrEuVc3WK/Nrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MEsYo+M8tYJs19WnuB4vdd58NV32mqrr8UAWRisKZTU=;
        b=Fq6KqgqmabcLXXkoZDVyx0gkhXD3J4MNSPdk9JX1mTiQ0X6ufMiW3+yCkuP2w/XPMS
         NlfAz9I00rZkJntIZeEl1bZW5PTv0nO1aBtts903Lzbq8U7G1l6NyjKsgiu2Y3zzR6gj
         Auokuxvg0nkONaHnuKdHQ9mF5VVBf9R85EaFkfkmjR48WM1Pof/0+42P4H3vJK2WYBH0
         1F6Tr8wctl26GJKKskEBnM3fw01MIolo6UycKb24WfwDmiKIYcgOQyV4poPUZ998oSsX
         SVrxwsUqRhDNtQrnZtu237OdP9tpXr4qTr8gWpd+jd1zCCdKsMTQd7Xa7O2bB7vIsiYl
         ckYQ==
X-Gm-Message-State: APjAAAWeLXTSkCe5A6n9EpFYJ5WbtL8taTqkdHhmbA1tPO1pQXV6OJcD
        ymp/aEtpmYGS/3WBzAWMD9HRTA==
X-Google-Smtp-Source: APXvYqxq5RdW9havwXr/jObPzo9m9LuMSWXQx/Mt2ubHSOXQkbBFYrB/WgI2zXx68jvK7z0oHjV5OA==
X-Received: by 2002:a17:902:8b89:: with SMTP id ay9mr786046plb.234.1572383659751;
        Tue, 29 Oct 2019 14:14:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c69sm123102pga.69.2019.10.29.14.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:14:12 -0700 (PDT)
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
Subject: [PATCH v3 15/29] x86: Actually use _etext for end of text segment
Date:   Tue, 29 Oct 2019 14:13:37 -0700
Message-Id: <20191029211351.13243-16-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029211351.13243-1-keescook@chromium.org>
References: <20191029211351.13243-1-keescook@chromium.org>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Various calculations are using the end of the exception table (which
does not need to be executable) as the end of the text segment. Instead,
in preparation for moving the exception table into RO_DATA, move _etext
after the exception table and update the calculations.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/sections.h | 1 -
 arch/x86/kernel/vmlinux.lds.S   | 7 +++----
 arch/x86/mm/init_64.c           | 6 +++---
 arch/x86/mm/pti.c               | 2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 71b32f2570ab..036c360910c5 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -6,7 +6,6 @@
 #include <asm/extable.h>
 
 extern char __brk_base[], __brk_limit[];
-extern struct exception_table_entry __stop___ex_table[];
 extern char __end_rodata_aligned[];
 
 #if defined(CONFIG_X86_64)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 41362e90142d..a1a758e25b2b 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -143,15 +143,14 @@ SECTIONS
 		*(.text.__x86.indirect_thunk)
 		__indirect_thunk_end = .;
 #endif
-
-		/* End of text section */
-		_etext = .;
 	} :text = 0x9090
 
 	EXCEPTION_TABLE(16)
 
-	/* .text should occupy whole number of pages */
+	/* End of text section, which should occupy whole number of pages */
+	_etext = .;
 	. = ALIGN(PAGE_SIZE);
+
 	X86_ALIGN_RODATA_BEGIN
 	RO_DATA(PAGE_SIZE)
 	X86_ALIGN_RODATA_END
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a6b5c653727b..26299e9ce6da 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1263,7 +1263,7 @@ int kernel_set_to_readonly;
 void set_kernel_text_rw(void)
 {
 	unsigned long start = PFN_ALIGN(_text);
-	unsigned long end = PFN_ALIGN(__stop___ex_table);
+	unsigned long end = PFN_ALIGN(_etext);
 
 	if (!kernel_set_to_readonly)
 		return;
@@ -1282,7 +1282,7 @@ void set_kernel_text_rw(void)
 void set_kernel_text_ro(void)
 {
 	unsigned long start = PFN_ALIGN(_text);
-	unsigned long end = PFN_ALIGN(__stop___ex_table);
+	unsigned long end = PFN_ALIGN(_etext);
 
 	if (!kernel_set_to_readonly)
 		return;
@@ -1301,7 +1301,7 @@ void mark_rodata_ro(void)
 	unsigned long start = PFN_ALIGN(_text);
 	unsigned long rodata_start = PFN_ALIGN(__start_rodata);
 	unsigned long end = (unsigned long) &__end_rodata_hpage_align;
-	unsigned long text_end = PFN_ALIGN(&__stop___ex_table);
+	unsigned long text_end = PFN_ALIGN(&_etext);
 	unsigned long rodata_end = PFN_ALIGN(&__end_rodata);
 	unsigned long all_end;
 
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 7f2140414440..44a9f068eee0 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -574,7 +574,7 @@ static void pti_clone_kernel_text(void)
 	 */
 	unsigned long start = PFN_ALIGN(_text);
 	unsigned long end_clone  = (unsigned long)__end_rodata_aligned;
-	unsigned long end_global = PFN_ALIGN((unsigned long)__stop___ex_table);
+	unsigned long end_global = PFN_ALIGN((unsigned long)_etext);
 
 	if (!pti_kernel_image_global_ok())
 		return;
-- 
2.17.1

