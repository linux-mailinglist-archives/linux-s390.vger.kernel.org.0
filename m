Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9321C85ED
	for <lists+linux-s390@lfdr.de>; Thu,  7 May 2020 11:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgEGJjO (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 7 May 2020 05:39:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3885 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgEGJjO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 7 May 2020 05:39:14 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 337F46E45F027E20161D;
        Thu,  7 May 2020 17:39:12 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 17:39:05 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-s390@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] s390/ism: fix error return code in ism_probe()
Date:   Thu, 7 May 2020 09:43:07 +0000
Message-ID: <20200507094307.14102-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Fix to return negative error code -ENOMEM from the smcd_alloc_dev()
error handling case instead of 0, as done elsewhere in this function.

Fixes: 684b89bc39ce ("s390/ism: add device driver for internal shared memory")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/s390/net/ism_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index c75112ee7b97..c7fade836d83 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -521,8 +521,10 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	ism->smcd = smcd_alloc_dev(&pdev->dev, dev_name(&pdev->dev), &ism_ops,
 				   ISM_NR_DMBS);
-	if (!ism->smcd)
+	if (!ism->smcd) {
+		ret = -ENOMEM;
 		goto err_resource;
+	}
 
 	ism->smcd->priv = ism;
 	ret = ism_dev_init(ism);



