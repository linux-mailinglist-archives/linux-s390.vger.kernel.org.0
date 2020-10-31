Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8542A14B1
	for <lists+linux-s390@lfdr.de>; Sat, 31 Oct 2020 10:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgJaJWW (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 31 Oct 2020 05:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgJaJWW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 31 Oct 2020 05:22:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAC5C0613D5;
        Sat, 31 Oct 2020 02:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3MSvK9iNSy+DFtMSDiSadE/QmhEKeo+2u5OIDmRr7vM=; b=SbajBFLZzxSbqHTnfyUDYuOs9Q
        AlPTPMQiJMVpCj4HUo+9SAYnxuk256+8XFZq6L3QIAbl55avttLUr1mYwtiSc3wyQJbjJxqOe4XVN
        DarPmrRVAn0nxozPoBogGFe891rSl6V7IyXzu8wp1f/YteqWLA00iRfmtsyzrQ6zfEytVMBZvoYyY
        SafyPEGeBDFIK+daVu/yiKf3LyaiWMcHPfAh0aBzuxHv55ltSEk0/A1E9/g8wnFmNqsS1AWyGGIDA
        7KYCHxbB3ra4Gz9MWNDrjYa8H/Yp4R+3rt1Dic5t+ctBW18UOx7BCpdNMBr8f6fdlWfTwm/dsO/Nl
        UQRskgqA==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYn5U-0008II-Mm; Sat, 31 Oct 2020 09:22:17 +0000
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
Subject: [PATCH 10/11] block: remove set_device_ro
Date:   Sat, 31 Oct 2020 09:58:09 +0100
Message-Id: <20201031085810.450489-11-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031085810.450489-1-hch@lst.de>
References: <20201031085810.450489-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Fold set_device_ro into its only remaining caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 7 -------
 block/ioctl.c         | 2 +-
 include/linux/genhd.h | 1 -
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 0a273211fec283..a487590b365e89 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1843,13 +1843,6 @@ static void set_disk_ro_uevent(struct gendisk *gd, int ro)
 	kobject_uevent_env(&disk_to_dev(gd)->kobj, KOBJ_CHANGE, envp);
 }
 
-void set_device_ro(struct block_device *bdev, int flag)
-{
-	bdev->bd_part->policy = flag;
-}
-
-EXPORT_SYMBOL(set_device_ro);
-
 void set_disk_ro(struct gendisk *disk, int flag)
 {
 	struct disk_part_iter piter;
diff --git a/block/ioctl.c b/block/ioctl.c
index 96cb4544736468..04255dc5f3bff3 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -371,7 +371,7 @@ static int blkdev_roset(struct block_device *bdev, fmode_t mode,
 		if (ret)
 			return ret;
 	}
-	set_device_ro(bdev, n);
+	bdev->bd_part->policy = n;
 	return 0;
 }
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 38f23d75701379..f232f26d7c777b 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -304,7 +304,6 @@ extern void del_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(dev_t dev, int *partno);
 extern struct block_device *bdget_disk(struct gendisk *disk, int partno);
 
-extern void set_device_ro(struct block_device *bdev, int flag);
 extern void set_disk_ro(struct gendisk *disk, int flag);
 
 static inline int get_disk_ro(struct gendisk *disk)
-- 
2.28.0

