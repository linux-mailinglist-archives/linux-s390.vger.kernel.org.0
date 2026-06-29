Return-Path: <linux-s390+bounces-21310-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id svscFTN6Qmql8AkAu9opvQ
	(envelope-from <linux-s390+bounces-21310-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 29 Jun 2026 15:59:15 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A374F6DBA6C
	for <lists+linux-s390@lfdr.de>; Mon, 29 Jun 2026 15:59:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VL9xL6v4;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21310-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21310-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C048B329C0E1
	for <lists+linux-s390@lfdr.de>; Mon, 29 Jun 2026 13:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9229237F8A5;
	Mon, 29 Jun 2026 13:29:15 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783A83F8243
	for <linux-s390@vger.kernel.org>; Mon, 29 Jun 2026 13:29:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739755; cv=none; b=A944CJQaP5fQmaxTRYNVkmTJNHT+lQ97oh3k4rCY3ST/OL4Me7idoBdvzo9wo6R31tGbmJAizXvvU6fOQKF8aqy+haEHSg4ZsU1J2OXysAW1+Ts38uuiRnE9vgE3mcsQEIdbMkQfrQhuFhetYmiQ1oeSCd/Df4A0ryzr588M7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739755; c=relaxed/simple;
	bh=AXfa5eUCN3paeO0DJLfWAbwKIGNTLTsR8GRieXrbu9Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZJ+5kdWmEcE1KCoVgwErRDShev6U1NZsVJlt94E60tTnfVpn3l0I/xdfeQTaaY2KKUL4A90nNLPGL+lpkx+JkIK/Bda2jZTMdJ2hj40VJnTbprZEXl59Mt2203J5TOnbxJTXNcPG+MkHn3QgBozPP4QsWKmStyhqDYCRxuLdcds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VL9xL6v4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1135C1F000E9;
	Mon, 29 Jun 2026 13:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782739754;
	bh=acilWKtvVhPAvPEe1NRKVs7FqN7+ESESCD3vgUrc5FU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VL9xL6v4p1MbeUgQlAbsV6wcqTZDt1H7H0G49cJH36eBZRBd/nAuQPiKLtp0tRrG9
	 VsZh9qLoCM5+Smj4XqanK/p+5MK/BBQRuChBeankuLaed5Y1FrMsbpcE/5Uit5Jcvi
	 Ztr2PH0cmeksVFUlz7Pb0imaY36ZWHsuODLQg8WUuFoKT0oJxETBVunXPN7dznEiNy
	 Jt2FPDqawyRP3A3lcNrEtzVKkKz7c0e/9Vft/dM6XCNY1niYnt5rA7v1wVACn0/XRk
	 MZHU3fRlPqgF4KiXRlSmZ5sMV1HDTIKxAszQs7aE8ZRyWRgp4wQ4ix55TQyvb+EtSr
	 k/TtaZ8tBGx2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 05/18] arm64: ptrace: Expand secure_computing() in
 place
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinjie Ruan" <ruanjinjie@huawei.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260629130616.642022-6-ruanjinjie@huawei.com>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-6-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 13:29:13 +0000
Message-Id: <20260629132914.1135C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21310-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ruanjinjie@huawei.com,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A374F6DBA6C

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Open-coding the seccomp check using a cached `flags` variable crea=
tes a Time-of-Check to Time-of-Use (TOCTOU) vulnerability during ptrace sto=
ps, allowing a seccomp filter installed via TSYNC to be bypassed.
--

commit 138e96f2aef98ac6348b34ceeb3157f77bd0f2f7
Author: Jinjie Ruan <ruanjinjie@huawei.com>

arm64: ptrace: Expand secure_computing() in place

This commit refactors syscall_trace_enter() by open-coding the seccomp
check to align with the generic entry framework. It explicitly checks
the flags parameter for _TIF_SECCOMP instead of calling the wrapper.

> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 863083de37c37..30df515528e8f 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -2420,8 +2420,10 @@ int syscall_trace_enter(struct pt_regs *regs, unsi=
gned long flags)
[ ... ]
>  	/* Do the secure computing after ptrace; failures should be fast. */
> -	if (!secure_computing())
> -		return NO_SYSCALL;
> +	if (flags & _TIF_SECCOMP) {
> +		if (!__secure_computing())
> +			return NO_SYSCALL;
> +	}

[Severity: High]
Does checking the cached 'flags' argument here instead of dynamically
reading the thread flags create a race condition?

If the current thread stops for ptrace earlier in syscall_trace_enter(),
and another thread installs a filter via seccomp with
SECCOMP_FILTER_FLAG_TSYNC while this thread is stopped, the newly set
_TIF_SECCOMP flag wouldn't be reflected in the local 'flags' variable.

Could this allow an unprivileged process to bypass a newly installed
seccomp filter for the current syscall, especially since the tracer might
modify the syscall number (e.g., to execve) during the ptrace stop?

As an additional detail, the generic entry code in include/linux/entry-comm=
on.h=20
seems to exhibit the same pattern by checking a cached 'work' variable pass=
ed=20
into syscall_trace_enter().

> =20
>  	/* Either of the above might have changed the syscall number */
>  	syscall =3D syscall_get_nr(current, regs);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629130616.6420=
22-1-ruanjinjie@huawei.com?part=3D5

