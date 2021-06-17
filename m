Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C4F3ABD3A
	for <lists+linux-s390@lfdr.de>; Thu, 17 Jun 2021 21:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhFQUBn (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 17 Jun 2021 16:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhFQUBn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 17 Jun 2021 16:01:43 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A2CC061574
        for <linux-s390@vger.kernel.org>; Thu, 17 Jun 2021 12:59:34 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id g13so353112ljj.10
        for <linux-s390@vger.kernel.org>; Thu, 17 Jun 2021 12:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zcyy0+lIJvFeXvehJWIwg9rBNfSRvCsx4qwdpO20ymM=;
        b=Sa9UsKs1TfLW+jThVPKpF4IS881XC4PkrKgWn0fM+jWpa0PS/9cBGdJkDi+DiRuLmH
         pVUOQK/vXvA5k+w+/Ao9Oa+7C+7xH/yI0dWuPULJZS0rGBtTGoLFC+3Qc8AbcyRj8zOJ
         DpxVhHJ8E45GjxJTLChERHp+n8t7rQqkJKk9h41u4z10xsTXMh4vcmbHWYlr7ER0i9Mk
         OYeBF0ZveJ+maeCroRci+5SfO9ceFC+PAdxVQH9m46kNqzWOHGkPEnGIMkvWCZAYZnZC
         Dialb0da5A2paeoKYLYuHhQChSH2Jg0aGv7sF0tMoqkt7S36wjx4/85b8vAPX1vBhh13
         qezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zcyy0+lIJvFeXvehJWIwg9rBNfSRvCsx4qwdpO20ymM=;
        b=rkCkuh3R3pGob9w2gBoYylUZbxfub0AINr1hnrn4hYnera+++EYNpdaqlTdRH3dcYp
         UrD33l3sRTRqm5VQ7WxBJQdysOhFDNPKMKkVWB87iQ4mStzeLT6p1Uk5cf6FOFjJe2d/
         pt/rGO2q0fqEQmCAlLx2GUEw1mIjLsqS0gUA/to7spgsc8ORVKcaTTmYFI0PpDrEkhvo
         ok83cZ07lUgLGozJmmf0swdKtYE8iOi4yBuuh8BkCN2JVxSrSzoxSgEqVC8EmU6JXF1F
         fDpPuXWmAYVk4jMpkZuQGEPEsUE3Q8wGw98gqRMuHSm8hsi6Wl3qEakNaW8+eLd2DyZF
         Hv9g==
X-Gm-Message-State: AOAM530QJje0uovVCHtxwUXTuOHh7gEIeOWKVTYe2XvPflBHwlPGmUo/
        m0JBnKa5wBjThJdZAu3hKnNR28bELNyfBiVchbXCqA==
X-Google-Smtp-Source: ABdhPJz0ijuZ9t/YCDHaBD0KL/8ro8OGrU2PaPRW0wxBPKgMi21Nra+hZyI13IVV6WSpYYS3U2jlpPz3NEJ7DRudOgY=
X-Received: by 2002:a05:651c:1181:: with SMTP id w1mr6271031ljo.116.1623959972826;
 Thu, 17 Jun 2021 12:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <YMtib5hKVyNknZt3@osiris> <20210617193139.856957-1-nathan@kernel.org>
In-Reply-To: <20210617193139.856957-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 17 Jun 2021 12:59:21 -0700
Message-ID: <CAKwvOdn9Z3JrVJzkZuXUY_5aBP5Ttxw6g9ALb_XM-bkY=iU8KQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/min-tool-version.sh: Raise minimum clang version
 to 13.0.0 for s390
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jun 17, 2021 at 12:32 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> clang versions prior to the current development version of 13.0.0 cannot
> compile s390 after commit 3abbdfde5a65 ("s390/bitops: use register pair
> instead of register asm") and the s390 maintainers do not intend to work
> around this in the kernel. Codify this in scripts/min-tool-version.sh
> similar to arm64 with GCC 5.1.0 so that there are no reports of broken
> builds.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> This should probably go through the s390 tree with Masahiro's ack.
>
>  scripts/min-tool-version.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index d22cf91212b0..319f92104f56 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -30,7 +30,12 @@ icc)
>         echo 16.0.3
>         ;;
>  llvm)
> -       echo 10.0.1
> +       # https://lore.kernel.org/r/YMtib5hKVyNknZt3@osiris/
> +       if [ "$SRCARCH" = s390 ]; then
> +               echo 13.0.0
> +       else
> +               echo 10.0.1
> +       fi
>         ;;
>  *)
>         echo "$1: unknown tool" >&2
>
> base-commit: 7d9c6b8147bdd76d7eb2cf6f74f84c6918ae0939
> --
> 2.32.0.93.g670b81a890
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210617193139.856957-1-nathan%40kernel.org.



-- 
Thanks,
~Nick Desaulniers
