Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10F74E8E2A
	for <lists+linux-s390@lfdr.de>; Mon, 28 Mar 2022 08:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbiC1G2z (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 28 Mar 2022 02:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiC1G2y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Mar 2022 02:28:54 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937E24E3AE;
        Sun, 27 Mar 2022 23:27:13 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KRjR33Rnjz9sSS;
        Mon, 28 Mar 2022 08:27:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TR6XdBzRQH81; Mon, 28 Mar 2022 08:27:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KRjR32Szvz9sSR;
        Mon, 28 Mar 2022 08:27:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3F9C38B76C;
        Mon, 28 Mar 2022 08:27:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LaNwMWJvjrPJ; Mon, 28 Mar 2022 08:27:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0F1168B763;
        Mon, 28 Mar 2022 08:27:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22S6R0jK086991
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 28 Mar 2022 08:27:00 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22S6QtUO086990;
        Mon, 28 Mar 2022 08:26:55 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH] livepatch: Remove klp_arch_set_pc() and asm/livepatch.h
Date:   Mon, 28 Mar 2022 08:26:48 +0200
Message-Id: <e029c7cfde436f6bbf99148ab14dc2da99add503.1648447981.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648448806; l=5338; s=20211009; h=from:subject:message-id; bh=Ly3GCtAkNGT2oW79kHKKyNL7YZGR2HnWx0D4adICxx8=; b=XJR/9U3DapYzZNiy8ayr2RO17EEiTtxk/1b/78Yf/bR6w68Nxbu3f9F6YR6mdMciz4bDGWUfJZJ7 c/sCVLhTCtQjo+bLWTKXKGqCXOAEdIl/1KmBXMQ1lMwwdCBjge/Q
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

All three versions of klp_arch_set_pc() do exactly the same: they
call ftrace_instruction_pointer_set().

Call ftrace_instruction_pointer_set() directly and remove
klp_arch_set_pc().

As klp_arch_set_pc() was the only thing remaining in asm/livepatch.h
on x86 and s390, remove asm/livepatch.h

livepatch.h remains on powerpc but its content is exclusively used
by powerpc specific code.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 MAINTAINERS                          |  2 --
 arch/powerpc/include/asm/livepatch.h | 10 +---------
 arch/powerpc/kernel/irq.c            |  1 -
 arch/powerpc/kernel/setup_64.c       |  2 +-
 arch/s390/include/asm/livepatch.h    | 22 ----------------------
 arch/x86/include/asm/livepatch.h     | 20 --------------------
 include/linux/livepatch.h            |  2 --
 kernel/livepatch/patch.c             |  2 +-
 8 files changed, 3 insertions(+), 58 deletions(-)
 delete mode 100644 arch/s390/include/asm/livepatch.h
 delete mode 100644 arch/x86/include/asm/livepatch.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ef8327aef1f..cb5f0d4a8fcc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11253,8 +11253,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.g
 F:	Documentation/ABI/testing/sysfs-kernel-livepatch
 F:	Documentation/livepatch/
 F:	arch/powerpc/include/asm/livepatch.h
-F:	arch/s390/include/asm/livepatch.h
-F:	arch/x86/include/asm/livepatch.h
 F:	include/linux/livepatch.h
 F:	kernel/livepatch/
 F:	lib/livepatch/
diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
index 1c60094ea0cd..d044a1fd4f44 100644
--- a/arch/powerpc/include/asm/livepatch.h
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -7,17 +7,9 @@
 #ifndef _ASM_POWERPC_LIVEPATCH_H
 #define _ASM_POWERPC_LIVEPATCH_H
 
-#include <linux/module.h>
-#include <linux/ftrace.h>
+#include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 
-#ifdef CONFIG_LIVEPATCH
-static inline void klp_arch_set_pc(struct ftrace_regs *fregs, unsigned long ip)
-{
-	ftrace_instruction_pointer_set(fregs, ip);
-}
-#endif /* CONFIG_LIVEPATCH */
-
 #ifdef CONFIG_LIVEPATCH_64
 static inline void klp_init_thread_info(struct task_struct *p)
 {
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 1c4715a03cd1..8c20226bcc11 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -64,7 +64,6 @@
 #include <asm/machdep.h>
 #include <asm/udbg.h>
 #include <asm/smp.h>
-#include <asm/livepatch.h>
 #include <asm/hw_irq.h>
 #include <asm/softirq_stack.h>
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index e547066a06aa..2c1e9a5ac6ca 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -59,7 +59,7 @@
 #include <asm/udbg.h>
 #include <asm/kexec.h>
 #include <asm/code-patching.h>
-#include <asm/livepatch.h>
+#include <asm/ftrace.h>
 #include <asm/opal.h>
 #include <asm/cputhreads.h>
 #include <asm/hw_irq.h>
diff --git a/arch/s390/include/asm/livepatch.h b/arch/s390/include/asm/livepatch.h
deleted file mode 100644
index 5209f223331a..000000000000
--- a/arch/s390/include/asm/livepatch.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * livepatch.h - s390-specific Kernel Live Patching Core
- *
- *  Copyright (c) 2013-2015 SUSE
- *   Authors: Jiri Kosina
- *	      Vojtech Pavlik
- *	      Jiri Slaby
- */
-
-#ifndef ASM_LIVEPATCH_H
-#define ASM_LIVEPATCH_H
-
-#include <linux/ftrace.h>
-#include <asm/ptrace.h>
-
-static inline void klp_arch_set_pc(struct ftrace_regs *fregs, unsigned long ip)
-{
-	ftrace_instruction_pointer_set(fregs, ip);
-}
-
-#endif
diff --git a/arch/x86/include/asm/livepatch.h b/arch/x86/include/asm/livepatch.h
deleted file mode 100644
index 7c5cc6660e4b..000000000000
--- a/arch/x86/include/asm/livepatch.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * livepatch.h - x86-specific Kernel Live Patching Core
- *
- * Copyright (C) 2014 Seth Jennings <sjenning@redhat.com>
- * Copyright (C) 2014 SUSE
- */
-
-#ifndef _ASM_X86_LIVEPATCH_H
-#define _ASM_X86_LIVEPATCH_H
-
-#include <asm/setup.h>
-#include <linux/ftrace.h>
-
-static inline void klp_arch_set_pc(struct ftrace_regs *fregs, unsigned long ip)
-{
-	ftrace_instruction_pointer_set(fregs, ip);
-}
-
-#endif /* _ASM_X86_LIVEPATCH_H */
diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 2614247a9781..293e29960c6e 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -16,8 +16,6 @@
 
 #if IS_ENABLED(CONFIG_LIVEPATCH)
 
-#include <asm/livepatch.h>
-
 /* task patch states */
 #define KLP_UNDEFINED	-1
 #define KLP_UNPATCHED	 0
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index c172bf92b576..4c4f5a776d80 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -118,7 +118,7 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 	if (func->nop)
 		goto unlock;
 
-	klp_arch_set_pc(fregs, (unsigned long)func->new_func);
+	ftrace_instruction_pointer_set(fregs, (unsigned long)func->new_func);
 
 unlock:
 	ftrace_test_recursion_unlock(bit);
-- 
2.35.1

