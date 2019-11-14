Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52E87FC8F5
	for <lists+linux-s390@lfdr.de>; Thu, 14 Nov 2019 15:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfKNOez (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 14 Nov 2019 09:34:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNOey (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 09:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+97M8q/DzVxkSwZO0CoMlnFjgCzRSA/777Cpn7hubd0=; b=u3xIPxkm5T+hxMUrf3pEe+tQ2j
        P34+wcNpbN/bWtm97MBi82YYbCK4c8gxTBliGQiRG78bD2A/q3bHukAv5nHvMEaF4liE7EgqjEBM9
        amLffTW6Y49dmjPpX0ID4su1QIs0UDdD6dXU7tuGGNaCua/9Hp43crRbKGrbggFjgSBomTWMWtqV+
        rjiVCPi5bXRH4y744deStEo1TJCJpOKg9SLk7g3/IrAdBZrmn7yK8H27K8uXvgbXR5JsE1BCbcwow
        tbaugv5aOo37KNMetUJq9leu/BeRqul21qvrpQL99Ol9AcFVCLnLWeBxk4K8EIFWvejuE9H2Dp7Ix
        cQnJ0MGg==;
Received: from [2001:4bb8:180:3806:c70:4a89:bc61:6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVGCz-0004ke-EP; Thu, 14 Nov 2019 14:34:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 5/7] block: remove (__)blkdev_reread_part as an exported API
Date:   Thu, 14 Nov 2019 15:34:36 +0100
Message-Id: <20191114143438.14681-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114143438.14681-1-hch@lst.de>
References: <20191114143438.14681-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

In general drivers should never mess with partition tables directly.
Unfortunately s390 and loop do for somewhat historic reasons, but they
can use bdev_disk_changed directly instead when we export it as they
satisfy the sanity checks we have in __blkdev_reread_part.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>	[dasd]
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/ioctl.c                   | 35 +++++----------------------------
 drivers/block/loop.c            | 13 +++++++-----
 drivers/s390/block/dasd_genhd.c |  4 +++-
 fs/block_dev.c                  |  7 +++++++
 include/linux/fs.h              |  2 --
 5 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 5ccd9f016594..7ac8a66c9787 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -155,46 +155,21 @@ static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user
 	}
 }
 
-/*
- * This is an exported API for the block driver, and will not
- * acquire bd_mutex. This API should be used in case that
- * caller has held bd_mutex already.
- */
-int __blkdev_reread_part(struct block_device *bdev)
+static int blkdev_reread_part(struct block_device *bdev)
 {
+	int ret;
+
 	if (!disk_part_scan_enabled(bdev->bd_disk) || bdev != bdev->bd_contains)
 		return -EINVAL;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	lockdep_assert_held(&bdev->bd_mutex);
-
-	return bdev_disk_changed(bdev, false);
-}
-EXPORT_SYMBOL(__blkdev_reread_part);
-
-/*
- * This is an exported API for the block driver, and will
- * try to acquire bd_mutex. If bd_mutex has been held already
- * in current context, please call __blkdev_reread_part().
- *
- * Make sure the held locks in current context aren't required
- * in open()/close() handler and I/O path for avoiding ABBA deadlock:
- * - bd_mutex is held before calling block driver's open/close
- *   handler
- * - reading partition table may submit I/O to the block device
- */
-int blkdev_reread_part(struct block_device *bdev)
-{
-	int res;
-
 	mutex_lock(&bdev->bd_mutex);
-	res = __blkdev_reread_part(bdev);
+	ret = bdev_disk_changed(bdev, false);
 	mutex_unlock(&bdev->bd_mutex);
 
-	return res;
+	return ret;
 }
-EXPORT_SYMBOL(blkdev_reread_part);
 
 static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 		unsigned long arg, unsigned long flags)
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ef6e251857c8..739b372a5112 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -640,7 +640,9 @@ static void loop_reread_partitions(struct loop_device *lo,
 {
 	int rc;
 
-	rc = blkdev_reread_part(bdev);
+	mutex_lock(&bdev->bd_mutex);
+	rc = bdev_disk_changed(bdev, false);
+	mutex_unlock(&bdev->bd_mutex);
 	if (rc)
 		pr_warn("%s: partition scan of loop%d (%s) failed (rc=%d)\n",
 			__func__, lo->lo_number, lo->lo_file_name, rc);
@@ -1164,10 +1166,11 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 		 * must be at least one and it can only become zero when the
 		 * current holder is released.
 		 */
-		if (release)
-			err = __blkdev_reread_part(bdev);
-		else
-			err = blkdev_reread_part(bdev);
+		if (!release)
+			mutex_lock(&bdev->bd_mutex);
+		err = bdev_disk_changed(bdev, false);
+		if (!release)
+			mutex_unlock(&bdev->bd_mutex);
 		if (err)
 			pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
 				__func__, lo_number, err);
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 5542d9eadfe0..7d079154f849 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -116,7 +116,9 @@ int dasd_scan_partitions(struct dasd_block *block)
 		return -ENODEV;
 	}
 
-	rc = blkdev_reread_part(bdev);
+	mutex_lock(&bdev->bd_mutex);
+	rc = bdev_disk_changed(bdev, false);
+	mutex_unlock(&bdev->bd_mutex);
 	if (rc)
 		DBF_DEV_EVENT(DBF_ERR, block->base,
 				"scan partitions error, rc %d", rc);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index ae16466a67f7..9558a2f064b1 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1513,6 +1513,8 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 	struct gendisk *disk = bdev->bd_disk;
 	int ret;
 
+	lockdep_assert_held(&bdev->bd_mutex);
+
 rescan:
 	ret = blk_drop_partitions(disk, bdev);
 	if (ret)
@@ -1540,6 +1542,11 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 
 	return ret;
 }
+/*
+ * Only exported for for loop and dasd for historic reasons.  Don't use in new
+ * code!
+ */
+EXPORT_SYMBOL_GPL(bdev_disk_changed);
 
 /*
  * bd_mutex locking:
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d233dd661df7..ae6c5c37f3ae 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2632,8 +2632,6 @@ extern void bd_finish_claiming(struct block_device *bdev,
 extern void bd_abort_claiming(struct block_device *bdev,
 			      struct block_device *whole, void *holder);
 extern void blkdev_put(struct block_device *bdev, fmode_t mode);
-extern int __blkdev_reread_part(struct block_device *bdev);
-extern int blkdev_reread_part(struct block_device *bdev);
 
 #ifdef CONFIG_SYSFS
 extern int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
-- 
2.20.1

