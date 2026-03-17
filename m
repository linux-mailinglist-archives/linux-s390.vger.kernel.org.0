Return-Path: <linux-s390+bounces-17460-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLRLOhcPuWkaoQEAu9opvQ
	(envelope-from <linux-s390+bounces-17460-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 17 Mar 2026 09:21:43 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 925F12A580D
	for <lists+linux-s390@lfdr.de>; Tue, 17 Mar 2026 09:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B68DF3024B2F
	for <lists+linux-s390@lfdr.de>; Tue, 17 Mar 2026 08:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC16539F178;
	Tue, 17 Mar 2026 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NCDoa4G2"
X-Original-To: linux-s390@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A7739D6F1;
	Tue, 17 Mar 2026 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735627; cv=none; b=St69b3Rkopo0nXjkJOute0rEetM/rPo/L035io+z+SrxyKNXskh4GkOBxm6IbLzO86BWpqDTqL+OC92pWgcNMuQODsvMLg2l+MMfPBmN9OcIIXhTiEydnZ/zr3LHkQXE9ww9Ja7DsW9c+13Fua5Qwq+dy3NBenWXTBrdHusZuII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735627; c=relaxed/simple;
	bh=VIP7V/gOKsn1STivRJx0aK1srolqpRD3OXhwn63pD8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+zMReeYH2h6y1pVvBaAwaa9GyT17kg34bdn0WUl+IKY1q2Rm4rFevBpCWT5ZyY/BgCTsexxUOHsLIk7iwJKrksNgnNiQNbEjhTWUUN3Pad66MKGbfUGR7YEUUESLW/S+mwgL0WRjeqXg+aCbmbUdgSIqmnMmAVx5ZYX9mZYCOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NCDoa4G2; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=I6NNkRbw2LWLpgzXAiPuaUjC2UyWXUjckLSGMAm39lY=;
	b=NCDoa4G2uQ6D3NFWSpEpmYV9ySvqQk6gE7t6e530XSEinjNBnihbuwbG7y8yU1uezpo8tAhcQ
	HhbRAaiaBAdtDgdyzNRo/BtnhjBtASTlCej6yFRz4mPhWKR870Mp38uzb09BIGA/CVgo71l4BRS
	cVhVKLc5ZavT1yPd9wJpqtU=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fZlBY0VzjzmVWl;
	Tue, 17 Mar 2026 16:15:17 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id E81BE4056D;
	Tue, 17 Mar 2026 16:20:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Mar
 2026 16:20:14 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <hca@linux.ibm.com>,
	<gor@linux.ibm.com>, <agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>,
	<svens@linux.ibm.com>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
	<peterz@infradead.org>, <luto@kernel.org>, <shuah@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <kevin.brodsky@arm.com>,
	<deller@gmx.de>, <macro@orcam.me.uk>, <akpm@linux-foundation.org>,
	<ldv@strace.io>, <anshuman.khandual@arm.com>, <ryan.roberts@arm.com>,
	<mark.rutland@arm.com>, <thuth@redhat.com>, <song@kernel.org>,
	<ada.coupriediaz@arm.com>, <linusw@kernel.org>, <broonie@kernel.org>,
	<pengcan@kylinos.cn>, <liqiang01@kylinos.cn>, <ziyao@disroot.org>,
	<guanwentao@uniontech.com>, <guoren@kernel.org>,
	<schuster.simon@siemens-energy.com>, <jremus@linux.ibm.com>,
	<david@kernel.org>, <mathieu.desnoyers@efficios.com>, <edumazet@google.com>,
	<kmal@cock.li>, <dvyukov@google.com>, <reddybalavignesh9979@gmail.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-s390@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v13 RESEND 07/14] arm64/ptrace: Define and use _TIF_SYSCALL_EXIT_WORK
Date: Tue, 17 Mar 2026 16:20:13 +0800
Message-ID: <20260317082020.737779-8-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317082020.737779-1-ruanjinjie@huawei.com>
References: <20260317082020.737779-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_GT_50(0.00)[55];
	TAGGED_FROM(0.00)[bounces-17460-lists,linux-s390=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ruanjinjie@huawei.com,linux-s390@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[arm.com,kernel.org,redhat.com,xen0n.name,linux.ibm.com,alien8.de,linux.intel.com,zytor.com,arndb.de,infradead.org,chromium.org,gmx.de,orcam.me.uk,linux-foundation.org,strace.io,kylinos.cn,disroot.org,uniontech.com,siemens-energy.com,efficios.com,google.com,cock.li,gmail.com,lists.infradead.org,vger.kernel.org,lists.linux.dev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[linux-s390];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:email,huawei.com:mid,arm.com:email]
X-Rspamd-Queue-Id: 925F12A580D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce _TIF_SYSCALL_EXIT_WORK to filter out entry-only flags
during the syscall exit path. This aligns arm64 with the generic
entry framework's SYSCALL_WORK_EXIT semantics.

[Rationale]
The current syscall exit path uses _TIF_SYSCALL_WORK to decide whether
to invoke syscall_exit_work(). However, _TIF_SYSCALL_WORK includes
flags that are only relevant during syscall entry:

1. _TIF_SECCOMP: Seccomp filtering (__secure_computing) only runs
  on entry. There is no seccomp callback for syscall exit.

2. _TIF_SYSCALL_EMU: In PTRACE_SYSEMU mode, the syscall is
  intercepted and skipped on entry. Since the syscall is never
  executed, reporting a syscall exit stop is unnecessary.

[Changes]
- Define _TIF_SYSCALL_EXIT_WORK: A new mask containing only flags
  requiring exit processing: _TIF_SYSCALL_TRACE, _TIF_SYSCALL_AUDIT,
  and _TIF_SYSCALL_TRACEPOINT.

- Update exit path: Use _TIF_SYSCALL_EXIT_WORK in
  syscall_exit_to_user_mode_work() to avoid redundant calls to
  audit and ptrace reporting when only entry-flags are set.

- Cleanup: Remove the has_syscall_work() helper as it is no longer
  needed. Direct flag comparison is now used to distinguish between
  entry and exit work requirements.

[Impact]
audit_syscall_exit() and report_syscall_exit() will no longer be
triggered for seccomp-only or emu-only syscalls. This matches the
generic entry behavior and improves efficiency by skipping unnecessary
exit processing.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/syscall.h     | 5 -----
 arch/arm64/include/asm/thread_info.h | 3 +++
 arch/arm64/kernel/ptrace.c           | 2 +-
 arch/arm64/kernel/syscall.c          | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index c469d09a7964..dea392c081ca 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -120,11 +120,6 @@ static inline int syscall_get_arch(struct task_struct *task)
 	return AUDIT_ARCH_AARCH64;
 }
 
-static inline bool has_syscall_work(unsigned long flags)
-{
-	return unlikely(flags & _TIF_SYSCALL_WORK);
-}
-
 int syscall_trace_enter(struct pt_regs *regs, unsigned long flags);
 void syscall_exit_to_user_mode_work(struct pt_regs *regs);
 
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 7942478e4065..4ae83cb620bb 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -109,6 +109,9 @@ void arch_setup_new_exec(void);
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
 				 _TIF_SYSCALL_EMU)
 
+#define _TIF_SYSCALL_EXIT_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
+				 _TIF_SYSCALL_TRACEPOINT)
+
 #ifdef CONFIG_SHADOW_CALL_STACK
 #define INIT_SCS							\
 	.scs_base	= init_shadow_call_stack,			\
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 35efa2062408..3cac9668aaa8 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2471,7 +2471,7 @@ void syscall_exit_to_user_mode_work(struct pt_regs *regs)
 
 	rseq_syscall(regs);
 
-	if (has_syscall_work(flags) || flags & _TIF_SINGLESTEP)
+	if (unlikely(flags & _TIF_SYSCALL_EXIT_WORK) || flags & _TIF_SINGLESTEP)
 		syscall_exit_work(regs, flags);
 }
 
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 66d4da641d97..ec478fc37a9f 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -101,7 +101,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		return;
 	}
 
-	if (has_syscall_work(flags)) {
+	if (unlikely(flags & _TIF_SYSCALL_WORK)) {
 		/*
 		 * The de-facto standard way to skip a system call using ptrace
 		 * is to set the system call to -1 (NO_SYSCALL) and set x0 to a
-- 
2.34.1


