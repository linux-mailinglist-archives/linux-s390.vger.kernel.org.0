Return-Path: <linux-s390+bounces-15967-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICvBB+3IcGkNZwAAu9opvQ
	(envelope-from <linux-s390+bounces-15967-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 21 Jan 2026 13:39:09 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC8F56EA1
	for <lists+linux-s390@lfdr.de>; Wed, 21 Jan 2026 13:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A75E9C83A9
	for <lists+linux-s390@lfdr.de>; Wed, 21 Jan 2026 12:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3954F481660;
	Wed, 21 Jan 2026 12:32:22 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C757481255;
	Wed, 21 Jan 2026 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768998742; cv=none; b=dc8MKACPUhy0bv2AcZU6lnic8l3UojjqYuEYT+VEppTFy8ot9tr8k/SfN5jihAzkxHsqKq0tL8jRUsw70B8iWCQKZR3Yeso7WrAA/SOWYTvx+ugICU69LHhDSgsaBNW7K6JUx7jNWEL9gLQ4wRYAdOfKZiLH1TPh7OHot5rqndM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768998742; c=relaxed/simple;
	bh=FELHx54kV3W/qnATluFqgshAxI/luUBfj25peQmvX7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekXg4nWnRQzqXq02K50bjhIA5GL17ihNE3HfOFbo8mZdD5WiReJxm7CmmD3mvt25AIqARb7blq/qu4faDyCrOh9qH4AUYT3TJd5FF/3SSje/0wsqM6Acva7LXo71JMduqrhviighDSJDV/23ZysIkfC/Om8gii5oBgRyoWzlHSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D87A81476;
	Wed, 21 Jan 2026 04:32:12 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16A163F740;
	Wed, 21 Jan 2026 04:32:13 -0800 (PST)
Date: Wed, 21 Jan 2026 12:32:08 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: kernel test robot <lkp@intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	David Laight <david.laight.linux@gmail.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 3/3] randomize_kstack: Unify random source across
 arches
Message-ID: <aXDHSIn3hIvESjXg@J2N7QTR9R3>
References: <20260119130122.1283821-4-ryan.roberts@arm.com>
 <202601210752.6Nsv9et9-lkp@intel.com>
 <46c7d109-b076-4bb3-9e6e-36c34c546c20@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46c7d109-b076-4bb3-9e6e-36c34c546c20@arm.com>
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : No valid SPF, No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15967-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,arm.com,kernel.org,linux.ibm.com,ellerman.id.au,dabbelt.com,eecs.berkeley.edu,linutronix.de,redhat.com,alien8.de,linux.intel.com,arndb.de,zx2c4.com,gmail.com,lists.linux.dev,vger.kernel.org,lists.infradead.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,linux-s390@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-s390];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,git-scm.com:url,intel.com:email]
X-Rspamd-Queue-Id: BDC8F56EA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 10:52:21AM +0000, Ryan Roberts wrote:
> On 20/01/2026 23:50, kernel test robot wrote:
> > Hi Ryan,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on akpm-mm/mm-everything]
> > [also build test WARNING on linus/master v6.19-rc6 next-20260119]
> > [cannot apply to tip/sched/core kees/for-next/hardening kees/for-next/execve]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/randomize_kstack-Maintain-kstack_offset-per-task/20260119-210329
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > patch link:    https://lore.kernel.org/r/20260119130122.1283821-4-ryan.roberts%40arm.com
> > patch subject: [PATCH v4 3/3] randomize_kstack: Unify random source across arches
> > config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20260121/202601210752.6Nsv9et9-lkp@intel.com/config)
> > compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260121/202601210752.6Nsv9et9-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202601210752.6Nsv9et9-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >>> vmlinux.o: warning: objtool: do_syscall_64+0x2c: call to preempt_count_add() leaves .noinstr.text section
> >>> vmlinux.o: warning: objtool: __do_fast_syscall_32+0x3d: call to preempt_count_add() leaves .noinstr.text section
> 
> Hmm, clearly Dave was correct not to rush this through... yuck. I'll take a
> look, but I guess there is no rush if this won't go into -next until shortly
> after -rc1.

Sorry, I should have checked the entry sequencing more thoroughly when I
reviewed this,.

From a quick look, I suspect the right thing to do is to pull the call
to add_random_kstack_offset() a bit later in a few cases; after the
entry logic has run, and after instrumentation_begin() (if the arch code
uses that), such that it doesn't matter if this gets instrumented.

Considering the callers of add_random_kstack_offset(), if we did that:

* arm64 is fine as-is.

* loongarch is fine as-is.

* powerpc's system_call_exception() would need this moved after the
  user_exit_irqoff(). Given that function is notrace rather than
  noinstr, it looks like there are bigger extant issues here.

* riscv is fine as-is.

* s390's __do_syscall() would need this moved after
  enter_from_user_mode().

* On x86:
  - do_int80_emulation() is fine as-is.
  - int80_emulation() is fine as-is.
  - do_int80_syscall_32() would need this moved after
    instrumentation_begin().
  - __do_fast_syscall_32() would need this moved after
    instrumentation_begin().
  - do_syscall_64() would need this moved after instrumentation_begin().

Mark.

