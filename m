Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F286C195769
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2020 13:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgC0Mp0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 27 Mar 2020 08:45:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:52153 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726959AbgC0Mp0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 08:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585313125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQV18ZnM2RMqffP1aaZhrnsNZxh9rsXGkVzvGtwtfAs=;
        b=OZvpyfyyax8a8Fp5JnHxAx2lTDhBxuDWgEFa7jIwf91JQAqdbwJRjXXoe/UyFxTYnuRrEA
        qGDikZRm36O+zyBkjCCcdOfmA8gzB1ipE5zkkHgwKB0a4ScW2MiK5F+HaZe/NkEcg3IcGY
        /LDb7el7QyLPKG6Ehw6WHxg512FvbGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-SFGzXh5kOKmWTzmI2mkoww-1; Fri, 27 Mar 2020 08:45:22 -0400
X-MC-Unique: SFGzXh5kOKmWTzmI2mkoww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D2A3800EBD;
        Fri, 27 Mar 2020 12:45:20 +0000 (UTC)
Received: from localhost (ovpn-113-83.ams2.redhat.com [10.36.113.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2828319757;
        Fri, 27 Mar 2020 12:45:19 +0000 (UTC)
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
Subject: [PATCH 2/2] s390/cio: generate delayed uevent for vfio-ccw subchannels
Date:   Fri, 27 Mar 2020 13:45:03 +0100
Message-Id: <20200327124503.9794-3-cohuck@redhat.com>
In-Reply-To: <20200327124503.9794-1-cohuck@redhat.com>
References: <20200327124503.9794-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The common I/O layer delays the ADD uevent for subchannels and
delegates generating this uevent to the individual subchannel
drivers. The vfio-ccw I/O subchannel driver, however, did not
do that, and will not generate an ADD uevent for subchannels
that had not been bound to a different driver (or none at all,
which also triggers the uevent).

Generate the ADD uevent at the end of the probe function if
uevents were still suppressed for the device.

Fixes: 63f1934d562d ("vfio: ccw: basic implementation for vfio_ccw driver=
")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
index e401a3d0aa57..339a6bc0339b 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -167,6 +167,11 @@ static int vfio_ccw_sch_probe(struct subchannel *sch=
)
 	if (ret)
 		goto out_disable;
=20
+	if (dev_get_uevent_suppress(&sch->dev)) {
+		dev_set_uevent_suppress(&sch->dev, 0);
+		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
+	}
+
 	VFIO_CCW_MSG_EVENT(4, "bound to subchannel %x.%x.%04x\n",
 			   sch->schid.cssid, sch->schid.ssid,
 			   sch->schid.sch_no);
--=20
2.21.1

