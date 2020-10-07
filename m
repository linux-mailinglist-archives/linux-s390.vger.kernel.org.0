Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265E2286544
	for <lists+linux-s390@lfdr.de>; Wed,  7 Oct 2020 18:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgJGQxT (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 7 Oct 2020 12:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgJGQxT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 12:53:19 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4BEC0613D3
        for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2020 09:53:19 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d20so3571662qka.5
        for <linux-s390@vger.kernel.org>; Wed, 07 Oct 2020 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aA5/IKqeJTcjHMODAliv+D9oxsXiJBjU0Q/RoQOchc4=;
        b=ThVHp0Bf6+g4+R33mQIvIX8CheiSQQTMUuTCia9X1IqJrBuFaGelh/l39LBTeYKkvK
         NaMOGfKlUrf0z4iE8OxQVYLuzZ/JlM7sUpAQwKcFn4cRIEuVLL6aIerNL35v1pmwUkj+
         wDrYDlD+5FNGiiz175SjQIUqXASz3MvdF3eYJh+ukkwcF83qjZnM9uioklIntUHKaRya
         Zg9rg6+eKKInIDWli/ZJm1h6yck77cdzU9Fs3bEWsRArMtEGioYwK8tfNazOHk/B4xtt
         Mf7AVxNkG0ee/JcnZSnMywZa9C4+2enXUIhuG1wGpzdJZvOcjJkPsfCeezTM2uT5xq7S
         MUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aA5/IKqeJTcjHMODAliv+D9oxsXiJBjU0Q/RoQOchc4=;
        b=Kz5bazX/NJlS6sTUkkoKOAldEewWKLEIR1bjeg/rdI6N1L0JhDsdi2kI341ju3FAFh
         K5VxSO2WOgKpMXqSzpR6jHGnqaKE9IqAS3EzbxhUKMCMjAoOJJ+Paer+HJRaRHurQ+Us
         NYMP6MFGGKj/jwyuw9qpU3ihQysgIpY5wmBfWuGy300y5ekqmauJAPYt++C1m+Flf7T9
         oIU7TEjb3x98a84H7ymA5YFJiN49UALRpB95FLRhAkoXzrZ04PiFJvFW4XiJIo7sJEYu
         EHZEWb/YMjgkLzmn2x8Xkk7gFB4Rk/DragK97lVGIVr0O4kttb/d22C8/mWNcA3BUYLb
         MDOQ==
X-Gm-Message-State: AOAM532G9p12Lq7SCSkg3lhrlBXpaayr/mwabWYZNrJ2HcneTCswWqMj
        tG309cdNinCIt0lZX9Fh2+yrKA==
X-Google-Smtp-Source: ABdhPJxixhkZJXYtJ75yqJVriDbZSDlnfap0MWWWiSIn4wzaboeX7oTS66SiExjVo2w4rTtFpjs6Eg==
X-Received: by 2002:a37:aec2:: with SMTP id x185mr3746059qke.73.1602089598574;
        Wed, 07 Oct 2020 09:53:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x75sm232893qka.59.2020.10.07.09.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 09:53:17 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQCgm-0010EB-Tr; Wed, 07 Oct 2020 13:53:16 -0300
Date:   Wed, 7 Oct 2020 13:53:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 05/13] mm/frame-vector: Use FOLL_LONGTERM
Message-ID: <20201007165316.GT5177@ziepe.ca>
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
 <20201007164426.1812530-6-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007164426.1812530-6-daniel.vetter@ffwll.ch>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 07, 2020 at 06:44:18PM +0200, Daniel Vetter wrote:
>  
> -	/*
> -	 * While get_vaddr_frames() could be used for transient (kernel
> -	 * controlled lifetime) pinning of memory pages all current
> -	 * users establish long term (userspace controlled lifetime)
> -	 * page pinning. Treat get_vaddr_frames() like
> -	 * get_user_pages_longterm() and disallow it for filesystem-dax
> -	 * mappings.
> -	 */
> -	if (vma_is_fsdax(vma)) {
> -		ret = -EOPNOTSUPP;
> -		goto out;
> -	}
> -
> -	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP))) {
> -		vec->got_ref = true;
> -		vec->is_pfns = false;
> -		ret = pin_user_pages_locked(start, nr_frames,
> -			gup_flags, (struct page **)(vec->ptrs), &locked);
> -		goto out;
> -	}

The vm_flags still need to be checked before going into the while
loop. If the break is taken then nothing would check vm_flags

Jason
