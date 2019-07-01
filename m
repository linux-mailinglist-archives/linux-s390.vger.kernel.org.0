Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D741502E6
	for <lists+linux-s390@lfdr.de>; Mon, 24 Jun 2019 09:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfFXHRq (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 24 Jun 2019 03:17:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfFXHRq (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Jun 2019 03:17:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C6C7308FEC6;
        Mon, 24 Jun 2019 07:17:46 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B00115D739;
        Mon, 24 Jun 2019 07:17:42 +0000 (UTC)
Date:   Mon, 24 Jun 2019 09:17:40 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Sebastian Ott <sebott@linux.ibm.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/cio: introduce driver_override on the css bus
Message-ID: <20190624091740.1d9c6c1d.cohuck@redhat.com>
In-Reply-To: <alpine.LFD.2.21.1906211817010.2388@schleppi>
References: <20190613110815.17251-1-cohuck@redhat.com>
        <alpine.LFD.2.21.1906211817010.2388@schleppi>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 24 Jun 2019 07:17:46 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 21 Jun 2019 18:19:36 +0200 (CEST)
Sebastian Ott <sebott@linux.ibm.com> wrote:

> On Thu, 13 Jun 2019, Cornelia Huck wrote:
> > Sometimes, we want to control which of the matching drivers
> > binds to a subchannel device (e.g. for subchannels we want to
> > handle via vfio-ccw).
> > 
> > For pci devices, a mechanism to do so has been introduced in
> > 782a985d7af2 ("PCI: Introduce new device binding path using
> > pci_dev.driver_override"). It makes sense to introduce the
> > driver_override attribute for subchannel devices as well, so
> > that we can easily extend the 'driverctl' tool (which makes
> > use of the driver_override attribute for pci).
> > 
> > Note that unlike pci we still require a driver override to
> > match the subchannel type; matching more than one subchannel
> > type is probably not useful anyway.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> 
> Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
> 
> Should I take that via our git tree or do you have other patches depending 
> on this one?
> 

No, this patch is stand-alone; everything else is happening in user
space, so taking it via your tree would be great. Thanks!
