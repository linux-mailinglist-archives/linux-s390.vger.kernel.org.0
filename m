Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F67C3B004C
	for <lists+linux-s390@lfdr.de>; Tue, 22 Jun 2021 11:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhFVJfG (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 22 Jun 2021 05:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229682AbhFVJfF (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Jun 2021 05:35:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1058A61352;
        Tue, 22 Jun 2021 09:32:44 +0000 (UTC)
Date:   Tue, 22 Jun 2021 10:32:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Bill Wendling <wcw@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Martin Liska <mliska@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Fangrui Song <maskray@google.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-toolchains@vger.kernel.org, Marco Elver <elver@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 2/2] Kconfig: CC_HAS_NO_PROFILE_FN_ATTR, depend on for
 GCOV and PGO
Message-ID: <20210622093241.GC3555@arm.com>
References: <20210618233023.1360185-1-ndesaulniers@google.com>
 <20210618233023.1360185-3-ndesaulniers@google.com>
 <CANpmjNNK-iYXucjz7Degh1kJPF_Z_=8+2vNLtUW17x0UnfgtPg@mail.gmail.com>
 <CAKwvOdmxGt6nAj+dDZEPdQtXNbYb8N6y3XwoCvCD+Qazskh7zw@mail.gmail.com>
 <CAGG=3QXeAxaf0AhKsg8P1-j2uHOoXne2KCOCEhq9SKa-e2dnag@mail.gmail.com>
 <CAKwvOd=9oAGPeuQmWnAMOxZn2ii_CRmyWnheoyXGcd09-U_CwA@mail.gmail.com>
 <20210622092533.GB3555@arm.com>
 <20210622092937.GB67232@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622092937.GB67232@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 22, 2021 at 10:29:37AM +0100, Mark Rutland wrote:
> On Tue, Jun 22, 2021 at 10:25:34AM +0100, Catalin Marinas wrote:
> > On Mon, Jun 21, 2021 at 01:43:54PM -0700, Nick Desaulniers wrote:
> > > We need to be able to express via Kconfig "GCOV should not be enabled
> > > for architectures that use noinstr when the toolchain does not support
> > > __attribute__((no_profile_instrument_function))."
> > > 
> > > Where "architectures that use noinstr" are currently arm64, s390, and
> > > x86.  So I guess we could do:
> > > 
> > > + depends on !ARM64 || !S390 || !X86 || CC_HAS_NO_PROFILE_FN_ATTR
> > 
> > I think you want:
> > 
> >   depends on !(ARM64 || S390 || X86) || CC_HAS_NO_PROFILE_FN_ATTR
> > 
> > > (We could add a Kconfig for ARCH_WANTS_NO_INSTR, which might be more
> > > informative than listed out architectures which might be non-obvious
> > > to passers-by).
> > 
> > That would probably look better.
> 
> It does; see:
> 
> https://lore.kernel.org/r/20210621231822.2848305-1-ndesaulniers@google.com

I'm getting there, eventually ;).

-- 
Catalin
