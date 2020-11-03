Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B872A418D
	for <lists+linux-s390@lfdr.de>; Tue,  3 Nov 2020 11:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgKCKUJ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 3 Nov 2020 05:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgKCKUI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Nov 2020 05:20:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D37C0613D1;
        Tue,  3 Nov 2020 02:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LHct6feTU7L0nCAl+LeQycCuOcwMhUL/YjRE2qUcCWU=; b=EUCvbfmEHp0IpQXzmXvVfjnuzg
        bGacAQCt80Bel0nlDOWWmOEIu/92AmksnWinXhnPhdMMDlfDf9FWoNM/HuCdCVlXtkm5MKufxnkWl
        tmml6TFttlAkN6GyTx5qY1zJ35r9pIfWBr3CCmLw9v3jU9ByIaFXZdGMCEdW6UwvW98v+8E49fxsE
        2Q0crdFjqYy1xBCp1I2lopKAMDshkL5oH0AreUZMk7orAKa7C7dZZtw073QaVZMp7z6Oj3cF02CsO
        zbgIDwcet1zYdy3v6MbWqKOcNo4agmG3Uqi/KWqZlLjJOaqxKGyNVjTkM97Oi53FMQhp8PfMNsbni
        qQdNOW2g==;
Received: from 089144208145.atnat0017.highway.a1.net ([89.144.208.145] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZtPz-0001Dl-Fp; Tue, 03 Nov 2020 10:20:00 +0000
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
Subject: [PATCH 08/10] loop: use set_disk_ro
Date:   Tue,  3 Nov 2020 11:00:16 +0100
Message-Id: <20201103100018.683694-9-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103100018.683694-1-hch@lst.de>
References: <20201103100018.683694-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use set_disk_ro instead of set_device_ro to match all other block
drivers and to ensure all partitions mirror the read-only flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cb1191d6e945f2..3e1ea45bb315d8 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1137,7 +1137,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	if (error)
 		goto out_unlock;
 
-	set_device_ro(bdev, (lo->lo_flags & LO_FLAGS_READ_ONLY) != 0);
+	set_disk_ro(lo->lo_disk, (lo->lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
 	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 	lo->lo_device = bdev;
-- 
2.28.0

