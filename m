Return-Path: <linux-s390+bounces-20638-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cJqULAPkJ2qc4AIAu9opvQ
	(envelope-from <linux-s390+bounces-20638-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 11:59:31 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AA865EA38
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 11:59:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=ooLJlfOE;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20638-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-20638-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFF8C30884A9
	for <lists+linux-s390@lfdr.de>; Tue,  9 Jun 2026 09:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF35438E5DE;
	Tue,  9 Jun 2026 09:52:17 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BDA35F19A;
	Tue,  9 Jun 2026 09:52:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998737; cv=none; b=E/BusGZNhpd0v87gnVZltmLp5HDhvP4UnWIL01bjqV15BWNbf6MfhcKEwBBTu968ET2cKZD5mY+9zWTJl9dOFg9/GoWXQZO6abspgk/+q1EzXA4vgUOF0FO3Ej0+qW3pe7zkjRuq3WPUilpdUMFghiIq5LvY9HSzT+gdB1B0Sko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998737; c=relaxed/simple;
	bh=7Gm8IWj74rkR6Fam5HRaVOftsIil1bnkU2DA0s2ev9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARFJiSTDm2awo9pDEPwRW+2uikJ6j7O42LFUeKegenQs3wxzzmIWWm1g9dnq7mk0bCkhPwHmGfFVyv0ivmactGMDsVkVPFX3tqY9fsA3yL8ZSGL7T4BcSCq9QVmnak67Q7Dh0+4w4nKhbW5ZxFDiMUs7uOirKolBhV3Y33mTpr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ooLJlfOE; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EA922680;
	Tue,  9 Jun 2026 02:52:11 -0700 (PDT)
Received: from [10.1.27.20] (unknown [10.1.27.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34C193FE53;
	Tue,  9 Jun 2026 02:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780998736; bh=7Gm8IWj74rkR6Fam5HRaVOftsIil1bnkU2DA0s2ev9I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ooLJlfOEr7ZL2QA/0vPpHDJ/7YZplsVHE5KNhwqEYENwV6So+5heyVPezWy6SlWvD
	 TOQSEhoB8h3sZ1jQ2osWz+vvs3O9hgNOakeaWDVW7cUQM09OXWA2+BlAmbkrS938Ua
	 KAxw7NccdP4sdTsMo1sNJw4KHX9lCa8q9FWqQsQk=
Message-ID: <dece845e-12df-4aa0-b515-a41458bfbae3@arm.com>
Date: Tue, 9 Jun 2026 10:52:11 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] s390/tick: Remove CIF_NOHZ_DELAY flag
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
 <20260609075213.31094-2-meted@linux.ibm.com>
 <e70007af-aa98-4870-985a-6648564127fd@arm.com>
 <7d2ace86-f355-4ff7-886b-7963574b2202@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <7d2ace86-f355-4ff7-886b-7963574b2202@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20638-lists,linux-s390=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[christian.loehle@arm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:meted@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:svens@linux.ibm.com,m:rafael@kernel.org,m:daniel.lezcano@kernel.org,m:anna-maria@linutronix.de,m:frederic@kernel.org,m:mingo@kernel.org,m:tglx@kernel.org,m:iii@linux.ibm.com,m:borntraeger@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,arm.com:dkim,arm.com:mid,arm.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42AA865EA38

On 6/9/26 10:40, Mete Durlu wrote:
> On 6/9/26 10:10, Christian Loehle wrote:
>> On 6/9/26 08:52, Mete Durlu wrote:
>>> Remove obsolete tick delay heuristic [1]. The upcoming cpuidle driver
>>> handles frequent sleep/wakeup cycles more effectively.
>>>
>>> [1] https://lore.kernel.org/all/20090929122533.402715150@de.ibm.com/
>>>
>>> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
>>> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
>>> ---
>> For bisectibility does it make sense to move this and 2/5 to the end?
> 
> I am unable to see how that would help. Could you elaborate?

CIF_NOHZ_DELAY is only obsolete because of the new s390 cpuidle driver
handles NOHZ better overall right?
So my suggestion was to only obsolete it once everything is in place?

