Return-Path: <linux-s390+bounces-4041-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100D88D11C3
	for <lists+linux-s390@lfdr.de>; Tue, 28 May 2024 04:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3853FB22DFC
	for <lists+linux-s390@lfdr.de>; Tue, 28 May 2024 02:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CFA17580;
	Tue, 28 May 2024 02:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Axvz5ywf"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478AE4436E;
	Tue, 28 May 2024 02:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862733; cv=none; b=dyFKa2AM7afMzy67o4W/C4xt0ypsOlEGDLsJbLKssWWHERksxftqW9W7hX0XforTzTu97Et9Uikafi4xdjJXGbpKM8knTyPc++VWGYAnykhxjc6zPwurGPuvPJi0/1f8iJh39ZD+wfR/IRT28+vxD2+uM4Y/2ZrUdm+TThR7ReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862733; c=relaxed/simple;
	bh=lA8NtYKtmK3cU7OzJId506XmthIl4+Xkz0k+EAhBp88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0ty7aRlzPH3PobEnmIDAR2+pbd8TiJo1L3B+NquXXN2I7SYZyFsjPCDpJDv8ImINfVWi4qA4bcxOHAHTYAwfNmwTJ+k6URZj7h2uuVvAyiyMkQgFgXLrFM7u1J7IYifOkmc92ecKoy8VekSMM0H4gSUUHEvNCR4wpt7O8IfgbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Axvz5ywf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B045C32782;
	Tue, 28 May 2024 02:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716862732;
	bh=lA8NtYKtmK3cU7OzJId506XmthIl4+Xkz0k+EAhBp88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Axvz5ywfvv5NCCeWiNd4DctfJCA0vjaT485oNWPEQKjVqj0Y2+3+36tWY0sBG2ad2
	 OLAzvC9jRTUbWifS1heZBpzhnAyovbATXzNZI+IturryiEU4Ya0NLkOMbvVxOCxcv7
	 iftnDNda/gOyLih5LkWt6dtQe6uz++kwoqVj/eVksdrsB9b7MaGjzMsmOHjGgrekLD
	 qgJwezvdf2yiPvnALMJZGZIczT99F7OFi5CGpPu0o7pCr/hplaeUAJdVMcKZA4M1Qx
	 1rhSbhpeRCEJX9YYcX5YqzUPNwZFufKX948Y6k6lzoUWh+sv2XCaFMLb1CWgqgecyz
	 ctiu/mRuFJ2uQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	jejb@parisc-linux.org,
	deller@gmx.de,
	benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au,
	palmer@sifive.com,
	aou@eecs.berkeley.edu,
	schwidefsky@de.ibm.com,
	heiko.carstens@de.ibm.com,
	tglx@linutronix.de,
	bp@alien8.de,
	x86@kernel.org,
	naveen.n.rao@linux.vnet.ibm.com,
	anil.s.keshavamurthy@intel.com,
	davem@davemloft.net,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 4/4] kprobe/ftrace: bail out if ftrace was killed
Date: Mon, 27 May 2024 22:18:39 -0400
Message-ID: <20240528021840.3905128-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528021840.3905128-1-sashal@kernel.org>
References: <20240528021840.3905128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
Content-Transfer-Encoding: 8bit

From: Stephen Brennan <stephen.s.brennan@oracle.com>

[ Upstream commit 1a7d0890dd4a502a202aaec792a6c04e6e049547 ]

If an error happens in ftrace, ftrace_kill() will prevent disarming
kprobes. Eventually, the ftrace_ops associated with the kprobes will be
freed, yet the kprobes will still be active, and when triggered, they
will use the freed memory, likely resulting in a page fault and panic.

This behavior can be reproduced quite easily, by creating a kprobe and
then triggering a ftrace_kill(). For simplicity, we can simulate an
ftrace error with a kernel module like [1]:

[1]: https://github.com/brenns10/kernel_stuff/tree/master/ftrace_killer

  sudo perf probe --add commit_creds
  sudo perf trace -e probe:commit_creds
  # In another terminal
  make
  sudo insmod ftrace_killer.ko  # calls ftrace_kill(), simulating bug
  # Back to perf terminal
  # ctrl-c
  sudo perf probe --del commit_creds

After a short period, a page fault and panic would occur as the kprobe
continues to execute and uses the freed ftrace_ops. While ftrace_kill()
is supposed to be used only in extreme circumstances, it is invoked in
FTRACE_WARN_ON() and so there are many places where an unexpected bug
could be triggered, yet the system may continue operating, possibly
without the administrator noticing. If ftrace_kill() does not panic the
system, then we should do everything we can to continue operating,
rather than leave a ticking time bomb.

Link: https://lore.kernel.org/all/20240501162956.229427-1-stephen.s.brennan@oracle.com/

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/kernel/probes/ftrace.c     | 3 +++
 arch/loongarch/kernel/ftrace_dyn.c   | 3 +++
 arch/parisc/kernel/ftrace.c          | 3 +++
 arch/powerpc/kernel/kprobes-ftrace.c | 3 +++
 arch/riscv/kernel/probes/ftrace.c    | 3 +++
 arch/s390/kernel/ftrace.c            | 3 +++
 arch/x86/kernel/kprobes/ftrace.c     | 3 +++
 include/linux/kprobes.h              | 7 +++++++
 kernel/kprobes.c                     | 6 ++++++
 kernel/trace/ftrace.c                | 1 +
 10 files changed, 35 insertions(+)

diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
index 834cffcfbce32..7ba4b98076de1 100644
--- a/arch/csky/kernel/probes/ftrace.c
+++ b/arch/csky/kernel/probes/ftrace.c
@@ -12,6 +12,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	struct kprobe_ctlblk *kcb;
 	struct pt_regs *regs;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index 73858c9029cc9..bff058317062e 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -287,6 +287,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	struct kprobe *p;
 	struct kprobe_ctlblk *kcb;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index 621a4b386ae4f..c91f9c2e61ed2 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -206,6 +206,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	struct kprobe *p;
 	int bit;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
index 072ebe7f290ba..f8208c027148f 100644
--- a/arch/powerpc/kernel/kprobes-ftrace.c
+++ b/arch/powerpc/kernel/kprobes-ftrace.c
@@ -21,6 +21,9 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
 	struct pt_regs *regs;
 	int bit;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(nip, parent_nip);
 	if (bit < 0)
 		return;
diff --git a/arch/riscv/kernel/probes/ftrace.c b/arch/riscv/kernel/probes/ftrace.c
index 7142ec42e889f..a69dfa610aa85 100644
--- a/arch/riscv/kernel/probes/ftrace.c
+++ b/arch/riscv/kernel/probes/ftrace.c
@@ -11,6 +11,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	struct kprobe_ctlblk *kcb;
 	int bit;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index c46381ea04ecb..7f6f8c438c265 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -296,6 +296,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	struct kprobe *p;
 	int bit;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index dd2ec14adb77b..15af7e98e161a 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -21,6 +21,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	struct kprobe_ctlblk *kcb;
 	int bit;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 0ff44d6633e33..5fcbc254d1864 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -378,11 +378,15 @@ static inline void wait_for_kprobe_optimizer(void) { }
 extern void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 				  struct ftrace_ops *ops, struct ftrace_regs *fregs);
 extern int arch_prepare_kprobe_ftrace(struct kprobe *p);
+/* Set when ftrace has been killed: kprobes on ftrace must be disabled for safety */
+extern bool kprobe_ftrace_disabled __read_mostly;
+extern void kprobe_ftrace_kill(void);
 #else
 static inline int arch_prepare_kprobe_ftrace(struct kprobe *p)
 {
 	return -EINVAL;
 }
+static inline void kprobe_ftrace_kill(void) {}
 #endif /* CONFIG_KPROBES_ON_FTRACE */
 
 /* Get the kprobe at this addr (if any) - called with preemption disabled */
@@ -495,6 +499,9 @@ static inline void kprobe_flush_task(struct task_struct *tk)
 static inline void kprobe_free_init_mem(void)
 {
 }
+static inline void kprobe_ftrace_kill(void)
+{
+}
 static inline int disable_kprobe(struct kprobe *kp)
 {
 	return -EOPNOTSUPP;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 65adc815fc6e6..166ebf81dc450 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1068,6 +1068,7 @@ static struct ftrace_ops kprobe_ipmodify_ops __read_mostly = {
 
 static int kprobe_ipmodify_enabled;
 static int kprobe_ftrace_enabled;
+bool kprobe_ftrace_disabled;
 
 static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 			       int *cnt)
@@ -1136,6 +1137,11 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
 		ipmodify ? &kprobe_ipmodify_ops : &kprobe_ftrace_ops,
 		ipmodify ? &kprobe_ipmodify_enabled : &kprobe_ftrace_enabled);
 }
+
+void kprobe_ftrace_kill()
+{
+	kprobe_ftrace_disabled = true;
+}
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
 static inline int arm_kprobe_ftrace(struct kprobe *p)
 {
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 83ba342aef31f..4bdaed40e30d0 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7892,6 +7892,7 @@ void ftrace_kill(void)
 	ftrace_disabled = 1;
 	ftrace_enabled = 0;
 	ftrace_trace_function = ftrace_stub;
+	kprobe_ftrace_kill();
 }
 
 /**
-- 
2.43.0


