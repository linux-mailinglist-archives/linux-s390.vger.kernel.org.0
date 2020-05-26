Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF481A74C0
	for <lists+linux-s390@lfdr.de>; Tue, 14 Apr 2020 09:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390796AbgDNH3g (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 14 Apr 2020 03:29:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390790AbgDNH3d (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Apr 2020 03:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3SJF34iqtAXgk3ZKegifeq16laJgV1rqmhTf/l/iWJs=; b=EXepnl9hmtII6CiU0h3i4FOpwS
        ir51vkFzy9gmhpE2sbmKXvQFzXmysggCSsJLz7WBrZReuGpoZzvjI7JfLUq2KrH4sKpXwbg1M/uel
        IRNpNGH0yDM4dirQ6rpIxjodJivOvKGSBwRMykSJm7JfANmd2dieZ0Sv09a1/lu9ALMCC/KzKk34e
        ZV+JSu64P8osOthU4o0FxizR+6Rwg39EI9RzRBfJUAX9il9cHE207EdyloZDM1GwViUqT1tVD4upi
        fZ1Q2hq6ud7YZbXV/rCUriT82ND2DBeWG460xFE6uMTHEkfVYa3zYMke7rW22H0yDim/wA0waE1wK
        Sdt3/Odg==;
Received: from [2001:4bb8:180:384b:4c21:af7:dd95:e552] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOG0c-0005ar-QL; Tue, 14 Apr 2020 07:29:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 07/10] block: don't call invalidate_partition from blk_drop_partitions
Date:   Tue, 14 Apr 2020 09:28:59 +0200
Message-Id: <20200414072902.324936-8-hch@lst.de>
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

Given that the device must not be busy, most of the calls from
invalidate_partition that are related to file system metadata are
guranteed to not happen.  Just open code the calls to sync_blockdev
and invalidate_bdev instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 8c5295ca8ea6..a94d296d7aed 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -607,15 +607,14 @@ int blk_drop_partitions(struct block_device *bdev)
 {
 	struct disk_part_iter piter;
 	struct hd_struct *part;
-	int res;
 
 	if (!disk_part_scan_enabled(bdev->bd_disk))
 		return 0;
 	if (bdev->bd_part_count || bdev->bd_openers > 1)
 		return -EBUSY;
-	res = invalidate_partition(bdev->bd_disk, 0);
-	if (res)
-		return res;
+
+	sync_blockdev(bdev);
+	invalidate_bdev(bdev);
 
 	disk_part_iter_init(&piter, bdev->bd_disk, DISK_PITER_INCL_EMPTY);
 	while ((part = disk_part_iter_next(&piter)))
-- 
2.25.1

