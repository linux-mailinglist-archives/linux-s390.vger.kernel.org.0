Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B4D40FA85
	for <lists+linux-s390@lfdr.de>; Fri, 17 Sep 2021 16:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhIQOnS (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 17 Sep 2021 10:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229710AbhIQOnQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Sep 2021 10:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631889712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iOTb3UE3yMAXob/FqBUe/TKYJnFydFEqXkEY8HDT4zI=;
        b=fX6RQrrOdoRi1Sym+XZ6E57EU+D57dj4AftutbJk7G4OA+QmpNBa54/uWAAvZjQ9CHWDbG
        JxmMwmRBCNO95d1035HTlvPhUGLbAot0sO9qtcld6gyKtLLKUd763e5dtmNosgI2jW76Dk
        89CYkgBlFzIX1tOLacUhY+YJTQTNVxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-f4qtFLsONraZNqNdM3BV9g-1; Fri, 17 Sep 2021 10:38:05 -0400
X-MC-Unique: f4qtFLsONraZNqNdM3BV9g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D087BBEEC;
        Fri, 17 Sep 2021 14:38:02 +0000 (UTC)
Received: from localhost (unknown [10.39.192.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E6111001281;
        Fri, 17 Sep 2021 14:37:46 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Eric Farman <farman@linux.ibm.com>,
        David Airlie <airlied@linux.ie>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        kvm@vger.kernel.org, Kirti Wankhede <kwankhede@nvidia.com>,
        linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/9] Move vfio_ccw to the new mdev API
In-Reply-To: <20210917125109.GE327412@nvidia.com>
Organization: Red Hat GmbH
References: <0-v2-7d3a384024cf+2060-ccw_mdev_jgg@nvidia.com>
 <1e431e58465b86430d02d429c86c427f7088bf1f.camel@linux.ibm.com>
 <20210913192407.GZ2505917@nvidia.com>
 <6f55044373dea4515b831957981bbf333e03de59.camel@linux.ibm.com>
 <20210914133618.GD4065468@nvidia.com> <87h7ejh0q3.fsf@redhat.com>
 <20210917125109.GE327412@nvidia.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Fri, 17 Sep 2021 16:37:44 +0200
Message-ID: <87ee9ngtdz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Sep 17 2021, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Sep 17, 2021 at 01:59:16PM +0200, Cornelia Huck wrote:
>> >  		ret = cio_cancel_halt_clear(sch, &iretry);
>> > -
>> >  		if (ret == -EIO) {
>> >  			pr_err("vfio_ccw: could not quiesce subchannel 0.%x.%04x!\n",
>> >  			       sch->schid.ssid, sch->schid.sch_no);
>> > -			break;
>> > +			return ret;
>> 
>> Looking at this, I wonder why we had special-cased -EIO -- for -ENODEV
>> we should be done as well, as then the device is dead and we do not need
>> to disable it.
>
> cio_cancel_halt_clear() should probably succeed in that case.

It will actually give us -ENODEV, as the very first call in that
function will already fail.

>
>> > @@ -413,13 +403,28 @@ static void fsm_close(struct vfio_ccw_private *private,
>> >  		spin_unlock_irq(sch->lock);
>> >  
>> >  		if (ret == -EBUSY)
>> > -			wait_for_completion_timeout(&completion, 3*HZ);
>> > +			wait_for_completion_timeout(&completion, 3 * HZ);
>> >  
>> >  		private->completion = NULL;
>> >  		flush_workqueue(vfio_ccw_work_q);
>> >  		spin_lock_irq(sch->lock);
>> >  		ret = cio_disable_subchannel(sch);
>> >  	} while (ret == -EBUSY);
>> > +	return ret;
>> > +}
>> > +
>> > +static void fsm_close(struct vfio_ccw_private *private,
>> > +		      enum vfio_ccw_event event)
>> > +{
>> > +	struct subchannel *sch = private->sch;
>> > +	int ret;
>> > +
>> > +	spin_lock_irq(sch->lock);
>> > +	if (!sch->schib.pmcw.ena)
>> > +		goto err_unlock;
>> > +	ret = cio_disable_subchannel(sch);
>> 
>> cio_disable_subchannel() should be happy to disable an already disabled
>> subchannel, so I guess we can just walk through this and end up in
>> CLOSED state... unless entering with !ena actually indicates that we
>> messed up somewhere else in the state machine. I still need to find time
>> to read the patches.
>
> I don't know, I looked at that ena stuff for a bit and couldn't guess
> what it is trying to do.

It is one of the bits in the pmcw control block that can be modified; if
it is 1, the subchannel is enabled and can be used for I/O, if it is 0,
the subchannel is disabled and all instructions that initiate or stop
I/O will fail. Basically, you enable the subchannel if you actually want
to access the device associated with it. Online/offline for (normal
usage) ccw devices maps (among other things) to associated subchannel
enabled/disabled; for a subchannel that is supposed to be passed via
vfio-ccw, we want to have it enabled so that it is actually usable.

I think the ena checking had been inspired from what the ccw bus
does. We could probably just forge ahead in any case and the called
functions in the css bus would be able to handle it just fine, but I
have not double checked.

> Arguably the channel should not be ripped away from vfio while the FSM
> is in the open states, so I'm not sure what a lot of this is for.

We could have surprise removal (i.e. a subchannel in active use being
ripped out), as that's what happens on real hardware as well. E.g. doing
a device_del in QEMU.

