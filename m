Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64E1548307
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jun 2022 11:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiFMI75 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 13 Jun 2022 04:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiFMI74 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 13 Jun 2022 04:59:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4721D657F
        for <linux-s390@vger.kernel.org>; Mon, 13 Jun 2022 01:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655110793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XSAZOqSg+uemZuWimeUX9GGyMVH7VjickHB170GvUVI=;
        b=O6fjRPjdUI9k6U0EGs7/Ybl1SXP1t3TgZdQ/SxeULwezA5Mib+W1ZaFXAn6chwLdOFz5Mb
        3ZE/7WQC1EmURoAJNQGQ8SWgt5bKiF0b3k0OQkLCazQmEh4keCziDUzpSnAxUUAxvkNFcr
        yKhZijRIChKyNTmKvFLmgfJU38kgzLE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-AWdatt2BPdqqX-7YE-ENfQ-1; Mon, 13 Jun 2022 04:59:51 -0400
X-MC-Unique: AWdatt2BPdqqX-7YE-ENfQ-1
Received: by mail-ed1-f70.google.com with SMTP id eh10-20020a0564020f8a00b0042dd9bf7c57so3564777edb.17
        for <linux-s390@vger.kernel.org>; Mon, 13 Jun 2022 01:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XSAZOqSg+uemZuWimeUX9GGyMVH7VjickHB170GvUVI=;
        b=vJ2eDqYU9NvWptA2ZDeEowIBn7V0j+xZwv2CfbXyf+d4obYQWCP7TEHsd31OtNIB6o
         mY+hQd1q40Ge+EkaGq/8nRGACUwVUtDZT781PGNO8LP/aG0TVIravm444GYrIjTPOhhs
         1HV/GUaYcl/EZ2KZrcQiaQks4DYp04XevpNIpGRoiVXvGtIU87XzJ7VgyqIor4xLKVQW
         E6XGGJwLtp+z91rutE0jkyw38S1VOfiBJwoUA5nMmpVNHPN93AFUg31sia15jEeo5MxT
         eantyua9S3SIlm66M8AELAorpeFHJyJwA9JUBd8O+0+E6dqb2WrKKJ2eYjpt+DkOta0w
         2ewQ==
X-Gm-Message-State: AOAM530SGcJGF8fmR/8s/2dLQ5C0k4wz006KIFaR6XRhJflX3boH2ymY
        s2mgCk1MGJxwgTYw6TM1rmi/AennQuuPZPR/l/GS0Ia3do745FvZvChC7xpNZag1ZWtAzzepxFH
        nAFqwuRenOmp5mWEs12bNTw==
X-Received: by 2002:aa7:da06:0:b0:42d:ca38:84ad with SMTP id r6-20020aa7da06000000b0042dca3884admr64922263eds.125.1655110790518;
        Mon, 13 Jun 2022 01:59:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZlkT3rt9xBIl6JGBANaaulptKk/JIh55+f5UAljKIFkmtoUekmDGQJNd7bzMXwfoGZNCbEg==
X-Received: by 2002:aa7:da06:0:b0:42d:ca38:84ad with SMTP id r6-20020aa7da06000000b0042dca3884admr64922245eds.125.1655110790312;
        Mon, 13 Jun 2022 01:59:50 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:107c:be5a:1a30:9f6d:4400:4adc])
        by smtp.gmail.com with ESMTPSA id vp5-20020a17090712c500b006f3ef214ddesm3576100ejb.68.2022.06.13.01.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 01:59:49 -0700 (PDT)
Date:   Mon, 13 Jun 2022 04:59:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH V6 8/9] virtio: harden vring IRQ
Message-ID: <20220613045606-mutt-send-email-mst@kernel.org>
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-9-jasowang@redhat.com>
 <20220611010747-mutt-send-email-mst@kernel.org>
 <CACGkMEtRP+0Xy63g0SF_y1avv=3rFv6P9+Z7kp9XBS5d+_py8w@mail.gmail.com>
 <20220613023337-mutt-send-email-mst@kernel.org>
 <CACGkMEs05ZisiPW+7H6Omp80MzmZWZCpc1mf5Vd99C3H-KUtgA@mail.gmail.com>
 <20220613041416-mutt-send-email-mst@kernel.org>
 <CACGkMEsT_fWdPxN1cTWOX=vu-ntp3Xo4j46-ZKALeSXr7DmJFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEsT_fWdPxN1cTWOX=vu-ntp3Xo4j46-ZKALeSXr7DmJFQ@mail.gmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 13, 2022 at 04:51:08PM +0800, Jason Wang wrote:
> On Mon, Jun 13, 2022 at 4:19 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jun 13, 2022 at 04:07:09PM +0800, Jason Wang wrote:
> > > On Mon, Jun 13, 2022 at 3:23 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Jun 13, 2022 at 01:26:59PM +0800, Jason Wang wrote:
> > > > > On Sat, Jun 11, 2022 at 1:12 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, May 27, 2022 at 02:01:19PM +0800, Jason Wang wrote:
> > > > > > > This is a rework on the previous IRQ hardening that is done for
> > > > > > > virtio-pci where several drawbacks were found and were reverted:
> > > > > > >
> > > > > > > 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
> > > > > > >    that is used by some device such as virtio-blk
> > > > > > > 2) done only for PCI transport
> > > > > > >
> > > > > > > The vq->broken is re-used in this patch for implementing the IRQ
> > > > > > > hardening. The vq->broken is set to true during both initialization
> > > > > > > and reset. And the vq->broken is set to false in
> > > > > > > virtio_device_ready(). Then vring_interrupt() can check and return
> > > > > > > when vq->broken is true. And in this case, switch to return IRQ_NONE
> > > > > > > to let the interrupt core aware of such invalid interrupt to prevent
> > > > > > > IRQ storm.
> > > > > > >
> > > > > > > The reason of using a per queue variable instead of a per device one
> > > > > > > is that we may need it for per queue reset hardening in the future.
> > > > > > >
> > > > > > > Note that the hardening is only done for vring interrupt since the
> > > > > > > config interrupt hardening is already done in commit 22b7050a024d7
> > > > > > > ("virtio: defer config changed notifications"). But the method that is
> > > > > > > used by config interrupt can't be reused by the vring interrupt
> > > > > > > handler because it uses spinlock to do the synchronization which is
> > > > > > > expensive.
> > > > > > >
> > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > > > Cc: Halil Pasic <pasic@linux.ibm.com>
> > > > > > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > > > > > Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> > > > > > > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > > > > > > Cc: linux-s390@vger.kernel.org
> > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > >
> > > > > >
> > > > > > Jason, I am really concerned by all the fallout.
> > > > > > I propose adding a flag to suppress the hardening -
> > > > > > this will be a debugging aid and a work around for
> > > > > > users if we find more buggy drivers.
> > > > > >
> > > > > > suppress_interrupt_hardening ?
> > > > >
> > > > > I can post a patch but I'm afraid if we disable it by default, it
> > > > > won't be used by the users so there's no way for us to receive the bug
> > > > > report. Or we need a plan to enable it by default.
> > > > >
> > > > > It's rc2, how about waiting for 1 and 2 rc? Or it looks better if we
> > > > > simply warn instead of disable it by default.
> > > > >
> > > > > Thanks
> > > >
> > > > I meant more like a flag in struct virtio_driver.
> > > > For now, could you audit all drivers which don't call _ready?
> > > > I found 5 of these:
> > > >
> > > > drivers/bluetooth/virtio_bt.c
> > >
> > > This driver seems to be fine, it doesn't use the device/vq in its probe().
> >
> >
> > But it calls hci_register_dev and that in turn queues all kind of
> > work. Also, can linux start using the device immediately after
> > it's registered?
> 
> So I think the driver is allowed to queue before DRIVER_OK.

it's not allowed to kick

> If yes,
> the only side effect is the delay of the tx interrupt after DRIVER_OK
> for a well behaved device.

your patches drop the interrupt though, it won't be just delayed.

> If not, we need to clarify it in the spec
> and call virtio_device_ready() before subsystem registration.

hmm, i don't get what we need to clarify

> >
> >
> > > > drivers/gpu/drm/virtio/virtgpu_drv.c
> > >
> > > It calles virtio_device_ready() in virtio_gpu_init(), and it looks to
> > > me the code is correct.
> >
> > OK.
> >
> > > > drivers/i2c/busses/i2c-virtio.c
> > > > drivers/net/caif/caif_virtio.c
> > > > drivers/nvdimm/virtio_pmem.c
> > >
> > > The above looks fine and we have three more:
> > >
> > > arm_scmi: probe() doesn't use vq
> > > mac80211_hwsim.c: doesn't use vq (only fill rx), but it kicks the rx,
> > > it looks to me we need a device_ready before the kick.
> > > virtio_rpmsg_bus.c: doesn't use vq
> > >
> > > I will post a patch for mac80211_hwsim.c.
> > > Thanks
> >
> > Same comments for all of the above. Might linux not start using the
> > device once it's registered?
> 
> It depends on the specific subsystem.
> 
> For the subsystem that can't use the device immediately, calling
> virtio_device_ready() after the subsystem's registration should be
> fine. E.g for the networking subsystem, the TX won't happen if
> ndo_open() is not called, calling virtio_device_ready() after
> netdev_register() seems to be fine.

exactly

> For the subsystem that can use the device immediately, if the
> subsystem does not depend on the result of a request in the probe to
> proceed, we are still fine. Since those requests will be proceed after
> DRIVER_OK.

Well first won't driver code normally kick as well?
And without kick, won't everything just be blocked?


> For the rest we need to do virtio_device_ready() before registration.
> 
> Thanks

Then we can get an interrupt for an unregistered device.


> >
> > > >
> > > >
> > > >
> > > >
> > > > > >
> > > > > >
> > > > > > > ---
> > > > > > >  drivers/s390/virtio/virtio_ccw.c       |  4 ++++
> > > > > > >  drivers/virtio/virtio.c                | 15 ++++++++++++---
> > > > > > >  drivers/virtio/virtio_mmio.c           |  5 +++++
> > > > > > >  drivers/virtio/virtio_pci_modern_dev.c |  5 +++++
> > > > > > >  drivers/virtio/virtio_ring.c           | 11 +++++++----
> > > > > > >  include/linux/virtio_config.h          | 20 ++++++++++++++++++++
> > > > > > >  6 files changed, 53 insertions(+), 7 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > > > > > > index c188e4f20ca3..97e51c34e6cf 100644
> > > > > > > --- a/drivers/s390/virtio/virtio_ccw.c
> > > > > > > +++ b/drivers/s390/virtio/virtio_ccw.c
> > > > > > > @@ -971,6 +971,10 @@ static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
> > > > > > >       ccw->flags = 0;
> > > > > > >       ccw->count = sizeof(status);
> > > > > > >       ccw->cda = (__u32)(unsigned long)&vcdev->dma_area->status;
> > > > > > > +     /* We use ssch for setting the status which is a serializing
> > > > > > > +      * instruction that guarantees the memory writes have
> > > > > > > +      * completed before ssch.
> > > > > > > +      */
> > > > > > >       ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_STATUS);
> > > > > > >       /* Write failed? We assume status is unchanged. */
> > > > > > >       if (ret)
> > > > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > > > > index aa1eb5132767..95fac4c97c8b 100644
> > > > > > > --- a/drivers/virtio/virtio.c
> > > > > > > +++ b/drivers/virtio/virtio.c
> > > > > > > @@ -220,6 +220,15 @@ static int virtio_features_ok(struct virtio_device *dev)
> > > > > > >   * */
> > > > > > >  void virtio_reset_device(struct virtio_device *dev)
> > > > > > >  {
> > > > > > > +     /*
> > > > > > > +      * The below virtio_synchronize_cbs() guarantees that any
> > > > > > > +      * interrupt for this line arriving after
> > > > > > > +      * virtio_synchronize_vqs() has completed is guaranteed to see
> > > > > > > +      * vq->broken as true.
> > > > > > > +      */
> > > > > > > +     virtio_break_device(dev);
> > > > > >
> > > > > > So make this conditional
> > > > > >
> > > > > > > +     virtio_synchronize_cbs(dev);
> > > > > > > +
> > > > > > >       dev->config->reset(dev);
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL_GPL(virtio_reset_device);
> > > > > > > @@ -428,6 +437,9 @@ int register_virtio_device(struct virtio_device *dev)
> > > > > > >       dev->config_enabled = false;
> > > > > > >       dev->config_change_pending = false;
> > > > > > >
> > > > > > > +     INIT_LIST_HEAD(&dev->vqs);
> > > > > > > +     spin_lock_init(&dev->vqs_list_lock);
> > > > > > > +
> > > > > > >       /* We always start by resetting the device, in case a previous
> > > > > > >        * driver messed it up.  This also tests that code path a little. */
> > > > > > >       virtio_reset_device(dev);
> > > > > > > @@ -435,9 +447,6 @@ int register_virtio_device(struct virtio_device *dev)
> > > > > > >       /* Acknowledge that we've seen the device. */
> > > > > > >       virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> > > > > > >
> > > > > > > -     INIT_LIST_HEAD(&dev->vqs);
> > > > > > > -     spin_lock_init(&dev->vqs_list_lock);
> > > > > > > -
> > > > > > >       /*
> > > > > > >        * device_add() causes the bus infrastructure to look for a matching
> > > > > > >        * driver.
> > > > > > > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > > > > > > index c9699a59f93c..f9a36bc7ac27 100644
> > > > > > > --- a/drivers/virtio/virtio_mmio.c
> > > > > > > +++ b/drivers/virtio/virtio_mmio.c
> > > > > > > @@ -253,6 +253,11 @@ static void vm_set_status(struct virtio_device *vdev, u8 status)
> > > > > > >       /* We should never be setting status to 0. */
> > > > > > >       BUG_ON(status == 0);
> > > > > > >
> > > > > > > +     /*
> > > > > > > +      * Per memory-barriers.txt, wmb() is not needed to guarantee
> > > > > > > +      * that the the cache coherent memory writes have completed
> > > > > > > +      * before writing to the MMIO region.
> > > > > > > +      */
> > > > > > >       writel(status, vm_dev->base + VIRTIO_MMIO_STATUS);
> > > > > > >  }
> > > > > > >
> > > > > > > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > > > > > > index 4093f9cca7a6..a0fa14f28a7f 100644
> > > > > > > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > > > > > > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > > > > > > @@ -467,6 +467,11 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
> > > > > > >  {
> > > > > > >       struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> > > > > > >
> > > > > > > +     /*
> > > > > > > +      * Per memory-barriers.txt, wmb() is not needed to guarantee
> > > > > > > +      * that the the cache coherent memory writes have completed
> > > > > > > +      * before writing to the MMIO region.
> > > > > > > +      */
> > > > > > >       vp_iowrite8(status, &cfg->device_status);
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL_GPL(vp_modern_set_status);
> > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > > index 9c231e1fded7..13a7348cedff 100644
> > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > @@ -1688,7 +1688,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > > > > > >       vq->we_own_ring = true;
> > > > > > >       vq->notify = notify;
> > > > > > >       vq->weak_barriers = weak_barriers;
> > > > > > > -     vq->broken = false;
> > > > > > > +     vq->broken = true;
> > > > > > >       vq->last_used_idx = 0;
> > > > > > >       vq->event_triggered = false;
> > > > > > >       vq->num_added = 0;
> > > > > >
> > > > > > and make this conditional
> > > > > >
> > > > > > > @@ -2134,8 +2134,11 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> > > > > > >               return IRQ_NONE;
> > > > > > >       }
> > > > > > >
> > > > > > > -     if (unlikely(vq->broken))
> > > > > > > -             return IRQ_HANDLED;
> > > > > > > +     if (unlikely(vq->broken)) {
> > > > > > > +             dev_warn_once(&vq->vq.vdev->dev,
> > > > > > > +                           "virtio vring IRQ raised before DRIVER_OK");
> > > > > > > +             return IRQ_NONE;
> > > > > > > +     }
> > > > > > >
> > > > > > >       /* Just a hint for performance: so it's ok that this can be racy! */
> > > > > > >       if (vq->event)
> > > > > > > @@ -2177,7 +2180,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> > > > > > >       vq->we_own_ring = false;
> > > > > > >       vq->notify = notify;
> > > > > > >       vq->weak_barriers = weak_barriers;
> > > > > > > -     vq->broken = false;
> > > > > > > +     vq->broken = true;
> > > > > > >       vq->last_used_idx = 0;
> > > > > > >       vq->event_triggered = false;
> > > > > > >       vq->num_added = 0;
> > > > > >
> > > > > > and make this conditional
> > > > > >
> > > > > > > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > > > > > > index 25be018810a7..d4edfd7d91bb 100644
> > > > > > > --- a/include/linux/virtio_config.h
> > > > > > > +++ b/include/linux/virtio_config.h
> > > > > > > @@ -256,6 +256,26 @@ void virtio_device_ready(struct virtio_device *dev)
> > > > > > >       unsigned status = dev->config->get_status(dev);
> > > > > > >
> > > > > > >       BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > > > > > > +
> > > > > > > +     /*
> > > > > > > +      * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > > > > > > +      * will see the driver specific setup if it sees vq->broken
> > > > > > > +      * as false (even if the notifications come before DRIVER_OK).
> > > > > > > +      */
> > > > > > > +     virtio_synchronize_cbs(dev);
> > > > > > > +     __virtio_unbreak_device(dev);
> > > > > > > +     /*
> > > > > > > +      * The transport should ensure the visibility of vq->broken
> > > > > > > +      * before setting DRIVER_OK. See the comments for the transport
> > > > > > > +      * specific set_status() method.
> > > > > > > +      *
> > > > > > > +      * A well behaved device will only notify a virtqueue after
> > > > > > > +      * DRIVER_OK, this means the device should "see" the coherenct
> > > > > > > +      * memory write that set vq->broken as false which is done by
> > > > > > > +      * the driver when it sees DRIVER_OK, then the following
> > > > > > > +      * driver's vring_interrupt() will see vq->broken as false so
> > > > > > > +      * we won't lose any notification.
> > > > > > > +      */
> > > > > > >       dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> > > > > > >  }
> > > > > > >
> > > > > > > --
> > > > > > > 2.25.1
> > > > > >
> > > >
> >

