Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666D13FF290
	for <lists+linux-s390@lfdr.de>; Thu,  2 Sep 2021 19:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347027AbhIBRmU (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 2 Sep 2021 13:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346791AbhIBRmR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Sep 2021 13:42:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD7CC061757;
        Thu,  2 Sep 2021 10:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7V8FZ80qIliivCO2ypIuGl2Awrc5ZK57tRJ4fo+fTPQ=; b=kjbVAj8y8kqrHOxzh5HG+PkbB9
        Y6I1Ri0p1OX8ZojE1JOAtx4zNb9br0bIT6kKcK0pwb43OF/nWHFc+nzS0JUAXe3mIT6QK9s5vu4ue
        fVEEbUgJeTgtw4VwPNvigT+lKIU6Dc8233ERbzZkIIXiwvWz4Hyfz6tf4LrQ28A1u9dDSaA6rYFq9
        35uMQ4WV2bbPVzdnA4rPEVZgLiAh6l2P8UTq9MmGpEaNGRNmvPKTLrfXBUgdDd1mjX1O5JxBV7YmM
        e8r3pzUqdi2C5GoAQ05/qJlFjCC4Bdm93rQ4fhe1239c5f20fXZ37R5oExtjYihS2xkkljbg05j1x
        Sjh2fZXQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLqi2-00A9FS-An; Thu, 02 Sep 2021 17:41:06 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, gregkh@linuxfoundation.org,
        chaitanya.kulkarni@wdc.com, atulgopinathan@gmail.com, hare@suse.de,
        maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org,
        colin.king@canonical.com, shubhankarvk@gmail.com,
        baijiaju1990@gmail.com, trix@redhat.com,
        dongsheng.yang@easystack.cn, ceph-devel@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com, oberpar@linux.ibm.com,
        tj@kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 9/9] s390/block/xpram: add error handling support for add_disk()
Date:   Thu,  2 Sep 2021 10:41:05 -0700
Message-Id: <20210902174105.2418771-10-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210902174105.2418771-1-mcgrof@kernel.org>
References: <20210902174105.2418771-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/s390/block/xpram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
index ce98fab4d43c..ed3904b6a9c8 100644
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -371,7 +371,9 @@ static int __init xpram_setup_blkdev(void)
 		disk->private_data = &xpram_devices[i];
 		sprintf(disk->disk_name, "slram%d", i);
 		set_capacity(disk, xpram_sizes[i] << 1);
-		add_disk(disk);
+		rc = add_disk(disk);
+		if (rc)
+			goto out;
 	}
 
 	return 0;
-- 
2.30.2

