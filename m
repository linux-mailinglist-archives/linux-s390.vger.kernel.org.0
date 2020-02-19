Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D6016398D
	for <lists+linux-s390@lfdr.de>; Wed, 19 Feb 2020 02:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgBSBrL (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 18 Feb 2020 20:47:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51822 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgBSBrL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 Feb 2020 20:47:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id t23so4736938wmi.1;
        Tue, 18 Feb 2020 17:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0fVrJXKQFBq1+DGIaqCpMFpVnwhHK6KBaU4A547suOs=;
        b=YLgqtn1vXiFmrY2qtcO4cITsJLHu/AVbBSZEJXUjgEko2za6mFlRXo65+dWkQXKRgO
         oyBH45ZP6ovZa90w72vhBPA/kdwQ5l4Wb6ww2v4tsfqrpiNr7wJJr6qDkQxGAq6UNzYu
         7/x8FMTWoPNKGNhE4+jxj9C/trMmqmjjwxMJZujH5pncP7uKTDGvYc9sUwjK8KZYa6Nb
         fGR0/n70ccFqpNmW5VzoivbPHUQrUmfIbjH3P/GH2fkkj2J908pE1+IOMjtK0wRvkR64
         3oBrPq0e4MK8O9EwGEEJSyHaZUvoBsFww7Px/X0M//l5pky9UaU1PoheuYo2Bn2CYrML
         ehUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fVrJXKQFBq1+DGIaqCpMFpVnwhHK6KBaU4A547suOs=;
        b=MXkOhgX6Ei82z1ra9Cc8UKEvBMCe+y8M5/JhbL1DtDG++2Q+REwCO/8jFl6EgOfoyv
         jFt9+RuY3ynXqv/SzVUpXtbEsqZJvtpyb4Fdtg4EftXrbaAJ3uUSvW3KCfGyIVqVhZqk
         zO8R5Prr6jyb2cn7+XExSomrk3Grrnw2xONSPIV7AegeHX8go2Y5ji7tiYmHlUXjZcV4
         pkgfPSrDzft3lL9Ln4YVTf/6kV2Je6H9g5382t27UK4fk6LxSXAVNLoEM302vhOOkvTv
         7YOwKZet2QH3Y/Sp40M0KqUhP7G+3yGIHz+m0f2ds4iIxJn4lD+lC4wEAjxgvIZW74fe
         EWOQ==
X-Gm-Message-State: APjAAAWrPWoLW1ZZNDfNZyWBn8LJHmgAlEWgEaGoCf1d5iRPuoSNTZTy
        WGuW9ht9DO1P1lQ3jFF80WZyChMaQWq9FtxPp8Y=
X-Google-Smtp-Source: APXvYqz/18W0f7bNjt6tGI58SVmP1FmnZYrDg6ZokZyrHZqy2s5BaPpIsHcEE+bP4h8WKGWdiuCoYqOW2DZrhZYGBqA=
X-Received: by 2002:a1c:5441:: with SMTP id p1mr6603389wmi.161.1582076827865;
 Tue, 18 Feb 2020 17:47:07 -0800 (PST)
MIME-Version: 1.0
References: <20200213123728.61216-1-pasic@linux.ibm.com> <20200213123728.61216-2-pasic@linux.ibm.com>
 <CACVXFVNiADTW_vLVc1bUSa0CoViLbVzoMnSJW4=sx=MCE-xUPw@mail.gmail.com> <20200218133531.3eb08120.pasic@linux.ibm.com>
In-Reply-To: <20200218133531.3eb08120.pasic@linux.ibm.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 19 Feb 2020 09:46:56 +0800
Message-ID: <CACVXFVPBPCzr+sfQ4HOw1DNPGnEfp+5BLqQkXWQgkaBKqr3yVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio-blk: fix hw_queue stopped on arbitrary error
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Feb 18, 2020 at 8:35 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Tue, 18 Feb 2020 10:21:18 +0800
> Ming Lei <tom.leiming@gmail.com> wrote:
>
> > On Thu, Feb 13, 2020 at 8:38 PM Halil Pasic <pasic@linux.ibm.com> wrote:
> > >
> > > Since nobody else is going to restart our hw_queue for us, the
> > > blk_mq_start_stopped_hw_queues() is in virtblk_done() is not sufficient
> > > necessarily sufficient to ensure that the queue will get started again.
> > > In case of global resource outage (-ENOMEM because mapping failure,
> > > because of swiotlb full) our virtqueue may be empty and we can get
> > > stuck with a stopped hw_queue.
> > >
> > > Let us not stop the queue on arbitrary errors, but only on -EONSPC which
> > > indicates a full virtqueue, where the hw_queue is guaranteed to get
> > > started by virtblk_done() before when it makes sense to carry on
> > > submitting requests. Let us also remove a stale comment.
> >
> > The generic solution may be to stop queue only when there is any
> > in-flight request
> > not completed.
> >
>
> I think this is a pretty close to that. The queue is stopped only on
> ENOSPC, which means virtqueue is full.
>
> > Checking -ENOMEM may not be enough, given -EIO can be returned from
> > virtqueue_add()
> > too in case of dma map failure.
>
> I'm not checking on -ENOMEM. So the queue would not be stopped on EIO.
> Maybe I'm misunderstanding something In any case, please have another
> look at the diff, and if your concerns persist please help me understand.

Looks I misread the patch, and this patch is fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming Lei
