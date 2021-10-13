Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D11842B7D3
	for <lists+linux-s390@lfdr.de>; Wed, 13 Oct 2021 08:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbhJMGry (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 13 Oct 2021 02:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbhJMGrw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 13 Oct 2021 02:47:52 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4620EC061764
        for <linux-s390@vger.kernel.org>; Tue, 12 Oct 2021 23:45:49 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 66so1366065pgc.9
        for <linux-s390@vger.kernel.org>; Tue, 12 Oct 2021 23:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w0j2Ihdi/0685L8FT6WteZp6O1hKULY2lNZfHOgIHSc=;
        b=ZVG9fseiMJi5y7uNc0U//uB9qmTc4gJH0ueiRXhntI+xclAF1mY0ZabBN0HENHjmuQ
         Wd2tZE7h7XcVk1DbOBPcKKRzFh73LE1iY97UMVdM/LDFC8CDxtoZ3SUXBlDw8iyhvu6V
         muglMpS8KRkUeK+EwwJZIYurw/HXNEkgWVJds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w0j2Ihdi/0685L8FT6WteZp6O1hKULY2lNZfHOgIHSc=;
        b=gZcxylgB/XPQ7cytlOvmWAMWGwcD2qO9jbWHTjdW0Q9REYdOPt/Hl5Rbera8iVkOoH
         PZaO0yu7RGhCteq6NkHUOj7+W27beMsAc+m4nN0/Vc7QrNALl9daXBERqNLC4HFVUwpE
         2RV739IZkDe8k5WY6xCAXiCTN2gwcupQxrwJ0HJF1cFuP1DM6L3tCUHfzuid30lD39nr
         4Ep8rgRUpwP0nCUpt0boSNn/ouoCHk1QDbTrlyu9m6PeFmAc6FCmZsuWzyKr9tMOyq5F
         bTa0GhpHjaJY32Gptc+ukcM6YkyhsV8dY+qfP2+zNf/MNnri+kJ0c+mVU5KwSjUeaBUm
         2HNQ==
X-Gm-Message-State: AOAM531BxPEtdiXPzP4wFjjrJsrcPhp79+IdWc8Hrda4b7peE+mPN7Iv
        bihnI2GfmRItHVDvSna+rz/KQA==
X-Google-Smtp-Source: ABdhPJyYGTFNE7wYL1tDchWsW1G14X62AMTEsDTHRuseDYe9oXvmyOMHWZK2W0kP1Mxrbkw9HEw8fw==
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id l14-20020a056a00140e00b00444b07751efmr31628811pfu.61.1634107548651;
        Tue, 12 Oct 2021 23:45:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g11sm13397260pgn.41.2021.10.12.23.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:45:48 -0700 (PDT)
Date:   Tue, 12 Oct 2021 23:45:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>, Guo Ren <guoren@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jonas Bonn <jonas@southpole.se>,
        Jonathan Corbet <corbet@lwn.net>,
        Julien Thierry <jthierry@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Marek <michal.lkml@markovi.net>,
        Michal Simek <monstr@monstr.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rich Felker <dalias@libc.org>,
        Richard Henderson <rth@twiddle.net>,
        Rob Herring <robh@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Will Deacon <will@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp,
        x86@kernel.org
Subject: Re: [PATCH 2/2] kbuild: use more subdir- for visiting subdirectories
 while cleaning
Message-ID: <202110122345.4B8FE35AED@keescook>
References: <20211013063622.548590-1-masahiroy@kernel.org>
 <20211013063622.548590-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013063622.548590-2-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 13, 2021 at 03:36:22PM +0900, Masahiro Yamada wrote:
> Documentation/kbuild/makefiles.rst suggests to use "archclean" for
> cleaning arch/$(SRCARCH)/boot/.
> 
> Since commit d92cc4d51643 ("kbuild: require all architectures to have
> arch/$(SRCARCH)/Kbuild"), we can use the "subdir- += boot" trick for
> all architectures. This can take advantage of the parallel option (-j)
> for "make clean".
> 
> I also cleaned up the comments. The "archdep" target does not exist.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

I like the clean-up!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
