Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6298818A4C8
	for <lists+linux-s390@lfdr.de>; Wed, 18 Mar 2020 21:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgCRUzq (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 18 Mar 2020 16:55:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728447AbgCRUzq (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Mar 2020 16:55:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF1F820A8B;
        Wed, 18 Mar 2020 20:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564945;
        bh=OtpKH4sa7WjFFEqXU6hQbOx0/zIIZm3na15gYI4GVjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lCWAILFi5ALnbhzQuO/m6tGMnozHNb/czFrbsg3Zt0O1hehOea1lgYlfyL5urQHc6
         DoYbRaPJrDnXv3z8QPhx0NbZ2Rt9YQrbP1qbBb6JmU9YPVBieBTk6fQjgzx6VtVW74
         GTGoMMdMMu+Ecq1hGJh7fhq2gkKnvG30K0wGnca8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 30/37] s390/qeth: handle error when backing RX buffer
Date:   Wed, 18 Mar 2020 16:55:02 -0400
Message-Id: <20200318205509.17053-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205509.17053-1-sashal@kernel.org>
References: <20200318205509.17053-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 17413852804d7e86e6f0576cca32c1541817800e ]

qeth_init_qdio_queues() fills the RX ring with an initial set of
RX buffers. If qeth_init_input_buffer() fails to back one of the RX
buffers with memory, we need to bail out and report the error.

Fixes: 4a71df50047f ("qeth: new qeth device driver")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index d99bfbfcafb76..5f59e2dfc7db9 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2811,12 +2811,12 @@ static int qeth_init_input_buffer(struct qeth_card *card,
 		buf->rx_skb = netdev_alloc_skb(card->dev,
 					       QETH_RX_PULL_LEN + ETH_HLEN);
 		if (!buf->rx_skb)
-			return 1;
+			return -ENOMEM;
 	}
 
 	pool_entry = qeth_find_free_buffer_pool_entry(card);
 	if (!pool_entry)
-		return 1;
+		return -ENOBUFS;
 
 	/*
 	 * since the buffer is accessed only from the input_tasklet
@@ -2848,10 +2848,15 @@ int qeth_init_qdio_queues(struct qeth_card *card)
 	/* inbound queue */
 	qdio_reset_buffers(card->qdio.in_q->qdio_bufs, QDIO_MAX_BUFFERS_PER_Q);
 	memset(&card->rx, 0, sizeof(struct qeth_rx));
+
 	qeth_initialize_working_pool_list(card);
 	/*give only as many buffers to hardware as we have buffer pool entries*/
-	for (i = 0; i < card->qdio.in_buf_pool.buf_count - 1; ++i)
-		qeth_init_input_buffer(card, &card->qdio.in_q->bufs[i]);
+	for (i = 0; i < card->qdio.in_buf_pool.buf_count - 1; i++) {
+		rc = qeth_init_input_buffer(card, &card->qdio.in_q->bufs[i]);
+		if (rc)
+			return rc;
+	}
+
 	card->qdio.in_q->next_buf_to_init =
 		card->qdio.in_buf_pool.buf_count - 1;
 	rc = do_QDIO(CARD_DDEV(card), QDIO_FLAG_SYNC_INPUT, 0, 0,
-- 
2.20.1

