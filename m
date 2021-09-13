Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AD9409FD7
	for <lists+linux-s390@lfdr.de>; Tue, 14 Sep 2021 00:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348495AbhIMWf3 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 13 Sep 2021 18:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348204AbhIMWfR (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 13 Sep 2021 18:35:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CACD26112D;
        Mon, 13 Sep 2021 22:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631572440;
        bh=O7E8E9rnE1vJn7DA9aPvIF05sMNv9dHWq5yGftVtZzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rWQwoRXRGfgwPRDIiKmjVBXwiQAQq5l6lsRKdtFRb9nw+TFJVOkgCiXF7EeFG24VR
         yOEBHq5uS2v32PIhLJknkMTRCgBHpUIOdSoiPsMjWguYRnajzB7fvgvNJkXI1lQTK3
         b4LRaTz6FcTHxSwDwWZb+2CMAuxum6qxRbkrX/LgZNtviB+0keV9tv4uGPcHz8HDSK
         Xnqh9SxZ7reXhNB43fQlNXOkQEQAvu0IuwY9rEeTfjk0VU4PQ3AFwp52RDLtbMwujB
         WdC00b9Nmcb+FBmHyvR9p2JpbOTs4EjE19pw8rgfX4UXcpSC5h19a31aBBzRtJXafz
         ZZD0OWxOxXbfw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Marco Elver <elver@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 15/25] s390/unwind: use current_frame_address() to unwind current task
Date:   Mon, 13 Sep 2021 18:33:29 -0400
Message-Id: <20210913223339.435347-15-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913223339.435347-1-sashal@kernel.org>
References: <20210913223339.435347-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 88b604263f3d6eedae0b1c2c3bbd602d1e2e8775 ]

current_stack_pointer() simply returns current value of %r15. If
current_stack_pointer() caller allocates stack (which is the case in
unwind code) %r15 points to a stack frame allocated for callees, meaning
current_stack_pointer() caller (e.g. stack_trace_save) will end up in
the stacktrace. This is not expected by stack_trace_save*() callers and
causes problems.

current_frame_address() on the other hand returns function stack frame
address, which matches %r15 upon function invocation. Using it in
get_stack_pointer() makes it more aligned with x86 implementation
(according to BACKTRACE_SELF_TEST output) and meets stack_trace_save*()
caller's expectations, notably KCSAN.

Also make sure unwind_start is always inlined.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Tested-by: Marco Elver <elver@google.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/patch.git-04dd26be3043.your-ad-here.call-01630504868-ext-6188@work.hours
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/stacktrace.h | 20 ++++++++++----------
 arch/s390/include/asm/unwind.h     |  8 ++++----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
index 3d8a4b94c620..dd00d98804ec 100644
--- a/arch/s390/include/asm/stacktrace.h
+++ b/arch/s390/include/asm/stacktrace.h
@@ -34,16 +34,6 @@ static inline bool on_stack(struct stack_info *info,
 	return addr >= info->begin && addr + len <= info->end;
 }
 
-static __always_inline unsigned long get_stack_pointer(struct task_struct *task,
-						       struct pt_regs *regs)
-{
-	if (regs)
-		return (unsigned long) kernel_stack_pointer(regs);
-	if (task == current)
-		return current_stack_pointer();
-	return (unsigned long) task->thread.ksp;
-}
-
 /*
  * Stack layout of a C stack frame.
  */
@@ -74,6 +64,16 @@ struct stack_frame {
 	((unsigned long)__builtin_frame_address(0) -			\
 	 offsetof(struct stack_frame, back_chain))
 
+static __always_inline unsigned long get_stack_pointer(struct task_struct *task,
+						       struct pt_regs *regs)
+{
+	if (regs)
+		return (unsigned long)kernel_stack_pointer(regs);
+	if (task == current)
+		return current_frame_address();
+	return (unsigned long)task->thread.ksp;
+}
+
 /*
  * To keep this simple mark register 2-6 as being changed (volatile)
  * by the called function, even though register 6 is saved/nonvolatile.
diff --git a/arch/s390/include/asm/unwind.h b/arch/s390/include/asm/unwind.h
index de9006b0cfeb..5ebf534ef753 100644
--- a/arch/s390/include/asm/unwind.h
+++ b/arch/s390/include/asm/unwind.h
@@ -55,10 +55,10 @@ static inline bool unwind_error(struct unwind_state *state)
 	return state->error;
 }
 
-static inline void unwind_start(struct unwind_state *state,
-				struct task_struct *task,
-				struct pt_regs *regs,
-				unsigned long first_frame)
+static __always_inline void unwind_start(struct unwind_state *state,
+					 struct task_struct *task,
+					 struct pt_regs *regs,
+					 unsigned long first_frame)
 {
 	task = task ?: current;
 	first_frame = first_frame ?: get_stack_pointer(task, regs);
-- 
2.30.2

