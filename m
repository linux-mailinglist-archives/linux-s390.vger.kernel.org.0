Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACB406B97C
	for <lists+linux-s390@lfdr.de>; Wed, 17 Jul 2019 11:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfGQJoC (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 17 Jul 2019 05:44:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfGQJoB (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jul 2019 05:44:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F49E5D674;
        Wed, 17 Jul 2019 09:44:01 +0000 (UTC)
Received: from localhost (dhcp-192-232.str.redhat.com [10.33.192.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B8F319C68;
        Wed, 17 Jul 2019 09:44:01 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Farhan Ali <alifm@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL v2 2/6] vfio-ccw: Fix memory leak and don't call cp_free in cp_init
Date:   Wed, 17 Jul 2019 11:43:46 +0200
Message-Id: <20190717094350.13620-3-cohuck@redhat.com>
In-Reply-To: <20190717094350.13620-1-cohuck@redhat.com>
References: <20190717094350.13620-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 17 Jul 2019 09:44:01 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Farhan Ali <alifm@linux.ibm.com>

We don't set cp->initialized to true so calling cp_free
will just return and not do anything.

Also fix a memory leak where we fail to free a ccwchain
on an error.

Fixes: 812271b910 ("s390/cio: Squash cp_free() and cp_unpin_free()")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Message-Id: <3173c4216f4555d9765eb6e4922534982bc820e4.1562854091.git.alifm@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 46967c664c0f..e4e8724eddaa 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -421,7 +421,7 @@ static int ccwchain_loop_tic(struct ccwchain *chain,
 static int ccwchain_handle_ccw(u32 cda, struct channel_program *cp)
 {
 	struct ccwchain *chain;
-	int len;
+	int len, ret;
 
 	/* Copy 2K (the most we support today) of possible CCWs */
 	len = copy_from_iova(cp->mdev, cp->guest_cp, cda,
@@ -448,7 +448,12 @@ static int ccwchain_handle_ccw(u32 cda, struct channel_program *cp)
 	memcpy(chain->ch_ccw, cp->guest_cp, len * sizeof(struct ccw1));
 
 	/* Loop for tics on this new chain. */
-	return ccwchain_loop_tic(chain, cp);
+	ret = ccwchain_loop_tic(chain, cp);
+
+	if (ret)
+		ccwchain_free(chain);
+
+	return ret;
 }
 
 /* Loop for TICs. */
@@ -642,8 +647,6 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
 
 	/* Build a ccwchain for the first CCW segment */
 	ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
-	if (ret)
-		cp_free(cp);
 
 	if (!ret) {
 		cp->initialized = true;
-- 
2.20.1

