Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23BA1F52C2
	for <lists+linux-s390@lfdr.de>; Wed, 10 Jun 2020 13:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgFJLCU (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 10 Jun 2020 07:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbgFJLCT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 Jun 2020 07:02:19 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80631C03E96F
        for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2020 04:02:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f185so1410896wmf.3
        for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2020 04:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7rhDhb7XG1irEJ3s4PZgrsrHfWLraefC8nvpXB2M8Mc=;
        b=CF/wuS5VIaKoRFRb1edURv8iEQYjyR3CNEeytRlAMvA21wqwMjjYcRQRDMcvSaZUt5
         sIxLF4nAiFukzYUzqFoM9F0M6EEuJnIeUdTzfS0wbtKfeKBl+oMFBvPxFZSnGFuGTJLn
         SLTnN0OH3CuV5KXtb4twhKhkNGT2rkhLsQdYrg4ECSvDpDw3KYMeiCGxsBnH7TBD/r9B
         VzJkPzGsPN92P+dzDdnjqTGCgJtXDQyDWZZlbW01anZrpC2hZ6eMvX8D1mJRHzoVfodx
         i01NcDUjuR3gVvm8teMjg8uDLv1MVDoe2pkZwjgDi1Sx4EmzwBMadua3PgiovyaVXVdW
         VbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7rhDhb7XG1irEJ3s4PZgrsrHfWLraefC8nvpXB2M8Mc=;
        b=lK7C9nGAXdW9JK1EOgWfOTZ2WPe67LCBizIMTR46IaYYc92Kvubh10uyVQmpySyqMk
         nyq2/yD1nZQRqTeqtKNZWlO85IfGKB30uRtXXWvUe1QqKYgWnzHZc9Jt1ILg0PbEY1gG
         O4mM7D/eqwwLUtq9jTFyV+O56wERNEdhN3xZCwhvTvVnuLztUVFTMoGlNEJ3VjuOlZXO
         C3Hagx64pkEvMGOPP9EkZ3ZqHUvLJ0ln01tDxpISZ/VnrhceKXeNloZF9zfr9AdH7v/O
         81x1qN8u7KFSZh0CSoM1wnuIZMbWFgLlfWf2my1fT3bVCkAo5B1ffBDcjubp1fRrSytW
         +11A==
X-Gm-Message-State: AOAM530fqKVeHaxQJE/IGry1GHYg1IhpPeV6tlHuL/XFXudU4fPTWfwZ
        UvrBaDJf5aZ3Khf3VpglfCZQve6FIcv1HpNU1Dqg4Q==
X-Google-Smtp-Source: ABdhPJxWkdQzPjV7iJo60NGhf0b8aUxJU7l5zHaNMqK0GiMoKSAB8Ny3tlpYWzYCUR5SkGOV1LyzRNZv8bHwF8oZDuo=
X-Received: by 2002:a1c:2082:: with SMTP id g124mr2706952wmg.21.1591786936358;
 Wed, 10 Jun 2020 04:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200610052154.5180-1-cai@lca.pw> <CACT4Y+Ze=cddKcU_bYf4L=GaHuJRUjY=AdFFpM7aKy2+aZrmyQ@mail.gmail.com>
In-Reply-To: <CACT4Y+Ze=cddKcU_bYf4L=GaHuJRUjY=AdFFpM7aKy2+aZrmyQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 10 Jun 2020 13:02:04 +0200
Message-ID: <CAG_fn=X-da3V0OC-Bzd2rmkNuZ_bVpH_n7Sp5P_hSGXD4ryyBA@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: silence a KASAN false positive
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 10, 2020 at 7:55 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Jun 10, 2020 at 7:22 AM Qian Cai <cai@lca.pw> wrote:
> >
> > kernel_init_free_pages() will use memset() on s390 to clear all pages
> > from kmalloc_order() which will override KASAN redzones because a
> > redzone was setup from the end of the allocation size to the end of the
> > last page. Silence it by not reporting it there. An example of the
> > report is,
>
> Interesting. The reason why we did not hit it on x86_64 is because
> clear_page is implemented in asm (arch/x86/lib/clear_page_64.S) and
> thus is not instrumented. Arm64 probably does the same. However, on
> s390 clear_page is defined to memset.

Can we define it to __memset() instead?
__memset() is supposed to be ignored by KASAN, e.g. KASAN runtime uses
it in the places where we don't care about bugs.
