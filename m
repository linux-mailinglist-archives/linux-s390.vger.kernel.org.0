Return-Path: <linux-s390+bounces-20631-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZYkyADLLJ2pP2QIAu9opvQ
	(envelope-from <linux-s390+bounces-20631-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 10:13:38 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5905C65D9FB
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 10:13:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=Le6kKzpb;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20631-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-20631-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23EE2303AF11
	for <lists+linux-s390@lfdr.de>; Tue,  9 Jun 2026 08:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F243EA97B;
	Tue,  9 Jun 2026 08:06:25 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4D33E95B1;
	Tue,  9 Jun 2026 08:06:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992385; cv=none; b=EtI1gj+UFjjWHYAcvTItJLlaArZUJeRqNjCCOyJILeiK+WSl3zl7Gzct4OiMLmUijpD5vU5e7SVJnDJRm3Mr4PxRvckcMNL35lkSL31EYQN3eYLwaUqI3HTvu1VzCwYSXl/No9SQ3+gogZuDOa/w7XZ+DRIYjuJFoynL9DiopFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992385; c=relaxed/simple;
	bh=qwbcgQ/WQsVIsTXkXunVAagyi9kEj56i64FLMZACVYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jb7/CmQ9hW7ewpWgtkH3VnkvaC/Mpqe7RSQGJQjqw+p8gYkBhqkpTNgrmG/hf+d7RU8gAmz1FEWHm/w/C/OkKOzWo4+CxhdCyTMrFG2RTrELRumG/xWGAWU9RoFIknRpQJV6+JA1wOnQjb9WFF1iHaUADo6L1mYmcPvq4FCLz60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Le6kKzpb; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 486592681;
	Tue,  9 Jun 2026 01:06:19 -0700 (PDT)
Received: from [10.1.29.25] (e127648.arm.com [10.1.29.25])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D91C3F93E;
	Tue,  9 Jun 2026 01:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780992384; bh=qwbcgQ/WQsVIsTXkXunVAagyi9kEj56i64FLMZACVYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Le6kKzpbUjoiHGhxUJ9PVimGhMg2bwpTBrPEfPdyePRQK/9hvH76xmCErt4nL6IPb
	 45gi+/BkZ89WZ5ClhOwWBsJhxXLyWeTthgDcnMDowqtw/BzsKbBE0Fio2L67Q6J78h
	 9TMgZJBqwERGj/ITSfLAP9ijrCEmyZWqvY4thmLw=
Message-ID: <2e07e79f-dee9-4ae7-a51d-eb132cc4abfa@arm.com>
Date: Tue, 9 Jun 2026 09:06:16 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] s390/idle: CPU idle driver
To: Mete Durlu <meted@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 linux-s390 <linux-s390@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20260609075213.31094-1-meted@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260609075213.31094-1-meted@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:meted@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:svens@linux.ibm.com,m:rafael@kernel.org,m:daniel.lezcano@kernel.org,m:anna-maria@linutronix.de,m:frederic@kernel.org,m:mingo@kernel.org,m:tglx@kernel.org,m:iii@linux.ibm.com,m:borntraeger@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20631-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[christian.loehle@arm.com,linux-s390@vger.kernel.org];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	RCPT_COUNT_TWELVE(0.00)[15]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5905C65D9FB

On 6/9/26 08:52, Mete Durlu wrote:
> This patch series introduces a CPU idle driver for s390
> architecture that leverages the existing cpu idle infrastructure and
> TEO (Timer Events Oriented) governor to optimize idle state selection
> based on timer events and interrupt patterns.
> 
> # Implementation Overview
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
I don't quite get the TEO focus of this series, on principle menu works
similarly, did TEO just work much better for you?
If so do you know why?

