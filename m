Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449B71A74BD
	for <lists+linux-s390@lfdr.de>; Tue, 14 Apr 2020 09:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390783AbgDNH32 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 14 Apr 2020 03:29:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390787AbgDNH3Z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Apr 2020 03:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=n5Vh+JWVW9VTJbLignOyEmbI7gMCeWGX/uWajVGfIY4=; b=BsQyn5zOWdrutkRIhdAqATKkQu
        7ukOGdyKpaIE8X9gxbay2q3JsaM9dk/mLqHDWVBn0j6m0HW0K3cS4Emblk/cAsMJ46qi/2U06nEQE
        4jwCexfq06x+C06jRdKkcqmr0i77e3a7HBi8qztPRanWP6j79a9I1Q3IOX2Och5mfJ05Z2xAfQiGM
        8DOEW3rVqKyZKLIXD4TWOqrfuCICdugD8MvIAcZ2gQ3HBqPfAhwCFXdLNOZKJ27A2TE1ZUdnd1Md8
        XO/1WjVw+56P+USdg1z5N5R8nvNAw4zmWh/XJJBbJzt5gjBlTOUb9zgMbDSCnj6NxZRLFbVD5hpj6
        ZgvLhhvQ==;
Received: from [2001:4bb8:180:384b:4c21:af7:dd95:e552] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOG0U-0005Zl-EA; Tue, 14 Apr 2020 07:29:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 04/10] block: remove hd_struct_kill
Date:   Tue, 14 Apr 2020 09:28:56 +0200
Message-Id: <20200414072902.324936-5-hch@lst.de>
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

The function has a single caller, so just open code it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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
index c5b47627210a..7d062599aa33 100644
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

