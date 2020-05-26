Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 889DF1A2997
	for <lists+linux-s390@lfdr.de>; Wed,  8 Apr 2020 21:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgDHTpH (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 8 Apr 2020 15:45:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730155AbgDHTpH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 15:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FEfhWvLPZ+iih2DaP3qYwNHreINUocGi+rjtpjpeO7c=; b=OXY2d9Y08lLZf/nY5hBJ1v0Tj8
        qzf5arRByNejSLT74+LWTZ7yrLfpFJCdQ/BVi67porZqbPrhuDX+JIJ4HMtopLbSPDKP1Ks0OwW2g
        3IR/jWagzml6yDf4jBC9h0Ccu55/8HIgEIS/KmbhYVPfBiBOoWOepWZFNCy2uiGZW9d38kd6k2b35
        tPiPiKdTIb+FnqxL60+2DcYK9R8nJIw4++KK4mc4kzoJRguf7tL17/TkygKptxxD8z+0khcExMxLs
        Sp3yHgR81vTXjI5/i9kZld90FvhAK89jejAhc9L/6Raa4SIgg/TrROvwreYPuBDXTsQdXwFhnZW8Z
        wSro+NFw==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMGdG-00055y-4Q; Wed, 08 Apr 2020 19:45:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 10/10] block: fold bdev_unhash_inode into invalidate_partition
Date:   Wed,  8 Apr 2020 21:44:39 +0200
Message-Id: <20200408194439.1580699-11-hch@lst.de>
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

invalidate_partition and bdev_unhash_inode are always paired, and
invalidate_partition already does an icache lookup for the block device
inode.  Piggy back on that to remove the inode from the hash.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c      |  8 ++++++--
 fs/block_dev.c     | 15 ---------------
 include/linux/fs.h |  1 -
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 980a4609d4a5..c05d509877fa 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -888,6 +888,12 @@ static void invalidate_partition(struct gendisk *disk, int partno)
 
 	fsync_bdev(bdev);
 	__invalidate_device(bdev, true);
+
+	/*
+	 * Unhash the bdev inode for this device so that it gets evicted as soon
+	 * as last inode reference is dropped.
+	 */
+	remove_inode_hash(bdev->bd_inode);
 	bdput(bdev);
 }
 
@@ -909,13 +915,11 @@ void del_gendisk(struct gendisk *disk)
 			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
 	while ((part = disk_part_iter_next(&piter))) {
 		invalidate_partition(disk, part->partno);
-		bdev_unhash_inode(part_devt(part));
 		delete_partition(disk, part);
 	}
 	disk_part_iter_exit(&piter);
 
 	invalidate_partition(disk, 0);
-	bdev_unhash_inode(disk_devt(disk));
 	set_capacity(disk, 0);
 	disk->flags &= ~GENHD_FL_UP;
 	up_write(&disk->lookup_sem);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9c8de54fa0c9..998820174d3e 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -883,21 +883,6 @@ static int bdev_set(struct inode *inode, void *data)
 
 static LIST_HEAD(all_bdevs);
 
-/*
- * If there is a bdev inode for this device, unhash it so that it gets evicted
- * as soon as last inode reference is dropped.
- */
-void bdev_unhash_inode(dev_t dev)
-{
-	struct inode *inode;
-
-	inode = ilookup5(blockdev_superblock, hash(dev), bdev_test, &dev);
-	if (inode) {
-		remove_inode_hash(inode);
-		iput(inode);
-	}
-}
-
 struct block_device *bdget(dev_t dev)
 {
 	struct block_device *bdev;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2b4e9f86b151..1a95e5158811 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2581,7 +2581,6 @@ extern struct kmem_cache *names_cachep;
 #ifdef CONFIG_BLOCK
 extern int register_blkdev(unsigned int, const char *);
 extern void unregister_blkdev(unsigned int, const char *);
-extern void bdev_unhash_inode(dev_t dev);
 extern struct block_device *bdget(dev_t);
 extern struct block_device *bdgrab(struct block_device *bdev);
 extern void bd_set_size(struct block_device *, loff_t size);
-- 
2.25.1

