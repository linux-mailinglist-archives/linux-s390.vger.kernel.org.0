Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB10F24D0FE
	for <lists+linux-s390@lfdr.de>; Fri, 21 Aug 2020 10:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgHUI5L (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 21 Aug 2020 04:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbgHUI46 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 21 Aug 2020 04:56:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52DEC061386;
        Fri, 21 Aug 2020 01:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=uWaR8ApvantUpqM86y/P+6964AqbZfZtPRdoPrYZqfs=; b=MgQe8ygJsGxVWTDs/6RJy96JPB
        VtEmPGH+UDa28L63F0p/Z+BU1XxgztmIcYxmlMnxcWr23Mx+6+3yrLIBMxp44IRYs9b5AqEXuJICo
        MWrYUt7rShYAaxKre4rWWSxUg4nxh5z4xBvwUiPnmV+jbZezQxadkhsJtMZlfKZS33g8+8zMn3oIa
        Hq41L9p3XhAR80AiSLXzLOiC4z0PMLQF3ny63yyWIyhWkwhBckgXQIrtUA9B2a5EJVcpY3vRwSATX
        LPVtPxAm+uPcIJPkoMzHuag1UZFHKcrtUtj+asivrOR4k4VprvTVymJYxqcqdNC3eGh0bU6eiTxUF
        pS4gYSDw==;
Received: from [2001:4bb8:198:f3b2:a2b:85ba:fb78:c253] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k92qV-0007hN-AY; Fri, 21 Aug 2020 08:56:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Xianting Tian <xianting_tian@126.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/2] block: fix locking for struct block_device size updates
Date:   Fri, 21 Aug 2020 10:56:00 +0200
Message-Id: <20200821085600.2395666-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821085600.2395666-1-hch@lst.de>
References: <20200821085600.2395666-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Two different callers use two different mutexes for updating the
block device size, which obviously doesn't help to actually protect
against concurrent updates from the different callers.  In addition
one of the locks, bd_mutex is rather prone to deadlocks with other
parts of the block stack that use it for high level synchronization.

Switch to using a new spinlock protecting just the size updates, as
that is all we need, and make sure everyone does the update through
the proper helper.

This fixeѕ a bug reported with the nvme revalidating disks during a
hot removal operation.

Reported-by: Xianting Tian <xianting_tian@126.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c         |  4 ++--
 drivers/block/aoe/aoecmd.c      |  4 +---
 drivers/md/dm.c                 | 15 ++-------------
 drivers/s390/block/dasd_ioctl.c |  9 ++-------
 fs/block_dev.c                  | 18 +++++++++---------
 include/linux/blk_types.h       |  1 +
 6 files changed, 17 insertions(+), 34 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index e62a98a8eeb750..328a2cb7875ba1 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -585,8 +585,8 @@ int bdev_resize_partition(struct block_device *bdev, int partno,
 	if (partition_overlaps(bdev->bd_disk, start, length, partno))
 		goto out_unlock;
 
-	part_nr_sects_write(part, (sector_t)length);
-	i_size_write(bdevp->bd_inode, length << SECTOR_SHIFT);
+	part_nr_sects_write(part, length);
+	bd_set_nr_sectors(bdevp, length);
 
 	ret = 0;
 out_unlock:
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 3cf9bc5d8d9599..6ad73fe730bede 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -900,9 +900,7 @@ aoecmd_sleepwork(struct work_struct *work)
 		ssize = get_capacity(d->gd);
 		bd = bdget_disk(d->gd, 0);
 		if (bd) {
-			inode_lock(bd->bd_inode);
-			i_size_write(bd->bd_inode, (loff_t)ssize<<9);
-			inode_unlock(bd->bd_inode);
+			bd_set_nr_sectors(bd, ssize);
 			bdput(bd);
 		}
 		spin_lock_irq(&d->lock);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 32fa6499739fb9..6b21e5104e3e08 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2097,18 +2097,6 @@ static void event_callback(void *context)
 	dm_issue_global_event();
 }
 
-/*
- * Protected by md->suspend_lock obtained by dm_swap_table().
- */
-static void __set_size(struct mapped_device *md, sector_t size)
-{
-	lockdep_assert_held(&md->suspend_lock);
-
-	set_capacity(md->disk, size);
-
-	i_size_write(md->bdev->bd_inode, (loff_t)size << SECTOR_SHIFT);
-}
-
 /*
  * Returns old map, which caller must destroy.
  */
@@ -2131,7 +2119,8 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 	if (size != dm_get_size(md))
 		memset(&md->geometry, 0, sizeof(md->geometry));
 
-	__set_size(md, size);
+	set_capacity(md->disk, size);
+	bd_set_nr_sectors(md->bdev, size);
 
 	dm_table_event_callback(t, event_callback, md);
 
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 777734d1b4e58c..faaf5596e31c12 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -55,10 +55,7 @@ dasd_ioctl_enable(struct block_device *bdev)
 
 	dasd_enable_device(base);
 	/* Formatting the dasd device can change the capacity. */
-	mutex_lock(&bdev->bd_mutex);
-	i_size_write(bdev->bd_inode,
-		     (loff_t)get_capacity(base->block->gdp) << 9);
-	mutex_unlock(&bdev->bd_mutex);
+	bd_set_nr_sectors(bdev, get_capacity(base->block->gdp));
 	dasd_put_device(base);
 	return 0;
 }
@@ -91,9 +88,7 @@ dasd_ioctl_disable(struct block_device *bdev)
 	 * Set i_size to zero, since read, write, etc. check against this
 	 * value.
 	 */
-	mutex_lock(&bdev->bd_mutex);
-	i_size_write(bdev->bd_inode, 0);
-	mutex_unlock(&bdev->bd_mutex);
+	bd_set_nr_sectors(bdev, 0);
 	dasd_put_device(base);
 	return 0;
 }
diff --git a/fs/block_dev.c b/fs/block_dev.c
index f52597172c8b79..aa559f1f08800e 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -876,6 +876,7 @@ struct block_device *bdget(dev_t dev)
 	bdev = &BDEV_I(inode)->bdev;
 
 	if (inode->i_state & I_NEW) {
+		spin_lock_init(&bdev->bd_size_lock);
 		bdev->bd_contains = NULL;
 		bdev->bd_super = NULL;
 		bdev->bd_inode = inode;
@@ -1290,6 +1291,7 @@ static void check_disk_size_change(struct gendisk *disk,
 {
 	loff_t disk_size, bdev_size;
 
+	spin_lock(&bdev->bd_size_lock);
 	disk_size = (loff_t)get_capacity(disk) << 9;
 	bdev_size = i_size_read(bdev->bd_inode);
 	if (disk_size != bdev_size) {
@@ -1304,6 +1306,7 @@ static void check_disk_size_change(struct gendisk *disk,
 				disk->disk_name);
 	}
 	bdev->bd_invalidated = 0;
+	spin_unlock(&bdev->bd_size_lock);
 }
 
 /**
@@ -1328,13 +1331,10 @@ int revalidate_disk(struct gendisk *disk)
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		struct block_device *bdev = bdget_disk(disk, 0);
 
-		if (!bdev)
-			return ret;
-
-		mutex_lock(&bdev->bd_mutex);
-		check_disk_size_change(disk, bdev, ret == 0);
-		mutex_unlock(&bdev->bd_mutex);
-		bdput(bdev);
+		if (bdev) {
+			check_disk_size_change(disk, bdev, ret == 0);
+			bdput(bdev);
+		}
 	}
 	return ret;
 }
@@ -1373,9 +1373,9 @@ EXPORT_SYMBOL(check_disk_change);
 
 void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 {
-	inode_lock(bdev->bd_inode);
+	spin_lock(&bdev->bd_size_lock);
 	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
-	inode_unlock(bdev->bd_inode);
+	spin_unlock(&bdev->bd_size_lock);
 }
 EXPORT_SYMBOL(bd_set_nr_sectors);
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 4ecf4fed171f0d..5accc2549d2259 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -38,6 +38,7 @@ struct block_device {
 	/* number of times partitions within this device have been opened. */
 	unsigned		bd_part_count;
 	int			bd_invalidated;
+	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
 	struct gendisk *	bd_disk;
 	struct backing_dev_info *bd_bdi;
 
-- 
2.28.0

