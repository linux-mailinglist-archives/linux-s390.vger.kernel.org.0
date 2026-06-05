Return-Path: <linux-s390+bounces-20550-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iXM2Ae1uImqvXAEAu9opvQ
	(envelope-from <linux-s390+bounces-20550-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 05 Jun 2026 08:38:37 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85546645931
	for <lists+linux-s390@lfdr.de>; Fri, 05 Jun 2026 08:38:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=kernel.org header.s=k20260515 header.b=eqw0eOWZ;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20550-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20550-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1304A30D2D0E
	for <lists+linux-s390@lfdr.de>; Fri,  5 Jun 2026 06:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1131413D6E;
	Fri,  5 Jun 2026 06:30:20 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AB841B34C;
	Fri,  5 Jun 2026 06:30:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641020; cv=none; b=qBz36o2WBgt5ESNYG2gdHjmB3+ManygJZjAkcOYsOzJGcp2nTTUJMKG4fgOiFPC2v4XlQ4w7YoBnY+RcBugNBLwTVK9XQwng4eBzXOZekXEL2GrEyRxqIiAYmZpzj0kTF8QJC/wTNOZRRWKnoeW1UTZTNeXuj5PCDK1eN0lCtqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641020; c=relaxed/simple;
	bh=fgCxOGHw8pCumGTDDYG9TIuZGQ69g3YHe0Qofz0UJoo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kjqfPvTMDd3FWroWLcW4tbX+AHMMwmI3jwx7K3JB8SvHqsgQo1VL9PA3P1DuMdPLu5v7sMv8YXZ1a6Mfm5rjCUEAkU9vq95kHgzvkZWeWqkZLmBBxV0WSWDnzuqtQW4Bp62yDf1OH+247yR0ZUz0UeNC73i/wVxTBbgxGKWRmSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqw0eOWZ reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C781F00898;
	Fri,  5 Jun 2026 06:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780641017;
	bh=Tg6N9VgqQ+N58PL4b7nf1TqxKbx3G9h4ztBKPkW3UxQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eqw0eOWZ8MqaTod2pDQtLpG8PJJQ7HCjLXmOEKZqdJR8seEe68+qybsRKTorOQaNc
	 sdTuQjgGnfzzzfa06NmIURh9NPtbGkcDIqoEPYYLIbk5XEXecbT6pMorj8Lsyd49wQ
	 bPrK2btAbedAIOoCPHq/UCKKF2n+i5A9hr1krRuyovzixKNbE0AWgUpj+d5wpx20lz
	 YXe0SdACeTtGLqAQ3ykaPdnGEvpzWo4kXGF3yR/k8cmkHssWZbYBzHYsI3llvVzN5V
	 0qy9XTcJZmWZAQJSNhDXrvP85lAW0HLA9Egl/dQO0KvBpKsxBExusPg9Y923Rrw2OQ
	 Fn7Sx8qcgl74Q==
Content-Type: multipart/mixed; boundary="===============6478213323594853790=="
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cc4b5fb3f63b8b508334edd883765bf81c9ab1d2045f414a74c8712c6cc705e9@mail.kernel.org>
In-Reply-To: <20260605054128.5925-6-boqun@kernel.org>
References: <20260605054128.5925-6-boqun@kernel.org>
Subject: Re: [PATCH v3 05/13] irq & spin_lock: Add counted interrupt disabling/enabling
From: bot+bpf-ci@kernel.org
To: boqun@kernel.org,peterz@infradead.org
Cc: catalin.marinas@arm.com,will@kernel.org,jonas@southpole.se,stefan.kristiansson@saunalahti.fi,shorne@gmail.com,hca@linux.ibm.com,gor@linux.ibm.com,agordeev@linux.ibm.com,borntraeger@linux.ibm.com,svens@linux.ibm.com,tglx@kernel.org,mingo@redhat.com,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,arnd@arndb.de,juri.lelli@redhat.com,vincent.guittot@linaro.org,dietmar.eggemann@arm.com,rostedt@goodmis.org,bsegall@google.com,mgorman@suse.de,vschneid@redhat.com,kprateek.nayak@amd.com,boqun@kernel.org,longman@redhat.com,akpm@linux-foundation.org,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,ojeda@kernel.org,gary@garyguo.net,bjorn3_gh@protonmail.com,lossin@kernel.org,a.hindborg@kernel.org,aliceryhl@google.com,tmgross@umich.edu,dakr@kernel.org,ruanjinjie@huawei.com,lyude@redhat.com,thuth@redhat.com,sohil.mehta@intel.com,pawan.kumar.
 gupta@linux.intel.com,seanjc@google.com,nikunj@amd.com,xin@zytor.com,joelagnelf@nvidia.com,andriy.shevchenko@linux.intel.com,rdunlap@infradead.org,ynorov@nvidia.com,bigeasy@linutronix.de,linux-kernel@vger.kernel.org,linux-openrisc@vger.kernel.org,linux-s390@vger.kernel.org,linux-arch@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,rust-for-linux@vger.kernel.org,boqun.feng@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 06:30:16 +0000 (UTC)
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
	TAGGED_FROM(0.00)[bounces-20550-lists,linux-s390=lfdr.de,bpf-ci];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:boqun@kernel.org,m:peterz@infradead.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:jonas@southpole.se,m:stefan.kristiansson@saunalahti.fi,m:shorne@gmail.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:arnd@arndb.de,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:kprateek.nayak@amd.com,m:longman@redhat.com,m:akpm@linux-foundation.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:ojeda@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@goo
 gle.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:ruanjinjie@huawei.com,m:lyude@redhat.com,m:thuth@redhat.com,m:sohil.mehta@intel.com,m:pawan.kumar. gupta@linux.intel.com,m:seanjc@google.com,m:nikunj@amd.com,m:xin@zytor.com,m:joelagnelf@nvidia.com,m:andriy.shevchenko@linux.intel.com,m:rdunlap@infradead.org,m:ynorov@nvidia.com,m:bigeasy@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-openrisc@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-arch@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:boqun.feng@gmail.com,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[77];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85546645931

--===============6478213323594853790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/interrupt_rc.h b/include/linux/interrupt_rc.h
> new file mode 100644
> index 000000000000..dd4444c61330
> --- /dev/null
> +++ b/include/linux/interrupt_rc.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * include/linux/interrupt_rc.h - refcounted local processor interrupt
> + * management.
> + *
> + * Since the implementation of this API currently depends on
> + * local_irq_save()/local_irq_restore(), we split this into it's own header to
> + * make it easier to include without hitting circular header dependencies.
> + */
> +
> +#ifndef __LINUX_INTERRUPT_RC_H
> +#define __LINUX_INTERRUPT_RC_H
> +
> +#include <linux/irqflags.h>
> +#include <asm/processor.h>
> +#ifdef CONFIG_SMP
> +#include <asm/smp.h>
> +#endif
> +
> +/* Per-cpu interrupt disabling state for local_interrupt_{disable,enable}() */
> +struct interrupt_disable_state {
> +	unsigned long flags;
> +};
> +
> +DECLARE_PER_CPU(struct interrupt_disable_state, local_interrupt_disable_state);
> +
> +static inline void local_interrupt_disable(void)
> +{
> +	unsigned long flags;
> +	int new_count;
> +
> +	WARN_ON_ONCE(in_nmi());
> +
> +	new_count = hardirq_disable_enter();
> +
> +	/* Interrupts can happen here, but it's OK, see __irq_exit_rcu(). */
> +
> +	if ((new_count & HARDIRQ_DISABLE_MASK) == HARDIRQ_DISABLE_OFFSET) {
> +		local_irq_save(flags);
> +		raw_cpu_write(local_interrupt_disable_state.flags, flags);
> +	}
> +}
> +
> +static inline void local_interrupt_enable(void)
> +{
> +	int new_count;
> +
> +	new_count = hardirq_disable_exit();
> +
> +	if ((new_count & HARDIRQ_DISABLE_MASK) == 0) {
> +		unsigned long flags;
> +
> +		flags = raw_cpu_read(local_interrupt_disable_state.flags);
> +		local_irq_restore(flags);

Could this lead to indefinite softirq starvation? When __irq_exit_rcu()
skips invoke_softirq() due to hardirq_disable_count() > 0, any scheduled
softirqs (timers, RCU callbacks, networking) remain pending. When the
outermost critical section ends and local_interrupt_enable() restores
hardware interrupts, it doesn't check local_softirq_pending() to flush
these deferred softirqs.

Will these pending softirqs stall until another unrelated hardware
interrupt fires? In low-activity periods, this could potentially cause
RCU stalls or network hangs. This concern was raised by the sashiko bot in
both v2 and v3 but remains unaddressed:

https://lore.kernel.org/all/20260526175409.7CFCC1F000E9@smtp.kernel.org/

> +		/*
> +		 * TODO: re-read preempt count can be avoided, but it needs
> +		 * should_resched() taking another parameter as the current
> +		 * preempt count
> +		 */
> +#ifdef CONFIG_PREEMPTION
> +		if (should_resched(0))
> +			__preempt_schedule();

Peter Zijlstra suggested in v2 replacing should_resched(0) with a direct
check of new_count for preemption. His suggestion was "can't you simply
write: if (!new_count) __preempt_schedule();" The author acknowledged this
in discussion but hasn't implemented it in v3:

https://lore.kernel.org/all/20260528104322.GF343181@noisy.programming.kicks-ass.net/

Is there a reason to keep the more complex should_resched(0) approach, or
would the direct check be more appropriate here?

> +#endif
> +	}
> +}
> +
> +#endif /* !__LINUX_INTERRUPT_RC_H */

[ ... ]

> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 10af5ed859e7..d1ab1799794c 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -88,6 +88,9 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
>  EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
>  #endif
>
> +DEFINE_PER_CPU(struct interrupt_disable_state, local_interrupt_disable_state);
> +EXPORT_PER_CPU_SYMBOL_GPL(local_interrupt_disable_state);
> +
>  DEFINE_PER_CPU(unsigned int, nmi_nesting);
>
>  /*
> @@ -728,7 +731,16 @@ static inline void __irq_exit_rcu(void)
>  #endif
>  	account_hardirq_exit(current);
>  	preempt_count_sub(HARDIRQ_OFFSET);
> -	if (!in_interrupt() && local_softirq_pending()) {
> +	/*
> +	 * Interrupts may happen between hardirq_disable_enter() and
> +	 * local_irq_save() in local_interrupt_disable(), if irq_exit() invokes
> +	 * softirq here, we may have a softirq handler calling
> +	 * local_interrupt_disable() but it won't disable the irq because
> +	 * hardirq disabling count is already 1, hence we need to prevent
> +	 * invoking softirq when a local_interrupt_disable() is ongoing.
> +	 */
> +	if (!in_interrupt() && !hardirq_disable_count() &&
> +	    local_softirq_pending()) {
>  		/*
>  		 * If we left hrtimers unarmed, make sure to arm them now,
>  		 * before enabling interrupts to run SoftIRQ.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26998319662
--===============6478213323594853790==--

