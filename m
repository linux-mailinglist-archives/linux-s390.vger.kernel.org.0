Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30531565621
	for <lists+linux-s390@lfdr.de>; Mon,  4 Jul 2022 14:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbiGDMwx (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 4 Jul 2022 08:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbiGDMwU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Jul 2022 08:52:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FC511C34;
        Mon,  4 Jul 2022 05:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0i80iHHZM5WvEuDaxP2iTUgBnHLdzUS4WjppCqPjzCE=; b=bU6xBLUv1HxwRXgSb7P1JxAGG6
        IjQns3q/Q+J5aIkIcmjgQKIPRwFQKSgqo9bqQEyC2EAesjc6ThZqJhsPoO1R8869Ot5MO6vn6AhOj
        G5jWtMXrroAq7TTNn4HCsEj9H8I7A+jZfKF4XLs6X5x3yLxoE1+MsEXtq+izVZr6MTZkJC2MVoeks
        Gm0uACNrH0EqJGGFHHhivxgGcBNad38xsVJUdb9pIuwE0LP1LtOQoTzlxiIXk7T3NMC32mVcHp1CB
        /qORsWF4V2YmKgH7Mhk4eFyF6zaiQweB9VZubKidCh8AmksjEd83+Id83p8nRJMhzBJy5Gmcai/Is
        iZgrZ8UA==;
Received: from [2001:4bb8:189:3c4a:8758:74d9:4df6:6417] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8LYg-008wWZ-8I; Mon, 04 Jul 2022 12:52:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Kirti Wankhede <kwankhede@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH 08/14] vfio/mdev: remove mdev_parent_dev
Date:   Mon,  4 Jul 2022 14:51:38 +0200
Message-Id: <20220704125144.157288-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704125144.157288-1-hch@lst.de>
References: <20220704125144.157288-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Just open code the dereferences in the only user.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Kirti Wankhede <kwankhede@nvidia.com>
---
 Documentation/driver-api/vfio-mediated-device.rst | 3 ---
 drivers/gpu/drm/i915/gvt/kvmgt.c                  | 2 +-
 drivers/vfio/mdev/mdev_core.c                     | 6 ------
 include/linux/mdev.h                              | 1 -
 4 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/Documentation/driver-api/vfio-mediated-device.rst b/Documentation/driver-api/vfio-mediated-device.rst
index 82a4007bd7207..a4c3a4a168ec6 100644
--- a/Documentation/driver-api/vfio-mediated-device.rst
+++ b/Documentation/driver-api/vfio-mediated-device.rst
@@ -202,9 +202,6 @@ Directories and files under the sysfs for Each Physical Device
 
 	sprintf(buf, "%s-%s", dev_driver_string(parent->dev), group->name);
 
-  (or using mdev_parent_dev(mdev) to arrive at the parent device outside
-  of the core mdev code)
-
 * device_api
 
   This attribute should show which device API is being created, for example,
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index ead56e4d30650..3473d4bafd61e 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1549,7 +1549,7 @@ static const struct vfio_device_ops intel_vgpu_dev_ops = {
 
 static int intel_vgpu_probe(struct mdev_device *mdev)
 {
-	struct device *pdev = mdev_parent_dev(mdev);
+	struct device *pdev = mdev->type->parent->dev;
 	struct intel_gvt *gvt = kdev_to_i915(pdev)->gvt;
 	struct intel_vgpu_type *type =
 		container_of(mdev->type, struct intel_vgpu_type, type);
diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index bde7ce620dae0..75628759a3bf0 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -23,12 +23,6 @@ static struct class_compat *mdev_bus_compat_class;
 static LIST_HEAD(mdev_list);
 static DEFINE_MUTEX(mdev_list_lock);
 
-struct device *mdev_parent_dev(struct mdev_device *mdev)
-{
-	return mdev->type->parent->dev;
-}
-EXPORT_SYMBOL(mdev_parent_dev);
-
 /*
  * Used in mdev_type_attribute sysfs functions to return the parent struct
  * device
diff --git a/include/linux/mdev.h b/include/linux/mdev.h
index 2ca85b6072b9e..186e5c866871e 100644
--- a/include/linux/mdev.h
+++ b/include/linux/mdev.h
@@ -100,7 +100,6 @@ void mdev_unregister_parent(struct mdev_parent *parent);
 int mdev_register_driver(struct mdev_driver *drv);
 void mdev_unregister_driver(struct mdev_driver *drv);
 
-struct device *mdev_parent_dev(struct mdev_device *mdev);
 static inline struct device *mdev_dev(struct mdev_device *mdev)
 {
 	return &mdev->dev;
-- 
2.30.2

