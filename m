Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5670F2BA3B0
	for <lists+linux-s390@lfdr.de>; Fri, 20 Nov 2020 08:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgKTHoV (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 20 Nov 2020 02:44:21 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7659 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgKTHoU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 Nov 2020 02:44:20 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CcpTG2YVFz15PdG;
        Fri, 20 Nov 2020 15:44:02 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 15:44:09 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH] s390: cio: fix two use-after-free bugs in device.c
Date:   Fri, 20 Nov 2020 15:48:49 +0800
Message-ID: <20201120074849.31557-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

put_device calls release function which do kfree() inside.
So following use of sch&cdev would cause use-after-free bugs.

Fix these by simply adjusting the position of put_device.

Fixes: 37db8985b211 ("s390/cio: add basic protected virtualization support")
Fixes: 74bd0d859dc3 ("s390/cio: fix unlocked access of online member")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/s390/cio/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index b29fe8d50..69492417b 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1664,10 +1664,10 @@ void __init ccw_device_destroy_console(struct ccw_device *cdev)
 	struct io_subchannel_private *io_priv = to_io_private(sch);
 
 	set_io_private(sch, NULL);
-	put_device(&sch->dev);
-	put_device(&cdev->dev);
 	dma_free_coherent(&sch->dev, sizeof(*io_priv->dma_area),
 			  io_priv->dma_area, io_priv->dma_area_dma);
+	put_device(&sch->dev);
+	put_device(&cdev->dev);
 	kfree(io_priv);
 }
 
@@ -1774,8 +1774,8 @@ static int ccw_device_remove(struct device *dev)
 				      ret, cdev->private->dev_id.ssid,
 				      cdev->private->dev_id.devno);
 		/* Give up reference obtained in ccw_device_set_online(). */
-		put_device(&cdev->dev);
 		spin_lock_irq(cdev->ccwlock);
+		put_device(&cdev->dev);
 	}
 	ccw_device_set_timeout(cdev, 0);
 	cdev->drv = NULL;
-- 
2.23.0

