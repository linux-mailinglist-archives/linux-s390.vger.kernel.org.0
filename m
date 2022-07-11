Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FF8566FC6
	for <lists+linux-s390@lfdr.de>; Tue,  5 Jul 2022 15:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiGENtD (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 5 Jul 2022 09:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiGENso (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Jul 2022 09:48:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16819B7EA;
        Tue,  5 Jul 2022 06:18:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A497A6145D;
        Tue,  5 Jul 2022 13:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F11C341C7;
        Tue,  5 Jul 2022 13:18:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kgxKm9Nm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657027132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h5ZwfNoo2bBgT0Q5jqJb92yKX6QoDN6Ha6ulX4NH6Lo=;
        b=kgxKm9Nml4O6Ii51m3Dos8EINLAKN7RytStmTw+nTl4uxq5STstFziZltUqJRuaMlEey9W
        JF8JGq8d7iMBCHeapXjPqaBfKaIq5Al8yjx1WvF4K/VHC0Qn2qmvZuUWEgvsN5i/9iAq/T
        86aAHQMEIsXJZlaYOfmJQE/y9SW5qC8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4a274931 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 5 Jul 2022 13:18:52 +0000 (UTC)
Date:   Tue, 5 Jul 2022 15:18:48 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Holger Dengler <dengler@linux.ibm.com>
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v1 1/1] s390/arch_random: Buffer true random data
Message-ID: <YsQ6OOrOWPhdynoM@zx2c4.com>
References: <20220705112712.4433-1-dengler@linux.ibm.com>
 <20220705112712.4433-2-dengler@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220705112712.4433-2-dengler@linux.ibm.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Holger,

On Tue, Jul 05, 2022 at 01:27:12PM +0200, Holger Dengler wrote:
> The trng instruction is very expensive and has a constant runtime for
> getting 0 to 32 bytes of (conditioned) true random data. Calling trng for
> in arch_get_random_seed_long() for each 8 bytes is too time-consuming,
> especially if it is called in interrupt context.
> 
> This implementation buffers the trng data and deliver parts of it to the

This patch seems to be repeating the same mistake I just cleaned up.
Specifically, an advantage of a CPU RNG is that it can always provide
*fresh* entropy, so that if, say, the system state is dumped, the CPU
will continue to provide fresh new uncompromised values. When you buffer
those values, they cease to be fresh.

But more realistically, have you benchmarked this and seen that it's
actually required? These functions are called once at boot, and then
when the RNG is reseeded, which happens around once a minute. That's
pretty darn rare. When you consider all the cycles that are completed
over the course of a minute, whatever the cost of the TRNG is seems
pretty negligible.

So anyway, maybe it'd be best to look at the "big picture" problem you
want to solve, rather than what looks to me like an attempt to solve a
problem that doesn't exist. Or maybe it does? If so, I'd be interested
to know when and how and where and such.

Jason
