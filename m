Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6AD3C9110
	for <lists+linux-s390@lfdr.de>; Wed, 14 Jul 2021 22:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240681AbhGNT5q (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 14 Jul 2021 15:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240953AbhGNTuO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 14 Jul 2021 15:50:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABA6861404;
        Wed, 14 Jul 2021 19:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626291982;
        bh=f3eEHGE9LlZfIcJe7uTHu8yg6F7aNQaqF870lFKtniA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pzvkfkWSeH2WVbOn8VB70y8bxra1hwtddcA4n9kPKVWjIbz0evabzhePMDcI1igtd
         tydfK/Gt+eYNIDy2obLh/l04uSEAq21eWznVo4t0kICSXjZ8oVMX56fp3XPF7Iz7nw
         xvUPF55H2gWwHSi+WUgsS79zbKCtbtS04+PLH617BvH1Twvd8CZ5jzSkWl4T00SCyq
         axqQ343EZhBujmhyOq7jIJjCOeXs7A3KhH/Q3cPJYNM2vlYXpHr2QxqwWnTi0U0wO9
         hbQ7EUS5fYg5FShv5XCmVBvyCF2b3nptOo7Vnp6YedQXOXqimWRRZjYn4KQL4lQ8YI
         BMOakVobhrdTQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 50/51] s390: introduce proper type handling call_on_stack() macro
Date:   Wed, 14 Jul 2021 15:45:12 -0400
Message-Id: <20210714194513.54827-50-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210714194513.54827-1-sashal@kernel.org>
References: <20210714194513.54827-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 41d71fe59cce41237f24f3b7bdc1b414069a34ed ]

The existing CALL_ON_STACK() macro allows for subtle bugs:

- There is no type checking of the function that is being called. That
  is: missing or too many arguments do not cause any compile error or
  warning. The same is true if the return type of the called function
  changes. This can lead to quite random bugs.

- Sign and zero extension of arguments is missing. Given that the s390
  C ABI requires that the caller of a function performs proper sign
  and zero extension this can also lead to subtle bugs.

- If arguments to the CALL_ON_STACK() macros contain functions calls
  register corruption can happen due to register asm constructs being
  used.

Therefore introduce a new call_on_stack() macro which is supposed to
fix all these problems.

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/stacktrace.h | 97 ++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
index 6836532f8d1a..e192681f83e1 100644
--- a/arch/s390/include/asm/stacktrace.h
+++ b/arch/s390/include/asm/stacktrace.h
@@ -115,6 +115,103 @@ struct stack_frame {
 	r2;								\
 })
 
+#define CALL_LARGS_0(...)						\
+	long dummy = 0
+#define CALL_LARGS_1(t1, a1)						\
+	long arg1  = (long)(t1)(a1)
+#define CALL_LARGS_2(t1, a1, t2, a2)					\
+	CALL_LARGS_1(t1, a1);						\
+	long arg2 = (long)(t2)(a2)
+#define CALL_LARGS_3(t1, a1, t2, a2, t3, a3)				\
+	CALL_LARGS_2(t1, a1, t2, a2);					\
+	long arg3 = (long)(t3)(a3)
+#define CALL_LARGS_4(t1, a1, t2, a2, t3, a3, t4, a4)			\
+	CALL_LARGS_3(t1, a1, t2, a2, t3, a3);				\
+	long arg4  = (long)(t4)(a4)
+#define CALL_LARGS_5(t1, a1, t2, a2, t3, a3, t4, a4, t5, a5)		\
+	CALL_LARGS_4(t1, a1, t2, a2, t3, a3, t4, a4);			\
+	long arg5 = (long)(t5)(a5)
+
+#define CALL_REGS_0							\
+	register long r2 asm("2") = dummy
+#define CALL_REGS_1							\
+	register long r2 asm("2") = arg1
+#define CALL_REGS_2							\
+	CALL_REGS_1;							\
+	register long r3 asm("3") = arg2
+#define CALL_REGS_3							\
+	CALL_REGS_2;							\
+	register long r4 asm("4") = arg3
+#define CALL_REGS_4							\
+	CALL_REGS_3;							\
+	register long r5 asm("5") = arg4
+#define CALL_REGS_5							\
+	CALL_REGS_4;							\
+	register long r6 asm("6") = arg5
+
+#define CALL_TYPECHECK_0(...)
+#define CALL_TYPECHECK_1(t, a, ...)					\
+	typecheck(t, a)
+#define CALL_TYPECHECK_2(t, a, ...)					\
+	CALL_TYPECHECK_1(__VA_ARGS__);					\
+	typecheck(t, a)
+#define CALL_TYPECHECK_3(t, a, ...)					\
+	CALL_TYPECHECK_2(__VA_ARGS__);					\
+	typecheck(t, a)
+#define CALL_TYPECHECK_4(t, a, ...)					\
+	CALL_TYPECHECK_3(__VA_ARGS__);					\
+	typecheck(t, a)
+#define CALL_TYPECHECK_5(t, a, ...)					\
+	CALL_TYPECHECK_4(__VA_ARGS__);					\
+	typecheck(t, a)
+
+#define CALL_PARM_0(...) void
+#define CALL_PARM_1(t, a, ...) t
+#define CALL_PARM_2(t, a, ...) t, CALL_PARM_1(__VA_ARGS__)
+#define CALL_PARM_3(t, a, ...) t, CALL_PARM_2(__VA_ARGS__)
+#define CALL_PARM_4(t, a, ...) t, CALL_PARM_3(__VA_ARGS__)
+#define CALL_PARM_5(t, a, ...) t, CALL_PARM_4(__VA_ARGS__)
+#define CALL_PARM_6(t, a, ...) t, CALL_PARM_5(__VA_ARGS__)
+
+/*
+ * Use call_on_stack() to call a function switching to a specified
+ * stack. Proper sign and zero extension of function arguments is
+ * done. Usage:
+ *
+ * rc = call_on_stack(nr, stack, rettype, fn, t1, a1, t2, a2, ...)
+ *
+ * - nr specifies the number of function arguments of fn.
+ * - stack specifies the stack to be used.
+ * - fn is the function to be called.
+ * - rettype is the return type of fn.
+ * - t1, a1, ... are pairs, where t1 must match the type of the first
+ *   argument of fn, t2 the second, etc. a1 is the corresponding
+ *   first function argument (not name), etc.
+ */
+#define call_on_stack(nr, stack, rettype, fn, ...)			\
+({									\
+	rettype (*__fn)(CALL_PARM_##nr(__VA_ARGS__)) = fn;		\
+	unsigned long frame = current_frame_address();			\
+	unsigned long __stack = stack;					\
+	unsigned long prev;						\
+	CALL_LARGS_##nr(__VA_ARGS__);					\
+	CALL_REGS_##nr;							\
+									\
+	CALL_TYPECHECK_##nr(__VA_ARGS__);				\
+	asm volatile(							\
+		"	lgr	%[_prev],15\n"				\
+		"	lg	15,%[_stack]\n"				\
+		"	stg	%[_frame],%[_bc](15)\n"			\
+		"	brasl	14,%[_fn]\n"				\
+		"	lgr	15,%[_prev]\n"				\
+		: [_prev] "=&d" (prev), CALL_FMT_##nr			\
+		: [_stack] "R" (__stack),				\
+		  [_bc] "i" (offsetof(struct stack_frame, back_chain)),	\
+		  [_frame] "d" (frame),					\
+		  [_fn] "X" (__fn) : CALL_CLOBBER_##nr);		\
+	(rettype)r2;							\
+})
+
 #define CALL_ON_STACK_NORETURN(fn, stack)				\
 ({									\
 	asm volatile(							\
-- 
2.30.2

