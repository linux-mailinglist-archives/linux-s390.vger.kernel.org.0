Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4D3419D528
	for <lists+linux-s390@lfdr.de>; Fri,  3 Apr 2020 12:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgDCKk5 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 Apr 2020 06:40:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28223 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727774AbgDCKk5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Apr 2020 06:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585910455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JaqVOeV6WYQw59j0NJVQ65MCQt+9qO9Y0ftJtqHK2uw=;
        b=SqRqEJ3Z10gETxaBZMOzcCGZF83GkFGslibv9GJt0E5IMAL6OHZXu65jEE0AMEppNoeMNn
        ugOF4FeSm6Ex0n95f4zmDrbIOdPu1UiMOXR2F0tdjismB68Gd9aZK3OkIzgBObjXGfoeCS
        oLDm/122hG/U6qH7N+U6hO3Y7l5HVg8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-0oum-T7ENXKNgbJLiPYztQ-1; Fri, 03 Apr 2020 06:40:52 -0400
X-MC-Unique: 0oum-T7ENXKNgbJLiPYztQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6DC9100551A;
        Fri,  3 Apr 2020 10:40:50 +0000 (UTC)
Received: from gondolin (ovpn-113-80.ams2.redhat.com [10.36.113.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88EAF10016E8;
        Fri,  3 Apr 2020 10:40:34 +0000 (UTC)
Date:   Fri, 3 Apr 2020 12:40:32 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Boris Fiuczynski <fiuczy@linux.ibm.com>
Subject: [RFD] uevent handling for subchannels
Message-ID: <20200403124032.5e70603d.cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi,

this is kind-of-a-followup to the uevent patches I sent in
<20200327124503.9794-1-cohuck@redhat.com> last Friday.

Currently, the common I/O layer will suppress uevents for subchannels
that are being registered, delegating generating a delayed ADD uevent
to the driver that actually binds to it and only generating the uevent
itself if no driver gets bound. The initial version of that delaying
was introduced in fa1a8c23eb7d ("s390: cio: Delay uevents for
subchannels"); from what I remember, we were seeing quite bad storms of
uevents on LPARs that had a lot of I/O subchannels with no device
accessible through them.

So while there's definitely a good reason for wanting to delay uevents,
it is also introducing problems. One is udev rules for subchannels that
are supposed to do something before a driver binds (e.g. setting
driver_override to bind an I/O subchannel to vfio_ccw instead of
io_subchannel) are not effective, as the ADD uevent will only be
generated when the io_subchannel driver is already done with doing all
setup. Another one is that only the ADD uevent is generated after
uevent suppression is lifted; any other uevents that might have been
generated are lost.

So, what to do about this, especially in the light of vfio-ccw handling?

One idea I had is to call css_sch_is_valid() from
css_register_subchannel(); this would exclude the largest class of
non-operational subchannels already (those that don't have a valid
device; I'm not quite sure if there's also something needed for EADM
subchannels?) If we got rid of the uevent delaying, we would still get
ADD/REMOVE events for subchannels where the device turns out to be
non-accessible, but I believe (hope) that those are not too many in a
sane system at least. As a bonus, we could also add additional values
from the pmcw to the uevent; the device number, for example, could be
helpful for vfio-ccw matching rules.

A drawback is that we change the timing (not the sequence, AFAICS) of
the uevents, which might break brittle setups.

Thoughts?

