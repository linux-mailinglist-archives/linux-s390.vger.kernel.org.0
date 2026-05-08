Return-Path: <linux-s390+bounces-19430-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMLdN1Wd/WmwgQAAu9opvQ
	(envelope-from <linux-s390+bounces-19430-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 08 May 2026 10:22:45 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5864F3A6C
	for <lists+linux-s390@lfdr.de>; Fri, 08 May 2026 10:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E257B300B475
	for <lists+linux-s390@lfdr.de>; Fri,  8 May 2026 08:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28473377EC1;
	Fri,  8 May 2026 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cxQY8IMX"
X-Original-To: linux-s390@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A09372B32;
	Fri,  8 May 2026 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228561; cv=none; b=tBm5+flrogX0IWVDfuzpo/u+TxqZtGtEFgTG5Ye2LeKQEw+iCbenrWAkkQA6Ao/TQr8Evf5oBRkBAfTVcBW5Z9J36zvegbD4yxrS0Fh9rZlCRjiEIiCI1z0nPr6o6kxXhiZKqc9wjPGemqp4JD5SBUcNSmJf1bE5H6BtNEbwrnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228561; c=relaxed/simple;
	bh=16p9TfU9bdyS1Qp6/DufPqQzUm3alabc2lHwAPLWW40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNpigW2Bjdc4DVVOK8KvX+Ceyh97eZE89ttB9EvMgagLkofMja173G/Zk4AFL2RYkGDY+ux2jSs5I7P1uqkhJvnmSOI0ALbZwVuqqUZYfhBdNTP+yfg6sIqwyRSYqVs8g8dcfHAq1sxJF0Tk80mX1O6ngpoHrr63gYPcYSD0HWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cxQY8IMX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C36521C01;
	Fri,  8 May 2026 01:22:29 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE99F3F763;
	Fri,  8 May 2026 01:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778228555; bh=16p9TfU9bdyS1Qp6/DufPqQzUm3alabc2lHwAPLWW40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxQY8IMX/B7FhVL1Nvuf+L8Wug2PpPWz9JfJaNZdGodJ8o/OkuV3hZi5srC84uIQR
	 tQSq/q3ivXmI9akAkYFYPFLV3+iIDpEPqsgXrdRKUOsAu5o1XXpjfOnwDdvy+xg6sY
	 1+Zmi3p0D2tG6DHMVTq2kp7x3q9mbbtIxS59CLbM=
Date: Fri, 8 May 2026 09:22:20 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Boqun Feng <boqun@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Lyude Paul <lyude@redhat.com>, Sohil Mehta <sohil.mehta@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 11/11] arm64: sched/preempt: Enable PREEMPT_COUNT_64BIT
Message-ID: <af2dPMW97tNOWuGF@J2N7QTR9R3>
References: <20260508042111.24358-1-boqun@kernel.org>
 <20260508042111.24358-12-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508042111.24358-12-boqun@kernel.org>
X-Rspamd-Queue-Id: 8A5864F3A6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,arm.com,kernel.org,southpole.se,saunalahti.fi,gmail.com,linux.ibm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linaro.org,goodmis.org,google.com,suse.de,amd.com,linux-foundation.org,garyguo.net,protonmail.com,umich.edu,huawei.com,intel.com,nvidia.com,linutronix.de,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19430-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,linux-s390@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[56];
	TAGGED_RCPT(0.00)[linux-s390];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:dkim]
X-Rspamd-Action: no action

Hi Boqun,

I have a question at the end, with some context for other reviewers
before that.

On Thu, May 07, 2026 at 09:21:11PM -0700, Boqun Feng wrote:
> ARM64 already uses 64bit preempt count and the need reschedule bit is
> maintained in a separate 32bit than the preempt count. 

For the benefit of those reading the list, arm64 has a separate 32-bit
count and a 32-bit field for need_resched, which are unioned together as
a composite 64-bit value:

	union {
		u64             preempt_count;  /* 0 => preemptible, <0 => bug */
		struct {
			u32     count;
			u32     need_resched;
		} preempt;
	};

All of our "count" operations work on the 32-bit count, e.g.

	static inline int preempt_count(void)
	{
		return READ_ONCE(current_thread_info()->preempt.count);
	}


	static inline void __preempt_count_add(int val)
	{
		u32 pc = READ_ONCE(current_thread_info()->preempt.count);
		pc += val;
		WRITE_ONCE(current_thread_info()->preempt.count, pc);
	}

	static inline void __preempt_count_sub(int val)
	{
		u32 pc = READ_ONCE(current_thread_info()->preempt.count);
		pc -= val;
		WRITE_ONCE(current_thread_info()->preempt.count, pc);
	}

... but some operations use the 64-bit 'preempt_count' field from the union, e.g.

	static inline bool should_resched(int preempt_offset)
	{
		u64 pc = READ_ONCE(current_thread_info()->preempt_count);
		return pc == preempt_offset;
	}	

> Therefore preempt count has enough bits to represent 16 level of NMI
> nesting, hence enable it for ARM64. This saves a per-CPU variable and
> additional instructions in the NMI path.

This might be true, but I think the name "PREEMPT_COUNT_64BIT" is
misleading given the above. What exactly does PREEMPT_COUNT_64BIT tell
core code it can do?

If this is just telling core code that it doesn't need ot reserve space
in preempt_count for the resched bits, can this be called something
else, e.g. HAS_SEPARATE_PREEMPT_RESCHED_BITS?

Mark.

> 
> Signed-off-by: Boqun Feng <boqun@kernel.org>
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fe60738e5943..1ed5173872fc 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -248,6 +248,7 @@ config ARM64
>  	select PCI_SYSCALL if PCI
>  	select POWER_RESET
>  	select POWER_SUPPLY
> +	select PREEMPT_COUNT_64BIT
>  	select SPARSE_IRQ
>  	select SWIOTLB
>  	select SYSCTL_EXCEPTION_TRACE
> -- 
> 2.50.1 (Apple Git-155)
> 
> 

