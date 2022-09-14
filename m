Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2795B88A1
	for <lists+linux-s390@lfdr.de>; Wed, 14 Sep 2022 14:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiINMwi (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 14 Sep 2022 08:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiINMwh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 14 Sep 2022 08:52:37 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F347820E
        for <linux-s390@vger.kernel.org>; Wed, 14 Sep 2022 05:52:36 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MSKtv5R91zHnlw;
        Wed, 14 Sep 2022 20:50:31 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 14 Sep 2022 20:52:33 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
        <cuigaosheng1@huawei.com>
CC:     <linux-s390@vger.kernel.org>
Subject: [PATCH] s390/cio: remove unused ccw_device_force_console() declaration
Date:   Wed, 14 Sep 2022 20:52:33 +0800
Message-ID: <20220914125233.1485890-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

ccw_device_force_console() has been removed by
commit 8cc0dcfdc1c0 ("s390/cio: remove pm support from
ccw bus driver"), so remove the declaration, too.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 arch/s390/include/asm/ccwdev.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/include/asm/ccwdev.h b/arch/s390/include/asm/ccwdev.h
index d4e90f2ba77e..bd1596810cc1 100644
--- a/arch/s390/include/asm/ccwdev.h
+++ b/arch/s390/include/asm/ccwdev.h
@@ -214,7 +214,6 @@ extern struct ccw_device *ccw_device_create_console(struct ccw_driver *);
 extern void ccw_device_destroy_console(struct ccw_device *);
 extern int ccw_device_enable_console(struct ccw_device *);
 extern void ccw_device_wait_idle(struct ccw_device *);
-extern int ccw_device_force_console(struct ccw_device *);
 
 extern void *ccw_device_dma_zalloc(struct ccw_device *cdev, size_t size);
 extern void ccw_device_dma_free(struct ccw_device *cdev,
-- 
2.25.1

