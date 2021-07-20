Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523883D04E3
	for <lists+linux-s390@lfdr.de>; Wed, 21 Jul 2021 00:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhGTWPE (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 20 Jul 2021 18:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231727AbhGTWOX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Jul 2021 18:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626821696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JPmMSBIIRpMLR6pnHriNECIPx7e3cs1ugIoacnqy1RY=;
        b=cZvV1wtlzB1tQHzp2rAi7NWJwzWb3a0fquf0sv6MDm+7zSNVhwudaHpEWhYsaTHtlM4KhO
        8akgwPnl0JK/x60Hx6gBkmh0XC5Y9qnmIZ5cRRWBRPqQNbwxA/xb8pgdyu+1ceWoX/M6B6
        tVgEm8OM/Rc6V+8BohX+5aFrer0heBE=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-peRX8rdwN224MSDu-VxEgQ-1; Tue, 20 Jul 2021 18:54:54 -0400
X-MC-Unique: peRX8rdwN224MSDu-VxEgQ-1
Received: by mail-oo1-f72.google.com with SMTP id k13-20020a4ad10d0000b029025ec20a413eso254655oor.11
        for <linux-s390@vger.kernel.org>; Tue, 20 Jul 2021 15:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPmMSBIIRpMLR6pnHriNECIPx7e3cs1ugIoacnqy1RY=;
        b=MKr6ft9XyzdAYsU7S22k/npoovHCPkoL2mD159aBLxUXw6kJNWUELsk8nG7TDA91Os
         453/NKSNjaSvTdWTDMIf7OLK/4kzLB2yQ6RU8eYqIfZM54hpwVnMnkjiX5gEICW7IG3i
         TzpRimXIGbZmHrpmKa9VNa5JKd2s19rjwmMApER6S02m8mMjG430O+hDyNLJ2eITaRPk
         tByn1bm9Df7LLEm62VrAeLQHkgpoBKLRQGr2jCYuRHtbleZQQIpohK6ICQ32oUiuvOlP
         spL3HfwaGdU8s9BqyB8t+eb6BZyTy8wQQMVJrtHdov9uAwq2KYzWWheOzYV8g2f0d+Zp
         lUkw==
X-Gm-Message-State: AOAM532IVprRWRhvCUTAJX/oOi7yL0lQVGstWV96QkWKNKvilGb9JP9c
        oc+QddfKd2EA2r7L3Z1ZUAB7E6EMYLu63hrCgQH/u8tu2PUq5BpgdQTBDJewWWp812mTyxnHiP/
        jODIbgYOn/1KWJrnb9N8TeQ==
X-Received: by 2002:a9d:4b02:: with SMTP id q2mr13197556otf.52.1626821694108;
        Tue, 20 Jul 2021 15:54:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7ncl7zRpBxXCyp5ocCnM/u43LPRAaepFBcKVNjugNChC0csQAeVdr5AwkuCzyfA5+QlRtnQ==
X-Received: by 2002:a9d:4b02:: with SMTP id q2mr13197528otf.52.1626821693761;
        Tue, 20 Jul 2021 15:54:53 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id l196sm3275801oib.14.2021.07.20.15.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 15:54:53 -0700 (PDT)
Date:   Tue, 20 Jul 2021 16:54:51 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Airlie <airlied@linux.ie>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        dri-devel@lists.freedesktop.org,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        kvm@vger.kernel.org, Kirti Wankhede <kwankhede@nvidia.com>,
        linux-doc@vger.kernel.org, linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v2 02/14] vfio/mbochs: Fix missing error unwind in
 mbochs_probe()
Message-ID: <20210720165451.625dddd4.alex.williamson@redhat.com>
In-Reply-To: <20210720224955.GD1117491@nvidia.com>
References: <0-v2-b6a5582525c9+ff96-vfio_reflck_jgg@nvidia.com>
        <2-v2-b6a5582525c9+ff96-vfio_reflck_jgg@nvidia.com>
        <20210720160127.17bf3c19.alex.williamson@redhat.com>
        <20210720224955.GD1117491@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 20 Jul 2021 19:49:55 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Jul 20, 2021 at 04:01:27PM -0600, Alex Williamson wrote:
> > On Tue, 20 Jul 2021 14:42:48 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > Compared to mbochs_remove() two cases are missing from the
> > > vfio_register_group_dev() unwind. Add them in.
> > > 
> > > Fixes: 681c1615f891 ("vfio/mbochs: Convert to use vfio_register_group_dev()")
> > > Reported-by: Cornelia Huck <cohuck@redhat.com>
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > >  samples/vfio-mdev/mbochs.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
> > > index e81b875b4d87b4..501845b08c0974 100644
> > > +++ b/samples/vfio-mdev/mbochs.c
> > > @@ -553,11 +553,14 @@ static int mbochs_probe(struct mdev_device *mdev)
> > >  
> > >  	ret = vfio_register_group_dev(&mdev_state->vdev);
> > >  	if (ret)
> > > -		goto err_mem;
> > > +		goto err_bytes;
> > >  	dev_set_drvdata(&mdev->dev, mdev_state);
> > >  	return 0;
> > >  
> > > +err_bytes:
> > > +	mbochs_used_mbytes -= mdev_state->type->mbytes;
> > >  err_mem:
> > > +	kfree(mdev_state->pages);
> > >  	kfree(mdev_state->vconfig);
> > >  	kfree(mdev_state);
> > >  	return ret;
> > > @@ -567,8 +570,8 @@ static void mbochs_remove(struct mdev_device *mdev)
> > >  {
> > >  	struct mdev_state *mdev_state = dev_get_drvdata(&mdev->dev);
> > >  
> > > -	mbochs_used_mbytes -= mdev_state->type->mbytes;
> > >  	vfio_unregister_group_dev(&mdev_state->vdev);
> > > +	mbochs_used_mbytes -= mdev_state->type->mbytes;
> > >  	kfree(mdev_state->pages);
> > >  	kfree(mdev_state->vconfig);
> > >  	kfree(mdev_state);  
> > 
> > Hmm, doesn't this suggest we need another atomic conversion?  (untested)  
> 
> Sure why not, I can add this as another patch
> 
> > @@ -567,11 +573,11 @@ static void mbochs_remove(struct mdev_device *mdev)
> >  {
> >  	struct mdev_state *mdev_state = dev_get_drvdata(&mdev->dev);
> >  
> > -	mbochs_used_mbytes -= mdev_state->type->mbytes;
> >  	vfio_unregister_group_dev(&mdev_state->vdev);
> >  	kfree(mdev_state->pages);
> >  	kfree(mdev_state->vconfig);
> >  	kfree(mdev_state);
> > +	atomic_add(mdev_state->type->mbytes, &mbochs_avail_mbytes);  
> 
> This should be up after the vfio_unregister_group_dev(), it is a use after free?

Oops, yep.  That or get the mbochs_type so we can mirror the _probe
setup.  Same on the _probe unwind, but we've already got type->mbytes
there.  Thanks,

Alex

