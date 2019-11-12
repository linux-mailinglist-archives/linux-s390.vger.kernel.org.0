Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E234EF9B48
	for <lists+linux-s390@lfdr.de>; Tue, 12 Nov 2019 21:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfKLUzM (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 12 Nov 2019 15:55:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43281 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfKLUzM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Nov 2019 15:55:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id 3so14182349pfb.10
        for <linux-s390@vger.kernel.org>; Tue, 12 Nov 2019 12:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p3sGAQxZSRJH4UZHNpIdLrEGYPs7j+wXkkL7B23DozY=;
        b=jzJxHJOhBgrxXGo+3hwTEULMtqhW32uUMjkXF6xooOB4YLF0fDp9kjF2ZcEXOqjPmZ
         wb3eB6O717UcTt+tyAbO8B80zA3u9jbuMXSpdMqJOUrOIw/6tlJouhIZBM+a5PnCN1vj
         lat++UKcoOXZLI/EBlS4RFvn1FgV/ybJGuQ4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p3sGAQxZSRJH4UZHNpIdLrEGYPs7j+wXkkL7B23DozY=;
        b=GSJ3cdG6PX0069QzRYlcNqEWwu2bs5ju+4GLlszXehjJlFqetyS2zUohZe/xcnjDqz
         eqiUj7HuHRr9rd2WVVpH5gybWdeOkCjfAy46GvVegE0+gVRHvBAl4Okh6cZ7iqES6Ba9
         xjMwwer3WU4MUnjs0COqU8HPttP8DJr9dOC6A+9je/u+pcuTfwnkm+A0TlKv4Uv3LFBg
         EiQUAPueMguQUBRm2VbPKtWGOrcT37aztuQYs5pCDUiIXIUHQS83ZtjQZKtilBQgqpda
         YopMMLhDs6QuaSU0RHKaY1fS1Wit7h9hJNaGXq0aSUUbAkIzmuLIAP4Hv65hh+pc7jFp
         uk5Q==
X-Gm-Message-State: APjAAAUbDXDw1uLtSpoQWtY4gJS2lQHkYuhKj063a3W32qN4yAsZZrOw
        /QX0yM7fYwg1NmUpIF1s4TgbVQ==
X-Google-Smtp-Source: APXvYqwhpXomPvDY55lP5tiV27rDluqLmojMV7DK9uMTENiwD2XDmRYC37Ogc+dw1yE3QtfbhDL3ZQ==
X-Received: by 2002:a17:90a:cd03:: with SMTP id d3mr9056375pju.137.1573592111764;
        Tue, 12 Nov 2019 12:55:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l74sm11993pje.29.2019.11.12.12.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 12:55:10 -0800 (PST)
Date:   Tue, 12 Nov 2019 12:55:09 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/29] vmlinux.lds.h: Replace RODATA with RO_DATA
Message-ID: <201911121252.25720DC6@keescook>
References: <20191011000609.29728-1-keescook@chromium.org>
 <20191011000609.29728-12-keescook@chromium.org>
 <CAMuHMdXfPyti1wFBb0hhf3CeDSQ=zVv7cV-taeYCmDswMQkXPQ@mail.gmail.com>
 <201911110922.17A2112B0@keescook>
 <CAMuHMdUJ8QPvqf51nVmOg1Zm20SNT7pXR72z=qmco=ecwawZ7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUJ8QPvqf51nVmOg1Zm20SNT7pXR72z=qmco=ecwawZ7A@mail.gmail.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Nov 11, 2019 at 07:08:51PM +0100, Geert Uytterhoeven wrote:
> Hi Kees,
> 
> On Mon, Nov 11, 2019 at 6:23 PM Kees Cook <keescook@chromium.org> wrote:
> > On Mon, Nov 11, 2019 at 05:58:06PM +0100, Geert Uytterhoeven wrote:
> > > On Fri, Oct 11, 2019 at 2:07 AM Kees Cook <keescook@chromium.org> wrote:
> > > > There's no reason to keep the RODATA macro: replace the callers with
> > > > the expected RO_DATA macro.
> > > >
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >  arch/alpha/kernel/vmlinux.lds.S      | 2 +-
> > > >  arch/ia64/kernel/vmlinux.lds.S       | 2 +-
> > > >  arch/microblaze/kernel/vmlinux.lds.S | 2 +-
> > > >  arch/mips/kernel/vmlinux.lds.S       | 2 +-
> > > >  arch/um/include/asm/common.lds.S     | 2 +-
> > > >  arch/xtensa/kernel/vmlinux.lds.S     | 2 +-
> > > >  include/asm-generic/vmlinux.lds.h    | 4 +---
> > > >  7 files changed, 7 insertions(+), 9 deletions(-)
> > >
> > > Somehow you missed:
> > >
> > >     arch/m68k/kernel/vmlinux-std.lds:  RODATA
> > >     arch/m68k/kernel/vmlinux-sun3.lds:      RODATA
> >
> > Argh. I've sent a patch; sorry and thanks for catching this. For my own
> > cross-build testing, which defconfig targets will hit these two linker
> > scripts?
> 
> vmlinux-sun3.lds: sun3_defconfig
> vmlinux-std.lds: All other classic 680x0 targets with an MMU, e.g. plain
>                  defconfig aka multi_defconfig.

Excellent, thank you; I've updated my multi-arch build list. :)

-- 
Kees Cook
