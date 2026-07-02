Return-Path: <linux-s390+bounces-21492-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LgbuJLtFRmoNNgsAu9opvQ
	(envelope-from <linux-s390+bounces-21492-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 02 Jul 2026 13:04:27 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DA46F661F
	for <lists+linux-s390@lfdr.de>; Thu, 02 Jul 2026 13:04:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=4TVhvdqA;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=sH6bVU2F;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21492-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21492-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A6913090137
	for <lists+linux-s390@lfdr.de>; Thu,  2 Jul 2026 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AE53CA4B6;
	Thu,  2 Jul 2026 10:56:20 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3897F357CE1;
	Thu,  2 Jul 2026 10:56:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989780; cv=none; b=i51rc7sSCV7acyfXDeE5Mp4AoQ1PwgTN28MmoSDh2q4Jmaf6LuynhFE6lXafnZVqaHnFThCbdCXBxn81PqUgfrFxO6rMb8bWvsdQyo5dobWTUoTJMvdYCFNJwcsRlmdEoy+jhoWzvM/BeSdZDN9NtC7CmxNswwprL11fylmGkNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989780; c=relaxed/simple;
	bh=WIcjYfoWn6gcmd0f9zDPpY6wy1Eu6WkQW0J8BHM4Zdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEZv6oVOyXUHQtq/smNbLSgzaGvwJ/XZDu2ow3qnIyfZhdpR3Kh/00rkxcB/Po8dpCjKNQQ9NcbkkAeqpnu9GZzAcPMljPWPSVw1xdU+89JavO718ED7M9us3hUbNJDt9F2ui4xtRwhciQAa56/DWH5fq9Os9yQn+lqZKnrtnOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4TVhvdqA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sH6bVU2F; arc=none smtp.client-ip=193.142.43.55
Date: Thu, 2 Jul 2026 12:56:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782989777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixPQhnXgf4TKhclNNixfZQM7k/+d5gcWfCG3ObKKmF0=;
	b=4TVhvdqAIOEciydZhtWWTSBcjaeQ7Q4Nw9cuTHhL5opET36YUxZTwm3tFIMjXOSyivMsdt
	e0nVvs6ZVME8To/TkXXaWt9vu/ln7SPpBWx1P7HA4t0Pa7TQR7NzLgcvsS4YnG+QFfuA2k
	jsYLqaHd7uofGl1j45DFi+maomvGsdRErti9RqvI/7AcnlWEQPSWjCnZQX5zJ/p4BY96ey
	QuN0X4JZNXCH04yMHGSmEnv7E0fqOXkibVit8kf41tnXjZi3Uwslp69Trx+GBHyxL0CpUD
	9fxWC9NFlot4OKOHjeJwpm0BfXn01F53jFXoGwwFb35RESO/ccPB7phTFYI+aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782989777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixPQhnXgf4TKhclNNixfZQM7k/+d5gcWfCG3ObKKmF0=;
	b=sH6bVU2F/pVuBlU067fDQEXZV5D8/UVBZNrA5jq3yQM1YprNUp9catTpYWYg5/RKz98OuW
	P0HauLhefLtPWAAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
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
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
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
Message-ID: <20260702105615.PiYhQ9Rt@linutronix.de>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-9-kprateek.nayak@amd.com>
 <20260701075714.GP48970@noisy.programming.kicks-ass.net>
 <20260701084150.GNOeboLw@linutronix.de>
 <38239f40-1673-469f-baa3-4a343d2aa4c3@amd.com>
 <20260701161736.xYYizA0e@linutronix.de>
 <20260702085921.GD49951@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702085921.GD49951@noisy.programming.kicks-ass.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21492-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:kprateek.nayak@amd.com,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:dvhart@infradead.org,m:dave@stgolabs.net,m:andrealmeid@igalia.com,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:samuel.holland@sifive.com,m:thecharlesjenkins@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:hpa@zytor.com,m:thuth@redhat.com,m:seanjc@google.com,m:jszhang@kernel.org,m:alex@ghiti.fr,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[amd.com,arndb.de,kernel.org,redhat.com,alien8.de,linux.intel.com,arm.com,dabbelt.com,eecs.berkeley.edu,linux.ibm.com,infradead.org,stgolabs.net,igalia.com,vger.kernel.org,sifive.com,gmail.com,lists.infradead.org,zytor.com,google.com,ghiti.fr];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:mid,linutronix.de:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,gnu.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31DA46F661F

On 2026-07-02 10:59:21 [+0200], Peter Zijlstra wrote:
> > Could someone verify this, please? The 5% look a bit high. This is on
> > top of the series (but not worsen by the series).
> 
> Bah, I tried to reproduce and couldn't. Then I noticed I did a clang
> build and that is in fact clever enough to do this optimization itself.
> 
> /me tries again with a GCC build.
> 
> pre:  [thread  0] futex: 0x561f14430680 [ 9021408 ops/sec ]
> post: [thread  0] futex: 0x55feadbbb680 [ 8977527 ops/sec ]
> 
> (and this seems to be well inside the error threshold of this test).
> 
> So I see the GCC build do the DIV, and no longer with his patch applied,
> but for some reason I cannot get the runtime performance to actually
> improve much of anything on my system.

I did open https://gcc.gnu.org/bugzilla/show_bug.cgi?id=126078 for the
div.

My .config is the debian distro on the 4 node big iron. [ in case it
it has so much overhead elsewhere that this place a bigger role].

"perf top" showed this as 6% or something and red in the function. After
the removal it did not show up.

Sebastian

