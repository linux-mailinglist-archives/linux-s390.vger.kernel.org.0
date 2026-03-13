Return-Path: <linux-s390+bounces-17288-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KPkGz/es2macQAAu9opvQ
	(envelope-from <linux-s390+bounces-17288-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 13 Mar 2026 10:51:59 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF02A280DB8
	for <lists+linux-s390@lfdr.de>; Fri, 13 Mar 2026 10:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43C3731F1206
	for <lists+linux-s390@lfdr.de>; Fri, 13 Mar 2026 09:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1333890F2;
	Fri, 13 Mar 2026 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zvvkMfff"
X-Original-To: linux-s390@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2579E381AF2;
	Fri, 13 Mar 2026 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395245; cv=none; b=FiovzKMiTdtVgPe6cZnRrjX2v4cLDxBFeZUaQAgWLucCZe4yqiUqxbSXiDnAUCsZ0ZvcI56QVaueJIT+iIqQzysOp3PC/2wUqZMPr5nmVbCBJ0CQHWlnvgZRjxH0ty4Inewdib8nZWMC8JB8nPmKoIRq9BTQtEu+tDKjsjq56mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395245; c=relaxed/simple;
	bh=PC8MPKy+0j88dG6m0YHbapY86SedgwhcjHHl97ED1nw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+pITzB6kh8tdTRM0r39G7WbNLS2qhIFCw0wmQOJudtgHxLBY+WUFAO/NisXuiVN/7fjqRLxWnB6cOMyoZNA1kfFUhy4o7l4D5gu1q7H14ZhNO1GfN4dSUc7jNTVn5GRY7MfVEHFIHKvLY5zmHcH+pHWDFdTMPu9j09PhDLPFMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zvvkMfff; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cZjClz0X85FauiimsTBvm71yzU+z1eB+WPKIVfy5JZQ=;
	b=zvvkMfffjRkFQeMrQXv9YrXuadrddXIMmquFLYMTryeH3MZJznmq/A/fccJTgIfmOxlcSUvZi
	1QSDGFhCPdTlpaQtqF07u1M4O6HSHPj6Rn2Vt1q89LoPOkqq9TNLNpVdWvyJcYtUJ7rplRnWDST
	vzGRMmDZKQwAWKoqxyTE/YA=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fXKJ83XJKznTWB;
	Fri, 13 Mar 2026 17:41:44 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 1BA8040565;
	Fri, 13 Mar 2026 17:47:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Mar
 2026 17:47:17 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
	<borntraeger@linux.ibm.com>, <svens@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <arnd@arndb.de>, <shuah@kernel.org>, <kees@kernel.org>,
	<luto@amacapital.net>, <wad@chromium.org>, <kevin.brodsky@arm.com>,
	<charlie@rivosinc.com>, <macro@orcam.me.uk>, <deller@gmx.de>,
	<ldv@strace.io>, <anshuman.khandual@arm.com>, <song@kernel.org>,
	<ryan.roberts@arm.com>, <mark.rutland@arm.com>, <ada.coupriediaz@arm.com>,
	<broonie@kernel.org>, <pengcan@kylinos.cn>, <liqiang01@kylinos.cn>,
	<thuth@redhat.com>, <andreas@gaisler.com>,
	<schuster.simon@siemens-energy.com>, <jremus@linux.ibm.com>,
	<jgross@suse.com>, <mathieu.desnoyers@efficios.com>, <yeoreum.yun@arm.com>,
	<kmal@cock.li>, <dvyukov@google.com>, <akpm@linux-foundation.org>,
	<reddybalavignesh9979@gmail.com>, <richard.weiyang@gmail.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v13 01/12] arm64/ptrace: Refactor syscall_trace_enter/exit() to accept flags parameter
Date: Fri, 13 Mar 2026 17:47:27 +0800
Message-ID: <20260313094738.3985794-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313094738.3985794-1-ruanjinjie@huawei.com>
References: <20260313094738.3985794-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[arm.com,kernel.org,redhat.com,linux.ibm.com,alien8.de,linux.intel.com,zytor.com,arndb.de,amacapital.net,chromium.org,rivosinc.com,orcam.me.uk,gmx.de,strace.io,kylinos.cn,gaisler.com,siemens-energy.com,suse.com,efficios.com,cock.li,google.com,linux-foundation.org,gmail.com,lists.infradead.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_FROM(0.00)[bounces-17288-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruanjinjie@huawei.com,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email,huawei.com:dkim,huawei.com:email,huawei.com:mid]
X-Rspamd-Queue-Id: EF02A280DB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Refactor syscall_trace_enter() and syscall_trace_exit() to move thread
flag reading to the caller and adopt standard helpers. This aligns
arm64's internal tracing logic with the requirements of the generic
entry framework.

[Changes]
1. Function signature changes:
   - syscall_trace_enter(regs) → syscall_trace_enter(regs, flags)
   - syscall_trace_exit(regs) → syscall_trace_exit(regs, flags)

2. Move flags reading to caller:
   - Previously: read_thread_flags() called inside each function.
   - Now: caller (like el0_svc_common) passes flags as parameter.
   - Benefit: Avoids redundant flag reading and simplifies the interface.

3. Use syscall_get_nr() helper:
   - Replace direct regs->syscallno access with
     syscall_get_nr(current, regs).
   - This helper is functionally equivalent to direct access on arm64.

4. Re-read syscall number after tracepoint:
  - Re-fetch the syscall number after trace_sys_enter() as it may have
    been modified by BPF or ftrace probes, matching generic entry behavior.

5. Update syscall.c:
   - el0_svc_common() now passes flags to tracing functions and
     re-fetches flags before exit to handle potential TIF updates.

[Why this matters]
- Aligns arm64 with the generic entry interface.
- Makes future migration to generic entry framework.
- Properly handles syscall number modifications by tracers.
- Uses standard architecture-independent helpers.

No functional changes intended.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/syscall.h |  4 ++--
 arch/arm64/kernel/ptrace.c       | 26 +++++++++++++++++---------
 arch/arm64/kernel/syscall.c      |  5 +++--
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 5e4c7fc44f73..30b203ef156b 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -120,7 +120,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 	return AUDIT_ARCH_AARCH64;
 }
 
-int syscall_trace_enter(struct pt_regs *regs);
-void syscall_trace_exit(struct pt_regs *regs);
+int syscall_trace_enter(struct pt_regs *regs, unsigned long flags);
+void syscall_trace_exit(struct pt_regs *regs, unsigned long flags);
 
 #endif	/* __ASM_SYSCALL_H */
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index ba5eab23fd90..8d296a07fbf7 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2408,9 +2408,9 @@ static void report_syscall_exit(struct pt_regs *regs)
 	}
 }
 
-int syscall_trace_enter(struct pt_regs *regs)
+int syscall_trace_enter(struct pt_regs *regs, unsigned long flags)
 {
-	unsigned long flags = read_thread_flags();
+	long syscall;
 	int ret;
 
 	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
@@ -2423,19 +2423,27 @@ int syscall_trace_enter(struct pt_regs *regs)
 	if (secure_computing() == -1)
 		return NO_SYSCALL;
 
-	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		trace_sys_enter(regs, regs->syscallno);
+	/* Either of the above might have changed the syscall number */
+	syscall = syscall_get_nr(current, regs);
 
-	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
+	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT)) {
+		trace_sys_enter(regs, syscall);
+
+		/*
+		 * Probes or BPF hooks in the tracepoint may have changed the
+		 * system call number as well.
+		 */
+		 syscall = syscall_get_nr(current, regs);
+	}
+
+	audit_syscall_entry(syscall, regs->orig_x0, regs->regs[1],
 			    regs->regs[2], regs->regs[3]);
 
-	return regs->syscallno;
+	return syscall;
 }
 
-void syscall_trace_exit(struct pt_regs *regs)
+void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
 {
-	unsigned long flags = read_thread_flags();
-
 	audit_syscall_exit(regs);
 
 	if (flags & _TIF_SYSCALL_TRACEPOINT)
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index c062badd1a56..e8fd0d60ab09 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -124,7 +124,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		 */
 		if (scno == NO_SYSCALL)
 			syscall_set_return_value(current, regs, -ENOSYS, 0);
-		scno = syscall_trace_enter(regs);
+		scno = syscall_trace_enter(regs, flags);
 		if (scno == NO_SYSCALL)
 			goto trace_exit;
 	}
@@ -143,7 +143,8 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	}
 
 trace_exit:
-	syscall_trace_exit(regs);
+	flags = read_thread_flags();
+	syscall_trace_exit(regs, flags);
 }
 
 void do_el0_svc(struct pt_regs *regs)
-- 
2.34.1


