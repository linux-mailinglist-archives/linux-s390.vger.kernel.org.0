Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F175B13D5B4
	for <lists+linux-s390@lfdr.de>; Thu, 16 Jan 2020 09:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbgAPIHp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 16 Jan 2020 03:07:45 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35555 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgAPIHp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Jan 2020 03:07:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id e12so18203204qto.2
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 00:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7IBdjvFRag9yZE/BKc5brHAQDARDtIXaGhkF8uJXRlQ=;
        b=qfoDxmehHt9zSJPjWabWfKApmNG47N0Q2/pjIts+XRh7UWc4ym2jspVC7dOFfypjnv
         qnIVrd6DHS4ExoKZLCfn7EiaWjc0VJ+thpAfGN13cJj50S+8ZZzG+BJuvVxj4+JMY4+Z
         R2R3sRy25/3S2Joee0sQyYVPnaXfnDYs0aGfjD1YGJjSt+TL0rdiQTLtodpF5kf/j6Pw
         othExYiiQoemDJnBkRX0X7T10o0baCnxfWlv3KwtSYdf0iHOwTBM8pggRIyGf5JBaiRK
         YBZSQa8lfcCAuhH2hwTvIHBU2LeyizZrqo97LUh1gq17vixbEJpIajFMOXrsvxxStmsS
         +BEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7IBdjvFRag9yZE/BKc5brHAQDARDtIXaGhkF8uJXRlQ=;
        b=rM7J9CHKR0QmE6QpXFgj3RPYrTm+ZAYWHJmbq2UlVd1rs6YgExqWkfX1L/VfHmdJ05
         ryrg4RUinmUGIT3Uj3OzyKycQe5a0Hg4rtq/wrG2OFfd42Mlect4PXQmrSlsKCn3BCNP
         u19t+Zruk1MiUGgF+hrxpljeLxN8EEJ9TBGdXQtuKYXuQ0g/s13UFkeAO3dZTvSJFW8l
         kt+OdzCCZxRjrwVcv++3MTaUpXvu4UypTct2ZIMiLt8Tatn305BQw0B9P9hX2yOijp0B
         xDlf4PUl6yK16iH6Lv2phkCPOyFZtUQiWfFA0cpbArqLERTf79E6TN0+M/OOLiq4rJ5T
         6S3A==
X-Gm-Message-State: APjAAAWSSgzG+vm0i8VTa+qDIPhZcxUSctGiFIC/xBj2qh/plc9tyFil
        3C4IXSHLI7wXFPkW2yEWmAUsMNUw2DnlF1ejY2RFvA==
X-Google-Smtp-Source: APXvYqzAhF+/72Zrdu85/2jD42Zoi8Td02RrL0uBou/vlg73GMNKwc0ffgSpLNGBhaZsCL3tktCpzfELeo9cOZYU61U=
X-Received: by 2002:ac8:30f7:: with SMTP id w52mr1194993qta.380.1579162063680;
 Thu, 16 Jan 2020 00:07:43 -0800 (PST)
MIME-Version: 1.0
References: <20200116062625.32692-1-dja@axtens.net> <20200116062625.32692-4-dja@axtens.net>
In-Reply-To: <20200116062625.32692-4-dja@axtens.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Jan 2020 09:07:32 +0100
Message-ID: <CACT4Y+YpOm9cDk5Hi62iAwMFgiotzWjfiK4i9-9jkha_ZNwuvw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kasan: initialise array in kasan_memcmp test
To:     Daniel Axtens <dja@axtens.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jan 16, 2020 at 7:26 AM Daniel Axtens <dja@axtens.net> wrote:
>
> memcmp may bail out before accessing all the memory if the buffers
> contain differing bytes. kasan_memcmp calls memcmp with a stack array.
> Stack variables are not necessarily initialised (in the absence of a
> compiler plugin, at least). Sometimes this causes the memcpy to bail
> early thus fail to trigger kasan.
>
> Make sure the array initialised to zero in the code.
>
> No other test is dependent on the contents of an array on the stack.
>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  lib/test_kasan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index a130d75b9385..519b0f259e97 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -619,7 +619,7 @@ static noinline void __init kasan_memcmp(void)
>  {
>         char *ptr;
>         size_t size = 24;
> -       int arr[9];
> +       int arr[9] = {};
>
>         pr_info("out-of-bounds in memcmp\n");
>         ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200116062625.32692-4-dja%40axtens.net.
