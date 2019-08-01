Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C63357E116
	for <lists+linux-s390@lfdr.de>; Thu,  1 Aug 2019 19:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732699AbfHAR3J (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 1 Aug 2019 13:29:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40910 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbfHAR3I (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Aug 2019 13:29:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so74423027wrl.7
        for <linux-s390@vger.kernel.org>; Thu, 01 Aug 2019 10:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7iES048LQCKT01wi1ZH6mu+llZ9u5BBJ+ptxxo4m+U=;
        b=WoHkVxtXyOlDI8FIrsWX+mKng5MgkynwGfd/EiStmKxt5ZmRGwagRY65HZ1D/QQNaj
         v4dQ3o6i+FbowNs5iKg+uUWIfd1LDUikpWW4Stm6hL/a+dh8l98sjXdIoUQ2DGyWdW9D
         VwHTiK6m88q/cO6xDvrUQ3OVGBezKVCugRm52n40mmP1+TOql/Ahky5a7rBp1QesQTNr
         ygTczmDMsij0pflEsuxDve0CwQVXOUzBdxX9X7P85zCpzUJm9RBRhz9BJuFUaEuWCUHT
         KkHtw/5RQDWhEyUF3UuSCcNG0QKqk09Oq1fURsscjTBaMQlUlp96ZULSpZUEU0G2IdcC
         sziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7iES048LQCKT01wi1ZH6mu+llZ9u5BBJ+ptxxo4m+U=;
        b=HLKE79RmDm2Z2Mn8YtCwVqVhjYvVg1C2aroL6huM4P7eg/nOI4Jyr/exTyOfJtb20z
         hX+K6CAem+JCVYKJxLpRfa69SbVQixE9IsaNkkPHZqqn+e6oPH0kSmxnRkSwGowlvtfu
         7/y4iuD6Fyu0r/igfTEJHP0dXphwL8rLdGN1u6fz5R/cA8rDm8QLny3dl/5EHpaT/VNa
         KnWEkYNEkTyDxVWPt+sKT8pFfbgk93sAmxzU4ixOYGmuaWgH984BLYBYQHZ97TEa+04L
         ltgXeAeABgl02ZA3xOsqSAeF+kbusrU8mdhsB1q++3ykZUdpus2NXURGyilAS0eRgZ7G
         9C3w==
X-Gm-Message-State: APjAAAUv4TWyzJapiL3dPqgyPJaXuzIy6FqaiuWlgxl8USkW7j8ncd1t
        CM2BxwN+5MV8eTEoqfwpoG59JLkan5cQ+1uJ9+tiAw==
X-Google-Smtp-Source: APXvYqwQ4BT46vMcwoHkV6Gc8YIsZiFmZw8/ASpSzzC9Tz3z1i9lnwO696CATx2wOyOHjR2u5qFB2fR3Zp04ForpvZs=
X-Received: by 2002:a5d:6b07:: with SMTP id v7mr31905638wrw.169.1564680546461;
 Thu, 01 Aug 2019 10:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190731163915.3fdfcb14@canb.auug.org.au> <20190731085819.GA3488@osiris>
 <20190731110816.GA20753@gondor.apana.org.au> <20190731111520.GC3488@osiris>
 <20190731113216.GA21068@gondor.apana.org.au> <20190731114453.GD3488@osiris> <20190801122849.GB4163@osiris>
In-Reply-To: <20190801122849.GB4163@osiris>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 1 Aug 2019 20:28:56 +0300
Message-ID: <CAKv+Gu_1HP2NapMk5O_-XpJdga5zyFJDkVudTRT6CWm+tqPndA@mail.gmail.com>
Subject: Re: linux-next: Tree for Jul 31 - s390 crypto build breakage
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Patrick Steuer <steuer@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 1 Aug 2019 at 15:28, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>
> On Wed, Jul 31, 2019 at 01:44:54PM +0200, Heiko Carstens wrote:
> > On Wed, Jul 31, 2019 at 09:32:16PM +1000, Herbert Xu wrote:
> > > On Wed, Jul 31, 2019 at 01:15:20PM +0200, Heiko Carstens wrote:
> > > >
> > > > However that doesn't fix the simd.h header file breakage with the
> > > > second patch :)
> > >
> > > That fix should be there now too.
> >
> > Yes, works now. Thank you!
>
> Still not... with linux-next as of today I get this (s390 defconfig):
>
> ERROR: "crypto_aegis128_decrypt_chunk_simd" [crypto/aegis128.ko] undefined!
> ERROR: "crypto_aegis128_update_simd" [crypto/aegis128.ko] undefined!
> ERROR: "crypto_aegis128_encrypt_chunk_simd" [crypto/aegis128.ko] undefined!
> scripts/Makefile.modpost:105: recipe for target 'modules-modpost' failed
>

Hello Heiko,

Apologies for the breakage. The first two fixes addressed obvious
shortcomings in my code, but with this issue, I'm a bit puzzled tbh.
The calls to these missing functions should be optimized away, since
have_simd never gets assigned if CONFIG_CRYPTO_AEGIS128_SIMD is not
defined, but for some reason, this isn't working. Which version of GCC
are you using?

Also, could you please try whether the patch below fixes the problem? Thanks

https://lore.kernel.org/linux-crypto/20190729074434.21064-1-ard.biesheuvel@linaro.org/
