Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCB1BFC8ED
	for <lists+linux-s390@lfdr.de>; Thu, 14 Nov 2019 15:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfKNOeq (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 14 Nov 2019 09:34:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38508 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNOeq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 09:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NgUhy3V0u9J/p+4rbFDCdEkQyYESnWrLyt5sqV2cPbw=; b=nM/sEvr7DlyayQLyEXM01ngaWo
        6N2NQVzdrRLqPQP4W3/YjMrE0IU8rZjOLDm8NS9WCPEhvWoJ/yD/U+tyb/MAfNl0hgmsDRVTpyGiG
        HtO9JqGX2sRBn6QsvjI1RAd3Wizo/l1/yY8/VAGj0hZ5wXHR5/gFckDEg+0l26A3B9TzXKsMYib8Y
        jHs+ywp7ypAeUeHJUo7PeCqVk8QUcfizO6cOsPNvxCqdroBk9VQnM/L1YqPKnaGRC9GqheIq4s/3d
        JlMeNlOG3l09PtUkgclsg9B/dWHU4cD8BMZumJfUabXRBN/8TKEieHN32bHRLXB4W7OfwYGIUPJMk
        8t+cJ/IA==;
Received: from [2001:4bb8:180:3806:c70:4a89:bc61:6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVGCp-0004iu-BV; Thu, 14 Nov 2019 14:34:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/7] block: refactor rescan_partitions
Date:   Thu, 14 Nov 2019 15:34:32 +0100
Message-Id: <20191114143438.14681-2-hch@lst.de>
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

Split out a helper that adds one single partition, and another one
calling that dealing with the parsed_partitions state.  This makes
it much more obvious how we clean up all state and start again when
using the rescan label.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/partition-generic.c | 172 +++++++++++++++++++++-----------------
 1 file changed, 94 insertions(+), 78 deletions(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index 31bff3fb28af..0909f66aab9d 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -459,128 +459,144 @@ static int drop_partitions(struct gendisk *disk, struct block_device *bdev)
 	return 0;
 }
 
-int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
+static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
+		struct parsed_partitions *state, int p)
 {
-	struct parsed_partitions *state = NULL;
+	sector_t size = state->parts[p].size;
+	sector_t from = state->parts[p].from;
 	struct hd_struct *part;
-	int p, highest, res;
-rescan:
-	if (state && !IS_ERR(state)) {
-		free_partitions(state);
-		state = NULL;
+
+	if (!size)
+		return true;
+
+	if (from >= get_capacity(disk)) {
+		printk(KERN_WARNING
+		       "%s: p%d start %llu is beyond EOD, ",
+		       disk->disk_name, p, (unsigned long long) from);
+		if (disk_unlock_native_capacity(disk))
+			return false;
+		return true;
 	}
 
-	res = drop_partitions(disk, bdev);
-	if (res)
-		return res;
+	if (from + size > get_capacity(disk)) {
+		printk(KERN_WARNING
+		       "%s: p%d size %llu extends beyond EOD, ",
+		       disk->disk_name, p, (unsigned long long) size);
 
-	if (disk->fops->revalidate_disk)
-		disk->fops->revalidate_disk(disk);
-	check_disk_size_change(disk, bdev, true);
-	bdev->bd_invalidated = 0;
-	if (!get_capacity(disk) || !(state = check_partition(disk, bdev)))
+		if (disk_unlock_native_capacity(disk))
+			return false;
+
+		/*
+		 * We can not ignore partitions of broken tables created by for
+		 * example camera firmware, but we limit them to the end of the
+		 * disk to avoid creating invalid block devices.
+		 */
+		size = get_capacity(disk) - from;
+	}
+
+	part = add_partition(disk, p, from, size, state->parts[p].flags,
+			     &state->parts[p].info);
+	if (IS_ERR(part)) {
+		printk(KERN_ERR " %s: p%d could not be added: %ld\n",
+		       disk->disk_name, p, -PTR_ERR(part));
+		return true;
+	}
+
+#ifdef CONFIG_BLK_DEV_MD
+	if (state->parts[p].flags & ADDPART_FLAG_RAID)
+		md_autodetect_dev(part_to_dev(part)->devt);
+#endif
+	return true;
+}
+
+static int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
+{
+	struct parsed_partitions *state;
+	int ret = -EAGAIN, p, highest;
+
+	state = check_partition(disk, bdev);
+	if (!state)
 		return 0;
 	if (IS_ERR(state)) {
 		/*
-		 * I/O error reading the partition table.  If any
-		 * partition code tried to read beyond EOD, retry
-		 * after unlocking native capacity.
+		 * I/O error reading the partition table.  If we tried to read
+		 * beyond EOD, retry after unlocking the native capacity.
 		 */
 		if (PTR_ERR(state) == -ENOSPC) {
 			printk(KERN_WARNING "%s: partition table beyond EOD, ",
 			       disk->disk_name);
 			if (disk_unlock_native_capacity(disk))
-				goto rescan;
+				return -EAGAIN;
 		}
 		return -EIO;
 	}
 
-	/* Partitions are not supported on zoned block devices */
+	/*
+	 * Partitions are not supported on zoned block devices.
+	 */
 	if (bdev_is_zoned(bdev)) {
 		pr_warn("%s: ignoring partition table on zoned block device\n",
 			disk->disk_name);
-		goto out;
+		ret = 0;
+		goto out_free_state;
 	}
 
 	/*
-	 * If any partition code tried to read beyond EOD, try
-	 * unlocking native capacity even if partition table is
-	 * successfully read as we could be missing some partitions.
+	 * If we read beyond EOD, try unlocking native capacity even if the
+	 * partition table was successfully read as we could be missing some
+	 * partitions.
 	 */
 	if (state->access_beyond_eod) {
 		printk(KERN_WARNING
 		       "%s: partition table partially beyond EOD, ",
 		       disk->disk_name);
 		if (disk_unlock_native_capacity(disk))
-			goto rescan;
+			goto out_free_state;
 	}
 
 	/* tell userspace that the media / partition table may have changed */
 	kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
 
-	/* Detect the highest partition number and preallocate
-	 * disk->part_tbl.  This is an optimization and not strictly
-	 * necessary.
+	/*
+	 * Detect the highest partition number and preallocate disk->part_tbl.
+	 * This is an optimization and not strictly necessary.
 	 */
 	for (p = 1, highest = 0; p < state->limit; p++)
 		if (state->parts[p].size)
 			highest = p;
-
 	disk_expand_part_tbl(disk, highest);
 
-	/* add partitions */
-	for (p = 1; p < state->limit; p++) {
-		sector_t size, from;
+	for (p = 1; p < state->limit; p++)
+		if (!blk_add_partition(disk, bdev, state, p))
+			goto out_free_state;
 
-		size = state->parts[p].size;
-		if (!size)
-			continue;
+	ret = 0;
+out_free_state:
+	free_partitions(state);
+	return ret;
+}
 
-		from = state->parts[p].from;
-		if (from >= get_capacity(disk)) {
-			printk(KERN_WARNING
-			       "%s: p%d start %llu is beyond EOD, ",
-			       disk->disk_name, p, (unsigned long long) from);
-			if (disk_unlock_native_capacity(disk))
-				goto rescan;
-			continue;
-		}
+int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
+{
+	int ret;
 
-		if (from + size > get_capacity(disk)) {
-			printk(KERN_WARNING
-			       "%s: p%d size %llu extends beyond EOD, ",
-			       disk->disk_name, p, (unsigned long long) size);
-
-			if (disk_unlock_native_capacity(disk)) {
-				/* free state and restart */
-				goto rescan;
-			} else {
-				/*
-				 * we can not ignore partitions of broken tables
-				 * created by for example camera firmware, but
-				 * we limit them to the end of the disk to avoid
-				 * creating invalid block devices
-				 */
-				size = get_capacity(disk) - from;
-			}
-		}
+rescan:
+	ret = drop_partitions(disk, bdev);
+	if (ret)
+		return ret;
 
-		part = add_partition(disk, p, from, size,
-				     state->parts[p].flags,
-				     &state->parts[p].info);
-		if (IS_ERR(part)) {
-			printk(KERN_ERR " %s: p%d could not be added: %ld\n",
-			       disk->disk_name, p, -PTR_ERR(part));
-			continue;
-		}
-#ifdef CONFIG_BLK_DEV_MD
-		if (state->parts[p].flags & ADDPART_FLAG_RAID)
-			md_autodetect_dev(part_to_dev(part)->devt);
-#endif
-	}
-out:
-	free_partitions(state);
-	return 0;
+	if (disk->fops->revalidate_disk)
+		disk->fops->revalidate_disk(disk);
+	check_disk_size_change(disk, bdev, true);
+	bdev->bd_invalidated = 0;
+
+	if (!get_capacity(disk))
+		return 0;
+	
+	ret = blk_add_partitions(disk, bdev);
+	if (ret == -EAGAIN)
+		goto rescan;
+	return ret;
 }
 
 int invalidate_partitions(struct gendisk *disk, struct block_device *bdev)
-- 
2.20.1

