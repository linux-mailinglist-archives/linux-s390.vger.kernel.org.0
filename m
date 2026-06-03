Return-Path: <linux-s390+bounces-20458-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FI5UF5SFIGqP4gAAu9opvQ
	(envelope-from <linux-s390+bounces-20458-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 03 Jun 2026 21:50:44 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CEB63AF82
	for <lists+linux-s390@lfdr.de>; Wed, 03 Jun 2026 21:50:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kR6k4vnP;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20458-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20458-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FE25301327D
	for <lists+linux-s390@lfdr.de>; Wed,  3 Jun 2026 19:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE8639B4A6;
	Wed,  3 Jun 2026 19:47:57 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5102DA762;
	Wed,  3 Jun 2026 19:47:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780516077; cv=none; b=KCY8RArbXONylm/dTG/IVUyF/RoW77fgrKLqf1vGKvqP9BG7hXlndhk5e7ZXOL4CY8S4xrhuo7MQ8fBTf1KjUBM3Ygx/Snf6VCp/UwxS9vpgs7XRNUpJvog0kci69W3bphQP2l9KLsg7g4nkxot+XEbnyaj6x5KKwrayXvQgRdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780516077; c=relaxed/simple;
	bh=Jfy7ICEfhLhONSnBDzkkcPMEW2bQCN5Dvs43KT+gIoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u51a5tIzxX4RRIGaXgVw3r9bUvmgm4OekGm8Lt6Ebdm74YspUAidiGHV6BLZ3UQCnE5kQGJ3fCFxRhuZYaTWlt5QZeSrHIcB3y16OOWO9x+xmxemWyhY4dawxDSdGp1nBQZ4KRghDDK2m7PDQIdT0000kUcxZqLPd2SGUitvFgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kR6k4vnP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3F91F00898;
	Wed,  3 Jun 2026 19:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780516076;
	bh=oOYIAtymmURbzMmJqPzPdyOu+sBYVlOP8gnvvEblgmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kR6k4vnPUTYHZJzGey/jecz5zzPXLoD03eJlnfW9KO7aCtwOd/LRL0iOnJQfhKZ4D
	 3ntSOoErCRUGWGBpfI2wfdwTETWnhi13p67C1c+yt8VMT89HKvBSf/GZlJuGlk5Yok
	 zaGMzcNUuqt8Tj9eCkj2e2kckr0YXl+VIBuKEeILguqwpK2oi2VO3Jr48KNwkn/gFr
	 7umbtIFtSp95KrhujC1i2G8K8fZYvFosGSYt5oMLM7rqLd90VlCLtcE05qTIKkIzLV
	 a2kjJV/BtIsiCTUcD6CG8JbbIXpY/A7BoKcAyR1fyXD8kiRG347/V3P0EkMysi71m4
	 tURKL7q65XcXA==
Date: Wed, 3 Jun 2026 16:47:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, agordeev@linux.ibm.com,
	gor@linux.ibm.com, hca@linux.ibm.com, jameshongleiwang@126.com,
	japo@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org,
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Subject: Re: [PATCH v12 00/19] perf: Use e_machine and lazily compute symbols
Message-ID: <aiCE6Gq7yE2T8ZoT@x1>
References: <20260602062452.2583619-1-irogers@google.com>
 <20260602152516.2831152-1-irogers@google.com>
 <CAP-5=fWtc0xHfCeXfcPUkmWtHZO4EUriDrqovr5nXzb0GvSWxw@mail.gmail.com>
 <ah--Jc0PMT7Y7Z18@z2>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ah--Jc0PMT7Y7Z18@z2>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20458-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:namhyung@kernel.org,m:irogers@google.com,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,m:hca@linux.ibm.com,m:jameshongleiwang@126.com,m:japo@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:linux-perf-users@vger.kernel.org,m:linux-s390@vger.kernel.org,m:sumanthk@linux.ibm.com,m:tmricht@linux.ibm.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[acme@kernel.org,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,linux.ibm.com,126.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acme@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,perf.data:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9CEB63AF82

On Tue, Jun 02, 2026 at 10:39:49PM -0700, Namhyung Kim wrote:
> On Tue, Jun 02, 2026 at 09:53:59AM -0700, Ian Rogers wrote:
> > On Tue, Jun 2, 2026 at 8:25 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > Add a helper to perf_env to compute the e_machine if it is EM_NONE.
> > > Derive the value from the arch string if available. Similarly derive
> > > the arch string from the ELF machine if available, for consistency.
> > > This means perf's arch (machine type) is no longer determined by uname
> > > but set to match that of the perf ELF executable.
> > >
> > > Migrate code away from strcmp on env->arch to using the e_machine
> > > comparisons that are more accurate and not prone to uname and other
> > > naming differences. While cleaning this up, also clean up the
> > > capstone initialization code to cover more architectures and to set
> > > the big endian flag based on ELF header information.
> > >
> > > Refactor perf_env__arch_strerrno to take an e_machine instead of an
> > > architecture string, removing the HAVE_LIBTRACEEVENT dependency
> > > entirely and making it unconditionally available. The generated errno
> > > table includes fallback definitions for newer ELF machine constants to
> > > ensure compatibility with older host glibc versions.
> > >
> > > Introduce a mutex in perf_env to safely protect lazy metadata setup,
> > > such as os_release or e_machine resolution, preventing concurrent
> > > initialization data races and memory leaks during multi-threaded
> > > profiling or symbol loading. Properly initialize stack-allocated
> > > perf_env instances to ensure safe mutex destruction.
> > >
> > > Switch the idle computation to the point of use and lazily compute it,
> > > rather than computing it for every symbol. The current only user is
> > > `perf top`. At the point of use the perf_env is available and this can
> > > be used to make sure the idle function computation correctly accounts
> > > for architecture-specific and kernel-version-specific patterns.
> > > To prevent concurrent updates to shared symbol bitfield flags, migrate
> > > bitfield variables in struct symbol to C11 atomic flags.
> > 
> > So I think this series is at the point where Sashiko [1] is giving
> > warnings only for out-of-scope things and pre-existing conditions. I
> > will give a detailed explanation below, but I'd appreciate help moving
> > this forward with human review and submission. Thanks!
> > 
> > > Ian Rogers (19):
> > >   perf env: Add perf_env__e_machine helper and use in perf_env__arch
> > 
> > 1 critical 2 high issues.
> > The issues relate to existing data races, the inaccurate arch string,
> > and normalizing the arch string stored in the data file. The existing
> > data races don't bite us currently due to the single threaded nature
> > of most of perf - multithreading is on the TODO list. The arch string
> > is inaccurate and the e_machine in newer perf.data files resolves
> > this. If we were using the arch string without the e_machine then the
> > concerns over its use are valid, but this series is trying to remove
> > the use of the arch string and strongly prefer the e_machine.
> > 
> > >   perf tests topology: Switch env->arch use to env->e_machine
> > 
> > No regressions.
> > 
> > >   perf env, dso, thread: Add _endian variants for e_machine helpers
> > 
> > 1 high issue for a potential pre-existing SEGV if a thread lacks maps.
> > Let's hope that doesn't happen, the example given assumes a
> > multithreaded environment and multi-threading is on the TODO list.
> > 
> > >   perf capstone: Determine architecture from e_machine
> > 
> > 1 low issue. A flag only present in capstone 4.0 is used. As capstone
> > 4.0 was released in 2018, let's just assume the flag is there rather
> > than adding yet more complexity.
> > 
> > >   perf print_insn: Use e_machine for fallback IP length check
> > 
> > No regressions.
> > 
> > >   perf symbol: Avoid use of machine__is
> > 
> > 1 high issue. Concerns over pre-existing cross-platform analysis
> > problems. Cross-platform analysis fully working is on the TODO list.
> > 
> > >   perf machine: Use perf_env e_machine rather than arch
> > >   perf sample-raw: Use perf_env e_machine rather than arch
> > >   perf sort: Use perf_env e_machine rather than arch
> > >   perf arch common: Use perf_env e_machine rather than arch
> > >   perf header: In print_pmu_caps use perf_env e_machine
> > >   perf c2c: Use perf_env e_machine rather than arch
> > >   perf lock-contention: Use perf_env e_machine rather than arch
> > >   perf env: Refactor perf_env__arch_strerrno
> > >   perf env: Remove unused perf_env__raw_arch
> > 
> > No regressions x9.
> > 
> > >   perf env: Add mutex to protect lazy environment initialization
> > 
> > 1 medium issue requesting more locking on more bits of perf_env.
> > Multi-threading is on the TODO list and let's stop the feature creep
> > here.
> > 
> > >   perf env: Add helper to lazily compute the os_release
> > 
> > 1 high issue. Concern over a perf data issue in pipe mode. Addressing
> > this would require a fairly major overhail of perf data, so let's add
> > fixing to the TODO list.
> > 
> > >   perf symbol: Add setters for bitfields sharing a byte to avoid
> > >     concurrent update issues
> > >   perf symbol: Lazily compute idle
> > 
> > No regressions x2.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo

