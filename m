Return-Path: <linux-s390+bounces-19591-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMfpHOFWA2qh4wEAu9opvQ
	(envelope-from <linux-s390+bounces-19591-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 18:35:45 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D73A524CCD
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 18:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16970305191B
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 16:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604883D0C16;
	Tue, 12 May 2026 16:31:15 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2573CF966;
	Tue, 12 May 2026 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603475; cv=none; b=SB6+y4LIyhvc/4kqeuKL6izdHUXhWvuklrCqJgEgS+ykfVoBUKOv1UjBf2a51f+dgN10Uct/cU3zbB52/r45GhMKhiR0S+7N+tRCq+g5dnNyEuQAlVdsEd0Rw7aZU4v+pA+r8FVmd+pqibDjAu0432mgbYoIaxfuuZXyqJ2yOpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603475; c=relaxed/simple;
	bh=IMbW7exXtcrNMyBQoQ3lKIf11X87bEjhtS6Gp02LSlU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SL0K/gO+dIA2pwdAPf+GQKppxF90r7d8wzGsQjz131V1obOq0pW7VyN8l10hf7cg7izfknt7p/dFKcbdKMYDuU7Q+pmp3nml4KlnPdhslsTOGzvlMCtGDcznEB4tbiWh9nFhPm4KkfFW30n3ude9fno4Yain+4bLUr0W8tR6J2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 94B2C1605C8;
	Tue, 12 May 2026 16:31:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 2E92318;
	Tue, 12 May 2026 16:30:48 +0000 (UTC)
Date: Tue, 12 May 2026 12:30:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Jonas Bonn
 <jonas@southpole.se>, Stefan Kristiansson
 <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Waiman
 Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>, Ada Couprie Diaz
 <ada.coupriediaz@arm.com>, Lyude Paul <lyude@redhat.com>, Sohil Mehta
 <sohil.mehta@intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Xin Li (Intel)" <xin@zytor.com>, Sean Christopherson <seanjc@google.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, Yury Norov <ynorov@nvidia.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, Joel
 Fernandes <joelaf@google.com>
Subject: Re: [PATCH 02/11] preempt: Track NMI nesting to separate per-CPU
 counter
Message-ID: <20260512123048.6666343f@gandalf.local.home>
In-Reply-To: <20260508042111.24358-3-boqun@kernel.org>
References: <20260508042111.24358-1-boqun@kernel.org>
	<20260508042111.24358-3-boqun@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: rxzg8jbfdtkk4aitrpcusrqxkwme1q84
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/wsxhK3YvLhxUJYewPwd+JDlrDDxI7THU=
X-HE-Tag: 1778603448-881851
X-HE-Meta: U2FsdGVkX19IoNKjn8/2CFuwQduihhp8T9fcERCiZ9DMjEPnQs4CgfXWCNX1eLR6jbWJWlnvk67MmsoS1U7wa0d0G2bcz4PY/4q9PQk9b2m720qNMXGNi/FtZn9L5vWoSAAmhinHOBCskUHmgFY3OyYuytp7wXzFllSmnf3MkgmvUa/tjWXwsp4HEaxkfJJih156So8K+ajlb94mCRbbnuNyrK8iIruiIRG+ofpNwV3eRM1ME/t/H1HWyrAdtwKz7Vo1lRKqK6Qu2nWCMg5ZxZ7ewaP6pnwF1qpkZsU239HpFmLpTAfJEzP/6CyhQ3mXi3Fph5W7sa7YTzxooOLZm9GaTVwD1jnGZpkvzMrTlQCKZIq0bFqrFqbLVIBwqiGnX5lYMKEZ3jMtYlOJk6VsPauVMs6wrMPzR2cumlZVwIyKG1eZJOEtKVxiCiukJhJs3w2DD/JFvEYZ0ZMz+4Ik+JHpQmHJ8rMoLnRf19wR8ZBCAM1BFWJXJYWwZ0uhjX/GDV0JQfolp30=
X-Rspamd-Queue-Id: 8D73A524CCD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,arm.com,kernel.org,southpole.se,saunalahti.fi,gmail.com,linux.ibm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linaro.org,google.com,suse.de,amd.com,linux-foundation.org,garyguo.net,protonmail.com,umich.edu,huawei.com,intel.com,nvidia.com,linutronix.de,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19591-lists,linux-s390=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.954];
	RCPT_COUNT_GT_50(0.00)[57];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gandalf.local.home:mid,nvidia.com:email]
X-Rspamd-Action: no action

On Thu,  7 May 2026 21:21:02 -0700
Boqun Feng <boqun@kernel.org> wrote:

> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Move NMI nesting tracking from the preempt_count bits to a separate per-CPU
> counter (nmi_nesting). This is to free up the NMI bits in the preempt_count,
> allowing those bits to be repurposed for other uses.  This also has the benefit
> of tracking more than 16-levels deep if there is ever a need.
> 
> Reduce multiple bits in preempt_count for NMI tracking. Reduce NMI_BITS
> from 3 to 1, using it only to detect if we're in an NMI.
> 
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Joel Fernandes <joelaf@google.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Boqun Feng <boqun@kernel.org>
> Link: https://patch.msgid.link/20260121223933.1568682-3-lyude@redhat.com
> ---
>  include/linux/hardirq.h | 16 ++++++++++++----
>  include/linux/preempt.h | 13 +++++++++----
>  kernel/softirq.c        |  2 ++
>  3 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> index d57cab4d4c06..cc06bda52c3e 100644
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -10,6 +10,8 @@
>  #include <linux/vtime.h>
>  #include <asm/hardirq.h>
>  
> +DECLARE_PER_CPU(unsigned int, nmi_nesting);
> +
>  extern void synchronize_irq(unsigned int irq);
>  extern bool synchronize_hardirq(unsigned int irq);
>  
> @@ -102,14 +104,16 @@ void irq_exit_rcu(void);
>   */
>  
>  /*
> - * nmi_enter() can nest up to 15 times; see NMI_BITS.
> + * nmi_enter() can nest - nesting is tracked in a per-CPU counter.
>   */
>  #define __nmi_enter()						\
>  	do {							\
>  		lockdep_off();					\
>  		arch_nmi_enter();				\
> -		BUG_ON(in_nmi() == NMI_MASK);			\
> -		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
> +		BUG_ON(__this_cpu_read(nmi_nesting) == UINT_MAX);	\

I think we should keep the max nesting fixed to 15. If this doesn't trigger
until UINT_MAX, it may take a long time to see that, and there's no reason
NMIs should nest more than 15 anyway.

Just because the counter allows it, doesn't me the system should allow it.

-- Steve


> +		__this_cpu_inc(nmi_nesting);			\
> +		__preempt_count_add(HARDIRQ_OFFSET);		\
> +		preempt_count_set(preempt_count() | NMI_MASK);	\
>  	} while (0)
>  
>  #define nmi_enter()						\
> @@ -124,8 +128,12 @@ void irq_exit_rcu(void);
>  

