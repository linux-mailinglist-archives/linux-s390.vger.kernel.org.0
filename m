Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08CA732C33
	for <lists+linux-s390@lfdr.de>; Fri, 16 Jun 2023 11:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344062AbjFPJkj (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 16 Jun 2023 05:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344154AbjFPJkD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 16 Jun 2023 05:40:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3747C2117;
        Fri, 16 Jun 2023 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686908402; x=1718444402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HcOydo8wLA/qSln+0xDpnkffMEGIG3fmLOI7pZDzYqk=;
  b=YvDhBPHT3VodXxxSn2HjEKeZr9tyXeISxD9cPZYPB8Hyf989XVjQXsyn
   dc9GkJplIWEeTZseuP96D2r+dIrVkUPf0HL09gnwGxkopOgYV9i4+F2E0
   4vh5koqene7FfKRo+NxjA57zFYZ7/X8SS8ZjdLkx/ynSoSZmryrK7FDGq
   3zRa2crq5SrBL72aC94zM5HbAgGVAmzECKaE2I3N5iKkfotnE2nlrTDso
   ipYO7lmwqDLYcymO5dHGR7JRQ0hH6PGmptO0joo3QQKUqj13cA+f4EmH1
   u9Qn2pE5vJSJrenOsDTmACIi80WyYljFywcBAXvqHFic7ob/xxx1UNEqa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361700206"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="361700206"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 02:40:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="715951065"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="715951065"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2023 02:40:00 -0700
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
Subject: [PATCH v13 06/22] vfio: Pass struct vfio_device_file * to vfio_device_open/close()
Date:   Fri, 16 Jun 2023 02:39:30 -0700
Message-Id: <20230616093946.68711-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616093946.68711-1-yi.l.liu@intel.com>
References: <20230616093946.68711-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This avoids passing too much parameters in multiple functions. Per the
input parameter change, rename the function to be vfio_df_open/close().

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Terrence Xu <terrence.xu@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Yanting Jiang <yanting.jiang@intel.com>
Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/vfio/group.c     | 20 ++++++++++++++------
 drivers/vfio/vfio.h      |  8 ++++----
 drivers/vfio/vfio_main.c | 25 +++++++++++++++----------
 3 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index b56e19d2a02d..caf53716ddb2 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -169,8 +169,9 @@ static void vfio_device_group_get_kvm_safe(struct vfio_device *device)
 	spin_unlock(&device->group->kvm_ref_lock);
 }
 
-static int vfio_device_group_open(struct vfio_device *device)
+static int vfio_df_group_open(struct vfio_device_file *df)
 {
+	struct vfio_device *device = df->device;
 	int ret;
 
 	mutex_lock(&device->group->group_lock);
@@ -190,7 +191,11 @@ static int vfio_device_group_open(struct vfio_device *device)
 	if (device->open_count == 0)
 		vfio_device_group_get_kvm_safe(device);
 
-	ret = vfio_device_open(device, device->group->iommufd);
+	df->iommufd = device->group->iommufd;
+
+	ret = vfio_df_open(df);
+	if (ret)
+		df->iommufd = NULL;
 
 	if (device->open_count == 0)
 		vfio_device_put_kvm(device);
@@ -202,12 +207,15 @@ static int vfio_device_group_open(struct vfio_device *device)
 	return ret;
 }
 
-void vfio_device_group_close(struct vfio_device *device)
+void vfio_df_group_close(struct vfio_device_file *df)
 {
+	struct vfio_device *device = df->device;
+
 	mutex_lock(&device->group->group_lock);
 	mutex_lock(&device->dev_set->lock);
 
-	vfio_device_close(device, device->group->iommufd);
+	vfio_df_close(df);
+	df->iommufd = NULL;
 
 	if (device->open_count == 0)
 		vfio_device_put_kvm(device);
@@ -228,7 +236,7 @@ static struct file *vfio_device_open_file(struct vfio_device *device)
 		goto err_out;
 	}
 
-	ret = vfio_device_group_open(device);
+	ret = vfio_df_group_open(df);
 	if (ret)
 		goto err_free;
 
@@ -260,7 +268,7 @@ static struct file *vfio_device_open_file(struct vfio_device *device)
 	return filep;
 
 err_close_device:
-	vfio_device_group_close(device);
+	vfio_df_group_close(df);
 err_free:
 	kfree(df);
 err_out:
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 332528af0846..2094f5a4ef04 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -21,13 +21,13 @@ struct vfio_device_file {
 
 	spinlock_t kvm_ref_lock; /* protect kvm field */
 	struct kvm *kvm;
+	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
 };
 
 void vfio_device_put_registration(struct vfio_device *device);
 bool vfio_device_try_get_registration(struct vfio_device *device);
-int vfio_device_open(struct vfio_device *device, struct iommufd_ctx *iommufd);
-void vfio_device_close(struct vfio_device *device,
-		       struct iommufd_ctx *iommufd);
+int vfio_df_open(struct vfio_device_file *df);
+void vfio_df_close(struct vfio_device_file *df);
 struct vfio_device_file *
 vfio_allocate_device_file(struct vfio_device *device);
 
@@ -92,7 +92,7 @@ void vfio_device_group_register(struct vfio_device *device);
 void vfio_device_group_unregister(struct vfio_device *device);
 int vfio_device_group_use_iommu(struct vfio_device *device);
 void vfio_device_group_unuse_iommu(struct vfio_device *device);
-void vfio_device_group_close(struct vfio_device *device);
+void vfio_df_group_close(struct vfio_device_file *df);
 struct vfio_group *vfio_group_from_file(struct file *file);
 bool vfio_group_enforced_coherent(struct vfio_group *group);
 void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm);
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 8ef9210ad2aa..825b1eeaebe2 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -434,9 +434,10 @@ vfio_allocate_device_file(struct vfio_device *device)
 	return df;
 }
 
-static int vfio_device_first_open(struct vfio_device *device,
-				  struct iommufd_ctx *iommufd)
+static int vfio_df_device_first_open(struct vfio_device_file *df)
 {
+	struct vfio_device *device = df->device;
+	struct iommufd_ctx *iommufd = df->iommufd;
 	int ret;
 
 	lockdep_assert_held(&device->dev_set->lock);
@@ -468,9 +469,11 @@ static int vfio_device_first_open(struct vfio_device *device,
 	return ret;
 }
 
-static void vfio_device_last_close(struct vfio_device *device,
-				   struct iommufd_ctx *iommufd)
+static void vfio_df_device_last_close(struct vfio_device_file *df)
 {
+	struct vfio_device *device = df->device;
+	struct iommufd_ctx *iommufd = df->iommufd;
+
 	lockdep_assert_held(&device->dev_set->lock);
 
 	if (device->ops->close_device)
@@ -482,15 +485,16 @@ static void vfio_device_last_close(struct vfio_device *device,
 	module_put(device->dev->driver->owner);
 }
 
-int vfio_device_open(struct vfio_device *device, struct iommufd_ctx *iommufd)
+int vfio_df_open(struct vfio_device_file *df)
 {
+	struct vfio_device *device = df->device;
 	int ret = 0;
 
 	lockdep_assert_held(&device->dev_set->lock);
 
 	device->open_count++;
 	if (device->open_count == 1) {
-		ret = vfio_device_first_open(device, iommufd);
+		ret = vfio_df_device_first_open(df);
 		if (ret)
 			device->open_count--;
 	}
@@ -498,14 +502,15 @@ int vfio_device_open(struct vfio_device *device, struct iommufd_ctx *iommufd)
 	return ret;
 }
 
-void vfio_device_close(struct vfio_device *device,
-		       struct iommufd_ctx *iommufd)
+void vfio_df_close(struct vfio_device_file *df)
 {
+	struct vfio_device *device = df->device;
+
 	lockdep_assert_held(&device->dev_set->lock);
 
 	vfio_assert_device_open(device);
 	if (device->open_count == 1)
-		vfio_device_last_close(device, iommufd);
+		vfio_df_device_last_close(df);
 	device->open_count--;
 }
 
@@ -550,7 +555,7 @@ static int vfio_device_fops_release(struct inode *inode, struct file *filep)
 	struct vfio_device_file *df = filep->private_data;
 	struct vfio_device *device = df->device;
 
-	vfio_device_group_close(device);
+	vfio_df_group_close(df);
 
 	vfio_device_put_registration(device);
 
-- 
2.34.1

