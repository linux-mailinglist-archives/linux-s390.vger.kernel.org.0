Return-Path: <linux-s390+bounces-16887-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCSVJA55qWl77wAAu9opvQ
	(envelope-from <linux-s390+bounces-16887-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 05 Mar 2026 13:37:34 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B9E211C9F
	for <lists+linux-s390@lfdr.de>; Thu, 05 Mar 2026 13:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82738301DCCF
	for <lists+linux-s390@lfdr.de>; Thu,  5 Mar 2026 12:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49633988E1;
	Thu,  5 Mar 2026 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R2J4Q/jq"
X-Original-To: linux-s390@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95AD3988F6;
	Thu,  5 Mar 2026 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714121; cv=none; b=kw9wLJeD/eES48APtr7fXrPPIUXXLzSXOuZN80nAr4vImjA16PPh7cLBiYwhRoQ2agQx6zc6q56FO2fBg/mngmNP8sdi1OC9f8iX/MSmpzQct8fb5BNCOulUKes4GSVnWTrKzdw2HyLPZKQ+SlklCuLR5R60aGqc6/bSQBdCq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714121; c=relaxed/simple;
	bh=b78d3+x7uSRSRL3lydMmdK89gDvVkVBJzTShwiTBs98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dlvr9SaibVk3W4/WU9MFxddCk7Ibv8Sh/i1cELIBxqaeMP/lT2eYSJZm9A+cAbbRoGRfW5ULNeJkt1NShut8UqwGBcJ0ITF1vFnFiX0eAq5rdZUg2zKB1NkuB5PJ72vdHwP1M2Lz68Oa790xCz85/7UVXE3eqWg7xqmx4dKwAwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R2J4Q/jq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xFpREfMs8906e7O1CHNb0whXOgtoJ7lwI9hm3SjHJNI=; b=R2J4Q/jqK/zk9wDRMy8yAQ3/zi
	ZR8gOZEPMQ/+6c29un9syO4ZWFTnhhPOg7bq/L+bxC0TmuO6h8IziEgXAPDQBOrke3dmxC9D6mS6Y
	uwp1Bbd9GXqiyQCSvroNf5/9Id4LT999L40k6wGrhZhvHLwJFRxL6jJfgR2AOQIq+sCWcaFtA7L+Y
	Wcj2GX1cm6kt/YoRmlS+gsxhp5Jy5gG5kDjYjPrqkPvKEzPMZLBD4VSANbTJXxUklIc9lb4UA7UdR
	12ujl6uxabyVQFGZnGdh8z31wWO9+2jJIfh31nZsN/vDA96AJrAdZxf/ejHrTeKGr+CVWAVTDLULU
	9CZdNacA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vy7vA-00000006ja5-2wO2;
	Thu, 05 Mar 2026 12:35:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0C587300CDE; Thu, 05 Mar 2026 13:35:05 +0100 (CET)
Date: Thu, 5 Mar 2026 13:35:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Mikhail Zaslonko <zaslonko@linux.ibm.com>, linux-next@vger.kernel.org,
	linux-s390@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [linux-next][s390] Boot hang after merge c50f05bd3c4e
 (sched/hrtick)
Message-ID: <20260305123505.GA1395416@noisy.programming.kicks-ass.net>
References: <af549a19-db99-4b16-8511-bf315177a13e@linux.ibm.com>
 <28add480-4841-4e6a-a8a9-1211280ecc51@linux.ibm.com>
 <20260305074922.7170Ad3-hca@linux.ibm.com>
 <20260305121201.GB596554@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305121201.GB596554@noisy.programming.kicks-ass.net>
X-Rspamd-Queue-Id: E5B9E211C9F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16887-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 01:12:01PM +0100, Peter Zijlstra wrote:

> > Any idea?
> 
> Well, that all looks like timers are going missing. Which matches with
> Sven saying that disabling HRTIMER_REARM_DEFERRED makes it go again.
> 
> I'm just not sure I can see why things would break between
> sched/hrtick (GOOD) and 1b8b1bb2a2fa (BAD).
> 
> Looking at the diff (eg git diff d50da4b5915f..c50f05bd3c4e) show some
> idle time changes to s390 and various kernel/ changes, but nothing that
> stands out to me :/

That s390 idle time code..

  0d785e2c324c ("s390/idle: Fix cpu idle exit cpu time accounting")

That moves this_cpu_add() from inside irq_enter_rcu() / irq_exit_rcu()
to outside of it.

Your this_cpu_add() as preempt_enable(), which does a preemption check.

Moving that before irq_enter_rcu() means it doesn't see HARDIRQ_OFFSET
in preempt_count(). As such, it might actually call into schedule() from
hardirq context.

Or am I missing something?

