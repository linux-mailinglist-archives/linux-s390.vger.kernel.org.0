Return-Path: <linux-s390+bounces-21488-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yIuJLxErRmrhKwsAu9opvQ
	(envelope-from <linux-s390+bounces-21488-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 02 Jul 2026 11:10:41 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 314786F5168
	for <lists+linux-s390@lfdr.de>; Thu, 02 Jul 2026 11:10:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=g7X4++Be;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21488-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-21488-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB2C5310617F
	for <lists+linux-s390@lfdr.de>; Thu,  2 Jul 2026 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BFB4657FE;
	Thu,  2 Jul 2026 08:59:48 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA7E412284;
	Thu,  2 Jul 2026 08:59:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982788; cv=none; b=BVoweiOHI8hcjC0ORm914AYJOsXT1PIVPDCmTA9IhvYdqAz3R+owaGfLCqCfoJRXveN+zCTXEcr2X3o/xLICePU6NIQbdi5P/m84Z79bTPtNqvnZORIg2zmjdidz7c8AnloqucB02lUfckgbif393GYa55lOI1RVUEkrDX3KA5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982788; c=relaxed/simple;
	bh=ZLVcbKipQNAdEJWKtk1WjEx5k5Uhknn05I6n6iCUbSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nt5C69M+glnhFSR6KHmgN1uJj5WK+R+GBStOeeP76iHEfHtnSaACUNq3Ob6Y4DWA44NNa7SmvmiTM+UonJn+iEvkOGZHw0HgprajdVrd0MpYVi35tkgGFCrfJuvFWzlm2zRcZHvOPe72JY8M6l628eru4vQ8T6FAny3gDMxPLl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g7X4++Be; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=usqHyr4FCppk89cjD1Lh8z87EZeT9dV/v0SgCLCx+zE=; b=g7X4++BeQ2q3zvMDe0NyPsUx45
	3RF7kSMPpRJbYt9i13rM6nx2YrMi6bglLo9KaWHX2kW0o8LMDoTT//Ifa+E2G6xEy8JVh7LI3VLhV
	pfLPjaeloaGkxDf/EyrDWK2d7ZPwETD3mnRd+Zm8U6Wo+zHIzbHkfvtnSaV65UQjpEgZlRWPz74t1
	uZ+2Qyh1y+o5EGlK7R8iiQorjBWQbQ11s5JP91ZxzfTGtLpP9bGB4U2aA3Jjn9RfPRYqPUK6KqVbt
	qrDiRFk4oGgCIyvEEwrlJoQ1fPKiasr1jqeVQKiw9AwCA6vyTYqUeBHmOLeCCitZYCa+2W1O3HTS0
	CCZNiKSQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfDGU-00000008EIf-3h8q;
	Thu, 02 Jul 2026 08:59:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EF899300402; Thu, 02 Jul 2026 10:59:21 +0200 (CEST)
Date: Thu, 2 Jul 2026 10:59:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Charlie Jenkins <thecharlesjenkins@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Huth <thuth@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jisheng Zhang <jszhang@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] futex: Optimise the size check get_futex_key()
Message-ID: <20260702085921.GD49951@noisy.programming.kicks-ass.net>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-9-kprateek.nayak@amd.com>
 <20260701075714.GP48970@noisy.programming.kicks-ass.net>
 <20260701084150.GNOeboLw@linutronix.de>
 <38239f40-1673-469f-baa3-4a343d2aa4c3@amd.com>
 <20260701161736.xYYizA0e@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701161736.xYYizA0e@linutronix.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21488-lists,linux-s390=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,arndb.de,kernel.org,redhat.com,alien8.de,linux.intel.com,arm.com,dabbelt.com,eecs.berkeley.edu,linux.ibm.com,infradead.org,stgolabs.net,igalia.com,vger.kernel.org,sifive.com,gmail.com,lists.infradead.org,zytor.com,google.com,ghiti.fr];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[peterz@infradead.org,linux-s390@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:kprateek.nayak@amd.com,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:dvhart@infradead.org,m:dave@stgolabs.net,m:andrealmeid@igalia.com,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:samuel.holland@sifive.com,m:thecharlesjenkins@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:hpa@zytor.com,m:thuth@redhat.com,m:seanjc@google.com,m:jszhang@kernel.org,m:alex@ghiti.fr,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,infradead.org:dkim,infradead.org:from_mime,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 314786F5168

On Wed, Jul 01, 2026 at 06:17:36PM +0200, Sebastian Andrzej Siewior wrote:
> The futex address must be naturally aligned and this is checked via
> "address % size" where `address' is the supplied address and `size' is
> the expected size of futex. It is guaranteed that `size' is power of two
> but the compiler does not see it and creates here a `div' operation
> (x86, arm, gcc-15).

That's pretty stupid, since size = futex_size() := 1 << (blah); so it
has every opportunity to actually see this. Also, see below, clang does!

> We can take advantage of the pow2 property and rewrite it as
> "address & (size-1)".
> 
> As per testing, the command
> |perf bench futex hash -f 1 -b 16384 -t 1 -r 30
> 
> improved from
> | [thread  0] futex: 0x5619f931f740 [ 7001583 ops/sec ]
> to
> | [thread  0] futex: 0x55da173e5740 [ 7376137 ops/sec ]
> 
> or by 5.3%
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> Could someone verify this, please? The 5% look a bit high. This is on
> top of the series (but not worsen by the series).

Bah, I tried to reproduce and couldn't. Then I noticed I did a clang
build and that is in fact clever enough to do this optimization itself.

/me tries again with a GCC build.

pre:  [thread  0] futex: 0x561f14430680 [ 9021408 ops/sec ]
post: [thread  0] futex: 0x55feadbbb680 [ 8977527 ops/sec ]

(and this seems to be well inside the error threshold of this test).

So I see the GCC build do the DIV, and no longer with his patch applied,
but for some reason I cannot get the runtime performance to actually
improve much of anything on my system.


