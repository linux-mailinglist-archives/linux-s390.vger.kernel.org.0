Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B1828B830
	for <lists+linux-s390@lfdr.de>; Mon, 12 Oct 2020 15:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbgJLNuG (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 12 Oct 2020 09:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389837AbgJLNtT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 12 Oct 2020 09:49:19 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC4DC0613D5
        for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2020 06:49:19 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id q21so15848106ota.8
        for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2020 06:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8X09Z4RduZw54E7UULyfcMVsq59sUX38yzJavXEvAuQ=;
        b=OxcKeNhvQoR0L8nxbCn1cXzOLqpqQBDfywbnUKwin8fP1jeNNo8TXGjdlV3i/RFefc
         kiDn5u8kWGFx2VxB985ageHcqSHKlzq4zLw3IXCA9ks8vIzNebZc3IQZx/DZrDgmJSXd
         NsUKEksWwYQT7XMaHoiEwCdO/DkttVP0ejuaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8X09Z4RduZw54E7UULyfcMVsq59sUX38yzJavXEvAuQ=;
        b=uligV65elPJyq4BjhbHJ2hdjYD7ztEVSVARXfb/KePm9FQ9D52LjoG39glBsf7C1M1
         fkTmCPNUSc4BW9ZAamHuBEGxXFcoMseoAxUgfCwzDdFYRgaP+icYZQUbK87JIpwYiG7B
         iPWVHuxHO0Vo9rVoHtahYEIfVbwjH1pb62VITJLhqqbx9tzUkQppLTBliwDh8ibSfFSp
         1uGbB0CNLLm4tP6YQH4V9jKUlOEZLKHHmm8yeTpszgw82LPQ4Si2plQQ+BK0hCM89UYY
         Y9etQPX97KFsQuBZgfQSch2E+JRGDd8Ru88tXLruvBInVr8PRvG5389OxtzfcmzpV0F1
         rtNg==
X-Gm-Message-State: AOAM531vNbLAuk5733wIH7P6Ce8aIQ6mQttsVwTXXQUCFkiDzd8iFQ9s
        pWmvDrcgOPq8ygnFqh/Pd4SAzQc9W8iuRneKUZNN4w==
X-Google-Smtp-Source: ABdhPJx2SbzoAtarumY1qTqnmUTVH9IgcM13EmZUSL9fGwCe3viWjRc3PXrzmY6z+PXG92wLIZXLR8i7oO5kJrgMePc=
X-Received: by 2002:a05:6830:8b:: with SMTP id a11mr7008058oto.303.1602510558346;
 Mon, 12 Oct 2020 06:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-10-daniel.vetter@ffwll.ch> <20201009123421.67a80d72@coco.lan>
 <20201009122111.GN5177@ziepe.ca> <20201009143723.45609bfb@coco.lan>
 <CGME20201009124900eucas1p26c93caa29c9925f1eef9be9ff7c6c65c@eucas1p2.samsung.com>
 <20201009124850.GP5177@ziepe.ca> <ed68968b-27bc-d776-8da8-ef21d6b3c378@samsung.com>
In-Reply-To: <ed68968b-27bc-d776-8da8-ef21d6b3c378@samsung.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 12 Oct 2020 15:49:07 +0200
Message-ID: <CAKMK7uGLOubJrr9A=usxkoVx+nXDW3bxhykfeU-TYXTUZyBoeQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/17] mm: Add unsafe_follow_pfn
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 12, 2020 at 12:47 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Jason,
>
> On 09.10.2020 14:48, Jason Gunthorpe wrote:
> > On Fri, Oct 09, 2020 at 02:37:23PM +0200, Mauro Carvalho Chehab wrote:
> >
> >> I'm not a mm/ expert, but, from what I understood from Daniel's patch
> >> description is that this is unsafe *only if*  __GFP_MOVABLE is used.
> > No, it is unconditionally unsafe. The CMA movable mappings are
> > specific VMAs that will have bad issues here, but there are other
> > types too.
>
> I'm trying to follow this thread, but I really wonder what do you mean
> by CMA movable mappings? If a buffer has been allocated from CMA and
> used for DMA, it won't be moved in the memory. It will stay at the same
> physical memory address all the time until freed by the owner. It just a
> matter of proper usage count tracking to delay freeing if it is still
> used somewhere.

 Yup. The problem is that this usage count tracking doesn't exist. And
drivers could at least in theory treat CMA like vram and swap buffers
in&out of it, so just refcounting the userspace vma isn't enough. In
practice, right now, it might be enough for CMA drivers though (but
there's more that's possible here).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
