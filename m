Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86AB8B0028
	for <lists+linux-s390@lfdr.de>; Wed, 11 Sep 2019 17:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfIKPfC (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 11 Sep 2019 11:35:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34069 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbfIKPfC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 Sep 2019 11:35:02 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1i84e4-0007EO-RV; Wed, 11 Sep 2019 15:35:00 +0000
From:   Colin King <colin.king@canonical.com>
To:     Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390/qeth: fix spelling mistake "alocpool" -> "allocpool"
Date:   Wed, 11 Sep 2019 16:35:00 +0100
Message-Id: <20190911153500.30836-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in QETH_CARD_TEXT text. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/s390/net/qeth_core_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index a7868c8133ee..ab96b22db3fe 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -218,7 +218,7 @@ static int qeth_alloc_buffer_pool(struct qeth_card *card)
 	void *ptr;
 	int i, j;
 
-	QETH_CARD_TEXT(card, 5, "alocpool");
+	QETH_CARD_TEXT(card, 5, "allocpool");
 	for (i = 0; i < card->qdio.init_pool.buf_count; ++i) {
 		pool_entry = kzalloc(sizeof(*pool_entry), GFP_KERNEL);
 		if (!pool_entry) {
-- 
2.20.1

