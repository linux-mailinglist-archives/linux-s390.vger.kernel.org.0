Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C121C2DC001
	for <lists+linux-s390@lfdr.de>; Wed, 16 Dec 2020 13:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgLPMIn (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 16 Dec 2020 07:08:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbgLPMIn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Dec 2020 07:08:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608120437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KtZFOQwKL4/9kjGqVJ3J058V62lU3lzqSedB8WS3LTM=;
        b=Aa5AzDDnYoqyPNUYzIvO89FaM1XL69KSAiBl1cRTnxTiBozqbvUVaw2RQvhD5wF26cJ76H
        QZS6hC1TAt97XNOqkNiDO//Mg6SkqGYs0ilvfai+tQBoGlkcQEg/i8zHeqG4mQMWX0ELtw
        tULnZgoukSxJfjgHDY5H7FjuVL7Hvy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-aZ-MLw8yNrWEuOqR87sO8A-1; Wed, 16 Dec 2020 07:07:15 -0500
X-MC-Unique: aZ-MLw8yNrWEuOqR87sO8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20EAE100C67B;
        Wed, 16 Dec 2020 12:07:14 +0000 (UTC)
Received: from gondolin (ovpn-113-163.ams2.redhat.com [10.36.113.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 910A85F9B0;
        Wed, 16 Dec 2020 12:07:12 +0000 (UTC)
Date:   Wed, 16 Dec 2020 13:07:10 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Boris Fiuczynski <fiuczy@linux.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.vnet.ibm.com>,
        oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        farman@linux.ibm.com
Subject: Re: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
Message-ID: <20201216130710.5aa6a933.cohuck@redhat.com>
In-Reply-To: <89146a87-371a-f148-057b-d3b7ce0cc21e@linux.ibm.com>
References: <20201124093407.23189-1-vneethv@linux.ibm.com>
        <20201124093407.23189-2-vneethv@linux.ibm.com>
        <20201124140220.77c65539.cohuck@redhat.com>
        <4be7e163-1118-d365-7d25-df39ba78181f@linux.vnet.ibm.com>
        <0b4e34b7-7a4e-71b0-8a64-ea909e64f416@linux.ibm.com>
        <20201208183054.44f4fc2d.cohuck@redhat.com>
        <20201209135203.0008ab18.pasic@linux.ibm.com>
        <20201215191307.281c6e6f.cohuck@redhat.com>
        <89146a87-371a-f148-057b-d3b7ce0cc21e@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 16 Dec 2020 12:53:41 +0100
Boris Fiuczynski <fiuczy@linux.ibm.com> wrote:

> On 12/15/20 7:13 PM, Cornelia Huck wrote:
> >>     
> >>> I'm not sure how many rules actually care about events for the
> >>> subchannel device; the ccw device seems like the more helpful device to
> >>> watch out for.  
> >> I tend to agree, but the problem with vfio-ccw is that (currently) we
> >> don't have a ccw device in the host, because we pass-through the
> >> subchannel. When we interrogate the subchannel, we do learn if there
> >> is a device and if, what is its devno. If I were to run a system with
> >> vfio-ccw passthrough, I would want to passthrough the subchannel that
> >> talks to the DASD (identified by devno) I need passed through to my
> >> guest.  
> > I think that can be solved by simply adding the devno as a variable to
> > the uevent (valid if it's an I/O subchannel; we don't register the
> > subchannel in the first place if dnv is not set.)
> >   
> Providing the devno in the context of the udev event certainly helps if 
> the event consumer would base its actions on it.
> As far as I understand the driver_override mechanics driverctl sets the 
> override based on a specified device. In that case the devno would not 
> be looked at and the subchannel would end up with a vfio-ccw driver even 
> so the ccw device might not be the one we want to use as pass-through 
> device.

Hm, maybe we need to make a change in driverctl that allows per-bus
custom rules?

