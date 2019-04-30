Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93415100BC
	for <lists+linux-s390@lfdr.de>; Tue, 30 Apr 2019 22:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfD3UZV (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 30 Apr 2019 16:25:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33559 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfD3UZV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 30 Apr 2019 16:25:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id y3so6421071plp.0
        for <linux-s390@vger.kernel.org>; Tue, 30 Apr 2019 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QpOw1LWaSCoGQRUTl79/lNw4kFsB+PPCBpCh4+YZCQE=;
        b=TCRtICDPnDgpFyJwe6+2uP7WT68bwJi4k5jLcAgur8MXs/FK0NgxSz3x0P+byJtArA
         rqd6kxabOeOzYgAMGzIbY5qSNMd6cCycSCfagmGG9DOy2cVLu3UcDLfAaR6fHUAtvSni
         A+H8E0iDlF8ZR/F7bB9aSIWdBivF+v5/h1KmCKVdaEONYJOPJJEtKhOEwljnsYl4kTgx
         CFvktFT6PmkBoPzvi/1EgBN0Sy4QhDjYDO5UPe3AdviUeWJSqNgJea/P+jxOFFUPqSJC
         67RwGLTodfIjCmvNmaBRgXKsV5Y6/pfJfc8yRXPBWrtM49bdyHuGwkPHfDFvRljGPA0+
         pGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QpOw1LWaSCoGQRUTl79/lNw4kFsB+PPCBpCh4+YZCQE=;
        b=GUc6KvbE+XriyhEam2soDNFcWQvcMietMx7/Ir05eHlZW+yk4+65hXvby4L/8j4rNt
         75j/jY7jrwch2G8skbXy8UokE+jx2Qn8LFCYp5wUAKzgblb+vkudCtPt0RnxPy3TDOnj
         Vt3vq2ll1C3iLvBmDu05pF+5pIC8uJ4V8tH1GE3TRPixY1C59Tzw82uOskc928bPcziN
         YCl/43d+HAj7OGrCDLuAdOQGv2BUtoONMQAwv9n0NQYWXY6dvnYPpxjeeoWef2Ux79CP
         sCu23N41fzgsV7GjDorMGtCLYyY2vYz16HAw8teU+ul4/5a1tO/pBsTCo9DS7w2OCPBE
         JfBQ==
X-Gm-Message-State: APjAAAXlf9vwOoYn3WytLB6b0ET0IIr9lxwVTEmyfJ8R9gKr7vQxyVBQ
        9FZ1PgEVVCGwYo0gXHRPbrSYuS5ztf38dXk9AhMpDw==
X-Google-Smtp-Source: APXvYqxrdXvmMXDMe/UzHW4z1+JQoAtpcG8BLtt+dDf0JbS3wANA9BWiiZlz9SHtypl8cIPKFB0LhaPSJcMcTLwXDyw=
X-Received: by 2002:a17:902:e287:: with SMTP id cf7mr72624788plb.217.1556655920547;
 Tue, 30 Apr 2019 13:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190423210058.249510-1-ndesaulniers@google.com>
In-Reply-To: <20190423210058.249510-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 30 Apr 2019 13:25:09 -0700
Message-ID: <CAKwvOd=aR_GsJkaMTtV83UAAyqkZGuToD+3Zbq5sv=U_bogXmg@mail.gmail.com>
Subject: Re: [PATCH] s390: vdso: drop unnecessary cc-ldoption
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Apr 23, 2019 at 2:01 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Towards the goal of removing cc-ldoption, it seems that --hash-style=
> was added to binutils 2.17.50.0.2 in 2006. The minimal required version
> of binutils for the kernel according to
> Documentation/process/changes.rst is 2.20.
>
> Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
> Cc: clang-built-linux@googlegroups.com
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/s390/kernel/vdso32/Makefile | 2 +-
>  arch/s390/kernel/vdso64/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
> index e76309fbbcb3..aee9ffbccb54 100644
> --- a/arch/s390/kernel/vdso32/Makefile
> +++ b/arch/s390/kernel/vdso32/Makefile
> @@ -19,7 +19,7 @@ KBUILD_AFLAGS_31 += -m31 -s
>  KBUILD_CFLAGS_31 := $(filter-out -m64,$(KBUILD_CFLAGS))
>  KBUILD_CFLAGS_31 += -m31 -fPIC -shared -fno-common -fno-builtin
>  KBUILD_CFLAGS_31 += -nostdlib -Wl,-soname=linux-vdso32.so.1 \
> -                       $(call cc-ldoption, -Wl$(comma)--hash-style=both)
> +                   -Wl,--hash-style=both
>
>  $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_31)
>  $(targets:%=$(obj)/%.dbg): KBUILD_AFLAGS = $(KBUILD_AFLAGS_31)
> diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
> index f849ac61c5da..bec19e7e6e1c 100644
> --- a/arch/s390/kernel/vdso64/Makefile
> +++ b/arch/s390/kernel/vdso64/Makefile
> @@ -19,7 +19,7 @@ KBUILD_AFLAGS_64 += -m64 -s
>  KBUILD_CFLAGS_64 := $(filter-out -m64,$(KBUILD_CFLAGS))
>  KBUILD_CFLAGS_64 += -m64 -fPIC -shared -fno-common -fno-builtin
>  KBUILD_CFLAGS_64 += -nostdlib -Wl,-soname=linux-vdso64.so.1 \
> -                       $(call cc-ldoption, -Wl$(comma)--hash-style=both)
> +                   -Wl,--hash-style=both
>
>  $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_64)
>  $(targets:%=$(obj)/%.dbg): KBUILD_AFLAGS = $(KBUILD_AFLAGS_64)
> --
> 2.21.0.593.g511ec345e18-goog
>

bumping for review
-- 
Thanks,
~Nick Desaulniers
