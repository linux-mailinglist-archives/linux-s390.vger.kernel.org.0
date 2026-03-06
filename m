Return-Path: <linux-s390+bounces-16915-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA+mHNqVqmmIUAEAu9opvQ
	(envelope-from <linux-s390+bounces-16915-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 06 Mar 2026 09:52:42 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D08C121D614
	for <lists+linux-s390@lfdr.de>; Fri, 06 Mar 2026 09:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD14E307A0AA
	for <lists+linux-s390@lfdr.de>; Fri,  6 Mar 2026 08:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2381175A95;
	Fri,  6 Mar 2026 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F3XfS5v7"
X-Original-To: linux-s390@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258891E531;
	Fri,  6 Mar 2026 08:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772786929; cv=none; b=iOOuHhYidDkPDfw4Mfhcxo+LPNg6/wifskhLrof0ceAMtrbAko9Df8bs1aCAFowdF+KNygFTw9ZcrsO4BIrH2veElo1uSygYT6Vv+lCq+QlslTtuzjLgNFFqxRNvRcb64YqlMuGT3zxaNQEswV0xNGhoOEfckhGMgd5XTpk8/eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772786929; c=relaxed/simple;
	bh=9xc2rd67zygfGvWAuXJWDaeN1yezR102MpqvN+cRWiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeStYDIrqCTWfR5bL9g2B3f8ZNW1N/EaTSAbPyBm1FXqKclgeZf5fPXBb0xUp1AMRdAMjBpwk94tVrASJ+f14ihr9OvC0TXInMbL+P7ouZZahYy3/oW58IH8B/oFIFbXHIxJtOTyNuy3VaTBPPugktPPFUuVfRZsn8G8o+eb87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F3XfS5v7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jUcog0pcNQnpMag/9mzHrQkTisayE/+eo7fVLOiHJG4=; b=F3XfS5v7gg+LLEYfVOP/YOGXgI
	iX1FEZne2zGA6mujKybrGTZl70Nn+57MW6qPR5+0BL3n/v52umGA5kR9cgh3ckkRR/hkjxUgCShb/
	Wh516fLci3vnwQo2zXsmEr0p5vs/tWWJx9KW1/caWXgkdB99ivEq9228wnn0TZ0GIgOHnAbAyg7Ra
	8cUmLDKuKUTwoxY1J/iVD5lSavhMAZiDf+NwOrefOuTjOgX4LBAuXBwWljQ+iuppBLKMqEQnjLoZ7
	KWRuNwDtbhCkwDLad3yHbw2O2kcxWMvDHbJnARyQBZgScEVgyst5XQASqoa6BYWWBJLOhgVqp+JIf
	JygEY6cg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyQrW-0000000GQ4K-1Lbh;
	Fri, 06 Mar 2026 08:48:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1C2BF300B40; Fri, 06 Mar 2026 09:41:38 +0100 (CET)
Date: Fri, 6 Mar 2026 09:41:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Mikhail Zaslonko <zaslonko@linux.ibm.com>, linux-next@vger.kernel.org,
	linux-s390@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [linux-next][s390] Boot hang after merge c50f05bd3c4e
 (sched/hrtick)
Message-ID: <20260306084138.GR1282955@noisy.programming.kicks-ass.net>
References: <af549a19-db99-4b16-8511-bf315177a13e@linux.ibm.com>
 <28add480-4841-4e6a-a8a9-1211280ecc51@linux.ibm.com>
 <20260305074922.7170Ad3-hca@linux.ibm.com>
 <20260305121201.GB596554@noisy.programming.kicks-ass.net>
 <20260305123505.GA1395416@noisy.programming.kicks-ass.net>
 <20260305124501.GB1395416@noisy.programming.kicks-ass.net>
 <20260305130725.GB652779@noisy.programming.kicks-ass.net>
 <20260305150210.7170D10-hca@linux.ibm.com>
 <cfd76996-ecae-4ed9-add0-70ca2e59ef11@linux.ibm.com>
 <20260305194821.8663A9e-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305194821.8663A9e-hca@linux.ibm.com>
X-Rspamd-Queue-Id: D08C121D614
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16915-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noisy.programming.kicks-ass.net:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:dkim]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 08:48:21PM +0100, Heiko Carstens wrote:

> Mikhail, which commit did you revert? The above discussion is about commit
> d8b5cf9c6314 ("s390/irq/idle: Remove psw bits early"), which is not
> explicitly mentioned.
> 
> But it is indeed broken: irqentry_exit() has a regs_irqs_disabled() check,
> which I broke with this commit - but "only" for idle exit.
> Result: no hrtimer_rearm_deferred() being called on idle exit.
> 
> Oh well. Peter, thanks for pointing to this broken commit. Will be reverted.

No problem; digging through unknown arch code is what keeps you sharp
;-)

