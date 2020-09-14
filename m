Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37BD269034
	for <lists+linux-s390@lfdr.de>; Mon, 14 Sep 2020 17:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgINPkI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 14 Sep 2020 11:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgINPjx (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Sep 2020 11:39:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69386217BA;
        Mon, 14 Sep 2020 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600097993;
        bh=6M1OqRToiUTgnMl/vPaO+DwRv+FUZXkQrwMS6mXs/VE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z6apreYpZ7cth9nEtb/BMxH3V07tNTMp3Jo5Iv7jRTWllncpv71FKeWzAvab4263P
         MwTJGbZnl04jSRe24D5hJwMxa6Y//dlq5XU+M0aXtWx424GAopVEDqwKM8dYJFi6om
         aGNzL3V2yd0k5k9xAKn1BhmHuE4FJqcaUAXvZmDs=
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 3/3] arm64: stacktrace: Convert to ARCH_STACKWALK
Date:   Mon, 14 Sep 2020 16:34:09 +0100
Message-Id: <20200914153409.25097-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914153409.25097-1-broonie@kernel.org>
References: <20200914153409.25097-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Historically architectures have had duplicated code in their stack trace
implementations for filtering what gets traced. In order to avoid this
duplication some generic code has been provided using a new interface
arch_stack_walk(), enabled by selecting ARCH_STACKWALK in Kconfig, which
factors all this out into the generic stack trace code. Convert arm64
to use this common infrastructure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/Kconfig             |  1 +
 arch/arm64/kernel/stacktrace.c | 79 +++++-----------------------------
 2 files changed, 11 insertions(+), 69 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..d1ba52e4b976 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -29,6 +29,7 @@ config ARM64
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
+	select ARCH_STACKWALK
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 05eaba21fd46..804d076b02cb 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -133,82 +133,23 @@ void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 NOKPROBE_SYMBOL(walk_stackframe);
 
 #ifdef CONFIG_STACKTRACE
-struct stack_trace_data {
-	struct stack_trace *trace;
-	unsigned int no_sched_functions;
-	unsigned int skip;
-};
 
-static bool save_trace(void *d, unsigned long addr)
+void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
+		     struct task_struct *task, struct pt_regs *regs)
 {
-	struct stack_trace_data *data = d;
-	struct stack_trace *trace = data->trace;
-
-	if (data->no_sched_functions && in_sched_functions(addr))
-		return false;
-	if (data->skip) {
-		data->skip--;
-		return false;
-	}
-
-	trace->entries[trace->nr_entries++] = addr;
-
-	return trace->nr_entries >= trace->max_entries;
-}
-
-void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
-{
-	struct stack_trace_data data;
-	struct stackframe frame;
-
-	data.trace = trace;
-	data.skip = trace->skip;
-	data.no_sched_functions = 0;
-
-	start_backtrace(&frame, regs->regs[29], regs->pc);
-	walk_stackframe(current, &frame, save_trace, &data);
-}
-EXPORT_SYMBOL_GPL(save_stack_trace_regs);
-
-static noinline void __save_stack_trace(struct task_struct *tsk,
-	struct stack_trace *trace, unsigned int nosched)
-{
-	struct stack_trace_data data;
 	struct stackframe frame;
 
-	if (!try_get_task_stack(tsk))
-		return;
-
-	data.trace = trace;
-	data.skip = trace->skip;
-	data.no_sched_functions = nosched;
-
-	if (tsk != current) {
-		start_backtrace(&frame, thread_saved_fp(tsk),
-				thread_saved_pc(tsk));
-	} else {
-		/* We don't want this function nor the caller */
-		data.skip += 2;
+	if (regs)
+		start_backtrace(&frame, regs->regs[29], regs->pc);
+	else if (task == current)
 		start_backtrace(&frame,
 				(unsigned long)__builtin_frame_address(0),
-				(unsigned long)__save_stack_trace);
-	}
-
-	walk_stackframe(tsk, &frame, save_trace, &data);
+				(unsigned long)arch_stack_walk);
+	else
+		start_backtrace(&frame, thread_saved_fp(task),
+				thread_saved_pc(task));
 
-	put_task_stack(tsk);
-}
-
-void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
-{
-	__save_stack_trace(tsk, trace, 1);
-}
-EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
-
-void save_stack_trace(struct stack_trace *trace)
-{
-	__save_stack_trace(current, trace, 0);
+	walk_stackframe(task, &frame, consume_entry, cookie);
 }
 
-EXPORT_SYMBOL_GPL(save_stack_trace);
 #endif
-- 
2.20.1

