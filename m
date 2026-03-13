Return-Path: <linux-s390+bounces-17294-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDfGA7jds2ktcQAAu9opvQ
	(envelope-from <linux-s390+bounces-17294-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 13 Mar 2026 10:49:44 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94092280C84
	for <lists+linux-s390@lfdr.de>; Fri, 13 Mar 2026 10:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AD38306B5A1
	for <lists+linux-s390@lfdr.de>; Fri, 13 Mar 2026 09:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB71D38C408;
	Fri, 13 Mar 2026 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yBqIZEW9"
X-Original-To: linux-s390@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD8B389107;
	Fri, 13 Mar 2026 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395254; cv=none; b=gv+61MaJn7xxC+U5K768gkqqzJQPPlo0HyxqX8veZf+CJS7aSgEWbLBUZH1/qL5YPNJQ6E1n0jQYpW+m3/gnJEbs3dXaNA3KVqDLt/0vDlI8G9c4IOY9SP+HIkuKS8NoVp4uz64ox8fJY57kOXu+BxxPzJhrq9JIoS3/7JKUgtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395254; c=relaxed/simple;
	bh=6z1/3WCDlleINA85Y6p70z60dKZed+IqwEEdTcCl3PI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=By1bU7sn3AMln+Z/1VbaJS1Boc8biKZSRFPsFR+19H0z9bhv20Nbu2x1YfBcjeCvty2Xxac5sk+4wFAbFB46b32H2mIdjzpXcgRvoH8wCVaC4BkYXP+in0ljPPNYA2XDu4togrkjvFhYr+HWcldb3rhJdKaWI9kSwZiLLqo/Fcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yBqIZEW9; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WEzP5z/SdtokaYujOa6eZX4XKze4duwTwqEgtATO8ak=;
	b=yBqIZEW9LgAAaW8S+Vos0a1k5NpqTpDEAQB6i+ZPVNj/jEQkmigBZVCWwZ5VND1sPFCfCrdtO
	MNTO6IQTPbIRh5/tWcn+5dfs4YzcUb+3vmx4bpS0rCEGcUY/VykMs2MJzZj0GP1TkQKC9sG6pw6
	P/83Iiu9uA2t/p340yyARKE=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fXKK66DBkzRhVG;
	Fri, 13 Mar 2026 17:42:34 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C5624056A;
	Fri, 13 Mar 2026 17:47:30 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Mar
 2026 17:47:28 +0800
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
Subject: [PATCH v13 07/12] arm64/ptrace: Skip syscall exit reporting for PTRACE_SYSEMU_SINGLESTEP
Date: Fri, 13 Mar 2026 17:47:33 +0800
Message-ID: <20260313094738.3985794-8-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313094738.3985794-1-ruanjinjie@huawei.com>
References: <20260313094738.3985794-1-ruanjinjie@huawei.com>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[ruanjinjie@huawei.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[arm.com,kernel.org,redhat.com,linux.ibm.com,alien8.de,linux.intel.com,zytor.com,arndb.de,amacapital.net,chromium.org,rivosinc.com,orcam.me.uk,gmx.de,strace.io,kylinos.cn,gaisler.com,siemens-energy.com,suse.com,efficios.com,cock.li,google.com,linux-foundation.org,gmail.com,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17294-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[50];
	DKIM_TRACE(0.00)[huawei.com:+];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:email,huawei.com:mid,arm.com:email]
X-Rspamd-Queue-Id: 94092280C84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Align the syscall exit reporting logic with the generic entry
framework by skipping the exit stop when PTRACE_SYSEMU_SINGLESTEP is
in effect.

[Rationale]
When a tracer uses PTRACE_SYSEMU_SINGLESTEP, both _TIF_SYSCALL_EMU
and _TIF_SINGLESTEP flags are set. Currently, arm64 reports a syscall
exit stop whenever _TIF_SINGLESTEP is set, regardless of the
emulation state.

However, as per the generic entry implementation (see
include/linux/entry-common.h):
"If SYSCALL_EMU is set, then the only reason to report is when SINGLESTEP
is set (i.e. PTRACE_SYSEMU_SINGLESTEP). This syscall instruction has been
already reported in syscall_trace_enter()."

Since PTRACE_SYSEMU intercepts and skips the actual syscall
execution, reporting a subsequent exit stop is redundant and
inconsistent with the expected behavior of emulated system calls.

[Changes]
- Introduce report_single_step(): Add a helper to encapsulate the
  logic for deciding whether to report a single-step stop at syscall
  exit. It returns false if _TIF_SYSCALL_EMU is set, ensuring the
  emulated syscall does not trigger a duplicate report.

- Update syscall_exit_work(): Use the new helper to determine
  the stepping state instead of directly checking _TIF_SINGLESTEP.

[Impact]
- PTRACE_SINGLESTEP: Continues to report exit stops for actual
  instructions.

- PTRACE_SYSEMU: Continues to skip exit stops.

- PTRACE_SYSEMU_SINGLESTEP: Now correctly skips the redundant exit
  stop, aligning arm64 with the generic entry infrastructure.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/ptrace.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 3cac9668aaa8..766de3584cff 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2454,14 +2454,25 @@ int syscall_trace_enter(struct pt_regs *regs, unsigned long flags)
 	return ret ? : syscall;
 }
 
+static inline bool report_single_step(unsigned long flags)
+{
+	if (flags & _TIF_SYSCALL_EMU)
+		return false;
+
+	return flags & _TIF_SINGLESTEP;
+}
+
 static void syscall_exit_work(struct pt_regs *regs, unsigned long flags)
 {
+	bool step;
+
 	audit_syscall_exit(regs);
 
 	if (flags & _TIF_SYSCALL_TRACEPOINT)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
-	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
+	step = report_single_step(flags);
+	if (step || flags & _TIF_SYSCALL_TRACE)
 		report_syscall_exit(regs);
 }
 
-- 
2.34.1


