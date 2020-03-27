Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 368CC195768
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2020 13:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgC0MpZ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 27 Mar 2020 08:45:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26511 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726959AbgC0MpY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 08:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585313123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uh02brwAs6UPf8g54VJ7ZJZWeQPovjkk5isHWN8xgE=;
        b=iM2AlE89ylgs1Z0D9gJlgocIl2H18nluV0hbolvIA9EAJDJOQGI0uBri9+K08GfhVquIOx
        5WoD++RuQvx+8yrwWBKOzqaczxZOGwHbojlkcf0NQu+ZmpLM8p9nJ0bF0lA8xiItX2l0Ds
        Zkv1DlSxTzHXty5kyvP0Usxlpycqulk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-iku9qQwHPjSzUiU680LnmA-1; Fri, 27 Mar 2020 08:45:20 -0400
X-MC-Unique: iku9qQwHPjSzUiU680LnmA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 641C0107ACC7;
        Fri, 27 Mar 2020 12:45:18 +0000 (UTC)
Received: from localhost (ovpn-113-83.ams2.redhat.com [10.36.113.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F11BC19488;
        Fri, 27 Mar 2020 12:45:17 +0000 (UTC)
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
Subject: [PATCH 1/2] s390/cio: avoid duplicated 'ADD' uevents
Date:   Fri, 27 Mar 2020 13:45:02 +0100
Message-Id: <20200327124503.9794-2-cohuck@redhat.com>
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
drivers. The io_subchannel driver will do so when the associated
ccw_device has been registered -- but unconditionally, so more
ADD uevents will be generated if a subchannel has been unbound
from the io_subchannel driver and later rebound.

To fix this, only generate the ADD event if uevents were still
suppressed for the device.

Reported-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
Fixes: fa1a8c23eb7d ("s390: cio: Delay uevents for subchannels")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/device.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 0c6245fc7706..983f9c9e08de 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -849,8 +849,10 @@ static void io_subchannel_register(struct ccw_device=
 *cdev)
 	 * Now we know this subchannel will stay, we can throw
 	 * our delayed uevent.
 	 */
-	dev_set_uevent_suppress(&sch->dev, 0);
-	kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
+	if (dev_get_uevent_suppress(&sch->dev)) {
+		dev_set_uevent_suppress(&sch->dev, 0);
+		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
+	}
 	/* make it known to the system */
 	ret =3D ccw_device_add(cdev);
 	if (ret) {
@@ -1058,8 +1060,11 @@ static int io_subchannel_probe(struct subchannel *=
sch)
 		 * Throw the delayed uevent for the subchannel, register
 		 * the ccw_device and exit.
 		 */
-		dev_set_uevent_suppress(&sch->dev, 0);
-		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
+		if (dev_get_uevent_suppress(&sch->dev)) {
+			/* should always be the case for the console */
+			dev_set_uevent_suppress(&sch->dev, 0);
+			kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
+		}
 		cdev =3D sch_get_cdev(sch);
 		rc =3D ccw_device_add(cdev);
 		if (rc) {
--=20
2.21.1

