Return-Path: <linux-s390+bounces-19387-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O0NIS1g+2kuaQMAu9opvQ
	(envelope-from <linux-s390+bounces-19387-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 06 May 2026 17:37:17 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CAC4DD5F7
	for <lists+linux-s390@lfdr.de>; Wed, 06 May 2026 17:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69DB530056FD
	for <lists+linux-s390@lfdr.de>; Wed,  6 May 2026 15:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571B7480326;
	Wed,  6 May 2026 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bMdi+zP3"
X-Original-To: linux-s390@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13AE3FCB06;
	Wed,  6 May 2026 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081829; cv=none; b=hqixUcWy+vqOBAur00/mVpYwL4Fq8pyWjvoDskcWlibrB1USa70Sj8w/nDwuVamihlF4m/2SimRzhwzG+cJ3Tou+Cntvk6IXuKAVV4M6i5xF3SEKx7mGbf8w4QNEL8prJY1ZE9VG0YHiTuaTApFuCStvbx/s+KrSi3QoF8M90Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081829; c=relaxed/simple;
	bh=5jyzOt/YE4MAJ87a+6OW9BOIOtlHnKUUXQbFsJ69GA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5wf4G3j7tr8PLIuJyxQqrFEBjG6I7aNX4GRjmG80EDhV1wkW2kfg6CESZJKDrCiWfNdeSIW/bkWClV7u+5rB2E4UNq854p78LfNqUHdWaP1MN9+r85/lmA9yV1WMdenFxWQwvgGycBdhR84I2IFGwRjmzZ7IloTFsMcS9AmWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bMdi+zP3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67E5B1682;
	Wed,  6 May 2026 08:37:01 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 923CB3F7B4;
	Wed,  6 May 2026 08:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778081826; bh=5jyzOt/YE4MAJ87a+6OW9BOIOtlHnKUUXQbFsJ69GA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMdi+zP3Eg/uLU1d3mO63YYr4BA3ZO4t1algcuI4CFGs8XeA9T34+qb0rdR39jzeg
	 j06elKg2k5eNJF+ZUZm4HfbXrZgBVCdvHX1pcaN+Q7kkJVmt6743pZjHTA/47tQcPO
	 EhPeVMH+7RxtBnh++b/ct/abuXYH8cT/M2HIAXHg=
Date: Wed, 6 May 2026 16:37:01 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v4 3/8] arm64/runtime-const: Introduce
 runtime_const_mask_32()
Message-ID: <aftgHVEW3dsnblfc@arm.com>
References: <20260430094730.31624-1-kprateek.nayak@amd.com>
 <20260430094730.31624-4-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430094730.31624-4-kprateek.nayak@amd.com>
X-Rspamd-Queue-Id: 17CAC4DD5F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[arm.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19387-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:dkim,arm.com:mid,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 09:47:25AM +0000, K Prateek Nayak wrote:
> Futex hash computation requires a mask operation with read-only after
> init data that will be converted to a runtime constant in the subsequent
> commit.
> 
> Introduce runtime_const_mask_32 to further optimize the mask operation
> in the futex hash computation hot path. GCC generates a:
> 
>   movz  w1, #lo16, lsl #0     // w1 = bits [15:0]
>   movk  w1, #hi16, lsl #16    // w1 = full 32-bit value
>   and   w0, w0, w1	      // w0 = w0 & w1
> 
> pattern to tackle arbitrary 32-bit masks and the same was also suggested
> by Claude which is implemented here. The final (__ret & mask) operation
> is intentiaonally placed outside of asm block to allow compilers to
> further optimize it if possible.
> 
> __runtime_fixup_ptr() already patches a "movz, + movk lsl #16" sequence
> which has been reused to patch the same sequence for
> __runtime_fixup_mask().
> 
> Assisted-by: Claude:claude-sonnet-4-5
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

