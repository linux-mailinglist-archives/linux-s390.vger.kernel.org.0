Return-Path: <linux-s390+bounces-22331-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H/2ZKl+XV2pXXgAAu9opvQ
	(envelope-from <linux-s390+bounces-22331-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 15 Jul 2026 16:21:19 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E19CB75F4D8
	for <lists+linux-s390@lfdr.de>; Wed, 15 Jul 2026 16:21:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=k1GNVa0D;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22331-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-22331-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B511B3242505
	for <lists+linux-s390@lfdr.de>; Wed, 15 Jul 2026 14:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4461832B9A8;
	Wed, 15 Jul 2026 14:10:56 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A23749E2
	for <linux-s390@vger.kernel.org>; Wed, 15 Jul 2026 14:10:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124656; cv=none; b=bUTjQAxnIEB8LBon/vOUYPdfo4X6A+faY8cMfmbaDlVcx+69GDAtiyehtOBWhQ/BuHETXmBY1CAjmhb3UdUZ0iLFq35dm3xrQILYQqhDqXKHEfm1A+UyxVBU1Rr6YEEwz7Z5DyCnuomsi2Ldx3vS9CZNFJNtSFsayTvnasQntfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124656; c=relaxed/simple;
	bh=AC+Thx7d2CMlbLdMeZfWw80m1lZG9KgXCFN1PkSTmkM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qVGufr63Ue00N8DuB4xB6p0NIF0FpSk70qzmfV5HA2bE2HajHGdGDgsEiQe7x3f9PtF5piKixSkxjTodlbj5QLXrxQqmohG7uexlZjkW4B7PqA6Z3FLvlp8HR3vppAeTedq0R1+3HtlM9XfGuV5xrWBf0cDHY7H6ykJVPpbEDWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1GNVa0D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCB61F00A3A;
	Wed, 15 Jul 2026 14:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784124654;
	bh=h9bMTc3xKk5y8qPvP0Y290GABHc9ZsoqItc8ojiXP2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k1GNVa0D+TPz5sTxl2MVrsaA5wzgbGUyJ1IioUD9Ljeb2o1kn57GBxsdWOydTdx4u
	 s420oBVSkapMWrbpuxzxYLikO60BcuQ7tDutUgW1tntsbyj95A/REWmv9ZNwFiJyMc
	 6XPgx4qxwcPs6bGEmNjFdLep/vPCBKr95a8ay5kfvmy7o+bVxqCPAwtnrezUWMSu77
	 FcV1fa4Gr8eChWTciFDd81EVcVqnhS56VTdhnvqN8fFXSd1n4Qaep0NZIM6Ptp8vvI
	 Gec+YYg+BAl4LLGCAUrrP7uD0bqSuu0BkUghWnr0hvlfiL1MSBYSCg/Ze+GTB3zSPK
	 tJsO1TbZrTD7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] s390/syscall: Keep syscall number in extra ptregs
 member
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sven Schnelle" <svens@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260715133830.2619853-3-svens@linux.ibm.com>
References: <20260715133830.2619853-1-svens@linux.ibm.com>
 <20260715133830.2619853-3-svens@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:10:53 +0000
Message-Id: <20260715141054.0FCB61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22331-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:svens@linux.ibm.com,m:hca@linux.ibm.com,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E19CB75F4D8
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Syscall restarts for system calls invoked via the `EXECUTE` instru=
ction will rewind the instruction pointer by the wrong amount, causing exec=
ution corruption.
- [High] The patch breaks the ptrace `NT_S390_SYSTEM_CALL` regset ABI by om=
itting the instruction length data.
- [High] The syscall number loaded from `%r1` is no longer truncated to 16 =
bits, allowing arbitrary garbage in the upper bits to cause valid syscalls =
to fail.
--

--- Patch [2]: [PATCH 2/2] s390/syscall: Keep syscall number in extra ptreg=
s member ---
commit 1c7e9df362bfdaa075e7114b5570a63dc6c4e073
Author: Sven Schnelle <svens@linux.ibm.com>

s390/syscall: Keep syscall number in extra ptregs member
   =20
Move the syscall number from ptregs::int_code to another union member
called syscall_nr. This simplifies the code a bit.

> diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
> index 4874de5edea0a..c3c69294ff330 100644
> --- a/arch/s390/kernel/signal.c
> +++ b/arch/s390/kernel/signal.c
> @@ -447,12 +447,12 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
>  	 * call information.
>  	 */
>  	current->thread.system_call =3D
> -		test_pt_regs_flag(regs, PIF_SYSCALL) ? regs->int_code : 0;
> +		test_pt_regs_flag(regs, PIF_SYSCALL) ? regs->syscall_nr : 0;

[Severity: High]
Does this break the ptrace NT_S390_SYSTEM_CALL regset ABI?

Previously, thread.system_call stored both the syscall number and the
instruction length code (ILC) in the upper 16 bits, which userspace tools=20
like CRIU depend on to correctly restart syscalls.

By saving only regs->syscall_nr, it appears the instruction length data is
dropped.

> =20
>  	if (get_signal(&ksig)) {
>  		/* Whee!  Actually deliver the signal.  */
>  		if (current->thread.system_call) {
> -			regs->int_code =3D current->thread.system_call;
> +			regs->syscall_nr =3D current->thread.system_call;
>  			/* Check for system call restarting. */
>  			switch (regs->gprs[2]) {

[ ... ]

> @@ -467,9 +467,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
>  				fallthrough;
>  			case -ERESTARTNOINTR:
>  				regs->gprs[2] =3D regs->orig_gpr2;
> -				regs->psw.addr =3D
> -					__rewind_psw(regs->psw,
> -						     regs->int_code >> 16);
> +				regs->psw.addr =3D __rewind_psw(regs->psw, SVC_LEN);

[Severity: High]
Is it safe to rewind the PSW address by a hardcoded SVC_LEN (2 bytes) here?

If a user-space application invokes a restartable syscall using the EXECUTE
instruction, the dynamic instruction length is 4 or 6 bytes.=20

Because the hardware ILC is no longer used to determine the rewind length,
could resuming userspace result in execution corruption or a SIGILL by
resuming in the middle of the EXECUTE instruction?

>  				break;
>  			}
>  		}

[ ... ]

> @@ -498,7 +496,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
>  		case -ERESTARTSYS:
>  		case -ERESTARTNOINTR:
>  			regs->gprs[2] =3D regs->orig_gpr2;
> -			regs->psw.addr =3D __rewind_psw(regs->psw, regs->int_code >> 16);
> +			regs->psw.addr =3D __rewind_psw(regs->psw, SVC_LEN);

[Severity: High]
This seems to have the same hardcoded SVC_LEN issue as above when restarting
syscalls on the alternative restart path. Could this also cause execution
corruption if the syscall was invoked via EXECUTE?

>  			if (test_thread_flag(TIF_SINGLE_STEP))
>  				clear_thread_flag(TIF_PER_TRAP);
>  			break;

[ ... ]

> diff --git a/arch/s390/kernel/syscall.c b/arch/s390/kernel/syscall.c
> index ce244dceec6dc..62e283ffef373 100644
> --- a/arch/s390/kernel/syscall.c
> +++ b/arch/s390/kernel/syscall.c
> @@ -100,7 +100,10 @@ void noinstr __do_syscall(struct pt_regs *regs, int =
per_trap)
>  	enter_from_user_mode(regs);
>  	add_random_kstack_offset();
>  	regs->psw =3D get_lowcore()->svc_old_psw;
> -	regs->int_code =3D get_lowcore()->svc_int_code;
> +	nr =3D get_lowcore()->svc_int_code & 0xffff;
> +	if (likely(!nr))
> +		nr =3D regs->gprs[1];
> +	regs->syscall_nr =3D nr;

[Severity: High]
Does this assignment need to truncate the value read from regs->gprs[1] to
16 bits?

If a 31-bit compat application, or a 64-bit application leaves garbage in
the upper 32 bits of register %r1 and issues a syscall with SVC number 0, nr
will include that garbage.=20

Could this cause the subsequent bounds check on nr in __do_syscall() to
fail, returning -ENOSYS for an otherwise valid syscall?

>  	update_timer_sys();
>  	if (cpu_has_bear())
>  		current->thread.last_break =3D regs->last_break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715133830.2619=
853-1-svens@linux.ibm.com?part=3D2

