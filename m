Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB4955E161
	for <lists+linux-s390@lfdr.de>; Tue, 28 Jun 2022 15:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiF0Jwv (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 27 Jun 2022 05:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbiF0Jwj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 27 Jun 2022 05:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DAD06409
        for <linux-s390@vger.kernel.org>; Mon, 27 Jun 2022 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656323557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FA4/e7nzPal3eOwEx0TnFAtrjsOunXWeNfCJ/Hz8a2U=;
        b=E94xR2tIoVmgJkkbDO/iE6lTxM2qGCcCHiHUAVi1V+bYE+pCpRqqgw8VbTK5OesDfxrxwJ
        Czf3AONumuPUGB92yYvEoKrDZwEVBMnf1fa4adUIj1/wj2+vYo5x1yN6B8LgjYfAGAxlHH
        zZFnKAKAnDAjYbWOrLYcm2Igbr/S6Wo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-gUsKBuYiPrCh22zHbngVDg-1; Mon, 27 Jun 2022 05:52:34 -0400
X-MC-Unique: gUsKBuYiPrCh22zHbngVDg-1
Received: by mail-wm1-f71.google.com with SMTP id i5-20020a1c3b05000000b003a02b027e53so7080635wma.7
        for <linux-s390@vger.kernel.org>; Mon, 27 Jun 2022 02:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FA4/e7nzPal3eOwEx0TnFAtrjsOunXWeNfCJ/Hz8a2U=;
        b=q+QO12/xyXM3qTQcxv+YBThqemJmAp1oFIExazUqG1TM9nxi5fiy+ulK+jVdmrwkXl
         uAZIpuglAmqUi03UhVk/POvO/l36X9bTuNMHRsWC89jauR8VcUgDwcuw3TQTHw0hHLi9
         XJRacF7crc9xpay27DEpZHbgD7Vb2B1WQ/bX4BPu2vmvYML9OJ7ja3W5osDwcddA1X3H
         vR2xDc1pU2NVb1z2eUqzy67ud3QBiPH355YBWq0CiBHhUst0a/FVGVRXHHP+NLed00hg
         ODKX/aptp3xS7ew82mbcHFXWr137rodacZnBjLGP3MT32eCR/5W9DgNvbc6OUaOXHeKO
         Ulxg==
X-Gm-Message-State: AJIora/rP/vA+o/4VqkJnxM8mEs4twED7P4YWuQEjAJzTYHKxK+NeKNp
        Y3LCb/BFY7xlTqApQGCeo3RVk6HuKRCq1cpbLKUQY3KtvDggKigiLQWywD/YQGKZbooFYHoxkq5
        DVxHrc1SUCcCb9zMji+knjw==
X-Received: by 2002:a05:6000:5c5:b0:21b:9b11:9128 with SMTP id bh5-20020a05600005c500b0021b9b119128mr11703386wrb.492.1656323553155;
        Mon, 27 Jun 2022 02:52:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sCxfv3KriW5BqnNxFUoTxKqQuPPHKNNy+QToEfQnWFhS08FguZ0weFalXCc3i4zDfmqBw1gQ==
X-Received: by 2002:a05:6000:5c5:b0:21b:9b11:9128 with SMTP id bh5-20020a05600005c500b0021b9b119128mr11703360wrb.492.1656323552827;
        Mon, 27 Jun 2022 02:52:32 -0700 (PDT)
Received: from redhat.com ([2.54.45.90])
        by smtp.gmail.com with ESMTPSA id l16-20020adffe90000000b0021b9a4a75e2sm9888998wrr.30.2022.06.27.02.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:52:32 -0700 (PDT)
Date:   Mon, 27 Jun 2022 05:52:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        kvm <kvm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V3] virtio: disable notification hardening by default
Message-ID: <20220627053820-mutt-send-email-mst@kernel.org>
References: <20220622012940.21441-1-jasowang@redhat.com>
 <20220622025047-mutt-send-email-mst@kernel.org>
 <CACGkMEtJY2ioD0L8ifTrCPatG6-NqQ01V=d2L1FeoweKV74LaA@mail.gmail.com>
 <20220624022622-mutt-send-email-mst@kernel.org>
 <CACGkMEuurobpUWmDL8zmZ6T6Ygc0OEMx6vx2EDCSoGNnZQ0r-w@mail.gmail.com>
 <20220627024049-mutt-send-email-mst@kernel.org>
 <CACGkMEvrDXDN7FH1vKoYCob2rkxUsctE_=g61kzHSZ8tNNr6vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEvrDXDN7FH1vKoYCob2rkxUsctE_=g61kzHSZ8tNNr6vA@mail.gmail.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 27, 2022 at 04:11:18PM +0800, Jason Wang wrote:
> On Mon, Jun 27, 2022 at 3:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jun 27, 2022 at 10:50:17AM +0800, Jason Wang wrote:
> > > On Fri, Jun 24, 2022 at 2:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Jun 22, 2022 at 03:09:31PM +0800, Jason Wang wrote:
> > > > > On Wed, Jun 22, 2022 at 3:03 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Wed, Jun 22, 2022 at 09:29:40AM +0800, Jason Wang wrote:
> > > > > > > We try to harden virtio device notifications in 8b4ec69d7e09 ("virtio:
> > > > > > > harden vring IRQ"). It works with the assumption that the driver or
> > > > > > > core can properly call virtio_device_ready() at the right
> > > > > > > place. Unfortunately, this seems to be not true and uncover various
> > > > > > > bugs of the existing drivers, mainly the issue of using
> > > > > > > virtio_device_ready() incorrectly.
> > > > > > >
> > > > > > > So let's having a Kconfig option and disable it by default. It gives
> > > > > > > us a breath to fix the drivers and then we can consider to enable it
> > > > > > > by default.
> > > > > > >
> > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > >
> > > > > >
> > > > > > OK I will queue, but I think the problem is fundamental.
> > > > >
> > > > > If I understand correctly, you want some core IRQ work?
> > > >
> > > > Yes.
> > > >
> > > > > As discussed
> > > > > before, it doesn't solve all the problems, we still need to do per
> > > > > driver audit.
> > > > >
> > > > > Thanks
> > > >
> > > > Maybe, but we don't need to tie things to device_ready then.
> > > > We can do
> > > >
> > > > - disable irqs
> > > > - device ready
> > > > - setup everything
> > > > - enable irqs
> > > >
> > > >
> > > > and this works for most things, the only issue is
> > > > this deadlocks if "setup everything" waits for interrupts.
> > > >
> > > >
> > > > With the current approach there's really no good time:
> > > > 1.- setup everything
> > > > - device ready
> > > >
> > > > can cause kicks before device is ready
> > > >
> > > > 2.- device ready
> > > > - setup everything
> > > >
> > > > can cause callbacks before setup.
> > > >
> > > > So I prefer the 1. and fix the hardening in the core.
> > >
> > > So my question is:
> > >
> > > 1) do similar hardening like config interrupt
> > > or
> > > 2) per transport notification work (e.g for PCI core IRQ work)
> > >
> > > 1) seems easier and universal, but we pay little overhead which could
> > > be eliminated by the config option.
> >
> > I doubt 1 is easy and I am not even sure core IRQ changes will help.
> 
> Core IRQ won't help in 1), the changes are limited in the virtio.
> 
> > My concern with adding overhead is that I'm not sure these are not just
> > wasted CPU cycles.  We spent a bunch of time on irq hardening and so far
> > we are still at the "all drivers need to be fixed" stage.
> 
> It's not the fault of hardening but the drivers. The hardening just
> expose those bugs.

Heh. Yea sure. But things work fine for people. What is the chance
your review found and fixed all driver bugs? After two attempts
I don't feel like hoping audit will fix all bugs.


> >
> > The reason config was kind of easy is that config interrupt is rarely
> > vital for device function so arbitrarily deferring that does not lead to
> > deadlocks - what you are trying to do with VQ interrupts is
> > fundamentally different. Things are especially bad if we just drop
> > an interrupt but deferring can lead to problems too.
> 
> I'm not sure I see the difference, disable_irq() stuffs also delay the
> interrupt processing until enable_irq().


Absolutely. I am not at all sure disable_irq fixes all problems.

> >
> > Consider as an example
> >     virtio-net: fix race between ndo_open() and virtio_device_ready()
> > if you just defer vq interrupts you get deadlocks.
> >
> >
> 
> I don't see a deadlock here, maybe you can show more detail on this?

What I mean is this: if we revert the above commit, things still
work (out of spec, but still). If we revert and defer interrupts until
device ready then ndo_open that triggers before device ready deadlocks.


> >
> > So, thinking about all this, how about a simple per vq flag meaning
> > "this vq was kicked since reset"?
> 
> And ignore the notification if vq is not kicked? It sounds like the
> callback needs to be synchronized with the kick.

Note we only need to synchronize it when it changes, which is
only during initialization and reset.


> >
> > If driver does not kick then it's not ready to get callbacks, right?
> >
> > Sounds quite clean, but we need to think through memory ordering
> > concerns - I guess it's only when we change the value so
> >         if (!vq->kicked) {
> >                 vq->kicked = true;
> >                 mb();
> >         }
> >
> > will do the trick, right?
> 
> There's no much difference with the existing approach:
> 
> 1) your proposal implicitly makes callbacks ready in virtqueue_kick()
> 2) my proposal explicitly makes callbacks ready via virtio_device_ready()
> 
> Both require careful auditing of all the existing drivers to make sure
> no kick before DRIVER_OK.

Jason, kick before DRIVER_OK is out of spec, sure. But it is unrelated
to hardening and in absence of config interrupts is generally easily
fixed just by sticking virtio_device_ready early in initialization.
With the current approach one has to *also* not do virtio_device_ready
too early - and it's really tricky.

With the proposal I think that we don't need to fix all drivers and
in my eyes that is a huge advantage because frankly I'm fine with
more work on strict spec compliance taking more than expected
but I would like the hardening work to finally be done.
I am not sure the amount of effort expended on the hardening here is
proportionate to the benefit it provides.



> >
> > need to think about the reset path - it already synchronizes callbacks
> > and already can lose interrupts so we just need to clear vq->kicked
> > before that, right?
> 
> Probably.
> 
> >
> >
> > > 2) seems require more work in the IRQ core and it can not work for all
> > > transports (e.g vDPA would be kind of difficult)
> > >
> > > Thanks
> >
> > Hmm I don't really get why would it be difficult.
> > VDPA is mostly PCI isn't it? With PCI both level INT#x and edge MSI
> > have interrupt masking support.
> 
> Yes, but consider the case of mlx5_vdpa, PCI stuff was hidden under
> the auxiliary bus. And that is the way another vendor will go.
> 
> Thanks

A bunch of callbacks will do it I guess.

> >
> >
> > > >
> > > >
> > > > > >
> > > > > >
> > > > > > > ---
> > > > > > > Changes since V2:
> > > > > > > - Tweak the Kconfig help
> > > > > > > - Add comment for the read_lock() pairing in virtio_ccw
> > > > > > > ---
> > > > > > >  drivers/s390/virtio/virtio_ccw.c |  9 ++++++++-
> > > > > > >  drivers/virtio/Kconfig           | 13 +++++++++++++
> > > > > > >  drivers/virtio/virtio.c          |  2 ++
> > > > > > >  drivers/virtio/virtio_ring.c     | 12 ++++++++++++
> > > > > > >  include/linux/virtio_config.h    |  2 ++
> > > > > > >  5 files changed, 37 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > > > > > > index 97e51c34e6cf..1f6a358f65f0 100644
> > > > > > > --- a/drivers/s390/virtio/virtio_ccw.c
> > > > > > > +++ b/drivers/s390/virtio/virtio_ccw.c
> > > > > > > @@ -1136,8 +1136,13 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> > > > > > >                       vcdev->err = -EIO;
> > > > > > >       }
> > > > > > >       virtio_ccw_check_activity(vcdev, activity);
> > > > > > > -     /* Interrupts are disabled here */
> > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > +     /*
> > > > > > > +      * Paried with virtio_ccw_synchronize_cbs() and interrupts are
> > > > > > > +      * disabled here.
> > > > > > > +      */
> > > > > > >       read_lock(&vcdev->irq_lock);
> > > > > > > +#endif
> > > > > > >       for_each_set_bit(i, indicators(vcdev),
> > > > > > >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> > > > > > >               /* The bit clear must happen before the vring kick. */
> > > > > > > @@ -1146,7 +1151,9 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> > > > > > >               vq = virtio_ccw_vq_by_ind(vcdev, i);
> > > > > > >               vring_interrupt(0, vq);
> > > > > > >       }
> > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > >       read_unlock(&vcdev->irq_lock);
> > > > > > > +#endif
> > > > > > >       if (test_bit(0, indicators2(vcdev))) {
> > > > > > >               virtio_config_changed(&vcdev->vdev);
> > > > > > >               clear_bit(0, indicators2(vcdev));
> > > > > > > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > > > > > > index b5adf6abd241..c04f370a1e5c 100644
> > > > > > > --- a/drivers/virtio/Kconfig
> > > > > > > +++ b/drivers/virtio/Kconfig
> > > > > > > @@ -35,6 +35,19 @@ menuconfig VIRTIO_MENU
> > > > > > >
> > > > > > >  if VIRTIO_MENU
> > > > > > >
> > > > > > > +config VIRTIO_HARDEN_NOTIFICATION
> > > > > > > +        bool "Harden virtio notification"
> > > > > > > +        help
> > > > > > > +          Enable this to harden the device notifications and suppress
> > > > > > > +          those that happen at a time where notifications are illegal.
> > > > > > > +
> > > > > > > +          Experimental: Note that several drivers still have bugs that
> > > > > > > +          may cause crashes or hangs when correct handling of
> > > > > > > +          notifications is enforced; depending on the subset of
> > > > > > > +          drivers and devices you use, this may or may not work.
> > > > > > > +
> > > > > > > +          If unsure, say N.
> > > > > > > +
> > > > > > >  config VIRTIO_PCI
> > > > > > >       tristate "PCI driver for virtio devices"
> > > > > > >       depends on PCI
> > > > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > > > > index ef04a96942bf..21dc08d2f32d 100644
> > > > > > > --- a/drivers/virtio/virtio.c
> > > > > > > +++ b/drivers/virtio/virtio.c
> > > > > > > @@ -220,6 +220,7 @@ static int virtio_features_ok(struct virtio_device *dev)
> > > > > > >   * */
> > > > > > >  void virtio_reset_device(struct virtio_device *dev)
> > > > > > >  {
> > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > >       /*
> > > > > > >        * The below virtio_synchronize_cbs() guarantees that any
> > > > > > >        * interrupt for this line arriving after
> > > > > > > @@ -228,6 +229,7 @@ void virtio_reset_device(struct virtio_device *dev)
> > > > > > >        */
> > > > > > >       virtio_break_device(dev);
> > > > > > >       virtio_synchronize_cbs(dev);
> > > > > > > +#endif
> > > > > > >
> > > > > > >       dev->config->reset(dev);
> > > > > > >  }
> > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > > index 13a7348cedff..d9d3b6e201fb 100644
> > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > @@ -1688,7 +1688,11 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > > > > > >       vq->we_own_ring = true;
> > > > > > >       vq->notify = notify;
> > > > > > >       vq->weak_barriers = weak_barriers;
> > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > >       vq->broken = true;
> > > > > > > +#else
> > > > > > > +     vq->broken = false;
> > > > > > > +#endif
> > > > > > >       vq->last_used_idx = 0;
> > > > > > >       vq->event_triggered = false;
> > > > > > >       vq->num_added = 0;
> > > > > > > @@ -2135,9 +2139,13 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> > > > > > >       }
> > > > > > >
> > > > > > >       if (unlikely(vq->broken)) {
> > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > >               dev_warn_once(&vq->vq.vdev->dev,
> > > > > > >                             "virtio vring IRQ raised before DRIVER_OK");
> > > > > > >               return IRQ_NONE;
> > > > > > > +#else
> > > > > > > +             return IRQ_HANDLED;
> > > > > > > +#endif
> > > > > > >       }
> > > > > > >
> > > > > > >       /* Just a hint for performance: so it's ok that this can be racy! */
> > > > > > > @@ -2180,7 +2188,11 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> > > > > > >       vq->we_own_ring = false;
> > > > > > >       vq->notify = notify;
> > > > > > >       vq->weak_barriers = weak_barriers;
> > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > >       vq->broken = true;
> > > > > > > +#else
> > > > > > > +     vq->broken = false;
> > > > > > > +#endif
> > > > > > >       vq->last_used_idx = 0;
> > > > > > >       vq->event_triggered = false;
> > > > > > >       vq->num_added = 0;
> > > > > > > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > > > > > > index 9a36051ceb76..d15c3cdda2d2 100644
> > > > > > > --- a/include/linux/virtio_config.h
> > > > > > > +++ b/include/linux/virtio_config.h
> > > > > > > @@ -257,6 +257,7 @@ void virtio_device_ready(struct virtio_device *dev)
> > > > > > >
> > > > > > >       WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > > > > > >
> > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > >       /*
> > > > > > >        * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > > > > > >        * will see the driver specific setup if it sees vq->broken
> > > > > > > @@ -264,6 +265,7 @@ void virtio_device_ready(struct virtio_device *dev)
> > > > > > >        */
> > > > > > >       virtio_synchronize_cbs(dev);
> > > > > > >       __virtio_unbreak_device(dev);
> > > > > > > +#endif
> > > > > > >       /*
> > > > > > >        * The transport should ensure the visibility of vq->broken
> > > > > > >        * before setting DRIVER_OK. See the comments for the transport
> > > > > > > --
> > > > > > > 2.25.1
> > > > > >
> > > >
> >

