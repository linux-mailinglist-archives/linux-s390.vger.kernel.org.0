Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AC22C8C3C
	for <lists+linux-s390@lfdr.de>; Mon, 30 Nov 2020 19:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbgK3SJc (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 30 Nov 2020 13:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387991AbgK3SJa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 Nov 2020 13:09:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95034C0613D2;
        Mon, 30 Nov 2020 10:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BfgXvx0Gu3xJBpb++s2gckZ+s5A0DNIeOhsP2zgVyc8=; b=OIqUTsNyf6BrLnInqjZTC/pS0y
        p7LA6JbRNOwnU7ESwkcr1PecuyPscrYepW3x1eh3Cm4uZqyB32e/k6ttpJ4Wy481sjvZl6A9I2SDc
        0FYuUUDMbB7+CpCImbqFfyutHisvM5J0BzOMNCyAGtiyKXuQTKPkaw3W9yyU4ee4sTPTpEhOmYwJb
        WbTdchOrWGaRWLMIRJ1ty6Af4OEoYAgSBJV+6yEkBCDvxP7eXwp8IlV3NZ0od0OUyrtQnTo+O6+HH
        YRkHTDLaV2i+u7EfydAxtoksaplDII8aDx1yrcv1G85u+kK7DA6JkQUZhp+mpL8BeqreK31HguBMZ
        ll4HwDzg==;
Received: from 089144198196.atnat0007.highway.a1.net ([89.144.198.196] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjnbT-0006zh-1l; Mon, 30 Nov 2020 18:08:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 4/5] block: remove the request_queue argument to the block_bio_remap tracepoint
Date:   Mon, 30 Nov 2020 18:58:53 +0100
Message-Id: <20201130175854.982460-5-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130175854.982460-1-hch@lst.de>
References: <20201130175854.982460-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The request_queue can trivially be derived from the bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c              |  2 +-
 drivers/md/dm.c               |  3 +--
 drivers/md/md-linear.c        |  3 +--
 drivers/md/md.c               |  5 ++---
 drivers/md/raid0.c            |  4 ++--
 drivers/md/raid1.c            |  7 +++----
 drivers/md/raid10.c           |  6 ++----
 drivers/md/raid5.c            | 15 +++++++--------
 drivers/nvme/host/multipath.c |  3 +--
 include/trace/events/block.h  |  8 +++-----
 kernel/trace/blktrace.c       | 14 +++++---------
 11 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index cb24654983e1e4..96e5fcd7f071b6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -758,7 +758,7 @@ static inline int blk_partition_remap(struct bio *bio)
 		if (bio_check_eod(bio, bdev_nr_sectors(p)))
 			goto out;
 		bio->bi_iter.bi_sector += p->bd_start_sect;
-		trace_block_bio_remap(bio->bi_disk->queue, bio, p->bd_dev,
+		trace_block_bio_remap(bio, p->bd_dev,
 				      bio->bi_iter.bi_sector -
 				      p->bd_start_sect);
 	}
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 9a5bd90779c7c4..5181907dc59537 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1276,8 +1276,7 @@ static blk_qc_t __map_bio(struct dm_target_io *tio)
 		break;
 	case DM_MAPIO_REMAPPED:
 		/* the bio has been remapped so dispatch it */
-		trace_block_bio_remap(clone->bi_disk->queue, clone,
-				      bio_dev(io->orig_bio), sector);
+		trace_block_bio_remap(clone, bio_dev(io->orig_bio), sector);
 		ret = submit_bio_noacct(clone);
 		break;
 	case DM_MAPIO_KILL:
diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index 98f1b4b2bdcef8..68cac7d1927823 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -257,8 +257,7 @@ static bool linear_make_request(struct mddev *mddev, struct bio *bio)
 		bio_endio(bio);
 	} else {
 		if (mddev->gendisk)
-			trace_block_bio_remap(bio->bi_disk->queue,
-					      bio, disk_devt(mddev->gendisk),
+			trace_block_bio_remap(bio, disk_devt(mddev->gendisk),
 					      bio_sector);
 		mddev_check_writesame(mddev, bio);
 		mddev_check_write_zeroes(mddev, bio);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 0065736f05b428..c555be0a8dce78 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8591,9 +8591,8 @@ void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 	bio_chain(discard_bio, bio);
 	bio_clone_blkg_association(discard_bio, bio);
 	if (mddev->gendisk)
-		trace_block_bio_remap(bdev_get_queue(rdev->bdev),
-			discard_bio, disk_devt(mddev->gendisk),
-			bio->bi_iter.bi_sector);
+		trace_block_bio_remap(discard_bio, disk_devt(mddev->gendisk),
+				      bio->bi_iter.bi_sector);
 	submit_bio_noacct(discard_bio);
 }
 EXPORT_SYMBOL(md_submit_discard_bio);
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 6f44177593a552..e5d7411cba9b46 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -571,8 +571,8 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 		tmp_dev->data_offset;
 
 	if (mddev->gendisk)
-		trace_block_bio_remap(bio->bi_disk->queue, bio,
-				disk_devt(mddev->gendisk), bio_sector);
+		trace_block_bio_remap(bio, disk_devt(mddev->gendisk),
+				      bio_sector);
 	mddev_check_writesame(mddev, bio);
 	mddev_check_write_zeroes(mddev, bio);
 	submit_bio_noacct(bio);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 960d854c07f897..c0347997f6ff73 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1305,8 +1305,8 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	read_bio->bi_private = r1_bio;
 
 	if (mddev->gendisk)
-	        trace_block_bio_remap(read_bio->bi_disk->queue, read_bio,
-				disk_devt(mddev->gendisk), r1_bio->sector);
+	        trace_block_bio_remap(read_bio, disk_devt(mddev->gendisk),
+				      r1_bio->sector);
 
 	submit_bio_noacct(read_bio);
 }
@@ -1517,8 +1517,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 		atomic_inc(&r1_bio->remaining);
 
 		if (mddev->gendisk)
-			trace_block_bio_remap(mbio->bi_disk->queue,
-					      mbio, disk_devt(mddev->gendisk),
+			trace_block_bio_remap(mbio, disk_devt(mddev->gendisk),
 					      r1_bio->sector);
 		/* flush_pending_writes() needs access to the rdev so...*/
 		mbio->bi_disk = (void *)conf->mirrors[i].rdev;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index b7bca6703df814..a6f99fa0b32cfc 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1200,8 +1200,7 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 	read_bio->bi_private = r10_bio;
 
 	if (mddev->gendisk)
-	        trace_block_bio_remap(read_bio->bi_disk->queue,
-	                              read_bio, disk_devt(mddev->gendisk),
+	        trace_block_bio_remap(read_bio, disk_devt(mddev->gendisk),
 	                              r10_bio->sector);
 	submit_bio_noacct(read_bio);
 	return;
@@ -1250,8 +1249,7 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 	mbio->bi_private = r10_bio;
 
 	if (conf->mddev->gendisk)
-		trace_block_bio_remap(mbio->bi_disk->queue,
-				      mbio, disk_devt(conf->mddev->gendisk),
+		trace_block_bio_remap(mbio, disk_devt(conf->mddev->gendisk),
 				      r10_bio->sector);
 	/* flush_pending_writes() needs access to the rdev so...*/
 	mbio->bi_disk = (void *)rdev;
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 39343479ac2a94..3a90cc0e43ca8e 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1222,9 +1222,9 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 				set_bit(R5_DOUBLE_LOCKED, &sh->dev[i].flags);
 
 			if (conf->mddev->gendisk)
-				trace_block_bio_remap(bi->bi_disk->queue,
-						      bi, disk_devt(conf->mddev->gendisk),
-						      sh->dev[i].sector);
+				trace_block_bio_remap(bi,
+						disk_devt(conf->mddev->gendisk),
+						sh->dev[i].sector);
 			if (should_defer && op_is_write(op))
 				bio_list_add(&pending_bios, bi);
 			else
@@ -1272,9 +1272,9 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 			if (op == REQ_OP_DISCARD)
 				rbi->bi_vcnt = 0;
 			if (conf->mddev->gendisk)
-				trace_block_bio_remap(rbi->bi_disk->queue,
-						      rbi, disk_devt(conf->mddev->gendisk),
-						      sh->dev[i].sector);
+				trace_block_bio_remap(rbi,
+						disk_devt(conf->mddev->gendisk),
+						sh->dev[i].sector);
 			if (should_defer && op_is_write(op))
 				bio_list_add(&pending_bios, rbi);
 			else
@@ -5468,8 +5468,7 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
 		spin_unlock_irq(&conf->device_lock);
 
 		if (mddev->gendisk)
-			trace_block_bio_remap(align_bi->bi_disk->queue,
-					      align_bi, disk_devt(mddev->gendisk),
+			trace_block_bio_remap(align_bi, disk_devt(mddev->gendisk),
 					      raid_bio->bi_iter.bi_sector);
 		submit_bio_noacct(align_bi);
 		return 1;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 74896be40c1769..106cf5c44ee7ab 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -312,8 +312,7 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 	if (likely(ns)) {
 		bio->bi_disk = ns->disk;
 		bio->bi_opf |= REQ_NVME_MPATH;
-		trace_block_bio_remap(bio->bi_disk->queue, bio,
-				      disk_devt(ns->head->disk),
+		trace_block_bio_remap(bio, disk_devt(ns->head->disk),
 				      bio->bi_iter.bi_sector);
 		ret = submit_bio_noacct(bio);
 	} else if (nvme_available_path(head)) {
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index b415e4cba84304..8fb89574d8677f 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -450,9 +450,8 @@ TRACE_EVENT(block_split,
 
 /**
  * block_bio_remap - map request for a logical device to the raw device
- * @q: queue holding the operation
  * @bio: revised operation
- * @dev: device for the operation
+ * @dev: original device for the operation
  * @from: original sector for the operation
  *
  * An operation for a logical device has been mapped to the
@@ -460,10 +459,9 @@ TRACE_EVENT(block_split,
  */
 TRACE_EVENT(block_bio_remap,
 
-	TP_PROTO(struct request_queue *q, struct bio *bio, dev_t dev,
-		 sector_t from),
+	TP_PROTO(struct bio *bio, dev_t dev, sector_t from),
 
-	TP_ARGS(q, bio, dev, from),
+	TP_ARGS(bio, dev, from),
 
 	TP_STRUCT__entry(
 		__field( dev_t,		dev		)
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 3ca6d62114f461..405637144a0389 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -993,20 +993,16 @@ static void blk_add_trace_split(void *ignore, struct bio *bio, unsigned int pdu)
 /**
  * blk_add_trace_bio_remap - Add a trace for a bio-remap operation
  * @ignore:	trace callback data parameter (not used)
- * @q:		queue the io is for
  * @bio:	the source bio
- * @dev:	target device
+ * @dev:	source device
  * @from:	source sector
  *
- * Description:
- *     Device mapper or raid target sometimes need to split a bio because
- *     it spans a stripe (or similar). Add a trace for that action.
- *
+ * Called after a bio is remapped to a different device and/or sector.
  **/
-static void blk_add_trace_bio_remap(void *ignore,
-				    struct request_queue *q, struct bio *bio,
-				    dev_t dev, sector_t from)
+static void blk_add_trace_bio_remap(void *ignore, struct bio *bio, dev_t dev,
+				    sector_t from)
 {
+	struct request_queue *q = bio->bi_disk->queue;
 	struct blk_trace *bt;
 	struct blk_io_trace_remap r;
 
-- 
2.29.2

