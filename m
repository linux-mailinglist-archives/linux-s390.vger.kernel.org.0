Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA9BB195767
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2020 13:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgC0MpV (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 27 Mar 2020 08:45:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:31093 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726515AbgC0MpU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 08:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585313119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FMkBTOJe0DP7Ot4XfrPUMmSeZ1ST3gJQ80CKfDOs0Ho=;
        b=Gbf2tG5C3eXMKWMasBarnmSHdayeNsAGjjQ1/6m2uQjiUNRf43gw4kafrlgzQKzW7nJ7ZM
        8oEUyiZnTYH09b65iUrwJ3hRMjG1ZMCq/pyBY0UBiIxLrrwrZp4kGqVH5GB9esT+d+yaik
        Q3oUVdPS6HHSL8G8bP5SKQPGONXlz3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-7OTHWLC2MXKmDySOn59Ebg-1; Fri, 27 Mar 2020 08:45:17 -0400
X-MC-Unique: 7OTHWLC2MXKmDySOn59Ebg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3ABEECF98B;
        Fri, 27 Mar 2020 12:45:16 +0000 (UTC)
Received: from localhost (ovpn-113-83.ams2.redhat.com [10.36.113.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C172D5DA2C;
        Fri, 27 Mar 2020 12:45:15 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     linux-s390@vger.kernel.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Boris Fiuczynski <fiuczy@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 0/2] s390/cio: correct some uevent issues
Date:   Fri, 27 Mar 2020 13:45:01 +0100
Message-Id: <20200327124503.9794-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

For subchannels, we currently delay the initial ADD uevent to a
point in time controlled by the driver bound to it (this is to
avoid a storm of useless uevents for I/O subchannels that do not
have an operational device behind it and will get deregistered
again, which are potentially a lot on LPARs.)

If we unbind from the io_subchannel driver and rebind again later,
we'll get a duplicate ADD uevent -- not a common workflow, but might
happen e.g. when you use a device in the host, then pass it to a
guest via vfio-ccw, and then want to use it in the host again. Fixed
by the first patch.

The vfio_ccw subchannel driver did not generate any ADD uevent at
all -- currently not a problem, as every I/O subchannel will have been
bound to the io_subchannel driver before, but let's fix this anyway
(second patch).

[As an aside, setting driver_override via a udev rule does not work
as expected, due to the uevent delaying -- a specified driver_override
works as designed, but userspace won't get the ADD uevent until after
the io_subchannel driver has been bound to the device already... we
may want to rethink this whole uevent mechanism for subchannels later,
but I don't think it's too pressing an issue.]

Probably easiest for both patches to go via the s390 arch maintainers.

Cornelia Huck (2):
  s390/cio: avoid duplicated 'ADD' uevents
  s390/cio: generate delayed uevent for vfio-ccw subchannels

 drivers/s390/cio/device.c       | 13 +++++++++----
 drivers/s390/cio/vfio_ccw_drv.c |  5 +++++
 2 files changed, 14 insertions(+), 4 deletions(-)

--=20
2.21.1

