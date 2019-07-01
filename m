Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7C324241
	for <lists+linux-s390@lfdr.de>; Mon, 20 May 2019 22:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfETUxC (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 20 May 2019 16:53:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35888 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfETUxC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 May 2019 16:53:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id j187so690076wmj.1
        for <linux-s390@vger.kernel.org>; Mon, 20 May 2019 13:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jgtaH3BaB88SvVVWGIdw/jgKWg3CUtWtW+8PvA7IK1Q=;
        b=I42Mz43wtZ1nWQ3sKCUUx3kqQRt2Y/rpluQ5sNqCf53WVKOnn3Y7ddXUMvFSbJIASR
         JCb5HmK8niEMQ2s7Rsy+dfVGk9sphSLJsl1DNaLTbfTwvr+mf2X3X1jLtub4U7lVzR0Q
         0lZKwxt63wJK0O0iSXvIbfWc5CPz0pTJ8fjDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgtaH3BaB88SvVVWGIdw/jgKWg3CUtWtW+8PvA7IK1Q=;
        b=hyOyfbD+iKcJzgeGLF6LC9NQXgTwuVyuRWNka44TwgfwhF6K5raavkgn0PTWrPgWhA
         9wgh6F1F4otFrEDBPG3xd7ZIWkyb6KTIMOfoN/0T6oUscJJQrHsl28vyGgroHcrYYszv
         pTjGWq3oZkrWJAwex4AjqCJ5keIkMo2kbB/X/nNYpdMMAQ4Ou6Lx7ICXM7I1s1pXNjoo
         gPTR/rxc5ZwEDwwZ+PcBeK4VOpyvOQEYH8eh3KLS5jgLkJdFZlcCemEtQHA0KKiBpIb0
         IB74AemKA5rTn41ecL3qDv5XioXoiSU4YbnGdiZQ7lL5qeONxhDFTmssQBbgdcM24UVY
         2u+A==
X-Gm-Message-State: APjAAAW+I/+eLWfqjhvnGjLVD2vPOadY97Fw6z+01vGK1w0yEEzV0XHY
        4Xy6N7rHeMlkKeEO02bTmwIjQxYpWQgB8rAsfX5e+Q==
X-Google-Smtp-Source: APXvYqwn7d+GBWIk6fB8Qtd7qIDaU75cis6JBkvckAkTOPh7S3rk1cWh+F9D7HccbeLepmSD8dai4fjwKf+FmjSydAc=
X-Received: by 2002:a1c:c7c8:: with SMTP id x191mr674058wmf.126.1558385580358;
 Mon, 20 May 2019 13:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190517065424.24453-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190517065424.24453-1-yamada.masahiro@socionext.com>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 20 May 2019 15:52:49 -0500
Message-ID: <CAFxkdApsrU0tOmCnGDa6HRJ6R3T1gG7o-DN5pZXV0g4Oov6yrA@mail.gmail.com>
Subject: Re: [PATCH] s390: mark __cpacf_check_opcode() and cpacf_query_func()
 as __always_inline
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Laura Abbott <labbott@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, May 17, 2019 at 1:55 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Commit e60fb8bf68d4 ("s390/cpacf: mark scpacf_query() as __always_inline")
> was not enough to make sure to meet the 'i' (immediate) constraint for the
> asm operands.
>
> With CONFIG_OPTIMIZE_INLINING enabled, Laura Abbott reported error
> with gcc 9.1.1:
>
>   In file included from arch/s390/crypto/prng.c:29:
>   ./arch/s390/include/asm/cpacf.h: In function 'cpacf_query_func':
>   ./arch/s390/include/asm/cpacf.h:170:2: warning: asm operand 3 probably doesn't match constraints
>     170 |  asm volatile(
>         |  ^~~
>   ./arch/s390/include/asm/cpacf.h:170:2: error: impossible constraint in 'asm'
>
> Add more __always_inline to force inlining.
>
> Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Reported-by: Laura Abbott <labbott@redhat.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
Thanks for the fix, this does indeed fix the build issues for us.

Justin

Tested-by: Justin Forbes <jforbes@fedoraproject.org>

>  arch/s390/include/asm/cpacf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
> index f316de40e51b..19459dfb4295 100644
> --- a/arch/s390/include/asm/cpacf.h
> +++ b/arch/s390/include/asm/cpacf.h
> @@ -177,7 +177,7 @@ static inline void __cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
>                 : "cc");
>  }
>
> -static inline int __cpacf_check_opcode(unsigned int opcode)
> +static __always_inline int __cpacf_check_opcode(unsigned int opcode)
>  {
>         switch (opcode) {
>         case CPACF_KMAC:
> @@ -217,7 +217,7 @@ static inline int cpacf_test_func(cpacf_mask_t *mask, unsigned int func)
>         return (mask->bytes[func >> 3] & (0x80 >> (func & 7))) != 0;
>  }
>
> -static inline int cpacf_query_func(unsigned int opcode, unsigned int func)
> +static __always_inline int cpacf_query_func(unsigned int opcode, unsigned int func)
>  {
>         cpacf_mask_t mask;
>
> --
> 2.17.1
>
