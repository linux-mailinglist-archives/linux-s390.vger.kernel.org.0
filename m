Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50017201BC
	for <lists+linux-s390@lfdr.de>; Fri,  2 Jun 2023 14:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbjFBMR2 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 2 Jun 2023 08:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbjFBMRR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Jun 2023 08:17:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FE71AE;
        Fri,  2 Jun 2023 05:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685708235; x=1717244235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bk8KB40aXNxkLMBLjR3bUDooNgsfPwAc0pvhL0SzSqM=;
  b=oGsippBfuADZL/oNeG97FgfZ01XKKERJbZDJuREXveasQF3NEBqjBSQp
   Qi5s9t+de7atjGHWlVcprydgyGTWjW0Iz9tmTVNf9HTKVnaEJHSHgOYaH
   DzTQxmQvaOnxYuW6rn7LjFGVpwiBmf4SVUuU+z6sJQhSmvt6SpbJCm1R/
   wDObkWAysQdO4PUS/c0n58ZP5WZYJP/u/A6cuZmbGDdSVkQ57bMKqOWdF
   3kYbhJ8FFmEF5uveMCIs9yovB/IYY6OFDvB0d0QGbjbNSS5T2Csqx5whw
   o+oD02+7rlS47Waftbr8BM0RU+hAsu700H5J0P9VN4gXwCDHYIgAmrkRS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="384136589"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="384136589"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 05:17:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="1037947327"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="1037947327"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga005.fm.intel.com with ESMTP; 02 Jun 2023 05:17:07 -0700
From:   Yi Liu <yi.l.liu@intel.com>
To:     alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com
Cc:     joro@8bytes.org, robin.murphy@arm.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.l.liu@intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
        jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com,
        lulu@redhat.com, suravee.suthikulpanit@amd.com,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        xudong.hao@intel.com, yan.y.zhao@intel.com, terrence.xu@intel.com,
        yanting.jiang@intel.com, zhenzhong.duan@intel.com,
        clegoate@redhat.com
Subject: [PATCH v12 10/24] vfio-iommufd: Move noiommu compat validation out of vfio_iommufd_bind()
Date:   Fri,  2 Jun 2023 05:16:39 -0700
Message-Id: <20230602121653.80017-11-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602121653.80017-1-yi.l.liu@intel.com>
References: <20230602121653.80017-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This moves the noiommu compat validation logic into vfio_df_group_open().
This is more consistent with what will be done in vfio device cdev path.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Terrence Xu <terrence.xu@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Yanting Jiang <yanting.jiang@intel.com>
Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/vfio/group.c   | 13 +++++++++++++
 drivers/vfio/iommufd.c | 22 ++++++++--------------
 drivers/vfio/vfio.h    |  9 +++++++++
 3 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 4e6277191eb4..b8b77daf7aa6 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -192,6 +192,19 @@ static int vfio_df_group_open(struct vfio_device_file *df)
 		vfio_device_group_get_kvm_safe(device);
 
 	df->iommufd = device->group->iommufd;
+	if (df->iommufd && vfio_device_is_noiommu(device) && device->open_count == 0) {
+		/*
+		 * Require no compat ioas to be assigned to proceed.  The basic
+		 * statement is that the user cannot have done something that
+		 * implies they expected translation to exist
+		 */
+		if (!capable(CAP_SYS_RAWIO) ||
+		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd))
+			ret = -EPERM;
+		else
+			ret = 0;
+		goto out_put_kvm;
+	}
 
 	ret = vfio_df_open(df);
 	if (ret) {
diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index a04f3a493437..21237f5d0ffc 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -10,6 +10,14 @@
 MODULE_IMPORT_NS(IOMMUFD);
 MODULE_IMPORT_NS(IOMMUFD_VFIO);
 
+bool vfio_iommufd_device_has_compat_ioas(struct vfio_device *vdev,
+					 struct iommufd_ctx *ictx)
+{
+	u32 ioas_id;
+
+	return !iommufd_vfio_compat_ioas_get_id(ictx, &ioas_id);
+}
+
 int vfio_iommufd_bind(struct vfio_device *vdev, struct iommufd_ctx *ictx)
 {
 	u32 ioas_id;
@@ -18,20 +26,6 @@ int vfio_iommufd_bind(struct vfio_device *vdev, struct iommufd_ctx *ictx)
 
 	lockdep_assert_held(&vdev->dev_set->lock);
 
-	if (vfio_device_is_noiommu(vdev)) {
-		if (!capable(CAP_SYS_RAWIO))
-			return -EPERM;
-
-		/*
-		 * Require no compat ioas to be assigned to proceed. The basic
-		 * statement is that the user cannot have done something that
-		 * implies they expected translation to exist
-		 */
-		if (!iommufd_vfio_compat_ioas_get_id(ictx, &ioas_id))
-			return -EPERM;
-		return 0;
-	}
-
 	ret = vdev->ops->bind_iommufd(vdev, ictx, &device_id);
 	if (ret)
 		return ret;
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 86e45ba18768..76181d208bc1 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -234,9 +234,18 @@ static inline void vfio_container_cleanup(void)
 #endif
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
+bool vfio_iommufd_device_has_compat_ioas(struct vfio_device *vdev,
+					 struct iommufd_ctx *ictx);
 int vfio_iommufd_bind(struct vfio_device *device, struct iommufd_ctx *ictx);
 void vfio_iommufd_unbind(struct vfio_device *device);
 #else
+static inline bool
+vfio_iommufd_device_has_compat_ioas(struct vfio_device *vdev,
+				    struct iommufd_ctx *ictx)
+{
+	return false;
+}
+
 static inline int vfio_iommufd_bind(struct vfio_device *device,
 				    struct iommufd_ctx *ictx)
 {
-- 
2.34.1

