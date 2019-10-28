Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 268EEE7585
	for <lists+linux-s390@lfdr.de>; Mon, 28 Oct 2019 16:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfJ1PwW (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 28 Oct 2019 11:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfJ1PwW (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 28 Oct 2019 11:52:22 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C7F920717;
        Mon, 28 Oct 2019 15:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572277941;
        bh=97yS8z5FVacniDasr5jHJ8UvydVF8s/Uj+ONoCj6FNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F5Heiqz7ChY3bRNtswHWSHyBW/ykGPEnDOiqXtLEHOft9Ggz/nnpIOK19X7E4ZbDd
         TkCk4dWyYXBFMFJ5M/vMfx1Ba5pAW4LSQ2R0HO5G59OnKluKoI0cDnbHp3EvGYyctc
         T4ygQUoDqNR7S04Bvq56Os6i5QD1BxSdS/efevGc=
Date:   Mon, 28 Oct 2019 15:52:16 +0000
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/2] locking/Kconfig: Add INLINE_SPINLOCKS &
 INLINE_RWLOCKS
Message-ID: <20191028155215.GE5576@willie-the-truck>
References: <20191016172028.16802-1-longman@redhat.com>
 <20191016172028.16802-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016172028.16802-2-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

[I thought I replied to this already but I can't find any evidence of that.
 Apologies if you receive this twice!]

On Wed, Oct 16, 2019 at 01:20:27PM -0400, Waiman Long wrote:
> Both the arm64 and s390 architectures decide to inline all the spinlock
> and rwlock functions except the read_trylock() and write_trylock()
> functions for arm64. As other architectures are contemplating about
> inlining those locking functions as well, it makes sense to make it
> easier and less error-prone to do this.
> 
> Two new Kconfig options INLINE_SPINLOCKS and INLINE_RWLOCKS and their
> ARCH_* counterparts are now added to streamline this process. The s390
> and arm64's Kconfig files are modified to use the new Kconfig options.
> 
> There is no functional change for s390. For arm64, both read_trylock()
> and write_trylock() are now inlined as well.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/arm64/Kconfig   | 28 ++-------------------------
>  arch/s390/Kconfig    | 30 ++---------------------------
>  kernel/Kconfig.locks | 45 +++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 48 insertions(+), 55 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 950a56b71ff0..e440d85dd8f1 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -35,32 +35,8 @@ config ARM64
>  	select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
> -	select ARCH_INLINE_READ_LOCK if !PREEMPT
> -	select ARCH_INLINE_READ_LOCK_BH if !PREEMPT
> -	select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPT
> -	select ARCH_INLINE_READ_LOCK_IRQSAVE if !PREEMPT
> -	select ARCH_INLINE_READ_UNLOCK if !PREEMPT
> -	select ARCH_INLINE_READ_UNLOCK_BH if !PREEMPT
> -	select ARCH_INLINE_READ_UNLOCK_IRQ if !PREEMPT
> -	select ARCH_INLINE_READ_UNLOCK_IRQRESTORE if !PREEMPT
> -	select ARCH_INLINE_WRITE_LOCK if !PREEMPT
> -	select ARCH_INLINE_WRITE_LOCK_BH if !PREEMPT
> -	select ARCH_INLINE_WRITE_LOCK_IRQ if !PREEMPT
> -	select ARCH_INLINE_WRITE_LOCK_IRQSAVE if !PREEMPT
> -	select ARCH_INLINE_WRITE_UNLOCK if !PREEMPT
> -	select ARCH_INLINE_WRITE_UNLOCK_BH if !PREEMPT
> -	select ARCH_INLINE_WRITE_UNLOCK_IRQ if !PREEMPT
> -	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE if !PREEMPT
> -	select ARCH_INLINE_SPIN_TRYLOCK if !PREEMPT
> -	select ARCH_INLINE_SPIN_TRYLOCK_BH if !PREEMPT
> -	select ARCH_INLINE_SPIN_LOCK if !PREEMPT
> -	select ARCH_INLINE_SPIN_LOCK_BH if !PREEMPT
> -	select ARCH_INLINE_SPIN_LOCK_IRQ if !PREEMPT
> -	select ARCH_INLINE_SPIN_LOCK_IRQSAVE if !PREEMPT
> -	select ARCH_INLINE_SPIN_UNLOCK if !PREEMPT
> -	select ARCH_INLINE_SPIN_UNLOCK_BH if !PREEMPT
> -	select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPT
> -	select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPT
> +	select ARCH_INLINE_RWLOCKS if !PREEMPT

This is a change in behaviour, since you're now selecting both
ARCH_INLINE_READ_TRYLOCK and ARCH_INLINE_WRITE_TRYLOCK for arm64.

However, I /think/ that's probably just because I missed that when
enabling the others, so cautiously:

Acked-by: Will Deacon <will@kernel.org> # arm64

Will
