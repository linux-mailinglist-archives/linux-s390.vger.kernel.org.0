Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D57471ADC
	for <lists+linux-s390@lfdr.de>; Sun, 12 Dec 2021 15:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhLLOj2 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 12 Dec 2021 09:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhLLOj1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 12 Dec 2021 09:39:27 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA596C061751
        for <linux-s390@vger.kernel.org>; Sun, 12 Dec 2021 06:39:27 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so12838535pju.3
        for <linux-s390@vger.kernel.org>; Sun, 12 Dec 2021 06:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2zny3Bx2o60PdHAHhyf6q+y4E1Ceap0f1n6TKcneOk=;
        b=AlZ4MjqeDEThHEH1FVUzZvmPycukh+PxUwoNaVX5obBJ1cbGHWrTFXhwDvkeLPtwLI
         NHAB8xNArm8PU3DO00Z4REhsm+1Qob5/1ys9INe5D2L2b/t2UBCbCv2eWNYhhKTCINNS
         Q1t8/d3A1COiZ95VaH5Rk1yRA9uPc1Tw8y+dLInqS/mvz45lXPDFlTg+rjL2gA8569Ct
         GL+IVMJJ/wrJ7C7lHVb1smufdMBPNjTAQrn9bTN7CY+SsdNimDU+ZrBJWQpMBVJ2jVq1
         uXY8Bk9o5/8ZSmZHwswsew7WhsFfZauh8tlr+PdX0FkYdSaEagRCltJHMUxaIZv/WTkL
         iliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2zny3Bx2o60PdHAHhyf6q+y4E1Ceap0f1n6TKcneOk=;
        b=LHz+fUbMp/KMhcBl/6KNPbZgd7rjy8rLLQzd9m51iAs1QVZTHrLav2QC6wdlVvNjb7
         qBgM1tvwrWGAd5rj64l038xtRbTtSO+RgB07LD3lN0b0+CRsQCCvJ4atEzPvKPV6RVoh
         Y1q9NPLqG5+to+VMlyk4KrtlHV7pz5hHvb5+I+Zn567AOJsy/EeuBKUVjshPu0N5bTSX
         zR8CCyuGreSekaQBU+1j2U+GumwZJWZA/kGKDTArdhXa6HObNM6RahbAco/rB7wz/t7M
         aN5iGFp02ky7gvYiqd8hRO9GGyntQlC8ZSOVxknynxeKYAEC6iBMLaGbE7KRxvMY4KeK
         U0kw==
X-Gm-Message-State: AOAM530F8CcoriDQ/lynT9kur/vISqbpFPfE3Johx9PW0eXXUm7nxmMJ
        rQ2rgNcJ/xxlw7W93EMvw/NKkh5bm1HuQjXtoJLkfQ==
X-Google-Smtp-Source: ABdhPJz2lbfhBkbKpu43+79k6Z3alD86owZO4X5IPgFqiWUlbzwsnwFTD+5Dey+ZqI2i+TrJIWAD/hQxem3DZ5dPHCE=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr37441884pjb.93.1639319967232;
 Sun, 12 Dec 2021 06:39:27 -0800 (PST)
MIME-Version: 1.0
References: <20211209063828.18944-1-hch@lst.de> <20211209063828.18944-5-hch@lst.de>
In-Reply-To: <20211209063828.18944-5-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 12 Dec 2021 06:39:16 -0800
Message-ID: <CAPcyv4gZjkVW0vwNLChXCCBVF8CsSZityzSVmcGAk79-mt9yOw@mail.gmail.com>
Subject: Re: [PATCH 4/5] dax: remove the copy_from_iter and copy_to_iter methods
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Dec 8, 2021 at 10:38 PM Christoph Hellwig <hch@lst.de> wrote:
>
> These methods indirect the actual DAX read/write path.  In the end pmem
> uses magic flush and mc safe variants and fuse and dcssblk use plain ones
> while device mapper picks redirects to the underlying device.
>
> Add set_dax_virtual() and set_dax_nomcsafe() APIs for fuse to skip these
> special variants, then use them everywhere as they fall back to the plain
> ones on s390 anyway and remove an indirect call from the read/write path
> as well as a lot of boilerplate code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/super.c           | 36 ++++++++++++++--
>  drivers/md/dm-linear.c        | 20 ---------
>  drivers/md/dm-log-writes.c    | 80 -----------------------------------
>  drivers/md/dm-stripe.c        | 20 ---------
>  drivers/md/dm.c               | 50 ----------------------
>  drivers/nvdimm/pmem.c         | 20 ---------
>  drivers/s390/block/dcssblk.c  | 14 ------
>  fs/dax.c                      |  5 ---
>  fs/fuse/virtio_fs.c           | 19 +--------
>  include/linux/dax.h           |  9 ++--
>  include/linux/device-mapper.h |  4 --
>  11 files changed, 37 insertions(+), 240 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index e81d5ee57390f..ff676a07480c8 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -105,6 +105,10 @@ enum dax_device_flags {
>         DAXDEV_WRITE_CACHE,
>         /* flag to check if device supports synchronous flush */
>         DAXDEV_SYNC,
> +       /* do not use uncached operations to write data */
> +       DAXDEV_CACHED,
> +       /* do not use mcsafe operations to read data */
> +       DAXDEV_NOMCSAFE,

Linus did not like the mcsafe name, and this brings it back. Let's
flip the polarity to positively indicate which routine to use, and to
match the 'nofault' style which says "copy and handle faults".

/* do not leave the caches dirty after writes */
DAXDEV_NOCACHE

/* handle CPU fetch exceptions during reads */
DAXDEV_NOMC

...and then flip the use cases around.

Otherwise, nice cleanup. In retrospect I took the feedback to push
this decision to a driver a bit too literally, this is much better.
