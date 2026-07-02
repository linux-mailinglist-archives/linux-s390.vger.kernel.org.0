Return-Path: <linux-s390+bounces-21491-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uRyuAgNBRmqKMwsAu9opvQ
	(envelope-from <linux-s390+bounces-21491-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 02 Jul 2026 12:44:19 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B96936F6198
	for <lists+linux-s390@lfdr.de>; Thu, 02 Jul 2026 12:44:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VwZTL9J3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zHrAXApM;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VwZTL9J3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zHrAXApM;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21491-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-21491-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25588308D95C
	for <lists+linux-s390@lfdr.de>; Thu,  2 Jul 2026 09:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0387847B435;
	Thu,  2 Jul 2026 09:30:27 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF3D4229BB
	for <linux-s390@vger.kernel.org>; Thu,  2 Jul 2026 09:30:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984626; cv=none; b=jF/5rXJmbpNcuPVWV+Bq8HnpiAGaiPB+RNQw1BIrW/xrikxoEyjSRKG3apInFx5UMvSJKCPS+61jLvtloSlaapUcW0NsBdIAr3/rEqRGWpWiMHHn+Xh8Cp5AbzIiX5W2MZwZPB+BWwThkZ5Zc4t3qN9/jtJ0+hCA3ss4CpXhSgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984626; c=relaxed/simple;
	bh=utkwS/ZHtOtz/0BUvlh3cGs/dDwybWvF4PZpD4NPg4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTSqPTuMBMURb6kADtWhYfHUYEdAmGC8byHmxAN4uxTPCAY9+p4abn8sRTCAegLzD8ehU2ccdEfmgLpxRnMQDy2qskktkF4QKZWP75IJyrq+XlsHoIvcSOlwT6LD6MfXsLS6irnGiIJ0fui/YMKvOntTSzA3/bAlY5Yp8Ohc51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VwZTL9J3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zHrAXApM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VwZTL9J3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zHrAXApM; arc=none smtp.client-ip=195.135.223.130
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07598740EC;
	Thu,  2 Jul 2026 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782984622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lWylP9b9cdUhMWrvdJZr9qFySJU8pT1hzR7f9NrXow=;
	b=VwZTL9J3aRvgi4LbvLAOQMkkVyhoxiDEySmxo6GgsLDYxnemwlOu9Z3DvdzwWlYueEsntf
	R/zYQ6fBSA9nhFH+F4DQqTYGy+Ti8qQcoiL6Dteg50eC6DxRtj+o8KMfgTGLhrHySCpfiq
	HYRAFTETZ70HCm0FYZOp7BiH/sXFQ/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782984622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lWylP9b9cdUhMWrvdJZr9qFySJU8pT1hzR7f9NrXow=;
	b=zHrAXApMECnqKbUH+JL7S7nVqoe6kzJ9OwVhYbDJIsfVlj+nEWi+3Wco6HCWABTCBRZMGY
	tNSSriZ3TujLsoDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782984622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lWylP9b9cdUhMWrvdJZr9qFySJU8pT1hzR7f9NrXow=;
	b=VwZTL9J3aRvgi4LbvLAOQMkkVyhoxiDEySmxo6GgsLDYxnemwlOu9Z3DvdzwWlYueEsntf
	R/zYQ6fBSA9nhFH+F4DQqTYGy+Ti8qQcoiL6Dteg50eC6DxRtj+o8KMfgTGLhrHySCpfiq
	HYRAFTETZ70HCm0FYZOp7BiH/sXFQ/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782984622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lWylP9b9cdUhMWrvdJZr9qFySJU8pT1hzR7f9NrXow=;
	b=zHrAXApMECnqKbUH+JL7S7nVqoe6kzJ9OwVhYbDJIsfVlj+nEWi+3Wco6HCWABTCBRZMGY
	tNSSriZ3TujLsoDA==
Date: Thu, 2 Jul 2026 11:30:20 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Zong Li <zong.li@sifive.com>, Nam Cao <namcao@linutronix.de>,
	Deepak Gupta <debug@rivosinc.com>,
	Lukas Gerlach <lukas.gerlach@cispa.de>,
	Rui Qi <qirui.001@bytedance.com>, Kees Cook <kees@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [RFC] entry: Untangle the return value of
 syscall_enter_from_user_mode from syscall NR
Message-ID: <akYvrFoMaw4tLuSd@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
 <BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com>
X-Spam-Flag: NO
X-Spam-Level: ***
X-Spamd-Bar: +++
X-Spam-Score: 3.99
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21491-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[msuchanek@suse.de,linux-s390@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[45];
	FORGED_RECIPIENTS(0.00)[m:hpa@zytor.com,m:peterz@infradead.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:andrew+kernel@donnellan.id.au,m:mark.rutland@arm.com,m:arnd@arndb.de,m:jiaxun.yang@flygoat.com,m:ryan.roberts@arm.com,m:gregkh@linuxfoundation.org,m:mkchauras@linux.ibm.com,m:sshegde@linux.ibm.com,m:zong.li@sifive.com,m:namcao@linutronix.de,m:debug@rivosinc.com,m:lukas.gerlach@cispa.de,m:qirui.001@bytedance.com,m:kees@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs.org
 ,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:andrew@donnellan.id.au,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[infradead.org,lwn.net,linuxfoundation.org,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,donnellan.id.au,arm.com,arndb.de,flygoat.com,sifive.com,linutronix.de,rivosinc.com,cispa.de,bytedance.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[msuchanek@suse.de,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[linux-s390,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.de:dkim,suse.de:email,suse.de:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,kunlun.suse.cz:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B96936F6198

On Wed, Jul 01, 2026 at 11:29:01AM -0700, H. Peter Anvin wrote:
> On July 1, 2026 10:42:08 AM PDT, "Michal Suchánek" <msuchanek@suse.de> wrote:
> >The return value of syscall_enter_from_user_mode is used both for the
> >adjusted syscall number and the indicator that a syscall should be
> >skipped.
> >
> >As seccomp can be invoked on any syscall, including invalid ones this
> >somewhat undermines seccomp.
> >
> >While the seccomp variants that terminate the process do not need to
> >care about this for the filter that sets the syscall return value this
> >disctinction is required.
> >
> >Pass the syscall number as a pointer to the inline entry functions, and
> >use the return value exclusively for the indication that the syscall is
> >already handled.
> >
> >This should avoid the need for the s390 PIF_SYSCALL_RET_SET which is the
> >workaround for exactly this deficiency.
> >
> >If this is desirable the patch could be split into some series that
> >adjusts the code flow where needed so that the final change is mostly
> >mechanical.
> >
> >There is also another way to handle this problem.
> >
> >With x86 using bit 30 to denote compatibility syscall it sounds like
> >declaring syscall number a 30bit quantity would work.
> >
> >Then bit 31 could be used to denote an invalid syscall that can never be
> >executed, and the -1 returned from syscall_enter_from_user_mode would
> >then be inherently invalid.
> >
> >That is so long as no architectures use syscall numbers outside of this
> >range so far, and the limitation is considered fine.
> > 
> 
> Negative numbers most definitely not be assigned as valid system calls, not now, not ever. 

Negativity of a number is a matter of intepretation. Sometimes the
syscall number is decleared as int, sometimes long, sometimes unsigned
long.

Passing -1 to strtoul generates some bit pattern that can then be
compared to another bit pattern inside a seccomp filter program, for
example.

> Therein lies some serious madness.
> 
> I believe setting the syscall number to -1 to skip is an ABI already in e.g. ptrace, so I doubt we can just get rid of it anyway. 

Yes, and seccomp can set the syscall number to -1 indicating it was
handled already even if the number was -1 to start with. While -1 is not
a valid syscall number it can still be filtered, at least on some
architectures.

> I would say as follows:
> 
> Let's formally define that: 
> 
> - valid system call numbers are positive 32-bit numbers, using the appropriate ABI convention for "int".
> 
> - bits [30:n] for some value of n are reserved for architecture-specific flags/modes. MIPS uses an offset of 2000 decimal between its syscall ABIs, which would imply n ~ 11, although I personally think that is too restrictive (MIPS could in fact use such a flag to provide an escape into a larger number space if we ever need more than 2000 system calls.)
> 
> I would suggest n = 24, at least for now. It is easier to give up additional bits later than to claw them back when already used. 
> 
> Thus: 
> 
> 1. The type for a system call is int.
> 
> 2. A valid system call number is always going to be positive.
> 
> 3. Bits [30:24] are available for architecture ABI use. The "architecture independent" part of the system call number is therefore 24 bits wide.

Will that also work correctly with seccomp?

As I understand it the current situation is that on x86 the BPF code
passed to seccomp must filter the compat syscall bit in the PBF code,
and I do not see how restricting the syscall value to 24bit would happen
without changing the seccomp filter API.

See eg. https://lore.kernel.org/linuxppc-dev/akTExSO3ZT7iRtBa@kunlun.suse.cz/
for sample code.

> 
> 4. The exact ABI is platform-specific, obviously, but as a general guideline (especially for new platforms/ABIs) should follow the rules for a platform "int" if practical. Notably, when passing a value in a register larger than 32 bits, which side of the calling interface is responsible for sign-extending a value passed in a register. If caller side, the kernel should validate, if callee side the kernel should ignore the additional bits and do the extension.

Do we even want to play with sign-extend?

If the syscall number is >= 1<<n after masking off flags recognized by
the platfrom (if any) it's invalid.

> 5. A negative system call number is guaranteed to return -ENOSYS (unless intercepted by seccomp, ptrace, or another mechanism under user space control.)

Interception by seccomp is exactly the case that's wonky.

> 6. If the platform needs to algorithmically modify the system call number due to platform-specific concerns (say, the platform uses a 16-bit special purpose register for the syscall number, or it has multiple kernel entry points with different behavior), it should if at all possible transcode the system call number as necessary to match this convention in APIs that are exposed to general kernel code. 
> 
> For example, in the future I could very much see the IA32 code in the x86 kernel using bit 29 internally to indicate an ia32 system call, simplifying the is_compat implementation on x86. It should not mean that passing bit 29 to either the syscall instruction or int $0x80 will be accepted.

As I understand the code it uses bit 30 for that. Maybe I missed
something?

Thanks

Michal

