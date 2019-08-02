Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7B87ECD4
	for <lists+linux-s390@lfdr.de>; Fri,  2 Aug 2019 08:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388817AbfHBGo5 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 2 Aug 2019 02:44:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36340 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfHBGo5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Aug 2019 02:44:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so61127388wme.1
        for <linux-s390@vger.kernel.org>; Thu, 01 Aug 2019 23:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RTIJdZfJyogINbGkYtFeVknV1tGImWiMfrMoLbklh1U=;
        b=v9QIbgCJLNas6/Y7Z9dtjZuPimi86NjRV3xXNKuKIVqYz6ewnLF8A0M7ywWyjhg8w6
         H4wT36fNabVxqIWqE/fI2QF8HA74Gzgd1jAdy0tiuKYclKURJAlUEHBrPU00RuQOK/d3
         t8SQ2Xt/dVe9UahYIYqWz9KozYRS7ZcBGdp0ZJkkl6uXNgfV5Qyq0w5vIsraVDTmclJK
         rSzr+KqB6cpvNJ2+qm8hVPQkLj02ZFMcdIXIS/UCcolKa8ogkH3oK+4B7NVsOk1lB6Ne
         G+PmqqtT76rJPPTEUvhsUAjYN6D6iSJ+iKQpv1/vIBVxDyOmrY6R809L6U1xVY4QExF/
         l/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTIJdZfJyogINbGkYtFeVknV1tGImWiMfrMoLbklh1U=;
        b=fapL7dPjdoGFLVb+fGG1rvT157SadBAzgNBJBetbWCFl7zLqx13NN+n9By80bMFnV5
         QVKRBakxrwfTBE+6X9ANuLNFlaOl0aB7/eq+VihOm5ZtKm4otjHcLlKGMrCFqzacy11x
         d3XkfNptUbhq4+Op88i/SjIs1VSyGzpR95xX5b2CyurXJM41w45n/0jeTHPmlmD3pZ5Z
         KrTvYbhCXA0rmR2cMki2MaK4tJKSMHTE9CgLZaUddgbX34PW2XDyT1pf+KsNRIxuPFfN
         x/JxAAnhaT9JKFnpNlnPkvwagXG3kdrN+DaqMu/9u38W9JFZ0Fi092gsQsD/N8cHIRJ4
         zBIQ==
X-Gm-Message-State: APjAAAV/X36oHDk/jQv0NIWN02Jm2TZ3HsmK2krohhqYoXs9lm/Uq6R0
        jUG6LI4GAYDtzt/9+/0Pj9EyPwrtf0YTGry1HT8RRA==
X-Google-Smtp-Source: APXvYqx2HjMfMiZukBNAi3VGxqmE7eYipuL8FubFc14RnWYXjUkXzbAJ8eTBAGYq8r2gpLTpJTE4JQcAoWP6WjCmZE4=
X-Received: by 2002:a05:600c:20c1:: with SMTP id y1mr2792227wmm.10.1564728294618;
 Thu, 01 Aug 2019 23:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190731163915.3fdfcb14@canb.auug.org.au> <20190731085819.GA3488@osiris>
 <20190731110816.GA20753@gondor.apana.org.au> <20190731111520.GC3488@osiris>
 <20190731113216.GA21068@gondor.apana.org.au> <20190731114453.GD3488@osiris>
 <20190801122849.GB4163@osiris> <CAKv+Gu_1HP2NapMk5O_-XpJdga5zyFJDkVudTRT6CWm+tqPndA@mail.gmail.com>
 <20190802102019.6a789c51@canb.auug.org.au> <20190802031414.GB14879@gondor.apana.org.au>
In-Reply-To: <20190802031414.GB14879@gondor.apana.org.au>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 2 Aug 2019 09:44:43 +0300
Message-ID: <CAKv+Gu_dohBsU3HN_J8cZBSKakKM61g++K1V0T1CJ6JtkJ8V-A@mail.gmail.com>
Subject: Re: linux-next: Tree for Jul 31 - s390 crypto build breakage
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Patrick Steuer <steuer@linux.ibm.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 2 Aug 2019 at 06:14, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Hi Stephen:
>
> On Fri, Aug 02, 2019 at 10:20:19AM +1000, Stephen Rothwell wrote:
> >
> > It might be time to revert all this series and try again.  The
> > implementation seems to have not been well thought through from a kernel
> > building point of view.  For a start the two commits
> >
> >   7cdc0ddbf74a ("crypto: aegis128 - add support for SIMD acceleration")
> >   ecc8bc81f2fb ("crypto: aegis128 - provide a SIMD implementation based on NEON intrinsics")
>
> I think the idea was that it would get optimised out if the
> implementation is absent which is why it was meant to work in
> this order.  But oviously as we have found out this didn't work.
>
> Ard, I think relying on the compiler to optimise something out based
> on an assignment within an if statement is just too error-prone.
> We'll need a different mechanism for this.
>

Indeed. This is definitely something I tested, and it appears to be
dependent on the GCC version.

> For now I'm going to back out those two specific patches as the
> rest seem to be valid by themselves.
>

OK. I will adopt this mechanism [0] after all and resubmit, once I get
confirmation from either Voldis or Heiko that this makes the issue go
away (given that my local GCC does not reproduce the issue)

[0] https://lore.kernel.org/linux-crypto/20190729074434.21064-1-ard.biesheuvel@linaro.org/
