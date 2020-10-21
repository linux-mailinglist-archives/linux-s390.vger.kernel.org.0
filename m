Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6F7295226
	for <lists+linux-s390@lfdr.de>; Wed, 21 Oct 2020 20:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504049AbgJUSVa (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 21 Oct 2020 14:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504041AbgJUSVa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 21 Oct 2020 14:21:30 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532A7C0613D4
        for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2020 11:21:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e22so4636429ejr.4
        for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2020 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lBYBT2trM0zWLuScJPu/8MEsMxH22DaNGgcD4PxkzgM=;
        b=aI4DCgQQ2pNgP8FJefkPAHWyeYDZ6gBOdUW5ASwTjCdJPt6/F0D5IUw+ryIpjQNXm7
         gK4+rVdRij2UezhsYNKjky15pbLyx71SXm/fZWi7e8Q4m+RVncNlw0/EQHwWG71kG1jW
         swatZpkYTu5yAZOXhuMbyP3n0EJyZ6Tj4Y/cuYa29u3olktUJdc4M4TJ2rd4I+0DOH8g
         zGBna8sz6bZsljPuc9avDUo1nfa6ddJFnaen4gYQFZ8z/YYqPo9kDiLM1CATyUVyGmG8
         pnWq4b5N/m5mvr9ZCnxufY7oD2D56MpGg2WZMNT6wzDAol9vlUAst1BSJiogsIkNya2g
         yS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lBYBT2trM0zWLuScJPu/8MEsMxH22DaNGgcD4PxkzgM=;
        b=bZe5GKIvOMgJwPyJXpX211cdZZfLmyfOWfjuVO02elXKK8jG7z2Y2rBCJdIb9TLF31
         xfB9N8MvqL/augDTS8ZTQ9n4VVLQ+BV/AEy9ow5h/unIGWay5Z9i/ch2Y23C7zYnJ0tD
         RIXfA8z1s8JcDF/2cgAlAAh4CWLlRxGBkpMxgNlgSmLqWNARFEmmtCMgmgM3K4KFoB4Q
         MwCBbgDwifr8KRc2XH7Su0vJ9ZzXpAwaBxygxfX84US5F1RA0aaO75mwtroD42SiKMB2
         atCHT4MpCZiJB6Zcr3w7+MmSjFhbatgP1zM5MT7+LVwLXyr/S/oMLGnjkMUQXGWaIX9G
         lDcQ==
X-Gm-Message-State: AOAM530XBRl0qRfV73J1DXgBhy79W6DyJSdMclCNSkcOMu+kttuXfBT5
        48TkSxuNwiJMNVbrivYG2CvJVGWzhskjWBIbUNts0A==
X-Google-Smtp-Source: ABdhPJzA1jSls/Kx/Mwjc1+1+EpDhh/HoRUDuIKQ8K0ggJGziicPcEE6tEKertKBv/kwHwmxQELgJDflTG3MPc+CL3w=
X-Received: by 2002:a17:906:c20f:: with SMTP id d15mr4627011ejz.341.1603304487981;
 Wed, 21 Oct 2020 11:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201021085655.1192025-1-daniel.vetter@ffwll.ch> <20201021085655.1192025-14-daniel.vetter@ffwll.ch>
In-Reply-To: <20201021085655.1192025-14-daniel.vetter@ffwll.ch>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 21 Oct 2020 11:21:17 -0700
Message-ID: <CAPcyv4jJTeH-PNjsXGrn=Ooz7=9rsZLdnFgwJ9xpQ6y14YoDrQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/16] /dev/mem: Only set filp->f_mapping
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "Linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Daniel Vetter <daniel.vetter@ffwll.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 21, 2020 at 1:57 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrot=
e:
>
> When we care about pagecache maintenance, we need to make sure that
> both f_mapping and i_mapping point at the right mapping.
>
> But for iomem mappings we only care about the virtual/pte side of
> things, so f_mapping is enough. Also setting inode->i_mapping was
> confusing me as a driver maintainer, since in e.g. drivers/gpu we
> don't do that. Per Dan this seems to be copypasta from places which do
> care about pagecache consistency, but not needed. Hence remove it for
> slightly less confusion.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
