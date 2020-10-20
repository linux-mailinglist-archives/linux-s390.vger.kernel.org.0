Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CC5285F52
	for <lists+linux-s390@lfdr.de>; Wed,  7 Oct 2020 14:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgJGMkO (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 7 Oct 2020 08:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgJGMkN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 08:40:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C36C061755;
        Wed,  7 Oct 2020 05:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=DrrvEOjZI6Az8+75GC0PV7Uo44fWyYkOTa/aSWPg2uU=; b=JDCZw4nI9Zma2DaNFVZTrizyqb
        a16c6EpM8qJyE3oXb9t8r8/UxOQelXczDxI/5mi9mNIz0z7abz8YQzR70Jwh+PULIIfpXBXwqF4U3
        /6/aFc3XslWsRglmVBT7x7fgvb0t0Qi96E7DPHC8mb0JcPC1gIvUat857L839ZnI6Dvb2iffi8IPv
        WpacUjEC6trWRv7usJEhoMZ0V0qePnfCG0P2+qkDfWr2cP2kB7sUVNMcVVlrrG7ZJQmcV4O1ehlvg
        kH9qrpgmCNeUxIryUFXV4Ny8/hxagQZ1YU/CyEzJ/Yyjen9JWX5Azv8QS7BYF+fTfA2o3sfvoKdII
        MOSDnr1w==;
Received: from [2001:4bb8:184:92a2:f749:31f9:6664:a99d] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQ8jr-0003ul-DI; Wed, 07 Oct 2020 12:40:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, sth@linux.ibm.com,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] partitions/ibm: fix non-DASD devices
Date:   Wed,  7 Oct 2020 14:40:09 +0200
Message-Id: <20201007124009.1438269-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Don't error out if the dasd_biodasdinfo symbol is not available.

Fixes: 26d7e28e3820 ("s390/dasd: remove ioctl_by_bdev calls")
Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 block/partitions/ibm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index d6e18df9c53c6d..4b044e620d3534 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -305,8 +305,6 @@ int ibm_partition(struct parsed_partitions *state)
 	if (!disk->fops->getgeo)
 		goto out_exit;
 	fn = symbol_get(dasd_biodasdinfo);
-	if (!fn)
-		goto out_exit;
 	blocksize = bdev_logical_block_size(bdev);
 	if (blocksize <= 0)
 		goto out_symbol;
@@ -326,7 +324,7 @@ int ibm_partition(struct parsed_partitions *state)
 	geo->start = get_start_sect(bdev);
 	if (disk->fops->getgeo(bdev, geo))
 		goto out_freeall;
-	if (fn(disk, info)) {
+	if (!fn || fn(disk, info)) {
 		kfree(info);
 		info = NULL;
 	}
@@ -370,7 +368,8 @@ int ibm_partition(struct parsed_partitions *state)
 out_nogeo:
 	kfree(info);
 out_symbol:
-	symbol_put(dasd_biodasdinfo);
+	if (fn)
+		symbol_put(dasd_biodasdinfo);
 out_exit:
 	return res;
 }
-- 
2.28.0

