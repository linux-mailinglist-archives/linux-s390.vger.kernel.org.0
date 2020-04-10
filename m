Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6940E1A4358
	for <lists+linux-s390@lfdr.de>; Fri, 10 Apr 2020 10:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJILO (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 10 Apr 2020 04:11:14 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35817 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgDJILN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Apr 2020 04:11:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id v2so1213525oto.2
        for <linux-s390@vger.kernel.org>; Fri, 10 Apr 2020 01:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hgf3DAUC4/KD19F9Gq5AGfjZOzS9LXWN/bbu/vFg+qA=;
        b=dFrk5z2BtMEmisYXExkZBismSlsWb5Q4k/3n94YDOvTZuh2CzIpH/i8KoNWzlv4bXk
         /+Bzn+RqlG2O4N1iciPqbf359lmAxRrY7woQmtsWzKRq9DFPU3AhxhJ6V+T7GDyl1tRC
         5xNRsfm5urzQ2GX3QtuJdU9JR4uI52qA4fFG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgf3DAUC4/KD19F9Gq5AGfjZOzS9LXWN/bbu/vFg+qA=;
        b=UxdK2aHxwkOMj6ZApcG+Io29UHfSZU2wEjBUYxFS5rnI5se6ABLqPYDcEud1uTsIgX
         zJx+9LL959rpAtrdYXD3MtJ4z6wddu362wEdsi+5IXMD1LHkoXRZR18HECif4snlyyMx
         b+Bp5GP5HZ4FhWrCvzT7W+8pxT6ZOZVkem4mmASLfgT1X2kS6aUHF3yGOMaxKjJxzAqk
         /enA76ei99r45OCk1yGYXQYZuZenGINpsupcYAy4pp1sBt2rbSPtT1GBe9dEoNmfrvV7
         2PwdHerAzLe/EHir54UiFzEV6okii/8cdv9G9JRjho1YBa5Y/27/5U2KNMNoBrS6YL5O
         msJA==
X-Gm-Message-State: AGi0PuZe12gZfIea69wwC98PSkCYt4s0h6t/3eji+A/2Xjbnar6cEYuE
        jdx9vA/LuFDsRbdSqJV9xkAF0hG3uxh6IV1NZc3y/g==
X-Google-Smtp-Source: APiQypJumpZ6N8vscDAXJtrZPRakBWDA3qYtIErOA5tqj0XblmFZSMuMiwpkQHsTVZs7vae7PdjUGGhKyrX4Ng8eQNQ=
X-Received: by 2002:a9d:6e8f:: with SMTP id a15mr3449972otr.188.1586506273249;
 Fri, 10 Apr 2020 01:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200408115926.1467567-1-hch@lst.de> <20200408115926.1467567-20-hch@lst.de>
 <20200408122504.GO3456981@phenom.ffwll.local> <eb48f7b6327e482ea9911b129210c0417ab48345.camel@kernel.crashing.org>
 <CAKMK7uHtkLvdsWFGiAtkzVa5mpnDvXkn3CHZQ6bgJ_enbyAc8A@mail.gmail.com> <0f360b9cb72b80bae0d0db8150f65598c2776268.camel@kernel.crashing.org>
In-Reply-To: <0f360b9cb72b80bae0d0db8150f65598c2776268.camel@kernel.crashing.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 10 Apr 2020 10:11:02 +0200
Message-ID: <CAKMK7uHKyN+c5oTEYVursx4at9br7LSXRb8PMoNEAEBh0hfBLQ@mail.gmail.com>
Subject: Re: [PATCH 19/28] gpu/drm: remove the powerpc hack in drm_legacy_sg_alloc
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, X86 ML <x86@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-hyperv@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-s390@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Apr 10, 2020 at 12:57 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Thu, 2020-04-09 at 11:41 +0200, Daniel Vetter wrote:
> > Now if these boxes didn't ever have agp then I think we can get away
> > with deleting this, since we've already deleted the legacy radeon
> > driver. And that one used vmalloc for everything. The new kms one does
> > use the dma-api if the gpu isn't connected through agp
>
> Definitely no AGP there.

Ah in that case I think we can be sure that this code is dead.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
