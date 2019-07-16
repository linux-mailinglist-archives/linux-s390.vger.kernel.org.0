Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E00FC6A639
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jul 2019 12:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbfGPKJ2 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 16 Jul 2019 06:09:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25847 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732475AbfGPKJ2 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jul 2019 06:09:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A3741300CB25;
        Tue, 16 Jul 2019 10:09:27 +0000 (UTC)
Received: from localhost (ovpn-117-180.ams2.redhat.com [10.36.117.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E33745E7A8;
        Tue, 16 Jul 2019 10:09:25 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Farhan Ali <alifm@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 5/5] vfio-ccw: Update documentation for csch/hsch
Date:   Tue, 16 Jul 2019 12:09:08 +0200
Message-Id: <20190716100908.3460-6-cohuck@redhat.com>
In-Reply-To: <20190716100908.3460-1-cohuck@redhat.com>
References: <20190716100908.3460-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 16 Jul 2019 10:09:27 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Farhan Ali <alifm@linux.ibm.com>

We now support CLEAR SUBCHANNEL and HALT SUBCHANNEL
via ccw_cmd_region.

Fixes: d5afd5d135c8 ("vfio-ccw: add handling for async channel instructions")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Message-Id: <7d977612c3f3152ffb950d77ae11b4b25c1e20c4.1562854091.git.alifm@linux.ibm.com>
[CH: properly mark region as literal block]
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 Documentation/s390/vfio-ccw.rst | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-ccw.rst
index 1f6d0b56d53e..be2af10e12b4 100644
--- a/Documentation/s390/vfio-ccw.rst
+++ b/Documentation/s390/vfio-ccw.rst
@@ -180,6 +180,13 @@ The process of how these work together.
    add it to an iommu_group and a vfio_group. Then we could pass through
    the mdev to a guest.
 
+
+VFIO-CCW Regions
+----------------
+
+The vfio-ccw driver exposes MMIO regions to accept requests from and return
+results to userspace.
+
 vfio-ccw I/O region
 -------------------
 
@@ -205,6 +212,25 @@ irb_area stores the I/O result.
 
 ret_code stores a return code for each access of the region.
 
+This region is always available.
+
+vfio-ccw cmd region
+-------------------
+
+The vfio-ccw cmd region is used to accept asynchronous instructions
+from userspace.
+
+#define VFIO_CCW_ASYNC_CMD_HSCH (1 << 0)
+#define VFIO_CCW_ASYNC_CMD_CSCH (1 << 1)
+struct ccw_cmd_region {
+       __u32 command;
+       __u32 ret_code;
+} __packed;
+
+This region is exposed via region type VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD.
+
+Currently, CLEAR SUBCHANNEL and HALT SUBCHANNEL use this region.
+
 vfio-ccw operation details
 --------------------------
 
@@ -306,9 +332,8 @@ Together with the corresponding work in QEMU, we can bring the passed
 through DASD/ECKD device online in a guest now and use it as a block
 device.
 
-While the current code allows the guest to start channel programs via
-START SUBCHANNEL, support for HALT SUBCHANNEL or CLEAR SUBCHANNEL is
-not yet implemented.
+The current code allows the guest to start channel programs via
+START SUBCHANNEL, and to issue HALT SUBCHANNEL and CLEAR SUBCHANNEL.
 
 vfio-ccw supports classic (command mode) channel I/O only. Transport
 mode (HPF) is not supported.
-- 
2.20.1

