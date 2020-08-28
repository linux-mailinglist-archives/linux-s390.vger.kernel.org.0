Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B0925519B
	for <lists+linux-s390@lfdr.de>; Fri, 28 Aug 2020 01:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgH0Xe4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 27 Aug 2020 19:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgH0Xey (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 27 Aug 2020 19:34:54 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE59C061232
        for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2020 16:34:53 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c6so6362536ilo.13
        for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2020 16:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WedloSq7WEmmdLIoMis0OnTbQ3vwipQyHuMeYXqSrtc=;
        b=z5afeT1uAO8r4nUnyvdyA9XOFk/fx4rNEV7OzYIxSzIyRPXSSuP0kLR0uFLb5b32/u
         2F9MWfvV9WNZ+AXIi+QLZ8p0NAvNTBNro8XHBAkvaJyY3ufO9Q62GJ4oCd3Mw0z1agKr
         qFAx/HdJ+EmG1djyMZ9CSGcKQmWFu/zVKz5vJDxg6Nx++SMMng1dGMX9Fmd/wZDTKzHU
         hK7p1r057Z3QOjx4Tgjjmk5k/beu18E/9gkjDnfpmsN6+7UO8xqzHsjZBJhd37zZ1RdM
         prBipf1AI2muUbFcyfU3La5FJDcrT8wuyB+danzKbVnftQC2AzrWmBaIjshroZB9Cb96
         Llhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WedloSq7WEmmdLIoMis0OnTbQ3vwipQyHuMeYXqSrtc=;
        b=X93XkVLGeQbAa2Wk1vTQcNX8NsocZh1o1PA5TslcU40NFpUKtUEQ4IhwTsDt3RdxtA
         jp7MbGX0SJSLpWfPet+2oFmVo2PX2+dWuSFMbfAL87AJqU04BAl6NZaQrONnddyJKKfS
         6jrBHWogwmb00aBHChn5gLxQoYoK/guwnF8B+Kgpi/D8RhLFJihbAnOFPzudvg91pGtM
         /jA5u5NmtRZtTfD7vs8ftR/pd0tk0+cp2454A8b1eSqJrUZtJ8cZCBvQ53b1kJvWY9w6
         oBiW8Nnf1YF4RXJZZl/o6YiGZ5UgymlzoYPCogxnRTmZQX1LQ9fqZrsvOz+l5efbhP+g
         1FkA==
X-Gm-Message-State: AOAM533MRrumrlhfpz4nXmCztW3qcJHtua5KQD0U5CGbaUx4kR3Sw34g
        r6swGR86A5ft7ZBH0NfagwLIdObtPkZCipZLUqCcLw==
X-Google-Smtp-Source: ABdhPJw0W2KNMSiVDCp6qP+D3bxqQi5szrf3hiteZz0kvkkYuvF0+Qn7lDLtjb0Ko+kJMcKtvMnZ3YU+iAfoJmlGVTk=
X-Received: by 2002:a92:4f:: with SMTP id 76mr18588367ila.11.1598571293162;
 Thu, 27 Aug 2020 16:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191221150402.13868-1-murphyt7@tcd.ie> <465815ae-9292-f37a-59b9-03949cb68460@deltatee.com>
 <20200529124523.GA11817@infradead.org> <CGME20200529190523eucas1p2c086133e707257c0cdc002f502d4f51d@eucas1p2.samsung.com>
 <33137cfb-603c-86e8-1091-f36117ecfaf3@deltatee.com> <ef2150d5-7b6a-df25-c10d-e43316fe7812@samsung.com>
 <b9140772-0370-a858-578c-af503a06d8e9@deltatee.com> <CALQxJuutRaeX89k2o4ffTKYRMizmMu0XbRnzpFuSSrkQR02jKg@mail.gmail.com>
 <766525c3-4da9-6db7-cd90-fb4b82cd8083@deltatee.com>
In-Reply-To: <766525c3-4da9-6db7-cd90-fb4b82cd8083@deltatee.com>
From:   Tom Murphy <murphyt7@tcd.ie>
Date:   Fri, 28 Aug 2020 00:34:41 +0100
Message-ID: <CALQxJuuS8KKUX_eWWSE81gsq5ePAETB-FoqRUSWFfqgr+B13gg@mail.gmail.com>
Subject: Re: [PATCH 0/8] Convert the intel iommu driver to the dma-iommu api
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Julien Grall <julien.grall@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-mediatek@lists.infradead.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-tegra@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 27 Aug 2020 at 22:36, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2020-08-23 6:04 p.m., Tom Murphy wrote:
> > I have added a check for the sg_dma_len == 0 :
> > """
> >  } __sgt_iter(struct scatterlist *sgl, bool dma) {
> >         struct sgt_iter s = { .sgp = sgl };
> >
> > +       if (sgl && sg_dma_len(sgl) == 0)
> > +           s.sgp = NULL;
> >
> >         if (s.sgp) {
> >             .....
> > """
> > at location [1].
> > but it doens't fix the problem.
>
> Based on my read of the code, it looks like we also need to change usage
> of sgl->length... Something like the rough patch below, maybe?
>
> Also, Tom, do you have an updated version of the patchset to convert the
> Intel IOMMU to dma-iommu available? The last one I've found doesn't
> apply cleanly (I'm assuming parts of it have been merged in slightly
> modified forms).
>

I'll try and post one in the next 24hours

> Thanks,
>
> Logan
>
> --
>
> diff --git a/drivers/gpu/drm/i915/i915_scatterlist.h
> b/drivers/gpu/drm/i915/i915
> index b7b59328cb76..9367ac801f0c 100644
> --- a/drivers/gpu/drm/i915/i915_scatterlist.h
> +++ b/drivers/gpu/drm/i915/i915_scatterlist.h
> @@ -27,13 +27,19 @@ static __always_inline struct sgt_iter {
>  } __sgt_iter(struct scatterlist *sgl, bool dma) {
>         struct sgt_iter s = { .sgp = sgl };
>
> +       if (sgl && !sg_dma_len(s.sgp))
> +               s.sgp = NULL;
> +
>         if (s.sgp) {
>                 s.max = s.curr = s.sgp->offset;
> -               s.max += s.sgp->length;
> -               if (dma)
> +
> +               if (dma) {
> +                       s.max += sg_dma_len(s.sgp);
>                         s.dma = sg_dma_address(s.sgp);
> -               else
> +               } else {
> +                       s.max += s.sgp->length;
>                         s.pfn = page_to_pfn(sg_page(s.sgp));
> +               }
>         }
>
>         return s;
