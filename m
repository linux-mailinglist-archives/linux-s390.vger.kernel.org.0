Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C4559600
	for <lists+linux-s390@lfdr.de>; Fri, 24 Jun 2022 11:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiFXJFV (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 24 Jun 2022 05:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiFXJFU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 24 Jun 2022 05:05:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30E534BFFD
        for <linux-s390@vger.kernel.org>; Fri, 24 Jun 2022 02:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656061518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0hr561ihhXsPhogsxkgvSPAdJWrnjtuolGrZFY+sf5U=;
        b=NJijTOzElsrqO6lb4OVHx0Mj13UzvZiAGmNRHd+DZ2jzKzsT2H/bQ7PuButx+xdFQHUxGy
        it8heBymlYyrFBSOShN2eBwo42OmCkVUAs0I420NgKjIADvLaBkXMh+BEAeZo+y4WhEwS1
        cB2bYLr/xoA94TzIVN3wDrHp4Ktn8Iw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-XfKEalfiO22Zh-Ojp3PAtw-1; Fri, 24 Jun 2022 05:05:15 -0400
X-MC-Unique: XfKEalfiO22Zh-Ojp3PAtw-1
Received: by mail-wr1-f71.google.com with SMTP id e5-20020adff345000000b0021b9f00e882so201001wrp.6
        for <linux-s390@vger.kernel.org>; Fri, 24 Jun 2022 02:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0hr561ihhXsPhogsxkgvSPAdJWrnjtuolGrZFY+sf5U=;
        b=2H3f5/icEcIn2g9MsjvmXm0kef7iFlcpE3gXXTXD/hygJW2KHFLNbFDMdsWwsi7ojU
         oh5eS2eVC5K+nZ1Cebss9wBS28SLN+CFtKIR/KhorZ4NU4cU53XdS709KlFsUGiIech0
         dTI/vVI9jR/dZIsV8izgK9/moWAIDACkP8FOm8UI3nNIV1srNsjWDTG4BNJfea/mo2+u
         VAfSWycAiviowerjPTYnWTg7ZWr3BgdlUWLiLDN9dKEiHdwv4K8qm0p4q5Fe2bJhylYH
         4s9qaxsXZPltyYEq6IWHqTQ8mhDw2wWQyUc8TgXUyYHDF7swhnlxkUGoChwwxFeUOoNu
         4WsA==
X-Gm-Message-State: AJIora+2thkLDWoGAOowURdcnZHOERY2pgrkVpRrXSGT22/grCtD2rvw
        eGOwZuc10CtDpjSw0uL1Mjd17MsAmtfGAhTA0zvg9xAzulURVPPOQoGMsGcXE2x54TQIkkhFeQ5
        OnpFm7iudwIuMO9cXLALkfQ==
X-Received: by 2002:adf:e60c:0:b0:21b:8bac:70ff with SMTP id p12-20020adfe60c000000b0021b8bac70ffmr12444225wrm.467.1656061512349;
        Fri, 24 Jun 2022 02:05:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uoe3m5qiYscNMmz7DE+gitHceKjGYr+ohkPwz4GHeoypqq3Oxw5JCxX+Nwl+a0MHZpdtfRxA==
X-Received: by 2002:adf:e60c:0:b0:21b:8bac:70ff with SMTP id p12-20020adfe60c000000b0021b8bac70ffmr12444202wrm.467.1656061512057;
        Fri, 24 Jun 2022 02:05:12 -0700 (PDT)
Received: from redhat.com ([2.55.188.216])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c230500b0039c8a22554bsm2100129wmo.27.2022.06.24.02.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 02:05:11 -0700 (PDT)
Date:   Fri, 24 Jun 2022 05:05:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Jason Wang <jasowang@redhat.com>, ben@decadent.org.uk,
        cohuck@redhat.com, pasic@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] virtio: disable notification hardening by default
Message-ID: <20220624050500-mutt-send-email-mst@kernel.org>
References: <20220622012940.21441-1-jasowang@redhat.com>
 <1656060115.233734-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656060115.233734-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jun 24, 2022 at 04:41:55PM +0800, Xuan Zhuo wrote:
> On Wed, 22 Jun 2022 09:29:40 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > We try to harden virtio device notifications in 8b4ec69d7e09 ("virtio:
> > harden vring IRQ"). It works with the assumption that the driver or
> > core can properly call virtio_device_ready() at the right
> > place. Unfortunately, this seems to be not true and uncover various
> > bugs of the existing drivers, mainly the issue of using
> > virtio_device_ready() incorrectly.
> >
> > So let's having a Kconfig option and disable it by default. It gives
> > us a breath to fix the drivers and then we can consider to enable it
> > by default.
> 
> 
> hi, I have a question.
> 
> What should we do when the queue is reset and CONFIG_VIRTIO_HARDEN_NOTIFICATION
> is off?
> 
> Since disable_irq() cannot be used, we should trust the device not to send irqs
> again. So we don't have to do anything?

yes

> Thanks.
> 
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes since V2:
> > - Tweak the Kconfig help
> > - Add comment for the read_lock() pairing in virtio_ccw
> > ---
> >  drivers/s390/virtio/virtio_ccw.c |  9 ++++++++-
> >  drivers/virtio/Kconfig           | 13 +++++++++++++
> >  drivers/virtio/virtio.c          |  2 ++
> >  drivers/virtio/virtio_ring.c     | 12 ++++++++++++
> >  include/linux/virtio_config.h    |  2 ++
> >  5 files changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index 97e51c34e6cf..1f6a358f65f0 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -1136,8 +1136,13 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >  			vcdev->err = -EIO;
> >  	}
> >  	virtio_ccw_check_activity(vcdev, activity);
> > -	/* Interrupts are disabled here */
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> > +	/*
> > +	 * Paried with virtio_ccw_synchronize_cbs() and interrupts are
> > +	 * disabled here.
> > +	 */
> >  	read_lock(&vcdev->irq_lock);
> > +#endif
> >  	for_each_set_bit(i, indicators(vcdev),
> >  			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> >  		/* The bit clear must happen before the vring kick. */
> > @@ -1146,7 +1151,9 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >  		vq = virtio_ccw_vq_by_ind(vcdev, i);
> >  		vring_interrupt(0, vq);
> >  	}
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >  	read_unlock(&vcdev->irq_lock);
> > +#endif
> >  	if (test_bit(0, indicators2(vcdev))) {
> >  		virtio_config_changed(&vcdev->vdev);
> >  		clear_bit(0, indicators2(vcdev));
> > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > index b5adf6abd241..c04f370a1e5c 100644
> > --- a/drivers/virtio/Kconfig
> > +++ b/drivers/virtio/Kconfig
> > @@ -35,6 +35,19 @@ menuconfig VIRTIO_MENU
> >
> >  if VIRTIO_MENU
> >
> > +config VIRTIO_HARDEN_NOTIFICATION
> > +        bool "Harden virtio notification"
> > +        help
> > +          Enable this to harden the device notifications and suppress
> > +          those that happen at a time where notifications are illegal.
> > +
> > +          Experimental: Note that several drivers still have bugs that
> > +          may cause crashes or hangs when correct handling of
> > +          notifications is enforced; depending on the subset of
> > +          drivers and devices you use, this may or may not work.
> > +
> > +          If unsure, say N.
> > +
> >  config VIRTIO_PCI
> >  	tristate "PCI driver for virtio devices"
> >  	depends on PCI
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index ef04a96942bf..21dc08d2f32d 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -220,6 +220,7 @@ static int virtio_features_ok(struct virtio_device *dev)
> >   * */
> >  void virtio_reset_device(struct virtio_device *dev)
> >  {
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >  	/*
> >  	 * The below virtio_synchronize_cbs() guarantees that any
> >  	 * interrupt for this line arriving after
> > @@ -228,6 +229,7 @@ void virtio_reset_device(struct virtio_device *dev)
> >  	 */
> >  	virtio_break_device(dev);
> >  	virtio_synchronize_cbs(dev);
> > +#endif
> >
> >  	dev->config->reset(dev);
> >  }
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 13a7348cedff..d9d3b6e201fb 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1688,7 +1688,11 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >  	vq->we_own_ring = true;
> >  	vq->notify = notify;
> >  	vq->weak_barriers = weak_barriers;
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >  	vq->broken = true;
> > +#else
> > +	vq->broken = false;
> > +#endif
> >  	vq->last_used_idx = 0;
> >  	vq->event_triggered = false;
> >  	vq->num_added = 0;
> > @@ -2135,9 +2139,13 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> >  	}
> >
> >  	if (unlikely(vq->broken)) {
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >  		dev_warn_once(&vq->vq.vdev->dev,
> >  			      "virtio vring IRQ raised before DRIVER_OK");
> >  		return IRQ_NONE;
> > +#else
> > +		return IRQ_HANDLED;
> > +#endif
> >  	}
> >
> >  	/* Just a hint for performance: so it's ok that this can be racy! */
> > @@ -2180,7 +2188,11 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >  	vq->we_own_ring = false;
> >  	vq->notify = notify;
> >  	vq->weak_barriers = weak_barriers;
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >  	vq->broken = true;
> > +#else
> > +	vq->broken = false;
> > +#endif
> >  	vq->last_used_idx = 0;
> >  	vq->event_triggered = false;
> >  	vq->num_added = 0;
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index 9a36051ceb76..d15c3cdda2d2 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -257,6 +257,7 @@ void virtio_device_ready(struct virtio_device *dev)
> >
> >  	WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> >
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >  	/*
> >  	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
> >  	 * will see the driver specific setup if it sees vq->broken
> > @@ -264,6 +265,7 @@ void virtio_device_ready(struct virtio_device *dev)
> >  	 */
> >  	virtio_synchronize_cbs(dev);
> >  	__virtio_unbreak_device(dev);
> > +#endif
> >  	/*
> >  	 * The transport should ensure the visibility of vq->broken
> >  	 * before setting DRIVER_OK. See the comments for the transport
> > --
> > 2.25.1
> >
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization

