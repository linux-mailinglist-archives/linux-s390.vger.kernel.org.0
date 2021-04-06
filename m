Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C66354CC2
	for <lists+linux-s390@lfdr.de>; Tue,  6 Apr 2021 08:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243970AbhDFGXe (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 6 Apr 2021 02:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243963AbhDFGXe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Apr 2021 02:23:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941EEC06174A;
        Mon,  5 Apr 2021 23:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JdbT4J8l0ptdxw8gzZF9vT24pdg38dTP4XXMLQS8BZY=; b=jqvzuBUqZhvdwTowquL/znRg1V
        shK6tM9HAtq/O8iPDUOce6OfdoqRLz4ZlOfMaWbDDAYJqyNbo9slNl6Hz9d8OD7ivP4VwNYK/8dsx
        aduCW0roBV6lyxKk69oJzIh5gLS+5mG1RXHZjsogDOspiWwr+LVLFFRS2xmlNLVKCThRFJHMY3v8F
        kGoNrYyguUeA0wqrqeF+Y2AD40+JXG+oE0DMehRZsJ3TokcHlcQ17A3UTEpDl7GFziKgjW4Nr/JxE
        ML0laAMxiTt2jKk4qZE3ajyFnlOli04JOLvnbSBOmOwQGAUOlR3dx3UrukKzvg62tXS7h8M0JnxQU
        LvRK8i3Q==;
Received: from [2001:4bb8:188:4907:c664:b479:e725:f367] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTf7V-007o9O-Ca; Tue, 06 Apr 2021 06:23:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 08/11] block: simplify printk_all_partitions
Date:   Tue,  6 Apr 2021 08:22:59 +0200
Message-Id: <20210406062303.811835-9-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210406062303.811835-1-hch@lst.de>
References: <20210406062303.811835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Just use xa_for_each to iterate over the partitions as there is no need
to grab a reference to each partition.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index e3f3c2321773f9..409ff4710f9215 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -806,10 +806,10 @@ void __init printk_all_partitions(void)
 	class_dev_iter_init(&iter, &block_class, NULL, &disk_type);
 	while ((dev = class_dev_iter_next(&iter))) {
 		struct gendisk *disk = dev_to_disk(dev);
-		struct disk_part_iter piter;
 		struct block_device *part;
 		char name_buf[BDEVNAME_SIZE];
 		char devt_buf[BDEVT_SIZE];
+		unsigned long idx;
 
 		/*
 		 * Don't show empty devices or things that have been
@@ -820,30 +820,29 @@ void __init printk_all_partitions(void)
 			continue;
 
 		/*
-		 * Note, unlike /proc/partitions, I am showing the
-		 * numbers in hex - the same format as the root=
-		 * option takes.
+		 * Note, unlike /proc/partitions, I am showing the numbers in
+		 * hex - the same format as the root= option takes.
 		 */
-		disk_part_iter_init(&piter, disk, DISK_PITER_INCL_PART0);
-		while ((part = disk_part_iter_next(&piter))) {
-			bool is_part0 = part == disk->part0;
-
-			printk("%s%s %10llu %s %s", is_part0 ? "" : "  ",
+		rcu_read_lock();
+		xa_for_each(&disk->part_tbl, idx, part) {
+			if (!bdev_nr_sectors(part))
+				continue;
+			printk("%s%s %10llu %s %s",
+			       bdev_is_partition(part) ? "  " : "",
 			       bdevt_str(part->bd_dev, devt_buf),
 			       bdev_nr_sectors(part) >> 1,
 			       disk_name(disk, part->bd_partno, name_buf),
 			       part->bd_meta_info ?
 					part->bd_meta_info->uuid : "");
-			if (is_part0) {
-				if (dev->parent && dev->parent->driver)
-					printk(" driver: %s\n",
-					      dev->parent->driver->name);
-				else
-					printk(" (driver?)\n");
-			} else
+			if (bdev_is_partition(part))
 				printk("\n");
+			else if (dev->parent && dev->parent->driver)
+				printk(" driver: %s\n",
+					dev->parent->driver->name);
+			else
+				printk(" (driver?)\n");
 		}
-		disk_part_iter_exit(&piter);
+		rcu_read_unlock();
 	}
 	class_dev_iter_exit(&iter);
 }
-- 
2.30.1

