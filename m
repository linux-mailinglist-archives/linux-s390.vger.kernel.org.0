Return-Path: <linux-s390+bounces-21525-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id djrgILt/R2p0ZgAAu9opvQ
	(envelope-from <linux-s390+bounces-21525-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 03 Jul 2026 11:24:11 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C901700987
	for <lists+linux-s390@lfdr.de>; Fri, 03 Jul 2026 11:24:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CbRmmERq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IocVvEyL;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Xmvd85vR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hGkTJQ74;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21525-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-21525-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47EC730921FC
	for <lists+linux-s390@lfdr.de>; Fri,  3 Jul 2026 07:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4B4370AD5;
	Fri,  3 Jul 2026 07:54:01 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA52371D0A
	for <linux-s390@vger.kernel.org>; Fri,  3 Jul 2026 07:53:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065241; cv=none; b=YShBSYM0O35kpY1M089H4LcsPk7SV4isRLuYXH2UjPPp72XAUzNfKn/AN3Wg/plgBsav0C36mqse1twZ+/CrrCT2W9CIx7fY69dYSYvKIKlbvnRRubmjIlS8salOTK+uRPZ03g0OpJNgI9NpcsJaoVH/CXixEanoVD12uoGBV9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065241; c=relaxed/simple;
	bh=Jo1HaNhObHl7wG20yGqS3718LydcoLNWIaNtvzbyLyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVGufO56u6+tSKSTd3KPRF9z1McvPiF2iRtZngw3Yo2koLrzyX/Q2tzmsqXvvQxyIlNCs+t/VrOQsm9rdOfVRSkoPwxZQYTjMXnrWTrflcoMB/+z9m74o2JPLfmmq1APkPq9Uet6vSLoxB4/WEFxmXrWY5+bsoKtSXRmLK6Jmr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CbRmmERq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IocVvEyL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xmvd85vR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hGkTJQ74; arc=none smtp.client-ip=195.135.223.131
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBA9F7618A;
	Fri,  3 Jul 2026 07:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783065238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86AOamRcFcJIzmtTIHlbMlj4CRLkggYnO20t0jZshpc=;
	b=CbRmmERqfWieu4ysWTh10omj+YQCxVfB6dtLRO5KwpMHTtbWI+HMjDSfkdmWL6Z5tBwSs0
	64dI9grAIJDKA53bwvMISb6ax0xKvJuXpWIS4xJvcO2WNzHkbVy0dGLLrFfoOL/of8MbJZ
	G8zUR0YbYZJ05OGL/vLxC4OMac4mNf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783065238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86AOamRcFcJIzmtTIHlbMlj4CRLkggYnO20t0jZshpc=;
	b=IocVvEyLW43oonFkQ+U2aar5zYKMFxmM4+MchCTOViE1CdZikSQHLgiS6R7lAvS5xh7nj2
	a6Dtpaov7ehMQpDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783065237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86AOamRcFcJIzmtTIHlbMlj4CRLkggYnO20t0jZshpc=;
	b=Xmvd85vRfIousfUHpOVFKa/+9oD4iF1jN72BWQqdOKQeyot1g8dqDeb96zST6xXQUnrWZd
	B/kWaO83Faf+lmPKFWp4CBuZksHwyAp3cMta7AX/exjpEQS9rlrW5BHFIn5WBCg9O1H8iE
	iaNxS6PbUufL/OKXF41SzStOrutbeHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783065237;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86AOamRcFcJIzmtTIHlbMlj4CRLkggYnO20t0jZshpc=;
	b=hGkTJQ74isW/5ugiXaiIuvBc0DJmprtXDaMZ10c37l+VbtperReN+4kbg0PGnbQNDEOVJn
	gCgyD/JHPKJMedDA==
Date: Fri, 3 Jul 2026 09:53:56 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Thomas Gleixner <tglx@kernel.org>
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
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
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
Message-ID: <akdqlO0eJ6jKH-wU@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
 <878q7tprau.ffs@fw13>
 <akZPakNl6JT_jgGd@kunlun.suse.cz>
 <87jyrdnmrh.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jyrdnmrh.ffs@fw13>
X-Spamd-Bar: ++++++++++++++++
X-Spam-Flag: YES
X-Spam-Score: 16.54
X-Spam-Level: ****************
X-Rspamd-Action: no action
X-Spamd-Result: default: False [4.34 / 15.00];
	SPAM_FLAG(5.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:peterz@infradead.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:luto@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:andrew+kernel@donnellan.id.au,m:mark.rutland@arm.com,m:arnd@arndb.de,m:jiaxun.yang@flygoat.com,m:ryan.roberts@arm.com,m:gregkh@linuxfoundation.org,m:mkchauras@linux.ibm.com,m:sshegde@linux.ibm.com,m:zong.li@sifive.com,m:namcao@linutronix.de,m:debug@rivosinc.com,m:lukas.gerlach@cispa.de,m:qirui.001@bytedance.com,m:kees@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs.org
 ,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:andrew@donnellan.id.au,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER(0.00)[msuchanek@suse.de,linux-s390@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[45];
	TAGGED_FROM(0.00)[bounces-21525-lists,linux-s390=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[msuchanek@suse.de,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[infradead.org,lwn.net,linuxfoundation.org,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,zytor.com,donnellan.id.au,arm.com,arndb.de,flygoat.com,sifive.com,linutronix.de,rivosinc.com,cispa.de,bytedance.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:from_mime,suse.de:dkim,kunlun.suse.cz:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C901700987

On Thu, Jul 02, 2026 at 10:45:54PM +0200, Thomas Gleixner wrote:
> On Thu, Jul 02 2026 at 13:45, Michal Suchánek wrote:
> > On Thu, Jul 02, 2026 at 01:24:57PM +0200, Thomas Gleixner wrote:
> >> On Wed, Jul 01 2026 at 19:42, Michal Suchánek wrote:
> >> > The return value of syscall_enter_from_user_mode is used both for the
> >> > adjusted syscall number and the indicator that a syscall should be
> >> > skipped.
> >> >
> >> > As seccomp can be invoked on any syscall, including invalid ones this
> >> > somewhat undermines seccomp.
> >> >
> >> > While the seccomp variants that terminate the process do not need to
> >> > care about this for the filter that sets the syscall return value this
> >> > disctinction is required.
> >> 
> >> You completely fail to explain why and what actual problem you are
> >> trying to solve. At least I can't figure it out from the above word
> >> salad.
> >
> > syscall_enter_from_user_mode returns the new syscall number after doing
> > something arbitrarry with it, including running seccomp.
> >
> > Wehn the syscall is already handled, eg. by seccomp filtering it returns
> > -1 as the new syscall number. -1 is an invalid syscall number but it can
> > still be filtered by seccomp.
> 
> Once syscall_enter_from_user_mode() returns -1 nothing can filter it
> anymore.
> 
> > When the syscall number was -1 to start with it's not possible to
> > determine if the syscall was fileterd from the return value. s390
> > returns the filtered state in a flag it sets on the regs structure,
> > avoiding this problem.
> 
> What needs to determine whether the syscall was filtered or not?

The code that executes syscall_enter_from_user_mode() needs to determine
that.

After syscall_enter_from_user_mode() returns the syscall needs to be
executed or skipped.

'Executing' an invalid syscall boils down to setting the return value to
-ENOSYS.

But if the syscall number returned is -1 was the syscall filtered and
the return value set by syscall_enter_from_user_mode() or should it be
set by the caller to -ENOSYS?

> 
> > However, the API should be specified in a way that does not require
> > everyone implementing such flag.
> 
> Which exact problem does the flag solve?

To be able to tell if the syscall was handled or no, the return value
from syscall_enter_from_user_mode() is inconclusive.

That's what the flag is for. To be able to tell if the syscall was
handled without relying on the ambiguous return value of
syscall_enter_from_user_mode().

Thanks

Michal

