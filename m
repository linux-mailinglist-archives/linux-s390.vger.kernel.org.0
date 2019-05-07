Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE8BC16C88
	for <lists+linux-s390@lfdr.de>; Tue,  7 May 2019 22:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfEGUqU (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 7 May 2019 16:46:20 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41160 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEGUqU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 May 2019 16:46:20 -0400
Received: by mail-ot1-f66.google.com with SMTP id g8so16289007otl.8
        for <linux-s390@vger.kernel.org>; Tue, 07 May 2019 13:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fw0JPQ4oQ07pMZfSEOmqFo0Ax/JNe6lqDNiuIeW+cfk=;
        b=rqW6lucK5GLSkk6D3VC83NNNr3p5l4cDVk4n80Uvm322BBV2qCuKSPr4z+P2ezcoyK
         z+YMgkO0V+5hEmcMr0MwF6O3QHG8xWVY2eTA1Py3k6awm18aqMlPP98eZujqBEdbRRXN
         aS93k1uMcPJFXIHF98HnDfB8WCQgSAWAn+PzoKcCdVTC+uJmNJ+7TTcrUEmBZNFgGikS
         JoN377FDE4nzpHgH/fCwVvnpugUJXF2ApAVZaCrgrLXf7ZjFcE/OLNwmWNUpvbW/wIQU
         Uwg4mKk8U4/mWeh5D1XY1VYZpFjHtv4IPmwLoWQVjBRPrwTp5axa3EA9O5FG/AT874cG
         VNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fw0JPQ4oQ07pMZfSEOmqFo0Ax/JNe6lqDNiuIeW+cfk=;
        b=tqGUAS0bmxgjeJrOpinD5PTUmgyPwy7Ss8pLmoWaja2KiRgs15FxJNo0ib7KYNIH3B
         60fZ1hIvQCqz9kEwRToFYpGZdrZbDURRwd9bY1gR7EaFDeChSEah314WD5OvXbexQm2z
         E4fKshkLip8/4Bs/ORECTi3yJTg3GB8wnzHFPoYddLq3LyHisu7EC3F0Ij9Dui7YOEsl
         b254px+50tY6tLLZD/2qLL9BjExQoN0RrjRWUyUxZ1/anPiplamv7JCGLkO8BEDNbTIH
         LeCZRXmdqSkRVHiFauQuCh6QMa/cKcelQaU6IULmk3/HYcHU2RNdyx3oCLnkQ5SJdWfQ
         LhpA==
X-Gm-Message-State: APjAAAXFRXrF2/sLNBodGbpOwRPa0bAkLaecz34eLlTiIv0yAKnxNkB+
        Q0GaPLsc9JKNdpqTMt5E1e+y1r/Rwa5dyJ0Y03+IMQ==
X-Google-Smtp-Source: APXvYqwkL7vHIYJxD+HfiXZUkr4PGh3XR7bd+koUKuRLubXL7y6kGEyKk74Z2RGz0ad/moc44qYziRyn+VmkpRZHHO8=
X-Received: by 2002:a9d:6f19:: with SMTP id n25mr2402081otq.367.1557261979262;
 Tue, 07 May 2019 13:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190507183804.5512-1-david@redhat.com> <20190507183804.5512-3-david@redhat.com>
In-Reply-To: <20190507183804.5512-3-david@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 May 2019 13:46:08 -0700
Message-ID: <CAPcyv4gtAMn2mDz0s1GRTJ52MeTK3jJYLQne6MiEx_ipPFUsmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] s390x/mm: Implement arch_remove_memory()
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 7, 2019 at 11:38 AM David Hildenbrand <david@redhat.com> wrote:
>
> Will come in handy when wanting to handle errors after
> arch_add_memory().
>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Oscar Salvador <osalvador@suse.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/mm/init.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 31b1071315d7..1e0cbae69f12 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -237,12 +237,13 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  void arch_remove_memory(int nid, u64 start, u64 size,
>                         struct vmem_altmap *altmap)
>  {
> -       /*
> -        * There is no hardware or firmware interface which could trigger a
> -        * hot memory remove on s390. So there is nothing that needs to be
> -        * implemented.
> -        */
> -       BUG();
> +       unsigned long start_pfn = start >> PAGE_SHIFT;
> +       unsigned long nr_pages = size >> PAGE_SHIFT;
> +       struct zone *zone;
> +
> +       zone = page_zone(pfn_to_page(start_pfn));

Does s390 actually support passing in an altmap? If 'yes', I think it
also needs the vmem_altmap_offset() fixup like x86-64:

        /* With altmap the first mapped page is offset from @start */
        if (altmap)
                page += vmem_altmap_offset(altmap);

...but I suspect it does not support altmap since
arch/s390/mm/vmem.c::vmemmap_populate() does not arrange for 'struct
page' capacity to be allocated out of an altmap defined page pool.

I think it would be enough to disallow any arch_add_memory() on s390
where @altmap is non-NULL. At least until s390 gains ZONE_DEVICE
support and can enable the pmem use case.
