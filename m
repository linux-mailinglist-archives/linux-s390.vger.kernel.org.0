Return-Path: <linux-s390+bounces-22291-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qy7iHANZVmoL3wAAu9opvQ
	(envelope-from <linux-s390+bounces-22291-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 17:42:59 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F71A756893
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 17:42:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rendec.net header.s=default header.b=rAqaJqFF;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22291-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22291-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rendec.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32786301AB7F
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C8D444716;
	Tue, 14 Jul 2026 15:41:43 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE648BD4A;
	Tue, 14 Jul 2026 15:41:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043703; cv=none; b=Ec9UDIeuxEQ/faxWlCMRK0sX0UGd49ZHI+vMYizgF9Xl57WMu+ut80JxHSxDN/CAANFv/ZfgGSOdzQLGFUlt6RWUa2gg2Zn2Ps5AXSoGujUMjdBfHFft5tE/7aerQ7kMT1ArB95aOmiAEe5zTWrY6KNcR1f/YSzDcIGNr8BE1O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043703; c=relaxed/simple;
	bh=u0x5lbDonOcd/zZRrlPN3V+m//i3MRhDi3VADgJWwPA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cwif81uINFoLOEUkOHi3LkkX1NyqMR1kjzIeJSOgZ8P4Rlcmkb3zdQji9NV7HiVJAkJAv4X2WjVGzy5QI8a5V4E3hsyVuHHQORwNlewPJNzP6IBXCSWvtNy+Otow0f/knUsDvM19Gt0/bccps6IwFhurGcvnKJcNsgJ2xbOYBO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; spf=pass smtp.mailfrom=rendec.net; dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b=rAqaJqFF; arc=none smtp.client-ip=80.86.107.70
Received: from bat.kanata.rendec.net (unknown [24.114.105.230])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 5F076C2C75;
	Tue, 14 Jul 2026 18:41:28 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 5F076C2C75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1784043698;
	bh=hKhKnBtVoVUk/sXTgCEmjbmfk+iGn8mR/E/A1x3cNyk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rAqaJqFFLrO6y6tNVaFvU6vIVcy3LmKR3vuzw4P0LZXbAJVJVm0ALDzL8TymM6hBv
	 CET/mK/kqUWiSZemfVMilwSqWFX7NQXXVpNQ/Te8bp3aMO1QuzmgMSY/iDK1H3oLI+
	 b54jOKhx6ngl0C+7U/vHITetf6JHV6RPlMzsTCj07sqnDOQYY9HRrwARS76jc64IHh
	 JgxemAMZU4ZbJH9EgYX9u416U/McWH+76dZ34vUPOoUw4O7hFqTWBFLZhpRbtKSpsT
	 lqzJ3VpJ/iGQMdziAOF0ZQPwuFo3eBNqkoCEX46BG6CZbIkZNRCTXHdambhKsn3JM6
	 YjYhQXSomeepg==
Message-ID: <0b9b0da3dd27df230038bc87efa8ed43bb02e740.camel@rendec.net>
Subject: Re: [patch 3/4] entry: Make return type of syscall_trace_enter()
 bool
From: Radu Rendec <radu@rendec.net>
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, Michael Ellerman
	 <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt	
 <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Sven Schnelle	
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, Mark
 Rutland	 <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Magnus Lindholm	 <linmag7@gmail.com>, "Mukesh Kumar Chaurasiya (IBM)"
 <mkchauras@gmail.com>,  Jonathan Corbet	 <corbet@lwn.net>
Date: Tue, 14 Jul 2026 11:41:24 -0400
In-Reply-To: <20260712141346.699072205@kernel.org>
References: <20260712134433.549076055@kernel.org>
	 <20260712141346.699072205@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rendec.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[rendec.net:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22291-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:msuchanek@suse.de,m:mpe@ellerman.id.au,m:sshegde@linux.ibm.com,m:linuxppc-dev@lists.ozlabs.org,m:chenhuacai@kernel.org,m:loongarch@lists.linux.dev,m:pjw@kernel.org,m:palmer@dabbelt.com,m:linux-riscv@lists.infradead.org,m:svens@linux.ibm.com,m:linux-s390@vger.kernel.org,m:x86@kernel.org,m:mark.rutland@arm.com,m:ruanjinjie@huawei.com,m:linmag7@gmail.com,m:mkchauras@gmail.com,m:corbet@lwn.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[radu@rendec.net,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[suse.de,ellerman.id.au,linux.ibm.com,lists.ozlabs.org,kernel.org,lists.linux.dev,dabbelt.com,lists.infradead.org,vger.kernel.org,arm.com,huawei.com,gmail.com,lwn.net];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[radu@rendec.net,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[rendec.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rendec.net:from_mime,rendec.net:mid,rendec.net:email,rendec.net:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F71A756893

On Sun, 2026-07-12 at 23:25 +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@kernel.org>
>=20
> This prepares for changing the return types of
> syscall_enter_from_user_mode[_work]() to bool, which in turn separates th=
e
> decision of invoking the syscall from the syscall number, which might hav=
e
> been changed in the call by ptrace, seccomp, tracing.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
> =C2=A0include/linux/entry-common.h |=C2=A0=C2=A0 18 +++++++++++-------
> =C2=A01 file changed, 11 insertions(+), 7 deletions(-)
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -72,7 +72,7 @@ static __always_inline long syscall_trac
> =C2=A0	 */
> =C2=A0	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
> =C2=A0		if (syscall_user_dispatch(regs))
> -			return -1L;
> +			return false;
> =C2=A0	}
> =C2=A0
> =C2=A0	/*
> @@ -87,13 +87,13 @@ static __always_inline long syscall_trac
> =C2=A0	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)=
) {
> =C2=A0		if (!arch_ptrace_report_syscall_permit_entry(regs) ||
> =C2=A0		=C2=A0=C2=A0=C2=A0 (work & SYSCALL_WORK_SYSCALL_EMU))
> -			return -1L;
> +			return false;
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Do seccomp after ptrace, to catch any tracer changes. */
> =C2=A0	if (work & SYSCALL_WORK_SECCOMP) {
> =C2=A0		if (!__seccomp_permit_syscall())
> -			return -1L;
> +			return false;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
> @@ -102,8 +102,7 @@ static __always_inline long syscall_trac
> =C2=A0	if (unlikely(audit_context()))
> =C2=A0		syscall_enter_audit(regs);
> =C2=A0
> -	/* Either of the above might have changed the syscall number */
> -	return syscall_get_nr(current, regs);
> +	return true;
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -133,8 +132,13 @@ static __always_inline long syscall_ente
> =C2=A0{
> =C2=A0	unsigned long work =3D READ_ONCE(current_thread_info()->syscall_wo=
rk);
> =C2=A0
> -	if (work & SYSCALL_WORK_ENTER)
> -		syscall =3D syscall_trace_enter(regs, work, syscall);
> +	if (work & SYSCALL_WORK_ENTER) {
> +		if (!syscall_trace_enter(regs, work, syscall))
> +			return -1L;
> +
> +		/* Reread the syscall number as it might have been modified */

nit: I would add "in the call above by ptrace, seccomp, tracing" - which
is actually in your commit message, but would make it immediately obvious
when reading the code.

> +		syscall =3D syscall_get_nr(current, regs);
> +	}
> =C2=A0
> =C2=A0	return syscall;
> =C2=A0}

Reviewed-by: Radu Rendec <radu@rendec.net>

