Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2638B259DEE
	for <lists+linux-s390@lfdr.de>; Tue,  1 Sep 2020 20:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgIASOQ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 1 Sep 2020 14:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgIASOP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Sep 2020 14:14:15 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD735C061244
        for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2020 11:14:14 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cy2so974793qvb.0
        for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2020 11:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4A3hPsjtdOjipSjaJeT1UcVHO23/CVQ2IpCQthxyHBw=;
        b=EHILGkhVsKeiCP6z45SoutVPM+jA7upQKYGslQ7Q4Dl4PucwRSZxe8vXQm+WQenWUd
         mQH48T5ue18fETXWnvjz5Wx0qyCBTup2nDgxleJXbZo+Gp/0QMb/oeHF9KTRl+obxy9+
         76Ku0JMrTeKENh3LuA26FCgW1oHIGGaZn86M+d9Lj2t7QXL0eKKAVFeU0KfW7EigDtGa
         7SybFavuEQT2XuvcQP+IuEFMkDijuHfAvhOCkdeTLAE7kS3scSIiw2qWpojyKJNsfGOM
         SsqTw9tAVuVs9EWnojQQ4pE/OF+CFPhdx0hQd9wicX/GuziDiMMdwW8ueGdHcY189NSK
         lz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4A3hPsjtdOjipSjaJeT1UcVHO23/CVQ2IpCQthxyHBw=;
        b=CQjLCQp1PBoCw1/sQZ8bgvCb3L6TTgJY/ljudar/yYeamJ7D+6nfAxn1mbDbGwpwdt
         j0bMcDT9fZvhwiUCR6E4u9aVxOKXGkMnYJScmgKsX8s0WRz0bSNbeeU6UU4e8hc/ar9w
         pJZt/zvysFl1qpX/7IXVi99vam3Fi9h1OMtS5Sbviw4FyGSHnBL9CP409c7It1QTE0ZM
         VzxB07BbQZop9ak8GhpIY2Q9HXwh5JfZmCCuc9WESsrFRzDbr1usFtGfLPAC3Vecx9UG
         yiG/WzGMMoJiUdrVa6lxAehzJF8zUBkUQGGEt650YhE/fqdqgUBNG5mbLfA2zww1MwFQ
         urrg==
X-Gm-Message-State: AOAM531b22c8ya9IUTuhySh64LLHQKjyqy5GEyhztwOAZl1jBP0PGfZT
        yGK1+iL1F4UfYLwnrQ+KYJ7zbA==
X-Google-Smtp-Source: ABdhPJyS7IcgtYtB2wNGX+Xo0eMaeBEI0j+77VrEcdnZRuTRVP0UtmztL9vqX9/MJnXvw4b2RGS8aw==
X-Received: by 2002:a0c:e783:: with SMTP id x3mr3317618qvn.114.1598984054019;
        Tue, 01 Sep 2020 11:14:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id k185sm2420678qkd.94.2020.09.01.11.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:14:13 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kDAnM-004ex1-GH; Tue, 01 Sep 2020 15:14:12 -0300
Date:   Tue, 1 Sep 2020 15:14:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200901181412.GE24045@ziepe.ca>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
 <9071c9fa-ba6a-90dc-2d7a-8b155141d890@de.ibm.com>
 <20200831121553.8be5dcdbdbc5256846ac513e@linux-foundation.org>
 <20200901194020.418da486@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901194020.418da486@thinkpad>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Sep 01, 2020 at 07:40:20PM +0200, Gerald Schaefer wrote:
> +/*
> + * With dynamic page table levels on s390, the static pXd_addr_end() functions
> + * will not return corresponding dynamic boundaries. This is no problem as long
> + * as only pXd pointers are passed down during page table walk, because
> + * pXd_offset() will simply return the given pointer for folded levels, and the
> + * pointer iteration over a range simply happens at the correct page table
> + * level.
> + * It is however a problem with gup_fast, or other places walking the page
> + * tables w/o locks using READ_ONCE(), and passing down the pXd values instead
> + * of pointers. In this case, the pointer given to pXd_offset() is a pointer to
> + * a stack variable, which cannot be used for pointer iteration at the correct
> + * level. Instead, the iteration then has to happen by going up to pgd level
> + * again. To allow this, provide pXd_addr_end_folded() functions with an
> + * additional pXd value parameter, which can be used on s390 to determine the
> + * folding level and return the corresponding boundary.
> + */
> +#ifndef pgd_addr_end_folded
> +#define pgd_addr_end_folded(pgd, addr, end)	pgd_addr_end(addr, end)
> +#endif
> +
> +#ifndef p4d_addr_end_folded
> +#define p4d_addr_end_folded(p4d, addr, end)	p4d_addr_end(addr, end)
> +#endif
> +
> +#ifndef pud_addr_end_folded
> +#define pud_addr_end_folded(pud, addr, end)	pud_addr_end(addr, end)
> +#endif
> +
> +#ifndef pmd_addr_end_folded
> +#define pmd_addr_end_folded(pmd, addr, end)	pmd_addr_end(addr, end)
> +#endif

Feels like it would be cleaner to globally change pmd_addr_end() /etc
to require the extra pmd input rather that introduce this special rule
when *_folded needs to be used? NOP on all arches execpt s390..

There are not so many call sites that it seems too scary, and I
wouldn't be surprised if there are going to be more cases beyond GUP
that *should* be using the READ_ONCE trick.

Jason
