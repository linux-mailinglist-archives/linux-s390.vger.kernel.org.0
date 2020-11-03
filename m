Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4171D2A417E
	for <lists+linux-s390@lfdr.de>; Tue,  3 Nov 2020 11:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgKCKR4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 3 Nov 2020 05:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgKCKRz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Nov 2020 05:17:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7104BC0613D1;
        Tue,  3 Nov 2020 02:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=p1ZVpq/JhXJNZ2ErQ1wodM48AyMMQ/eaTR0fjdImLPM=; b=BHWYCCBfAh6vADip6r+IwxTawN
        1ag44N85toKxC/4ni/GPClOGTpzCYCOa3GSG8ay/kcsf+0S+pFklYoWrecxlQ1jgHfAwJCflts9bv
        7wfp1C1RrqNXiMpyRW2NabiyihWEfLNVG3GZjbXF8Ov1uC49zGaH5qKfOTXYAaNWNf/bIF41D5ed2
        WyYpKCUqp9BvHHwIOKLnc90XEuzR/E6E+pXyofHuivoWRqT+xe4RZ8qbJ5zNe5Kh0l3mnJF8KQGHv
        56qeYUQZBDu9DiUvXSqw1o6Ef6mFF2K1owPOwQSSxshzrsueWBoAZl8Zvu8uvo39W32e/381vV3hE
        XMoCy0rg==;
Received: from 089144208145.atnat0017.highway.a1.net ([89.144.208.145] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZtNs-00016O-FM; Tue, 03 Nov 2020 10:17:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH 07/10] block: don't call into the driver for BLKROSET
Date:   Tue,  3 Nov 2020 11:00:15 +0100
Message-Id: <20201103100018.683694-8-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103100018.683694-1-hch@lst.de>
References: <20201103100018.683694-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Now that all drivers that want to hook into setting or clearing the
read-only flag use the set_read_only method, this code can be removed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/ioctl.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index a6fa16b9770593..96cb4544736468 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -346,26 +346,6 @@ static int blkdev_pr_clear(struct block_device *bdev,
 	return ops->pr_clear(bdev, c.key);
 }
 
-/*
- * Is it an unrecognized ioctl? The correct returns are either
- * ENOTTY (final) or ENOIOCTLCMD ("I don't know this one, try a
- * fallback"). ENOIOCTLCMD gets turned into ENOTTY by the ioctl
- * code before returning.
- *
- * Confused drivers sometimes return EINVAL, which is wrong. It
- * means "I understood the ioctl command, but the parameters to
- * it were wrong".
- *
- * We should aim to just fix the broken drivers, the EINVAL case
- * should go away.
- */
-static inline int is_unrecognized_ioctl(int ret)
-{
-	return	ret == -EINVAL ||
-		ret == -ENOTTY ||
-		ret == -ENOIOCTLCMD;
-}
-
 static int blkdev_flushbuf(struct block_device *bdev, fmode_t mode,
 		unsigned cmd, unsigned long arg)
 {
@@ -384,9 +364,6 @@ static int blkdev_roset(struct block_device *bdev, fmode_t mode,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	ret = __blkdev_driver_ioctl(bdev, mode, cmd, arg);
-	if (!is_unrecognized_ioctl(ret))
-		return ret;
 	if (get_user(n, (int __user *)arg))
 		return -EFAULT;
 	if (bdev->bd_disk->fops->set_read_only) {
-- 
2.28.0

