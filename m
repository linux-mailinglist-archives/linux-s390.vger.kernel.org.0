Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA2061A2980
	for <lists+linux-s390@lfdr.de>; Wed,  8 Apr 2020 21:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgDHTop (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 8 Apr 2020 15:44:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40568 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgDHTop (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 15:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zaiVVn26POc3v9EheIrbbUfgKHpxYPyAv21MH+M1N7Y=; b=uA3NBa5jwXGt8OOvlAv0cZL6Tt
        MSRvGcvla4/LNjOGonN8XWF1hdIF9692+uAQZZZFCqzKCCxwot5tkoDuBYX4oU9go2i4q/qOT7ocv
        fVwSdakhjCI4NLpCoVOcwj0pmOcYIQJUyCDeK+yO4S9piGtzmcxOZqljjBL0SRMsK1WR2KkHLs8uw
        OIHTSuQASC+/euKmvUJ/ugJadN56wWEx13CrEnt243cJVubL5Eg3KX4gfOZwIOVtrPjVPQgRifncZ
        70Nklwc+y3YBbpJc7CduxngpNPHll8Bgk+XxuQeZxnnUKGV15+0gDoArJvTI31qw1ASbwsqQG6uDG
        ogyReXSQ==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMGct-0004GS-VM; Wed, 08 Apr 2020 19:44:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 01/10] block: refactor blkpg_ioctl
Date:   Wed,  8 Apr 2020 21:44:30 +0200
Message-Id: <20200408194439.1580699-2-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408194439.1580699-1-hch@lst.de>
References: <20200408194439.1580699-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Split each sub-command out into a separate helper, and move those helpers
to block/partitions/core.c instead of having a lot of partition
manipulation logic open coded in block/ioctl.c.

Signed-off-by: Christoph Hellwig <hch@lst.de
---
 block/blk.h             |   8 ++-
 block/ioctl.c           | 150 +++++++---------------------------------
 block/partitions/core.c | 115 +++++++++++++++++++++++++++++-
 3 files changed, 145 insertions(+), 128 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 0a94ec68af32..305e0ac22bf7 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -389,11 +389,13 @@ char *disk_name(struct gendisk *hd, int partno, char *buf);
 #define ADDPART_FLAG_NONE	0
 #define ADDPART_FLAG_RAID	1
 #define ADDPART_FLAG_WHOLEDISK	2
-struct hd_struct *__must_check add_partition(struct gendisk *disk, int partno,
-		sector_t start, sector_t len, int flags,
-		struct partition_meta_info *info);
 void __delete_partition(struct percpu_ref *ref);
 void delete_partition(struct gendisk *disk, int partno);
+int bdev_add_partition(struct block_device *bdev, int partno,
+		sector_t start, sector_t length);
+int bdev_del_partition(struct block_device *bdev, int partno);
+int bdev_resize_partition(struct block_device *bdev, int partno,
+		sector_t start, sector_t length);
 int disk_expand_part_tbl(struct gendisk *disk, int target);
 
 static inline int hd_ref_init(struct hd_struct *part)
diff --git a/block/ioctl.c b/block/ioctl.c
index 6e827de1a4c4..3de5b29c839e 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -16,142 +16,44 @@
 static int blkpg_do_ioctl(struct block_device *bdev,
 			  struct blkpg_partition __user *upart, int op)
 {
-	struct block_device *bdevp;
-	struct gendisk *disk;
-	struct hd_struct *part, *lpart;
 	struct blkpg_partition p;
-	struct disk_part_iter piter;
 	long long start, length;
-	int partno;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 	if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))
 		return -EFAULT;
-	disk = bdev->bd_disk;
 	if (bdev != bdev->bd_contains)
 		return -EINVAL;
-	partno = p.pno;
-	if (partno <= 0)
+
+	if (p.pno <= 0)
 		return -EINVAL;
+
+	if (op == BLKPG_DEL_PARTITION)
+		return bdev_del_partition(bdev, p.pno);
+
+	start = p.start >> SECTOR_SHIFT;
+	length = p.length >> SECTOR_SHIFT;
+
+	/* check for fit in a hd_struct */
+	if (sizeof(sector_t) < sizeof(long long)) {
+		long pstart = start, plength = length;
+
+		if (pstart != start || plength != length || pstart < 0 ||
+		    plength < 0 || p.pno > 65535)
+			return -EINVAL;
+	}
+
 	switch (op) {
-		case BLKPG_ADD_PARTITION:
-			start = p.start >> 9;
-			length = p.length >> 9;
-			/* check for fit in a hd_struct */
-			if (sizeof(sector_t) == sizeof(long) &&
-			    sizeof(long long) > sizeof(long)) {
-				long pstart = start, plength = length;
-				if (pstart != start || plength != length
-				    || pstart < 0 || plength < 0 || partno > 65535)
-					return -EINVAL;
-			}
-			/* check if partition is aligned to blocksize */
-			if (p.start & (bdev_logical_block_size(bdev) - 1))
-				return -EINVAL;
-
-			mutex_lock(&bdev->bd_mutex);
-
-			/* overlap? */
-			disk_part_iter_init(&piter, disk,
-					    DISK_PITER_INCL_EMPTY);
-			while ((part = disk_part_iter_next(&piter))) {
-				if (!(start + length <= part->start_sect ||
-				      start >= part->start_sect + part->nr_sects)) {
-					disk_part_iter_exit(&piter);
-					mutex_unlock(&bdev->bd_mutex);
-					return -EBUSY;
-				}
-			}
-			disk_part_iter_exit(&piter);
-
-			/* all seems OK */
-			part = add_partition(disk, partno, start, length,
-					     ADDPART_FLAG_NONE, NULL);
-			mutex_unlock(&bdev->bd_mutex);
-			return PTR_ERR_OR_ZERO(part);
-		case BLKPG_DEL_PARTITION:
-			part = disk_get_part(disk, partno);
-			if (!part)
-				return -ENXIO;
-
-			bdevp = bdget(part_devt(part));
-			disk_put_part(part);
-			if (!bdevp)
-				return -ENOMEM;
-
-			mutex_lock(&bdevp->bd_mutex);
-			if (bdevp->bd_openers) {
-				mutex_unlock(&bdevp->bd_mutex);
-				bdput(bdevp);
-				return -EBUSY;
-			}
-			/* all seems OK */
-			fsync_bdev(bdevp);
-			invalidate_bdev(bdevp);
-
-			mutex_lock_nested(&bdev->bd_mutex, 1);
-			delete_partition(disk, partno);
-			mutex_unlock(&bdev->bd_mutex);
-			mutex_unlock(&bdevp->bd_mutex);
-			bdput(bdevp);
-
-			return 0;
-		case BLKPG_RESIZE_PARTITION:
-			start = p.start >> 9;
-			/* new length of partition in bytes */
-			length = p.length >> 9;
-			/* check for fit in a hd_struct */
-			if (sizeof(sector_t) == sizeof(long) &&
-			    sizeof(long long) > sizeof(long)) {
-				long pstart = start, plength = length;
-				if (pstart != start || plength != length
-				    || pstart < 0 || plength < 0)
-					return -EINVAL;
-			}
-			part = disk_get_part(disk, partno);
-			if (!part)
-				return -ENXIO;
-			bdevp = bdget(part_devt(part));
-			if (!bdevp) {
-				disk_put_part(part);
-				return -ENOMEM;
-			}
-			mutex_lock(&bdevp->bd_mutex);
-			mutex_lock_nested(&bdev->bd_mutex, 1);
-			if (start != part->start_sect) {
-				mutex_unlock(&bdevp->bd_mutex);
-				mutex_unlock(&bdev->bd_mutex);
-				bdput(bdevp);
-				disk_put_part(part);
-				return -EINVAL;
-			}
-			/* overlap? */
-			disk_part_iter_init(&piter, disk,
-					    DISK_PITER_INCL_EMPTY);
-			while ((lpart = disk_part_iter_next(&piter))) {
-				if (lpart->partno != partno &&
-				   !(start + length <= lpart->start_sect ||
-				   start >= lpart->start_sect + lpart->nr_sects)
-				   ) {
-					disk_part_iter_exit(&piter);
-					mutex_unlock(&bdevp->bd_mutex);
-					mutex_unlock(&bdev->bd_mutex);
-					bdput(bdevp);
-					disk_put_part(part);
-					return -EBUSY;
-				}
-			}
-			disk_part_iter_exit(&piter);
-			part_nr_sects_write(part, (sector_t)length);
-			i_size_write(bdevp->bd_inode, p.length);
-			mutex_unlock(&bdevp->bd_mutex);
-			mutex_unlock(&bdev->bd_mutex);
-			bdput(bdevp);
-			disk_put_part(part);
-			return 0;
-		default:
+	case BLKPG_ADD_PARTITION:
+		/* check if partition is aligned to blocksize */
+		if (p.start & (bdev_logical_block_size(bdev) - 1))
 			return -EINVAL;
+		return bdev_add_partition(bdev, p.pno, start, length);
+	case BLKPG_DEL_PARTITION:
+		return bdev_resize_partition(bdev, p.pno, start, length);
+	default:
+		return -EINVAL;
 	}
 }
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 1a0a829d8416..7577bdba3b2b 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -335,7 +335,7 @@ static DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
  * Must be called either with bd_mutex held, before a disk can be opened or
  * after all disk users are gone.
  */
-struct hd_struct *add_partition(struct gendisk *disk, int partno,
+static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 				sector_t start, sector_t len, int flags,
 				struct partition_meta_info *info)
 {
@@ -472,6 +472,119 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	return ERR_PTR(err);
 }
 
+static bool partition_overlaps(struct gendisk *disk, sector_t start,
+		sector_t length, int skip_partno)
+{
+	struct disk_part_iter piter;
+	struct hd_struct *part;
+	bool overlap = false;
+
+	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
+	while ((part = disk_part_iter_next(&piter))) {
+		if (part->partno == skip_partno ||
+		    start >= part->start_sect + part->nr_sects ||
+		    start + length <= part->start_sect)
+			continue;
+		overlap = true;
+		break;
+	}
+
+	disk_part_iter_exit(&piter);
+	return overlap;
+}
+
+int bdev_add_partition(struct block_device *bdev, int partno,
+		sector_t start, sector_t length)
+{
+	struct hd_struct *part;
+
+	mutex_lock(&bdev->bd_mutex);
+	if (partition_overlaps(bdev->bd_disk, start, length, -1)) {
+		mutex_unlock(&bdev->bd_mutex);
+		return -EBUSY;
+	}
+
+	part = add_partition(bdev->bd_disk, partno, start, length,
+			ADDPART_FLAG_NONE, NULL);
+	mutex_unlock(&bdev->bd_mutex);
+	return PTR_ERR_OR_ZERO(part);
+}
+
+int bdev_del_partition(struct block_device *bdev, int partno)
+{
+	struct block_device *bdevp;
+	struct hd_struct *part;
+	int ret = 0;
+
+	part = disk_get_part(bdev->bd_disk, partno);
+	if (!part)
+		return -ENXIO;
+
+	bdevp = bdget(part_devt(part));
+	disk_put_part(part);
+	if (!bdevp)
+		return -ENOMEM;
+
+	mutex_lock(&bdevp->bd_mutex);
+
+	ret = -EBUSY;
+	if (bdevp->bd_openers)
+		goto out_unlock;
+
+	fsync_bdev(bdevp);
+	invalidate_bdev(bdevp);
+
+	mutex_lock_nested(&bdev->bd_mutex, 1);
+	delete_partition(bdev->bd_disk, partno);
+	mutex_unlock(&bdev->bd_mutex);
+
+	ret = 0;
+out_unlock:
+	mutex_unlock(&bdevp->bd_mutex);
+	bdput(bdevp);
+	return ret;
+}
+
+int bdev_resize_partition(struct block_device *bdev, int partno,
+		sector_t start, sector_t length)
+{
+	struct block_device *bdevp;
+	struct hd_struct *part;
+	int ret = 0;
+
+	part = disk_get_part(bdev->bd_disk, partno);
+	if (!part)
+		return -ENXIO;
+
+	ret = -ENOMEM;
+	bdevp = bdget(part_devt(part));
+	if (!bdevp)
+		goto out_put_part;
+
+	mutex_lock(&bdevp->bd_mutex);
+	mutex_lock_nested(&bdev->bd_mutex, 1);
+
+	ret = -EINVAL;
+	if (start != part->start_sect)
+		goto out_unlock;
+
+	ret = -EBUSY;
+	if (partition_overlaps(bdev->bd_disk, start, length, partno))
+		goto out_unlock;
+
+	part_nr_sects_write(part, (sector_t)length);
+	i_size_write(bdevp->bd_inode, length << SECTOR_SHIFT);
+
+	ret = 0;
+out_unlock:
+	mutex_unlock(&bdevp->bd_mutex);
+	mutex_unlock(&bdev->bd_mutex);
+	bdput(bdevp);
+out_put_part:
+	disk_put_part(part);
+	return ret;
+}
+
 static bool disk_unlock_native_capacity(struct gendisk *disk)
 {
 	const struct block_device_operations *bdops = disk->fops;
-- 
2.25.1

