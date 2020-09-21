Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E97271B90
	for <lists+linux-s390@lfdr.de>; Mon, 21 Sep 2020 09:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgIUHVD (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 21 Sep 2020 03:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgIUHUR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Sep 2020 03:20:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D3FC061755;
        Mon, 21 Sep 2020 00:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aWpQMjG3K8ZDoYTgVEFk+u0gKdJASH29rDnXXsv40lc=; b=nPdCKsa1AKYRb5HoCWLpMWnHZ2
        WCzoTP4XCD0vyRaLIMn5iDFyYAA8Xb8Yddn7TOP2uVGBRq5AP3wK3vqVJFCaxhLv4Kt7Alp2qbVuS
        tMAx1+5VCDlAsg7CXEFh2DA26uSrVwWRbVDQBrJ9zo8doVfGJfAhpINmK98BIZyZUGrC+K0x32iwX
        LYBk5b1gPP3CeKR/yE/3rZTm2osd3al6VncOcoX/Ji3imqTpOVc8wf6lO72NvI5Rm+BOqOjrpAnmf
        Qyb8TYf1JgO1QiDHTK29wr3DOXIzknAMqf5iWxna1LDXl9q6kzsxGQ8z64z9kpKzWizW5DRXA03qw
        ZdXiB9DQ==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKG7J-0003JK-J0; Mon, 21 Sep 2020 07:20:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: [PATCH 14/14] block: mark blkdev_get static
Date:   Mon, 21 Sep 2020 09:19:58 +0200
Message-Id: <20200921071958.307589-15-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921071958.307589-1-hch@lst.de>
References: <20200921071958.307589-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

There are no users outside the core block code left now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c         | 3 +--
 include/linux/blkdev.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 2898d69be6b3e4..6b9d19ffa5af7b 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1616,7 +1616,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
  * RETURNS:
  * 0 on success, -errno on failure.
  */
-int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
+static int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 {
 	int ret, perm = 0;
 
@@ -1637,7 +1637,6 @@ int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 	bdput(bdev);
 	return ret;
 }
-EXPORT_SYMBOL(blkdev_get);
 
 /**
  * blkdev_get_by_path - open a block device by name
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5bd96fbab9b4c8..14117995091224 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1975,7 +1975,6 @@ void blkdev_show(struct seq_file *seqf, off_t offset);
 #define BLKDEV_MAJOR_MAX	0
 #endif
 
-int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder);
 struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 		void *holder);
 struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder);
-- 
2.28.0

