Return-Path: <linux-s390+bounces-22107-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HjI0FgGmVGonowMAu9opvQ
	(envelope-from <linux-s390+bounces-22107-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 10:46:57 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D2D748E49
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 10:46:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r+RdOu7X;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gQkdb4P9;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r+RdOu7X;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gQkdb4P9;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22107-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-22107-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA3D43038A5F
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 08:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF803C13FB;
	Mon, 13 Jul 2026 08:45:08 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23443BF684
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 08:44:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932306; cv=none; b=gt/VD1u3Y+2M/vMbWDpyFMOZwI8Rw15Uq/G9d0B2c4YhWbhTzC5ASVPTTGltejzIJz0RI+Tij/Um/zQ2OeHRI/0QOPVgRElZhTYgRM7WB1R0iMw0qUYiOW3gIwFqfFlf1riqyWffb/Z0n8GL560SGuRCwC/kA+2bKo8X2r41BPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932306; c=relaxed/simple;
	bh=bZ34bsvXlV3rjb/Mxe/xt4IzULpQTffhX4j3vdYGiAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6II4eTUfaKNPrzxF/EGcxSM29xv0G8rZ/5Ols9KrFwOZRKwjrT57zlUoc/oZSz6+V3bZ7YohHGEme3s+17HrOXqUD8fgAsbVo30looAK/RhW5rqwIcgEszCbH9XFLkp68UGry0HhyjCpPc+WYHsXP8IFUawLAeM4ygRxXEgGn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r+RdOu7X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gQkdb4P9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r+RdOu7X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gQkdb4P9; arc=none smtp.client-ip=195.135.223.131
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BA357744E;
	Mon, 13 Jul 2026 08:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783932292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wOqYLE7XCd1dyoTtB3Uni1tJhG2ZPfNesMlKhEUlxw0=;
	b=r+RdOu7XiG6HWhbr9pAG6XGyeZKMMBFIRjat/72NL2mbYxHP0zrOB3f3QilNPJI7q3w5xs
	wVeyVaHVmQa0RWsKdSNXdpZ68FK/P6qCgxIqCmH0rzBIz1yc8AtG57aGojuCq+btSgCdJM
	kMgpjbKEFSn/eBjKsOd+YBfrfwpNGCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783932292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wOqYLE7XCd1dyoTtB3Uni1tJhG2ZPfNesMlKhEUlxw0=;
	b=gQkdb4P9HbkQTKS5EkCscMvwW0dRzYA0YniAiaIdT5hSQuexB294AZ+icFllO6E4kklxGL
	Yl2ucsTSYxhqrIBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783932292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wOqYLE7XCd1dyoTtB3Uni1tJhG2ZPfNesMlKhEUlxw0=;
	b=r+RdOu7XiG6HWhbr9pAG6XGyeZKMMBFIRjat/72NL2mbYxHP0zrOB3f3QilNPJI7q3w5xs
	wVeyVaHVmQa0RWsKdSNXdpZ68FK/P6qCgxIqCmH0rzBIz1yc8AtG57aGojuCq+btSgCdJM
	kMgpjbKEFSn/eBjKsOd+YBfrfwpNGCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783932292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wOqYLE7XCd1dyoTtB3Uni1tJhG2ZPfNesMlKhEUlxw0=;
	b=gQkdb4P9HbkQTKS5EkCscMvwW0dRzYA0YniAiaIdT5hSQuexB294AZ+icFllO6E4kklxGL
	Yl2ucsTSYxhqrIBA==
Date: Mon, 13 Jul 2026 10:44:51 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Radu Rendec <radu@rendec.net>
Subject: Re: [patch 4/4] entry, treewide: Make
 syscall_enter_from_user_mode[_work]() indicate syscall execution
Message-ID: <alSlg72c8xmjaj48@kunlun.suse.cz>
References: <20260712134433.549076055@kernel.org>
 <20260712141346.772209074@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712141346.772209074@kernel.org>
X-Spam-Flag: YES
X-Spam-Level: **************
X-Spamd-Bar: ++++++++++++++
X-Spam-Score: 14.88
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:mpe@ellerman.id.au,m:sshegde@linux.ibm.com,m:linuxppc-dev@lists.ozlabs.org,m:chenhuacai@kernel.org,m:loongarch@lists.linux.dev,m:pjw@kernel.org,m:palmer@dabbelt.com,m:linux-riscv@lists.infradead.org,m:svens@linux.ibm.com,m:linux-s390@vger.kernel.org,m:x86@kernel.org,m:mark.rutland@arm.com,m:ruanjinjie@huawei.com,m:linmag7@gmail.com,m:mkchauras@gmail.com,m:corbet@lwn.net,m:radu@rendec.net,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[msuchanek@suse.de,linux-s390@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22107-lists,linux-s390=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[msuchanek@suse.de,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,ellerman.id.au,linux.ibm.com,lists.ozlabs.org,kernel.org,lists.linux.dev,dabbelt.com,lists.infradead.org,arm.com,huawei.com,gmail.com,lwn.net,rendec.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kunlun.suse.cz:mid,suse.de:from_mime,suse.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4D2D748E49

Hello,

On Sun, Jul 12, 2026 at 11:25:32PM +0200, Thomas Gleixner wrote:
> The return values of syscall_enter_from_user_mode[_work]() are
> non-intuitive. Both functions return the syscall number which should be
> invoked by the architecture specific syscall entry code. The returned
> number can be:
> 
>   - the unmodified syscall number which was handed in by the caller
> 
>   - a modified syscall number (ptrace, seccomp, trace/probe/bpf)
> 
> That has an additional twist. If the return value is -1L then the caller is
> not allowed to modify the return value as that indicates that the modifying
> entity requests to abort the syscall and set the return value already. That
> can obviously not be differentiated from a syscall which handed in -1 as
> syscall number.
> 
> The most trivial way to deal with that is:
> 
>     set_return_value(regs, -ENOSYS);
>     nr = syscall_enter_from_user_mode(regs, nr);
>     if (valid(nr))
>     	handle_syscall(regs, nr);
> 
> That's what LOONGARCH, RISCV, and X86 do. But PowerPC and S390 do not
> preset the return value, so when user space hands in -1 and there is
> nothing setting the return value in the entry work code, then the syscall
> is skipped but the return value is whatever random data has been in the
> return value register.

The reason why PowerPC and S390 do not preset the return value is that
the return value uses the same register as the syscall number. There are
apparently other architectures on which the return value overlaps with
the arguments which also do not preset the return value for that reason.
If they would use the generic entry the same problem would arise.

> Change the return values of syscall_enter_from_user_mode[_work]() to
> boolean and return false, when either ptrace or seccomp request to skip the

There is a difference between seccomp and ptrace.

When seccomp indicates to skip the syscall it has also set the syscall
return value.

However, when the syscall number is -1 and the return value is not
preset that does not indicate anything.

The return value can still hold garbage. ptrace does not have the
ability to indicate that a syscall is to be skipped, at least on the
entry trace. It needs to be skipped based on the syscall number being
invalid.

Thanks

Michal

