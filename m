Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531B030477E
	for <lists+linux-s390@lfdr.de>; Tue, 26 Jan 2021 20:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbhAZF76 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 26 Jan 2021 00:59:58 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2875 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbhAYKSi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 Jan 2021 05:18:38 -0500
Received: from dggeme764-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DPPj14ltVz5Kdq;
        Mon, 25 Jan 2021 17:29:57 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggeme764-chm.china.huawei.com
 (10.3.19.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Mon, 25
 Jan 2021 17:31:26 +0800
From:   Chengyang Fan <cy.fan@huawei.com>
To:     <hca@linux.ibm.com>, <gor@linux.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <joe@perches.com>
Subject: [PATCH] s390/ap: remove unneeded semicolon
Date:   Mon, 25 Jan 2021 17:58:39 +0800
Message-ID: <20210125095839.1720265-1-cy.fan@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggeme764-chm.china.huawei.com (10.3.19.110)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Remove a superfluous semicolon after function definition.

Signed-off-by: Chengyang Fan <cy.fan@huawei.com>
---
 arch/s390/include/asm/ap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
index aea32dda3d14..837d1699b109 100644
--- a/arch/s390/include/asm/ap.h
+++ b/arch/s390/include/asm/ap.h
@@ -368,7 +368,7 @@ static inline struct ap_queue_status ap_dqap(ap_qid_t qid,
 #if IS_ENABLED(CONFIG_ZCRYPT)
 void ap_bus_cfg_chg(void);
 #else
-static inline void ap_bus_cfg_chg(void){};
+static inline void ap_bus_cfg_chg(void){}
 #endif
 
 #endif /* _ASM_S390_AP_H_ */
-- 
2.25.1

