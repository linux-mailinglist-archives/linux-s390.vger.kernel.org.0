Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAA7504BF5
	for <lists+linux-s390@lfdr.de>; Mon, 18 Apr 2022 06:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiDRE4U (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 18 Apr 2022 00:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbiDRE4R (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Apr 2022 00:56:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE8917ABA;
        Sun, 17 Apr 2022 21:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ehhbXywWEInDu2MzhhcU8qyC2x202NRIVxnfV552fWg=; b=4+aRzQJYcjSRih3CAHHoWbQKH7
        tpRyxCuoqoDD29J+mP/JD+tuOpLTzRf6tGAVyuGm1tGzqWiKw0VPI3Z//Ivegeb/zkkMfBF25uEJu
        8o1KOY9vmrdu70v5p52qRPOvKYU/KO1j7AILK0X1SV3xH0zUNCBtjO5MxmPWDyB3FnDcknLf1/b8+
        fYnEzGYeuBU14+X4y8DMlr1JmpgaZUgZLWvLmRML5UshcDri7muDpboKeTNp2VDYLGcnydDsZfdy1
        EQTV6mqhUtxtdvZYv9mIEeqGcvXfbsOHMtH6Uny/9EHEwtxN5JNm1DCu1+PcS53QbmFNMsfc4uiGB
        S1uPtQoA==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngJO3-00FYha-FT; Mon, 18 Apr 2022 04:53:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Mike Snitzer <snitzer@kernel.org>, Song Liu <song@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-um@lists.infradead.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        dm-devel@redhat.com
Subject: [PATCH 01/11] ubd: don't set the discard_alignment queue limit
Date:   Mon, 18 Apr 2022 06:53:04 +0200
Message-Id: <20220418045314.360785-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220418045314.360785-1-hch@lst.de>
References: <20220418045314.360785-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The discard_alignment queue limit is named a bit misleading means the
offset into the block device at which the discard granularity starts.
Setting it to the discard granularity as done by ubd is mostly harmless
but also useless.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 085ffdf98e57e..c4344b67628dd 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -799,7 +799,6 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 	}
 	if (ubd_dev->no_trim == 0) {
 		ubd_dev->queue->limits.discard_granularity = SECTOR_SIZE;
-		ubd_dev->queue->limits.discard_alignment = SECTOR_SIZE;
 		blk_queue_max_discard_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
 		blk_queue_max_write_zeroes_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
 	}
-- 
2.30.2

