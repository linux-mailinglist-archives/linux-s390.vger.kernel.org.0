Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB03D2DFDB3
	for <lists+linux-s390@lfdr.de>; Mon, 21 Dec 2020 16:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgLUPsK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 21 Dec 2020 10:48:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbgLUPsK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Dec 2020 10:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608565604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1BNfXk6YdaZ/t3A5JuB5TgcqTozkWTtEWLO8WsTZAHc=;
        b=dHkUNW+sJBEFV8xuXzoJaMaIC0K56I/Ev/o5idmovgpRejNRLeGFeLtX2ncT4ZTZVEUmEI
        poo0/9uydgqH3tXonQdhrY2m6X8UPkCDqYdndCzgHWU0U7bpd2OOW9nMYDjZ9mWAHhtOTQ
        263gJkeTrGYLY56gIZj3tuKkkxQxTuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-wXy3onZ3MmO1B_Ks9H1dzg-1; Mon, 21 Dec 2020 10:46:40 -0500
X-MC-Unique: wXy3onZ3MmO1B_Ks9H1dzg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB13610054FF;
        Mon, 21 Dec 2020 15:46:38 +0000 (UTC)
Received: from gondolin (ovpn-113-49.ams2.redhat.com [10.36.113.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5526C131C5;
        Mon, 21 Dec 2020 15:46:37 +0000 (UTC)
Date:   Mon, 21 Dec 2020 16:46:34 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.vnet.ibm.com>,
        oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        farman@linux.ibm.com, fiuczy@linux.ibm.com
Subject: Re: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
Message-ID: <20201221164634.11cd3813.cohuck@redhat.com>
In-Reply-To: <20201219073316.1be609d5.pasic@linux.ibm.com>
References: <20201124093407.23189-1-vneethv@linux.ibm.com>
        <20201124093407.23189-2-vneethv@linux.ibm.com>
        <20201124140220.77c65539.cohuck@redhat.com>
        <4be7e163-1118-d365-7d25-df39ba78181f@linux.vnet.ibm.com>
        <0b4e34b7-7a4e-71b0-8a64-ea909e64f416@linux.ibm.com>
        <20201208183054.44f4fc2d.cohuck@redhat.com>
        <20201209135203.0008ab18.pasic@linux.ibm.com>
        <20201215191307.281c6e6f.cohuck@redhat.com>
        <20201219073316.1be609d5.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, 19 Dec 2020 07:33:16 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> I finally came around to test this. In my experience driverctl works for
> subchannels and vfio_ccw without this patch, and continues to work with
> it. I found the code in driverctl that does the unbind and the implicit
> bind (via drivers_probe after after driver_override was set).
> 
> So now I have to ask, how exactly was the original problem diagnosed?
> 
> In https://marc.info/?l=linux-s390&m=158591045732735&w=2 there is a
> paragraph like:
> 
> """
> So while there's definitely a good reason for wanting to delay uevents,
> it is also introducing problems. One is udev rules for subchannels that
> are supposed to do something before a driver binds (e.g. setting
> driver_override to bind an I/O subchannel to vfio_ccw instead of
> io_subchannel) are not effective, as the ADD uevent will only be
> generated when the io_subchannel driver is already done with doing all
> setup. Another one is that only the ADD uevent is generated after
> uevent suppression is lifted; any other uevents that might have been
> generated are lost.
> """
> 
> This is not how driverclt works! I.e. it deals with the situation that
> the I/O subchannel was already bound to the io_subchannel driver at
> the time the udev rule installed by driverctl activates (via the
> mechanism I described above).

That's... weird. It definitely did not work on the LPAR I initially
tried it out on!

However, I think removing the suppression still looks like a good idea:
we still have the "any uevent other than ADD will have been lost"
problem.

