Return-Path: <linux-s390+bounces-21424-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UlsjImHTRGrx1QoAu9opvQ
	(envelope-from <linux-s390+bounces-21424-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 10:44:17 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB696EB399
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 10:44:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=WlkVgNkT;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=i5WUD6yc;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21424-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21424-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02F2C30209D5
	for <lists+linux-s390@lfdr.de>; Wed,  1 Jul 2026 08:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD853E95BD;
	Wed,  1 Jul 2026 08:41:57 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647CD3DEADC;
	Wed,  1 Jul 2026 08:41:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895317; cv=none; b=sHlJxGUtW4EATXNDjCx/4K5Fjmu2LtHptZ8lr8utyUJ6zC+/+QjYUV0cEpqTU8SLYaUL5Lerk/JzCuoIei2dMbTfT6GFl32F2/K5wh9bSPWgUg9Uw3OWFSS2epy7FbsKb7WDrwf2+o6fuHjHyQvzOFutJSqgOGYpynxT9YGRwPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895317; c=relaxed/simple;
	bh=hIW/bfoVhF6C8YrHlddSaYp+8+PB2sPCZ1uwcJ1svP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shuX5TnDrDJcVuGwtavDgj63VuKsrMprpgyH+mInnwem2DMZrDcyaGyU+2k2iolXxb8SlGlg/XpeOeMasio1g6QrF6R/CFabMDIWWaAEYXKBG4Qjuz5oMDTHvLNm5HBAr/zYmkS3zLc1ZI25b+uWpYmXaqW8O8IhVX2oeoP9zw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WlkVgNkT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i5WUD6yc; arc=none smtp.client-ip=193.142.43.55
Date: Wed, 1 Jul 2026 10:41:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782895312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hIW/bfoVhF6C8YrHlddSaYp+8+PB2sPCZ1uwcJ1svP8=;
	b=WlkVgNkTFIYNtIj5qhELBYQd+AxKqlkZG3TrLGwri5qEahI5i2Iq5DPX1nRgw4bnbyacTw
	G6IG8Qy3NuzNrCDMtIbAL5uMpEgdi1pIXIqiIyZJuvq+UJQxYzRGJrpiwLWtT4av1uVvlD
	RGAbzJcyGPtwci6yrymLNTmaiULCn8ET6Tnkm2/7TuvhZos5optOP0cIInMD0X64zBibOX
	wlFtEzmKWPN5JwVjZUwN0LY1fw2+Qpa9cS/QY9chuZM14XdjrlPKAF/CfWpGQWzlVWB5Cy
	hjsnfyncyhqRk3d2cx8c1W7hUUH3sjBIOm/jrY9WePU3JRRm9ynzK2e7bJ681w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782895312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hIW/bfoVhF6C8YrHlddSaYp+8+PB2sPCZ1uwcJ1svP8=;
	b=i5WUD6yceXQe3x8TOrF2eWaGcrFDsh2T9jch8rsli5FTanCRAoIUsTybzMrCtoXwtD6xPq
	deJ2Wb7rO9Vu+lAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Charlie Jenkins <thecharlesjenkins@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Huth <thuth@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jisheng Zhang <jszhang@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v5 8/8] futex: Use runtime constants for __futex_hash()
 hot path
Message-ID: <20260701084150.GNOeboLw@linutronix.de>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-9-kprateek.nayak@amd.com>
 <20260701075714.GP48970@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701075714.GP48970@noisy.programming.kicks-ass.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21424-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:kprateek.nayak@amd.com,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:dvhart@infradead.org,m:dave@stgolabs.net,m:andrealmeid@igalia.com,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:samuel.holland@sifive.com,m:thecharlesjenkins@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:hpa@zytor.com,m:thuth@redhat.com,m:seanjc@google.com,m:jszhang@kernel.org,m:alex@ghiti.fr,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[amd.com,arndb.de,kernel.org,redhat.com,alien8.de,linux.intel.com,arm.com,dabbelt.com,eecs.berkeley.edu,linux.ibm.com,infradead.org,stgolabs.net,igalia.com,vger.kernel.org,sifive.com,gmail.com,lists.infradead.org,zytor.com,google.com,ghiti.fr];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:mid,linutronix.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EB696EB399

On 2026-07-01 09:57:14 [+0200], Peter Zijlstra wrote:
> The big $1M question: does it actually make it go faster? The whole
> point here was performance, right? But I'm not seeing numbers showing
> how awesome these patches are.

I did complain about the about the size of __futex_data which is blown
on distro kernels due to CONFIG_NODES_SHIFT=10 on Debian for instance.
This makes it go away at no extra price but yeah let me boot a big box
and see.
If the performance remains unchanged it is still worth considering due
to size savings on the average box with 1 node. The biggest box I have
access to has four nodes. If I remember correctly, Prateek was saying
that AMD has "normal" boxes which would require =9 for normal operation
and they do run distro kernels so lowering that value is not an option.

Sebastian

