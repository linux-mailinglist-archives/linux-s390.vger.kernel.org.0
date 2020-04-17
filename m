Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81411ADD6F
	for <lists+linux-s390@lfdr.de>; Fri, 17 Apr 2020 14:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgDQMiU (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 17 Apr 2020 08:38:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27740 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgDQMiT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Apr 2020 08:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587127098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SZpUdommMIQ7wSju1Ntwx13tpJCK6xVSPmOSlBrgwKM=;
        b=g0F5mKxW8It65m5ztqCeMRB9c3ZQQGQXtrEQx2MnZSgm6ZcjmSmNECovQ+fSN/Gnm8COZa
        AzrHw/ZGUfEdMxTDqa21eg/YbmqaVTbEGJlPHERwvlLOIHomFfwmZVOE+bTAvR6twRWPXa
        U/dr7PejoTGhPkdzL/RIPbNhAs+7qvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-3TdE0_llNOWhZ6HP2VQ1BQ-1; Fri, 17 Apr 2020 08:38:16 -0400
X-MC-Unique: 3TdE0_llNOWhZ6HP2VQ1BQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D1088017F3;
        Fri, 17 Apr 2020 12:38:15 +0000 (UTC)
Received: from gondolin (ovpn-112-200.ams2.redhat.com [10.36.112.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE5309A274;
        Fri, 17 Apr 2020 12:38:13 +0000 (UTC)
Date:   Fri, 17 Apr 2020 14:38:11 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Boris Fiuczynski <fiuczy@linux.ibm.com>
Subject: Re: [RFD] uevent handling for subchannels
Message-ID: <20200417143811.7e6ecb2c.cohuck@redhat.com>
In-Reply-To: <20200403124032.5e70603d.cohuck@redhat.com>
References: <20200403124032.5e70603d.cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Friendly ping.

On Fri, 3 Apr 2020 12:40:32 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> Hi,
> 
> this is kind-of-a-followup to the uevent patches I sent in
> <20200327124503.9794-1-cohuck@redhat.com> last Friday.
> 
> Currently, the common I/O layer will suppress uevents for subchannels
> that are being registered, delegating generating a delayed ADD uevent
> to the driver that actually binds to it and only generating the uevent
> itself if no driver gets bound. The initial version of that delaying
> was introduced in fa1a8c23eb7d ("s390: cio: Delay uevents for
> subchannels"); from what I remember, we were seeing quite bad storms of
> uevents on LPARs that had a lot of I/O subchannels with no device
> accessible through them.
> 
> So while there's definitely a good reason for wanting to delay uevents,
> it is also introducing problems. One is udev rules for subchannels that
> are supposed to do something before a driver binds (e.g. setting
> driver_override to bind an I/O subchannel to vfio_ccw instead of
> io_subchannel) are not effective, as the ADD uevent will only be
> generated when the io_subchannel driver is already done with doing all
> setup. Another one is that only the ADD uevent is generated after
> uevent suppression is lifted; any other uevents that might have been
> generated are lost.
> 
> So, what to do about this, especially in the light of vfio-ccw handling?
> 
> One idea I had is to call css_sch_is_valid() from
> css_register_subchannel(); this would exclude the largest class of
> non-operational subchannels already (those that don't have a valid
> device; I'm not quite sure if there's also something needed for EADM
> subchannels?) If we got rid of the uevent delaying, we would still get
> ADD/REMOVE events for subchannels where the device turns out to be
> non-accessible, but I believe (hope) that those are not too many in a
> sane system at least. As a bonus, we could also add additional values
> from the pmcw to the uevent; the device number, for example, could be
> helpful for vfio-ccw matching rules.
> 
> A drawback is that we change the timing (not the sequence, AFAICS) of
> the uevents, which might break brittle setups.
> 
> Thoughts?
> 

