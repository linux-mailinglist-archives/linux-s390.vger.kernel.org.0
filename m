Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A191EC336
	for <lists+linux-s390@lfdr.de>; Tue,  2 Jun 2020 21:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgFBTwt (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 2 Jun 2020 15:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgFBTwk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Jun 2020 15:52:40 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA712C08C5C2
        for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2020 12:52:39 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 185so5672994pgb.10
        for <linux-s390@vger.kernel.org>; Tue, 02 Jun 2020 12:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jBlQ0H5npGZVX47FUALQU/dmYxL2gnelxfg7MyVgbp0=;
        b=cXB+4FqNR7A1+uDCNrWesXMiMm7U/wLiP8fD+W0cE1gzqO2K8wf1c21vHDI37WBEFD
         9QnRF0kehrlIrI4U5xggqGOcyDyyRFq52mX3/BZ6GEbc6RWuraI8bw8RmIasX7ASzrZD
         UkWZIIoMb/sYmEfPDYKHrqLXoXLaFuawhh57qCuX/QfXyCVfUGTfD5cbpnH188RnBSw5
         z+8NzdfxXFDbnqNzil6f1tVct+EwLHuEpN1HGG+ct9ECKFR4gtfKFT2vzyFj7ihbOSaf
         8C5RQ+5WMawNzeL5+Q0UOrDdCTXXgugtJNndzY/Digyp6kFV5SCf/bycj0bm7qKk/JdL
         0Flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBlQ0H5npGZVX47FUALQU/dmYxL2gnelxfg7MyVgbp0=;
        b=l9B1KhIan4jcraccpsxyLlihE+QO9kHJ31N29yv62Wmo7/nPGoNk/eShThXQWpUQ9Y
         KKaIdgJLhwpqM5qUm5dpw0+6Q1I+wq0rVJfOCQ6pcrIR/lw31Gyc8kiKc7VJegk/Or6q
         yVTGLXN5jNT3NipdvQKCkUSeFryID52u+tzMwRSEyLuVE9UgAsJpRocIr7D2Z39BUGXh
         voEfoOt9mRpKU00zqcAysoj74VLecGb9JBk1vd7ijG440lHzbelftM9GqiEsYkUAWkny
         UffFIjV5I/AuJ5AUyGHXgGm2/HSbbUGGRxYStIVYrJkueRcD34jwnoPTK536s8P1oOc2
         5Xag==
X-Gm-Message-State: AOAM5334ncfrQaKN7kymaizGnXBxgMTcT4aUFmE/5YG/eV2ZAQHCnpVr
        iwXP4YC5QaOnKO0Rq05ciMhbPlvtgNOVbMbYJI1kjZHw
X-Google-Smtp-Source: ABdhPJwCuiEf76Zc629eMOZpmu8/WaCfFuZD4eftG+RCE1u8qTjG8vY+SrXS/9ahOtF+G23ZHcYgVcLUMB2hz29+5jI=
X-Received: by 2002:a17:90b:4c47:: with SMTP id np7mr893785pjb.101.1591127558983;
 Tue, 02 Jun 2020 12:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmCrM0eUZHR12OBgyRhNPFDzZKjrpZ0DW8Cg=wqTfzDFw@mail.gmail.com>
 <20200602192523.32758-1-natechancellor@gmail.com>
In-Reply-To: <20200602192523.32758-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Jun 2020 12:52:26 -0700
Message-ID: <CAKwvOdnH8rxT7y1U0d=pyD19K38KwarrwA2s+Ji7ctgg+ks_kg@mail.gmail.com>
Subject: Re: [PATCH v2] s390: vdso: Use $(LD) instead of $(CC) to link vDSO
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

On Tue, Jun 2, 2020 at 12:25 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Currently, the VDSO is being linked through $(CC). This does not match
> how the rest of the kernel links objects, which is through the $(LD)
> variable.
>
> When clang is built in a default configuration, it first attempts to use
> the target triple's default linker, which is just ld. However, the user
> can override this through the CLANG_DEFAULT_LINKER cmake define so that
> clang uses another linker by default, such as LLVM's own linker, ld.lld.
> This can be useful to get more optimized links across various different
> projects.
>
> However, this is problematic for the s390 vDSO because ld.lld does not
> have any s390 emulatiom support:
>
> https://github.com/llvm/llvm-project/blob/llvmorg-10.0.1-rc1/lld/ELF/Driver.cpp#L132-L150
>
> Thus, if a user is using a toolchain with ld.lld as the default, they
> will see an error, even if they have specified ld.bfd through the LD
> make variable:
>
> $ make -j"$(nproc)" -s ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- LLVM=1 \
>                        LD=s390x-linux-gnu-ld \
>                        defconfig arch/s390/kernel/vdso64/
> ld.lld: error: unknown emulation: elf64_s390
> clang-11: error: linker command failed with exit code 1 (use -v to see invocation)
>
> Normally, '-fuse-ld=bfd' could be used to get around this; however, this
> can be fragile, depending on paths and variable naming. The cleaner
> solution for the kernel is to take advantage of the fact that $(LD) can
> be invoked directly, which bypasses the heuristics of $(CC) and respects
> the user's choice. Similar changes have been done for ARM, ARM64, and
> MIPS.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1041
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks, with this, I'm more confident that the linker flags don't change.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> v1 -> v2:
>
> * Add -fPIC per GCC's documentation, as pointed out by Nick.
>
>  arch/s390/kernel/vdso64/Makefile | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
> index bec19e7e6e1c..67c14732c304 100644
> --- a/arch/s390/kernel/vdso64/Makefile
> +++ b/arch/s390/kernel/vdso64/Makefile
> @@ -18,8 +18,8 @@ KBUILD_AFLAGS_64 += -m64 -s
>
>  KBUILD_CFLAGS_64 := $(filter-out -m64,$(KBUILD_CFLAGS))
>  KBUILD_CFLAGS_64 += -m64 -fPIC -shared -fno-common -fno-builtin
> -KBUILD_CFLAGS_64 += -nostdlib -Wl,-soname=linux-vdso64.so.1 \
> -                   -Wl,--hash-style=both
> +ldflags-y := -fPIC -shared -nostdlib -soname=linux-vdso64.so.1 \
> +            --hash-style=both -T
>
>  $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_64)
>  $(targets:%=$(obj)/%.dbg): KBUILD_AFLAGS = $(KBUILD_AFLAGS_64)
> @@ -37,8 +37,8 @@ KASAN_SANITIZE := n
>  $(obj)/vdso64_wrapper.o : $(obj)/vdso64.so
>
>  # link rule for the .so file, .lds has to be first
> -$(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64) FORCE
> -       $(call if_changed,vdso64ld)
> +$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) FORCE
> +       $(call if_changed,ld)
>
>  # strip rule for the .so file
>  $(obj)/%.so: OBJCOPYFLAGS := -S
> @@ -50,8 +50,6 @@ $(obj-vdso64): %.o: %.S FORCE
>         $(call if_changed_dep,vdso64as)
>
>  # actual build commands
> -quiet_cmd_vdso64ld = VDSO64L $@
> -      cmd_vdso64ld = $(CC) $(c_flags) -Wl,-T $(filter %.lds %.o,$^) -o $@
>  quiet_cmd_vdso64as = VDSO64A $@
>        cmd_vdso64as = $(CC) $(a_flags) -c -o $@ $<
>
>
> base-commit: e1750a3d9abbea2ece29cac8dc5a6f5bc19c1492
> --
> 2.27.0.rc2
>


-- 
Thanks,
~Nick Desaulniers
