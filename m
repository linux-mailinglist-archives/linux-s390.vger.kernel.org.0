Return-Path: <linux-s390+bounces-22095-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3fwiH5NAVGp3jwMAu9opvQ
	(envelope-from <linux-s390+bounces-22095-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 03:34:11 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9783746747
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 03:34:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=As7yTkFf;
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22095-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22095-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F17263009B11
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 01:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA522258EFF;
	Mon, 13 Jul 2026 01:34:08 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1349D25783C;
	Mon, 13 Jul 2026 01:34:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783906448; cv=none; b=g0roVfFL6ueutOe+hnnzIhqlx+jdIRMPyFTAp9VBWxmrzwb9T4DF4YfQiUgNyrR2ZG7vBR6j+BYuF3y4/+zf9XuNx+8UYoDILZgEzPQZrAE/FPrT6+1/hjqnPDwcdJ+s8QDq9hc3E38mja3LLM9W0EorJ7veh2jxTi+pShBO8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783906448; c=relaxed/simple;
	bh=ESBAb4FaEwJ3DblC3rWsC/2dgS0VbgJLDXEHmRTNO4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aU919/I8aH170i4Z1uui8jCGXlWhNOG4Qjut4d8sKBFb9nHblYLzekr3o0J+Ey5KsVTw4uLVLOJMcaBtO5Ky065V/H3Ak9CkWwLiX3/4QrOQPsCYjaX8SUuu0LkUPau5Kkh1F+viC9MnL697iQ0OHQmN6dhjgTpoU+fX1fF7n2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=As7yTkFf; arc=none smtp.client-ip=113.46.200.220
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nIM4m5e9jGc2sCxhzH+mYlnpqbqKe9faxrdPztB+tkM=;
	b=As7yTkFfrwDJVeeOgWTYV+UMEyVi3b+jQMQX7rfkp/tm1wuMS9j4Dw2TgZKn8WKc6c7OKl2xJ
	4J+tM+ADkcJXS8glDkArkowYGIiT2JlAmOdOPIng5dw3tqTx9gh09KANnSex0ZsCV4lA0wnaDZY
	fsG/wYMyPD4R0cNbSBIwSTI=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gz4Tr5crRz12LF7;
	Mon, 13 Jul 2026 09:24:16 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id DD07540561;
	Mon, 13 Jul 2026 09:33:55 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Jul 2026 09:33:54 +0800
Message-ID: <7480b818-d44c-47f5-944a-5f17f3429d09@huawei.com>
Date: Mon, 13 Jul 2026 09:33:53 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 1/4] entry: Rework syscall_audit_enter()
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
 <20260712141346.576865340@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260712141346.576865340@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-22095-lists,linux-s390=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9783746747



On 7/13/2026 5:25 AM, Thomas Gleixner wrote:
> Move it out of line and let it reread the syscall number on it's own. That
> makes the low level entry code denser and allows to move the reread to the
> call site of syscall_trace_enter() once the tracer is fixed up.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  include/linux/entry-common.h  |   14 +++-----------
>  kernel/entry/syscall-common.c |   10 ++++++++++
>  2 files changed, 13 insertions(+), 11 deletions(-)
> 
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -60,16 +60,7 @@ static __always_inline bool arch_ptrace_
>  
>  long trace_syscall_enter(struct pt_regs *regs, long syscall);
>  void trace_syscall_exit(struct pt_regs *regs, long ret);
> -
> -static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
> -{
> -	if (unlikely(audit_context())) {
> -		unsigned long args[6];
> -
> -		syscall_get_arguments(current, regs, args);
> -		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
> -	}
> -}
> +void syscall_enter_audit(struct pt_regs *regs);
>  
>  static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned long work,
>  						long syscall)
> @@ -111,7 +102,8 @@ static __always_inline long syscall_trac
>  	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
>  		syscall = trace_syscall_enter(regs, syscall);
>  
> -	syscall_enter_audit(regs, syscall);
> +	if (unlikely(audit_context()))
> +		syscall_enter_audit(regs);

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

>  
>  	return syscall;
>  }
> --- a/kernel/entry/syscall-common.c
> +++ b/kernel/entry/syscall-common.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <linux/audit.h>
>  #include <linux/entry-common.h>
>  
>  #define CREATE_TRACE_POINTS
> @@ -21,3 +22,12 @@ void trace_syscall_exit(struct pt_regs *
>  {
>  	trace_sys_exit(regs, ret);
>  }
> +
> +void syscall_enter_audit(struct pt_regs *regs)
> +{
> +	long syscall = syscall_get_nr(current, regs);
> +	unsigned long args[6];
> +
> +	syscall_get_arguments(current, regs, args);
> +	__audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
> +}
> 


