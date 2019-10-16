Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C97EDD8C16
	for <lists+linux-s390@lfdr.de>; Wed, 16 Oct 2019 11:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbfJPJCv (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 16 Oct 2019 05:02:51 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41560 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfJPJCu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Oct 2019 05:02:50 -0400
Received: by mail-vs1-f68.google.com with SMTP id l2so15067987vsr.8
        for <linux-s390@vger.kernel.org>; Wed, 16 Oct 2019 02:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6jUvM81mCFEJrPhVj3ktuFKsOAYFM0PHI7JF/RGSugc=;
        b=zEoEoRFBpMGeuWqMXV1f2QHg2y48MKzrSWjmPr6/mDYgWWxOZbJL7d/8fWf/SG7HHV
         kKLadN9y/vYBRZU7Sk3mpCHh239xyDlA7O3DHiOTMowI8qPx+xDNM0BA1r1+/mQQ9gHC
         y79iDmELliQ/ijHblynfsz49H0zzWPN3L5FHCVA+IQF7NBLHXmvVS9v596wyzYHH3kjw
         WvaZpcpFC7slJ6G8fu0NP7l9UfJ2hAs5TeZGV6CG3EVqponasYr2bLW+OwCcvxbgb52V
         UXdJWUpaoOiGgxuhyl91XkUBnYFM533hNRijW+GUGt3bw/a7hRzZSH5Y3gDKWA4k6eAb
         OW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6jUvM81mCFEJrPhVj3ktuFKsOAYFM0PHI7JF/RGSugc=;
        b=Aj3Rmd/V8vgK8WQ7MCJ2t5w5AdyVoWWFRVpHjQUY4RT3a5KRTzC0r+TsMgv08Cu+cm
         668X05sdkUyqrLUlWBG4n9ORsX2MfGlsS2BVQx95whKt7HL7QebCwhAVpbI8s+0eHo75
         eA5UIm7u+IzFyV8q07JJFKvKqljK0XRVsQtBnhmZRQAKeac6OvnBY8gCpqERaHICVPcs
         /Eb5dQ5jLBhYg5tbOumqxwpG7mHg8Q63zRI3Dc/GbX29OImmnpe0ZVfwGb2TkYOwRPr6
         bTUsOmT73btbvYKMpKORX1G9e2pHlOqNsuHRiTP6uyCfQPttZkV7WiuVEcbYkyYFxBF5
         Dn/g==
X-Gm-Message-State: APjAAAX1wu6gXKwF/X0NyVANTFYMlXfX8Z81XW/vU/iHseiXnPm0U7zi
        bYDEgaL2CFAhBIe7s4Te7tL4DcU/P8kjrJPyUqlcDQ==
X-Google-Smtp-Source: APXvYqxQSyLvxpBp3m1mo/VCOsScsg3NUDkJh1pU5DAlAz/K+hgV+5JWlOgAPzmr5rIaoiRfaKo5DuPpU5vDVQv8UK4=
X-Received: by 2002:a67:b20d:: with SMTP id b13mr522223vsf.164.1571216569773;
 Wed, 16 Oct 2019 02:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191012201809.160500-1-ebiggers@kernel.org>
In-Reply-To: <20191012201809.160500-1-ebiggers@kernel.org>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Wed, 16 Oct 2019 12:02:38 +0300
Message-ID: <CAOtvUMdrrOB4zqe5v6mKDEnnfm4qnSDPW5+at6vhqTdF-wUL+Q@mail.gmail.com>
Subject: Re: [RFT PATCH 0/3] crypto: s390 - convert to skcipher API
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, Oct 12, 2019 at 11:20 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> This series converts the glue code for the S390 CPACF implementations of
> AES, DES, and 3DES modes from the deprecated "blkcipher" API to the
> "skcipher" API.  This is needed in order for the blkcipher API to be
> removed.
>
> I've compiled this patchset, and the conversion is very similar to that
> which has been done for many other crypto drivers.  But I don't have the
> hardware to test it, nor is S390 CPACF supported by QEMU.  So I really
> need someone with the hardware to test it.  You can do so by setting:
>
> CONFIG_CRYPTO_HW=3Dy
> CONFIG_ZCRYPT=3Dy
> CONFIG_PKEY=3Dy
> CONFIG_CRYPTO_AES_S390=3Dy
> CONFIG_CRYPTO_PAES_S390=3Dy
> CONFIG_CRYPTO_DES_S390=3Dy
> # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=3Dy
> CONFIG_CRYPTO_AES=3Dy
> CONFIG_CRYPTO_DES=3Dy
> CONFIG_CRYPTO_CBC=3Dy
> CONFIG_CRYPTO_CTR=3Dy
> CONFIG_CRYPTO_ECB=3Dy
> CONFIG_CRYPTO_XTS=3Dy
>
> Then boot and check for crypto self-test failures by running
> 'dmesg | grep alg'.
>
> If there are test failures, please also check whether they were already
> failing prior to this patchset.
>
> This won't cover the "paes" ("protected key AES") algorithms, however,
> since those don't have self-tests.  If anyone has any way to test those,
> please do so.



It is probably  impracticable to test paes algorithms since they rely
on keys which are not accessible to the kernel and are typically tied
to the specific machine you run on.

Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
