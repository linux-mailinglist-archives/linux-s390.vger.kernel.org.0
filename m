Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B295FB830
	for <lists+linux-s390@lfdr.de>; Tue, 11 Oct 2022 18:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJKQWM (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 11 Oct 2022 12:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJKQWL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 11 Oct 2022 12:22:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C783195E4C
        for <linux-s390@vger.kernel.org>; Tue, 11 Oct 2022 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665505328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gv22bmoTax0J0zhnmYTJUdzNvY/rZYRIc0hd8rouMg=;
        b=h5iy8YxiHkC4Kaa6hKdsVflcNHsfyFKnRCMfGVAb6j4l+J6CC+IO/MO0oYNyJuBeXQy2sL
        4uRVxYLTlT3dfO5HE9nlYFAz6+2B1j+BcEcKdmL6EogdvQvzsR6dbn1F12zBI/qvnCKJ9W
        4lRmLYgtG0lfeQg/+i46P0neW2oLejY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-bQW8jptkM028H4DG1EeYeg-1; Tue, 11 Oct 2022 12:22:07 -0400
X-MC-Unique: bQW8jptkM028H4DG1EeYeg-1
Received: by mail-ed1-f72.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so11523720eda.19
        for <linux-s390@vger.kernel.org>; Tue, 11 Oct 2022 09:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6gv22bmoTax0J0zhnmYTJUdzNvY/rZYRIc0hd8rouMg=;
        b=vFay8YZBkthMQQ/aXj/zMawIBypTnsKaOi26klW9ZIDfKKr9lW7eu1UMohFryrU/vW
         CW+/lrO13QstWxg4cxT4Q/PJa+v5PHbrGFUhzvg5Hb9M2EgGJLenXnmjmWVRmmANXzLH
         egBIrJ/2+8FXe4q9Hn2Wc2Sj+TSZZj6bMkHRpJXs98U1aHLLkU8+koV9nnOBXsaGz6Ym
         cp95+i2ysYYyL0mVw6yCrMRPLMSxG7tZapr3tgTYZGoNlwnv40H5Rc7daNrb0eM7Xydx
         sKs/0zyBKgToUk9rFuClnRUAwU37+MTbFQyfFB2/ARMC9Rvznj6KSgqylohRKqM6VpfT
         ZK5Q==
X-Gm-Message-State: ACrzQf17AM0F6EKYCE2n7UipWJ4uRpBITgauJP88dpmy6epsyTMQTEo5
        7eOdSgB98BD3zHr6L4FQB6jrlSaD7RCwUDBQ9w0RYkU2G1qEKjPFd5GeYxnswngkFe32SJ3k8lh
        QFgiNv10LSBaGfCsEBZiSbg==
X-Received: by 2002:a17:907:2712:b0:78d:a223:729b with SMTP id w18-20020a170907271200b0078da223729bmr11697139ejk.443.1665505325960;
        Tue, 11 Oct 2022 09:22:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5z3+5ecaWwqYPDE234CAcuf3hKc1qLTNOp8VUNiMDwybT1F6EbMEGGKCCgL+v4lylioGXOig==
X-Received: by 2002:a17:907:2712:b0:78d:a223:729b with SMTP id w18-20020a170907271200b0078da223729bmr11697097ejk.443.1665505325743;
        Tue, 11 Oct 2022 09:22:05 -0700 (PDT)
Received: from [192.168.0.198] (host-79-47-205-133.retail.telecomitalia.it. [79.47.205.133])
        by smtp.gmail.com with ESMTPSA id xf13-20020a17090731cd00b00730b3bdd8d7sm7273113ejb.179.2022.10.11.09.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 09:22:05 -0700 (PDT)
Message-ID: <3e680bb9-9896-3665-dd59-4f2e6f8205bb@redhat.com>
Date:   Tue, 11 Oct 2022 18:22:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC PATCH 0/5] Generic IPI sending tracepoint
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas RAILLARD <douglas.raillard@arm.com>
References: <20221007154145.1877054-1-vschneid@redhat.com>
 <Y0CFnWDpMNGajIRD@fuller.cnet> <xhsmhilkqfi7z.mognet@vschneid.remote.csb>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <xhsmhilkqfi7z.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/11/22 18:17, Valentin Schneider wrote:
> Thinking out loud, it makes way more sense to record a cpumask in the
> tracepoint, but perhaps we could have a postprocessing step to transform
> those into N events each targeting a single CPU?

My approach on the tracers/rtla is to make the simple things in kernel, and beautify
things in user-space.

You could keep the tracepoint as a mask, and then make it pretty, like cpus=3-5,8
in user-space. For example with a trace-cmd/perf loadable plugin, libtracefs helper.

For rtla I was thinking to make a new tool to parse them. and make it pretty there.

-- Daniel

