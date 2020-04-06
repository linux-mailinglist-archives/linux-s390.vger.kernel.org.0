Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C11419F53B
	for <lists+linux-s390@lfdr.de>; Mon,  6 Apr 2020 13:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgDFLyv (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 6 Apr 2020 07:54:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57256 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726329AbgDFLyv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Apr 2020 07:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586174090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/SFCm8iiuo1/VZAyAs54gN05br4y81ab5jF78e/Nlc=;
        b=btdwU/EDaC1dmPRgpgzt2ifjfyEpgFmyC8fOdbGNmUxRKeyntYIg5AINzH4UycDk9GjT3n
        zeGkxM/1LEMwWDd3kzKgUe89hn/V/5x7jGPzOhA02pBgiivlKHObKHgJvkiCdryLS8WMYm
        HNX+9281kjm/vxZvLeMsD3jeJ7RI0e4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-6TR1WjUDOv2N2kZq0WG1xg-1; Mon, 06 Apr 2020 07:54:46 -0400
X-MC-Unique: 6TR1WjUDOv2N2kZq0WG1xg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EBB88017FF;
        Mon,  6 Apr 2020 11:54:45 +0000 (UTC)
Received: from gondolin (ovpn-113-129.ams2.redhat.com [10.36.113.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 738672637B;
        Mon,  6 Apr 2020 11:54:43 +0000 (UTC)
Date:   Mon, 6 Apr 2020 13:54:41 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     linux-s390@vger.kernel.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Boris Fiuczynski <fiuczy@linux.ibm.com>
Subject: Re: [PATCH 0/2] s390/cio: correct some uevent issues
Message-ID: <20200406135441.743db659.cohuck@redhat.com>
In-Reply-To: <20200327124503.9794-1-cohuck@redhat.com>
References: <20200327124503.9794-1-cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 27 Mar 2020 13:45:01 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> For subchannels, we currently delay the initial ADD uevent to a
> point in time controlled by the driver bound to it (this is to
> avoid a storm of useless uevents for I/O subchannels that do not
> have an operational device behind it and will get deregistered
> again, which are potentially a lot on LPARs.)
> 
> If we unbind from the io_subchannel driver and rebind again later,
> we'll get a duplicate ADD uevent -- not a common workflow, but might
> happen e.g. when you use a device in the host, then pass it to a
> guest via vfio-ccw, and then want to use it in the host again. Fixed
> by the first patch.
> 
> The vfio_ccw subchannel driver did not generate any ADD uevent at
> all -- currently not a problem, as every I/O subchannel will have been
> bound to the io_subchannel driver before, but let's fix this anyway
> (second patch).
> 
> [As an aside, setting driver_override via a udev rule does not work
> as expected, due to the uevent delaying -- a specified driver_override
> works as designed, but userspace won't get the ADD uevent until after
> the io_subchannel driver has been bound to the device already... we
> may want to rethink this whole uevent mechanism for subchannels later,
> but I don't think it's too pressing an issue.]
> 
> Probably easiest for both patches to go via the s390 arch maintainers.

Friendly ping. Anyone taking these?

> 
> Cornelia Huck (2):
>   s390/cio: avoid duplicated 'ADD' uevents
>   s390/cio: generate delayed uevent for vfio-ccw subchannels
> 
>  drivers/s390/cio/device.c       | 13 +++++++++----
>  drivers/s390/cio/vfio_ccw_drv.c |  5 +++++
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 

