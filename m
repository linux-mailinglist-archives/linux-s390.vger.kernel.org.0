Return-Path: <linux-s390+bounces-21893-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iCUNLUtWT2rbegIAu9opvQ
	(envelope-from <linux-s390+bounces-21893-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 09 Jul 2026 10:05:31 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 137CC72E0E2
	for <lists+linux-s390@lfdr.de>; Thu, 09 Jul 2026 10:05:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=DwmhEa4J;
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21893-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21893-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAB02304F2C1
	for <lists+linux-s390@lfdr.de>; Thu,  9 Jul 2026 07:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984F53DE44C;
	Thu,  9 Jul 2026 07:59:34 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C313E0256;
	Thu,  9 Jul 2026 07:59:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583974; cv=none; b=ZwAdX3GULbdRi//9g6sdx8L7opZTsIOuOc0DKBe4tgm/K6WfmJAbYI0B1XWL/KL1kv5pkKzaQn5N9aGxwKFc1O5sc6ylHhPGqlGgWxg2AgJp4gRewduUiMs/8qpLULuxj7A1Cem1FY0CAuK79RiLEUyFkJ6XHFDIvTetPTEl1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583974; c=relaxed/simple;
	bh=d43P6Q8/S6bcamTRIfbVcvyRSMVOh2Ztu2DXjNrcXyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JkQ5Rm2fDcOhmn1mmiZUsonZSeIvjpKr+ta4OCXKDj2d+I3ZWgo0dbcmImYj1O0RSc2XT3IjSMcuCNPGAxajdvo7CrODSbtWnnvwLSNdmsnOnODc/TlbMdUuiIJNvyj2Rn0kLPc/ZM4QnWcHWSB9QmTaZBAdLN/Q2/ZjkomIj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DwmhEa4J; arc=none smtp.client-ip=113.46.200.217
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=amF18KHfc8NodmLlIFl9+tYxitLhQeTXu6ioMRTAIhg=;
	b=DwmhEa4JsZH1zyt75IBFUEkYJMYW+ez6g3GqbaAAdGlvMivx7XQMpEbeY+BIMBJbg82eFYJRv
	A6w879pWEbnndkDFcInfs1Lz7SgEszZcAusSMg9XCYhmUtHeZlgmbQA/qxsMc6wVD2uKd7y78Pu
	9gaY7eN4pgIJHOHwJ3k/0pg=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gwnF96JgNzcb0T;
	Thu,  9 Jul 2026 15:50:21 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id C128A40537;
	Thu,  9 Jul 2026 15:59:26 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jul 2026 15:59:22 +0800
Message-ID: <dfc05f53-6cef-4da2-83c1-6e765ec419fe@huawei.com>
Date: Thu, 9 Jul 2026 15:59:21 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] syscall_user_dispatch: Introduce
 ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
CC: <chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <hca@linux.ibm.com>, <gor@linux.ibm.com>,
	<agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <nathan@kernel.org>,
	<kees@kernel.org>, <xur@google.com>, <peterz@infradead.org>,
	<gourry@gourry.net>, <lukas.bulwahn@redhat.com>, <ryan.roberts@arm.com>,
	<yangtiezhu@loongson.cn>, <sshegde@linux.ibm.com>, <mchauras@linux.ibm.com>,
	<austin.kim@lge.com>, <arnd@arndb.de>, <jchrist@linux.ibm.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>
References: <20260709072803.3843948-1-ruanjinjie@huawei.com>
 <20260709093404-0b19988f-8d19-4fae-86d8-396aa747307d@linutronix.de>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260709093404-0b19988f-8d19-4fae-86d8-396aa747307d@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21893-lists,linux-s390=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[40];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thomas.weissschuh@linutronix.de,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:nathan@kernel.org,m:kees@kernel.org,m:xur@google.com,m:peterz@infradead.org,m:gourry@gourry.net,m:lukas.bulwahn@redhat.com,m:ryan.roberts@arm.com,m:yangtiezhu@loongson.cn,m:sshegde@linux.ibm.com,m:mchauras@linux.ibm.com,m:austin.kim@lge.com,m:arnd@arndb.de,m:jchrist@linux.ibm.com,m:x86@kernel.org,m:linux-kernel@vger.kernel.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs.org,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ruanjinjie@huawei.com,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,zytor.com,google.com,infradead.org,gourry.net,arm.com,loongson.cn,lge.com,arndb.de,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,huawei.com:from_mime,huawei.com:email,huawei.com:mid,huawei.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 137CC72E0E2



On 7/9/2026 3:36 PM, Thomas Weißschuh wrote:
> On Thu, Jul 09, 2026 at 03:28:03PM +0800, Jinjie Ruan wrote:
>> Currently, only x86 genuinely implements and supports Syscall User
>> Dispatch (SUD). Multiple architectures provide a stub
>> arch_syscall_is_vdso_sigreturn() returning 'false' simply to satisfy
>> GENERIC_ENTRY compilation, which creates a false impression of feature
>> support.
>>
>> Introduce ARCH_SUPPORTS_SYSCALL_USER_DISPATCH to decouple this mechanism
>> from GENERIC_ENTRY. Select it exclusively on x86 and remove the redundant
>> stub functions from other architectures.
> 
> Nice, this confused me before.
> 
>> Link: https://lore.kernel.org/linux-arm-kernel/akZgV0Y4YAmB43_g@J2N7QTR9R3.cambridge.arm.com/
>> Cc: Thomas Gleixner <tglx@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
>> Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/Kconfig                         | 1 +
>>  arch/loongarch/include/asm/syscall.h | 6 ------
>>  arch/powerpc/include/asm/syscall.h   | 5 -----
>>  arch/riscv/include/asm/syscall.h     | 5 -----
>>  arch/s390/include/asm/syscall.h      | 5 -----
>>  arch/x86/Kconfig                     | 1 +
>>  6 files changed, 2 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 0c01521c2f3f..393d0fb75eac 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -116,6 +116,7 @@ config GENERIC_ENTRY
>>  
>>  config SYSCALL_USER_DISPATCH
>>  	bool "Syscall User Dispatch"
>> +	depends on ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
> 
> ARCH_SUPPORTS_SYSCALL_USER_DISPATCH is not declared as a config option,
> so the 'select' will not do anything. Needs this:
> 
> config ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
> 	bool

Yes, this is missing here.
> 
>>  	depends on GENERIC_ENTRY
>>  	default y
>>  	help
> 
> (...)


