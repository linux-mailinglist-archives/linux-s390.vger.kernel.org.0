Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C52555F4D8
	for <lists+linux-s390@lfdr.de>; Wed, 29 Jun 2022 06:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiF2EHc (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 29 Jun 2022 00:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiF2EHb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 29 Jun 2022 00:07:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F5F035275
        for <linux-s390@vger.kernel.org>; Tue, 28 Jun 2022 21:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656475649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4okYHEm4SgM9nOKI+uhdQmjDfrAtAyFZ6PRSnlTGfAM=;
        b=COexMbo5YW1uQMIDs7H/yoQ8fQCcmaXW3TAWQ2yjtrG1C8/qDQFqCrd677d51RgCeEz+9m
        mBrgH6/wBwrzPUKqNq++Uq1jCYuuG5M/FnFb2+o2xXot6QQOza7roXTIf9AarrdF1TPGbP
        mT2cZr9o63XuJkZWk40F0VT2mgYcxR0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-8oTWBvRTPuu7MNJuG7D_IA-1; Wed, 29 Jun 2022 00:07:24 -0400
X-MC-Unique: 8oTWBvRTPuu7MNJuG7D_IA-1
Received: by mail-lf1-f71.google.com with SMTP id o7-20020a056512230700b004810a865709so4828923lfu.3
        for <linux-s390@vger.kernel.org>; Tue, 28 Jun 2022 21:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4okYHEm4SgM9nOKI+uhdQmjDfrAtAyFZ6PRSnlTGfAM=;
        b=raK8ExmQCgqoiImhJLF63s7yPt3PZJU41DG4d52d8NlP7O7f+AQohUHMdeGiXx1EVu
         PTb/hHF8f4Sp+wsfnbsTr1UCr3jlFq9GCLewDSARDj10rpr+FScnZKTu5QgNhFQGIsDq
         Mi06Q4eZs/FiWEnfKaQOYH0gc8SrMzg4UoxbR03xYL7N0C+729pZ81S004/FKwAbhYMl
         c+U3RZe8WSVieadatv9D0x+YyjtuR9L6C0QOH2lrqgKiDr0GuW1pKkfHeFiWVB0cGWQ/
         E2OokdGpd+T7amrnBHDH68Zl080ryJVM3Q/AXXd19n/ishsGAGLMLouRmfzi4WpfJBHO
         xhSQ==
X-Gm-Message-State: AJIora/xD67b1latXjCuo2uPu5bBkiVXq5IyLrLiM+pll6RSbMDCSsOT
        l7WdXYuRQl0xytGdLa+AuLuoMqGXFJ0qzgdSxPt2hxv3GrCf7YxE6rq33v2k5pnbTX5dfGzx62z
        hJOfbfuVV7NhzdW1cfp8iqR5YKBbDbWTw4JOVNA==
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id p37-20020a05651213a500b0047dc1d9dea8mr743985lfa.442.1656475642786;
        Tue, 28 Jun 2022 21:07:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vg0eKDPEsjjzW+CPIT1Y0L4q3DMFK9dyxcn9lQgocnHDq6YeN4AEHNv2YVAh1J7Dd8f2je0BPr2Mg1VXBBSmo=
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id
 p37-20020a05651213a500b0047dc1d9dea8mr743957lfa.442.1656475642324; Tue, 28
 Jun 2022 21:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220622012940.21441-1-jasowang@redhat.com> <20220622025047-mutt-send-email-mst@kernel.org>
 <CACGkMEtJY2ioD0L8ifTrCPatG6-NqQ01V=d2L1FeoweKV74LaA@mail.gmail.com>
 <20220624022622-mutt-send-email-mst@kernel.org> <CACGkMEuurobpUWmDL8zmZ6T6Ygc0OEMx6vx2EDCSoGNnZQ0r-w@mail.gmail.com>
 <20220627024049-mutt-send-email-mst@kernel.org> <CACGkMEvrDXDN7FH1vKoYCob2rkxUsctE_=g61kzHSZ8tNNr6vA@mail.gmail.com>
 <20220627053820-mutt-send-email-mst@kernel.org> <CACGkMEvcs+9_SHmO1s3nyzgU7oq7jhU2gircVVR3KDsGDikh5Q@mail.gmail.com>
 <20220628004614-mutt-send-email-mst@kernel.org> <CACGkMEsC4A+3WejLSOZoH3enXtai=+JyRNbxcpzK4vODYzhaFw@mail.gmail.com>
In-Reply-To: <CACGkMEsC4A+3WejLSOZoH3enXtai=+JyRNbxcpzK4vODYzhaFw@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 29 Jun 2022 12:07:11 +0800
Message-ID: <CACGkMEvu0D0XD7udz0ebVjNM0h5+K9Rjd-5ed=PY_+-aduzG2g@mail.gmail.com>
Subject: Re: [PATCH V3] virtio: disable notification hardening by default
To:     "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 28, 2022 at 2:17 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Tue, Jun 28, 2022 at 1:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jun 28, 2022 at 11:49:12AM +0800, Jason Wang wrote:
> > > > Heh. Yea sure. But things work fine for people. What is the chance
> > > > your review found and fixed all driver bugs?
> > >
> > > I don't/can't audit all bugs but the race between open/close against
> > > ready/reset. It looks to me a good chance to fix them all but if you
> > > think differently, let me know
> > >
> > > > After two attempts
> > > > I don't feel like hoping audit will fix all bugs.
> > >
> > > I've started the auditing and have 15+ patches in the queue. (only
> > > covers bluetooth, console, pmem, virtio-net and caif). Spotting the
> > > issue is not hard but the testing, It would take at least the time of
> > > one release to finalize I guess.
> >
> > Absolutely. So I am looking for a way to implement hardening that does
> > not break existing drivers.
>
> I totally agree with you to seek a way without bothering the drivers.
> Just wonder if this is possbile.
>
> >
> >
> > > >
> > > >
> > > > > >
> > > > > > The reason config was kind of easy is that config interrupt is rarely
> > > > > > vital for device function so arbitrarily deferring that does not lead to
> > > > > > deadlocks - what you are trying to do with VQ interrupts is
> > > > > > fundamentally different. Things are especially bad if we just drop
> > > > > > an interrupt but deferring can lead to problems too.
> > > > >
> > > > > I'm not sure I see the difference, disable_irq() stuffs also delay the
> > > > > interrupt processing until enable_irq().
> > > >
> > > >
> > > > Absolutely. I am not at all sure disable_irq fixes all problems.
> > > >
> > > > > >
> > > > > > Consider as an example
> > > > > >     virtio-net: fix race between ndo_open() and virtio_device_ready()
> > > > > > if you just defer vq interrupts you get deadlocks.
> > > > > >
> > > > > >
> > > > >
> > > > > I don't see a deadlock here, maybe you can show more detail on this?
> > > >
> > > > What I mean is this: if we revert the above commit, things still
> > > > work (out of spec, but still). If we revert and defer interrupts until
> > > > device ready then ndo_open that triggers before device ready deadlocks.
> > >
> > > Ok, I guess you meant on a hypervisor that is strictly written with spec.
> >
> > I mean on hypervisor that starts processing queues after getting a kick
> > even without DRIVER_OK.
>
> Oh right.
>
> >
> > > >
> > > >
> > > > > >
> > > > > > So, thinking about all this, how about a simple per vq flag meaning
> > > > > > "this vq was kicked since reset"?
> > > > >
> > > > > And ignore the notification if vq is not kicked? It sounds like the
> > > > > callback needs to be synchronized with the kick.
> > > >
> > > > Note we only need to synchronize it when it changes, which is
> > > > only during initialization and reset.
> > >
> > > Yes.
> > >
> > > >
> > > >
> > > > > >
> > > > > > If driver does not kick then it's not ready to get callbacks, right?
> > > > > >
> > > > > > Sounds quite clean, but we need to think through memory ordering
> > > > > > concerns - I guess it's only when we change the value so
> > > > > >         if (!vq->kicked) {
> > > > > >                 vq->kicked = true;
> > > > > >                 mb();
> > > > > >         }
> > > > > >
> > > > > > will do the trick, right?
> > > > >
> > > > > There's no much difference with the existing approach:
> > > > >
> > > > > 1) your proposal implicitly makes callbacks ready in virtqueue_kick()
> > > > > 2) my proposal explicitly makes callbacks ready via virtio_device_ready()
> > > > >
> > > > > Both require careful auditing of all the existing drivers to make sure
> > > > > no kick before DRIVER_OK.
> > > >
> > > > Jason, kick before DRIVER_OK is out of spec, sure. But it is unrelated
> > > > to hardening
> > >
> > > Yes but with your proposal, it seems to couple kick with DRIVER_OK somehow.
> >
> > I don't see how - my proposal ignores DRIVER_OK issues.
>
> Yes, what I meant is, in your proposal, the first kick after rest is a
> hint that the driver is ok (but actually it could not).
>
> >
> > > > and in absence of config interrupts is generally easily
> > > > fixed just by sticking virtio_device_ready early in initialization.
> > >
> > > So if the kick is done before the subsystem registration, there's
> > > still a window in the middle (assuming we stick virtio_device_ready()
> > > early):
> > >
> > > virtio_device_ready()
> > > virtqueue_kick()
> > > /* the window */
> > > subsystem_registration()
> >
> > Absolutely, however, I do not think we really have many such drivers
> > since this has been known as a wrong thing to do since the beginning.
> > Want to try to find any?
>
> Yes, let me try and update.

This is basically the device that have an RX queue, so I've found the
following drivers:

scmi, mac80211_hwsim, vsock, bt, balloon.

>
> >I couldn't ... except maybe bluetooth
> > but that's just maintainer nacking fixes saying he'll fix it
> > his way ...
> >
> > > And during remove(), we get another window:
> > >
> > > subsysrem_unregistration()
> > > /* the window */
> > > virtio_device_reset()
> >
> > Same here.

Basically for the drivers that set driver_ok before registration, so
we have a lot:

blk, net, mac80211_hwsim, scsi, vsock, bt, crypto, gpio, gpu, i2c,
iommu, caif, pmem, input, mem

So I think there's no easy way to harden the notification without
auditing the driver one by one (especially considering the driver may
use bh or workqueue). The problem is the notification hardening
depends on a correct or race-free probe/remove. So we need to fix the
issues in probe/remove then do the hardening on the notification.

Thanks

> >
> > > if we do reset before, we may end up with other issues like deadlock.
> > >
> > > So I think it's probably very hard to fix issues only at the virtio
> > > core since we need subsystem specific knowledge to make sure
> > > everything is synchronized.
> >
> > How many drivers do you see with the issue above?
>
> E.g for virtio-net, except for the ndo_open()/driver_ok races I
> spotted another two.
>
> > As compared to yours which has 16 patches just in your queue.
> >
> > > > With the current approach one has to *also* not do virtio_device_ready
> > > > too early - and it's really tricky.
> > >
> > > Not sure how much we differ here, during the probe driver can just
> > > place the virtio_device_ready() after the kick.
> >
> > Not so easy. For example, consider virtio net without your
> > locking change. kick is part of a command vq operation
> > which does not directly have anything to do with probe.
> > Same for many other devices - once you register,
> > linux can send commands immediately.
> > Yes we can invent per device flags and locking rules to
> > try and suppress commands until device_ready. I am not
> > all that happy with this idea to be frank ...
>
> Actuall, I meant we need to depend on the subsystem facilities to
> handle this (e.g the rtnl_lock() ndo_XYZ) instead of inventing per
> driver flags. I believe virtio is not the only driver that suffers
> from those races.
>
> >
> >
> > > >
> > > > With the proposal I think that we don't need to fix all drivers and
> > > > in my eyes that is a huge advantage because frankly I'm fine with
> > > > more work on strict spec compliance taking more than expected
> > > > but I would like the hardening work to finally be done.
> > >
> > > Ok, but what I meant is, with your proposal if a buggy drive kicks
> > > before DRIVER_OK, it suppresses the effect of hardening?
> >
> > I don't see how. DRIVER_OK is for device's benefit, guest does not need
> > it.
> >
> > > > I am not sure the amount of effort expended on the hardening here is
> > > > proportionate to the benefit it provides.
> > >
> > > Probably, but we received those bug reports from the confidential
> > > computing guys.
> > >
> > > Or can we choose to go another way, let the kconfig option enabled for
> > > TDX/SEV, and then fix the bugs only if it is reported?
> >
> > Nah that's really fragmenting out userbase.
>
> True.
>
> >
> > > >
> > > >
> > > >
> > > > > >
> > > > > > need to think about the reset path - it already synchronizes callbacks
> > > > > > and already can lose interrupts so we just need to clear vq->kicked
> > > > > > before that, right?
> > > > >
> > > > > Probably.
> > > > >
> > > > > >
> > > > > >
> > > > > > > 2) seems require more work in the IRQ core and it can not work for all
> > > > > > > transports (e.g vDPA would be kind of difficult)
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > Hmm I don't really get why would it be difficult.
> > > > > > VDPA is mostly PCI isn't it? With PCI both level INT#x and edge MSI
> > > > > > have interrupt masking support.
> > > > >
> > > > > Yes, but consider the case of mlx5_vdpa, PCI stuff was hidden under
> > > > > the auxiliary bus. And that is the way another vendor will go.
> > > > >
> > > > > Thanks
> > > >
> > > > A bunch of callbacks will do it I guess.
> > >
> > > Possible but looks like a layer violation, I think auxiliary stuff
> > > wants to hide the underlayer architecture. That is why I tend to do it
> > > in the virtio core. And actually, transport is freed to implement
> > > another layer of those synchronization if it wants.
> > >
> > > Thanks
> >
> > As usual a level of indirection will help with layering.
>
> Probably.
>
> Thanks
>
> >
> > > >
> > > > > >
> > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > ---
> > > > > > > > > > > Changes since V2:
> > > > > > > > > > > - Tweak the Kconfig help
> > > > > > > > > > > - Add comment for the read_lock() pairing in virtio_ccw
> > > > > > > > > > > ---
> > > > > > > > > > >  drivers/s390/virtio/virtio_ccw.c |  9 ++++++++-
> > > > > > > > > > >  drivers/virtio/Kconfig           | 13 +++++++++++++
> > > > > > > > > > >  drivers/virtio/virtio.c          |  2 ++
> > > > > > > > > > >  drivers/virtio/virtio_ring.c     | 12 ++++++++++++
> > > > > > > > > > >  include/linux/virtio_config.h    |  2 ++
> > > > > > > > > > >  5 files changed, 37 insertions(+), 1 deletion(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > > > > > > > > > > index 97e51c34e6cf..1f6a358f65f0 100644
> > > > > > > > > > > --- a/drivers/s390/virtio/virtio_ccw.c
> > > > > > > > > > > +++ b/drivers/s390/virtio/virtio_ccw.c
> > > > > > > > > > > @@ -1136,8 +1136,13 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> > > > > > > > > > >                       vcdev->err = -EIO;
> > > > > > > > > > >       }
> > > > > > > > > > >       virtio_ccw_check_activity(vcdev, activity);
> > > > > > > > > > > -     /* Interrupts are disabled here */
> > > > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > > > > +     /*
> > > > > > > > > > > +      * Paried with virtio_ccw_synchronize_cbs() and interrupts are
> > > > > > > > > > > +      * disabled here.
> > > > > > > > > > > +      */
> > > > > > > > > > >       read_lock(&vcdev->irq_lock);
> > > > > > > > > > > +#endif
> > > > > > > > > > >       for_each_set_bit(i, indicators(vcdev),
> > > > > > > > > > >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> > > > > > > > > > >               /* The bit clear must happen before the vring kick. */
> > > > > > > > > > > @@ -1146,7 +1151,9 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> > > > > > > > > > >               vq = virtio_ccw_vq_by_ind(vcdev, i);
> > > > > > > > > > >               vring_interrupt(0, vq);
> > > > > > > > > > >       }
> > > > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > > > >       read_unlock(&vcdev->irq_lock);
> > > > > > > > > > > +#endif
> > > > > > > > > > >       if (test_bit(0, indicators2(vcdev))) {
> > > > > > > > > > >               virtio_config_changed(&vcdev->vdev);
> > > > > > > > > > >               clear_bit(0, indicators2(vcdev));
> > > > > > > > > > > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > > > > > > > > > > index b5adf6abd241..c04f370a1e5c 100644
> > > > > > > > > > > --- a/drivers/virtio/Kconfig
> > > > > > > > > > > +++ b/drivers/virtio/Kconfig
> > > > > > > > > > > @@ -35,6 +35,19 @@ menuconfig VIRTIO_MENU
> > > > > > > > > > >
> > > > > > > > > > >  if VIRTIO_MENU
> > > > > > > > > > >
> > > > > > > > > > > +config VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > > > > +        bool "Harden virtio notification"
> > > > > > > > > > > +        help
> > > > > > > > > > > +          Enable this to harden the device notifications and suppress
> > > > > > > > > > > +          those that happen at a time where notifications are illegal.
> > > > > > > > > > > +
> > > > > > > > > > > +          Experimental: Note that several drivers still have bugs that
> > > > > > > > > > > +          may cause crashes or hangs when correct handling of
> > > > > > > > > > > +          notifications is enforced; depending on the subset of
> > > > > > > > > > > +          drivers and devices you use, this may or may not work.
> > > > > > > > > > > +
> > > > > > > > > > > +          If unsure, say N.
> > > > > > > > > > > +
> > > > > > > > > > >  config VIRTIO_PCI
> > > > > > > > > > >       tristate "PCI driver for virtio devices"
> > > > > > > > > > >       depends on PCI
> > > > > > > > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > > > > > > > > index ef04a96942bf..21dc08d2f32d 100644
> > > > > > > > > > > --- a/drivers/virtio/virtio.c
> > > > > > > > > > > +++ b/drivers/virtio/virtio.c
> > > > > > > > > > > @@ -220,6 +220,7 @@ static int virtio_features_ok(struct virtio_device *dev)
> > > > > > > > > > >   * */
> > > > > > > > > > >  void virtio_reset_device(struct virtio_device *dev)
> > > > > > > > > > >  {
> > > > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > > > >       /*
> > > > > > > > > > >        * The below virtio_synchronize_cbs() guarantees that any
> > > > > > > > > > >        * interrupt for this line arriving after
> > > > > > > > > > > @@ -228,6 +229,7 @@ void virtio_reset_device(struct virtio_device *dev)
> > > > > > > > > > >        */
> > > > > > > > > > >       virtio_break_device(dev);
> > > > > > > > > > >       virtio_synchronize_cbs(dev);
> > > > > > > > > > > +#endif
> > > > > > > > > > >
> > > > > > > > > > >       dev->config->reset(dev);
> > > > > > > > > > >  }
> > > > > > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > > > > > > index 13a7348cedff..d9d3b6e201fb 100644
> > > > > > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > > > > > @@ -1688,7 +1688,11 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > > > > > > > > > >       vq->we_own_ring = true;
> > > > > > > > > > >       vq->notify = notify;
> > > > > > > > > > >       vq->weak_barriers = weak_barriers;
> > > > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > > > >       vq->broken = true;
> > > > > > > > > > > +#else
> > > > > > > > > > > +     vq->broken = false;
> > > > > > > > > > > +#endif
> > > > > > > > > > >       vq->last_used_idx = 0;
> > > > > > > > > > >       vq->event_triggered = false;
> > > > > > > > > > >       vq->num_added = 0;
> > > > > > > > > > > @@ -2135,9 +2139,13 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> > > > > > > > > > >       }
> > > > > > > > > > >
> > > > > > > > > > >       if (unlikely(vq->broken)) {
> > > > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > > > >               dev_warn_once(&vq->vq.vdev->dev,
> > > > > > > > > > >                             "virtio vring IRQ raised before DRIVER_OK");
> > > > > > > > > > >               return IRQ_NONE;
> > > > > > > > > > > +#else
> > > > > > > > > > > +             return IRQ_HANDLED;
> > > > > > > > > > > +#endif
> > > > > > > > > > >       }
> > > > > > > > > > >
> > > > > > > > > > >       /* Just a hint for performance: so it's ok that this can be racy! */
> > > > > > > > > > > @@ -2180,7 +2188,11 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> > > > > > > > > > >       vq->we_own_ring = false;
> > > > > > > > > > >       vq->notify = notify;
> > > > > > > > > > >       vq->weak_barriers = weak_barriers;
> > > > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > > > >       vq->broken = true;
> > > > > > > > > > > +#else
> > > > > > > > > > > +     vq->broken = false;
> > > > > > > > > > > +#endif
> > > > > > > > > > >       vq->last_used_idx = 0;
> > > > > > > > > > >       vq->event_triggered = false;
> > > > > > > > > > >       vq->num_added = 0;
> > > > > > > > > > > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > > > > > > > > > > index 9a36051ceb76..d15c3cdda2d2 100644
> > > > > > > > > > > --- a/include/linux/virtio_config.h
> > > > > > > > > > > +++ b/include/linux/virtio_config.h
> > > > > > > > > > > @@ -257,6 +257,7 @@ void virtio_device_ready(struct virtio_device *dev)
> > > > > > > > > > >
> > > > > > > > > > >       WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > > > > > > > > > >
> > > > > > > > > > > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > > > > > > > > > >       /*
> > > > > > > > > > >        * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > > > > > > > > > >        * will see the driver specific setup if it sees vq->broken
> > > > > > > > > > > @@ -264,6 +265,7 @@ void virtio_device_ready(struct virtio_device *dev)
> > > > > > > > > > >        */
> > > > > > > > > > >       virtio_synchronize_cbs(dev);
> > > > > > > > > > >       __virtio_unbreak_device(dev);
> > > > > > > > > > > +#endif
> > > > > > > > > > >       /*
> > > > > > > > > > >        * The transport should ensure the visibility of vq->broken
> > > > > > > > > > >        * before setting DRIVER_OK. See the comments for the transport
> > > > > > > > > > > --
> > > > > > > > > > > 2.25.1
> > > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> >

