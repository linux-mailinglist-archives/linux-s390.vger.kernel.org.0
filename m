Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6125F1A2989
	for <lists+linux-s390@lfdr.de>; Wed,  8 Apr 2020 21:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgDHTow (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 8 Apr 2020 15:44:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729382AbgDHTow (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 15:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CLr8PhWQMR8C43XGb6bzbVdZHVmy/mIdNLhGTpfjDbE=; b=oUAJAqRs7Q0bFEsq+DT4Fbvbls
        3j+5MLNlN2c7b35dA1bPaX+7YeylfB0lguHGeUab6y9AccFr/QFDFcQufqZ+01VM537y1NDpGCT1R
        KdUkuMF22WUQft/qyiWHyI6wh0yl0fRJmE62ICpine+nOq4Z7uVoL341c54i65gstPXMYf9P9c7kK
        21BxL9C1URFouD4w7amca1ldCEynizD1ik6jMqZh48Sk1/xuGqWCgcf8x8zcBTzkX9FpKtvCk6/1n
        cTbhCWskExSry2qC400ARedjtM05xSo5IbUdniWM+cJW09moqVzYHEFZsePSGxU/lbTCiuj2RmUU7
        6RSY1BGw==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMGd1-0004Hk-9g; Wed, 08 Apr 2020 19:44:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 04/10] block: remove hd_struct_kill
Date:   Wed,  8 Apr 2020 21:44:33 +0200
Message-Id: <20200408194439.1580699-5-hch@lst.de>
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

The function has a single caller, so just open code it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h             | 5 -----
 block/partitions/core.c | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index b1a0b8cd87f0..204963bb03e8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -413,11 +413,6 @@ static inline void hd_struct_put(struct hd_struct *part)
 	percpu_ref_put(&part->ref);
 }
 
-static inline void hd_struct_kill(struct hd_struct *part)
-{
-	percpu_ref_kill(&part->ref);
-}
-
 static inline void hd_free_part(struct hd_struct *part)
 {
 	free_part_stats(part);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 13d61ed76e0e..f10968b601be 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -321,7 +321,7 @@ void delete_partition(struct gendisk *disk, struct hd_struct *part)
 	 * "in-use" until we really free the gendisk.
 	 */
 	blk_invalidate_devt(part_devt(part));
-	hd_struct_kill(part);
+	percpu_ref_kill(&part->ref);
 }
 
 static ssize_t whole_disk_show(struct device *dev,
-- 
2.25.1

