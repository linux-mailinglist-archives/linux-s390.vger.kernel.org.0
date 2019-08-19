Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F8894F05
	for <lists+linux-s390@lfdr.de>; Mon, 19 Aug 2019 22:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfHSUab (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 19 Aug 2019 16:30:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40976 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfHSUaa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 19 Aug 2019 16:30:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id j16so10040277wrr.8
        for <linux-s390@vger.kernel.org>; Mon, 19 Aug 2019 13:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l52yYwHq1LObMc0puWs93jV1nOm5qkHbMpUFFaC5UE4=;
        b=SDwq3O+rWLYotgDX3AdaiYfydMz54Xw3Snjv+BPKxNhCVuwzKp+WC7m2PM8aNBVrSr
         DlVWn4DzC2jW6uWf57xYehppqX4iHLbJ+j/PMbnc/6AMucQuaRa8sk9SUd/EHQjXFArc
         oLtEnU9kfaOGckZeCMiCdPrSVbaIjThh0RPSPTXn3Hb/U8ua6Khy+LpygOWpNyI+3NPS
         kT2k+bWYohcs83GADoo5+YcGLGCR5yx21rMGR36uBxgF7zMRhqdZvfKv269j+Jv2Dat6
         YrckVK03ocqHQqY0Za1nr8rOZ7ygHyMhZNNzhu8k8FFHHNPnIXPot8uEsIos2ukk4QYu
         24HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l52yYwHq1LObMc0puWs93jV1nOm5qkHbMpUFFaC5UE4=;
        b=pQLAS9+KQfeafE0YsAOe41mYbUV9SRrf/WEYUo9lhSdmVuUlJPTXUhIQavFD/T3Yxl
         ubym+gvlUxafVNF4/3iaMJwqhAC/4IAB98IVlUU/6YQl/yaqFJSrP6cEUFAV6mAtn3wc
         QP9jDx4p/RdqEcQLZLUwg1qLqqTEEIemle3FtlNdR6uAObwwYepwLE1Y+LEiv/35eCWa
         8eGOlhpXaA2CfvNMaLsEyMbDRlxnopEs2IoOU5HdSTy05de+LaFd78lB4LfLoBCVWTlz
         kC3KscwnbeWC3H7yXepb94XKQArnLw/ZCqpySfd5M7fXiTsV6/WnMHhWSsWxmopvS38v
         z2og==
X-Gm-Message-State: APjAAAX0KIwlfGWlQ5EhSSxv6Ek8fgszpRvlTTY/PxIUI76JX6XA/UQm
        A6LN0fWtqvOr0jtG3Ahgmv6039IlBwiKWHe7NLQgIw==
X-Google-Smtp-Source: APXvYqyPtrXxAYjyWWCryqrxHIgQAaxNHv7cEqM1mUeNw0yq9H+DtUO9ide1m9aKd111B6/IdMFPiMs9lgjFs6v17wk=
X-Received: by 2002:adf:e8c2:: with SMTP id k2mr28893752wrn.198.1566246628164;
 Mon, 19 Aug 2019 13:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190817142435.8532-1-hdegoede@redhat.com> <CAKv+Gu_bdcEQVnUcBpucgxk8zJ3EgsS=mBUpqfECOq_k1YYN9w@mail.gmail.com>
 <26a86843-d610-80fe-6bdc-a8ce4fd43d6b@redhat.com>
In-Reply-To: <26a86843-d610-80fe-6bdc-a8ce4fd43d6b@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 19 Aug 2019 23:30:16 +0300
Message-ID: <CAKv+Gu9sf8MSJD2w2+bqfScQPi5Wv3c7KWz9FHAjkhj2-zKupA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] crypto: sha256 - Merge 2 separate C
 implementations into 1, put into separate library
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 19 Aug 2019 at 22:38, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 19-08-19 17:08, Ard Biesheuvel wrote:
> > On Sat, 17 Aug 2019 at 17:24, Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi All,
> >>
> >> Here is v2 of my patch series refactoring the current 2 separate SHA256
> >> C implementations into 1 and put it into a separate library.
> >>
> >> There are 3 reasons for this:
> >>
> >> 1) Remove the code duplication of having 2 separate implementations
> >>
> >> 2) Offer a separate library SHA256 implementation which can be used
> >> without having to call crypto_alloc_shash first. This is especially
> >> useful for use during early boot when crypto_alloc_shash does not
> >> work yet.
> >>
> >> 3) Having the purgatory code using the same code as the crypto subsys means
> >> that the purgratory code will be tested by the crypto subsys selftests.
> >>
> >> This has been tested on x86, including checking that kecec still works.
> >>
> >> This has NOT been tested on s390, if someone with access to s390 can
> >> test that things still build with this series applied and that
> >> kexec still works, that would be great.
> >>
> >> Changes in v2:
> >> - Use put_unaligned_be32 to store the hash to allow callers to use an
> >>    unaligned buffer for storing the hash
> >> - Add a comment to include/crypto/sha256.h explaining that these functions
> >>    now may be used outside of the purgatory too (and that using the crypto
> >>    API instead is preferred)
> >> - Add sha224 support to the lib/crypto/sha256 library code
> >> - Make crypto/sha256_generic.c not only use sha256_transform from
> >>    lib/crypto/sha256.c but also switch it to using sha256_init, sha256_update
> >>    and sha256_final from there so that the crypto subsys selftests fully test
> >>    the lib/crypto/sha256.c implementation
> >>
> >
> > This looks fine to me, although I agree with Eric's feedback regarding
> > further cleanups.
>
> Ack, as I already told Eric I'm happy to do a follow up series with
> the necessary local static function renames so that we can then merge
> sha256.h into sha.h .
>

Yes, that would be excellent.

> > Also, now that we have a C library, I'd like to drop
> > the dependency of the mips and x86 sha256 algo implementations up
> > sha256_generic.c, and use the library directly instead (so that
> > sha256-generic is no longer needed on x86 or mips)
>
> I assume this is more of a generic remark and not targeted towards me?
>

Let's call it a general call for volunteers :-)
