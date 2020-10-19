Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5070229309B
	for <lists+linux-s390@lfdr.de>; Mon, 19 Oct 2020 23:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733053AbgJSVgX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 19 Oct 2020 17:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733051AbgJSVgX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 19 Oct 2020 17:36:23 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFE1C0613CE
        for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2020 14:36:23 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id u7so761311vsq.11
        for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2020 14:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zt0sW14NGbSPkIAsGgDnuPTZkg50rAzFOa2c71N8N40=;
        b=vLNvAP1LjWrhrL4F8+0NHo6Iug6iIoUeVxrn2cQUJmNrS2okc6WWChp9EtjXIa6FWV
         5pzCEw1pW52OE1xuwzXtCZgdD+8LJJfyczi5xi4m680Kxqw8tWafPosbk0aE6Fynr40+
         POp0Zr9jbXAM4pkGRhgD+jqMbcFEpYBRMvEaORAOpjsaHQAfVt8K8h+tJKA14EhFA5Xl
         jb1PWcVT/CyQ3lGlMGT12eYzLlN8Kp3Ca1PyvZFs7w0JvoNN5+Ny/vIJgf3njOHRyDWj
         GUk+MNni93ri/x+CA6I+OEyJjfzD49rz3Ra9dnzTYBpzLJtGu45xnOYktYh+6c4O6pDE
         Zkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zt0sW14NGbSPkIAsGgDnuPTZkg50rAzFOa2c71N8N40=;
        b=BuAxZ5Aqf5iezXg7XWRjkgfpkLBs1tIFAZLDgQdEsuPPswagK/GaN6pcF3q2CbBneR
         /Ahqc7JiDw/P6uM3IzVUdLvpi65TDzCGabTmSE4vt6IO3p+wEISqhyjL2XTki4TGM3Ud
         ki1EyrPQJD5dvZdycpASn+X55cwy5MLDQ0qDneYpzZ2CILj4ftVLyEQ7i8unqPE62rIL
         HCn81MPdUNAslMYGAAIIalDtX8RV6YdW9EeWw4d6y4sXY4jlplPMCZgrraPNtKV4xAuS
         IYVyk2jd2D1ZuPJISAohkdhFQYI1d9gLrJ36fEf52s+7/u6pX156XV8+YUzlfxIBlkWo
         LcBA==
X-Gm-Message-State: AOAM533zT4xcEp3ecLswil8BPGKeGoeioI1nWm9T1EmhX32e/dYZXqYn
        y9lRXpRw0YfbrEvQif6u6iqxQ3GApNLXzI8EJQiCRg==
X-Google-Smtp-Source: ABdhPJxFtppCFVzz+pb+4uOv1AfMN+qMXos9IGuk48xsKZ9xhEWW1XWGgYxg4hQYiZV9Jjy3DqKPugr8Olokwc9+aPA=
X-Received: by 2002:a05:6102:1144:: with SMTP id j4mr1772628vsg.39.1603143382267;
 Mon, 19 Oct 2020 14:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=0nOhK4KoLb1_Jni5u3ENDx10QeAxfYcSbtFQs77FxAw@mail.gmail.com>
 <30b7bea6-1135-609b-f1e5-a4f243e1dcc1@roeck-us.net> <CAKwvOdmnr0qqJTg+cU5KJ2-nJQgTY-8AraZQHXZUw0KNZKE4fg@mail.gmail.com>
 <c461496a-1ea4-4d44-4913-950cabcd3e31@de.ibm.com>
In-Reply-To: <c461496a-1ea4-4d44-4913-950cabcd3e31@de.ibm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 19 Oct 2020 14:36:10 -0700
Message-ID: <CAKwvOdnn=i_Jg4B5o4sh2mRNGY9aH1piXoBYwEB4E3PpWZM5bw@mail.gmail.com>
Subject: Re: s390 - buildroot + qemu
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, egorenar@linux.ibm.com,
        Vasily Gorbik <gor@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 19, 2020 at 3:55 AM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
>
> On 17.10.20 01:40, Nick Desaulniers wrote:
> > On Fri, Oct 16, 2020 at 4:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On 10/16/20 4:11 PM, Nick Desaulniers wrote:
> >>> Hello all,
> >>> I'm working on integrating the latest release of buildroot (2020.08.1)
> >>> into our CI for ClangBuiltLinux.
> >>>
> >>> https://github.com/ClangBuiltLinux/boot-utils/pull/25
> >>> https://github.com/ClangBuiltLinux/boot-utils/pull/26
> >>> https://github.com/ClangBuiltLinux/continuous-integration/pull/327
> >>>
> >>> I'm seeing the following error from QEMU:
> >>> KASLR disabled: CPU has no PRNG
> >>> Linux version 5.9.0-00732-g04ed4527465f (ndesaulniers@<myhost>) #30
> >>> SMP Fri Oct 16 15:49:05 PDT 2020Kernel fault: interruption code 0005
> >>> ilc:2
> >>> PSW : 0000200180000000 000000000001779e
> >>>       R:0 T:0 IO:0 EX:0 Key:0 M:0 W:0 P:0 AS:0 CC:2 PM:0 RI:0 EA:3
> >>> GPRS: 0000000000000001 0000000c00000000 00000003fffffff4 00000000fffffff0
> >>>       0000000000000000 00000000fffffff4 000000000000000c 00000000fffffff0
> >>>       00000000fffffffc 0000000000000000 00000000fffffff8 00000000008a75a8
> >>>       0000000000000009 0000000000000002 0000000000000008 000000000000bce0
>
> Do you have more information? If not, any chance to run objdump on the kernel
> and check what instructions do you have aroung address 0x1779e
> [...]

Is PSW the program counter?
/me skims https://www.kernel.org/doc/Documentation/s390/Debugging390.txt *woah*
Is there something more specific I should be running than:
$ s390x-linux-gnu-objdump -Dr vmlinux | grep 179fe
because I get lots of hits for that, but not 0x179fe.

In fact, the first symbol starts at 0x100000. Unless this is a failure
in the image decompressor?

>
> > Hopefully qemu supports something newer than Z900?  Or can we change
> > arch/s390/Kconfig:255 to use a different arch? Is arch9 == z900???:
>
> Newer QEMUs do support up to z13, so I think this is not an issue as long
> as you have an uptodate qemu.

$ qemu-system-s390x --version
QEMU emulator version 5.1.0 (Debian 1:5.1+dfsg-4)

-- 
Thanks,
~Nick Desaulniers
