Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6A62867AE
	for <lists+linux-s390@lfdr.de>; Wed,  7 Oct 2020 20:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgJGSrI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 7 Oct 2020 14:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbgJGSrI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 14:47:08 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C796C0613D4
        for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2020 11:47:08 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s7so4049969qkh.11
        for <linux-s390@vger.kernel.org>; Wed, 07 Oct 2020 11:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=blJZdod8zk/hTt6aNFQh+ol0gh1a78kUUXD+guPskI4=;
        b=FXhd/ekfXs6fh3cll2LP8DfZTMZ6v7gCpfAUIVVfE1B0U7VAQPIBKxkhfc1dFnYq82
         Kn+0XgvAM0ZBWredbpGcw0ytLSBsmbdkDGp0d+KMnNGmIEd0csrhxJ9+3u41TCl493tC
         qoy8IibKfAQBUMznmwxuOWwggfytiLaCOIvMZb5U54saVhW+IJeIoldKHp1JhktgI1fb
         dTZmieJYDuht9kp7PCFRN7wXqTnaAEzHkQzHVBm8ar/Bjnd8Q7KMUa8aVJVvWcZ/h3MJ
         RvoONyk7Z54SWNZEGjCpat5nQxlJo0thAT/kABWJLN0ZoyCZkh1K7GW3tSI0B90Pau7f
         OT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=blJZdod8zk/hTt6aNFQh+ol0gh1a78kUUXD+guPskI4=;
        b=oWmgCbwQ3NGpCdYF42CrkUFzN45tx75MTgA06e2Ann93oYjtgRYempUh4jeGnOkLFl
         EcEmTGsb4G9FOS9aGJU0VqSs3xhu+teeLFZIGj5xlFMFEzwk8sqQzaDeBhBhT8UoP0nE
         AdBNMHf+B97C5zHxJA+SvxlbtnJLXuM3Aqt+6oONv1qi2yPlp4+zx11Ap8Li5RQZX7Bu
         AmdBki6WeBkaT5LTZqazOJksSBS7TQL2z0VQNNt7E/C1cClvjI/isFX0Dsb0aDyKLUI9
         N3D86sQzgj0QxJYfGz5MQ2ALLvjuKJ3GtT48OxxVNkU58lTDnk9DRvNCD+zw41mRrjI/
         ZENg==
X-Gm-Message-State: AOAM533LkncQTMoTUtyb+IhCvim2e2pMyoTctoIOEhRcL5WqJS6KRGlo
        lZOkQkQIqMyl1tye0ixv2UBFJw==
X-Google-Smtp-Source: ABdhPJyI7YrbswPfVJyHh3D9zECw9J/wTcosoBEFRYUxMgJHlEqE+dKTaCija+ZxTihrZ+KRv+csgQ==
X-Received: by 2002:a05:620a:244e:: with SMTP id h14mr4456465qkn.348.1602096427480;
        Wed, 07 Oct 2020 11:47:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o2sm2032427qkk.42.2020.10.07.11.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 11:47:06 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQESv-001Elc-Ob; Wed, 07 Oct 2020 15:47:05 -0300
Date:   Wed, 7 Oct 2020 15:47:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, linux-s390@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 13/13] vfio/type1: Mark follow_pfn as unsafe
Message-ID: <20201007184705.GY5177@ziepe.ca>
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
 <20201007164426.1812530-14-daniel.vetter@ffwll.ch>
 <20201007173911.GX5177@ziepe.ca>
 <CAKMK7uEbAAJPPmv1yM_-V24Xg=S=NWxs2Yhi51kb-4AZLbFTTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uEbAAJPPmv1yM_-V24Xg=S=NWxs2Yhi51kb-4AZLbFTTg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 07, 2020 at 08:14:06PM +0200, Daniel Vetter wrote:

> Hm, but wouldn't need that the semi-nasty vma_open trick to make sure
> that vma doesn't untimely disappear? Or is the idea to look up the
> underlying vfio object, and refcount that directly?

Ah, the patches Alex was working on had the refcount I think, it does
need co-ordination across multiple VFIO instances IIRC.

At least a simple check would guarentee we only have exposed PCI BAR
pages which is not as bad security wise as the other stuff.

Jason
