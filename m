Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D05B64EA32
	for <lists+linux-s390@lfdr.de>; Fri, 21 Jun 2019 16:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfFUOF6 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 21 Jun 2019 10:05:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfFUOF5 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Jun 2019 10:05:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB4FF30C31B1;
        Fri, 21 Jun 2019 14:05:57 +0000 (UTC)
Received: from gondolin (dhcp-192-192.str.redhat.com [10.33.192.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1269E61101;
        Fri, 21 Jun 2019 14:05:53 +0000 (UTC)
Date:   Fri, 21 Jun 2019 16:05:51 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Sebastian Ott <sebott@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/cio: introduce driver_override on the css bus
Message-ID: <20190621160551.7f11adb7.cohuck@redhat.com>
In-Reply-To: <20190621153711.7d713c4d.pasic@linux.ibm.com>
References: <20190613110815.17251-1-cohuck@redhat.com>
        <20190621115604.0f3e3f69.cohuck@redhat.com>
        <20190621153711.7d713c4d.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 21 Jun 2019 14:05:57 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 21 Jun 2019 15:37:11 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Fri, 21 Jun 2019 11:56:04 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Thu, 13 Jun 2019 13:08:15 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> > > Sometimes, we want to control which of the matching drivers
> > > binds to a subchannel device (e.g. for subchannels we want to
> > > handle via vfio-ccw).
> > > 
> > > For pci devices, a mechanism to do so has been introduced in
> > > 782a985d7af2 ("PCI: Introduce new device binding path using
> > > pci_dev.driver_override"). It makes sense to introduce the
> > > driver_override attribute for subchannel devices as well, so
> > > that we can easily extend the 'driverctl' tool (which makes
> > > use of the driver_override attribute for pci).
> > > 
> > > Note that unlike pci we still require a driver override to
> > > match the subchannel type; matching more than one subchannel
> > > type is probably not useful anyway.
> > > 
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> 
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

Thanks!

> 
> I guess the '\n' handling is customary, and is what the same what
> the pci counterpart (782a985d7af2) does anyway. It bothers
> me a little that you don't necessarily get back from with show
> what you stored. E.g. # echo -e "bug\nfree"
> > /sys/bus/css/devices/0.0.0001/driver_override # echo $?  
> 0
> # cat /sys/bus/css/devices/0.0.0001/driver_override
> bug
> # echo $?
> 0
> But given the previous art (782a985d7af2) I think it is the best way
> to do it.

Yeah; I shamelessly copied a lot :) And I agree it's probably useful to
have both act in the same way.

> 
> The rest is very straightforward.
> 
> > > ---
> > > 
> > > Lightly tested; did not yet attempt to adapt driverctl to actually
> > > make use of it.  
> > 
> > Friendly ping.
> > 
> > In the meanwhile, I figured out that you do not need to adapt driverctl
> > at all, but just need to pass it '-b css' to work on the css bus; this
> > seems to work just fine with this patch applied.
> >   
> 
> Interesting. I hope to get around and have a closer look at it
> eventually.

Nice; somebody else looking at it is always useful :)
