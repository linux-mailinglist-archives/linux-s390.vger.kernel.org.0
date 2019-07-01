Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D786A1881E
	for <lists+linux-s390@lfdr.de>; Thu,  9 May 2019 12:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbfEIKDY (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 9 May 2019 06:03:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfEIKDY (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 9 May 2019 06:03:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36AEF88E48;
        Thu,  9 May 2019 10:03:24 +0000 (UTC)
Received: from localhost (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2128E1001E64;
        Thu,  9 May 2019 10:03:20 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org
Subject: [PATCH] s390/dasd: fix build warning in dasd_eckd_build_cp_raw
Date:   Thu,  9 May 2019 18:03:14 +0800
Message-Id: <20190509100314.19152-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 09 May 2019 10:03:24 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Commit 72deb455b5ec619f ("block: remove CONFIG_LBDAF") changes
sector_t to u64 unconditionaly, so apply '%llu' for print
sector_t variable.

Fixes: 72deb455b5ec619f ("block: remove CONFIG_LBDAF")
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/s390/block/dasd_eckd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index f89f9d02e788..c09039eea707 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -3827,7 +3827,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_raw(struct dasd_device *startdev,
 	if ((start_padding_sectors || end_padding_sectors) &&
 	    (rq_data_dir(req) == WRITE)) {
 		DBF_DEV_EVENT(DBF_ERR, basedev,
-			      "raw write not track aligned (%lu,%lu) req %p",
+			      "raw write not track aligned (%llu,%llu) req %p",
 			      start_padding_sectors, end_padding_sectors, req);
 		return ERR_PTR(-EINVAL);
 	}
-- 
2.9.5

