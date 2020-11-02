Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E537D2A34A3
	for <lists+linux-s390@lfdr.de>; Mon,  2 Nov 2020 20:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgKBTup (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 2 Nov 2020 14:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgKBTuK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Nov 2020 14:50:10 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0AFC061A04
        for <linux-s390@vger.kernel.org>; Mon,  2 Nov 2020 11:50:10 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id r186so11717596pgr.0
        for <linux-s390@vger.kernel.org>; Mon, 02 Nov 2020 11:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k4LTKkpRl0FzdtxEEsZ6XXMq2NyJ1sWqeT5BlT+fbPU=;
        b=cGuqCduPzEgd/U4CfrmT9i2W6DEOg2+5twTXOeUrVL4q+7FAzIo7NMOf2Xf5RRtLPK
         ZYXJZXDQQOqS7iPFunDyxoVOU5vQvT0C0bqujtwFlPU58AYjsBF2PuzOczAWy+//0Ygb
         IMQbxVzkpbvteFRsPtfoI3jbp3YyG5olfxXU39bVkvL9COWFoJPydLezTsDyViuNRiml
         jmsUlFq/4hrKYkc/+X6cfOsTnvkwD/8092y3EJck1nVMJy3TW9PhMjIuS2hIpbdukJhd
         2cbJSqLZn17elN/KlXCAbIxKxtiAC7eQ4y3HbS6V8o0EQLN1JhIbxoInRTrPiCjjj+uU
         KVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k4LTKkpRl0FzdtxEEsZ6XXMq2NyJ1sWqeT5BlT+fbPU=;
        b=WvcwwqHcBTDeLdchwj8bmg4WmbM6bWgjSobNqIYMpEzkecIGz0aQgQphBOdf0VTpRi
         NMjkNvOZvQqQgburRbzgS3AWHVDsjuSRyF2L3IbxZ1sP+wk/fF3cyt5SwWFkJvjNudrJ
         LzS4QfrVPEAtsM9+UHHydfN8ps+aKg/tZYyiXJuLF1wEAM9JSPN0oz2CcOeP/5jF+uRI
         ph6VVG/KQ1V0xGIPy+HtBnhlM6kgPOJpWWPan9MPuytUlWCIEJt4b9a8wCIz6df5IkEt
         Hem7vGYd0RG1VfL93FAJnj2c94LOQR5gfGBLmXlX2rWEkkZaJlRZnv/Ge7sHUET8xwab
         KHEw==
X-Gm-Message-State: AOAM5311Ly+dpSZnV6wWFpCVBARKC67AA7R0PPZth0LhmM74RMypebYC
        1kg/uV1OVjUsX3mwakrnwF4aSQ==
X-Google-Smtp-Source: ABdhPJzFIIBM3l0G072FO0GIJKQVEMcIN1PZ2MbsRhJVPGJSVSVtZm2BtBwakRNn8fePrbXCm0Wqmw==
X-Received: by 2002:a17:90a:5211:: with SMTP id v17mr18157629pjh.200.1604346609603;
        Mon, 02 Nov 2020 11:50:09 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id fy13sm284489pjb.10.2020.11.02.11.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 11:50:08 -0800 (PST)
Subject: Re: [PATCH] s390: add support for TIF_NOTIFY_SIGNAL
To:     Qian Cai <cai@redhat.com>
Cc:     linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        oleg@redhat.com, tglx@linutronix.de,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
References: <20201101173153.GC9375 () osiris>
 <362e3645e2c0891309c07e244a147f0c32f106da.camel@redhat.com>
 <54c02fa6-8c8a-667f-af99-e83a1f150586@kernel.dk>
 <d60d24de6b7c9b948333e4e288452fe0a39d2380.camel@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b7b2fa41-fab2-7fd4-f10f-9c352bc9c692@kernel.dk>
Date:   Mon, 2 Nov 2020 12:50:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d60d24de6b7c9b948333e4e288452fe0a39d2380.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/2/20 11:58 AM, Qian Cai wrote:
> On Mon, 2020-11-02 at 10:07 -0700, Jens Axboe wrote:
>> On 11/2/20 9:59 AM, Qian Cai wrote:
>>> On Sun, 2020-11-01 at 17:31 +0000, Heiko Carstens wrote:
>>>> On Thu, Oct 29, 2020 at 10:21:11AM -0600, Jens Axboe wrote:
>>>>> Wire up TIF_NOTIFY_SIGNAL handling for s390.
>>>>>
>>>>> Cc: linux-s390@vger.kernel.org
>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> Even though I did confirm that today's linux-next contains this additional
>>> patch
>>> from Heiko below, a z10 guest is still unable to boot. Reverting the whole
>>> series (reverting only "s390: add support for TIF_NOTIFY_SIGNAL" introduced
>>> compiling errors) fixed the problem, i.e., git revert --no-edit
>>> af0dd809f3d3..7b074c15374c [1]
>>
>> That's odd, it should build fine without that patch. How did it fail for you?
> 
> In file included from ./arch/s390/include/asm/bug.h:5,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/mmdebug.h:5,
>                  from ./include/linux/percpu.h:5,
>                  from ./include/linux/context_tracking_state.h:5,
>                  from ./include/linux/hardirq.h:5,
>                  from ./include/linux/kvm_host.h:7,
>                  from arch/s390/kernel/asm-offsets.c:11:
> ./include/linux/sched/signal.h: In function ‘signal_pending’:
> ./include/linux/sched/signal.h:368:39: error: ‘TIF_NOTIFY_SIGNAL’ undeclared
> (first use in this function); did you mean ‘TIF_NOTIFY_RESUME’?
>   if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
>                                        ^~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:78:42: note: in definition of macro ‘unlikely’
>  # define unlikely(x) __builtin_expect(!!(x), 0)
>                                           ^
> ./include/linux/sched/signal.h:368:39: note: each undeclared identifier is
> reported only once for each function it appears in
>   if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
>                                        ^~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:78:42: note: in definition of macro ‘unlikely’
>  # define unlikely(x) __builtin_expect(!!(x), 0)
>                                           ^
> make[1]: *** [scripts/Makefile.build:117: arch/s390/kernel/asm-offsets.s] Error
> 1
> make: *** [Makefile:1198: prepare0] Error 2

Ah, but that's because later patches assume that TIF_NOTIFY_SIGNAL is
always there once all archs have been converted. If you just want to back
out that patch, you'll need to just revert this one:

commit 82ef6998ed9d488e56bbfbcc2ec9adf62bf78f08
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Oct 9 16:04:39 2020 -0600

    kernel: remove checking for TIF_NOTIFY_SIGNAL

as well and I suspect it should build.

-- 
Jens Axboe

