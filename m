Return-Path: <linux-s390+bounces-18394-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uN2NNmH6zGnRYgYAu9opvQ
	(envelope-from <linux-s390+bounces-18394-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 01 Apr 2026 12:58:41 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B5715378F55
	for <lists+linux-s390@lfdr.de>; Wed, 01 Apr 2026 12:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36044307FEF6
	for <lists+linux-s390@lfdr.de>; Wed,  1 Apr 2026 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81693FB055;
	Wed,  1 Apr 2026 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TRSFkRwV"
X-Original-To: linux-s390@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A1B3DEAE3;
	Wed,  1 Apr 2026 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040936; cv=none; b=QckL4Em5oIb91VrJD61fweNnlfDb5LfsX8s0x2HW9qpiPIfojGnzke2d1Aa0TGaem5aVOgAqlcgm+kOVZgynTUrWuyL12LHRA6DmMaXe2wRCCxhnCKJbwSJtyE5d27i6YLzZNxnc9P2/dntEb2xDH5mILWdr/q2U77xJDYNzsxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040936; c=relaxed/simple;
	bh=2UQIkCCHHnYMJL08xGfBrcE6awkfKjIUqvN58fjiAvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ji9aJa/RIVRjVlimrwnLPPnpG6LyR4/k7coqahSkT/Gt7GQHfKDrgQL2g5iojCDsTe4bzEXN05mlqhjhmx6z6mtrQTMMoWWj4wPvrpnAquZJZEQpJwxSARAPVwAyHtppCKE96oO7s7MMdhLIS0kcKbZuKNYHilmo24K2evoPSoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TRSFkRwV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43486288E;
	Wed,  1 Apr 2026 03:55:22 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B90D3F915;
	Wed,  1 Apr 2026 03:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775040928; bh=2UQIkCCHHnYMJL08xGfBrcE6awkfKjIUqvN58fjiAvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TRSFkRwVSzNZv1EfCfPXSKYVmxX06QSVIiXB2oC0ctF9sgb4BPVkTz4/bL14wnBvP
	 tl/+mjzRctRS3PPkAAMR8vWfJH17iSvGYZ9S6iCow39/5NMpdbDUSVX7JsWwj0Vlqi
	 NDVqY+hrLmqDreFqsDGT4UNSUnA0+gRm1bAfF/Nk=
Date: Wed, 1 Apr 2026 11:55:20 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, oleg@redhat.com,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, arnd@arndb.de,
	shuah@kernel.org, kevin.brodsky@arm.com, yeoreum.yun@arm.com,
	anshuman.khandual@arm.com, thuth@redhat.com, ryan.roberts@arm.com,
	mark.rutland@arm.com, song@kernel.org, ziyao@disroot.org,
	linusw@kernel.org, schuster.simon@siemens-energy.com,
	jremus@linux.ibm.com, akpm@linux-foundation.org,
	mathieu.desnoyers@efficios.com, kmal@cock.li, dvyukov@google.com,
	reddybalavignesh9979@gmail.com, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v14 3/4] arm64: Use generic TIF bits for common thread
 flags
Message-ID: <acz5mOrm6_E1UBwV@arm.com>
References: <20260320104222.1381274-1-ruanjinjie@huawei.com>
 <20260320104222.1381274-4-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320104222.1381274-4-ruanjinjie@huawei.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,xen0n.name,linux.ibm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,arm.com,disroot.org,siemens-energy.com,linux-foundation.org,efficios.com,cock.li,google.com,gmail.com,lists.infradead.org,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-18394-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	RCPT_COUNT_TWELVE(0.00)[40];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,linux-s390@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email,arm.com:dkim,arm.com:email,arm.com:mid]
X-Rspamd-Queue-Id: B5715378F55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 06:42:21PM +0800, Jinjie Ruan wrote:
> Use the generic TIF bits defined in <asm-generic/thread_info_tif.h> for
> standard thread flags (TIF_SIGPENDING, TIF_NEED_RESCHED, TIF_NOTIFY_RESUME,
> TIF_RESTORE_SIGMASK, TIF_SINGLESTEP, etc.) instead of defining
> them locally.
> 
> Arm64-specific bits (TIF_FOREIGN_FPSTATE, TIF_MTE_ASYNC_FAULT, TIF_SVE,
> TIF_SSBD, etc.) are renumbered to start at bit 16 to avoid conflicts.
> 
> This enables RSEQ optimizations which require CONFIG_HAVE_GENERIC_TIF_BITS
> combined with the generic entry infrastructure (already used by arm64).
> 
> By the way, remove TIF_FREEZE because this flag became unused since
> commit d88e4cb67197 ("freezer: remove now unused TIF_FREEZE").
> 
> Cc: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Given that it's touching multiple trees, I guess it's a series for
Andrew?

-- 
Catalin

