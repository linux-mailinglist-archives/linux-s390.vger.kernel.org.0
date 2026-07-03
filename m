Return-Path: <linux-s390+bounces-21526-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UqMUBByDR2qFZwAAu9opvQ
	(envelope-from <linux-s390+bounces-21526-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 03 Jul 2026 11:38:36 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35501700B6D
	for <lists+linux-s390@lfdr.de>; Fri, 03 Jul 2026 11:38:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=jbJkBVOT;
	dmarc=pass (policy=none) header.from=infradead.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21526-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21526-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A9513044116
	for <lists+linux-s390@lfdr.de>; Fri,  3 Jul 2026 09:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700713B42C1;
	Fri,  3 Jul 2026 09:26:36 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB183B3BE9;
	Fri,  3 Jul 2026 09:26:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070796; cv=none; b=UaYmeMYFafyna1IWBfVjBS3wrVhgqfPEl2V8CHNdDvM3VPLQz/z5OVSUCBlkHTydP2ONnjwOu3yso4FUA2BOe9GtPNE3xffA4NRXxlwzp34jFcIfP92IgNDjqB6opa8uPblwE5jbiqe5XJMVD5CNeiwkT5Tmv/UkC6QPaUpBM5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070796; c=relaxed/simple;
	bh=XKVidnSNN3InnpyZdVJSXMV5TalS8iCBJQsbAHe4kT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeAsE6HOixfA4hCymk7/PtiEEyn7jEXv8Bl2DghMAXuFMdZtFCqEzTTcJeeSvLiiMeV4PLk1EB6eff0dcWWv/vxythH9pgM6NbMGfalU2Ho4WcB/PEtthu83oLopp+bKDYasK2jBiQasd5i99Su2wUyRmikDxXVzVJeILVqcUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jbJkBVOT; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MPQJV7b7kJxx5txnyZHmL5S4FKlfiNVgVgnkVZMZ+6g=; b=jbJkBVOT/shtiot9Fc2pimpU1C
	HwNC+VKHJMncmc41AF6pUNHHSHoEGiATR5ncPKDf0gGLbv+67XpsMWxpomqvnEWns2uuBP/NddLZt
	steywxZ4WKc2RcW1NM+uxAnQdAAw132ojGrke1r7Pofyl1JkngSK/ZT8m/vnNnUJ/rn4JTxBKp4i0
	U/ASGh0yXX0fXF6pY9FpYaAqDi7txgXPudLUNWL3sk5/nxO8P6rEIu7ZbmelZsUVKfX0VljoEPfZm
	Xs/7RlQubEXJnZR7hTst9g4bBclCh3APcrjBGKulmX625kzp3ZyHOw+tSbkdVvEtqZOW0J1c9UbOk
	HiJJGH8Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfa9Z-0000000A4v3-364Y;
	Fri, 03 Jul 2026 09:25:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7451030035C; Fri, 03 Jul 2026 11:25:44 +0200 (CEST)
Date: Fri, 3 Jul 2026 11:25:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Jonathan Corbet <corbet@lwn.net>,
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
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20260703092544.GB651302@noisy.programming.kicks-ass.net>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
 <BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com>
 <87h5mhnjsr.ffs@fw13>
 <yt9dwlvca8rn.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dwlvca8rn.fsf@linux.ibm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21526-lists,linux-s390=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:svens@linux.ibm.com,m:tglx@kernel.org,m:hpa@zytor.com,m:msuchanek@suse.de,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:luto@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:andrew+kernel@donnellan.id.au,m:mark.rutland@arm.com,m:arnd@arndb.de,m:jiaxun.yang@flygoat.com,m:ryan.roberts@arm.com,m:gregkh@linuxfoundation.org,m:mkchauras@linux.ibm.com,m:sshegde@linux.ibm.com,m:zong.li@sifive.com,m:namcao@linutronix.de,m:debug@rivosinc.com,m:lukas.gerlach@cispa.de,m:qirui.001@bytedance.com,m:kees@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs.org,m:
 linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:andrew@donnellan.id.au,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[peterz@infradead.org,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,zytor.com,suse.de,lwn.net,linuxfoundation.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,donnellan.id.au,arm.com,arndb.de,flygoat.com,sifive.com,linutronix.de,rivosinc.com,cispa.de,bytedance.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390,kernel];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noisy.programming.kicks-ass.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,infradead.org:from_mime,infradead.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35501700B6D

On Fri, Jul 03, 2026 at 08:26:36AM +0200, Sven Schnelle wrote:

> The difference between x86 and s390 is that on s390, regs->gprs[2] is
> used for both the syscall number and the syscall return value.
> That was a design mistake early in the begin about 25 years ago, but
> it's ABI now, so it cannot be changed.
> 
> When seccomp decides to skip a syscall, it write a return value into
> regs->gprs[2]. When syscall_enter_from_user_mode_work() returns, it
> returns this number. If it's negative all is good - the 'if (likely(nr <
> NR_syscalls))' conditiion would just catch it and skip the syscall.

You do have regs->orig_gpr2; I didn't fully track its usage, but can't
you treat that as the syscall nr and always consider regs->gprs[2] as the
return value?

