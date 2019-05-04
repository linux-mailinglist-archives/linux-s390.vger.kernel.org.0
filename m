Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21BD1137D5
	for <lists+linux-s390@lfdr.de>; Sat,  4 May 2019 08:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfEDGmK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 4 May 2019 02:42:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbfEDGmK (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 4 May 2019 02:42:10 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 086F3EAAFBB6FF155F08;
        Sat,  4 May 2019 14:42:07 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Sat, 4 May 2019 14:41:59 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Heiko Carstens" <heiko.carstens@de.ibm.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-s390@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] KVM: s390: fix typo in parameter description
Date:   Sat, 4 May 2019 06:51:45 +0000
Message-ID: <20190504065145.53665-1-weiyongjun1@huawei.com>
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

Fix typo in parameter description.

Fixes: 8b905d28ee17 ("KVM: s390: provide kvm_arch_no_poll function")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8d6d75db8de6..ac6163c334d6 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -181,7 +181,7 @@ MODULE_PARM_DESC(hpage, "1m huge page backing support");
 /* maximum percentage of steal time for polling.  >100 is treated like 100 */
 static u8 halt_poll_max_steal = 10;
 module_param(halt_poll_max_steal, byte, 0644);
-MODULE_PARM_DESC(hpage, "Maximum percentage of steal time to allow polling");
+MODULE_PARM_DESC(halt_poll_max_steal, "Maximum percentage of steal time to allow polling");
 
 /*
  * For now we handle at most 16 double words as this is what the s390 base



