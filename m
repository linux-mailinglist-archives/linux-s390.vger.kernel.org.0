Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C28138BE2B
	for <lists+linux-s390@lfdr.de>; Fri, 21 May 2021 07:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhEUFx1 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 21 May 2021 01:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbhEUFxT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 21 May 2021 01:53:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296E6C0613ED;
        Thu, 20 May 2021 22:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qpSY+0TMV+kLNfssm5yqW5PXw6929uJMh10yjO4G3Hg=; b=REjOcyfEWJqr1F+Dz0zsnHHh7k
        CFJeufNc2XQCjxry2qXhzZcdWYuKNubSk6Ip0JRyepquClMzNvAK1cwJDGCf7oQlZfmL2qmubz3Sa
        3DS30OGdWJUke42YryY7PJUac6hEA6fOmzKf888kUppNbcbMZRyxliw8ExySUjM7T7qES1PNURchG
        reZQ76l2KTyWSLrn2iS6wGvfjP71UejnKYwqy0z6+V+6dIp/TcXKf9XTO9kurus/aP68avlCAbWUZ
        kJXtJCv/AW2mNI38UTxbXLtzWToT1Nvc1Clan2W2Jj7CAv5tM3mqun3CXzgQQNlyk64rufwa6Er2D
        cLuVZfGw==;
Received: from [2001:4bb8:180:5add:4fd7:4137:d2f2:46e6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljy4T-00Gpyh-Dv; Fri, 21 May 2021 05:51:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jim Paris <jim@jtan.com>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Matias Bjorling <mb@lightnvm.io>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
        drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH 07/26] drbd: convert to blk_alloc_disk/blk_cleanup_disk
Date:   Fri, 21 May 2021 07:50:57 +0200
Message-Id: <20210521055116.1053587-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210521055116.1053587-1-hch@lst.de>
References: <20210521055116.1053587-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Convert the drbd driver to use the blk_alloc_disk and blk_cleanup_disk
helpers to simplify gendisk and request_queue allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_main.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index de463773b530..55234a558e98 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2231,8 +2231,7 @@ void drbd_destroy_device(struct kref *kref)
 	if (device->bitmap) /* should no longer be there. */
 		drbd_bm_cleanup(device);
 	__free_page(device->md_io.page);
-	put_disk(device->vdisk);
-	blk_cleanup_queue(device->rq_queue);
+	blk_cleanup_disk(device->vdisk);
 	kfree(device->rs_plan_s);
 
 	/* not for_each_connection(connection, resource):
@@ -2701,7 +2700,6 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	struct drbd_device *device;
 	struct drbd_peer_device *peer_device, *tmp_peer_device;
 	struct gendisk *disk;
-	struct request_queue *q;
 	int id;
 	int vnr = adm_ctx->volume;
 	enum drbd_ret_code err = ERR_NOMEM;
@@ -2723,29 +2721,26 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 
 	drbd_init_set_defaults(device);
 
-	q = blk_alloc_queue(NUMA_NO_NODE);
-	if (!q)
-		goto out_no_q;
-	device->rq_queue = q;
-
-	disk = alloc_disk(1);
+	disk = blk_alloc_disk(NUMA_NO_NODE);
 	if (!disk)
 		goto out_no_disk;
+
 	device->vdisk = disk;
+	device->rq_queue = disk->queue;
 
 	set_disk_ro(disk, true);
 
-	disk->queue = q;
 	disk->major = DRBD_MAJOR;
 	disk->first_minor = minor;
+	disk->minors = 1;
 	disk->fops = &drbd_ops;
 	sprintf(disk->disk_name, "drbd%d", minor);
 	disk->private_data = device;
 
-	blk_queue_write_cache(q, true, true);
+	blk_queue_write_cache(disk->queue, true, true);
 	/* Setting the max_hw_sectors to an odd value of 8kibyte here
 	   This triggers a max_bio_size message upon first attach or connect */
-	blk_queue_max_hw_sectors(q, DRBD_MAX_BIO_SIZE_SAFE >> 8);
+	blk_queue_max_hw_sectors(disk->queue, DRBD_MAX_BIO_SIZE_SAFE >> 8);
 
 	device->md_io.page = alloc_page(GFP_KERNEL);
 	if (!device->md_io.page)
@@ -2834,10 +2829,8 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 out_no_bitmap:
 	__free_page(device->md_io.page);
 out_no_io_page:
-	put_disk(disk);
+	blk_cleanup_disk(disk);
 out_no_disk:
-	blk_cleanup_queue(q);
-out_no_q:
 	kref_put(&resource->kref, drbd_destroy_resource);
 	kfree(device);
 	return err;
-- 
2.30.2

