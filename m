Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7922327DE9
	for <lists+linux-s390@lfdr.de>; Mon,  1 Mar 2021 13:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhCAMJr (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 1 Mar 2021 07:09:47 -0500
Received: from mail-m121143.qiye.163.com ([115.236.121.143]:39082 "EHLO
        mail-m121143.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbhCAMJq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Mar 2021 07:09:46 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m121143.qiye.163.com (Hmail) with ESMTPA id E18C854023A;
        Mon,  1 Mar 2021 20:08:57 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] s390: crypto: Return -EFAULT if copy_to_user() fails
Date:   Mon,  1 Mar 2021 20:08:21 +0800
Message-Id: <1614600502-16714-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0tLHk9CHkhOT0sfVkpNSk9NS0tOSENITkpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kxw6KAw4Qz8TORA4HhoTE08B
        FT5PFDxVSlVKTUpPTUtLTkhDTUJKVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFJS0pPNwY+
X-HM-Tid: 0a77edb1089bb038kuuue18c854023a
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The copy_to_user() function returns the number of bytes remaining to be
copied, but we want to return -EFAULT if the copy doesn't complete.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 41fc2e413..1ffdd41
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1286,7 +1286,7 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
 	info.num_regions = 0;
 	info.num_irqs = 0;
 
-	return copy_to_user((void __user *)arg, &info, minsz);
+	return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
 }
 
 static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
-- 
2.7.4

