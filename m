Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C721D99D9
	for <lists+linux-s390@lfdr.de>; Tue, 19 May 2020 16:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgESOdZ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 19 May 2020 10:33:25 -0400
Received: from verein.lst.de ([213.95.11.211]:44330 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgESOdZ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 May 2020 10:33:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1ECA568C4E; Tue, 19 May 2020 16:33:22 +0200 (CEST)
Date:   Tue, 19 May 2020 16:33:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     hch@lst.de, axboe@kernel.dk, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com
Subject: [PATCH 3/2] block: remove ioctl_by_bdev
Message-ID: <20200519143321.GB16127@lst.de>
References: <20200519142259.102279-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519142259.102279-1-sth@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

No callers left.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c     | 12 ------------
 include/linux/fs.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index ebd1507789d29..2eb92456a22e7 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2166,18 +2166,6 @@ const struct file_operations def_blk_fops = {
 	.fallocate	= blkdev_fallocate,
 };
 
-int ioctl_by_bdev(struct block_device *bdev, unsigned cmd, unsigned long arg)
-{
-	int res;
-	mm_segment_t old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	res = blkdev_ioctl(bdev, 0, cmd, arg);
-	set_fs(old_fs);
-	return res;
-}
-
-EXPORT_SYMBOL(ioctl_by_bdev);
-
 /**
  * lookup_bdev  - lookup a struct block_device by name
  * @pathname:	special file representing the block device
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1a95e51588113..861ca61d728bc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2636,7 +2636,6 @@ extern int sync_filesystem(struct super_block *);
 extern const struct file_operations def_blk_fops;
 extern const struct file_operations def_chr_fops;
 #ifdef CONFIG_BLOCK
-extern int ioctl_by_bdev(struct block_device *, unsigned, unsigned long);
 extern int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
 extern long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
 extern int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder);
-- 
2.26.2

