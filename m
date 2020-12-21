Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1132B2DFDBF
	for <lists+linux-s390@lfdr.de>; Mon, 21 Dec 2020 16:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgLUPyD (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 21 Dec 2020 10:54:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbgLUPyC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Dec 2020 10:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608565955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QTKz5XkmqntuEWQ3ug73+/SkbbyNfpApCfrbz+lf6I=;
        b=Sx00hj56TEguBoRZ+wQa1x7psgM2ynD5nTrgI3oPpdMc4AY4gVHiwz+O8dq6iIcUkKPb1p
        jvnYSFXsNkj0X5bqVDpQAkzYuNWj34EffxPlfsHGuTsAFSo6IptGxdEUmlcJ0hwdhXK/BX
        NyqPUJZEqIYYfpPOmllzG/3SJdG8z7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-UVisZkIjNXKahBgRvN50bg-1; Mon, 21 Dec 2020 10:52:34 -0500
X-MC-Unique: UVisZkIjNXKahBgRvN50bg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C07DCAFAA4;
        Mon, 21 Dec 2020 15:52:23 +0000 (UTC)
Received: from gondolin (ovpn-113-49.ams2.redhat.com [10.36.113.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CFE45C3E9;
        Mon, 21 Dec 2020 15:52:22 +0000 (UTC)
Date:   Mon, 21 Dec 2020 16:52:19 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Boris Fiuczynski <fiuczy@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.vnet.ibm.com>,
        oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        farman@linux.ibm.com
Subject: Re: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
Message-ID: <20201221165219.7f2aa7c6.cohuck@redhat.com>
In-Reply-To: <20201219082006.2529bcec.pasic@linux.ibm.com>
References: <20201124093407.23189-1-vneethv@linux.ibm.com>
        <20201124093407.23189-2-vneethv@linux.ibm.com>
        <20201124140220.77c65539.cohuck@redhat.com>
        <4be7e163-1118-d365-7d25-df39ba78181f@linux.vnet.ibm.com>
        <0b4e34b7-7a4e-71b0-8a64-ea909e64f416@linux.ibm.com>
        <20201208183054.44f4fc2d.cohuck@redhat.com>
        <20201209135203.0008ab18.pasic@linux.ibm.com>
        <20201215191307.281c6e6f.cohuck@redhat.com>
        <89146a87-371a-f148-057b-d3b7ce0cc21e@linux.ibm.com>
        <20201216130710.5aa6a933.cohuck@redhat.com>
        <20201219082006.2529bcec.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, 19 Dec 2020 08:20:06 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 16 Dec 2020 13:07:10 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Wed, 16 Dec 2020 12:53:41 +0100
> > Boris Fiuczynski <fiuczy@linux.ibm.com> wrote:
> >   
> > > On 12/15/20 7:13 PM, Cornelia Huck wrote:  
> > > >>       
> > > >>> I'm not sure how many rules actually care about events for the
> > > >>> subchannel device; the ccw device seems like the more helpful device to
> > > >>> watch out for.    
> > > >> I tend to agree, but the problem with vfio-ccw is that (currently) we
> > > >> don't have a ccw device in the host, because we pass-through the
> > > >> subchannel. When we interrogate the subchannel, we do learn if there
> > > >> is a device and if, what is its devno. If I were to run a system with
> > > >> vfio-ccw passthrough, I would want to passthrough the subchannel that
> > > >> talks to the DASD (identified by devno) I need passed through to my
> > > >> guest.    
> > > > I think that can be solved by simply adding the devno as a variable to
> > > > the uevent (valid if it's an I/O subchannel; we don't register the
> > > > subchannel in the first place if dnv is not set.)
> > > >     
> > > Providing the devno in the context of the udev event certainly helps if 
> > > the event consumer would base its actions on it.
> > > As far as I understand the driver_override mechanics driverctl sets the 
> > > override based on a specified device. In that case the devno would not 
> > > be looked at and the subchannel would end up with a vfio-ccw driver even 
> > > so the ccw device might not be the one we want to use as pass-through 
> > > device.  
> > 
> > Hm, maybe we need to make a change in driverctl that allows per-bus
> > custom rules?
> >   
> 
> The issue with that is, that this problem ain't bus specific. I.e. it
> could make perfect sense to driver_override a certain ccw tape device to
> an alternative tape driver.

But ccw does not provide driver_override? Confused.

> 
> The problem is, that the only way driverctl can identify a device is a
> (name_of_the_bus), device_name_on_the bus) pair. Currently the udev rule
> installed by driverctl simply ooks fora file 
> /etc/driverctl.d/$env{SUBSYSTEM}-$kernel
> which basically encodes the current selection criteria.
> 
> Can yo please elaborate on your idea? How would you extend the driverctl
> cli and how would persistence look like for these custom rules? Would
> you make driverctl write an udev rule for each such device/custom rule
> on 'set-override' command instead of file in /etc/driverctl.d?

I have not really looked at how to implement this. But we could have
driverctl support an optional "additional_parameters" option, which
allows to specify key/value pairs that have to match. I guess that
should be dropped into the driverctl config directory, and generate an
additional check?

