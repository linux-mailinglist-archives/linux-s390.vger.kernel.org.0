Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52693C6B5E
	for <lists+linux-s390@lfdr.de>; Tue, 13 Jul 2021 09:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbhGMHn0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 13 Jul 2021 03:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbhGMHnZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Jul 2021 03:43:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9EBC0613EE
        for <linux-s390@vger.kernel.org>; Tue, 13 Jul 2021 00:40:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3D1l-000435-Ip; Tue, 13 Jul 2021 09:40:25 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3D1l-0006Qj-1H; Tue, 13 Jul 2021 09:40:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3D1h-0000vv-VE; Tue, 13 Jul 2021 09:40:21 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@pengutronix.de,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 4/5] s390/scm: Make struct scm_driver::remove return void
Date:   Tue, 13 Jul 2021 09:40:13 +0200
Message-Id: <20210713074014.684791-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713074014.684791-1-u.kleine-koenig@pengutronix.de>
References: <20210713074014.684791-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=ktkMzQSAAyHCymxHaeuezQhJvasMyN9hNxYTQRFBFeQ=; m=P1AAUGZpbPCPO5X70OZJM21oQma4swJvSOO9wO7GJmw=; p=gttOw7RSWj+rG5XX1mcdi+yFxjr52UsL+JH53OMp2Wg=; g=f86d4654b18b6749acbbaeaf2b9c03f3c75eb3d2
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDtQz4ACgkQwfwUeK3K7Ak+zwf+IIW VJpNw43LftUXtG7YN6A71rhCSQNQI0fAQ8rbSSr077spsOk14vNTAahve+bfAtB8Wmw7u4MVXqlQg rGH8FkFLxVYFgiSXY5d+nzI884fwBFzYmAkIQqwhY3Kb2dzz4pnC/azgxGOUushV37E1Uo7Auv5Qv YA8mjjskP6rAhnnON3S6k9TqO8gAVz+v5L5t13xnwuOp6/zks4dHtm3CU3nd/6vndq23B1V0i8hal fLcSTdxpCOwbCXlSWa+pvf9c2/k0z8r9KWW/0zcZazGyLt5a14lsLh7kk8Eo1H1Ta9eQpuFZ9QuJ4 4qgyG2mXmAytx+RZRGauLEKhTmHL5Hg==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The driver core ignores the return value of scmdev_remove()
(because there is only little it can do when a device disappears).

So make it impossible for future drivers to return an unused error code
by changing the remove prototype to return void.

The real motivation for this change is the quest to make struct
bus_type::remove return void, too.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/s390/include/asm/eadm.h | 2 +-
 drivers/s390/block/scm_drv.c | 4 +---
 drivers/s390/cio/scm.c       | 5 ++++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/eadm.h b/arch/s390/include/asm/eadm.h
index bb63b2afdf6f..445fe4c8184a 100644
--- a/arch/s390/include/asm/eadm.h
+++ b/arch/s390/include/asm/eadm.h
@@ -105,7 +105,7 @@ enum scm_event {SCM_CHANGE, SCM_AVAIL};
 struct scm_driver {
 	struct device_driver drv;
 	int (*probe) (struct scm_device *scmdev);
-	int (*remove) (struct scm_device *scmdev);
+	void (*remove) (struct scm_device *scmdev);
 	void (*notify) (struct scm_device *scmdev, enum scm_event event);
 	void (*handler) (struct scm_device *scmdev, void *data,
 			blk_status_t error);
diff --git a/drivers/s390/block/scm_drv.c b/drivers/s390/block/scm_drv.c
index 3134fd6e058e..69a845eb8b1f 100644
--- a/drivers/s390/block/scm_drv.c
+++ b/drivers/s390/block/scm_drv.c
@@ -60,15 +60,13 @@ static int scm_probe(struct scm_device *scmdev)
 	return ret;
 }
 
-static int scm_remove(struct scm_device *scmdev)
+static void scm_remove(struct scm_device *scmdev)
 {
 	struct scm_blk_dev *bdev = dev_get_drvdata(&scmdev->dev);
 
 	scm_blk_dev_cleanup(bdev);
 	dev_set_drvdata(&scmdev->dev, NULL);
 	kfree(bdev);
-
-	return 0;
 }
 
 static struct scm_driver scm_drv = {
diff --git a/drivers/s390/cio/scm.c b/drivers/s390/cio/scm.c
index 9f26d4310bb3..b31711307e5a 100644
--- a/drivers/s390/cio/scm.c
+++ b/drivers/s390/cio/scm.c
@@ -33,7 +33,10 @@ static int scmdev_remove(struct device *dev)
 	struct scm_device *scmdev = to_scm_dev(dev);
 	struct scm_driver *scmdrv = to_scm_drv(dev->driver);
 
-	return scmdrv->remove ? scmdrv->remove(scmdev) : -ENODEV;
+	if (scmdrv->remove)
+		scmdrv->remove(scmdev);
+
+	return 0;
 }
 
 static int scmdev_uevent(struct device *dev, struct kobj_uevent_env *env)
-- 
2.30.2

