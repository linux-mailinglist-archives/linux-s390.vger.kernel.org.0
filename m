Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1418E1A424B
	for <lists+linux-s390@lfdr.de>; Fri, 10 Apr 2020 07:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgDJFps (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 10 Apr 2020 01:45:48 -0400
Received: from verein.lst.de ([213.95.11.211]:49645 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgDJFpr (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Apr 2020 01:45:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D2EFD68C4E; Fri, 10 Apr 2020 07:45:44 +0200 (CEST)
Date:   Fri, 10 Apr 2020 07:45:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: s390 boot woe due to "block: fix busy device checking in
 blk_drop_partitions"
Message-ID: <20200410054544.GA17923@lst.de>
References: <AD16A450-794F-4EEA-A7BF-42452F18294A@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AD16A450-794F-4EEA-A7BF-42452F18294A@lca.pw>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Please try this patch:

---
From f42fb98cc627f9b960fd5b9a3a229da5c5dcf54a Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 10 Apr 2020 07:14:13 +0200
Subject: block: fix busy device checking in blk_drop_partitions again

The previous fix had an off by one in the bd_openers checking, counting
the callers blkdev_get.

Fixes: d3ef5536274f ("block: fix busy device checking in blk_drop_partitions")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 1a0a829d8416..bc1ded1331b1 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -496,7 +496,7 @@ int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev)
 
 	if (!disk_part_scan_enabled(disk))
 		return 0;
-	if (bdev->bd_part_count || bdev->bd_openers)
+	if (bdev->bd_part_count || bdev->bd_openers > 1)
 		return -EBUSY;
 	res = invalidate_partition(disk, 0);
 	if (res)
-- 
2.25.1

