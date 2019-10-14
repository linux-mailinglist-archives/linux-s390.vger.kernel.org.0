Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F302CD62E2
	for <lists+linux-s390@lfdr.de>; Mon, 14 Oct 2019 14:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbfJNMrK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 14 Oct 2019 08:47:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54498 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbfJNMrK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Oct 2019 08:47:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so17143368wmp.4
        for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2019 05:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTkA/5vTH9Kh1+XMRC6xhgxSKGDJRglBVbRfMO0b/uY=;
        b=hEqY218fHzvciuduGiB8zmFUf3M0b55irActkL0tbSl4V9ZW4yb2Gr8EbVZxRMUsak
         2EEDG50n39iM1awJUJkvRG97oYZz4tX+EHLKLEWOvREf7Z+JrfkMUrZOYLfZRc00jEkg
         nrVFXNnLewGGtjWGzUsToPdaKNUKUpRuEKib7gDmcS3p2OjkfxvwZJ7CXQm3Ih8mEHBm
         GE6vtINAN+YDEePf/L+gWdG50qaKyATPJGNdeMnaVlUF12tOrKmIn987WhZLHvqp1FAU
         g75RQPG+tf4W76LB+oak+hQgOfGxgfngYrv3QwPf32ZJjQA1ssRuMpJ0Z6fobZCq9RKG
         rJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTkA/5vTH9Kh1+XMRC6xhgxSKGDJRglBVbRfMO0b/uY=;
        b=ROB+Y7zJFAHo6aw+CuEx2Ho7Ra5A+Nxoomvxa2SGwLX9wbEmjyYhApIdhlAD7utxY/
         nZQl8erfSpT12uqo5IhId3qjzA36PENqs53qgB+iUEdpSWGSKdtoqoFi0m0XWRfP7ljo
         P7SSu4zkiFND7zibhhvwv1G5quMad0NiZsRP2VrciiPMxwUlZgIX63p1La5ouENzpKfh
         SSDiLVMeca9U3RyqgD5Kd5qkBa/u1I8g6xH/ozzNetXc3JLNFH3nFrejnDpnFfzIDCCG
         Ce5JDMznYbL0U/e92Qrw7HCv0U4F2eKMW+NVkLUM9pNWLElvFfHlwK3JCmJ9883YnyNL
         mZLQ==
X-Gm-Message-State: APjAAAXOtGjydd10iwB34s3QZNj+vUbjQw5ra369FvXP+SXUvLO0vgSD
        31671HMxAFcK9y0dXs3Eq7VXeXbvCiK0T4aDyYYqtw==
X-Google-Smtp-Source: APXvYqyE7O3ty6hTTmcwGxRp3tsZOYJcvZhkhjALW6bQaoAI0SUEL4togKyAb9MuENgPYvjAUi4POYXXDr99Yki0TjM=
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr15281643wml.10.1571057226626;
 Mon, 14 Oct 2019 05:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191012201809.160500-1-ebiggers@kernel.org>
In-Reply-To: <20191012201809.160500-1-ebiggers@kernel.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 14 Oct 2019 14:46:55 +0200
Message-ID: <CAKv+Gu_HWop7ry=PKMjYrY8EcZN2dmJnqWRE=VPR2ep7OFEBVw@mail.gmail.com>
Subject: Re: [RFT PATCH 0/3] crypto: s390 - convert to skcipher API
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, 12 Oct 2019 at 22:20, Eric Biggers <ebiggers@kernel.org> wrote:
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
> CONFIG_CRYPTO_HW=y
> CONFIG_ZCRYPT=y
> CONFIG_PKEY=y
> CONFIG_CRYPTO_AES_S390=y
> CONFIG_CRYPTO_PAES_S390=y
> CONFIG_CRYPTO_DES_S390=y
> # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> CONFIG_DEBUG_KERNEL=y
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
> CONFIG_CRYPTO_AES=y
> CONFIG_CRYPTO_DES=y
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_ECB=y
> CONFIG_CRYPTO_XTS=y
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
>
> Eric Biggers (3):
>   crypto: s390/aes - convert to skcipher API
>   crypto: s390/paes - convert to skcipher API
>   crypto: s390/des - convert to skcipher API
>

These look fine to me:

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

but i cannot test them either.
