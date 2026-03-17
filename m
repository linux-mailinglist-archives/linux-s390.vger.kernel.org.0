Return-Path: <linux-s390+bounces-17457-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG8xD1wPuWkaoQEAu9opvQ
	(envelope-from <linux-s390+bounces-17457-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 17 Mar 2026 09:22:52 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBE12A58AE
	for <lists+linux-s390@lfdr.de>; Tue, 17 Mar 2026 09:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DBF33073AAA
	for <lists+linux-s390@lfdr.de>; Tue, 17 Mar 2026 08:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C597439D6DF;
	Tue, 17 Mar 2026 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HjFxAALP"
X-Original-To: linux-s390@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AB539C64E;
	Tue, 17 Mar 2026 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735624; cv=none; b=WsnPc+QpwTluw9J5UGQtUG7m1m7AeBicIgSIFDV2woVtSZfZY3zdIsGTPAwc1HtGYKURMCuy2PhH/MDDc9xCHd5wAV0BEbFVCmfePTNPWhGWgxsDOgMFfy+LJI758GA37s/Za5UY+ESH+BcWJckPlrZ8gSrTkqce+0Xp0y1mpGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735624; c=relaxed/simple;
	bh=uFVdStJqmRo7KB97x+mpX0spYL1NBEeBhooV7DPVnsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaDf1huJqMl+HLpFBsdYNyiUxxfHZH2ybnRynPnbhKc5tvAfyMKh/iJ7moDPbpPX270EFwRkeMZ48PYYtRX9ARxiV4pZymxBIAQm5EfvpJfTsMenwMnBjKss7CNpXPvxyf/idypuqw3mTFmW7Qh+nei2np1eC8D+yXHhS/mH4EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HjFxAALP; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sBX9yVD1XwVBO8/P5Xrrvv9cm0iqe1Ko3v6FFuPSOFQ=;
	b=HjFxAALPHxYUpjdG8BniAoY8E6KltAJYcQ6OfO9o1z6CuBN91Is6Oi3zT0k6mS8JZiJpohCqO
	Du8KKijUHzOPyNGzp/WiQ+OB5+rF4PAs3D5SXBorpf4u5RL/oMkYd41cmVj6P3dgYPzN1149sA8
	0zwGhWkLslJz29IiPSja+Hs=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fZl9l38d5zcbN6;
	Tue, 17 Mar 2026 16:14:35 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 994022025E;
	Tue, 17 Mar 2026 16:20:12 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Mar
 2026 16:20:10 +0800
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
Subject: [PATCH v13 RESEND 05/14] arm64: ptrace: Move rseq_syscall() before audit_syscall_exit()
Date: Tue, 17 Mar 2026 16:20:11 +0800
Message-ID: <20260317082020.737779-6-ruanjinjie@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_GT_50(0.00)[55];
	TAGGED_FROM(0.00)[bounces-17457-lists,linux-s390=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ruanjinjie@huawei.com,linux-s390@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[arm.com,kernel.org,redhat.com,xen0n.name,linux.ibm.com,alien8.de,linux.intel.com,zytor.com,arndb.de,infradead.org,chromium.org,gmx.de,orcam.me.uk,linux-foundation.org,strace.io,kylinos.cn,disroot.org,uniontech.com,siemens-energy.com,efficios.com,google.com,cock.li,gmail.com,lists.infradead.org,vger.kernel.org,lists.linux.dev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[linux-s390];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: CBBE12A58AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move the rseq_syscall() check earlier in the syscall exit path to ensure
it operates on the original instruction pointer (regs->pc) before any
potential modification by a tracer.

[Background]
When CONFIG_DEBUG_RSEQ is enabled, rseq_syscall() verifies that a system
call was not executed within an rseq critical section by examining
regs->pc. If a violation is detected, it triggers a SIGSEGV.

[Problem]
Currently, arm64 invokes rseq_syscall() after report_syscall_exit().
However, during report_syscall_exit(), a ptrace tracer can modify the
task's instruction pointer via PTRACE_SETREGS. This leads to an
inconsistency where rseq may analyze a post-trace PC instead of the
actual PC at the time of syscall exit.

[Why this matters]
The rseq check is intended to validate the execution context of the
syscall itself. Analyzing a tracer-modified PC can lead to incorrect
detection or missed violations. Moving the check earlier ensures rseq
sees the authentic state of the task.

[Alignment]
This change aligns arm64 with:
- Generic entry, which calls rseq_syscall() first.
- arm32 implementation, which also performs the check before audit.

[Impact]
There is no functional change to signal delivery; SIGSEGV will still be
processed in arm64_exit_to_user_mode() at the end of the exit path.

Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/ptrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 3cb497b2bd22..f3d3dec85828 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2456,6 +2456,8 @@ int syscall_trace_enter(struct pt_regs *regs, unsigned long flags)
 
 void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
 {
+	rseq_syscall(regs);
+
 	audit_syscall_exit(regs);
 
 	if (flags & _TIF_SYSCALL_TRACEPOINT)
@@ -2463,8 +2465,6 @@ void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
 
 	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
 		report_syscall_exit(regs);
-
-	rseq_syscall(regs);
 }
 
 /*
-- 
2.34.1


