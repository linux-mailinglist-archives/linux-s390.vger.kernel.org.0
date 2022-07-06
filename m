Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A742568CA7
	for <lists+linux-s390@lfdr.de>; Wed,  6 Jul 2022 17:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiGFPZg (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 6 Jul 2022 11:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiGFPZV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Jul 2022 11:25:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849F726AE1;
        Wed,  6 Jul 2022 08:25:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CE2E61FD6;
        Wed,  6 Jul 2022 15:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E98C3411C;
        Wed,  6 Jul 2022 15:24:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MfGZXb8n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657121096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vjqdS21oaUKcKvXC0EcJ6AHi+otxfA3EET5R3nVpN+M=;
        b=MfGZXb8npvpYoU43hWe25DYKHe0PBhy4Xe+NehRnPfmEif7iB9fxcAooznnS+za/0ewMYi
        zAuB8WvEvrHWRsucspGtZ/xyQEiJKL7mObMLaa3ZFdb6jvrPRV4NLOYKbwZbbuDHhY9G4/
        PSj7+iJoPiYNS8XRwJYx0lk1+GuwlcE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 36d0362c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 6 Jul 2022 15:24:55 +0000 (UTC)
Date:   Wed, 6 Jul 2022 17:24:49 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] random: remove CONFIG_ARCH_RANDOM and "nordrand"
Message-ID: <YsWpQWXVeDFXvq0F@zx2c4.com>
References: <20220705190121.293703-1-Jason@zx2c4.com>
 <YsWiSH4BrY5oNJuM@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsWiSH4BrY5oNJuM@mit.edu>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Ted,

On Wed, Jul 06, 2022 at 10:55:04AM -0400, Theodore Ts'o wrote:
> On Tue, Jul 05, 2022 at 09:01:21PM +0200, Jason A. Donenfeld wrote:
> > Later the thinking evolved. With a properly designed RNG, using RDRAND
> > values alone won't harm anything, even if the outputs are malicious.
> 
> I personally think it's totally fine to remove nordrand.  However, the
> reason why it was there was that there were some rather extreme
> tin-foil-hatters who believed that if (the completely unavailable to
> the public for auditing) RDRAND implementation *were* malicious *and*
> the microcode had access to the register file and/or the instruction
> pipeline, then in theory, a malicious CPU could subvert how the RDRAND
> is mixed into the getrandom output to force a particular output.
> 
> Personally, I've always considered it to be insane, since a much
> easier way to compromise a CPU would be to drop a Minix system hidden
> into the CPU running a web server that had massive security bugs in it
> that were only discovered years later.  And if you don't trust the CPU
> manufacture to that extent, you should probably simply not use CPU's
> from that manufacturer.  :-)

That specific attack scenario is actually something I've fixed over the
last few months, by ensuring that all RDRAND values go through the hash
function. So even if the CPU is super malicious, it'd still need a hash
preimage, which isn't considered to be computable for blake2s.

Minix in the cpu... haha.. surely that would never happen... haha
surely...

Jason
