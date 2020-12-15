Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED182DB3B1
	for <lists+linux-s390@lfdr.de>; Tue, 15 Dec 2020 19:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgLOSYw (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 15 Dec 2020 13:24:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34729 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731270AbgLOSYl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Dec 2020 13:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608056582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A21obnB1sOAmglaRS5v6764SnqmcKMcG7eZk/uWaP0s=;
        b=EHr8GLlHJ4UT4T7A8pMMQjyYn2e6x4IZgzG9WJz7GPGJnOMHh3zuEA6jsw88BPAnK1H5cq
        pKOT3+YB5L0HkasWo2Ml+4HBmoIDpO74MFhhD3vBg6Q4DVi1Oy66YbpddSnMNwua9U20WP
        8BYaXcrBOtURTKybrYhPkZQQh2bsae0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-CNql23LhPuWO5PcDe9mJhw-1; Tue, 15 Dec 2020 13:13:13 -0500
X-MC-Unique: CNql23LhPuWO5PcDe9mJhw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C843107ACF8;
        Tue, 15 Dec 2020 18:13:11 +0000 (UTC)
Received: from gondolin (ovpn-114-220.ams2.redhat.com [10.36.114.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A44B1F078;
        Tue, 15 Dec 2020 18:13:09 +0000 (UTC)
Date:   Tue, 15 Dec 2020 19:13:07 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.vnet.ibm.com>,
        oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        farman@linux.ibm.com, fiuczy@linux.ibm.com
Subject: Re: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
Message-ID: <20201215191307.281c6e6f.cohuck@redhat.com>
In-Reply-To: <20201209135203.0008ab18.pasic@linux.ibm.com>
References: <20201124093407.23189-1-vneethv@linux.ibm.com>
        <20201124093407.23189-2-vneethv@linux.ibm.com>
        <20201124140220.77c65539.cohuck@redhat.com>
        <4be7e163-1118-d365-7d25-df39ba78181f@linux.vnet.ibm.com>
        <0b4e34b7-7a4e-71b0-8a64-ea909e64f416@linux.ibm.com>
        <20201208183054.44f4fc2d.cohuck@redhat.com>
        <20201209135203.0008ab18.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 9 Dec 2020 13:52:03 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Tue, 8 Dec 2020 18:30:54 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > > 
> > > But, the more i look at this patch and discuss on this, i think this is 
> > > not complete.
> > > i.e as you know, the main reason for this RFC was the the below thread.
> > > https://marc.info/?l=linux-s390&m=158591045732735&w=2
> > > We are still not solving the problem that was mentioned in that RFD.
> > > 
> > > There are couple of things which we needs to consider here. With this 
> > > patch, the uevents
> > > are generated before doing the initialization or before finding the 
> > > ccw-device
> > > connected. Which means, the udev-rules have to manage with a 
> > > non-initialized setup
> > > compared to the previous version (Version without this patch). As you 
> > > mentioned, the
> > > current user-space programs which works with this uevent, especially in 
> > > case of vfio-ccw
> > > will have a problem.    
> > 
> > IIUC, we'll get the "normal" ADD uevent when the subchannel device is
> > registered (i.e. made visible). For the vfio-ccw case, we want the
> > driverctl rule to match in this case, so that the driver override can
> > be set before the subchannel device ends up being bound to the I/O
> > subchannel driver. So I think that removing the suppression is giving
> > us exactly what we want? Modulo any errors in the initialization
> > sequence we might currently have in the css bus code, of course.
> >  
> 
> I believe, I'm the originator of these concerns, yet I find my
> concern hard to recognize in the comment of Vineeth, so let me
> please try to explain this in a different way.
> 
> AFAIK the uevent handling is asynchronous with regards to matching and
> probing, in a sense that there is no synchronization mechanism that
> ensures, the userspace has had the ADD event handled (e.g.
> driver_override set_ before the kernel proceeds with matching and
> probing of the device. Am I wrong about this?
> 
> If I'm, with the suppression gone we end up with race, where userspace
> may or may not set driver_override in time.
> 
> The man page of driverctl
> (https://manpages.debian.org/testing/driverctl/driverctl.8.en.html)
> claims that: "driverctl integrates with udev to support overriding driver
> selection for both cold- and hotplugged devices from the moment of discovery, ..."
> and "The driver overrides created by driverctl are persistent across
> system reboots by default."
> 
> Writing to the driver_override sysfs attribute does not auto-rebind. So
> if we can't ensure being in time to set driver_override for the
> subchannel before the io_subchannel driver binds, then the userspace
> should handle this situation (by unbind and bind) to ensure the
> effectiveness of 'driver override'. I couldn't find that code in
> driverctl, and I assume if we had that, driver override would work
> without this patch. Conny, does that sound about right?
> 
> My argument is purely speculative. I didn't try this out, but trying
> stuff out is of limited value with races anyway. Vineeth did you try?
> If not, I could check this out myself some time later.

Whenever we delegate policy decisions like that to userspace, we'll end
up with uncertainty depending on timing. I don't think that there's any
way around it. (FWIW, driver_override for pci behaves just the same,
unless I misread the code.)

What removing the uevent suppression does give us is at least a chance
to influence the driver that is being bound and not wait until we have
a fully setup ccw device as a child as well.

>  
> > I'm not sure how many rules actually care about events for the
> > subchannel device; the ccw device seems like the more helpful device to
> > watch out for.  
> 
> I tend to agree, but the problem with vfio-ccw is that (currently) we
> don't have a ccw device in the host, because we pass-through the
> subchannel. When we interrogate the subchannel, we do learn if there
> is a device and if, what is its devno. If I were to run a system with
> vfio-ccw passthrough, I would want to passthrough the subchannel that
> talks to the DASD (identified by devno) I need passed through to my
> guest.

I think that can be solved by simply adding the devno as a variable to
the uevent (valid if it's an I/O subchannel; we don't register the
subchannel in the first place if dnv is not set.)

