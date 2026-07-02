Return-Path: <linux-s390+bounces-21520-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f8yfHQnORmq2dwsAu9opvQ
	(envelope-from <linux-s390+bounces-21520-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 02 Jul 2026 22:46:01 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D84646FCCDF
	for <lists+linux-s390@lfdr.de>; Thu, 02 Jul 2026 22:46:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UaD5CREX;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21520-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-21520-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B434C30450B3
	for <lists+linux-s390@lfdr.de>; Thu,  2 Jul 2026 20:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A508530675F;
	Thu,  2 Jul 2026 20:45:58 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6423D1D7E41;
	Thu,  2 Jul 2026 20:45:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783025158; cv=none; b=o60W65vH/p17Ezs8NXxGjKMr+SVCH/gGKbVhMvIo/iQZYEGMgUFh/M7eLyWo48YNkGfrdqFeKYaiEfl0RPpMTV1pZTiV2fFxHlQBGjyAkNq5s6PYNZf30fwff0/AhsaCFMYJxxp2zL6JMmr0fYW0efTJVATb5bXU4N003c5HOPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783025158; c=relaxed/simple;
	bh=ba3X3ZETjVs6YknWjbiZ8awUBHTLyUR0p9siPtBSq5s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hsKcTKE3HwfGpvr18Mfgh0HAz5o4M3HlQvzq9/gFmYNiLlnVZckuXzHCJRtC/QrjYL5+2F3N0jlMlDvwNgjyfWUBFg4UR3YpxzkcO6rnvBg+6qO1rXtbFQJlbURfSzOjhFADjXXvoXtEJ+YdIN+kaKd0DGzOZVPBfYFnIAhJTyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaD5CREX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E22A1F000E9;
	Thu,  2 Jul 2026 20:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783025157;
	bh=RgKO/UZyvy5Z38gyC0IxY1FJQhRYi6rg13CXydLdQY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=UaD5CREX6zIC4y3TKyphGTRRC28mz0dermBnriIDo4VJeBY/fdSm+bo4SMeeqxcg4
	 2nZAzjliM6+hr13yB3w26OsBLeq2/LrH4mPoYTvdvIoIgX7/pLVzQh7YACklPUTPLp
	 FLllWVPCLOhkab1Df0IWNyhs3Ywb2DxH7ixWEd8w6zgUPmPOydjr19iHGh9HjLcZ4F
	 9UCuRvgiy4zhYBZoDyEW5Z9msFbTaIp5y2F8IW6O+Mb0197Xa/ngseuyyyv0Wudwne
	 iFoJGUnjorvAS2hYs4zLCLoOB5VYqaG8YVDJzvMwOcYqcJ7sZ/KrRKbchO6zN9ftrj
	 z/YENEra/5DFg==
From: Thomas Gleixner <tglx@kernel.org>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Andrew Donnellan <andrew+kernel@donnellan.id.au>, Mark
 Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Ryan Roberts <ryan.roberts@arm.com>, Greg
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
In-Reply-To: <akZPakNl6JT_jgGd@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz> <878q7tprau.ffs@fw13>
 <akZPakNl6JT_jgGd@kunlun.suse.cz>
Date: Thu, 02 Jul 2026 22:45:54 +0200
Message-ID: <87jyrdnmrh.ffs@fw13>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[45];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:msuchanek@suse.de,m:peterz@infradead.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:luto@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:andrew+kernel@donnellan.id.au,m:mark.rutland@arm.com,m:arnd@arndb.de,m:jiaxun.yang@flygoat.com,m:ryan.roberts@arm.com,m:gregkh@linuxfoundation.org,m:mkchauras@linux.ibm.com,m:sshegde@linux.ibm.com,m:zong.li@sifive.com,m:namcao@linutronix.de,m:debug@rivosinc.com,m:lukas.gerlach@cispa.de,m:qirui.001@bytedance.com,m:kees@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs.o
 rg,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:andrew@donnellan.id.au,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21520-lists,linux-s390=lfdr.de];
	FORGED_SENDER(0.00)[tglx@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[infradead.org,lwn.net,linuxfoundation.org,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,zytor.com,donnellan.id.au,arm.com,arndb.de,flygoat.com,sifive.com,linutronix.de,rivosinc.com,cispa.de,bytedance.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D84646FCCDF

On Thu, Jul 02 2026 at 13:45, Michal Such=C3=A1nek wrote:
> On Thu, Jul 02, 2026 at 01:24:57PM +0200, Thomas Gleixner wrote:
>> On Wed, Jul 01 2026 at 19:42, Michal Such=C3=A1nek wrote:
>> > The return value of syscall_enter_from_user_mode is used both for the
>> > adjusted syscall number and the indicator that a syscall should be
>> > skipped.
>> >
>> > As seccomp can be invoked on any syscall, including invalid ones this
>> > somewhat undermines seccomp.
>> >
>> > While the seccomp variants that terminate the process do not need to
>> > care about this for the filter that sets the syscall return value this
>> > disctinction is required.
>>=20
>> You completely fail to explain why and what actual problem you are
>> trying to solve. At least I can't figure it out from the above word
>> salad.
>
> syscall_enter_from_user_mode returns the new syscall number after doing
> something arbitrarry with it, including running seccomp.
>
> Wehn the syscall is already handled, eg. by seccomp filtering it returns
> -1 as the new syscall number. -1 is an invalid syscall number but it can
> still be filtered by seccomp.

Once syscall_enter_from_user_mode() returns -1 nothing can filter it
anymore.

> When the syscall number was -1 to start with it's not possible to
> determine if the syscall was fileterd from the return value. s390
> returns the filtered state in a flag it sets on the regs structure,
> avoiding this problem.

What needs to determine whether the syscall was filtered or not?

> However, the API should be specified in a way that does not require
> everyone implementing such flag.

Which exact problem does the flag solve?

>> > -	instrumentation_begin();
>> > -	if (!invoke_syscall(regs, nr) && nr !=3D -1)
>> > -	 	result_reg(regs) =3D __sys_ni_syscall(regs);
>> > -	instrumentation_end();
>> > +	/* Skip syscall when -1 is returned */
>> > +	if (!syscall_enter_from_user_mode(regs, &nr)) {
>>=20
>> Seriously?
>>=20
>> If we go and separate the syscall number from the return value, then the
>> return value 0 means success and anything else fail. Which in other
>> words is a boolean. So instead of tastelessly adding a completely
>> nonsensical comment about -1 here, syscall_enter_from_user_mode() wants
>> to have the return value type bool with a proper boolean logic: true =3D
>> success, false =3D abort.
>
> We have that very same API down to __secure_computing() which returns
> boolean represented as -1 and 0 values. That does not mean it's not
> tasteless.

Hahahahaha.

We have a lot of functions which have a boolean return value but a
int/long return type for historical reasons.

We've added bool because it's not ambiguous and allows the compiler to
optimize better. It also makes the code more clear. Modern code uses a
non-boolean return type only when there is an actual reason for it,
e.g. propagating an error code all the way back through the call chain.
The historical 0=3Dsuccess <0 =3D errorcode model really want's to be
restricted to such cases.

Just for the record:

  https://lore.kernel.org/all/67c3ae5c-d88b-4172-9996-4e2046b7e0dc@huawei.c=
om/
  https://lore.kernel.org/all/20260629130616.642022-2-ruanjinjie@huawei.com/

So I stand with my comment that it is sloppy and tasteless to slap an
argument into a pile of functions, claim separation of return value and
syscall number and leave the return value in an ill-defined state.

>> > @@ -168,8 +168,7 @@ __visible noinstr void do_int80_emulation(struct p=
t_regs *regs)
>> >  	nr =3D syscall_32_enter(regs);
>> >=20=20
>> >  	local_irq_enable();
>> > -	nr =3D syscall_enter_from_user_mode_work(regs, nr);
>> > -	do_syscall_32_irqs_on(regs, nr);
>> > +	syscall_enter_from_user_mode_work(regs, &nr);
>>=20
>> How exactly is this ever going to invoke a valid syscall?
>
> That's one of the problems with giant all-in-one patch, things like this
> easily slip in. However, it is in cluded mostly for illustration, I
> don't expect anyone to merge this as-is.

It's a problem with hastily cobbled together slop. Even RFC patches
should at least be functional.
=20
>> > +	if (!syscall_enter_from_user_mode_work(regs, &nr)) {
>> > +		nr &=3D GENMASK(31, 0);
>> > +		do_syscall_32_irqs_on(regs, nr);
>>=20
>>   do_syscall_32_irqs_on(regs, (int)nr);
>>=20
>> would be too simple, right?
>
> Also way less explicit.

Now you care about explicit, but the return value mess can be left
ambiguous, right?

Aside of that, the cast is very much explicit for people who can read C.

It would be great if you could sit back and come up with a very explicit
and comprehensible explanation for the problem you are trying to solve.

Thanks,

        tglx

