Return-Path: <linux-s390+bounces-21007-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v8L0LRUZNGrbOQYAu9opvQ
	(envelope-from <linux-s390+bounces-21007-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 18:13:09 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DB36A1847
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 18:13:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=aDf8Re86;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21007-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-21007-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3D3D30048C2
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 16:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FAF3403ED;
	Thu, 18 Jun 2026 16:06:36 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3770A32B128;
	Thu, 18 Jun 2026 16:06:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798796; cv=none; b=K2gVGI4H04Mo5/s8+I9lClNAjdXeQKXdRPkphR3/MEwYx71PpxYylLBRhhYbcadkAwhJf5QmzLYHBw2qKcp6dO9hMxQpq8X/dX+V8rOt8Pc21+75nKJmNdPPOhWuzmd+qBQH2zAMv5zdSENfwgvoEBZmYWx2TkrQ9cdY0g1VvXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798796; c=relaxed/simple;
	bh=S7/atp7qhCI/LBkPov1K1NfiCLzklLsUfrZnQ8z2FJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijP1R9qBAiP+0tgK8cQHpSaNbz4FS8hytmx0QPT9mxNfKBzyCR5A45AHDA/HWs5dNoGgv3kpx8qAecg0Oiy1RuBTONcWVb0jX1ONZJP6yKscdJ1ulBQ66tjeVANTMwxFWgbU/pY6NRNz6YuCOW2NGdtg0sPkMaNEfUE6ucqdCS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aDf8Re86; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF044493F;
	Thu, 18 Jun 2026 09:06:29 -0700 (PDT)
Received: from [10.57.24.180] (unknown [10.57.24.180])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE2143F632;
	Thu, 18 Jun 2026 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781798794; bh=S7/atp7qhCI/LBkPov1K1NfiCLzklLsUfrZnQ8z2FJA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aDf8Re86s92xSZizM8Uf0vxbf54v4hQwugiO0mbDN1+4dPUU2j8zKDqLuov8bLBiI
	 3CRiqjECQ46Xm1IQjJwM1nYPWKby+1bvSNGID0zZt8vGa95TRAJqkboktiqlRUE14F
	 9I7Fj3hbz0KJZbKK90ikSbzhAbZPpNo9UI/SSd8Q=
Message-ID: <e6723ea1-2400-4edc-aee8-8be7d9cb7945@arm.com>
Date: Thu, 18 Jun 2026 17:06:30 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] s390/idle: Introduce cpuidle for s390
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
References: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
 <20260618-idledriver-v3-4-684061eecbcb@linux.ibm.com>
 <464e277c-40f8-4812-85f6-67b470436692@arm.com>
 <f280ac2a-7690-42eb-aca2-3cef711d71c9@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <f280ac2a-7690-42eb-aca2-3cef711d71c9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21007-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:email,arm.com:mid,arm.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27DB36A1847

On 6/18/26 15:47, Mete Durlu wrote:
> On 6/18/26 4:41 PM, Christian Loehle wrote:
>> On 6/18/26 13:00, Mete Durlu wrote:
>>> Introduce generic cpuidle driver on s390. Use a two stage approach to
>>> handle idle scenarios and use idle governor for idle stage selection.
>>> Two stages are, from shallow to deep, idle polling and enabled wait.
>>>
>>> Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>>> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
>>> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
>>> ---
> 
> [..snip..]
> 
> 
>>> +static int s390_cpuidle_cpu_online(unsigned int cpu)
>>> +{
>>> +    struct cpuidle_device *dev = &per_cpu(cpuidle_dev, cpu);
>>> +    int rc;
>>> +
>>> +    if (dev->registered) {
>>> +        cpuidle_pause_and_lock();
>>> +        rc = cpuidle_enable_device(dev);
>>> +        cpuidle_resume_and_unlock();
>>> +        if (rc)
>>> +            pr_err("Failed to enable cpuidle device on cpu %u\n", cpu);
>>> +    } else {
>>> +        dev->cpu = cpu;
>>> +        rc = cpuidle_register_device(dev);
>>> +        if (rc)
>>> +            pr_err("Failed to register cpuidle driver on cpu %u\n", cpu);
>>> +    }
>>> +    return rc;
>>
>> Most other drivers allow for hotplug cpu_online to succeed even if cpuidle doesn't, is
>> this intentionally done otherwise here?
> 
> Yes it is by design. Users would not be aware that something went wrong
> if we don't fail here (unless they check dmesg regularly which we don't
> expect). By failing here driver communicates that there is a problem
> and allows users to resolve that instead of letting a cpu run with
> degraded performance.
> 

Okay, thanks!
So FWIW this looks reasonable to me now, can't really comment much
on the s390 specifics, in particular as a guest, but from a purely
cpuidle perspective this looks okay, so good to see that this seems
to be working for you!

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

