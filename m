Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5932A289081
	for <lists+linux-s390@lfdr.de>; Fri,  9 Oct 2020 20:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390369AbgJISDr (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 9 Oct 2020 14:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390334AbgJISBs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Oct 2020 14:01:48 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6040AC0613D2
        for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2020 11:01:48 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id b10so2945523qvf.0
        for <linux-s390@vger.kernel.org>; Fri, 09 Oct 2020 11:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JtTniNbWimQFTlPWxNfhtRJTUnIfWE2pIrRn0nLquTU=;
        b=f/szaRC+vLdnDgqFvq8AOddrp6VSsc5+VOKHgdN1Blfz+Kdocq0LgJzoYOwFNRhbsb
         R58LfaQQ3n9+kujlpK+dXsyPtLR7PpkdHaoMjpLP5dFUu9uKpYtIgwUv2SzANG3wJ4HI
         uZ2jIrHb3l+wKyafHdJPZ5UpeQcq4bXudJq3VH1qWYsmCJKZjK3dkCknvRMRvHtmwEaJ
         +C7ytvDBDqqX8xISydsOLSJIZQl1e2A9hJato/1mUA5uyCKy3VQWCdd1nWlOILZ9XItf
         xtRqWEAdtlSCbEhxBM5pVhNugecQkdco1xNKTq95myZ76QxSJibw5Xyqk8ww4uW9rkwK
         T0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JtTniNbWimQFTlPWxNfhtRJTUnIfWE2pIrRn0nLquTU=;
        b=OHgw9nOoLStvQM9COiVj3JvH3rPmAvS/MfyCkw3V1kNopqXICK8UTNXhVjIwMXIJM6
         kikOVj59k6jAesGzwDi2taqk91ExCGMJxk3sfEEGKZcihXh3VF19jYuGPSB+005E0XWw
         83Vz/Xi/5FSwop/D66lF39FFB9iH5Evx7Mc4ma9dtu4COGJk2k833sFV6bsNUjgwbsYo
         5Dv15oarxz6rM1auivZk4CX3IFrd5bl82eEmkQr5807ChGZvzfe+pm/s7DgChiFKAU5S
         VJoO2ztF98y2EJrZ6gM4OclREGivOdZrZ0ySv8tiDaz0OKLUyAb8vClWaoGxiLmq7hyd
         WwVg==
X-Gm-Message-State: AOAM533KuUlXK0h7DWLkdAcdcbDiMklkCP0lV0Z1wZ7zh8tCwWw6sHsu
        I2MEeL1avnViYsKUU0Lq6nMwCQ==
X-Google-Smtp-Source: ABdhPJwGH8DcAarR0OMfhGw63SRnoeGEeh/DF4k79ebCsxHoTPcqFkl2Atp6g4SjeQTYysb9k3E+GQ==
X-Received: by 2002:ad4:52c6:: with SMTP id p6mr12553168qvs.38.1602266507532;
        Fri, 09 Oct 2020 11:01:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 68sm6690974qkg.108.2020.10.09.11.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 11:01:46 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQwi9-002b28-P5; Fri, 09 Oct 2020 15:01:45 -0300
Date:   Fri, 9 Oct 2020 15:01:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
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
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 09/17] mm: Add unsafe_follow_pfn
Message-ID: <20201009180145.GB5177@ziepe.ca>
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-10-daniel.vetter@ffwll.ch>
 <20201009123421.67a80d72@coco.lan>
 <20201009122111.GN5177@ziepe.ca>
 <20201009143723.45609bfb@coco.lan>
 <20201009124850.GP5177@ziepe.ca>
 <CAKMK7uF-hrSwzFQkp6qEP88hM1Qg8TMQOunuRHh=f2+D8MaMRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uF-hrSwzFQkp6qEP88hM1Qg8TMQOunuRHh=f2+D8MaMRg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Oct 09, 2020 at 07:52:05PM +0200, Daniel Vetter wrote:

> > > If this is the case, the proper fix seems to have a GFP_NOT_MOVABLE
> > > flag that it would be denying the core mm code to set __GFP_MOVABLE.
> >
> > We can't tell from the VMA these kinds of details..
> >
> > It has to go the other direction, evey mmap that might be used as a
> > userptr here has to be found and the VMA specially created to allow
> > its use. At least that is a kernel only change, but will need people
> > with the HW to do this work.
> 
> I think the only reasonable way to keep this working is:
> - add a struct dma_buf *vma_tryget_dma_buf(struct vm_area_struct *vma);
> - add dma-buf export support to fbdev and v4l
> - roll this out everywhere we still need it.

It seems to me there is a technical way forward to restore user
compat, so it is really no different than RDMA/DRM pain we both
suffered before.

Thus no justification to NAK it. If media wants things to keep working
they have to do the technical path like you outline above.

> Realistically this just isn't going to happen. 

If your series goes ahead it will get solved. Someone will take on the
huge project to either add DMA buf to the drivers people still care
about, or do the work above to transparently handle in kernel.

If we allow things to keep working without consequence then nobody
will do it.

The only reason we did the 4 years of work in RDMA was because Linus
went in and broke the uABI for a security fix. It was hundreds of
patches to fix it, so I don't have much sympathy for "it is too hard"
here.

Jason
