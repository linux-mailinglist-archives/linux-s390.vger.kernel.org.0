Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31FB81A298E
	for <lists+linux-s390@lfdr.de>; Wed,  8 Apr 2020 21:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgDHTo5 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 8 Apr 2020 15:44:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgDHTo5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 15:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=i4bEGtCLQccNYXil7zhdkF5o1S3lZFIBpHM3YttaFak=; b=QqagxzLHO7rnRKv3nqEul7YeDp
        IPJkAq6+rNJUiTGQcidif0ZgpL+SsXBzW+pmmE2iqzEkLMuGUo7519ZcMExsV19h22JqdJ3yf6DqI
        a7hdhkAmr2psUKh5zw0HM5EQY+8IGqC71WACi1StZoZkfvYh09/8vflFVoF0aIr0V3rtEaI4zmR8n
        jlkrQEvSmb2qQoUyY0gDxDFdOiRUa6HtsiFiVvyRVM3iAmEUW7lL+BN+T/Zqm4PsaYTvhSLjkMXkT
        RcJRy9G3zBtHHrD5NPcWGqspZwVkFUB5sBiuKMkd/Cy72jry4kb852lr9uj5SzT4j48rrVLv2sbVx
        bgjRj9EA==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMGd6-0004Kr-8L; Wed, 08 Apr 2020 19:44:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 06/10] dasd: use blk_drop_partitions instead of badly reimplementing it
Date:   Wed,  8 Apr 2020 21:44:35 +0200
Message-Id: <20200408194439.1580699-7-hch@lst.de>
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

Use the blk_drop_partitions function instead of messing around with
ioctls that get kernel pointers.  For this blk_drop_partitions needs
to be exported, which it normally shouldn't - make an exception for
s390 only.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c         |  4 ++++
 drivers/s390/block/dasd_genhd.c | 20 ++++----------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index e0ff8a49279f..8a41c25022ab 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -624,6 +624,10 @@ int blk_drop_partitions(struct block_device *bdev)
 
 	return 0;
 }
+#ifdef CONFIG_S390
+/* for historic reasons in the DASD driver */
+EXPORT_SYMBOL_GPL(blk_drop_partitions);
+#endif
 
 static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
 		struct parsed_partitions *state, int p)
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 7d079154f849..af5b0ecb8f89 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -143,9 +143,6 @@ int dasd_scan_partitions(struct dasd_block *block)
  */
 void dasd_destroy_partitions(struct dasd_block *block)
 {
-	/* The two structs have 168/176 byte on 31/64 bit. */
-	struct blkpg_partition bpart;
-	struct blkpg_ioctl_arg barg;
 	struct block_device *bdev;
 
 	/*
@@ -155,19 +152,10 @@ void dasd_destroy_partitions(struct dasd_block *block)
 	bdev = block->bdev;
 	block->bdev = NULL;
 
-	/*
-	 * See fs/partition/check.c:delete_partition
-	 * Can't call delete_partitions directly. Use ioctl.
-	 * The ioctl also does locking and invalidation.
-	 */
-	memset(&bpart, 0, sizeof(struct blkpg_partition));
-	memset(&barg, 0, sizeof(struct blkpg_ioctl_arg));
-	barg.data = (void __force __user *) &bpart;
-	barg.op = BLKPG_DEL_PARTITION;
-	for (bpart.pno = block->gdp->minors - 1; bpart.pno > 0; bpart.pno--)
-		ioctl_by_bdev(bdev, BLKPG, (unsigned long) &barg);
-
-	invalidate_partition(block->gdp, 0);
+	mutex_lock(&bdev->bd_mutex);
+	blk_drop_partitions(bdev);
+	mutex_unlock(&bdev->bd_mutex);
+
 	/* Matching blkdev_put to the blkdev_get in dasd_scan_partitions. */
 	blkdev_put(bdev, FMODE_READ);
 	set_capacity(block->gdp, 0);
-- 
2.25.1

