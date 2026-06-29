Return-Path: <linux-s390+bounces-21309-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mzq2EJd3Qmqs7wkAu9opvQ
	(envelope-from <linux-s390+bounces-21309-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 29 Jun 2026 15:48:07 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB746DB7FC
	for <lists+linux-s390@lfdr.de>; Mon, 29 Jun 2026 15:48:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gcMCmLLf;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21309-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21309-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 068AD3245F1B
	for <lists+linux-s390@lfdr.de>; Mon, 29 Jun 2026 13:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1900404BFA;
	Mon, 29 Jun 2026 13:16:04 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735A8404BF6
	for <linux-s390@vger.kernel.org>; Mon, 29 Jun 2026 13:16:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738964; cv=none; b=PsdWpG6DSZOEk2u8kn7Xtm7EG0RAgljFmNqbCjKc9L0Wu1HzCKVU5HdheYCTbB7WNeDF5r8lORDk0y5oq8S55yR8ytxOw+ncV1QPefYjH4vwNcExatAQYzSyYVruHSPwRvM31klpWA6z7sGCCH7r1Q2z0lD7hoi0KlrW0R8T3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738964; c=relaxed/simple;
	bh=vBeMDNOkkISunQWwVpT1IPmz7hFW3tF1bv+VVl14UbU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bkJAsmScmhqL1tUNc8lLvLBkdccuW9Tw3ji3obeUuJ2sCswxIuNvlC7ybk3z/mbadG9ujkA9ZXVGmggE9/W4XlFUzLDA0pWtmqonRztq8uoE81b4d66u5HKFJUq5j5x7QeN98ePiCB8TeJse9sdPN2EuMbU/uT9G9ei2aUKUW7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcMCmLLf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9601F000E9;
	Mon, 29 Jun 2026 13:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782738963;
	bh=UlmdCveokX4ANFfJqz5Fn28sclOTK8kpfcDjwV5+iXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gcMCmLLfkh3xmJVbnE0zTlqDJKpO4eLyRC62gpYKZf++u9U1UDD1GDGj1Fd1Al6Oi
	 dsDJ8eq+h8kgf1ymITrorsYzC/NXVRvWI4mubVG5vWI/rTE6Q3Oj6rlLDXc1xZgbKi
	 Ut0fwXUv2j7VdarljqXmH/pCovuAtCpb4YSudwShu+IRgZao5XbYgLw1LaWw9SzAVP
	 4slB4Ug5ZNwBTmXVOFVBhuDN2p+XP9P7vW7/qbk3KKz90DwSQ3pDjuD0vivlOe+L8w
	 LNkqe4hWOtsKWO6CGZJ07MMOB239FPPIXYbJi0IBYgN0vxYfsXL4JwO1V92wuvObYs
	 fHbFZ+Ayfetrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 01/18] seccomp: Convert __secure_computing() to
 return boolean
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinjie Ruan" <ruanjinjie@huawei.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260629130616.642022-2-ruanjinjie@huawei.com>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 13:16:02 +0000
Message-Id: <20260629131602.DC9601F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21309-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,vger.kernel.org:from_smtp,huawei.com:email,lists.linux.dev:replyto];
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
X-Rspamd-Queue-Id: BBB746DB7FC

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Incomplete conversion of secure_computing() return semantics i=
n x86 vsyscall emulation causes allowed vsyscalls to be incorrectly skipped=
 and blocked vsyscalls to be executed.
- [Critical] Inverted seccomp evaluation logic for tracer-modified syscalls=
 in SECCOMP_RET_TRACE allows ptracers to bypass seccomp and execute blocked=
 system calls.
--

commit f5bc8c5696220b369255d486da26d273d661d2fa
Author: Jinjie Ruan <ruanjinjie@huawei.com>

seccomp: Convert __secure_computing() to return boolean

The return value of __secure_computing() currently uses 0 to indicate
that a system call should be allowed, and -1 to indicate that it should
be blocked/killed. This 0/-1 pattern is non-intuitive for a security
check function and makes the control flow at the call sites less readable.

> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsysc=
all/vsyscall_64.c
> index ea36de9fa8641..6aed3987b9f96 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -198,7 +198,7 @@ static bool __emulate_vsyscall(struct pt_regs *regs, =
unsigned long address)
>  	regs->orig_ax =3D syscall_nr;
>  	regs->ax =3D -ENOSYS;
>  	tmp =3D secure_computing();
> -	if ((!tmp && regs->orig_ax !=3D syscall_nr) || regs->ip !=3D address) {
> +	if ((tmp && regs->orig_ax !=3D syscall_nr) || regs->ip !=3D address) {
>  		warn_bad_vsyscall(KERN_DEBUG, regs,
>  				  "seccomp tried to change syscall nr or ip");
>  		force_exit_sig(SIGSYS);
>  		return true;
>  	}
>  	regs->orig_ax =3D -1;
>  	if (tmp)
>  		goto do_ret;  /* skip requested */

[Severity: Critical]
Since secure_computing() now returns true when allowing a system call, does=
n't
this check skip the emulation for allowed vsyscalls and execute the blocked
ones instead?

[ ... ]

> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 066909393c38f..1fec6efedab62 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c

[ ... ]

> @@ -1330,19 +1330,19 @@ static int __seccomp_filter(int this_syscall, con=
st bool recheck_after_trace)
>  		 * a skip would have already been reported.
>  		 */
>  		if (__seccomp_filter(this_syscall, true))
> -			return -1;
> +			return false;
> =20
> -		return 0;
> +		return true;

[Severity: Critical]
Is this logic inverted for tracer-modified syscalls in SECCOMP_RET_TRACE?

__seccomp_filter() now returns true on allow and false on deny.
If the nested __seccomp_filter() call evaluates the modified syscall and
returns true (allow), the if condition evaluates to true and it returns
false (deny).

Conversely, if it returns false (deny), it bypasses the if condition and
returns true (allow).

Could a ptracer bypass the seccomp sandbox entirely by changing the syscall
to a prohibited one, which would then be incorrectly allowed here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629130616.6420=
22-1-ruanjinjie@huawei.com?part=3D1

