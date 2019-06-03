Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8183032E9B
	for <lists+linux-s390@lfdr.de>; Mon,  3 Jun 2019 13:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfFCL1t (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 3 Jun 2019 07:27:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36248 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbfFCL1t (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Jun 2019 07:27:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id a3so719484pgb.3
        for <linux-s390@vger.kernel.org>; Mon, 03 Jun 2019 04:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yge3w9rHbWgvobFZbFOeEgA2IlTICZ6Y6fbhlA0nby0=;
        b=Y+yacQIvPCAiHgjTQHZU0FVoG9I2CbtFWh1hmP9jN5AY8VLFjiX+k6xtFzH0HNGzit
         O8+HuDE7HRrRPCKpVtBjzFEjUib45UJWNrACrI5dtMn5dhL7BYlOQviAmeCacyysnT/n
         Xvty8zwlPZ+u8dVb5gfg1+6bj4mdWhGmOj9ZV4LWheZdjBeBpOVrxXrNWXT+AbiGMNl2
         Yu+vBF4TlQWGZi8Dq4zfPpETqkKfLGxVZb/314XRDJcA/hQwkyrur5b+hi4Dx4U2BziM
         nnSr7BJ7sU2o9o3B6SunhLofFsrm83s3EU1wt5ZiCI98JrmP0w6INx6y8G5bvgNUiRxA
         ZVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yge3w9rHbWgvobFZbFOeEgA2IlTICZ6Y6fbhlA0nby0=;
        b=TIsSuLY14fJGhy+EgSsezElgu+hfj07tYHhfdQ/N1OBoHZlgSDx4ZAaLZDdtyLPuoS
         K4Wd3cYquRPsXGFFa8MuD2nPlr8ze4bqFXCsncxWmU1JdJ6haYr+fGge7DqVKrxPc0hr
         VmK+g+Ru16DK5EwV8TxyvJEuRg/Sh0F8uQVZMI23WMMw1L3NY4947WS+dzLv3XJ9xOyW
         xF9H7Mceyal1WgCdxtbMJQx1W2ne3jonrxO76HzHS/YfJountp0Otws7XXk/nYjOq4Rc
         Yck2ClPQd5M7I4XQjGplDTuMzaVPW1BYFzfe9hQuAeynJhxhcrSEVvAEVH87LSG13pkD
         ub9Q==
X-Gm-Message-State: APjAAAU8yi+8Tf65RbYoL0mhwkAnjoBprJK1uBLYG0DaRloMA/a+hjiU
        ugBcPrXFRY50X6/t8lr2LDVdZXZCct5YhQyhl2Bc/A==
X-Google-Smtp-Source: APXvYqzSN6KszB00jgSY5jsJHGaLYRRvYWrgtbKYUHrE3f1JWTjJzTyKXde3mFVwC5OO8+m15yXDYPFToKa7arJ98wc=
X-Received: by 2002:a62:4d03:: with SMTP id a3mr30832487pfb.2.1559561268802;
 Mon, 03 Jun 2019 04:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190506185207.31069-1-tmurphy@arista.com> <20190603105158.GL12745@8bytes.org>
In-Reply-To: <20190603105158.GL12745@8bytes.org>
From:   Tom Murphy <tmurphy@arista.com>
Date:   Mon, 3 Jun 2019 12:27:37 +0100
Message-ID: <CAPL0++72dekt=re1=sTWpCJtMX=mUOc3Jcq=9d1sr1QO25_zFA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] iommu/amd: Convert the AMD iommu driver to the
 dma-iommu api
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 3, 2019 at 11:52 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> Hi Tom,
>
> On Mon, May 06, 2019 at 07:52:02PM +0100, Tom Murphy wrote:
> > Convert the AMD iommu driver to the dma-iommu api. Remove the iova
> > handling and reserve region code from the AMD iommu driver.
>
> Thank you for your work on this! I appreciate that much, but I am not
> sure we are ready to make that move for the AMD and Intel IOMMU drivers
> yet.
>
> My main concern right now is that these changes will add a per-page
> table lock into the fast-path for dma-mapping operations. There has been
> much work in the past to remove all locking from these code-paths and
> make it scalable on x86.

Where is the locking introduced? intel doesn't use a lock in it's
iommu_map function:
https://github.com/torvalds/linux/blob/f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a/drivers/iommu/intel-iommu.c#L5302
because it cleverly uses cmpxchg64 to avoid using locks:
https://github.com/torvalds/linux/blob/f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a/drivers/iommu/intel-iommu.c#L900
And the locking in AMD's iommu_map function can be removed (and i have
removed it in my patch set) because it does that same thing as intel:
https://github.com/torvalds/linux/blob/f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a/drivers/iommu/amd_iommu.c#L1486

Is there something I'm missing?

>
> The dma-ops implementations in the x86 IOMMU drivers have the benefit
> that they can call their page-table manipulation functions directly and
> without locks, because they can make the necessary assumptions. The
> IOMMU-API mapping/unmapping path can't make these assumptions because it
> is also used for non-DMA-API use-cases.
>
> So before we can move the AMD and Intel drivers to the generic DMA-API
> implementation we need to solve this problem to not introduce new
> scalability regressions.
>
> Regards,
>
>         Joerg
>
