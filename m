Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4B0161EE8
	for <lists+linux-s390@lfdr.de>; Tue, 18 Feb 2020 03:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgBRCVc (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 17 Feb 2020 21:21:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37835 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgBRCVc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Feb 2020 21:21:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id a6so1206974wme.2;
        Mon, 17 Feb 2020 18:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eY7gqSVNopqtgZAFLrrVT+eoXLnh2uTk4VjIyhxxVUI=;
        b=lWfEjZdwTlpzTJU/5rhFxfMC9DhmiD6MQKthqW76Hbv0XfOiGyqGDu5RldcdpYXDW8
         8VC2MGu7JmRBUL9fqnyzhiIDG3lvptGawu3597QnUhz3j5vLjUvlxqf/5+0NIUht2qA6
         uWtDKT3in5vo4L05ycc8PSKWD8SX6KfjeE/VrkPHoXR6vYccQNX6hznzbhKuUHFPgrjn
         dU8UTGnKjuMJikK87oHmZHLKnJRriEiSnKE3m9Jf9zKK0NQynG9nod5ORwABMAmNSD73
         iWWpflgLYPICza/RpijPeYAYt6nJdVlb+5kUCHV5nhUDfMDi/MN5OigyycC/QcKsiuKL
         UE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eY7gqSVNopqtgZAFLrrVT+eoXLnh2uTk4VjIyhxxVUI=;
        b=diIb5u/cC7YjyKDgObt8vLIZ/KwvoyLQVOPr981x3CLPhjr/kcIXAijrGQnaJUJTGJ
         IbvyWBTQjaqWFbftUYMfFZ44ecnIMhPkocFUy2eDCDkUcs9XuwOPHkzslvPlZGh9I+M4
         xk6zAe/sstRO0nfSo6jD5Lu4w0e7A9cQ3CKAPJ6R/8azy0vnsA0b1kgtoNi9dlpxevrN
         0qKPRDbzzwyS+f8RDyFhZhP3HD8L2JLhlav1QvdHACCEela60J00Yi4kvn2plvbHsvuV
         a9WvVfYGINUnkhmm+FWgjwMLY3CzN4tQ/TUbNuvSFgR9UJeL99LqcgaGpcXLfL3Eerux
         refg==
X-Gm-Message-State: APjAAAVo5HyfD+0qQdK5NuxkPmrWq7txi90AK/0kILPqLCQFuCawBRbe
        /xxRUc/58ny+g6QucpM/65m7kNSbl58cRlkPf1Md7cJGHa4=
X-Google-Smtp-Source: APXvYqyDtuMB29KXJ2WCyqWXVgI1TB7/0mLR6wN9PM4aCO4sInPlQNWZ2Ru4+ybFn+ncPUAjgjEnVEw1970/5hQdhZ8=
X-Received: by 2002:a1c:5441:: with SMTP id p1mr2198840wmi.161.1581992489535;
 Mon, 17 Feb 2020 18:21:29 -0800 (PST)
MIME-Version: 1.0
References: <20200213123728.61216-1-pasic@linux.ibm.com> <20200213123728.61216-2-pasic@linux.ibm.com>
In-Reply-To: <20200213123728.61216-2-pasic@linux.ibm.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 18 Feb 2020 10:21:18 +0800
Message-ID: <CACVXFVNiADTW_vLVc1bUSa0CoViLbVzoMnSJW4=sx=MCE-xUPw@mail.gmail.com>
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

On Thu, Feb 13, 2020 at 8:38 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> Since nobody else is going to restart our hw_queue for us, the
> blk_mq_start_stopped_hw_queues() is in virtblk_done() is not sufficient
> necessarily sufficient to ensure that the queue will get started again.
> In case of global resource outage (-ENOMEM because mapping failure,
> because of swiotlb full) our virtqueue may be empty and we can get
> stuck with a stopped hw_queue.
>
> Let us not stop the queue on arbitrary errors, but only on -EONSPC which
> indicates a full virtqueue, where the hw_queue is guaranteed to get
> started by virtblk_done() before when it makes sense to carry on
> submitting requests. Let us also remove a stale comment.

The generic solution may be to stop queue only when there is any
in-flight request
not completed.

Checking -ENOMEM may not be enough, given -EIO can be returned from
virtqueue_add()
too in case of dma map failure.

Thanks,
