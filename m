Return-Path: <linux-s390+bounces-22096-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M/KOCRNBVGqJjwMAu9opvQ
	(envelope-from <linux-s390+bounces-22096-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 03:36:19 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86233746770
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 03:36:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=OhHsWWrF;
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22096-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22096-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DD37300889A
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 01:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48D62701B6;
	Mon, 13 Jul 2026 01:36:16 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B06263C8F;
	Mon, 13 Jul 2026 01:36:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783906576; cv=none; b=riC2UB4sndSHt/WMid6qJHuL4asxQTc/K9G6BYybfdwKPIhfDQVuu33PKZwgGaKAvVMWSJnzB4tgSHb85l81E5HUuMq54GTywfHSiYpjAbg4N+o7OH4kaq10fUvLU0aPEcS9nPm14c+4k4OfVw6X551nNGfqk+z/9Fbzt7ZC218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783906576; c=relaxed/simple;
	bh=bibHdppFjtyf0QcJHzBNmxb5u4a5380rDNhF8Uu4KxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vj55fGU+htM6Othku3/11A353YEhC/pQW/LGrK0Xoi5bJCMfRZ9PNQtrGGa/2SWoXVGuggTtcEjGfZftAD20MvI7GXRw5ndX+ohj/KnQkXSM8qNDE1v2nFVtoeuyTz+Y79dUEB5tm79RBEgBt1Qm7gwH/u6gU7e/70ulgWp6J+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OhHsWWrF; arc=none smtp.client-ip=113.46.200.223
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iSKyRunqi7Efa2Mu72Zd3vRWZxizzKBzPxtAO2+QtZI=;
	b=OhHsWWrFqDF4iw01ju/V/wuedSNvk4Qd5RncBOtws+2WzWqGVxRMLU8DWnT+L5aKc3F63rC9o
	zSQF8j/UbvpacJIgfpEFOqJvNSjHOZU8gpv7Avy6L6yPLnkBEoTgPNgjsMMuUcSswDQ5mIW5KFE
	AkTfC23kF7UYdY3K6BSmLV8=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gz4Xm1fF1zmV8S;
	Mon, 13 Jul 2026 09:26:48 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 559ED4055B;
	Mon, 13 Jul 2026 09:36:05 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Jul 2026 09:36:04 +0800
Message-ID: <ad9b5f8f-7c4d-4fbb-b0a3-69859ee8b365@huawei.com>
Date: Mon, 13 Jul 2026 09:36:02 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 2/4] entry: Rework trace_syscall_enter()
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
CC: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, Michael Ellerman
	<mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	<linuxppc-dev@lists.ozlabs.org>, Huacai Chen <chenhuacai@kernel.org>,
	<loongarch@lists.linux.dev>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, <linux-riscv@lists.infradead.org>, Sven Schnelle
	<svens@linux.ibm.com>, <linux-s390@vger.kernel.org>, <x86@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Magnus Lindholm <linmag7@gmail.com>, "Mukesh
 Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>, Radu Rendec <radu@rendec.net>
References: <20260712134433.549076055@kernel.org>
 <20260712141346.639115923@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260712141346.639115923@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22096-lists,linux-s390=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:msuchanek@suse.de,m:mpe@ellerman.id.au,m:sshegde@linux.ibm.com,m:linuxppc-dev@lists.ozlabs.org,m:chenhuacai@kernel.org,m:loongarch@lists.linux.dev,m:pjw@kernel.org,m:palmer@dabbelt.com,m:linux-riscv@lists.infradead.org,m:svens@linux.ibm.com,m:linux-s390@vger.kernel.org,m:x86@kernel.org,m:mark.rutland@arm.com,m:linmag7@gmail.com,m:mkchauras@gmail.com,m:corbet@lwn.net,m:radu@rendec.net,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ruanjinjie@huawei.com,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[suse.de,ellerman.id.au,linux.ibm.com,lists.ozlabs.org,kernel.org,lists.linux.dev,dabbelt.com,lists.infradead.org,vger.kernel.org,arm.com,gmail.com,lwn.net,rendec.net];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruanjinjie@huawei.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,huawei.com:from_mime,huawei.com:email,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86233746770



On 7/13/2026 5:25 AM, Thomas Gleixner wrote:
> Reread the syscall number from pt_regs and stop returning the eventually
> modified syscall number.
> 
> That moves the reread to the end of the syscall_trace_enter() and prepares
> for moving it to the call site.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  include/linux/entry-common.h  |   10 ++++------
>  kernel/entry/syscall-common.c |    9 ++-------
>  2 files changed, 6 insertions(+), 13 deletions(-)
> 
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -58,7 +58,7 @@ static __always_inline bool arch_ptrace_
>  }
>  #endif
>  
> -long trace_syscall_enter(struct pt_regs *regs, long syscall);
> +void trace_syscall_enter(struct pt_regs *regs);
>  void trace_syscall_exit(struct pt_regs *regs, long ret);
>  void syscall_enter_audit(struct pt_regs *regs);
>  
> @@ -96,16 +96,14 @@ static __always_inline long syscall_trac
>  			return -1L;
>  	}
>  
> -	/* Either of the above might have changed the syscall number */
> -	syscall = syscall_get_nr(current, regs);
> -
>  	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
> -		syscall = trace_syscall_enter(regs, syscall);
> +		trace_syscall_enter(regs);
>  
>  	if (unlikely(audit_context()))
>  		syscall_enter_audit(regs);
>  
> -	return syscall;
> +	/* Either of the above might have changed the syscall number */
> +	return syscall_get_nr(current, regs);

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

>  }
>  
>  /**
> --- a/kernel/entry/syscall-common.c
> +++ b/kernel/entry/syscall-common.c
> @@ -8,14 +8,9 @@
>  
>  /* Out of line to prevent tracepoint code duplication */
>  
> -long trace_syscall_enter(struct pt_regs *regs, long syscall)
> +void trace_syscall_enter(struct pt_regs *regs)
>  {
> -	trace_sys_enter(regs, syscall);
> -	/*
> -	 * Probes or BPF hooks in the tracepoint may have changed the
> -	 * system call number. Reread it.
> -	 */
> -	return syscall_get_nr(current, regs);
> +	trace_sys_enter(regs, syscall_get_nr(current, regs));
>  }
>  
>  void trace_syscall_exit(struct pt_regs *regs, long ret)
> 


