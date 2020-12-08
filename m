Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C945A2D3129
	for <lists+linux-s390@lfdr.de>; Tue,  8 Dec 2020 18:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbgLHRcn (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 8 Dec 2020 12:32:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21022 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730671AbgLHRcn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Dec 2020 12:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607448676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dwqJR2yJGvDj0C6HcDNS3VH5GquEkFKIGcDXRG8j3AI=;
        b=PWUaFtf6NTlp722stNsiuQBKVC64QNMVMlrO3ofjcf86cSN5z23uFj2T5X1k01pP4Nj4W+
        5N/7BieQNL9Vz7QXG50sS/MRUuxTCcnme/v8/Cct9zdUZXpBjJWUB/HoaGgbs9D73b/7Ma
        O+7CFovkMRmjTkYK6+qFdTGdpFhh6wU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-qkdkRzGOPqOT7yHqeYxkWQ-1; Tue, 08 Dec 2020 12:31:08 -0500
X-MC-Unique: qkdkRzGOPqOT7yHqeYxkWQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10603107ACF6;
        Tue,  8 Dec 2020 17:30:58 +0000 (UTC)
Received: from gondolin (ovpn-113-5.ams2.redhat.com [10.36.113.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 830155D9DD;
        Tue,  8 Dec 2020 17:30:56 +0000 (UTC)
Date:   Tue, 8 Dec 2020 18:30:54 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Vineeth Vijayan <vneethv@linux.ibm.com>
Cc:     Vineeth Vijayan <vneethv@linux.vnet.ibm.com>,
        oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        farman@linux.ibm.com, fiuczy@linux.ibm.com,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
Message-ID: <20201208183054.44f4fc2d.cohuck@redhat.com>
In-Reply-To: <0b4e34b7-7a4e-71b0-8a64-ea909e64f416@linux.ibm.com>
References: <20201124093407.23189-1-vneethv@linux.ibm.com>
        <20201124093407.23189-2-vneethv@linux.ibm.com>
        <20201124140220.77c65539.cohuck@redhat.com>
        <4be7e163-1118-d365-7d25-df39ba78181f@linux.vnet.ibm.com>
        <0b4e34b7-7a4e-71b0-8a64-ea909e64f416@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 7 Dec 2020 09:09:48 +0100
Vineeth Vijayan <vneethv@linux.ibm.com> wrote:

> Hi Cornelia,
> 
> A bit more on this RFC.
> I think this is a required change in the CIO layer, especially because there
> are lot of validations before we call the probe, which makes sure that we
> are not generating the uevent on an invalid (without a ccw-device connected)
> subchannel and we dont expect a uevent-storm with the current code-base.
> So, in anyway, Removing the suppression in the uevent is a cleaner way 
> for the
> css driver.

Agreed. A device being found not operational during actual ccw device
setup but not earlier is probably an edge case.

> 
> But, the more i look at this patch and discuss on this, i think this is 
> not complete.
> i.e as you know, the main reason for this RFC was the the below thread.
> https://marc.info/?l=linux-s390&m=158591045732735&w=2
> We are still not solving the problem that was mentioned in that RFD.
> 
> There are couple of things which we needs to consider here. With this 
> patch, the uevents
> are generated before doing the initialization or before finding the 
> ccw-device
> connected. Which means, the udev-rules have to manage with a 
> non-initialized setup
> compared to the previous version (Version without this patch). As you 
> mentioned, the
> current user-space programs which works with this uevent, especially in 
> case of vfio-ccw
> will have a problem.

IIUC, we'll get the "normal" ADD uevent when the subchannel device is
registered (i.e. made visible). For the vfio-ccw case, we want the
driverctl rule to match in this case, so that the driver override can
be set before the subchannel device ends up being bound to the I/O
subchannel driver. So I think that removing the suppression is giving
us exactly what we want? Modulo any errors in the initialization
sequence we might currently have in the css bus code, of course.

I'm not sure how many rules actually care about events for the
subchannel device; the ccw device seems like the more helpful device to
watch out for.

> Second point is, there is no guarantee on the current code that the 
> uevent generated
> will be used by udev-rules of vfio-ccw instead of io-subchannel driver. 
> This means, we
> need to do some more modifications on the udev-rules, which can then 
> decide which
> driver should bind with the subchannel. I think that is the only way to 
> avoid the
> problems we are facing with the driver_override.

Looking on my LPAR, it seems the driverctl rule is the second in
priority; i.e., it will be called before nearly everything else. This
should suffice, I hope?

> I would like to get your expert-opinion on the modifications that can be 
> done on the
> vfio-ccw udev-rules to make it sync with the current patch.

I think the vfio-ccw specific rules are those we need to worry about
the least. Again, from a quick browse on my LPAR, the existing rules
seem pretty sane AFAICS. I cannot speak for all the different distros,
though :)

One thing that probably should be changed together with the removal of
the uevent suppression is the de-registration of the subchannel device
by the ccw bus. Likely an edge case, but might cause confusion when a
subchannel is immediately gone again.

