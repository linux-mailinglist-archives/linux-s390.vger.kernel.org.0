Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9523328FFB2
	for <lists+linux-s390@lfdr.de>; Fri, 16 Oct 2020 10:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405002AbgJPIDz (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 16 Oct 2020 04:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404996AbgJPIDx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 16 Oct 2020 04:03:53 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF69C0613D5
        for <linux-s390@vger.kernel.org>; Fri, 16 Oct 2020 01:03:52 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id h10so1492094oie.5
        for <linux-s390@vger.kernel.org>; Fri, 16 Oct 2020 01:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=INEWr2CP3X204G2+3BdRku1fQyrBAx5gcE6UKT3OyOY=;
        b=PYscHGENn896fSGfivBibPnplvLtnL/b2OJMTMD4dpMHQHxNw+64iWRis9sD2nvJ3L
         GOV/hMMVbuuc/Dh9AKUrk63GN8LOY99ye984UM1brrmBjSpje4c9K1cdtapwwULr3uYK
         5a7sZUI60W2i8WwwI8UzzVDb5t1NNMYrEKGHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=INEWr2CP3X204G2+3BdRku1fQyrBAx5gcE6UKT3OyOY=;
        b=rAWqeYrK4Z3aDaRDbY30JLFYQ4F1+BrQGgqv0/Hd5esp+r2qZmtf7T+WIOm7MivkAa
         BMGF2zr3SxFGVYl5b9ooXsbJZgdlKyYRSD2LfEyaYYclvukyCwk3R6OtIjV8DV28Nm0n
         ibcrcSxarG3A2eNFDEmWCW2pfjbM4d0aokfam2EmE1lopiFbYR0/KTEz9elStPDJomss
         UUs9NDLOqsWUTmFPSvzJGj6NUmxoe7yZHSU0PMu4tb8aWS+z7etf/l5jr1oX7u6eLBe0
         0T983q8FjynSRKjkcWRVwbvm4kgnGK9p3YSkvHTQGXvHYHgPhb0aviWEZi64hdnaNiEJ
         usKQ==
X-Gm-Message-State: AOAM533UwRVj41iD4ss0vIJGR66tgI4RmSFlkaT98Le0t3KXORXpsgoQ
        8ddlScnvLg6Poe+Ice4Egq9P2RwFFuoCPwVJoLhIig==
X-Google-Smtp-Source: ABdhPJyggtVpJqRzRZN6iIJJ0+C7Hddh3AOv25V3h7tJwuwrOe4WsT5egHelZJkzdhhjjawKTJeCGzwdsP8tFNIJ4dY=
X-Received: by 2002:aca:cc01:: with SMTP id c1mr1679690oig.128.1602835431410;
 Fri, 16 Oct 2020 01:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-6-daniel.vetter@ffwll.ch> <4685181e-8306-0d96-8be6-592b3c563cbf@nvidia.com>
In-Reply-To: <4685181e-8306-0d96-8be6-592b3c563cbf@nvidia.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 16 Oct 2020 10:03:40 +0200
Message-ID: <CAKMK7uEoM3vM9X-R6dAHPAqdKryMtj2BOoBbJwJR9mCwNSpQ1g@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] mm/frame-vector: Use FOLL_LONGTERM
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Oct 16, 2020 at 9:54 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 10/9/20 12:59 AM, Daniel Vetter wrote:
> ...
> > @@ -48,40 +47,25 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
> >
> >       start = untagged_addr(start);
> >
> > -     mmap_read_lock(mm);
> > -     locked = 1;
> > -     vma = find_vma_intersection(mm, start, start + 1);
> > -     if (!vma) {
> > -             ret = -EFAULT;
> > -             goto out;
> > -     }
> > -
> > -     /*
> > -      * While get_vaddr_frames() could be used for transient (kernel
> > -      * controlled lifetime) pinning of memory pages all current
> > -      * users establish long term (userspace controlled lifetime)
> > -      * page pinning. Treat get_vaddr_frames() like
> > -      * get_user_pages_longterm() and disallow it for filesystem-dax
> > -      * mappings.
> > -      */
> > -     if (vma_is_fsdax(vma)) {
> > -             ret = -EOPNOTSUPP;
> > -             goto out;
> > -     }
> > -
> > -     if (!(vma->vm_flags & (VM_IO | VM_PFNMAP))) {
> > +     ret = pin_user_pages_fast(start, nr_frames,
> > +                               FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
> > +                               (struct page **)(vec->ptrs));
> > +     if (ret > 0) {
>
> None of the callers that we have today will accept anything less than
> ret == nr_frames. And the whole partially pinned region idea turns out
> to be just not useful for almost everyone, from what I recall of the gup/pup
> call sites. So I wonder if we should just have get_vaddr_frames do the
> cleanup here and return -EFAULT, if ret != nr_frames ?

Yeah I noticed that the calling convention here is a bit funny. But I
with these frame-vector helpers now being part of drivers/media it's
up to media folks if they want to clean that up, or leave it as is.

If this would be in drm I'd say we'll have the loud warning and
tainting due to CONFIG_STRICT_FOLLOW_PFN=n for 2-3 years. Then
assuming no big complaints showed up, rip it all out and just directly
call pup in each place that wants it (like I've done for habanalabs
and exynos).
-Daniel


--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
