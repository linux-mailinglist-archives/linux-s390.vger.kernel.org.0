Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22471BF5C7
	for <lists+linux-s390@lfdr.de>; Thu, 30 Apr 2020 12:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgD3Kn0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 30 Apr 2020 06:43:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53496 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726127AbgD3Kn0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 06:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588243405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RDi2vE7xlXjhzYA/qFLKFknGOZGTd39IiKLpNXW46B0=;
        b=cvXo84LGaGHaGLeqcOhTPzlFXFQK4Z0MhSIQDYNcXmuKq7znKcWC3DeHX0wgYLF/iOQLmh
        UVHGpRH8jtAy6BmuUdNc3bGs+V+uvpVjt9BpMmxhU930zHqfv/Krn0lc0YdbbPC1eFHal+
        CR/eqit1P4HIjsDLcjT80YwM3nEP9Bc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-42hY1zNmNcaAtHdj-7o95A-1; Thu, 30 Apr 2020 06:43:21 -0400
X-MC-Unique: 42hY1zNmNcaAtHdj-7o95A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 597C5468;
        Thu, 30 Apr 2020 10:43:20 +0000 (UTC)
Received: from gondolin (ovpn-112-226.ams2.redhat.com [10.36.112.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C09C65C1BE;
        Thu, 30 Apr 2020 10:43:18 +0000 (UTC)
Date:   Thu, 30 Apr 2020 12:43:16 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Vineeth Vijayan <vneethv@linux.vnet.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Boris Fiuczynski <fiuczy@linux.ibm.com>
Subject: Re: [RFD] uevent handling for subchannels
Message-ID: <20200430124316.023a82b0.cohuck@redhat.com>
In-Reply-To: <53d7d08d-c1d2-dad3-7f01-a165b24b0359@linux.ibm.com>
References: <20200403124032.5e70603d.cohuck@redhat.com>
        <20200417143811.7e6ecb2c.cohuck@redhat.com>
        <8649ea94-8617-07b6-170e-65c278d9383b@linux.vnet.ibm.com>
        <c69da1c0-d151-257b-fe43-786e47a3cf9b@linux.vnet.ibm.com>
        <20200423182001.40345df8.cohuck@redhat.com>
        <53d7d08d-c1d2-dad3-7f01-a165b24b0359@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 27 Apr 2020 12:10:17 +0200
Peter Oberparleiter <oberpar@linux.ibm.com> wrote:

> On 23.04.2020 18:20, Cornelia Huck wrote:
> > On Thu, 23 Apr 2020 16:52:24 +0200
> > Vineeth Vijayan <vneethv@linux.vnet.ibm.com> wrote:  
> >> Then we could also change the way ccw_device_call_sch_unregister() 
> >> works, where
> >> the subchannel-unregister is happening from an upper layer.  
> > 
> > Hm, what's the problem here? This seems to be mostly a case of "we did
> > I/O to the device and it appeared not operational; so we go ahead and
> > unregister the subchannel"? Childless I/O subchannels are a bit useless.  
> 
> Hey Conny,
> 
> sparked by your proposal, Vineeth and myself looked at the corresponding
> CIO code and wondered if things couldn't be done in a generally
> better/cleaner way. So here we'd like to get your opinion.
> 
> In particular, as it is currently, a child-driver (IO subchannel driver,
> vfio-ccw, etc.) unregisters a device owned by a parent-device-driver
> (CSS), which feels from a high-level-view like a layering violation:
> only the parent driver should register and unregister the parent device.
> Also in case no subchannel driver is available (e.g. due to
> driver_override=none), there would be no subchannel ADD event at all.

Doesn't the base css code generate the uevent in that case?

> 
> So, tapping into you historical expertise about CIO, is there any reason
> for doing it this way beyond being nice to userspace tooling that
> subchannels with non-working CCW devices are automatically hidden by
> unregistering them?

We always had ccw devices behind I/O subchannels, but that has not been
the case since we introduced vfio-ccw, so hopefully everybody can deal
with that. The rationale behind this was that device-less I/O
subchannels were deemed to be useless; I currently can't remember
another reason.

What about EADM, btw? CHSC does not have a device, and message does not
have a driver.

> 
> Removing the child-unregisters-parent logic this would also enable
> manual rebind of subchannels for which only a different driver than the
> default one can successfully talk to the child device, though I'm
> unaware of any current application for that.

Yes.

Let me think about that some more (no clear head currently, sorry.)

