Return-Path: <linux-s390+bounces-9036-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744B8A39349
	for <lists+linux-s390@lfdr.de>; Tue, 18 Feb 2025 06:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22231701BE
	for <lists+linux-s390@lfdr.de>; Tue, 18 Feb 2025 05:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA831A23AE;
	Tue, 18 Feb 2025 05:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oRHY3T2D"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED68749C;
	Tue, 18 Feb 2025 05:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739858341; cv=none; b=S+uYmSb70k02p8rpJeh2zIqttS7rtxPHbmWL8bxOcHku2ZvR3pU+OWApXf51MXUzP/XcBJErBUBWQs7tr/FSdseaG0f1KSXR7nNhu3cdrtlYnNwVcM9q8f3lnxYBUHRNMQM2x7Wl9ira8O8RT7w96n55YZ8sq7sQ7cowjnh2BME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739858341; c=relaxed/simple;
	bh=CEVJqpctOMdfCysXFks3+xB0utmM69RdwWx2wPnB110=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rihCt97Gj26PfT4d7VEqjfvlwWjqY0OQK1wCvI1j2atknmNkHFgBOTyylkTZK26TZ9+QsrbcKOAcIVUSwGE8NoUJnISRx2wilPt/y3zn9qVlhnrTKyv9vLDGsZPd8BV/5+r4zUNeKQV4MjLRmwZAOQw0ntZP9T12txsJLRq2GV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oRHY3T2D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HFddcH020021;
	Tue, 18 Feb 2025 05:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tjVxHI
	8p+Dwo9AwyLlaVxDg1pLMBBHhFN5oRVlEBrGk=; b=oRHY3T2Dro3K+EtlSRLH1t
	nl5+cJln+aLYxg2mqCQsCwdP8O8mG6+YjHd6krlclOVnCxoPI0rMtXAGYtvotECz
	lTyTEdJynzeBFwuocgeb2nKN80cntn+EN/Vy25M30be1uS4hM8TL7+LQBIcrv16t
	wt+JX2GydVxGdfBk0Cyip3ubfIstDVvEsPSWXiqxXSRU1SFKugIned4ihBSp6Dc/
	0/afxTEODdBbZbquZztZBF3/jZiaXuM2YFk8uK/maKj+s3yhHAkmJ34z8+WduRIK
	uDKdPl7vkEhF6Fy98VvDAYyjcLklKR/JQnb4CmmEpZ50JCFTe/uhatQ1Hx2vPMCw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44v7xub15p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 05:58:44 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51I5pjSO003681;
	Tue, 18 Feb 2025 05:58:44 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44v7xub15k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 05:58:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51I52mgT008148;
	Tue, 18 Feb 2025 05:58:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u58thqv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 05:58:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51I5wfH330933560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 05:58:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BB0720043;
	Tue, 18 Feb 2025 05:58:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05AFB20040;
	Tue, 18 Feb 2025 05:58:39 +0000 (GMT)
Received: from [9.124.222.120] (unknown [9.124.222.120])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2025 05:58:38 +0000 (GMT)
Message-ID: <cc6996cc-c5c1-429d-ade0-9978b859f207@linux.ibm.com>
Date: Tue, 18 Feb 2025 11:28:38 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] sched/fair: introduce new scheduler group type
 group_parked
To: Tobias Huschle <huschle@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
References: <20250217113252.21796-1-huschle@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250217113252.21796-1-huschle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Swk8pcBcXOq8yXLxc2f4gxkz7F_GouNO
X-Proofpoint-GUID: Lka8UfRi4Fvf0hl-0fYnSZi1AmeqmgsS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_01,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180039



On 2/17/25 17:02, Tobias Huschle wrote:
> Changes to v1
> 
> parked vs idle
> - parked CPUs are now never considered to be idle
> - a scheduler group is now considered parked iff there are parked CPUs
>    and there are no idle CPUs, i.e. all non parked CPUs are busy or there
>    are only parked CPUs. A scheduler group with parked tasks can be
>    considered to not be parked, if it has idle CPUs which can pick up
>    the parked tasks.
> - idle_cpu_without always returns that the CPU will not be idle if the
>    CPU is parked
> 
> active balance, no_hz, queuing
> - should_we_balance always returns true if a scheduler groups contains
>    a parked CPU and that CPU has a running task
> - stopping the tick on parked CPUs is now prevented in sched_can_stop_tick
>    if a task is running
> - tasks are being prevented to be queued on parked CPUs in ttwu_queue_cond
> 
> cleanup
> - removed duplicate checks for parked CPUs
> 
> CPU capacity
> - added a patch which removes parked cpus and their capacity from
>    scheduler statistics
> 
> 
> Original description:
> 
> Adding a new scheduler group type which allows to remove all tasks
> from certain CPUs through load balancing can help in scenarios where
> such CPUs are currently unfavorable to use, for example in a
> virtualized environment.
> 
> Functionally, this works as intended. The question would be, if this
> could be considered to be added and would be worth going forward
> with. If so, which areas would need additional attention?
> Some cases are referenced below.
> 
> The underlying concept and the approach of adding a new scheduler
> group type were presented in the Sched MC of the 2024 LPC.
> A short summary:
> 
> Some architectures (e.g. s390) provide virtualization on a firmware
> level. This implies, that Linux kernels running on such architectures
> run on virtualized CPUs.
> 
> Like in other virtualized environments, the CPUs are most likely shared
> with other guests on the hardware level. This implies, that Linux
> kernels running in such an environment may encounter 'steal time'. In
> other words, instead of being able to use all available time on a
> physical CPU, some of said available time is 'stolen' by other guests.
> 
> This can cause side effects if a guest is interrupted at an unfavorable
> point in time or if the guest is waiting for one of its other virtual
> CPUs to perform certain actions while those are suspended in favour of
> another guest.
> 
> Architectures, like arch/s390, address this issue by providing an
> alternative classification for the CPUs seen by the Linux kernel.
> 
> The following example is arch/s390 specific:
> In the default mode (horizontal CPU polarization), all CPUs are treated
> equally and can be subject to steal time equally.
> In the alternate mode (vertical CPU polarization), the underlying
> firmware hypervisor assigns the CPUs, visible to the guest, different
> types, depending on how many CPUs the guest is entitled to use. Said
> entitlement is configured by assigning weights to all active guests.
> The three CPU types are:
>      - vertical high   : On these CPUs, the guest has always highest
>                          priority over other guests. This means
>                          especially that if the guest executes tasks on
>                          these CPUs, it will encounter no steal time.
>      - vertical medium : These CPUs are meant to cover fractions of
>                          entitlement.
>      - vertical low    : These CPUs will have no priority when being
>                          scheduled. This implies especially, that while
>                          all other guests are using their full
>                          entitlement, these CPUs might not be ran for a
>                          significant amount of time.
> 
> As a consequence, using vertical lows while the underlying hypervisor
> experiences a high load, driven by all defined guests, is to be avoided.
> 
> In order to consequently move tasks off of vertical lows, introduce a
> new type of scheduler groups: group_parked.
> Parked implies, that processes should be evacuated as fast as possible
> from these CPUs. This implies that other CPUs should start pulling tasks
> immediately, while the parked CPUs should refuse to pull any tasks
> themselves.
> Adding a group type beyond group_overloaded achieves the expected
> behavior. By making its selection architecture dependent, it has
> no effect on architectures which will not make use of that group type.
> 
> This approach works very well for many kinds of workloads. Tasks are
> getting migrated back and forth in line with changing the parked
> state of the involved CPUs.
> 
> There are a couple of issues and corner cases which need further
> considerations:
> - rt & dl:      Realtime and deadline scheduling require some additional
>                  attention.

I think we need to address atleast rt, there would be some non percpu 
kworker threads which need to move out of parked cpus.

> - ext:          Probably affected as well. Needs some conceptional
>                  thoughts first.
> - raciness:     Right now, there are no synchronization efforts. It needs
>                  to be considered whether those might be necessary or if
>                  it is alright that the parked-state of a CPU might change
>                  during load-balancing.
> 
> Patches apply to tip:sched/core
> 
> The s390 patch serves as a simplified implementation example.


Gave it a try on powerpc with the debugfs file. it works for 
sched_normal tasks.

> 
> Tobias Huschle (3):
>    sched/fair: introduce new scheduler group type group_parked
>    sched/fair: adapt scheduler group weight and capacity for parked CPUs
>    s390/topology: Add initial implementation for selection of parked CPUs
> 
>   arch/s390/include/asm/smp.h    |   2 +
>   arch/s390/kernel/smp.c         |   5 ++
>   include/linux/sched/topology.h |  19 ++++++
>   kernel/sched/core.c            |  13 ++++-
>   kernel/sched/fair.c            | 104 ++++++++++++++++++++++++++++-----
>   kernel/sched/syscalls.c        |   3 +
>   6 files changed, 130 insertions(+), 16 deletions(-)
> 


