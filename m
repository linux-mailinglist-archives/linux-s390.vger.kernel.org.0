Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 305631532D
	for <lists+linux-s390@lfdr.de>; Mon,  6 May 2019 19:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfEFR4b (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 6 May 2019 13:56:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39548 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfEFR41 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 May 2019 13:56:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so16235300wmk.4
        for <linux-s390@vger.kernel.org>; Mon, 06 May 2019 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgcBPgF1G8mWsEvrlCrTStioPWUfDuKosdmWCCS6E5E=;
        b=VTcOSw6DyJHMGc0Los3OPWsCksrdPWPyD8vO7tfd4hoUYxYcfmFRvdg6+xhXohcDI4
         iaPbQJh8VcU547wAZs36ZseUPhEx2n6IGa7dslufaoh80Vv9iPal8eujdbqhX47dUUCf
         rd0f8NtzfQWEGvOpMeRmdX8JSJP8cWcKcVhIbhptYXMtK+CkC+jkyMF1+0K9zUfHIWKS
         SJl54+i/RAyvIlSJFHmzstzMCaSBfFTRYRQj0rviMBg1ovVLt3DHD9KLbmEDFh5DQkUB
         K/4VUUv6V6l3X4JgKl9DsDvUKdy2qvZJaDBJBTVgKEAth7AkIIbN3tSX8f+DjWvOa5Un
         ZWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgcBPgF1G8mWsEvrlCrTStioPWUfDuKosdmWCCS6E5E=;
        b=YGM/WFQKYR+QbfgaETIRp3oVtLxaVAaBA6WIwx75I9Wg5Bs3tgSrZmYRWi/34iSexs
         ji2WxXgst0nEoCAFK6duvEqMn+kDJslEJ+Z7uXNGe9eTFtYsb1ZEleN6GdSJXw43QwVa
         BqymvMFP95thq1+UChTAOoLghEfrc7Zv58BhFMb+68fm6XVJet9Pc1PMDCFiaSoAFwLG
         7FnsvY8OFs/YD9BCi/6R8tMgZJ3oBB5Fr1f2yYA0S9/b0HUSGdS1I7HFvRkpKQls/BhB
         ekDGc6c9rhbMv8TQQ8k3MuiSV/j/HizPk7gwWawRPLtW9uIiPWoNcHiovys5uyH4r0br
         xD9Q==
X-Gm-Message-State: APjAAAX+9/ilm1fZl+NMMXOo5HT0nDJtsV4iMN0ZtllfVBCxBct3iqWn
        Zc8Bw05uWuhTucx1a5RBN91VOcDp7L6umDTUvCXwmA==
X-Google-Smtp-Source: APXvYqy6O9Hx4Xu6PpK27h5ZvwKOZrtRiCBaX5D6FeKqa43xpsoBRLSUcAf7GCThq5ov8PH4U8Kpn29YDNsu9mBVmhc=
X-Received: by 2002:a1c:2e88:: with SMTP id u130mr10259976wmu.54.1557165384862;
 Mon, 06 May 2019 10:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190430002952.18909-1-tmurphy@arista.com> <20190430002952.18909-4-tmurphy@arista.com>
 <20190430111222.GA3191@infradead.org> <da835ce2-f73e-3035-e1d7-d3028cc1a838@arm.com>
 <20190430113253.GA23210@infradead.org> <96ebb6fc-a889-fa94-09ba-65d505b85724@arm.com>
In-Reply-To: <96ebb6fc-a889-fa94-09ba-65d505b85724@arm.com>
From:   Tom Murphy <tmurphy@arista.com>
Date:   Mon, 6 May 2019 18:56:13 +0100
Message-ID: <CAPL0++61WytVhs63tvt+hdpZKXGinrkYx=4nDtNx1UoNTRWWjw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iommu/dma-iommu: Use the dev->coherent_dma_mask
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, Heiko Stuebner <heiko@sntech.de>,
        Will Deacon <will.deacon@arm.com>,
        David Brown <david.brown@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andy Gross <andy.gross@linaro.org>,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Just to make this clear, I won't apply Christoph's patch (the one in
this email thread) and instead the only change I will make is to
rename dma_limit to dma_mask.

On Tue, Apr 30, 2019 at 1:05 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 30/04/2019 12:32, Christoph Hellwig wrote:
> > On Tue, Apr 30, 2019 at 12:27:02PM +0100, Robin Murphy wrote:
> >>> Hmm, I don't think we need the DMA mask for the MSI mapping, this
> >>> should probably always use a 64-bit mask.
> >>
> >> If that were true then we wouldn't need DMA masks for regular mappings
> >> either. If we have to map the MSI doorbell at all, then we certainly have to
> >> place it at an IOVA that the relevant device is actually capable of
> >> addressing.
> >
> > Well, as shown by the patch below we don't even look at the DMA mask
> > for the MSI page - we just allocate from bottom to top.
>
> In the trivial cookie for unmanaged domains, yes, but in that case the
> responsibility is on VFIO to provide a suitable (i.e. sub-32-bit)
> address range for that cookie in the first place. In the managed case,
> allocation uses the streaming mask via iommu_dma_get_msi_page() calling
> __iommu_dma_map(). Admittedly the mask can then get overlooked when
> reusing an existing mapping, which strictly could pose a problem if you
> have multiple devices with incompatible masks in the same group (and
> such that the PCI stuff doesn't already mitigate it), but that's such an
> obscure corner case that I'm reticent to introduce the complication to
> handle it until it's actually proven necessary.
>
> Robin.
