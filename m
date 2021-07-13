Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21DA3C6B61
	for <lists+linux-s390@lfdr.de>; Tue, 13 Jul 2021 09:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhGMHn3 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 13 Jul 2021 03:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbhGMHn3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Jul 2021 03:43:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81951C0613DD
        for <linux-s390@vger.kernel.org>; Tue, 13 Jul 2021 00:40:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3D1j-0003xz-4k; Tue, 13 Jul 2021 09:40:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3D1h-0006Py-Jh; Tue, 13 Jul 2021 09:40:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3D1h-0000vP-Ie; Tue, 13 Jul 2021 09:40:21 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@pengutronix.de,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 2/5] s390/cio: Make struct css_driver::remove return void
Date:   Tue, 13 Jul 2021 09:40:11 +0200
Message-Id: <20210713074014.684791-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713074014.684791-1-u.kleine-koenig@pengutronix.de>
References: <20210713074014.684791-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=Zzh6Qah9igZDzbjfUk8AwTB4DBF9iwmgRJQWuOwvwcc=; m=NJ6Mrq9SGd+6Raj4Ph3u7WcDxqXD2X9JpTrAqQ6iaJc=; p=dIvXn065WcUeFDWu88dn/CVmtGJ9aRxWBgN4OMyj3Gw=; g=8a2a8dab3e3a8f389794804b23c10178add091b4
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDtQzgACgkQwfwUeK3K7AkEZQf9ESX O1FmCODfAQ9yF+paMVBqOutxPpjaUHr4N0kf0U4rQuCsTftLcpduS+5xmgDONEPvWkOGK4vdD8BxN Pl2Sd/WAHAOUqPoPuLVFTyIh+hazmgFuGQaS9dusyasZlKxssitxKHqKMobW+w+5Ldf6ngA6aCod6 9hcbjLD0BpY8gT1eqYLU6S7JGUGrd2X6S8tl+L1IZl17oa2SijOhEFCrPfm7YAGLebpelbzi6SPRp dk9w3hV6bzmaxzWaSv/VlPe6mdWtWMisyXMRTZ4zHvZYO26+upnxWQJqm5TTHgVFgqbSx7cpYPPWT u5PJ+9dAXSMjMKrE7Lm5PGL7U1RpAcA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The driver core ignores the return value of css_remove()
(because there is only little it can do when a device disappears) and
all callbacks return 0 anyhow.

So make it impossible for future drivers to return an unused error code
by changing the remove prototype to return void.

The real motivation for this change is the quest to make struct
bus_type::remove return void, too.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/s390/cio/chsc_sch.c     | 3 +--
 drivers/s390/cio/css.c          | 7 ++++---
 drivers/s390/cio/css.h          | 2 +-
 drivers/s390/cio/device.c       | 5 ++---
 drivers/s390/cio/eadm_sch.c     | 4 +---
 drivers/s390/cio/vfio_ccw_drv.c | 3 +--
 6 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index c42405c620b5..684348d82f08 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -100,7 +100,7 @@ static int chsc_subchannel_probe(struct subchannel *sch)
 	return ret;
 }
 
-static int chsc_subchannel_remove(struct subchannel *sch)
+static void chsc_subchannel_remove(struct subchannel *sch)
 {
 	struct chsc_private *private;
 
@@ -112,7 +112,6 @@ static int chsc_subchannel_remove(struct subchannel *sch)
 		put_device(&sch->dev);
 	}
 	kfree(private);
-	return 0;
 }
 
 static void chsc_subchannel_shutdown(struct subchannel *sch)
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index a974943c27da..092fd1ea5799 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -1374,12 +1374,13 @@ static int css_probe(struct device *dev)
 static int css_remove(struct device *dev)
 {
 	struct subchannel *sch;
-	int ret;
 
 	sch = to_subchannel(dev);
-	ret = sch->driver->remove ? sch->driver->remove(sch) : 0;
+	if (sch->driver->remove)
+		sch->driver->remove(sch);
 	sch->driver = NULL;
-	return ret;
+
+	return 0;
 }
 
 static void css_shutdown(struct device *dev)
diff --git a/drivers/s390/cio/css.h b/drivers/s390/cio/css.h
index 2eddfc47f687..c98522cbe276 100644
--- a/drivers/s390/cio/css.h
+++ b/drivers/s390/cio/css.h
@@ -81,7 +81,7 @@ struct css_driver {
 	int (*chp_event)(struct subchannel *, struct chp_link *, int);
 	int (*sch_event)(struct subchannel *, int);
 	int (*probe)(struct subchannel *);
-	int (*remove)(struct subchannel *);
+	void (*remove)(struct subchannel *);
 	void (*shutdown)(struct subchannel *);
 	int (*settle)(void);
 };
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 84f659cafe76..cd5d2d4d8e46 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -137,7 +137,7 @@ static int ccw_uevent(struct device *dev, struct kobj_uevent_env *env)
 
 static void io_subchannel_irq(struct subchannel *);
 static int io_subchannel_probe(struct subchannel *);
-static int io_subchannel_remove(struct subchannel *);
+static void io_subchannel_remove(struct subchannel *);
 static void io_subchannel_shutdown(struct subchannel *);
 static int io_subchannel_sch_event(struct subchannel *, int);
 static int io_subchannel_chp_event(struct subchannel *, struct chp_link *,
@@ -1101,7 +1101,7 @@ static int io_subchannel_probe(struct subchannel *sch)
 	return 0;
 }
 
-static int io_subchannel_remove(struct subchannel *sch)
+static void io_subchannel_remove(struct subchannel *sch)
 {
 	struct io_subchannel_private *io_priv = to_io_private(sch);
 	struct ccw_device *cdev;
@@ -1120,7 +1120,6 @@ static int io_subchannel_remove(struct subchannel *sch)
 			  io_priv->dma_area, io_priv->dma_area_dma);
 	kfree(io_priv);
 	sysfs_remove_group(&sch->dev.kobj, &io_subchannel_attr_group);
-	return 0;
 }
 
 static void io_subchannel_verify(struct subchannel *sch)
diff --git a/drivers/s390/cio/eadm_sch.c b/drivers/s390/cio/eadm_sch.c
index c8964e0a23e7..15bdae5981ca 100644
--- a/drivers/s390/cio/eadm_sch.c
+++ b/drivers/s390/cio/eadm_sch.c
@@ -282,7 +282,7 @@ static void eadm_quiesce(struct subchannel *sch)
 	spin_unlock_irq(sch->lock);
 }
 
-static int eadm_subchannel_remove(struct subchannel *sch)
+static void eadm_subchannel_remove(struct subchannel *sch)
 {
 	struct eadm_private *private = get_eadm_private(sch);
 
@@ -297,8 +297,6 @@ static int eadm_subchannel_remove(struct subchannel *sch)
 	spin_unlock_irq(sch->lock);
 
 	kfree(private);
-
-	return 0;
 }
 
 static void eadm_subchannel_shutdown(struct subchannel *sch)
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 9b61e9b131ad..76099bcb765b 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -234,7 +234,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	return ret;
 }
 
-static int vfio_ccw_sch_remove(struct subchannel *sch)
+static void vfio_ccw_sch_remove(struct subchannel *sch)
 {
 	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
 	struct vfio_ccw_crw *crw, *temp;
@@ -257,7 +257,6 @@ static int vfio_ccw_sch_remove(struct subchannel *sch)
 	VFIO_CCW_MSG_EVENT(4, "unbound from subchannel %x.%x.%04x\n",
 			   sch->schid.cssid, sch->schid.ssid,
 			   sch->schid.sch_no);
-	return 0;
 }
 
 static void vfio_ccw_sch_shutdown(struct subchannel *sch)
-- 
2.30.2

