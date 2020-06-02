Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3191EC437
	for <lists+linux-s390@lfdr.de>; Tue,  2 Jun 2020 23:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgFBVR2 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 2 Jun 2020 17:17:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25742 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgFBVR1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Jun 2020 17:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591132645;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=Ylu/HiOGtyIh3U7JFEU/kaSkFMIS4f2I77a/faIj58k=;
        b=apb7WPvjn+ZpTogqKQgf9Q3eOWQwpMH0QjPyM1BP286Lp273Jz2xnmcrh9sgyocbVJ+kAY
        ehOXabtgSFgqZkkPeyxZWPFSiIwQOGp31x+7Eui7MK33yC+VwO0C6GwjN2yu9klyEGjXmH
        hRLyBBrzxCvoKZBP9/ZeYKm6NynvMX8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-4Qvoz_ZUOYKKeMODKl1mQg-1; Tue, 02 Jun 2020 17:17:20 -0400
X-MC-Unique: 4Qvoz_ZUOYKKeMODKl1mQg-1
Received: by mail-qv1-f70.google.com with SMTP id v15so1675194qvm.2
        for <linux-s390@vger.kernel.org>; Tue, 02 Jun 2020 14:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Ylu/HiOGtyIh3U7JFEU/kaSkFMIS4f2I77a/faIj58k=;
        b=KA2WPoYoZOLeJ1TzR41PUs0YZ0ueb/EXbc16Gibo8dIKRx8X4QpGQKO+6t2rtFqPPB
         nHqX9XDxzdX6ybSs7fUAKPkHw/VWRPzlfMT2ieaPcgzGnrj8rzJj717WJTtWL2Bs04lY
         qBPuEqrTOCYRj06Uzdroqxjszf8mHYyED2N69mK7Y4UG9g7h/xIAf6qcnQYxpoFw2lem
         /TYTfhse1RkocjVwddptWpvuIUaAwZhL6W8aIYdxSgSIry5OtiezFUR0YGiKay62DZMi
         VFESzqLPhU9M4ncSIpTVbqdyrD21gdkUkbT0XqddcXXIdqNLVadxODJGaVI2q1p5uXKk
         aYIw==
X-Gm-Message-State: AOAM531B2rkeuJ2ROrP/+pi51nE5yy/iG72bmD017Pu/M9GNesRRp+Bj
        IvYeCC9Jv16sFHIbf7OLB8z+A3r5GIvzI6pZt/DXO6qgs1wyen/f8Hv0QE2cthUKnsTmD4V3ZOK
        U9nRQiPV6xqtvzOJU9ZwCMQ==
X-Received: by 2002:ad4:4572:: with SMTP id o18mr4280445qvu.228.1591132639421;
        Tue, 02 Jun 2020 14:17:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjUlzm0vhI6fKGjvvF8hVsaVisMes9o90lVEfQF4r2oAsbB6iugyCZPUzy6UK1t6uFVWKiBA==
X-Received: by 2002:ad4:4572:: with SMTP id o18mr4280428qvu.228.1591132639109;
        Tue, 02 Jun 2020 14:17:19 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id l9sm3244877qki.90.2020.06.02.14.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 14:17:18 -0700 (PDT)
Date:   Tue, 2 Jun 2020 14:17:16 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 00/33] iommu: Move iommu_group setup to IOMMU core code
Message-ID: <20200602211716.mcwacflxvh7kycya@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
References: <20200414131542.25608-1-joro@8bytes.org>
 <20200529221623.qc6twmpzryh7nkvb@cantor>
 <20200601104240.7f5xhz7gooqhaq4n@cantor>
 <47711845-98ee-95b8-aa95-423a36ed9741@linux.intel.com>
 <20200602000236.j4m3jvluzdhjngdc@cantor>
 <20200602142312.GJ14598@8bytes.org>
 <20200602163806.o5dpj2tpemwdzyiw@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200602163806.o5dpj2tpemwdzyiw@cantor>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue Jun 02 20, Jerry Snitselaar wrote:
>On Tue Jun 02 20, Joerg Roedel wrote:
>>Hi Jerry,
>>
>>On Mon, Jun 01, 2020 at 05:02:36PM -0700, Jerry Snitselaar wrote:
>>>
>>>Yeah, that will solve the panic.
>>>
>>
>>If you still see the kdump faults, can you please try with the attached
>>diff? I was not able to reproduce them in my setup.
>>
>>Regards,
>>
>>	Joerg
>>
>
>I have another hp proliant server now, and reproduced. I will have the
>patch below tested shortly. Minor change, I switched group->domain to
>domain since group isn't an argument, and *data being passed in comes
>from group->domain anyways.
>

Looks like it solves problem for both the epyc system, and the hp proliant
server,

>>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>index b5ea203f6c68..5a6d509f72b6 100644
>>--- a/drivers/iommu/iommu.c
>>+++ b/drivers/iommu/iommu.c
>>@@ -1680,8 +1680,12 @@ static void probe_alloc_default_domain(struct bus_type *bus,
>>static int iommu_group_do_dma_attach(struct device *dev, void *data)
>>{
>>	struct iommu_domain *domain = data;
>>+	int ret = 0;
>>
>>-	return __iommu_attach_device(domain, dev);
>>+	if (!iommu_is_attach_deferred(group->domain, dev))
>>+		ret = __iommu_attach_device(group->domain, dev);
>>+
>>+	return ret;
>>}
>>
>>static int __iommu_group_dma_attach(struct iommu_group *group)
>>_______________________________________________
>>iommu mailing list
>>iommu@lists.linux-foundation.org
>>https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>

