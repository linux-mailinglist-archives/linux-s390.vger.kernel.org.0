Return-Path: <linux-s390+bounces-20551-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FzB2MPxuImq0XAEAu9opvQ
	(envelope-from <linux-s390+bounces-20551-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 05 Jun 2026 08:38:52 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C9F645944
	for <lists+linux-s390@lfdr.de>; Fri, 05 Jun 2026 08:38:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=kernel.org header.s=k20260515 header.b=H4dTp+wV;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20551-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20551-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0E9830D7698
	for <lists+linux-s390@lfdr.de>; Fri,  5 Jun 2026 06:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382224218A5;
	Fri,  5 Jun 2026 06:30:22 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC42408033;
	Fri,  5 Jun 2026 06:30:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641022; cv=none; b=qfTQ6/TLCO0QAFhPAwjeKzIrfTPHPp/u+hCaxJPz7zkej5mbudYvb2cH5XzuJWTNXVaVBfrNMXu30Z2ohDuH3QcMHTpXjwf+5Hvc9d34eP3pMVV8rS7uWSMsjhTJJH7iWjlzpwqdlDZk1s1QjmG67s6Jb2E/03RzqQXZuBVGWxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641022; c=relaxed/simple;
	bh=b7fyKzhjw4yx3OaqAa3FKuCwhuCp9NuXnczYKyFON00=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UhFftrMDU+4CLJl5lKP259bKhhkcuJ5Q/mwMw7DbDrwEpjhS1Rw2oG80F5jBWJLf+Ri3uIqZu8xiDYNUgH5qHXRgPuH5pbty7cnRchgRw8u7z8uMQps5LPaH9G1+1O/6fd1KaS/aIJuVQs5wQRnHZcP4EElDEFr30BtA0/fBtZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4dTp+wV reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53EC1F00893;
	Fri,  5 Jun 2026 06:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780641020;
	bh=ZuCEbTdg7Jvg/3RTGozyLFZtT0FjVHWOOoiUv+zGjX8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=H4dTp+wVDiRNcUShgm1dL5dR6Tk83U4HJ3+rbGVRR2YEQt9BGsgO6w0jLtbvThZLx
	 AyyU7p0Z/0eIMfhQQFZvPw4FjH/6jaKXWtQ1rFzkGeewQpukxF1bejycPV5P2pxt94
	 4Z/a2iSiVNzHCgdYm3sDI/uPYEICv4kGu52Ya2Bh1CTftj0yqZp3A7D51TstjWB5AS
	 DRSg8zbg4eTysQr4pKWQlt+Lrni9PITOiUg/HgOrBNoVk1WsWkR3ueAZuWQKjZtiXA
	 umEJLRkkAN5OIbh6H0UdUQ4AM39TQ8rPBGytoRWDg0yTBchxBEEEgU/7e3LDF5Gy/X
	 jDGbyjUG7DthA==
Content-Type: multipart/mixed; boundary="===============2479707455285012343=="
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ab3d42abe5ed92f3a7c40a961ed14ae1dbad4789f9d41b0c484a020e723e8ac4@mail.kernel.org>
In-Reply-To: <20260605054128.5925-11-boqun@kernel.org>
References: <20260605054128.5925-11-boqun@kernel.org>
Subject: Re: [PATCH v3 10/13] preempt: Introduce HAS_SEPARATE_PREEMPT_RESCHED_BITS
From: bot+bpf-ci@kernel.org
To: boqun@kernel.org,peterz@infradead.org
Cc: catalin.marinas@arm.com,will@kernel.org,jonas@southpole.se,stefan.kristiansson@saunalahti.fi,shorne@gmail.com,hca@linux.ibm.com,gor@linux.ibm.com,agordeev@linux.ibm.com,borntraeger@linux.ibm.com,svens@linux.ibm.com,tglx@kernel.org,mingo@redhat.com,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,arnd@arndb.de,juri.lelli@redhat.com,vincent.guittot@linaro.org,dietmar.eggemann@arm.com,rostedt@goodmis.org,bsegall@google.com,mgorman@suse.de,vschneid@redhat.com,kprateek.nayak@amd.com,boqun@kernel.org,longman@redhat.com,akpm@linux-foundation.org,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,ojeda@kernel.org,gary@garyguo.net,bjorn3_gh@protonmail.com,lossin@kernel.org,a.hindborg@kernel.org,aliceryhl@google.com,tmgross@umich.edu,dakr@kernel.org,ruanjinjie@huawei.com,lyude@redhat.com,thuth@redhat.com,sohil.mehta@intel.com,pawan.kumar.
 gupta@linux.intel.com,seanjc@google.com,nikunj@amd.com,xin@zytor.com,joelagnelf@nvidia.com,andriy.shevchenko@linux.intel.com,rdunlap@infradead.org,ynorov@nvidia.com,bigeasy@linutronix.de,linux-kernel@vger.kernel.org,linux-openrisc@vger.kernel.org,linux-s390@vger.kernel.org,linux-arch@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,rust-for-linux@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 06:30:18 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,southpole.se,saunalahti.fi,gmail.com,linux.ibm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linaro.org,goodmis.org,google.com,suse.de,amd.com,linux-foundation.org,iogearbox.net,linux.dev,garyguo.net,protonmail.com,umich.edu,huawei.com,intel.com,nvidia.com,infradead.org,linutronix.de,vger.kernel.org,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,linux-s390@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-20551-lists,linux-s390=lfdr.de,bpf-ci];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:boqun@kernel.org,m:peterz@infradead.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:jonas@southpole.se,m:stefan.kristiansson@saunalahti.fi,m:shorne@gmail.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:arnd@arndb.de,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:kprateek.nayak@amd.com,m:longman@redhat.com,m:akpm@linux-foundation.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:ojeda@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@goo
 gle.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:ruanjinjie@huawei.com,m:lyude@redhat.com,m:thuth@redhat.com,m:sohil.mehta@intel.com,m:pawan.kumar. gupta@linux.intel.com,m:seanjc@google.com,m:nikunj@amd.com,m:xin@zytor.com,m:joelagnelf@nvidia.com,m:andriy.shevchenko@linux.intel.com,m:rdunlap@infradead.org,m:ynorov@nvidia.com,m:bigeasy@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-openrisc@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-arch@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[76];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.kernel.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22C9F645944

--===============2479707455285012343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f3f7cb01d69d..bf8288b3d52b 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -327,6 +327,7 @@ config X86
>  	select USER_STACKTRACE_SUPPORT
>  	select HAVE_ARCH_KCSAN			if X86_64
>  	select PROC_PID_ARCH_STATUS		if PROC_FS
> +	select HAS_SEPARATE_PREEMPT_RESCHED_BITS		if X86_64
>  	select HAVE_ARCH_NODE_DEV_GROUP		if X86_SGX

A subsystem pattern flags this as potentially concerning: selecting
HAS_SEPARATE_PREEMPT_RESCHED_BITS with only the X86_64 condition may
bypass the PREEMPT_COUNT dependency.

Looking at the definition in kernel/Kconfig.preempt, the config symbol
HAS_SEPARATE_PREEMPT_RESCHED_BITS explicitly depends on both PREEMPT_COUNT
and 64BIT:

kernel/Kconfig.preempt:
    config HAS_SEPARATE_PREEMPT_RESCHED_BITS
        bool
        depends on PREEMPT_COUNT && 64BIT

PREEMPT_COUNT is not always enabled. It gets selected by PREEMPTION, and
by a few debug configs (CONFIG_DEBUG_PREEMPT, DEBUG_ATOMIC_SLEEP,
PREEMPT_TRACER, etc.), but a standard CONFIG_PREEMPT_NONE=y configuration
without any of those debug options will have PREEMPT_COUNT=n.

In such a configuration, the select statement (gated only by X86_64)
will force HAS_SEPARATE_PREEMPT_RESCHED_BITS=y while its depends on
PREEMPT_COUNT is unmet. This will produce a Kconfig unmet-dependency
warning: "WARNING: unmet direct dependencies detected for
HAS_SEPARATE_PREEMPT_RESCHED_BITS / Depends on [n]: PREEMPT_COUNT &&
64BIT / Selected by [y]: - X86 [=y]".

Sashiko-bot raised this concern in both v2 and v3 of this patch (message
IDs <20260526195703.C90E31F000E9@smtp.kernel.org> and
<20260605055956.46EC81F00893@smtp.kernel.org>), escalating it from Low to
Medium severity:

https://lore.kernel.org/all/20260605055956.46EC81F00893@smtp.kernel.org/

Should this select be conditional on PREEMPT_COUNT? For example:

    select HAS_SEPARATE_PREEMPT_RESCHED_BITS  if X86_64 && PREEMPT_COUNT

[ ... ]

> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index 88c594c6d7fc..35f546a042b1 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -122,6 +122,10 @@ config PREEMPT_RT_NEEDS_BH_LOCK
>  config PREEMPT_COUNT
>         bool
>
> +config HAS_SEPARATE_PREEMPT_RESCHED_BITS
> +	bool
> +	depends on PREEMPT_COUNT && 64BIT
> +

This commit fixes a bug but lacks a Fixes: tag. The commit corrects
underflow detection logic in preempt_count_sub() by changing from a signed
comparison to unsigned wraparound detection. The bug was introduced when
commit 7c346d37f86b expanded the preempt_count bit layout by adding 8-bit
HARDIRQ_DISABLE_BITS, increasing total bit usage from 21 to 29 bits.

This expansion highlighted the flaw in the existing signed comparison
underflow check (val > preempt_count()), which doesn't correctly detect
unsigned underflow. The fix properly uses unsigned arithmetic (pc - uval >
pc) to detect wraparound.

Should this include:

  Fixes: 7c346d37f86b ("preempt: Introduce HARDIRQ_DISABLE_BITS")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26998319662
--===============2479707455285012343==--

