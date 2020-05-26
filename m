Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7471A74C4
	for <lists+linux-s390@lfdr.de>; Tue, 14 Apr 2020 09:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390798AbgDNH3g (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 14 Apr 2020 03:29:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390793AbgDNH3d (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Apr 2020 03:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1tQNHczqdOkMvIrFiUNZMReRuQ2EqdtBBOuteS/GlOs=; b=ZC03W5SkjKP9ilgG5Ujd982+0H
        Wm4ZUF9YYN0BHDHqxn8eR2A92ttrySpafEaS66qTlPSpOG16A1v7Ysve7xQS97TlrFcJ7Qd921h5T
        g0wpZEcTvxyCYtfRJa8SjMA3QgO/xT6ZDUHtavgyokqJx2jTxCz0mTR5ohOJYyn/TGbn8edurLC5F
        KnJuo26VxC4r4PvKGntn7yZ7QKaVusFWk7akuCB1GIDNu/GjU6ONk3Crtmyw7P2u+dp+hT91zd0Lp
        bGJ9Xealbm+PM7w6BgNvAAgS1KUPBhw2eKOKWN4I3jjLgQdEaqIe444B7G3NVrb2xZFfAcWvBSqxL
        Zu6TNDNQ==;
Received: from [2001:4bb8:180:384b:4c21:af7:dd95:e552] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOG0i-0005bb-F6; Tue, 14 Apr 2020 07:29:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 09/10] block: mark invalidate_partition static
Date:   Tue, 14 Apr 2020 09:29:01 +0200
Message-Id: <20200414072902.324936-10-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414072902.324936-1-hch@lst.de>
References: <20200414072902.324936-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

invalidate_partition is only used in genhd.c, so mark it static.  Also
drop the return value given that is is always ignored.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/genhd.c      | 27 +++++++++++++--------------
 include/linux/fs.h |  1 -
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 1cc50ad5b191..980a4609d4a5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -878,6 +878,19 @@ void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk)
 }
 EXPORT_SYMBOL(device_add_disk_no_queue_reg);
 
+static void invalidate_partition(struct gendisk *disk, int partno)
+{
+	struct block_device *bdev;
+
+	bdev = bdget_disk(disk, partno);
+	if (!bdev)
+		return;
+
+	fsync_bdev(bdev);
+	__invalidate_device(bdev, true);
+	bdput(bdev);
+}
+
 void del_gendisk(struct gendisk *disk)
 {
 	struct disk_part_iter piter;
@@ -1806,20 +1819,6 @@ int bdev_read_only(struct block_device *bdev)
 
 EXPORT_SYMBOL(bdev_read_only);
 
-int invalidate_partition(struct gendisk *disk, int partno)
-{
-	int res = 0;
-	struct block_device *bdev = bdget_disk(disk, partno);
-	if (bdev) {
-		fsync_bdev(bdev);
-		res = __invalidate_device(bdev, true);
-		bdput(bdev);
-	}
-	return res;
-}
-
-EXPORT_SYMBOL(invalidate_partition);
-
 /*
  * Disk events - monitor disk events like media change and eject request.
  */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4f6f59b4f22a..2b4e9f86b151 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2723,7 +2723,6 @@ extern bool is_bad_inode(struct inode *);
 extern int revalidate_disk(struct gendisk *);
 extern int check_disk_change(struct block_device *);
 extern int __invalidate_device(struct block_device *, bool);
-extern int invalidate_partition(struct gendisk *, int);
 #endif
 unsigned long invalidate_mapping_pages(struct address_space *mapping,
 					pgoff_t start, pgoff_t end);
-- 
2.25.1

