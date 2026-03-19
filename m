Return-Path: <linux-s390+bounces-17682-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIhbGV0HvGkArgIAu9opvQ
	(envelope-from <linux-s390+bounces-17682-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 15:25:33 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D09922CCBF6
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 15:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 014F9307EAF6
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 14:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBF1363C56;
	Thu, 19 Mar 2026 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIQrp4QN"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D13362124
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929943; cv=none; b=RtJmunYz0dWnRQ6npTbn/sA1bD/q9GhElThGK2iSHEowP3Qy+fU12iYqceIWHodfTJuMcNkKERKqQNSv4HzG4i2xxsbqOR2YQRXHr4UIOK3aoE9CnPjAudImni7qN4dvzZ3BQjwk3ZlfjP4D3wWocFHbd/SiyWAG97CXblv40eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929943; c=relaxed/simple;
	bh=5In9ocaR+6jg3LqC0+4n3Jkx7M1/roXYIwDOHJoB1Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCvfr3xKqknOaUqZvanb4h9SyXzO5NaA4wyA2KOtR+tnoYO3IULogo5oMkd+CqHHjBIwkDeuMx4zU2tiDMVEFFqy4LqU3lc+B7J/iBtG7KPkbCU3Eq1a3NZQ21zB6XyFq0p6jlgMAsOLKrBBMvEu5DOV6BC2P4nsyVI9ZwtlEyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIQrp4QN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E46C2BCF7
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773929943;
	bh=5In9ocaR+6jg3LqC0+4n3Jkx7M1/roXYIwDOHJoB1Fo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kIQrp4QNkQuQbjZ+641LKbMDnPEL9fwxWAeU4X/BRUy7aQ2WIi3Ep7+C/jWoLFfrp
	 fx6qNgsXM5f5QrhkUyUunulS754GHjIlPt7oSP3I3VgkJBBhslVNqiGskgLd49+M/O
	 vCcgvJWNji+/GKnFGsnnKFv+6k0IudruwIyp0bmDrZXBYLFDH4Cqx4WiBlLE2eO9+U
	 TvaKWmKFe6flDlLa+J01Zr7EtI2wrF10MacdNf0ajm7W1AFCKWa3NamGWtaeedFcpy
	 9ZOUIAmtI9dEnBhha2IdeNhvgN/9L0RA9zUsAp89wPDAiFQtaSKV3oOckIfVV6OKJP
	 wljJz8vLnisog==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79885f4a8ffso9694917b3.3
        for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 07:19:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRI/r5tsnxiACc0rnPdF4Y89nquAJwVSYOpwel/5nzsoV+jgYptDoEwSwUMrrxk/69kIlsMDcGXdwT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8S7/ZdKzskTQ5FksH9y+rnPUSOqM1V0r4+ZlkSsGEqptv5o8S
	YhHqAf9z4cP6P8A8UrO5q90Rghp6PzlnbE6RDp02A1sEzjZpEEMr4iTr61AMzukkuj5W2E1IFMq
	novy04uFp5bSK7o9NioQUZlS5TDDfC1A=
X-Received: by 2002:a05:690c:6e87:b0:796:3917:7291 with SMTP id
 00721157ae682-79a71cba4c8mr76329307b3.58.1773929942527; Thu, 19 Mar 2026
 07:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317082020.737779-1-ruanjinjie@huawei.com> <20260317082020.737779-8-ruanjinjie@huawei.com>
In-Reply-To: <20260317082020.737779-8-ruanjinjie@huawei.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 15:18:51 +0100
X-Gmail-Original-Message-ID: <CAD++jLnd53rOuRhWgmChdJgRGR0oNbMk2h44B=7MyU_K5bSkHw@mail.gmail.com>
X-Gm-Features: AaiRm53qjb8luXRudNPzAExMRmb-2YjIAOwzo5IV_LB42SfludlKqsGd2TH6RSA
Message-ID: <CAD++jLnd53rOuRhWgmChdJgRGR0oNbMk2h44B=7MyU_K5bSkHw@mail.gmail.com>
Subject: Re: [PATCH v13 RESEND 07/14] arm64/ptrace: Define and use _TIF_SYSCALL_EXIT_WORK
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, arnd@arndb.de, 
	peterz@infradead.org, luto@kernel.org, shuah@kernel.org, kees@kernel.org, 
	wad@chromium.org, kevin.brodsky@arm.com, deller@gmx.de, macro@orcam.me.uk, 
	akpm@linux-foundation.org, ldv@strace.io, anshuman.khandual@arm.com, 
	ryan.roberts@arm.com, mark.rutland@arm.com, thuth@redhat.com, song@kernel.org, 
	ada.coupriediaz@arm.com, broonie@kernel.org, pengcan@kylinos.cn, 
	liqiang01@kylinos.cn, ziyao@disroot.org, guanwentao@uniontech.com, 
	guoren@kernel.org, schuster.simon@siemens-energy.com, jremus@linux.ibm.com, 
	david@kernel.org, mathieu.desnoyers@efficios.com, edumazet@google.com, 
	kmal@cock.li, dvyukov@google.com, reddybalavignesh9979@gmail.com, 
	x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,redhat.com,xen0n.name,linux.ibm.com,alien8.de,linux.intel.com,zytor.com,arndb.de,infradead.org,chromium.org,gmx.de,orcam.me.uk,linux-foundation.org,strace.io,kylinos.cn,disroot.org,uniontech.com,siemens-energy.com,efficios.com,google.com,cock.li,gmail.com,lists.infradead.org,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17682-lists,linux-s390=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[54];
	TAGGED_RCPT(0.00)[linux-s390];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email,huawei.com:email]
X-Rspamd-Queue-Id: D09922CCBF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 9:20=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:

> Introduce _TIF_SYSCALL_EXIT_WORK to filter out entry-only flags
> during the syscall exit path. This aligns arm64 with the generic
> entry framework's SYSCALL_WORK_EXIT semantics.
>
> [Rationale]
> The current syscall exit path uses _TIF_SYSCALL_WORK to decide whether
> to invoke syscall_exit_work(). However, _TIF_SYSCALL_WORK includes
> flags that are only relevant during syscall entry:
>
> 1. _TIF_SECCOMP: Seccomp filtering (__secure_computing) only runs
>   on entry. There is no seccomp callback for syscall exit.
>
> 2. _TIF_SYSCALL_EMU: In PTRACE_SYSEMU mode, the syscall is
>   intercepted and skipped on entry. Since the syscall is never
>   executed, reporting a syscall exit stop is unnecessary.
>
> [Changes]
> - Define _TIF_SYSCALL_EXIT_WORK: A new mask containing only flags
>   requiring exit processing: _TIF_SYSCALL_TRACE, _TIF_SYSCALL_AUDIT,
>   and _TIF_SYSCALL_TRACEPOINT.
>
> - Update exit path: Use _TIF_SYSCALL_EXIT_WORK in
>   syscall_exit_to_user_mode_work() to avoid redundant calls to
>   audit and ptrace reporting when only entry-flags are set.
>
> - Cleanup: Remove the has_syscall_work() helper as it is no longer
>   needed. Direct flag comparison is now used to distinguish between
>   entry and exit work requirements.
>
> [Impact]
> audit_syscall_exit() and report_syscall_exit() will no longer be
> triggered for seccomp-only or emu-only syscalls. This matches the
> generic entry behavior and improves efficiency by skipping unnecessary
> exit processing.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

