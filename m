Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8586F10E758
	for <lists+linux-s390@lfdr.de>; Mon,  2 Dec 2019 10:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfLBJCS (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 2 Dec 2019 04:02:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55251 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfLBJCS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Dec 2019 04:02:18 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1ibhax-0006Io-Rg; Mon, 02 Dec 2019 09:02:15 +0000
From:   Colin King <colin.king@canonical.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] s390/test_unwind: fix spelling mistake "reqister" -> "register"
Date:   Mon,  2 Dec 2019 09:02:15 +0000
Message-Id: <20191202090215.28766-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a pr_info message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/s390/lib/test_unwind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
index bda7ac0ddd29..32b7a30b2485 100644
--- a/arch/s390/lib/test_unwind.c
+++ b/arch/s390/lib/test_unwind.c
@@ -238,7 +238,7 @@ static int test_unwind_irq(struct unwindme *u)
 {
 	preempt_disable();
 	if (register_external_irq(EXT_IRQ_CLK_COMP, unwindme_irq_handler)) {
-		pr_info("Couldn't reqister external interrupt handler");
+		pr_info("Couldn't register external interrupt handler");
 		return -1;
 	}
 	u->task = current;
-- 
2.24.0

