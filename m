Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBFF2C83D2
	for <lists+linux-s390@lfdr.de>; Mon, 30 Nov 2020 13:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgK3MEn (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 30 Nov 2020 07:04:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9072 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgK3MEn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 Nov 2020 07:04:43 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cl3m04d5RzLxqn;
        Mon, 30 Nov 2020 20:03:28 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 30 Nov 2020 20:03:52 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Steffen Maier <maier@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH] scsi: zfcp: move the position of put_device
Date:   Mon, 30 Nov 2020 20:11:54 +0800
Message-ID: <20201130121154.194190-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Have the `put_device()` call after `device_unregister()` in both
`zfcp_unit_remove()` and `zfcp_sysfs_port_remove_store()` to make
it more natural, for put_device() ought to be the last time we
touch the object in both functions.

Suggested-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/s390/scsi/zfcp_sysfs.c | 4 ++--
 drivers/s390/scsi/zfcp_unit.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_sysfs.c b/drivers/s390/scsi/zfcp_sysfs.c
index 8d9662e8b..edfeed4ba 100644
--- a/drivers/s390/scsi/zfcp_sysfs.c
+++ b/drivers/s390/scsi/zfcp_sysfs.c
@@ -327,10 +327,10 @@ static ssize_t zfcp_sysfs_port_remove_store(struct device *dev,
 	list_del(&port->list);
 	write_unlock_irq(&adapter->port_list_lock);
 
-	put_device(&port->dev);
-
 	zfcp_erp_port_shutdown(port, 0, "syprs_1");
 	device_unregister(&port->dev);
+
+	put_device(&port->dev);
  out:
 	zfcp_ccw_adapter_put(adapter);
 	return retval ? retval : (ssize_t) count;
diff --git a/drivers/s390/scsi/zfcp_unit.c b/drivers/s390/scsi/zfcp_unit.c
index e67bf7388..4ee355ae1 100644
--- a/drivers/s390/scsi/zfcp_unit.c
+++ b/drivers/s390/scsi/zfcp_unit.c
@@ -255,9 +255,9 @@ int zfcp_unit_remove(struct zfcp_port *port, u64 fcp_lun)
 		scsi_device_put(sdev);
 	}
 
-	put_device(&unit->dev);
-
 	device_unregister(&unit->dev);
 
+	put_device(&unit->dev);
+
 	return 0;
 }
-- 
2.23.0

