Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55DA2958B7
	for <lists+linux-s390@lfdr.de>; Thu, 22 Oct 2020 09:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504736AbgJVHA7 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 22 Oct 2020 03:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504799AbgJVHA5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 22 Oct 2020 03:00:57 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26288C0613D4
        for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2020 00:00:56 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id f8so351695oij.10
        for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2020 00:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2r/6zOf2kRDD4tSmvaZuCPU8DwfuIowf0YjaeLwP4Nk=;
        b=et6ZBeQFHerVGVhgtgtRrYMM/XKZjx8P9HBSzQAYN1qwBLnRqWCR1692Hd2N6mG2QH
         DRodjxUs0g/udks4HbxzEysdS3iPEQ/WX4sYQzu415V2h1QQT1XnQSq/3dWFguLdKkzI
         zrJA18zci4a+rkwc8KCUbQtvVEViy3ghNPANM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2r/6zOf2kRDD4tSmvaZuCPU8DwfuIowf0YjaeLwP4Nk=;
        b=WopRR2P2EPAOoivaOAdLq5D2fBd13MNihieehscGasejMASQv/wgWWmFWvg8uKYz+H
         WygVlk+CNSkXrP1hIPfQmNCO0NWsyede1IuL6Ot7hB5NHNnjf2KoaD8yh06cc8MnauVg
         vb6YGF7iISJiAK6ZDpXRUcUvOV4KfxPK8+wt8EaCyifWfKzVyU/nnToqVHsEt37uNc9k
         +GfJEMyVWbyh9OK5GFSZbyEN9cQCcXDm3jDxDXFVHJAPeGjapxdJsfF56+hHHi9pHrMA
         6gJzfBTSe95iCTKH99NQX4PLZOMtPn5AUp5uMW8Ktd+hLVCscIpU/io9IdD9cvCl7zQg
         Z1Lw==
X-Gm-Message-State: AOAM533e3YQrnLdnzxhkHeSIRwgjDz8pczyIg35HTplX4CNxIC+2vSEV
        UoStxAdLjlcTya/V22lbvMIRljfGwXDL94J2IdTNFg==
X-Google-Smtp-Source: ABdhPJw2FIAzZzMzBC6IGQ2084OMcZPDQegSMdZ1Ud1eEaxA84bu8yPrNPLWUQWDUUxTjx4XtxIOFs49Df+sZwbm0Kw=
X-Received: by 2002:aca:cc01:: with SMTP id c1mr631463oig.128.1603350055185;
 Thu, 22 Oct 2020 00:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201021085655.1192025-1-daniel.vetter@ffwll.ch>
 <20201021085655.1192025-13-daniel.vetter@ffwll.ch> <20201021125030.GK36674@ziepe.ca>
 <CAKMK7uEWe8CaT7zjcZ6dJAKHxtxtqzjVB35fCFviwhcnqksDfw@mail.gmail.com>
 <20201021151352.GL36674@ziepe.ca> <CAKMK7uGq0=ks7Zj1Et44k7x9FwE9u_ua4zANSqrLRri0v01V+Q@mail.gmail.com>
 <20201021163702.GM36674@ziepe.ca> <CAKMK7uEjE5sHUq0hV_bnYjPKRxYyBnty0sLre+owANGZjLJg9Q@mail.gmail.com>
 <20201021232022.GN36674@ziepe.ca>
In-Reply-To: <20201021232022.GN36674@ziepe.ca>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 22 Oct 2020 09:00:44 +0200
Message-ID: <CAKMK7uEkAK42+19KRo06XzJFuMCVriEEg0jxqXq8oAdt2ExLsQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] PCI: Obey iomem restrictions for procfs mmap
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Oct 22, 2020 at 1:20 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Oct 21, 2020 at 09:24:08PM +0200, Daniel Vetter wrote:
> > On Wed, Oct 21, 2020 at 6:37 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Wed, Oct 21, 2020 at 05:54:54PM +0200, Daniel Vetter wrote:
> > >
> > > > The trouble is that io_remap_pfn adjust vma->pgoff, so we'd need to
> > > > split that. So ideally ->mmap would never set up any ptes.
> > >
> > > /dev/mem makes pgoff == pfn so it doesn't get changed by remap.
> > >
> > > pgoff doesn't get touched for MAP_SHARED either, so there are other
> > > users that could work like this - eg anyone mmaping IO memory is
> > > probably OK.
> >
> > I was more generally thinking for io_remap_pfn_users because of the
> > mkwrite use-case we might have in fbdev emulation in drm.
>
> You have a use case for MAP_PRIVATE and io_remap_pfn_range()??

Uh no :-) But for ioremaps and keep track of which pages userspace has
touched. Problem is that there's many displays where you need to
explicitly upload the data, and in drm we have ioctl calls for that.
fbdev mmap assumes this just magically happens. So you need to keep
track of write faults, launch a delayed worker which first re-protects
all ptes and then uploads the dirty pages. And ideally we wouldn't
have to implement this everywhere just for fbdev, but could wrap it
around an existing mmap implementation by just intercepting mkwrite.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
