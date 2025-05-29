Return-Path: <linux-s390+bounces-10864-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AA1AC834F
	for <lists+linux-s390@lfdr.de>; Thu, 29 May 2025 22:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90172A40861
	for <lists+linux-s390@lfdr.de>; Thu, 29 May 2025 20:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E4929345A;
	Thu, 29 May 2025 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XIvqNns9"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316B328E56B
	for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748551584; cv=none; b=eWewVQRo/GrbTY/+9OSIgatSpRQvM69SbdwqRYUwTHf05jIYgShdnRFUWdbELMzIcwdkOGe6f2Pz+bqA5okCaV5r4DFVzJUzRT3IcYi1Ykp8SlvCQoqULRWRiHzqoBbNl1epo1b4yevsYtSCexQgYxylvt7sckKPFDp6MygbUMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748551584; c=relaxed/simple;
	bh=/6z1v/qNBfUFOoxicD1V48QdZQfp4IVH4S3L1yiqKHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GG/v2WNJjHQJxtGTpNnqkmK58a4+V4yJbrmeT3r6tweIDOuvcBlfvjNeEpeXAarg+K0eTI+Qoy4khcaCp8c3wj/3fomzADpLubVg5qubQyDi/28ScPTOopBk1LnNZTmUwLsQhxd5zjaROm/UdM26LcvgnoiwSZA84Ujf6WdRHyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XIvqNns9; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso983844a91.2
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1748551581; x=1749156381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6TtaMd1HywfsuyRcNH/42AXM3iz/qus8mLnXbozVUkA=;
        b=XIvqNns9ls/HGWvWQNu791RDA+NMA/YEPxyggEhVbL2i+z4BXfGCTpY52IwPgra9FR
         d1nN6q5UEyqlfXLtzpmbgCycsZqlJS77ZGVQwjxfqRRxYz8/iduVhtR4rR+75I0Boa2M
         GbIfASXNfsS8lh1k49srFIfuXeZy439ELQVnqPpABa8uTRERxvt5T3mkBvWyChbub969
         KecqPD0gn/3PPWUqnQ8g3HIUuWYlICf833vlxY4RUNnTo4nMLlizX5sSP0GG9y++98P3
         ocnHf7RM5v0M4SuEeJtuf6crf48EKIjY8EUO8ks+d0MjXoKoH79KiLc5SPN3uwPD70In
         LVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748551581; x=1749156381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TtaMd1HywfsuyRcNH/42AXM3iz/qus8mLnXbozVUkA=;
        b=ZY9lBqURu8HNfnFfbB6We+KMGvnnfURRQKddvWLxUP8QNd94oF6FxsjsM1OH+C3KqP
         XhCcfo1L/zcWjSmDh5VAWuWg3piBNFrrhNa2JxK4k+97hKcCaP3p9Keyyb+ZX1lftsD4
         nXpkX2w29ifSjvq5bMFAN7gdOHMZzg9X8YU1mFb8OuX+J4yySSCeROZ6iJ//O6vjB7pi
         0U6BoemX/M1QrIvyEfS9y+yU2AZulZr1FABoypdfXVECZpYI2MvvX7RjfIh7XUdYfKzF
         ki5SeR906YdDtLaWTXMARQeIf3CmFaOK3ZJ2ML++guBdQwF/Nd7yCrXHxlMs4iEL+CIA
         NjVw==
X-Forwarded-Encrypted: i=1; AJvYcCUK8MN6Rl4E0pzBtLvXSx2dXVPqqUizRP0izvyd+p2Rc5SxypKSAX40XgMeMeCQ6RGkHwWdqqi9bJf2@vger.kernel.org
X-Gm-Message-State: AOJu0YzzugKLfJFcd0/0eRfLV2edui0cllQAa6XsLHq9KqeNcIvoHvg0
	wyZ2lWodNDpXMrKzNEoAUn7GSRDRmp8S6Exy5qTLFzqC17hZ8AnIuxZZAcrCQB45hPc=
X-Gm-Gg: ASbGncuvPKpiLqEiAHiDhcztaxluuRymJpT2qMAQiPtG9ldfYVlz7Jy4aKjs7zKwBzw
	DaDFQJM90OSE+h1pHvwUjLNKP72j3IrX1wS+sSknFrvMaQfyZw2xacosuLCfkD7hQcE5M/ozuNb
	euUKB3GKatDXHO6r5rpkcDMEy6s++5+aiP6mSVqHQrDqy1X+RM4nSOPkDyxvI05Tj2mX+c0/wiX
	7bm7eQtGF+gS02yBueKTuMxMP/vep6SiAJSqntkEGeKpCY8isb5de6R3YSlf/4yuukh8TzmhQLv
	meX6I8ua28Ub8y8OGLEJ4/t/6J5VYgAOEgRo9A0xvNpi9Sd+7bxJgvmIFFzuylXu7f+2LA==
X-Google-Smtp-Source: AGHT+IEO8HwssTrnrLL8DGNfi7UDT2JfkJIUURFRStahz0gCmflYidew8g3m8w3QvBPF+GZDsBP2sw==
X-Received: by 2002:a17:90b:1d89:b0:311:f99e:7f51 with SMTP id 98e67ed59e1d1-312415329famr1432137a91.18.1748551581341;
        Thu, 29 May 2025 13:46:21 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd9486sm16245345ad.67.2025.05.29.13.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 13:46:20 -0700 (PDT)
Date: Thu, 29 May 2025 13:46:17 -0700
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Alim Akhtar <alim.akhtar@samsung.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
	Janne Grunau <j@jannau.net>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Neal Gompa <neal@gompa.dev>, Orson Zhai <orsonzhai@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Clark <robdclark@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Sven Peter <sven@svenpeter.dev>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, virtualization@lists.linux.dev,
	Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, patches@lists.linux.dev
Subject: Re: [PATCH 3/7] iommu: Remove ops.pgsize_bitmap from drivers that
 don't use it
Message-ID: <aDjHmR7ZVTbsSITO@tjeznach.ba.rivosinc.com>
References: <0-v1-7c5282b0c334+2db-iommu_rm_ops_pgsize_jgg@nvidia.com>
 <3-v1-7c5282b0c334+2db-iommu_rm_ops_pgsize_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3-v1-7c5282b0c334+2db-iommu_rm_ops_pgsize_jgg@nvidia.com>

On Tue, Apr 29, 2025 at 11:34:13AM -0300, Jason Gunthorpe wrote:
> These drivers all set the domain->pgsize_bitmap in their
> domain_alloc_paging() functions, so the ops value is never used. Delete
> it.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/apple-dart.c       | 1 -
>  drivers/iommu/intel/iommu.c      | 1 -
>  drivers/iommu/iommufd/selftest.c | 1 -
>  drivers/iommu/riscv/iommu.c      | 1 -
>  drivers/iommu/virtio-iommu.c     | 6 ++----
>  5 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index bb57092ca90110..2d0d31ba28860a 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1533,7 +1533,6 @@ static void riscv_iommu_release_device(struct device *dev)
>  }
>  
>  static const struct iommu_ops riscv_iommu_ops = {
> -	.pgsize_bitmap = SZ_4K,
>  	.of_xlate = riscv_iommu_of_xlate,
>  	.identity_domain = &riscv_iommu_identity_domain,
>  	.blocked_domain = &riscv_iommu_blocking_domain,

Reviewed-by: Tomasz Jeznach <tjeznach@rivosinc.com> # for RISC-V

Sorry for the delayed response.
- Tomasz

