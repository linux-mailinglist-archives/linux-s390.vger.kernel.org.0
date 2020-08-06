Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF7E23E1D0
	for <lists+linux-s390@lfdr.de>; Thu,  6 Aug 2020 21:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgHFTDG (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 6 Aug 2020 15:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFTDF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Aug 2020 15:03:05 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA7FC061574
        for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2020 12:03:05 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y206so15321102pfb.10
        for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2020 12:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhR0m982Es3MI21ruXSJXbz1Iy4lmeilbsfCyAfMJxo=;
        b=sByt28GXGJ2qmUWW8e/taZtD9K+rBh8ZeO5EWGmQsAfjQKxxiJ0x7aA33Jjie9WGzW
         h/GJnsLuSeKO3+9iSSWWwIWHZQ2WjyNKSbLqOJFOsXeQnYUq5qcVwcKqB8ymlBmfB0IZ
         uWcPI4cPdd58G9dHGGt5Ej/LcFaTOkns3a9RkMfHkO3TCzat0XgjziuKPJC/xJzN/czy
         wDHHN6XQ4INII6ei0wA/sf9Vc53Qk+4fr/lgATONxbIHuR8dYZpl03qdTW/rrURvUgzc
         tV1++iAuv0yvCLt3YMnGTN622hMdiD+hhm1rkK7HXgXIJgzBIaNOKjLA7YXATTIDObtY
         0OEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhR0m982Es3MI21ruXSJXbz1Iy4lmeilbsfCyAfMJxo=;
        b=hrTCE29nYW+is0mkRkefhmWkJ07J0WTGAkxEU9bv/grGvyGPZiIcd5kZ1dMb/Vm0Ko
         JgcU34AZqZdioFzI8Nc8G6iUFiJwhpdgkhL8x9ZnkJzn+l00MdFs2jIjvgIn3KzXe82O
         ZBATGtxrwqL8m4jCHUk8y35GO7bNz/eP/ct45EJkeNzAJEp9UPUF29nvnY3AMT0wcoJ3
         VLhISo8ufiVwpvdMb/84T5F3KFUKxOP53MnC7z9JUklByEcDOqBgvIg4z5zb7sT7QqNB
         fr9FfYOPS3//5KAJ5QVQlTuA8dKE79sBH3mHdKOE0mIYAZ9uVeSfO4tmIwVGQQDpmNN/
         CbtQ==
X-Gm-Message-State: AOAM532kDGGi8oV8uSzw//lRCwXfx7eoB22PkdShKMMD6aDNXknvZsIZ
        7+hmH824uMlubl1OsoMoE7mibJ7VmU8KWW2XNWhh3E4km8c=
X-Google-Smtp-Source: ABdhPJwzbr8mf0iH888U0xYgTcLKeaHoK1HqvtprwRAnD5B4KL2v3NwZLj4XrqkreCy0IJajcQ3d1zwjPKpViLQS8qA=
X-Received: by 2002:aa7:96e5:: with SMTP id i5mr9578554pfq.108.1596740584269;
 Thu, 06 Aug 2020 12:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdn-2E=v_7Uie71pz2jjYCKnk98K1Ly8EkpxzvC6M5pXFA@mail.gmail.com>
 <20200716112840.GC8484@osiris> <your-ad-here.call-01596030682-ext-1369@work.hours>
In-Reply-To: <your-ad-here.call-01596030682-ext-1369@work.hours>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 6 Aug 2020 12:02:52 -0700
Message-ID: <CAKwvOd=1E+90VHwzh9cYGz9YKy_ECMJuK6gZhzLqBFw9kS4Cww@mail.gmail.com>
Subject: Re: linux plumbers + clang + s390 virtualized testing
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jul 29, 2020 at 6:51 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> > > We were very excited to see your patches going by for enabling Clang
> > > support for s390.  Since then, we've added s390 builds to our
> > > continuous integration setup.
> > >
> > > We've been running into a few issues with doing virtualized boot tests
> > > of our kernels on s390.
> > >
> > > I was curious if you'll both be attending Linux plumbers conf?  If we
> > > carve out time for an s390+clang talk, would this be of interest to
> > > you to attend?
> I will attend and it would surely be interesting to me and other
> s390 folks. Your efforts are greatly appreciated!

Cool, so our MC has been approved:
https://www.linuxplumbersconf.org/event/7/page/80-accepted-microconferences#llvm-cr

But we're super tight on time and probably won't be able to do a
session on s390 at the MC.  That said, I have just submitted a BoF
proposal since we have more topics internal to our group we'd like to
have more time to discuss.  I've added s390 testing to the list of
potential topics, too.  I'll re-ping this thread once I hear back
about whether it gets approved or not.

That said, we do meet once every other week virtually online, see
links: https://clangbuiltlinux.github.io/.

>
> BTW I believe basic Clang support for s390 came earlier in 5.2 with
> a lot of efforts from Arnd Bergmann.
>
> My part was fixing recent breakages and bugging our s390 clang team
> (which did all the great work) to get kernel specific features support
> in clang 10 and 11 to reach features parity with gcc. And eventually
> doing few adjustments so that features which came with clang 10 and
> 11 are working smoothly. That is s390 "asm goto" support and specific
> compiler flags for ftrace support and stack packing.

That's awesome; I'd love to get the chance to meet your s390 LLVM
team; in general it can take a while to get bugs routed to folks most
empowered to fix them until you know who they are.

Would you, any fellow s390 kernel and LLVM folks be interested in
attending one of our virtual meetings, even if it's just to say "hi"
quickly? Next one is next Wednesday.

Usually we go over whatever firedrills we've been running the past two
weeks, but sometimes have presentations of folks projects and
research.  I think it would be cool to get more background on s390 and
work out the issues we're running into with testing.
-- 
Thanks,
~Nick Desaulniers
