Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AD3268A52
	for <lists+linux-s390@lfdr.de>; Mon, 14 Sep 2020 13:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgINLr0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 14 Sep 2020 07:47:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53578 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726043AbgINLqv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Sep 2020 07:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600084010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8gfwnHD9dHu8uZfZ5YjjFWhs2d5AsnLOmKJgI0VS09M=;
        b=KVJ3XcHCxaB2JSO8W8a7LtNDCPaFZOv4zWg2TTgu1a9xWsnQUeHkS5ViYjJ7oUzQ+mI6PB
        4XRoH4tnqqTdQxOvQ9nW3A44Wh5toQVL0winlNMCujLAR/Wr/OEbegwz5DAc71Dz56U3SV
        /Nt9t+OjLFbW1ilqpM8zOl8cabulZF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-N7txhOc0NXi9aI1uiONIWg-1; Mon, 14 Sep 2020 07:46:48 -0400
X-MC-Unique: N7txhOc0NXi9aI1uiONIWg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81D41801AAB;
        Mon, 14 Sep 2020 11:46:46 +0000 (UTC)
Received: from gondolin (ovpn-112-214.ams2.redhat.com [10.36.112.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1BDD7839F;
        Mon, 14 Sep 2020 11:46:44 +0000 (UTC)
Date:   Mon, 14 Sep 2020 13:46:42 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Vineeth Vijayan <vneethv@linux.vnet.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Boris Fiuczynski <fiuczy@linux.ibm.com>
Subject: Re: [RFD] uevent handling for subchannels
Message-ID: <20200914134642.5e2e2c0e.cohuck@redhat.com>
In-Reply-To: <20200701112313.62a22156.cohuck@redhat.com>
References: <20200403124032.5e70603d.cohuck@redhat.com>
        <20200417143811.7e6ecb2c.cohuck@redhat.com>
        <8649ea94-8617-07b6-170e-65c278d9383b@linux.vnet.ibm.com>
        <c69da1c0-d151-257b-fe43-786e47a3cf9b@linux.vnet.ibm.com>
        <20200423182001.40345df8.cohuck@redhat.com>
        <53d7d08d-c1d2-dad3-7f01-a165b24b0359@linux.ibm.com>
        <20200430124316.023a82b0.cohuck@redhat.com>
        <20200629135631.10db3c32.cohuck@redhat.com>
        <20200701112313.62a22156.cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

<casts "reanimate" on dead thread>

On Wed, 1 Jul 2020 11:23:13 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Mon, 29 Jun 2020 13:56:31 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > Ok, so I've resumed the thinking process, and I think getting rid of
> > the "no I/O subchannel without functional device" approach is a good
> > idea, and allows us to make handling driver matches more similar to
> > everyone else.  
> 
> As an aside, there's another odd construct: the I/O subchannel driver
> *always* binds to the subchannel device, even if there is a problem,
> and schedules an unregistration of the subchannel device on error. This
> was introduced because events from machine check handling are not
> processed if there isn't a driver (at least I thought back then that it
> was a good idea.) I think a more correct way to handle this would be to
> do the following:
> 
> * If something doesn't work, clean up and return an error in the probe
>   function. The subchannel device stays around, it's just not bound.
> * Have the css bus do some basic processing for subchannels not bound
>   to any driver (e.g., check dnv/w). This would also make it possible
>   to unregister dead message subchannels if a machine check is received
>   for them (don't know if that's an actual problem in pratice.)
> 
> > 
> > What changes would be needed?
> > * The whole logic to suppress uevents for subchannels and generate one
> >   later will go. (Touches the various subchannel driver, including
> >   vfio-ccw.)
> > * ccw_device_todo() can just unregister the ccw device, and there's no
> >   longer a need for ccw_device_call_sch_unregister(). (IIUC, this also
> >   covers setting disconnected devices offline.)  
> 
> I'm actually not sure if unregistration-by-driver is the right thing
> for most cases (except for something like disconnected device removal),
> that should be done by the bus. Maybe something for later (don't fear,
> I don't plan to work on the common I/O layer again :)
> 
> > * As the I/O subchannel driver now needs to deal with cases where no
> >   ccw device is available, the code for that needs to be checked.
> >   (That's probably the most time-consuming task.)  
> 
> Had a quick look, doesn't actually look too bad (most places already
> check for !cdev.)
> 
> > 
> > Userspace should be fine with I/O subchannels without ccw device,
> > that's nothing new.
> > 
> > Does that sound reasonable?  

Is anybody looking at this? The delayed uevent handling is a bit of a
mess for management of vfio-ccw devices...

