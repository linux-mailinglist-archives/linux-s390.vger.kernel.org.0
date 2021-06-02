Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136C2398229
	for <lists+linux-s390@lfdr.de>; Wed,  2 Jun 2021 08:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhFBG6L (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 2 Jun 2021 02:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhFBG5v (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Jun 2021 02:57:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78631C06138D;
        Tue,  1 Jun 2021 23:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Nt6wErfubiqnYVzweXP3z8/rIFCiMtQahAHnZtmIiWQ=; b=hKOfYl8YkpHQsdsCJlgWZugO4N
        8fA3EUPkn9+TcsNuxwOAiqb3mNj8IytqoaliRlOJGLTV2vKpHMO6rQ1hlUlt0+Mkm+c5R/1hkmkn7
        oTHREX9ZW78opJHrkSMxB5aCt3NEqpb+8QhNRYh4/wvPcfO1Rb2/ZQR+g2Eo/Q/BlHFp+u+PN1zzV
        pUp3mo54MUYKztGaP64TzrsyiDi6S2vcUaJtmVAkviIbIqZRFaDYaSgCXtB5+UEr/Ho31XLAOGGlI
        c+6ImRaQZ98uKF5v5kiT9CbtO1B6knRIsPn1hDSDTVU+kF579t+oYPcuUhzdK5Z+yGE/Xb+qFY58k
        TDv/4cKQ==;
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1loKn5-0026La-Sd; Wed, 02 Jun 2021 06:55:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Tim Waugh <tim@cyberelk.net>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH 25/30] xen-blkfront: use blk_mq_alloc_disk and blk_cleanup_disk
Date:   Wed,  2 Jun 2021 09:53:40 +0300
Message-Id: <20210602065345.355274-26-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210602065345.355274-1-hch@lst.de>
References: <20210602065345.355274-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use blk_mq_alloc_disk and blk_cleanup_disk to simplify the gendisk and
request_queue allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/xen-blkfront.c | 96 +++++++++++++++---------------------
 1 file changed, 39 insertions(+), 57 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index f2c1aedcdf5a..8d49f8fa98bb 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -968,48 +968,6 @@ static void blkif_set_queue_limits(struct blkfront_info *info)
 	blk_queue_dma_alignment(rq, 511);
 }
 
-static int xlvbd_init_blk_queue(struct gendisk *gd, u16 sector_size,
-				unsigned int physical_sector_size)
-{
-	struct request_queue *rq;
-	struct blkfront_info *info = gd->private_data;
-
-	memset(&info->tag_set, 0, sizeof(info->tag_set));
-	info->tag_set.ops = &blkfront_mq_ops;
-	info->tag_set.nr_hw_queues = info->nr_rings;
-	if (HAS_EXTRA_REQ && info->max_indirect_segments == 0) {
-		/*
-		 * When indirect descriptior is not supported, the I/O request
-		 * will be split between multiple request in the ring.
-		 * To avoid problems when sending the request, divide by
-		 * 2 the depth of the queue.
-		 */
-		info->tag_set.queue_depth =  BLK_RING_SIZE(info) / 2;
-	} else
-		info->tag_set.queue_depth = BLK_RING_SIZE(info);
-	info->tag_set.numa_node = NUMA_NO_NODE;
-	info->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	info->tag_set.cmd_size = sizeof(struct blkif_req);
-	info->tag_set.driver_data = info;
-
-	if (blk_mq_alloc_tag_set(&info->tag_set))
-		return -EINVAL;
-	rq = blk_mq_init_queue(&info->tag_set);
-	if (IS_ERR(rq)) {
-		blk_mq_free_tag_set(&info->tag_set);
-		return PTR_ERR(rq);
-	}
-
-	rq->queuedata = info;
-	info->rq = gd->queue = rq;
-	info->gd = gd;
-	info->sector_size = sector_size;
-	info->physical_sector_size = physical_sector_size;
-	blkif_set_queue_limits(info);
-
-	return 0;
-}
-
 static const char *flush_info(struct blkfront_info *info)
 {
 	if (info->feature_flush && info->feature_fua)
@@ -1146,12 +1104,36 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
 
 	err = xlbd_reserve_minors(minor, nr_minors);
 	if (err)
-		goto out;
+		return err;
 	err = -ENODEV;
 
-	gd = alloc_disk(nr_minors);
-	if (gd == NULL)
-		goto release;
+	memset(&info->tag_set, 0, sizeof(info->tag_set));
+	info->tag_set.ops = &blkfront_mq_ops;
+	info->tag_set.nr_hw_queues = info->nr_rings;
+	if (HAS_EXTRA_REQ && info->max_indirect_segments == 0) {
+		/*
+		 * When indirect descriptior is not supported, the I/O request
+		 * will be split between multiple request in the ring.
+		 * To avoid problems when sending the request, divide by
+		 * 2 the depth of the queue.
+		 */
+		info->tag_set.queue_depth =  BLK_RING_SIZE(info) / 2;
+	} else
+		info->tag_set.queue_depth = BLK_RING_SIZE(info);
+	info->tag_set.numa_node = NUMA_NO_NODE;
+	info->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	info->tag_set.cmd_size = sizeof(struct blkif_req);
+	info->tag_set.driver_data = info;
+
+	err = blk_mq_alloc_tag_set(&info->tag_set);
+	if (err)
+		goto out_release_minors;
+
+	gd = blk_mq_alloc_disk(&info->tag_set, info);
+	if (IS_ERR(gd)) {
+		err = PTR_ERR(gd);
+		goto out_free_tag_set;
+	}
 
 	strcpy(gd->disk_name, DEV_NAME);
 	ptr = encode_disk_name(gd->disk_name + sizeof(DEV_NAME) - 1, offset);
@@ -1164,14 +1146,16 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
 
 	gd->major = XENVBD_MAJOR;
 	gd->first_minor = minor;
+	gd->minors = nr_minors;
 	gd->fops = &xlvbd_block_fops;
 	gd->private_data = info;
 	set_capacity(gd, capacity);
 
-	if (xlvbd_init_blk_queue(gd, sector_size, physical_sector_size)) {
-		del_gendisk(gd);
-		goto release;
-	}
+	info->rq = gd->queue;
+	info->gd = gd;
+	info->sector_size = sector_size;
+	info->physical_sector_size = physical_sector_size;
+	blkif_set_queue_limits(info);
 
 	xlvbd_flush(info);
 
@@ -1186,9 +1170,10 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
 
 	return 0;
 
- release:
+out_free_tag_set:
+	blk_mq_free_tag_set(&info->tag_set);
+out_release_minors:
 	xlbd_release_minors(minor, nr_minors);
- out:
 	return err;
 }
 
@@ -1217,12 +1202,9 @@ static void xlvbd_release_gendisk(struct blkfront_info *info)
 	nr_minors = info->gd->minors;
 	xlbd_release_minors(minor, nr_minors);
 
-	blk_cleanup_queue(info->rq);
-	blk_mq_free_tag_set(&info->tag_set);
-	info->rq = NULL;
-
-	put_disk(info->gd);
+	blk_cleanup_disk(info->gd);
 	info->gd = NULL;
+	blk_mq_free_tag_set(&info->tag_set);
 }
 
 /* Already hold rinfo->ring_lock. */
-- 
2.30.2

