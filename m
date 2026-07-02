Return-Path: <linux-s390+bounces-21521-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id orUFOMfeRmp8ewsAu9opvQ
	(envelope-from <linux-s390+bounces-21521-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 02 Jul 2026 23:57:27 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3738C6FD19C
	for <lists+linux-s390@lfdr.de>; Thu, 02 Jul 2026 23:57:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=B+tc+5RH;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21521-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21521-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5159307A9E0
	for <lists+linux-s390@lfdr.de>; Thu,  2 Jul 2026 21:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756B33AFCFD;
	Thu,  2 Jul 2026 21:50:00 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E103ABD80;
	Thu,  2 Jul 2026 21:49:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783029000; cv=none; b=ff1QYQoXnOUoq4ZRzsXbpMjhmxNYZJAsUIeTGSO6ZCGcSA9Dir9IAhEFiRw/7PiG6ApwxI3jYB9vA4E7L0/AXysvAL/kMM68VjLv63bFLJybFCrwIt4fvIWp1Mndks3ldV7TJ2KjUsvFsZ8kxYtAD5tsA345IrC+K7khuc4Cemk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783029000; c=relaxed/simple;
	bh=ISkPg/YBdFNLVZr9zQfTxmgaGMA28Hs3tI2QtR9CKSo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HiU6MIFKY6fN0/3phyzzd2M9IMQxUZXjQ5YZCWoTo5Gg2lgpjBKd7fFzXw2wL/JED5CfGJ+tMm4sEidjB2sP6zL4pd0C0yWt57CFa6BryGhVV6gaSNgjAbyVgJ3513nseYyDbuqshLbLBGlpA5SjhFqEOzAxNbZ8XlVahyjXWzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+tc+5RH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229061F000E9;
	Thu,  2 Jul 2026 21:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783028999;
	bh=OR8xOq9dAd26ujiAwVszzOHiLCszARnPiwIaNz5ESn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=B+tc+5RHqY3JoS8BHBFtIs6Ixwb3FHiZW7sw1eSjWzSZOdtdOeiX1LOBPB259SqN0
	 RNu9r3S6UrqNIzSwvlS0ScHYEXZUS4yKPvIEK6KMwjeIWpfxZumCiw9DxB+KO6MQY1
	 ZI5ulAka1rXUJeevOMYAvWilVlf7cswGz3Dxdg/7doTH+m+bgGilYGCAoBXpM2yze+
	 njTHv1m+JV3W3uth459/AznoFJO4beF/j9n/ic34ynDmKQQgBUnWNLxloBHcFS7A8E
	 ikCdHAQgPb2eYut2DcXNxvdCL/QOxh0vGXxjv4Fo+Kn0pYSvtPQluXZyAJPKTejWQ+
	 kdFdgBw5+DLDA==
From: Thomas Gleixner <tglx@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>,
 Peter Zijlstra <peterz@infradead.org>
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
 x86@kernel.org, Andrew Donnellan <andrew+kernel@donnellan.id.au>, Mark
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
In-Reply-To: <BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
 <BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com>
Date: Thu, 02 Jul 2026 23:49:56 +0200
Message-ID: <87h5mhnjsr.ffs@fw13>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[45];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hpa@zytor.com,m:msuchanek@suse.de,m:peterz@infradead.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:luto@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:andrew+kernel@donnellan.id.au,m:mark.rutland@arm.com,m:arnd@arndb.de,m:jiaxun.yang@flygoat.com,m:ryan.roberts@arm.com,m:gregkh@linuxfoundation.org,m:mkchauras@linux.ibm.com,m:sshegde@linux.ibm.com,m:zong.li@sifive.com,m:namcao@linutronix.de,m:debug@rivosinc.com,m:lukas.gerlach@cispa.de,m:qirui.001@bytedance.com,m:kees@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs.o
 rg,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:andrew@donnellan.id.au,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21521-lists,linux-s390=lfdr.de];
	FORGED_SENDER(0.00)[tglx@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[lwn.net,linuxfoundation.org,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,donnellan.id.au,arm.com,arndb.de,flygoat.com,sifive.com,linutronix.de,rivosinc.com,cispa.de,bytedance.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email,fw13:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3738C6FD19C

On Wed, Jul 01 2026 at 11:29, H. Peter Anvin wrote:

Can you please trim your replies? Scrolling through hundred lines of
useless quoted text is just annoying.

> On July 1, 2026 10:42:08 AM PDT, "Michal Such=C3=A1nek" <msuchanek@suse.d=
e> wrote:
>>-static __always_inline long syscall_enter_from_user_mode(struct pt_regs =
*regs, long syscall)
>>+static __always_inline long syscall_enter_from_user_mode(struct pt_regs =
*regs, long *syscall)
>> {
>> 	long ret;
>>

> 1. The type for a system call is int.

That ship has sailed long ago. man syscall ...

> 2. A valid system call number is always going to be positive.

That's true today.

> 3. Bits [30:24] are available for architecture ABI use. The
>    "architecture independent" part of the system call number is therefore
>    24 bits wide.
>
> 4. The exact ABI is platform-specific, obviously, but as a general
>    guideline (especially for new platforms/ABIs) should follow the rules
>    for a platform "int" if practical. Notably, when passing a value in a
>    register larger than 32 bits, which side of the calling interface is
>    responsible for sign-extending a value passed in a register. If caller
>    side, the kernel should validate, if callee side the kernel should
>    ignore the additional bits and do the extension.

The kernel sign expands today already, i.e. for compat syscalls.

> 5. A negative system call number is guaranteed to return -ENOSYS
>    (unless intercepted by seccomp, ptrace, or another mechanism under
>    user space control.)

That's true today.

ASM entry:
       regs->eax =3D -ENOSYS;

C entry:
       nr =3D syscall_enter_from_user_mode(regs, nr);

       if ((unsigned)nr < SYSCALL_MAX)
       	    regs->eax =3D handle_syscall();
       else if (nr !=3D -1)
       	    regs->eax =3D -ENOSYS;

       ....

If seccomp overwrites regs->eax and aborts any syscall (including -1) by
returning -1, then the value seccomp wrote into regs->eax is preserved
and returned to user space.

The same applies for syscall_user_dispatch() and ptrace...() if they
decide to overwrite regs->eax _and_ abort the syscall by letting
syscall_enter_from_user_mode() return -1.

trace_syscall_enter() is not any different. If the magic BPF in there
rewrites the syscall number to -1 then either the original -ENOSYS or
the BPF induced overwrite is returned to user space.

It's less than obvious and I have no objections to clean that up and
make it more intuitive, but I still fail to see what Michal is actually
trying to solve and what the magic flag is for. If s390 requires it,
then that's an s390 problem, but definitely x86 does not.

> 6. If the platform needs to algorithmically modify the system call
>    number due to platform-specific concerns (say, the platform uses a
>    16-bit special purpose register for the syscall number, or it has
>    multiple kernel entry points with different behavior), it should if at
>    all possible transcode the system call number as necessary to match
>    this convention in APIs that are exposed to general kernel code.
>
> For example, in the future I could very much see the IA32 code in the
> x86 kernel using bit 29 internally to indicate an ia32 system call,
> simplifying the is_compat implementation on x86.

I don't see how that makes it simpler. Those are two different entry
code paths and magic bits wont make that go away.

> It should not mean that passing bit 29 to either the syscall
> instruction or int $0x80 will be accepted.

Your proposal looks even more like a solution in search of a problem
than the original one.

Thanks,

        tglx


