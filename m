Return-Path: <linux-s390+bounces-12497-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B7BB3DD18
	for <lists+linux-s390@lfdr.de>; Mon,  1 Sep 2025 10:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99725169BCB
	for <lists+linux-s390@lfdr.de>; Mon,  1 Sep 2025 08:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09D82FB973;
	Mon,  1 Sep 2025 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RA4zwAAE"
X-Original-To: linux-s390@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F377262F;
	Mon,  1 Sep 2025 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716810; cv=none; b=R2HCFnXNS6zOx17K43ITBMRRsgwNlCgjaYd+dKyHR9dNbvNTJYfKnhZQ3t4FYDpiwVGtDJIEIIP9ns+P9znFbVZswms1VN3KFWj4dAH0ROUQd23De7I0CkHdGoOwB/pLs1QbL+vX21HkNkUT0cv5dsO4tVRAJTZC8g/ZcRv/HrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716810; c=relaxed/simple;
	bh=Nu0Z5YRABht37ceEFhru9sO3g0wQQK80E5FaZzZqeME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhrXeDzSHcH3BW+CN2KhWiYQQe2NQ1aRwsaQphB4g4DBSPyPnrBvoMLEHNTJ1Tjtu1lM3Z7da3bfa5hcuwglKkezWr4I/OJ7RAxezn4rG4ugpYL4KJbUUbzDZBYMSOkQ0ou5eH8XZbzGt8Oc2NP8Q3rU2yQyh8fek26cmJeKodA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RA4zwAAE; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=StnaVQ/kuJKs04O83dX5k4oJKlm7slZS7P8l56c6/pw=; b=RA4zwAAEQiCqRY/TooPy/tk0ud
	rw/w/lrPMKIuCcLgBggd3vuF4fpgSHX2M6sOVAuXSsUxc6uo62EztDxZp6mUyLYACfh9aAiQ4hUoK
	82CRdGtK06o3JG8leT4mdeqFWpOvxCq7zbalqum94HHR3wsQiUtwGOvNJ/2o6yTp+OPGxXR5MGYPV
	1yOapB3oD+7v/gfi+iv8++UHuT1iMd7Mz0pOnUMIQprUWkrJXSVst3cjO2AyrjWrnKgBhq12Fknwk
	r0JV17FlQBdTf/VOYEqYBwF38xuhW7tHMPCWst5TfMJAk8UyIIHkIoyKzZPme1MsIqukkAMY1KpFN
	VoQ5ou9w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut0HF-00000003gW1-0qU0;
	Mon, 01 Sep 2025 08:52:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3F3FB300342; Mon, 01 Sep 2025 10:52:36 +0200 (CEST)
Date: Mon, 1 Sep 2025 10:52:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	thomas.weissschuh@linutronix.de, Li Chen <chenl311@chinatelecom.cn>,
	Bibo Mao <maobibo@loongson.cn>, Mete Durlu <meted@linux.ibm.com>,
	Tobias Huschle <huschle@linux.ibm.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andrea Righi <arighi@nvidia.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH v7 4/8] powerpc/smp: Introduce CONFIG_SCHED_MC to guard
 MC scheduling bits
Message-ID: <20250901085236.GK4068168@noisy.programming.kicks-ass.net>
References: <20250826041319.1284-1-kprateek.nayak@amd.com>
 <20250826041319.1284-5-kprateek.nayak@amd.com>
 <609a980b-cbe3-442b-a492-91722870b156@csgroup.eu>
 <20250826080706.GC3245006@noisy.programming.kicks-ass.net>
 <20250826094358.GG3245006@noisy.programming.kicks-ass.net>
 <7137972e-bc7a-432c-94be-755ba9029d8c@linux.ibm.com>
 <20250901083507.GD4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901083507.GD4067720@noisy.programming.kicks-ass.net>

On Mon, Sep 01, 2025 at 10:35:07AM +0200, Peter Zijlstra wrote:
> On Thu, Aug 28, 2025 at 08:13:51PM +0530, Shrikanth Hegde wrote:
> 
> > > --- a/arch/powerpc/Kconfig
> > > +++ b/arch/powerpc/Kconfig
> > > @@ -170,6 +170,9 @@ config PPC
> > >   	select ARCH_STACKWALK
> > >   	select ARCH_SUPPORTS_ATOMIC_RMW
> > >   	select ARCH_SUPPORTS_DEBUG_PAGEALLOC	if PPC_BOOK3S || PPC_8xx
> > > +	select ARCH_SUPPORTS_SCHED_SMT		if PPC64 && SMP
> > > +	select ARCH_SUPPORTS_SCHED_MC		if PPC64 && SMP
> > > +	select SCHED_MC				if ARCH_SUPPORTS_SCHED_MC
> > 
> > Wondering if this SCHED_MC is necessary here? shouldn't it be set by arch/Kconfig?
> 
> Ah, so without this SCHED_MC becomes a user selectable option, with this
> it is an always on option (for ppc64) -- no user prompt.
> 
> That is, this is the only way I found to have similar semantics to this:
> 
> > > -config SCHED_MC
> > > -	def_bool y
> > > -	depends on PPC64 && SMP
> > > -
> 
> Which is also not a user selectable option.
> 
> > nit: Also, can we have so they are still sorted?
> > 	select ARCH_SUPPORTS_SCHED_MC		if PPC64 && SMP
> > 	select ARCH_SUPPORTS_SCHED_SMT		if PPC64 && SMP
> 
> Sure, let me flip them. I need to prod that that patch anyway, built
> robot still ain'ted happy.

Looks like 44x/iss476-smp_defconfig (iow 32bit power) also wants
SCHED_MC, so it should be:

config SCHED_MC
	def_bool y
	depends on SMP

Its just SMT that's a PPC64 special.

