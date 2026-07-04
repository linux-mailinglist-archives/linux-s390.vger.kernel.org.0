Return-Path: <linux-s390+bounces-21565-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WOGSAK1ESWpqzwAAu9opvQ
	(envelope-from <linux-s390+bounces-21565-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Sat, 04 Jul 2026 19:36:45 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 529297081B0
	for <lists+linux-s390@lfdr.de>; Sat, 04 Jul 2026 19:36:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=zytor.com header.s=2026062701 header.b=CJF5CAKR;
	dmarc=pass (policy=none) header.from=zytor.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21565-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21565-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DCC6300F5F4
	for <lists+linux-s390@lfdr.de>; Sat,  4 Jul 2026 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1650320CBE;
	Sat,  4 Jul 2026 17:36:41 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0CF35E1B1;
	Sat,  4 Jul 2026 17:36:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783186601; cv=none; b=B+3mp6MISNcNXHPpamlb9ox9fr91BJZbbWkO26WnRHXh672bdaIrAtlaVJCj/N8d/cLygzLDrl06HaDrEOQNrzrnebGawQNtq4tAYGKoYlbiHDTsQESIRgwOKpfo3Xpgz+UylPqX0tHnDrtLU+PJ2ZWHDvJGQaPPzOHi7YEkYP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783186601; c=relaxed/simple;
	bh=dTFud6IYNn4nvyg1znQWrkcJonRufF/qiM6XZzzUK0c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=b7CTBvpxeFqPcZ3YmE0g8a2g/0p6vXjSxDQ1e6NHBf5crSLjsxKf5YV1KH2nQNCYN4rcidX6LwOnimdKTlNArWGJQVSOipTAJ4644WATcW5cHOAK4ZxJdFMzb3DxKsIxu81VFuyXM32MpZELeiklnYO4l8F3Cp6oj2j/W3D3t1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=CJF5CAKR; arc=none smtp.client-ip=198.137.202.136
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 664HJ3VH1732288
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 4 Jul 2026 10:19:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 664HJ3VH1732288
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1783185548;
	bh=dTFud6IYNn4nvyg1znQWrkcJonRufF/qiM6XZzzUK0c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=CJF5CAKRz4eNOPyR8kG0iAzsmyc+IwhntrZI2+KNzBcxTwm4Pcp7ISaY7lclR6A+T
	 R6iud2HrZonYFu7Ng8lIZ2Zy+h6YMeauv3txYKWEhoUf4+sfZRGAxFauHe9YYLo4uT
	 C6dgcvSiTqEU+iIkY6G3PGqbNZPx4bFWNID7VQM3t0H3q9hYfHNBXSLVMX7VMkyGoT
	 AchFenE1pkrCZJeaXw8wK9l7BRpqKAAfu9aoRxmSUBXrsCED1ggSW/SS3uws8TW93A
	 TkiqPgvXsUI43KFbqW08LGibZW5bbrWgmswEj6zjL2nzb2J1On7jMSJi4qiHbO8w3j
	 5g1n/GjjLwl9A==
Date: Sat, 04 Jul 2026 10:18:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Sven Schnelle <svens@linux.ibm.com>,
        =?ISO-8859-1?Q?Michal_Such=E1nek?= <msuchanek@suse.de>
CC: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Andrew Donnellan <andrew+kernel@donnellan.id.au>,
        Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, Zong Li <zong.li@sifive.com>,
        Nam Cao <namcao@linutronix.de>, Deepak Gupta <debug@rivosinc.com>,
        Lukas Gerlach <lukas.gerlach@cispa.de>,
        Rui Qi <qirui.001@bytedance.com>, Kees Cook <kees@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BRFC=5D_entry=3A_Untangle_the_return_value_of?=
 =?US-ASCII?Q?_syscall=5Fenter=5Ffrom=5Fuser=5Fmode_from_syscall_NR?=
User-Agent: K-9 Mail for Android
In-Reply-To: <yt9dtsqg480p.fsf@linux.ibm.com>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz> <BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com> <87h5mhnjsr.ffs@fw13> <yt9dwlvca8rn.fsf@linux.ibm.com> <87ldbsmnie.ffs@fw13> <yt9d5x2w5r84.fsf@linux.ibm.com> <20260703105718.GO751831@noisy.programming.kicks-ass.net> <akecJWAJP-e5CYP_@kunlun.suse.cz> <yt9dtsqg480p.fsf@linux.ibm.com>
Message-ID: <69ACC6A7-7845-41B4-B0D0-2E6FCDA7443D@zytor.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026062701];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:svens@linux.ibm.com,m:msuchanek@suse.de,m:peterz@infradead.org,m:tglx@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:luto@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:andrew+kernel@donnellan.id.au,m:mark.rutland@arm.com,m:arnd@arndb.de,m:jiaxun.yang@flygoat.com,m:ryan.roberts@arm.com,m:gregkh@linuxfoundation.org,m:mkchauras@linux.ibm.com,m:sshegde@linux.ibm.com,m:zong.li@sifive.com,m:namcao@linutronix.de,m:debug@rivosinc.com,m:lukas.gerlach@cispa.de,m:qirui.001@bytedance.com,m:kees@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs
 .org,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:andrew@donnellan.id.au,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21565-lists,linux-s390=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,lwn.net,linuxfoundation.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,donnellan.id.au,arm.com,arndb.de,flygoat.com,sifive.com,linutronix.de,rivosinc.com,cispa.de,bytedance.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.infradead.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hpa@zytor.com,linux-s390@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[zytor.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390,kernel];
	RCPT_COUNT_TWELVE(0.00)[45];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 529297081B0

On July 3, 2026 4:39:18 AM PDT, Sven Schnelle <svens@linux=2Eibm=2Ecom> wro=
te:
>Michal Such=C3=A1nek <msuchanek@suse=2Ede> writes:
>
>> The same could be asked of syscall_enter_from_user_mode=2E I find it ve=
ry
>> odd=2E Why does it conflate the syscall number with its return value?
>>
>> It never uses the syscall number passed in except when returning it
>> unchanged=2E When it pokes the registers it reads the syscall number fr=
om
>> them=2E
>>
>> If the caller of syscall_enter_from_user_mode only read the syscall
>> number from the registers when syscall_enter_from_user_mode returns and
>> indicates the syscall should be still executed this whole shenigan woul=
d
>
>I agree=2E The fact that if (nr < NR_syscall) just works because -1 gets
>casted to 0xffffffff and is therefore out of bounds is very odd=2E
>

Not at all strange=2E It is an *extremely* common construct in C, especial=
ly for range checking values into [0, n)=2E

In addition to being idiomatic, keep in mind that this is one of the absol=
utely most performance critical paths in the entire kernel=2E One of the fu=
ndamental cornerstones behind Unix is to keep system calls cheap so that th=
ey can be simple building blocks for more complex operations=2E It is not t=
he only possible design philosophy, but it is the one we chose to adopt, qu=
ite successfully=2E

The downside? Squeezing every possible cycle out of the system call path b=
ecomes one of the most essential tuning tasks=2E The good part is that keep=
ing the system call path clean also makes it maintainable, even when there =
are quirks=2E

