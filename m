Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7736B626F7
	for <lists+linux-s390@lfdr.de>; Mon,  8 Jul 2019 19:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfGHRRm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 8 Jul 2019 13:17:42 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35330 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbfGHRRl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jul 2019 13:17:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id p197so11479204lfa.2
        for <linux-s390@vger.kernel.org>; Mon, 08 Jul 2019 10:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bECgTdMtGyGERAEx4hhuq1ieQo20b4zcXHR1yCPWbo=;
        b=YkdbkwQAEgL5WEVqh56Ro2gTiY0AqYU6FJl4lhKzjngEUNfc75EOmqvN/9o5KeQpRO
         8lpUZyvo4iiOCecAiFUNPpFjrlvMY38JOxpiAtItCRRMhaMDC1zexo+UgbU4ZqyeGdqs
         Q3VdTY3FIaBIw/JtDQVJXC5HHLSZ075eXR2II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bECgTdMtGyGERAEx4hhuq1ieQo20b4zcXHR1yCPWbo=;
        b=t7jl+aReNsf5EXp9FFWrqr5rQMTFYMhtnqlNrdmFJH7vd7ruySl1LxAHTCcoABR3MU
         RmrDhv6zFmKfChxF+GjyTBJi0YuEaeM2slY/sFHVYGpeWn66hHRVP0Ui2UioKja4hVvH
         B8Qz+jq3ISxh8v5QxN0Cu9P643uMUDJzASfpu26vTnAZT7KutQnbbA2P3KSrsRmoImv3
         Y7z51FqDj2f5P/a1wvE/PVSgRZphJ7XXDhaSveUgb7WHBI0F6/+l+25pHTsWSX/oxVsX
         F6Tc1rCgz3NXX0a0N23pq71Y/5KxISZg9KHHctDue1XrQ56kEw9Kw1cIpyodxPYiE4CL
         dQRg==
X-Gm-Message-State: APjAAAX2YWUX8fFgmg17+BKYT8WD6Eymy9zo7neVWE1YHuuF6ZVAUgDc
        fn4i8lEr+J90NARVH+i6F1f4+fMw5wQ=
X-Google-Smtp-Source: APXvYqyfAL7kaHwKm00sge0fHc82MjSf5MC+qz4UieSxiy0ETu4MlNMLZoBj3jhZNEyaCM1i0nILPQ==
X-Received: by 2002:ac2:51a3:: with SMTP id f3mr7552653lfk.94.1562606259425;
        Mon, 08 Jul 2019 10:17:39 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id x137sm2873270lff.23.2019.07.08.10.17.38
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 10:17:38 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id m8so7234725lji.7
        for <linux-s390@vger.kernel.org>; Mon, 08 Jul 2019 10:17:38 -0700 (PDT)
X-Received: by 2002:a2e:9a58:: with SMTP id k24mr10999260ljj.165.1562606258274;
 Mon, 08 Jul 2019 10:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <your-ad-here.call-01562573328-ext-8139@work.hours>
In-Reply-To: <your-ad-here.call-01562573328-ext-8139@work.hours>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 Jul 2019 10:17:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=win6P5gsZnE57WZOUNGP12gX2gGri3+7EhQ6uky2fZk_w@mail.gmail.com>
Message-ID: <CAHk-=win6P5gsZnE57WZOUNGP12gX2gGri3+7EhQ6uky2fZk_w@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for the 5.3 merge window
To:     Vasily Gorbik <gor@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jul 8, 2019 at 1:23 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> please pull s390 fixes and features for 5.3.
> This is my first pull request. My PGP key id is 716A93D7,
> key fingerprint: F397 316C 210A 9C03 1205  6691 467C 8ED2 716A 93D7

Thanks for the heads-up, everything looks fine and I see you have the
proper signatures on that key.

> Please also note the fixup required to avoid s390 build error after you
> pull Greg's driver-core changes for 5.3:
> http://lkml.kernel.org/r/e9889ea3-0286-df1c-864c-ba67a0286855@de.ibm.com

Ok, so I don't have Greg's pull request in my in-box yet, which means
that I may well forget about this by the time I do get it, and I won't
see the build failure because I don't do a s390 cross-build.

I'll _try_ to remember, but apologies in advance if this slips
through. I have the working memory of a slightly retarded chipmunk.

Greg - if you happen to remember and add a reminder to the pull
request when it gets done that would be good, but worst case the s390
people get to call me names.

                Linus
