Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5C51EC25A
	for <lists+linux-s390@lfdr.de>; Tue,  2 Jun 2020 21:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgFBTHY (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 2 Jun 2020 15:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgFBTHX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Jun 2020 15:07:23 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A454EC08C5C2
        for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2020 12:07:23 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h95so2011776pje.4
        for <linux-s390@vger.kernel.org>; Tue, 02 Jun 2020 12:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfQKuxiya5c6CS1sQLjDYz3AELCRI+zeqaXfLh33ZRc=;
        b=CwzremuRny+74HFHt1GSLN0EiKI1/8IHu1FTRSK058vGqnLpv02WElwFPZGNiH/RXb
         qymNUpUn5LLz54HAe/FQdMqV/h88kFtsQr179hRzby++0XBteKyKqyiHP8fIr+Jicwr2
         +CvId6ur3P33DVfT20jhFBxFFcn/FsX8pTuYye/f/aOrOSgmv8U/16Jr/ClC9Qk0GSjv
         zxPecXB6+/oh3OFjLwBFYVoy1JosSr+rNPMZXXgc4YkDNVG49pQdP/BPVxdIKFbnpCj8
         LI4EUpB3/nEiZRzBh0LI82mEqkPEnrVJUo4hRt/EalzAU3ugYS3v7NqomtB+P0zqXHjQ
         jkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfQKuxiya5c6CS1sQLjDYz3AELCRI+zeqaXfLh33ZRc=;
        b=DPgeRMfWRhx9cKDTHdnHjSUCTduxcrU/IUIWbtNHva2cPiB7y0bAhnBuUjrK3ufrFm
         0H6/T7dJS0BWwJUat3f4p6JX3nXos/Zz60zfwXsB5JuJAcU+bDKD7yxF9Aetp/r7XoM3
         5/LD1MrLV3YePZY8JvgYCKkBIiaJa7VIj9PQ50N0bDvmcmy0eA8A3BQZDt7WemNJzaC7
         BTQdT8bTtlnbNM7JyX+A+klzqLb8m411IysMsYFIE/4EVTjjymWC/0MdJWCc/a9EACHj
         Swen/XoiA2d/pRGLAOZWLxZzpBL+9Qr+rXyWCcbQFKh0ibsQv4DAEM0gyXwJOzSAP6MD
         JBSw==
X-Gm-Message-State: AOAM533bB3THIj1bFfTGNfV/Y7xhDnQwapQtx64x+4lvumruYiJ/C/+v
        CyFF5mzECXWElKXm6FpHNw2zVWFfMtFSwA6wLsSkOw==
X-Google-Smtp-Source: ABdhPJzErMlJcFTmHXZCn6ion2BvFh7++6vQBZ/LlRpTKGwVRGL2D0opCTZ9J9RwwBaMnwuqQQZJtSfI4P4mcXi7oBo=
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr26014006pll.223.1591124842742;
 Tue, 02 Jun 2020 12:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200528060600.2732012-1-natechancellor@gmail.com>
In-Reply-To: <20200528060600.2732012-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Jun 2020 12:07:11 -0700
Message-ID: <CAKwvOdmCrM0eUZHR12OBgyRhNPFDzZKjrpZ0DW8Cg=wqTfzDFw@mail.gmail.com>
Subject: Re: [PATCH] s390: vdso: Use $(LD) instead of $(CC) to link vDSO
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, May 27, 2020 at 11:06 PM Nathan Chancellor
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
> ---
>  arch/s390/kernel/vdso64/Makefile | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
> index bec19e7e6e1c..b8db1ffbc2b9 100644
> --- a/arch/s390/kernel/vdso64/Makefile
> +++ b/arch/s390/kernel/vdso64/Makefile
> @@ -18,8 +18,8 @@ KBUILD_AFLAGS_64 += -m64 -s
>
>  KBUILD_CFLAGS_64 := $(filter-out -m64,$(KBUILD_CFLAGS))
>  KBUILD_CFLAGS_64 += -m64 -fPIC -shared -fno-common -fno-builtin
> -KBUILD_CFLAGS_64 += -nostdlib -Wl,-soname=linux-vdso64.so.1 \
> -                   -Wl,--hash-style=both
> +ldflags-y := -shared -nostdlib -soname=linux-vdso64.so.1 \
> +            --hash-style=both -T

I'm happy with the rest of the patch, and the intent of the patch.
The one part I'm worried about is the above hunk.  Since -shared is
now repeated between the compiler and the linker flags, I looked up
the documentation on -shared.
https://gcc.gnu.org/onlinedocs/gcc/Link-Options.html
>> For predictable results, you must also specify the same set of options used for compilation (-fpic, -fPIC, or model suboptions) when you specify this linker option.
So it seems that -shared should be used for BOTH compiler and linker,
but it seems like -fPIC should be, too.  It may be fine without, but I
would be more comfortable signing off if -fPIC was specified in both.
Otherwise the rest of the patch LGTM, and thanks for sending.

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
> base-commit: 9cb1fd0efd195590b828b9b865421ad345a4a145
> --


-- 
Thanks,
~Nick Desaulniers
