Return-Path: <linux-s390+bounces-22099-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B2y1GXSNVGrwnAMAu9opvQ
	(envelope-from <linux-s390+bounces-22099-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 09:02:12 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B948E747C39
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 09:02:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b="xuFdla/6";
	dkim=pass header.d=linutronix.de header.s=2020e header.b=cXVv1a5z;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22099-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22099-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 875DF300CE48
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 07:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446D831326A;
	Mon, 13 Jul 2026 07:02:03 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3029ACCD;
	Mon, 13 Jul 2026 07:02:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926123; cv=none; b=BtxRvgojsWX43DbU7imxrT6hqe3NrUy6YPjb/Z+zEquZQqWf4d50wbtj2/bolXc9TLzA3c4fRODBIdHLgsuOOI1zf5jJhRovy+Vb8qYyA+WEyZH9G2w0RUr+vinbqteQGU3WdSoSyQqjjkpRnSpUx0TiJFJOeKdrdwuZcSPtXTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926123; c=relaxed/simple;
	bh=7qgYWfsFyZ2RgA/27lsYmYQZTrcjl45mKP6ePkNwd3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTUWScNU7d33coXMdhoW7DR8U9M2IoV+TWsMnbdPhOqr077dqJMrDMWw8/wrfL8qFHxhHtSLFU56FFo1o4p69lEhpvrY+iy0z/66fwl93O/omJhlnvd0clBei39WhYyh081Q+zsO6fG2s1e0aWBFjkW5ztJQqgO/3WkNfjv7kYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xuFdla/6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cXVv1a5z; arc=none smtp.client-ip=193.142.43.55
Date: Mon, 13 Jul 2026 09:01:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783926118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnmxNdHqKoh6xuYofsr73YiT+W94DI4jpIiM80uad1k=;
	b=xuFdla/6ifWVxs+wZ/ziKIXPwTG8sNl1CvOxpSkj7lA5470k6wTgjpeu7/nlRL+oihS2Qs
	JADuHCTtvX5KsRBE+2BwukLfzUJWDi3WmNcefXD07sqWlxw7cq54WE1/rhAb0H08RGTG54
	NKVh6zGp+juLKf0xn/ZZ/iHAUAMgZL1Gz+AEf4FCljbY9Gs2UrRNV9CQfA9ZnvX7iuY/CR
	+eH0hO+UwyFjJgLhe6cGdJg9VIHjkyqxDiQcyzD1kAE21gJQJA90gnhj4aClj+bpR70P1/
	PyuEkKpTBKkI7DGLCZkpzwWyVeBOFCXJejv6p2QBYbd8qAfd3VxT9OjpsNrVgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783926118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnmxNdHqKoh6xuYofsr73YiT+W94DI4jpIiM80uad1k=;
	b=cXVv1a5zXQlrcFC6I4GHPNC9QKNeWn00sP2uqrUVvBJohK68NTBxPt4JyPk2bcommOIhMi
	q3BAQe+PJhx4WPDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, nathan@kernel.org, kees@kernel.org, 
	xur@google.com, arnd@arndb.de, peterz@infradead.org, gourry@gourry.net, 
	lukas.bulwahn@redhat.com, ryan.roberts@arm.com, yangtiezhu@loongson.cn, 
	mchauras@linux.ibm.com, sshegde@linux.ibm.com, austin.kim@lge.com, jchrist@linux.ibm.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH RESEND] syscall_user_dispatch: Introduce
 ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
Message-ID: <20260713085930-c6e454ac-cb4d-4016-8971-49df521e1d8d@linutronix.de>
References: <20260713035422.582771-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713035422.582771-1-ruanjinjie@huawei.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.60 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22099-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[thomas.weissschuh@linutronix.de,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,zytor.com,google.com,arndb.de,infradead.org,gourry.net,arm.com,loongson.cn,lge.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[40];
	FORGED_RECIPIENTS(0.00)[m:ruanjinjie@huawei.com,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:nathan@kernel.org,m:kees@kernel.org,m:xur@google.com,m:arnd@arndb.de,m:peterz@infradead.org,m:gourry@gourry.net,m:lukas.bulwahn@redhat.com,m:ryan.roberts@arm.com,m:yangtiezhu@loongson.cn,m:mchauras@linux.ibm.com,m:sshegde@linux.ibm.com,m:austin.kim@lge.com,m:jchrist@linux.ibm.com,m:x86@kernel.org,m:linux-kernel@vger.kernel.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs.org,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B948E747C39

On Mon, Jul 13, 2026 at 11:54:22AM +0800, Jinjie Ruan wrote:
> Currently, only x86 genuinely implements and supports Syscall User
> Dispatch (SUD). Multiple architectures provide a stub
> arch_syscall_is_vdso_sigreturn() returning 'false' simply to satisfy
> GENERIC_ENTRY compilation, which creates a false impression of feature
> support.
> 
> Introduce ARCH_SUPPORTS_SYSCALL_USER_DISPATCH to decouple this mechanism
> from GENERIC_ENTRY. Select it exclusively on x86 and remove the redundant
> stub functions from other architectures.
> 
> Link: https://lore.kernel.org/linux-arm-kernel/akZgV0Y4YAmB43_g@J2N7QTR9R3.cambridge.arm.com/
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Gregory Price <gourry@gourry.net>
> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Cc: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

> ---
> v1 -> RESEND
> - Define missing ARCH_SUPPORTS_SYSCALL_USER_DISPATCH.

If code is changed it is not a resend. Instead it should have been v2.

> ---
>  arch/Kconfig                         | 4 ++++
>  arch/loongarch/include/asm/syscall.h | 6 ------
>  arch/powerpc/include/asm/syscall.h   | 5 -----
>  arch/riscv/include/asm/syscall.h     | 5 -----
>  arch/s390/include/asm/syscall.h      | 5 -----
>  arch/x86/Kconfig                     | 1 +
>  6 files changed, 5 insertions(+), 21 deletions(-)

(...)

