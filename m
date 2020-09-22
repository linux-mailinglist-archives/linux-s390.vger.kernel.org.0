Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC1A273CD6
	for <lists+linux-s390@lfdr.de>; Tue, 22 Sep 2020 09:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgIVH7r (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 22 Sep 2020 03:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgIVH7q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 22 Sep 2020 03:59:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF68FC061755;
        Tue, 22 Sep 2020 00:59:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x23so2305745wmi.3;
        Tue, 22 Sep 2020 00:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yYZwD/JN41HSW2o2yBV5D0g97V44Y0rKO2sNnKdHUhE=;
        b=qRykHTLdSJFSoQXfXO+yN4UNYJ/YVaOYc+nZp15yapRq/lAEKnzGieCh7z7YLtEsjm
         l4HGRLWaSiCRKVXFiNVspJUY+JF5cbnmHTi3J8LBBnkc+fygy30wbUThbk7uN7G0MIbh
         qCcmvDEycOYu5YiF9BMGHOXHpg5W6KtQfOxK6n37oPDSaJp9c5xVqilKUaO6HHuSutu+
         Ov2YGd9bB9gGENnWxuPis5FvBUKubP3qwHaZu/9wEgNAKBIDYsWrvMbNXR4MG09Af+m8
         wpIhb7tQvP9t7UOL3zfTROmtF4/bBDMBs3zrFg2ZNfCRwVJSOn1o18raTqrzVWYD+TIO
         V0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yYZwD/JN41HSW2o2yBV5D0g97V44Y0rKO2sNnKdHUhE=;
        b=ZuOY2vznYHP5PEFIKplhJ9NE+imKtQFo/HvuzNi7qNJl7IE1zCiEo3PBl2rsjWrAhl
         SwTaUdgtTz0dJ88iCbjf/uvVMs53WdN1MnTu51L7sfPjwgrzLjrETH0IgS5U8Ob6xm7J
         aF2QGBtm23k0N37htSUuZ5xOAou684c4rsBVzLqXN6JKYkldhrHmfheXv4qLaZBn1qAs
         LYdHUwcsFRXRKhtFh5oOX0Kkcc70yf2Hev5FP9BazkCb8D91bHe5i+rqu7EF/2UQgAtL
         p9/yidf9qbHSZ73X9XyuLiZN3fG4J44vbn7fkUEdQhxUQhJP1Qvje+0r5XbtjcLTxK+9
         t6Nw==
X-Gm-Message-State: AOAM533+KzF64K7FFf4zSZFUm54U8V3P7LQdnh1qkbBDAzf0bJF1G5GQ
        U2wEK3DzGpUEgvVrVEGcqPtEs38224hYwQ==
X-Google-Smtp-Source: ABdhPJyp+yvFLYLY/48JTev8mJO6XccKtCAi407VdoITx4a2DkqQ4UW1R3oWhs41QqIHG8+BiQ07BQ==
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr3114615wms.36.1600761583858;
        Tue, 22 Sep 2020 00:59:43 -0700 (PDT)
Received: from [192.168.43.240] ([5.100.192.97])
        by smtp.gmail.com with ESMTPSA id 91sm27110787wrq.9.2020.09.22.00.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 00:59:43 -0700 (PDT)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Howells <dhowells@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>, io-uring@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Network Development <netdev@vger.kernel.org>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>
References: <CAK8P3a2Mi+1yttyGk4k7HxRVrMtmFqJewouVhynqUL0PJycmog@mail.gmail.com>
 <D0791499-1190-4C3F-A984-0A313ECA81C7@amacapital.net>
 <563138b5-7073-74bc-f0c5-b2bad6277e87@gmail.com>
 <486c92d0-0f2e-bd61-1ab8-302524af5e08@gmail.com>
 <CALCETrW3rwGsgfLNnu_0JAcL5jvrPVTLTWM3JpbB5P9Hye6Fdw@mail.gmail.com>
 <d5c6736a-2cb4-4e22-78da-a667bda5c05a@gmail.com>
 <CALCETrUEC81va8-fuUXG1uA5rbKxnKDYsDOXC70_HtKD4LAeAg@mail.gmail.com>
 <e0a1b4d1-ff47-18d1-d535-c62812cb3105@gmail.com>
 <CAK8P3a2-6JNS38EbZcLrk=cTT526oP=Rf0aoqWNSJ-k4XTYehQ@mail.gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Message-ID: <f25b4708-eba6-78d6-03f9-5bfb04e07627@gmail.com>
Date:   Tue, 22 Sep 2020 10:57:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2-6JNS38EbZcLrk=cTT526oP=Rf0aoqWNSJ-k4XTYehQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 22/09/2020 10:23, Arnd Bergmann wrote:
> On Tue, Sep 22, 2020 at 8:32 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>> On 22/09/2020 03:58, Andy Lutomirski wrote:
>>> On Mon, Sep 21, 2020 at 5:24 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>> I may be looking at a different kernel than you, but aren't you
>>> preventing creating an io_uring regardless of whether SQPOLL is
>>> requested?
>>
>> I diffed a not-saved file on a sleepy head, thanks for noticing.
>> As you said, there should be an SQPOLL check.
>>
>> ...
>> if (ctx->compat && (p->flags & IORING_SETUP_SQPOLL))
>>         goto err;
> 
> Wouldn't that mean that now 32-bit containers behave differently
> between compat and native execution?
> 
> I think if you want to prevent 32-bit applications from using SQPOLL,
> it needs to be done the same way on both to be consistent:

The intention was to disable only compat not native 32-bit.

> 
>    if ((!IS_ENABLED(CONFIG_64BIT) || ctx->compat) &&
>         (p->flags & IORING_SETUP_SQPOLL))
>             goto err;
> 
> I don't really see how taking away SQPOLL from 32-bit tasks is
> any better than just preventing access to the known-broken files
> as Al suggested, or adding the hack to make it work as in
> Christoph's original patch.

That's why I'm hoping that Christoph's work and the discussion will
reach consensus, but the bug should be patched in the end. IMHO,
it's a good and easy enough fallback option (temporal?).

> 
> Can we expect all existing and future user space to have a sane
> fallback when IORING_SETUP_SQPOLL fails?

SQPOLL has a few differences with non-SQPOLL modes, but it's easy
to convert between them. Anyway, SQPOLL is a privileged special
case that's here for performance/latency reasons, I don't think
there will be any non-accidental users of it.
-- 
Pavel Begunkov
