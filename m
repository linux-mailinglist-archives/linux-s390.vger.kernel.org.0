Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231CA2B8CEE
	for <lists+linux-s390@lfdr.de>; Thu, 19 Nov 2020 09:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgKSIMv (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 19 Nov 2020 03:12:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60362 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgKSIMv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 Nov 2020 03:12:51 -0500
Date:   Thu, 19 Nov 2020 09:12:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605773570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BROv8K3KAJ8j8aPcvMQWQCZxfKl5DT3lsrkDC+R7veY=;
        b=24ApUwEqegWBsT7O+m3IhcxPUp8nyI4NXoofHGdaijhJGQZEzdwXlgYqTfGXg/X7VAX1Vn
        lSyPbmgG44JVk1FiIoXW9EohQwycV9lkjdO4BmoDGGHP4Z7ZVSV3DHku87EzmDVmltNGf+
        g+t0L3d8SMja6jUqmEck+M/HZLeyuoU1S3DdeQaibvMfjqb+MUvD6ekOKc6hICBMQZ3EuG
        I9w0GeE09t10h2HKVlrNISpzyDtJBYUJ6l0Eyh9Fw/U4PfKRnISnIbg2p2+i2oAQgQgP/M
        XCz4tEx9meCetx6BfGMoknc3VU/R40D6/N90qMOxArXEaurkYI/c6T7PHVbm3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605773570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BROv8K3KAJ8j8aPcvMQWQCZxfKl5DT3lsrkDC+R7veY=;
        b=yplLaba7owiOl1njIWH4FewvIFBrxogcVB5Cl2snZTapAFREzUp56kamyOM0d0XBdIXFOJ
        S4FAQwZkWhCiSJAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julian Wiedmann <jwi@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/6] s390/ctcm: Put struct th_header and th_sweep on
 stack.
Message-ID: <20201119081248.iyb2dxeazgm3fhyg@linutronix.de>
References: <20201118105317.605671-1-bigeasy@linutronix.de>
 <20201118105317.605671-2-bigeasy@linutronix.de>
 <88ac2454-32f4-f48b-f255-b23aedabc45b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88ac2454-32f4-f48b-f255-b23aedabc45b@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2020-11-19 09:45:08 [+0200], Julian Wiedmann wrote:
> On 18.11.20 12:53, Sebastian Andrzej Siewior wrote:
> > The size of struct th_header is 8 byte and the size of struct th_sweep
> > is 16 byte. The memory for is allocated, initialized, used and
> > deallocated a few lines later.
> > 
> > It is more efficient to avoid the allocation/free dance and keeping the
> > variable on stack. Especially since the compiler is smart enough to not
> > allocate the memory on stack but assign the values directly.
> > 
> > Declare struct th_sweep/th_header on stack and initialize it to zero.
> > Use the local variable instead of the pointer.
> > 
> 
> Frankly, I'd much rather see us use the pointers that are returned from
> skb_push() and skb_put(). No need for the on-stack & memcpy indirection.

You are aware that the compiler optimizes the on-stack memory away and
you get the zero-init for free due to the way the assignment is made?
There is no memcpy() in the resulting code.

Sebastian
