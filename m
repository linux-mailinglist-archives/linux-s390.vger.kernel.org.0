Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9158B1F54B4
	for <lists+linux-s390@lfdr.de>; Wed, 10 Jun 2020 14:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgFJM0K (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 10 Jun 2020 08:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbgFJM0G (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 Jun 2020 08:26:06 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BFEC03E96F
        for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2020 05:26:05 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 205so1773622qkg.3
        for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2020 05:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xNoh9u1q9fbWqVtSlCDwrQ/3B0eRAU+tf8g5idD9RH8=;
        b=UwTLaOrWR7hV8EsCbkCBzm+aoRnVXQvT3SaWLGbTiHJZLxaHGs/C6EN8wujmxE0ylL
         0vyEjXlLHwgwt3QdRSmhy+bwyqBa0q8UeWEcM+com0sDMfX+0OVk/D5ZsQ5aOHPUs2Ko
         OEAjMVTDagknQn+r75YbZSHmgd12Tch0f7xyc1hUfY1P3Bv/rYmXeLIZ2cthH5ckwRib
         bFEVJzGdhTGoGpc+oN4P9dqpw6flV8M8DKy9vklpOspXXjPTPRFgTc3Suffya+z8fun1
         q5DfKR0awUCBLUOlkC8lyr29hjcgkhM0FpYfHGE+S5k6J35vuCTL1CblOxltWLeJjjAP
         by1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xNoh9u1q9fbWqVtSlCDwrQ/3B0eRAU+tf8g5idD9RH8=;
        b=p6fn8cCdp8myo4UjGw4SdNjUGK2+0fBrMRyEzJuXZowU/iC2RmHbjY0LG0bBx9gfQP
         mRg0Wcsip6XrfiCpnnUjC+1Z4fUsnSz/j08AfcaoSX0cgoQg0s7vKS/O1Z7fBfsAhzA4
         OLWZfONVXpcdx1ngi7MFQfgndM6YNKQcIKSi7eedKL6uF/fZngA4+k9aktFARqY/XK7o
         3VSrGH9AJUC9045l+TZC1YQfiSMLxM4g+soQxrx47as2Hw8yNtGI+mX+WBuug2Uo8yS+
         4AdEdgJQpUWPW694PMWo7/LXcL9GP01X2wNvOLBzQoM/M3ubop454K/ci7OECNayeJGa
         Jtsg==
X-Gm-Message-State: AOAM531qNuvnbMNiapbiBS8Yb8UIaXBo6lQ3y+IJP4fUrkQHmbZE6IHU
        COpsN2omNRQZozE+l8pjHsBIMQ==
X-Google-Smtp-Source: ABdhPJxfCiqGtPTB/F8/CkJXwvO/TBi4Kep/Q9MykJYaeASwyoqY8SlgDYmVpqi7gBmnB+zfpWIusQ==
X-Received: by 2002:a37:7d45:: with SMTP id y66mr2582137qkc.484.1591791963659;
        Wed, 10 Jun 2020 05:26:03 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y54sm13368128qtj.28.2020.06.10.05.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 05:26:02 -0700 (PDT)
Date:   Wed, 10 Jun 2020 08:26:00 -0400
From:   Qian Cai <cai@lca.pw>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] mm/page_alloc: silence a KASAN false positive
Message-ID: <20200610122600.GB954@lca.pw>
References: <20200610052154.5180-1-cai@lca.pw>
 <CACT4Y+Ze=cddKcU_bYf4L=GaHuJRUjY=AdFFpM7aKy2+aZrmyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Ze=cddKcU_bYf4L=GaHuJRUjY=AdFFpM7aKy2+aZrmyQ@mail.gmail.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 10, 2020 at 07:54:50AM +0200, Dmitry Vyukov wrote:
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
> clear_[high]page are pretty extensively used in the kernel.
> We can either do this, or make clear_page non instrumented on s390 as
> well to match the existing implicit assumption. The benefit of the
> current approach is that we can find some real use-after-free's and
> maybe out-of-bounds on clear_page. The downside is that we may need
> more of these annotations. Thoughts?

Since we had already done the same thing in poison_page(), I suppose we
could do the same here. Also, clear_page() has been used in many places
on s390, and it is not clear to me if those are all safe like this.

There might be more annotations required, so it probably up to s390
maintainers (CC'ed) if they prefer not instrumenting clear_page() like
other arches.

> 
> >  BUG: KASAN: slab-out-of-bounds in __free_pages_ok
> >  Write of size 4096 at addr 000000014beaa000
> >  Call Trace:
> >  show_stack+0x152/0x210
> >  dump_stack+0x1f8/0x248
> >  print_address_description.isra.13+0x5e/0x4d0
> >  kasan_report+0x130/0x178
> >  check_memory_region+0x190/0x218
> >  memset+0x34/0x60
> >  __free_pages_ok+0x894/0x12f0
> >  kfree+0x4f2/0x5e0
> >  unpack_to_rootfs+0x60e/0x650
> >  populate_rootfs+0x56/0x358
> >  do_one_initcall+0x1f4/0xa20
> >  kernel_init_freeable+0x758/0x7e8
> >  kernel_init+0x1c/0x170
> >  ret_from_fork+0x24/0x28
> >  Memory state around the buggy address:
> >  000000014bea9f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >  000000014bea9f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >000000014beaa000: 03 fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> >                     ^
> >  000000014beaa080: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> >  000000014beaa100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> >
> > Fixes: 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options")
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  mm/page_alloc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 727751219003..9954973f89a3 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1164,8 +1164,11 @@ static void kernel_init_free_pages(struct page *page, int numpages)
> >  {
> >         int i;
> >
> > +       /* s390's use of memset() could override KASAN redzones. */
> > +       kasan_disable_current();
> >         for (i = 0; i < numpages; i++)
> >                 clear_highpage(page + i);
> > +       kasan_enable_current();
> >  }
> >
> >  static __always_inline bool free_pages_prepare(struct page *page,
> > --
> > 2.21.0 (Apple Git-122.2)
> >
