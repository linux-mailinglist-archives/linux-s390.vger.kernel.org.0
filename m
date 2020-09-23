Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA92276357
	for <lists+linux-s390@lfdr.de>; Wed, 23 Sep 2020 23:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgIWVu6 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 23 Sep 2020 17:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWVu5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Sep 2020 17:50:57 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C58C0613CE
        for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2020 14:50:57 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w3so926279ljo.5
        for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2020 14:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQxQmbzRrQuCKCUaOiqsh55FHIh/dttYp8q5GiktQPU=;
        b=ZIQvE1/n5W6r6ANWxGOZ+9AP7gwMEMEED6X92oVZOax3vYiHv+l2qcWQ1jU0hjUqkd
         lAzvYhwR1NzAN6YwWKkCYoCbwQ6S1UntBhfTbuZtHeAG/S+x4F5eKpCrCL+bTlA8pPZ9
         HstiDsRlv95t3Q2ttvq2aR/viplvzpTQymMBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQxQmbzRrQuCKCUaOiqsh55FHIh/dttYp8q5GiktQPU=;
        b=rqS4I8UG+pfmSdUtRXZHYhN14Ey4otBctBp2XGWTGHksXnxqULpRi7QsTtxQW1p79k
         SQBcu1eGxFvsdh4Uct44zK6T6z0Fgiy6aCKLQdu8O7y3tpovhlN1unHAh/cHiqZejjBf
         aiukLW71MGbH31mJmecwgAsAnUTviL3d/D17KH2G/J1kz5MvVSbykH+xXSJPNuflA93J
         byob/jmqLUp3sM87EQQrgaAyf4HA+xyvc92Da5LdiV7A/Mp5JEVz6TEDF43fsaYm9fOY
         ZZB4Gnusa4ILCfPDIUP3/NyKfwPlX6PKunxAbAKKnDEhDlWLXVra1VImW4aze6xkIrnR
         lvEQ==
X-Gm-Message-State: AOAM531GzoeDvqLvVc692NDg4t2t8cNu1TtyVls6VX5iB+xroO0yB/99
        agWVLaQ3no6xoT9SjSRmHnXX8rDei8Skyw==
X-Google-Smtp-Source: ABdhPJxLjEueuZ3OXBhzZMNhwjgzOd4Pwc8EQWCaHUP38Swjm+LNm6jHOIaZryq09HoAiiGJIQakWw==
X-Received: by 2002:a2e:b5a8:: with SMTP id f8mr540784ljn.246.1600897854505;
        Wed, 23 Sep 2020 14:50:54 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id x5sm505794lff.280.2020.09.23.14.50.52
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 14:50:52 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id k25so904511ljg.9
        for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2020 14:50:52 -0700 (PDT)
X-Received: by 2002:a2e:994a:: with SMTP id r10mr556008ljj.102.1600897851950;
 Wed, 23 Sep 2020 14:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <a46e9bbef2ed4e17778f5615e818526ef848d791.camel@redhat.com>
 <20200916142806.GD7076@osiris> <20200922190350.7a0e0ca5@thinkpad>
 <20200923153938.5be5dd2c@thinkpad> <CAHk-=wiMJu0_sLO78+nLoe=pxC-p=sSpC3moq0p5RyJc9KXC4Q@mail.gmail.com>
 <20200923233306.7c5666de@thinkpad>
In-Reply-To: <20200923233306.7c5666de@thinkpad>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Sep 2020 14:50:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbfGCKKn=RTX9gF9Q+FYOGn2kD1OLnQuJSD+A0Rvg9Pw@mail.gmail.com>
Message-ID: <CAHk-=wgbfGCKKn=RTX9gF9Q+FYOGn2kD1OLnQuJSD+A0Rvg9Pw@mail.gmail.com>
Subject: Re: BUG: Bad page state in process dirtyc0w_child
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Peter Xu <peterx@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
        Qian Cai <cai@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Sep 23, 2020 at 2:33 PM Gerald Schaefer
<gerald.schaefer@linux.ibm.com> wrote:
>
> Thanks, very nice walk-through, need some time to digest this. The TLB
> aspect is interesting, and we do have our own __tlb_remove_page_size(),
> which directly calls free_page_and_swap_cache() instead of the generic
> batched approach.

So I don't think it's the free_page_and_swap_cache() itself that is the problem.

As mentioned, the actual pages themselves should be handled by the
reference counting being atomic.

The interrupt disable is really about just the page *tables* being
free'd - not the final page level.

So the issue is that at least on x86-64, we have the serialization
that we will only free the page tables after a cross-CPU IPI has
flushed the TLB.

I think s390 just RCU-free's the page tables instead, which should fix it.

So I think this is special, and s390 is very different from x86, but I
don't think it's the problem.

In fact, I think you pinpointed the real issue:

> Meanwhile, out of curiosity, while I still fail to comprehend commit
> 09854ba94c6a ("mm: do_wp_page() simplification") in its entirety, there
> is one detail that I find most confusing: the unlock_page() has moved
> behind the wp_page_reuse(), while it was the other way round before.

You know what? That was just a mistake, and I think you may actually
have hit the real cause of the problem.

It means that we keep the page locked until after we do the
pte_unmap_unlock(), so now we have no guarantees that we hold the page
referecne.

And then we unlock it - while somebody else might be freeing it.

So somebody is freeing a locked page just as we're unlocking it, and
that matches the problem you see exactly: the debug thing will hit
because the last free happened while locked, and then by the time the
printout happens it has become unlocked so it doesn't show any more.

Duh.

Would you mind testing just moving the unlock_page() back to before
the wp_page_reuse()?

Does that make your debug check go away?

              Linus
