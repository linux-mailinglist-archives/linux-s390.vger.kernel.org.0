Return-Path: <linux-s390+bounces-21494-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yXGwLjRRRmqpQgsAu9opvQ
	(envelope-from <linux-s390+bounces-21494-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 02 Jul 2026 13:53:24 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 192116F7134
	for <lists+linux-s390@lfdr.de>; Thu, 02 Jul 2026 13:53:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kLTmUhIz;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21494-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21494-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49D53303DAF2
	for <lists+linux-s390@lfdr.de>; Thu,  2 Jul 2026 11:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7101F3F787E;
	Thu,  2 Jul 2026 11:25:02 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431C33EEAE9;
	Thu,  2 Jul 2026 11:25:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991502; cv=none; b=L6D98juZNezTcPDIyuBIabax1e2jjWnONeZ9oQ4KWvAuIcNbJA5SeQplfXUonSPzvZUNxYH9sLv/AzMKXIW3fXSmf4bpalJ2HSOhOAS2EX9zRd3cC+EnGo/OzPU8+WIYIUknHQiY872jQ9HWp/08NUXJPYDDuz+wZFL9W3Dfu5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991502; c=relaxed/simple;
	bh=2Gv5HFzlkMbFzaDx1llG37d5UEFM/5AOSXNnQSuRzf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G3+dzUtAIBxbY8STk49rsIcldA44II2/VYUoQGJtEfdNnQ9YY9ymfdE1BqVcQBDdIgwSqKJWPS67g5MSLzF4DT8iP13xJbZ5dhVSnZC3SmRDH5PSif/qFu5xOxakzIGy2rDHRgzOJ9rZ7yfTOw+dd6QxBteQKc6sw/yyk4ke6sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLTmUhIz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2817C1F00A3F;
	Thu,  2 Jul 2026 11:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782991501;
	bh=mOM3rzsLQ5zcU0KB7ppqvlisg4HQiYPTf14y3PbqPhs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kLTmUhIzP0y8iCpVDm6+5t9nX8pnl/FL2IHkdX+LfPQlaEB6wVtL1kzoiWM3qgtdM
	 9lTWMsYU7FF6L2fLFenc6N5j8Ef5Fsck26DORNh2e1uC+hhJjt3XhPbzYodE5No+/4
	 tWeWtodTFyens21QxAEsxxmbVM/H/aptMqXN2OB3YO2ifHuNtRpMc59RFcP/OFJdrl
	 p/pPBwhqDVsZFrWWR0Y/4+EfsV6EJ/+t4oycLzrV5+G6c5l4TaSPPG0X2wti9LPib7
	 U22B6IjMFDRlMrSIOQnTd3sE3VScotvakJyHz80nD/AmM45TrVc/NRY1ZD3+rFexs+
	 OeLrJpr3ynMYA==
From: Thomas Gleixner <tglx@kernel.org>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, Peter Zijlstra
 <peterz@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Huacai Chen <chenhuacai@kernel.org>, WANG
 Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Andy
 Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Donnellan
 <andrew+kernel@donnellan.id.au>, Mark Rutland <mark.rutland@arm.com>,
 Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, Arnd Bergmann
 <arnd@arndb.de>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Ryan Roberts <ryan.roberts@arm.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mukesh Kumar Chaurasiya
 <mkchauras@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Zong
 Li <zong.li@sifive.com>, Nam Cao <namcao@linutronix.de>, Deepak Gupta
 <debug@rivosinc.com>, Lukas Gerlach <lukas.gerlach@cispa.de>, Rui Qi
 <qirui.001@bytedance.com>, Kees Cook <kees@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [RFC] entry: Untangle the return value of
 syscall_enter_from_user_mode from syscall NR
In-Reply-To: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
Date: Thu, 02 Jul 2026 13:24:57 +0200
Message-ID: <878q7tprau.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[46];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:msuchanek@suse.de,m:peterz@infradead.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:luto@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:andrew+kernel@donnellan.id.au,m:mark.rutland@arm.com,m:arnd@arndb.de,m:jiaxun.yang@flygoat.com,m:ryan.roberts@arm.com,m:gregkh@linuxfoundation.org,m:mkchauras@linux.ibm.com,m:sshegde@linux.ibm.com,m:zong.li@sifive.com,m:namcao@linutronix.de,m:debug@rivosinc.com,m:lukas.gerlach@cispa.de,m:qirui.001@bytedance.com,m:kees@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs.o
 rg,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:andrew@donnellan.id.au,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21494-lists,linux-s390=lfdr.de];
	FORGED_SENDER(0.00)[tglx@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[lwn.net,linuxfoundation.org,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,zytor.com,donnellan.id.au,arm.com,suse.de,arndb.de,flygoat.com,sifive.com,linutronix.de,rivosinc.com,cispa.de,bytedance.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,fw13:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 192116F7134

On Wed, Jul 01 2026 at 19:42, Michal Such=C3=A1nek wrote:
> The return value of syscall_enter_from_user_mode is used both for the
> adjusted syscall number and the indicator that a syscall should be
> skipped.
>
> As seccomp can be invoked on any syscall, including invalid ones this
> somewhat undermines seccomp.
>
> While the seccomp variants that terminate the process do not need to
> care about this for the filter that sets the syscall return value this
> disctinction is required.

You completely fail to explain why and what actual problem you are
trying to solve. At least I can't figure it out from the above word
salad.

> Pass the syscall number as a pointer to the inline entry functions, and
> use the return value exclusively for the indication that the syscall is
> already handled.
>
> This should avoid the need for the s390 PIF_SYSCALL_RET_SET which is the
> workaround for exactly this deficiency.
>
> If this is desirable the patch could be split into some series that
> adjusts the code flow where needed so that the final change is mostly
> mechanical.

That's not a matter of desire. That's mandatory.

> -	instrumentation_begin();
> -	if (!invoke_syscall(regs, nr) && nr !=3D -1)
> -	 	result_reg(regs) =3D __sys_ni_syscall(regs);
> -	instrumentation_end();
> +	/* Skip syscall when -1 is returned */
> +	if (!syscall_enter_from_user_mode(regs, &nr)) {

Seriously?

If we go and separate the syscall number from the return value, then the
return value 0 means success and anything else fail. Which in other
words is a boolean. So instead of tastelessly adding a completely
nonsensical comment about -1 here, syscall_enter_from_user_mode() wants
to have the return value type bool with a proper boolean logic: true =3D
success, false =3D abort.

> @@ -168,8 +168,7 @@ __visible noinstr void do_int80_emulation(struct pt_r=
egs *regs)
>  	nr =3D syscall_32_enter(regs);
>=20=20
>  	local_irq_enable();
> -	nr =3D syscall_enter_from_user_mode_work(regs, nr);
> -	do_syscall_32_irqs_on(regs, nr);
> +	syscall_enter_from_user_mode_work(regs, &nr);

How exactly is this ever going to invoke a valid syscall?

> +	if (!syscall_enter_from_user_mode_work(regs, &nr)) {
> +		nr &=3D GENMASK(31, 0);
> +		do_syscall_32_irqs_on(regs, nr);

  do_syscall_32_irqs_on(regs, (int)nr);

would be too simple, right?

Thanks,

        tglx

