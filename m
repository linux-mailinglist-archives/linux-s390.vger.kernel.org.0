Return-Path: <linux-s390+bounces-2399-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A28F874BA6
	for <lists+linux-s390@lfdr.de>; Thu,  7 Mar 2024 11:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68D51F2B077
	for <lists+linux-s390@lfdr.de>; Thu,  7 Mar 2024 10:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CAD12D762;
	Thu,  7 Mar 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tFUmC2RO"
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A727712D1E0;
	Thu,  7 Mar 2024 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805372; cv=none; b=Z2y8CxJCYDwVCa1ryqOcnzG7dsZWKSFbQEWbYKBKg+VRtR7Mcvij5xwpRfI+TXFNYy2+yU00L7Yr8whBeDE2BSOl6h1y7jiPQKEcZqFIVF1tcEVQ7qPO3BlbE0f51rVz7GrbJGy6AXwS8YcJbkPrn7BNGYosuSweO3hz+nGZBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805372; c=relaxed/simple;
	bh=4SYq0MNi4JB7A69WIhhzrXwLtLthYDGt/xXlakfwFng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FvWnOt5c+xr7zUTlEwnBCe1oIgC+1/UXCS87g7kVPRV65OXfvzHjUfv1KKLvna/uzWUTHuT8e6UBALRFdi9Rw4u9vo8yWWQ+4bBMM7BBgrHik9yVO61Az8F7I9NmjIXuHdLUQAGUjWl1U2VGehPr9WCZXjhPIGfa9pIHeaRNbkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tFUmC2RO; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709805363; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8Ab8IW2fS2yd95fNpvMr3UjgB1WQdOfro1JYhGbEp9k=;
	b=tFUmC2ROa07V5JXdPMuG43WGlfsgSVLV+g+uH9iD6LlKEJciB+ygduWZcsGz43tLKVUFdDHSpZvmR+MGB6qLR1g/Iuf8p0+EqTmS5SOa+A92pWR37bkiy1k8hURyRtu0JKzeRyEdU5+0/4i0Ei21Twbi7DVlb2p3qO2wsf1+F/k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2-Ke1m_1709805360;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W2-Ke1m_1709805360)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 17:56:02 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	twinkler@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 10/11] net/smc: adapt cursor update when sndbuf and peer DMB are merged
Date: Thu,  7 Mar 2024 17:55:35 +0800
Message-Id: <20240307095536.29648-11-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240307095536.29648-1-guwen@linux.alibaba.com>
References: <20240307095536.29648-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since ghost sndbuf shares the same physical memory with peer DMB,
the cursor update processing needs to be adapted to ensure that the
data to be consumed won't be overwritten.

So in this case, the fin_curs and sndbuf_space that were originally
updated after sending the CDC message should be modified to not be
update until the peer updates cons_curs.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_cdc.c | 52 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index c820ef197610..e938fe3bcc7c 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -18,6 +18,7 @@
 #include "smc_tx.h"
 #include "smc_rx.h"
 #include "smc_close.h"
+#include "smc_ism.h"
 
 /********************************** send *************************************/
 
@@ -255,17 +256,25 @@ int smcd_cdc_msg_send(struct smc_connection *conn)
 		return rc;
 	smc_curs_copy(&conn->rx_curs_confirmed, &curs, conn);
 	conn->local_rx_ctrl.prod_flags.cons_curs_upd_req = 0;
-	/* Calculate transmitted data and increment free send buffer space */
-	diff = smc_curs_diff(conn->sndbuf_desc->len, &conn->tx_curs_fin,
-			     &conn->tx_curs_sent);
-	/* increased by confirmed number of bytes */
-	smp_mb__before_atomic();
-	atomic_add(diff, &conn->sndbuf_space);
-	/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
-	smp_mb__after_atomic();
-	smc_curs_copy(&conn->tx_curs_fin, &conn->tx_curs_sent, conn);
+	if (!smc_ism_support_dmb_nocopy(conn->lgr->smcd)) {
+		/* Ghost sndbuf shares the same memory region with
+		 * peer DMB, so don't update the tx_curs_fin and
+		 * sndbuf_space until peer has consumed the data.
+		 */
+		/* Calculate transmitted data and increment free
+		 * send buffer space
+		 */
+		diff = smc_curs_diff(conn->sndbuf_desc->len, &conn->tx_curs_fin,
+				     &conn->tx_curs_sent);
+		/* increased by confirmed number of bytes */
+		smp_mb__before_atomic();
+		atomic_add(diff, &conn->sndbuf_space);
+		/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
+		smp_mb__after_atomic();
+		smc_curs_copy(&conn->tx_curs_fin, &conn->tx_curs_sent, conn);
 
-	smc_tx_sndbuf_nonfull(smc);
+		smc_tx_sndbuf_nonfull(smc);
+	}
 	return rc;
 }
 
@@ -323,7 +332,7 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 {
 	union smc_host_cursor cons_old, prod_old;
 	struct smc_connection *conn = &smc->conn;
-	int diff_cons, diff_prod;
+	int diff_cons, diff_prod, diff_tx;
 
 	smc_curs_copy(&prod_old, &conn->local_rx_ctrl.prod, conn);
 	smc_curs_copy(&cons_old, &conn->local_rx_ctrl.cons, conn);
@@ -339,6 +348,27 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 		atomic_add(diff_cons, &conn->peer_rmbe_space);
 		/* guarantee 0 <= peer_rmbe_space <= peer_rmbe_size */
 		smp_mb__after_atomic();
+
+		if (conn->lgr->is_smcd &&
+		    smc_ism_support_dmb_nocopy(conn->lgr->smcd)) {
+			/* Ghost sndbuf shares the same memory region with
+			 * peer RMB, so update tx_curs_fin and sndbuf_space
+			 * when peer has consumed the data.
+			 */
+			/* calculate peer rmb consumed data */
+			diff_tx = smc_curs_diff(conn->sndbuf_desc->len,
+						&conn->tx_curs_fin,
+						&conn->local_rx_ctrl.cons);
+			/* increase local sndbuf space and fin_curs */
+			smp_mb__before_atomic();
+			atomic_add(diff_tx, &conn->sndbuf_space);
+			/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
+			smp_mb__after_atomic();
+			smc_curs_copy(&conn->tx_curs_fin,
+				      &conn->local_rx_ctrl.cons, conn);
+
+			smc_tx_sndbuf_nonfull(smc);
+		}
 	}
 
 	diff_prod = smc_curs_diff(conn->rmb_desc->len, &prod_old,
-- 
2.32.0.3.g01195cf9f


