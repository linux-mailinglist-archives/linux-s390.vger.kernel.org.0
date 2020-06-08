Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD801F1F88
	for <lists+linux-s390@lfdr.de>; Mon,  8 Jun 2020 21:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgFHTNT (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 8 Jun 2020 15:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgFHTNT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jun 2020 15:13:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9307EC08C5C3
        for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2020 12:13:17 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z9so21907241ljh.13
        for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2020 12:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZEQWSktvr2M5fWsid2cuBAtiEuoArYd9g7ZXSsSNo98=;
        b=d3Reon7jPtra73UYNDVATmEABtsz9kmMH4WHHgreNqOfYsJ3S7HPF54P8q6CONbUXa
         Oa/+f46oc/R+kHTGTM0ic0aFLVfRV6hk3j1Zb3AbXIlYx5JH7joEGP5GzeY1egacazeG
         03riFE4/645obLNzRFcww8QqdM3A8v5zVJJuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZEQWSktvr2M5fWsid2cuBAtiEuoArYd9g7ZXSsSNo98=;
        b=fkqCEvSxnHqRSzW+3ins1yY7VY3WA3Cut3D+rtYaOE30y+8fm6Xabvfov7AGRIVicA
         P1EyuffiVB+2FCmw2nBSYSNZyV1L9sEJMdEvkFpV/MfoHd+arsj5Y+FrOY5meemCK0yo
         o57q4YnskG58tHgG/ygjg+lPMRoS1OioLh7Nk+RgjY1mbSTmmyHAoBpRPOWnAXk4M3Bu
         j9iIJTlv83Ll7UPUbRxMkNX3wDaEIpxd20tAQTalcQWSak7Xz1c9YwrnpSB9iljGjQ1q
         I1iCqjjvFUN4Wi++qRGzfJIZQLvg3wsBMAZs+IjiOEhd1NFXQKFC9UNgyKV2VAUndAMY
         RFgw==
X-Gm-Message-State: AOAM533Qywe8ABwBAekcnLxYVl6Bu51QUuUe5C8Jv3+Wtn1F5TnV6oeb
        DZtQ1tXfK8pUukhBruFBEt5KEWxWTGo=
X-Google-Smtp-Source: ABdhPJzWu6gYz16GdbiHKGYFt1V3n9DBqzELVdnav1jPOwbFbSyRMON2o0d6StRx5mXS45dHCP9Llw==
X-Received: by 2002:a2e:b17a:: with SMTP id a26mr12519284ljm.348.1591643595245;
        Mon, 08 Jun 2020 12:13:15 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 22sm3871329lju.5.2020.06.08.12.13.14
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 12:13:14 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id n23so21931460ljh.7
        for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2020 12:13:14 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr11106342ljn.70.1591643593917;
 Mon, 08 Jun 2020 12:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <your-ad-here.call-01591630479-ext-3636@work.hours> <CAHk-=whC98Ge2Y2uooRkbt11R1QpF0283Oqnz6X6AUBa_XBbzQ@mail.gmail.com>
In-Reply-To: <CAHk-=whC98Ge2Y2uooRkbt11R1QpF0283Oqnz6X6AUBa_XBbzQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 Jun 2020 12:12:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnntptk9j7KgtPQY5yNEkL5J64mAsqZgdV_4FLtiFboQ@mail.gmail.com>
Message-ID: <CAHk-=whnntptk9j7KgtPQY5yNEkL5J64mAsqZgdV_4FLtiFboQ@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for the 5.8 merge window
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 8, 2020 at 12:09 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jun 8, 2020 at 8:35 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
> >
> > Please note 2 minor merge conflict resolutions below:
>
> There was a third because of the iommu tree I merged today.

Oh, and please don't post the whole patch in your pull request.

That's ok for small "fixes" pulls, but it's absolutely the wrong thing
to do with thousands of lines, nobody is going to review that anyway
when the review is supposed to happen on the individual patches.

I'm surprised it even made it to lkml at almost 200k in size.

              Linus
