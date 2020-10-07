Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0900286B74
	for <lists+linux-s390@lfdr.de>; Thu,  8 Oct 2020 01:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgJGXVX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 7 Oct 2020 19:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgJGXVV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 19:21:21 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08307C0613D3
        for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2020 16:21:19 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id h12so2023303qtu.1
        for <linux-s390@vger.kernel.org>; Wed, 07 Oct 2020 16:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wKVq0v36o1OseOTfSiRENpilMLoRQr0K5VZe4J2K3Kc=;
        b=eonGoy0XmwUCVUGspJnsew+Xt7VaOYXBvCVLNfKebMnycQvmW3AnbQjz9lSZk+oJTt
         dhvuV/v/cnVlxITNMU9OjuXLMypWJUZ21uT0gYOxQ8d5Ns6agyhkSgI250TcvBKPkqcq
         eDXVSqeP187Kj7hX9ZW21soQCHyKtnnpRD86xF4iV4vIsAEXErr5M7nS61S+a1iD/LIb
         LoT/Oje5p+16A0FP2LPQqK7+AMDx5byuewUWnk+LOvBmW6M8aHFUXTPUZju1RP8UOXu8
         sLtKGSyXFXzBShaXLdlI6xM43DeuV6UnkYTmZJGaAH/xG5nThTf8qdvy8p02SSq+yIph
         +DKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wKVq0v36o1OseOTfSiRENpilMLoRQr0K5VZe4J2K3Kc=;
        b=Gb/K+VMur7mg+ls9eZt/CMKrvuEWWILXYYw9n4MywaxSL+JONR1fXvAtfFiVJyXBxD
         0o8gX/Ak9ih0rC4xSoQgkab/FAeZBbVqyvNm75J9i/iUxTL2Zo3NL7RgicmkC83E9Y+A
         +Wdz9ByexBY5SV9GJCYSaZ2thtSCfB4L4ehc2VZ+DUrMvy7/Al1JyGgXC0KLPXQAexYY
         k1x1cjKgp0YCg0DUtYxOXt1ZK0d0fnjwRzPD1+0bp/M3mPLW185dPKkfsbqIH4gLmMbg
         ejkSI2QZY3+FdhQpIhZcYnWgIfrWXWg/NSNPJla6NouZSLmL1QZ0Z1YOwh4aQXHfrJkp
         It1A==
X-Gm-Message-State: AOAM533oDKEzoo3FhG+nDtIxOjB7epo9pLCiKpkwhsZ8lZVo6QF7VNO0
        8uuQx4S0FCOsPlFLKBNOa2086w==
X-Google-Smtp-Source: ABdhPJyQZRi/LW8n5yhULmf0Fru5TIwyRzoLwr2XtdSWRnkxdnVhvqGusX2Dk2zCuTvGMQkdks5bXg==
X-Received: by 2002:ac8:5bd0:: with SMTP id b16mr5601331qtb.296.1602112879011;
        Wed, 07 Oct 2020 16:21:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id z26sm1881713qki.40.2020.10.07.16.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 16:21:18 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQIkH-001IkZ-3z; Wed, 07 Oct 2020 20:21:17 -0300
Date:   Wed, 7 Oct 2020 20:21:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, linux-s390@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Rik van Riel <riel@redhat.com>,
        Benjamin Herrensmidt <benh@kernel.crashing.org>,
        Dave Airlie <airlied@linux.ie>,
        Hugh Dickins <hugh@veritas.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 07/13] mm: close race in generic_access_phys
Message-ID: <20201007232117.GB5177@ziepe.ca>
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
 <20201007164426.1812530-8-daniel.vetter@ffwll.ch>
 <20201007172746.GU5177@ziepe.ca>
 <CAKMK7uH3P-6zs5MVceFD7872owqtcktqsTaQAOKNyaBg4_w=aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uH3P-6zs5MVceFD7872owqtcktqsTaQAOKNyaBg4_w=aA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 07, 2020 at 08:01:42PM +0200, Daniel Vetter wrote:
> I think it'd fix the bug, until someone wires ->access up for
> drivers/gpu, or the next subsystem. This is also just for ptrace, so
> we really don't care when we stall the vm badly and other silly
> things. So I figured the somewhat ugly, but full generic solution is
> the better one, so that people who want to be able to ptrace
> read/write their iomem mmaps can just sprinkle this wherever they feel
> like.
> 
> But yeah if we go with most minimal fix, i.e. only trying to fix the
> current users, then your thing should work and is simpler. But it
> leaves the door open for future problems.

The only other idea I had was to fully make the 'vma of __iomem
memory' some generic utility, completely take over the vm_ops.

We did something like this in RDMA, what I found was even just
implementing mmap() using the kernel helpers turned out to be pretty
tricky, many drivers did it wrong in small ways.

Jason
