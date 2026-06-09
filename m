Return-Path: <linux-s390+bounces-20699-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SCh8D6A7KGpVAgMAu9opvQ
	(envelope-from <linux-s390+bounces-20699-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 18:13:20 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B1666231E
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 18:13:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=Jo4JxxNG;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20699-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20699-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91FE532DE9FD
	for <lists+linux-s390@lfdr.de>; Tue,  9 Jun 2026 15:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E311C495506;
	Tue,  9 Jun 2026 15:47:45 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B179340BCC0;
	Tue,  9 Jun 2026 15:47:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020065; cv=none; b=Kun6/yb+kpe1CzRkKcxS8lnE+P6HhNiLNWoXqr2EJHQ6Pt5X/X+ur5y3R5g0mXLCuLh3VQtMf0I7iGcN+27NrykLzUWF+OrFBXdFdJ3ogmeArs9uCA5Z7NuLMBWK/qACM5fNrQVv51SfOba0RDgTkEpCxFrGD3jQRwx2vDHjmlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020065; c=relaxed/simple;
	bh=0aC3hWoz/Olyd4D8O79tYgqL54u3mce9Je6cOCupXj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fr7HzaWKoRPpY0ctcv5ogodWz0yortDFa+eKLuDZvFwOqsu8KOJOeDVBfWUVnzoLK7adbbY26vT9j38jcfNikaI43KXvSvTj7dNYe4ZLkpGOFHylpv7ZbTPyL52syG37LyoRajlQoF6lUWYMDJnbW74oU8bAQ9+6MVRiz42xXvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Jo4JxxNG; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C3073528;
	Tue,  9 Jun 2026 08:47:38 -0700 (PDT)
Received: from [10.57.30.26] (unknown [10.57.30.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85C003FD88;
	Tue,  9 Jun 2026 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781020062; bh=0aC3hWoz/Olyd4D8O79tYgqL54u3mce9Je6cOCupXj0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jo4JxxNGQneNv49KRyosjwZo5FLCfbSJJwmSo5q+5WuN9NJ+IjX2gteqa805bTols
	 e1JCiFoEPa3F304fdDTvlUthw1ENmEzEcF3uVeRcUm54a4NiWQJ5PDQjKITtbgfnCV
	 KKEi+EsvE/EG5TBjhpEicQfewvLwTL1ULwFfr6Rw=
Message-ID: <0e6ff23c-b509-40eb-87f3-7b04fb066edf@arm.com>
Date: Tue, 9 Jun 2026 16:47:37 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] s390/idle: CPU idle driver
To: Mete Durlu <meted@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260609-idledriver-v2-0-21c2f581d11f@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260609-idledriver-v2-0-21c2f581d11f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20699-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:meted@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:svens@linux.ibm.com,m:anna-maria@linutronix.de,m:frederic@kernel.org,m:mingo@kernel.org,m:tglx@kernel.org,m:rafael@kernel.org,m:daniel.lezcano@kernel.org,m:borntraeger@linux.ibm.com,m:iii@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[christian.loehle@arm.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:dkim,arm.com:mid,arm.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0B1666231E

On 6/9/26 14:24, Mete Durlu wrote:
> v1 -> v2:
> 
> * Add idle driver enteries to MAINTAINERS file (Christian Loehle)
> * Remove extra line break left in drivers/cpuidle/Kconfig.s390
>   (Christian Loehle)
> 
> This patch series introduces a CPU idle driver for s390
> architecture that leverages the existing cpu idle infrastructure and
> TEO (Timer Events Oriented) governor to optimize idle state selection
> based on timer events and interrupt patterns.

So if (according to v1) there's no data (yet) that teo is much preferred,
I would remove all mentions of it in code and patch descriptions?
A cpuidle driver requiring a specific governor sort-of violates the
abstraction.
In case teo does work much better for you, which I wouldn't doubt for
a second from what your system looks like, it would be nice to present
some data on it. Additionally I think setting it in the defconfig alone
is probably enough?

> 
> - Implementation Overview
> -----------------------------------------------------------------------
> 
> The driver implements two idle states;
> 
> **Polling Idle (shallow state)**
> - Busy-loop implementation that prevents SIE-exit during short idle periods
> - Zero exit latency, optimized for latency-sensitive workloads
> - Maintains CPU with the guest, improving response times
> 
> **Enabled Wait (deep state)**
> - Traditional EW state that signals hypervisor availability
> - Higher exit latency but more efficient for longer idle periods
> 
> The TEO governor dynamically selects between these states by monitoring
> next timer interrupts and system interrupt frequency, choosing the most
> appropriate idle state for each situation.
> 
> - Performance Benefits
> -----------------------------------------------------------------------
> 
> Benchmark results across LPAR, KVM, and z/VM guests demonstrate significant
> improvements for latency-sensitive and scheduler-intensive workloads:
> 
> ```
> Benchmark    | LPAR  | z/VM  | KVM   |
> -----------------------------------------
> cyclictest   | +45%  | +50%  | +30%  |
> hackbench    | +5%   | +12%  | -     |
> pgbench      | +2%   | +15%  | +2%   |
> uperf        | +50%* | +-5%  | +-5%  |
> ```
> 
> *Single-threaded uperf scenarios show 50-70% improvements on LPAR.
> Multi-threaded results show slight improvements overall.
> 
> Additionally, fio and ioping tests show latency distribution shifts toward
> lower values with reduced minimum and average latencies.
> 
> - Configuration
> -----------------------------------------------------------------------
> 
> Idle state parameters are tuned per hypervisor type after benchmarks:
> 
> **LPAR:**
> - Polling: 5us target residency, 0us exit latency
> - EW: 5us target residency, 5us exit latency
> 
> **KVM/z/VM:**
> - Polling: 1us target residency, 0us exit latency
> - EW: 1us target residency, 1us exit latency
> 
I think this would also be useful in cpuidle-s390.c in particular the
different residency+latency values for LPAR and KVM/z/VM and what they aim
to achieve for you.

Additionally polling is initialised to 0/0 by poll_state.c, so I don't know
where you're taking these values from?

