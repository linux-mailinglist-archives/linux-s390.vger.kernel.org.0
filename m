Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71E331565B6
	for <lists+linux-s390@lfdr.de>; Sat,  8 Feb 2020 18:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgBHRS0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 8 Feb 2020 12:18:26 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35787 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbgBHRS0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 8 Feb 2020 12:18:26 -0500
Received: by mail-pf1-f193.google.com with SMTP id y73so1446018pfg.2
        for <linux-s390@vger.kernel.org>; Sat, 08 Feb 2020 09:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=97bjEOo8NHHV0loxcFn46KhJrhrQDZe2/hrTKBrxCbU=;
        b=MJhcoM0SRrl5HRn5pz7vMoJ8DjJawM8tIysmSsxEfyKsiCIxwykEjTvF7Gs4rYGNkH
         kfapTWItfXC6yG580TiICh/O1EYeiyuhEc7YxdWmrdYRl3iBHpVExVKGBLKtFWssQdLH
         NaVjavbtX7UWI4/6UZgcALrUU9yoOHm8M2eeH7UYRz9qQ6tBNHxq710Cjh0g9PjaC3Uz
         GASQS3GzqU5vyZ7/rW1sV/x0T3RfgDMuqP65uaIy3AyOkbYXyRaOZvv1Kvpdq4y9BlzC
         ETiFi6rNabfbCgL6UhBITTePryLaPxECMVudpQmbE2QJH1d66gv3YFg6ISsOWXHtrIgX
         8jiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97bjEOo8NHHV0loxcFn46KhJrhrQDZe2/hrTKBrxCbU=;
        b=Dfk+95lpeRgQwAKPx1pXFMIqwPj4SG7vEoXwuVNn2EJJEyneTYMLOfTU6RP9JB01xa
         oY8V9hM/7nX5gcqGRNb+Ip7Knz1c/snqkVLl/lTrbcXPB0KKUBT1hR8FlZqaoM9yBSNa
         t1lX37F0JDBCOeEVVTT3jHDqGevU9TIhVoOIMr7gvBi+lVCzbgPyDgOWCiNr3WELlJh+
         zyF5gE2OPBiw4JU10RGeBidYAFBEG9jAIfMry3wEGC+f2CFfm31qWPn7U20wO3nq17FT
         IQw6J6CryICPMcMJS9aTw8tFpb7ItAIFFbcReGmxlmMeDSjjDLPAEdHC3L4/2dkaX+Kz
         VCxQ==
X-Gm-Message-State: APjAAAX4z66tzt1eZrRaEFI+CEEorymwz4fpdc/PREI4Rhz58evVBzVL
        PCxwq3/U+ptG5CEEvIB+jlsGlQITy8fx1Hh52FqQbA==
X-Google-Smtp-Source: APXvYqyiiruyeS6UNw0CyjbnMuWpEXID4hIpT9+muDpBN3d9UdLGV1o2mBBbLXAzQOOMZJnZXDUQHFYAj2ewcJqRJ/Q=
X-Received: by 2002:a63:d249:: with SMTP id t9mr5721230pgi.263.1581182305426;
 Sat, 08 Feb 2020 09:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20200208140858.47970-1-natechancellor@gmail.com>
In-Reply-To: <20200208140858.47970-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Sat, 8 Feb 2020 17:18:13 +0000
Message-ID: <CAKwvOdkLy9iKyJUqjgX8K8F98xS6Bz-O8OT_jdxZCzpSrfni8A@mail.gmail.com>
Subject: Re: [PATCH] s390/time: Fix clk type in get_tod_clock
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, Feb 8, 2020 at 3:10 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> In file included from ../arch/s390/boot/startup.c:3:
> In file included from ../include/linux/elf.h:5:
> In file included from ../arch/s390/include/asm/elf.h:132:
> In file included from ../include/linux/compat.h:10:
> In file included from ../include/linux/time.h:74:
> In file included from ../include/linux/time32.h:13:
> In file included from ../include/linux/timex.h:65:
> ../arch/s390/include/asm/timex.h:160:20: warning: passing 'unsigned char
> [16]' to parameter of type 'char *' converts between pointers to integer
> types with different sign [-Wpointer-sign]
>         get_tod_clock_ext(clk);
>                           ^~~
> ../arch/s390/include/asm/timex.h:149:44: note: passing argument to
> parameter 'clk' here
> static inline void get_tod_clock_ext(char *clk)
>                                            ^
>
> Change clk's type to just be char so that it matches what happens in
> get_tod_clock_ext.
>
> Fixes: 57b28f66316d ("[S390] s390_hypfs: Add new attributes")
> Link: https://github.com/ClangBuiltLinux/linux/issues/861
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

First time I've seen a `typedef` in a function. I wonder if that makes
its definition have function scope? (re: get_tod_clock_ext())

> ---
>
> Alternatively, changing the clk type in get_tod_clock_ext to unsigned
> which is what it was in the early 2000s.

Yeah, it doesn't really matter for this case, it looks like. Either way,

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>  arch/s390/include/asm/timex.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
> index 670f14a228e5..6bf3a45ccfec 100644
> --- a/arch/s390/include/asm/timex.h
> +++ b/arch/s390/include/asm/timex.h
> @@ -155,7 +155,7 @@ static inline void get_tod_clock_ext(char *clk)
>
>  static inline unsigned long long get_tod_clock(void)
>  {
> -       unsigned char clk[STORE_CLOCK_EXT_SIZE];
> +       char clk[STORE_CLOCK_EXT_SIZE];
>
>         get_tod_clock_ext(clk);
>         return *((unsigned long long *)&clk[1]);
> --
> 2.25.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200208140858.47970-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
