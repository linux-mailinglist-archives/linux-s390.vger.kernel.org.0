Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E808E9E9
	for <lists+linux-s390@lfdr.de>; Thu, 15 Aug 2019 13:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbfHOLN5 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 15 Aug 2019 07:13:57 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41751 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbfHOLN5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 15 Aug 2019 07:13:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id o101so5005291ota.8
        for <linux-s390@vger.kernel.org>; Thu, 15 Aug 2019 04:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IuWtIDr90zkI+XfebKnko5l+I/4xHf39ovWKoeqGaCw=;
        b=nNQ/UtAXFhxaaxM9xQ9O8IFhMDMFvXunujEOMrSPWYCvTGD+YxkdrSxxRuus/GVUBp
         GQoOAQizlE7KESwvt/hZDxMbEejumbr3zlWb4gT62uRTJXHWvWtJR7eaSmt+P/Feob0G
         3FUQTPCC4U1ru+VC9jVwEnwjC7mL9mTGXdSrv0YV/tjgkZ9zqojYrqsx+I/zHyMAQt8f
         8tY1ausOgFce7Ab8S1UDh3376evaQbzs8AquCZCJWaLZvUFdMNaMr4YLxIusv5ITVmeU
         i1/FqeHC8FIMWswYm99EVT/8f/U+y5anena34TtOtJsjHhUYQi17LOqEs6UTPxD4ON1T
         NLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IuWtIDr90zkI+XfebKnko5l+I/4xHf39ovWKoeqGaCw=;
        b=JPQ1mtgD8or0Ni4V6V/HuuoTkl0dJjzOGabPX7JcAxACH8Iu8JTYPu+VS8ok+2zIBj
         5iB2HCd6r7S1rB40PcvlPjIvJC2nOUAf89mQcAiD2UWcycKAm2111AVJ2uiuanJX5yL6
         y/Falr539nXoTlq8bwfTuItTUQUN20PFQkti6RolJ1xuGFqC+7JZKBVbIdjjNf6Ny/2T
         b38AesVTZ67hXvUcsDtRx1MRKCrtSqAn719ksD1/T6rLLCANaIH9+8i2lDiEOEAeKxNa
         PCzgbbpo43qKHj4Of0rtxlAfwpkX2oKEJ8B+PR6gjxynJN9iClFeN0/Z6DFE499aU2Kt
         MVqA==
X-Gm-Message-State: APjAAAW05Q7UdikH3G2rVvAP1FJ377kVGWcHYdc1FSoUkvrlYIoBuNp8
        N7FwI7dHAq4RT/K3q39VUOfN2D8NcI+Iu2l+gHekng==
X-Google-Smtp-Source: APXvYqyLPDKvvPTRbvGbWfWW/U8q2MBMOdJm/HCo2dFUBkYNWHxXuaIDP3Rx+nIt9imUtzeQRmZpWsoqqA6dgyl5YCA=
X-Received: by 2002:a5e:9314:: with SMTP id k20mr5014873iom.235.1565867636592;
 Thu, 15 Aug 2019 04:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190613223901.9523-1-murphyt7@tcd.ie> <20190624061945.GA4912@infradead.org>
 <20190810071952.GA25550@infradead.org> <CALQxJuvxBc3MH3_B_fZ3FvURHOM3F3dvvZ6x=GtALUAvyu7Qxw@mail.gmail.com>
 <20190813130711.GA30468@infradead.org>
In-Reply-To: <20190813130711.GA30468@infradead.org>
From:   Tom Murphy <murphyt7@tcd.ie>
Date:   Thu, 15 Aug 2019 12:13:45 +0100
Message-ID: <CALQxJusdvvnL-7WuCy9qobB6heG2oj7XS4Bs3Z1dMyLXSeZOzg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] iommu/amd: Convert the AMD iommu driver to the
 dma-iommu api
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>,
        Will Deacon <will.deacon@arm.com>,
        virtualization@lists.linux-foundation.org,
        David Brown <david.brown@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Done, I just sent it there. I don't have any AMD hardware to test on
while I'm traveling. However the rebase was very straightforward and
the code was tested a month ago on the old linux-next.

I only have the AMD conversion done. I will work on rebasing the intel
one when I get a chance.

On Tue, 13 Aug 2019 at 14:07, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Aug 13, 2019 at 08:09:26PM +0800, Tom Murphy wrote:
> > Hi Christoph,
> >
> > I quit my job and am having a great time traveling South East Asia.
>
> Enjoy!  I just returned from my vacation.
>
> > I definitely don't want this work to go to waste and I hope to repost it
> > later this week but I can't guarantee it.
> >
> > Let me know if you need this urgently.
>
> It isn't in any strict sense urgent.  I just have various DMA API plans
> that I'd rather just implement in dma-direct and dma-iommu rather than
> also in two additional commonly used iommu drivers.  So on the one had
> the sooner the better, on the other hand no real urgency.
