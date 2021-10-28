Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045FF43D805
	for <lists+linux-s390@lfdr.de>; Thu, 28 Oct 2021 02:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhJ1AXS (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 27 Oct 2021 20:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhJ1AXS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 27 Oct 2021 20:23:18 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A95C061767
        for <linux-s390@vger.kernel.org>; Wed, 27 Oct 2021 17:20:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so3321664pjb.3
        for <linux-s390@vger.kernel.org>; Wed, 27 Oct 2021 17:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=thFpqdlxLVjcGfDZPprDTzPo9iTzt5bk9dqhDCzY+u0=;
        b=Bp5byUxxNEOGWx1LiYKcSiES+UNWDp5D/cMWZdjtl33fGWM9mdrZIzgn/KeGW66w48
         HLlosh7rVoB0KWLzJNIesUqmq7HyWnrZDWPZXtEInbmdYlimOId2CvHzX4NDal8E2jsZ
         NIOS1NWX2Og4zHktLs8Z73ffbx1VrB4tMgXBr+cAXsS3m4YEPwio+BMFFkGVGFDC70ho
         bg5uNNY9RzCmq9k8vu68K0vdjkKG8QMiqL+5O7IERSfZ90owTTf78IF/SLmMshLsv0gn
         algtrVwvBQo2E9HZ/GOG94ZMah+I89z5KkLKLbHkHit8m9WqG6x8NqMi8PHespkOBUpP
         20MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=thFpqdlxLVjcGfDZPprDTzPo9iTzt5bk9dqhDCzY+u0=;
        b=WNugdelU1KWYn121hf0a0NehwlHew0cn+TME6/+Q4EHG3Xe/IDIDM6smVVDpVoSuYm
         J/r7z/vE3QJCYe6dxtnh6zCZTeX6EiZvNp769Iu7ws4J1qy4WKhKZfbqTSgCoMtc391y
         c/RLKtIeFLdoMAoyWbKHynwdQzZU4s1//sKFK/fzfip/TZXFnsdHNEcgJGlHU/iIk1Rz
         fQO9mdRgaG3Yi94HZWpmZNrk6gy+9gkuTYr6q907ruAoCoDPg8DwV6N0Up41cnwPsGLc
         RcCJfvVhNVp/csq5O5dDyueaKfQZPDnpnTr/yHK/M441M6d3H5ktVjWkRHF24aulvkQt
         ToQQ==
X-Gm-Message-State: AOAM531dfq01tHsLPpGGTS95hR/2jnVQJf9DdPy/sWU9sf5kPTHd8ovg
        1uJn8Wn7j0Bv5qoyFXUAggmOqGCpEaTasLtaRnGJ/w==
X-Google-Smtp-Source: ABdhPJzDJ7G0OO0ihyu2DGXMx9nVI+vhdbJMigLbokXMw0jK9Xiqd7lMu/pWH/LSzIK1m8uglUBBOlGG+XCxTCXb4vQ=
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr942901pjb.220.1635380451659;
 Wed, 27 Oct 2021 17:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de> <20211018044054.1779424-8-hch@lst.de>
 <20211019154447.GL24282@magnolia>
In-Reply-To: <20211019154447.GL24282@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 Oct 2021 17:20:40 -0700
Message-ID: <CAPcyv4g0yC3S8X6_DPtSjgFu3XFOHwu1KDy1HQP9eWk-EnDaxA@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH 07/11] dax: remove dax_capable
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-xfs <linux-xfs@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Oct 19, 2021 at 8:45 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Mon, Oct 18, 2021 at 06:40:50AM +0200, Christoph Hellwig wrote:
> > Just open code the block size and dax_dev == NULL checks in the callers.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/dax/super.c          | 36 ------------------------------------
> >  drivers/md/dm-table.c        | 22 +++++++++++-----------
> >  drivers/md/dm.c              | 21 ---------------------
> >  drivers/md/dm.h              |  4 ----
> >  drivers/nvdimm/pmem.c        |  1 -
> >  drivers/s390/block/dcssblk.c |  1 -
> >  fs/erofs/super.c             | 11 +++++++----
> >  fs/ext2/super.c              |  6 ++++--
> >  fs/ext4/super.c              |  9 ++++++---
> >  fs/xfs/xfs_super.c           | 21 ++++++++-------------
> >  include/linux/dax.h          | 14 --------------
> >  11 files changed, 36 insertions(+), 110 deletions(-)
> >
[..]               if (ext4_has_feature_inline_data(sb)) {
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index d07020a8eb9e3..163ceafbd8fd2 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
[..]
> > +     if (mp->m_super->s_blocksize != PAGE_SIZE) {
> > +             xfs_alert(mp,
> > +                     "DAX not supported for blocksize. Turning off DAX.\n");
>
> Newlines aren't needed at the end of extX_msg/xfs_alert format strings.

Thanks Darrick, I fixed those up.
