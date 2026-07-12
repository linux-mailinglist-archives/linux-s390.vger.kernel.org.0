Return-Path: <linux-s390+bounces-22093-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ES+/MFIGVGoKhAMAu9opvQ
	(envelope-from <linux-s390+bounces-22093-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Sun, 12 Jul 2026 23:25:38 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7466A745F5B
	for <lists+linux-s390@lfdr.de>; Sun, 12 Jul 2026 23:25:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RLFHFdpF;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22093-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-22093-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55D6C300A7DE
	for <lists+linux-s390@lfdr.de>; Sun, 12 Jul 2026 21:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05A7376BC5;
	Sun, 12 Jul 2026 21:25:31 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D303769EF;
	Sun, 12 Jul 2026 21:25:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783891531; cv=none; b=hWE8rvVx9NZKgLioubjQQxCIv1shT4zK3NvTIg9vSmRCRa+sQBwapEzTzwyNsfvnujii6U/gwq0O2fDXzZkMBktLglXrspV+q3WrXx11Yqgm6/USGcyI3v2L/AXjXZ+O6VOWSfK208h/Tcx60D3d2QhzyQOm7SCJzgDex+zxtsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783891531; c=relaxed/simple;
	bh=C7H4U6sMO4YkOH5pYiIoQ+0TycDVOUBpFLeQIr+ccoo=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FvGNrbUIkMT9idBADJplqWsbSaCO80ysf+feQXegryVXTBI1AjoIU6xBopzaBYEyzTYhvE/JuyYVj9eEZ0hJWxI4kdp4aK8BVdILlkM4rvNs+zri5glZtxGa5aS/6ACSpDXYrKrSICVgGr6IX/PblbuyBSQ707OG3DdwwiTJlU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLFHFdpF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9691F000E9;
	Sun, 12 Jul 2026 21:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783891530;
	bh=3dgiu8TI4TCoeEn0bEpVdfOeeBtaQ/CqpKNHZxWnkT0=;
	h=Date:From:To:Cc:Subject:References;
	b=RLFHFdpFXUTSZm/YBrtnuBzx0Yh8fHlGCVPyr2M8hm65643btsbKADLAv6wpykm33
	 Eg0cUgOEJOfikXRmAG51l2v8MPBdeAm4aMIOyJ/i6di5f7CALzJWxWHCoNxcD6S0ah
	 FX4lwJrcKFzpB2M5EgU1/ICA5lBHJxPds5h1Jxb+KnbSYzz3UD+j9I76Mfca2WnMrL
	 l+97Kjp5ak82rCbAcIT3mOGGkVYr59ROgtUEPIgjxvkwzQUd/3aKLG8Jh+dmHXGXKQ
	 EXN1m1qE2cZM4dUpd34jLSEE6VEv5KNYMkU6dEdFEGOJLIsBjxZdcBSNxnjfoamDuS
	 GhGN8JsoJebPw==
Date: Sun, 12 Jul 2026 23:25:27 +0200
Message-ID: <20260712141346.699072205@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 x86@kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 Magnus Lindholm <linmag7@gmail.com>,
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Radu Rendec <radu@rendec.net>
Subject: [patch 3/4] entry: Make return type of syscall_trace_enter() bool
References: <20260712134433.549076055@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22093-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:msuchanek@suse.de,m:mpe@ellerman.id.au,m:sshegde@linux.ibm.com,m:linuxppc-dev@lists.ozlabs.org,m:chenhuacai@kernel.org,m:loongarch@lists.linux.dev,m:pjw@kernel.org,m:palmer@dabbelt.com,m:linux-riscv@lists.infradead.org,m:svens@linux.ibm.com,m:linux-s390@vger.kernel.org,m:x86@kernel.org,m:mark.rutland@arm.com,m:ruanjinjie@huawei.com,m:linmag7@gmail.com,m:mkchauras@gmail.com,m:corbet@lwn.net,m:radu@rendec.net,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tglx@kernel.org,linux-s390@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[suse.de,ellerman.id.au,linux.ibm.com,lists.ozlabs.org,kernel.org,lists.linux.dev,dabbelt.com,lists.infradead.org,vger.kernel.org,arm.com,huawei.com,gmail.com,lwn.net,rendec.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7466A745F5B

From: Thomas Gleixner <tglx@kernel.org>

This prepares for changing the return types of
syscall_enter_from_user_mode[_work]() to bool, which in turn separates the
decision of invoking the syscall from the syscall number, which might have
been changed in the call by ptrace, seccomp, tracing.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 include/linux/entry-common.h |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -72,7 +72,7 @@ static __always_inline long syscall_trac
 	 */
 	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
 		if (syscall_user_dispatch(regs))
-			return -1L;
+			return false;
 	}
 
 	/*
@@ -87,13 +87,13 @@ static __always_inline long syscall_trac
 	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
 		if (!arch_ptrace_report_syscall_permit_entry(regs) ||
 		    (work & SYSCALL_WORK_SYSCALL_EMU))
-			return -1L;
+			return false;
 	}
 
 	/* Do seccomp after ptrace, to catch any tracer changes. */
 	if (work & SYSCALL_WORK_SECCOMP) {
 		if (!__seccomp_permit_syscall())
-			return -1L;
+			return false;
 	}
 
 	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
@@ -102,8 +102,7 @@ static __always_inline long syscall_trac
 	if (unlikely(audit_context()))
 		syscall_enter_audit(regs);
 
-	/* Either of the above might have changed the syscall number */
-	return syscall_get_nr(current, regs);
+	return true;
 }
 
 /**
@@ -133,8 +132,13 @@ static __always_inline long syscall_ente
 {
 	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 
-	if (work & SYSCALL_WORK_ENTER)
-		syscall = syscall_trace_enter(regs, work, syscall);
+	if (work & SYSCALL_WORK_ENTER) {
+		if (!syscall_trace_enter(regs, work, syscall))
+			return -1L;
+
+		/* Reread the syscall number as it might have been modified */
+		syscall = syscall_get_nr(current, regs);
+	}
 
 	return syscall;
 }


