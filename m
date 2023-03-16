Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2848E6BD011
	for <lists+linux-s390@lfdr.de>; Thu, 16 Mar 2023 13:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCPM4A (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 16 Mar 2023 08:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjCPMzw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Mar 2023 08:55:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF7641B45;
        Thu, 16 Mar 2023 05:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678971347; x=1710507347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5i23gf1h+ciV9B2md2GWX21OpBSs+D0W7WGB4SrBDec=;
  b=DTrpw/S0XhSPzyCIv2U615/Fvubib+rX2eid4vJkb2A4qjx6US30jXp+
   crPSKxP93/X8iksxAIkfvkxsA4H3ufxVZpx7511lee+JRpvVt40V3+73Y
   ns31gKZNDsR/KTmBuP1JiWTHhEVTNHD2Tmtp4gDFyRC3kLk7WYO6ldBkM
   R6+/ng+M07T944WmWZIkUYcv3Qz81dySZMkjRwmPuy8Q1lWnMmUBcS4gF
   kQpsDQ9s1TGiJvQGS/5X8HatI7NM/VySzWOEaXpl1xfkTqO/PkOZ3hsMJ
   NMF3G43uDrW/Ij/2B5jD3pjUSIT0qS9/izgo8bHlY58haapZtpgWAZkcq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10650"; a="336668032"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="336668032"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 05:55:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10650"; a="790277768"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="790277768"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 16 Mar 2023 05:55:43 -0700
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
        xudong.hao@intel.com, yan.y.zhao@intel.com, terrence.xu@intel.com
Subject: [PATCH v7 05/22] kvm/vfio: Rename kvm_vfio_group to prepare for accepting vfio device fd
Date:   Thu, 16 Mar 2023 05:55:17 -0700
Message-Id: <20230316125534.17216-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316125534.17216-1-yi.l.liu@intel.com>
References: <20230316125534.17216-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Meanwhile, rename related helpers. No functional change is intended.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Terrence Xu <terrence.xu@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 virt/kvm/vfio.c | 115 ++++++++++++++++++++++++------------------------
 1 file changed, 58 insertions(+), 57 deletions(-)

diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 8bac308ba630..857d6ba349e1 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -21,7 +21,7 @@
 #include <asm/kvm_ppc.h>
 #endif
 
-struct kvm_vfio_group {
+struct kvm_vfio_file {
 	struct list_head node;
 	struct file *file;
 #ifdef CONFIG_SPAPR_TCE_IOMMU
@@ -30,7 +30,7 @@ struct kvm_vfio_group {
 };
 
 struct kvm_vfio {
-	struct list_head group_list;
+	struct list_head file_list;
 	struct mutex lock;
 	bool noncoherent;
 };
@@ -98,34 +98,35 @@ static struct iommu_group *kvm_vfio_file_iommu_group(struct file *file)
 }
 
 static void kvm_spapr_tce_release_vfio_group(struct kvm *kvm,
-					     struct kvm_vfio_group *kvg)
+					     struct kvm_vfio_file *kvf)
 {
-	if (WARN_ON_ONCE(!kvg->iommu_group))
+	if (WARN_ON_ONCE(!kvf->iommu_group))
 		return;
 
-	kvm_spapr_tce_release_iommu_group(kvm, kvg->iommu_group);
-	iommu_group_put(kvg->iommu_group);
-	kvg->iommu_group = NULL;
+	kvm_spapr_tce_release_iommu_group(kvm, kvf->iommu_group);
+	iommu_group_put(kvf->iommu_group);
+	kvf->iommu_group = NULL;
 }
 #endif
 
 /*
- * Groups can use the same or different IOMMU domains.  If the same then
- * adding a new group may change the coherency of groups we've previously
- * been told about.  We don't want to care about any of that so we retest
- * each group and bail as soon as we find one that's noncoherent.  This
- * means we only ever [un]register_noncoherent_dma once for the whole device.
+ * Groups/devices can use the same or different IOMMU domains. If the same
+ * then adding a new group/device may change the coherency of groups/devices
+ * we've previously been told about. We don't want to care about any of
+ * that so we retest each group/device and bail as soon as we find one that's
+ * noncoherent.  This means we only ever [un]register_noncoherent_dma once
+ * for the whole device.
  */
 static void kvm_vfio_update_coherency(struct kvm_device *dev)
 {
 	struct kvm_vfio *kv = dev->private;
 	bool noncoherent = false;
-	struct kvm_vfio_group *kvg;
+	struct kvm_vfio_file *kvf;
 
 	mutex_lock(&kv->lock);
 
-	list_for_each_entry(kvg, &kv->group_list, node) {
-		if (!kvm_vfio_file_enforced_coherent(kvg->file)) {
+	list_for_each_entry(kvf, &kv->file_list, node) {
+		if (!kvm_vfio_file_enforced_coherent(kvf->file)) {
 			noncoherent = true;
 			break;
 		}
@@ -143,10 +144,10 @@ static void kvm_vfio_update_coherency(struct kvm_device *dev)
 	mutex_unlock(&kv->lock);
 }
 
-static int kvm_vfio_group_add(struct kvm_device *dev, unsigned int fd)
+static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
 {
 	struct kvm_vfio *kv = dev->private;
-	struct kvm_vfio_group *kvg;
+	struct kvm_vfio_file *kvf;
 	struct file *filp;
 	int ret;
 
@@ -162,27 +163,27 @@ static int kvm_vfio_group_add(struct kvm_device *dev, unsigned int fd)
 
 	mutex_lock(&kv->lock);
 
-	list_for_each_entry(kvg, &kv->group_list, node) {
-		if (kvg->file == filp) {
+	list_for_each_entry(kvf, &kv->file_list, node) {
+		if (kvf->file == filp) {
 			ret = -EEXIST;
 			goto err_unlock;
 		}
 	}
 
-	kvg = kzalloc(sizeof(*kvg), GFP_KERNEL_ACCOUNT);
-	if (!kvg) {
+	kvf = kzalloc(sizeof(*kvf), GFP_KERNEL_ACCOUNT);
+	if (!kvf) {
 		ret = -ENOMEM;
 		goto err_unlock;
 	}
 
-	kvg->file = filp;
-	list_add_tail(&kvg->node, &kv->group_list);
+	kvf->file = filp;
+	list_add_tail(&kvf->node, &kv->file_list);
 
 	kvm_arch_start_assignment(dev->kvm);
 
 	mutex_unlock(&kv->lock);
 
-	kvm_vfio_file_set_kvm(kvg->file, dev->kvm);
+	kvm_vfio_file_set_kvm(kvf->file, dev->kvm);
 	kvm_vfio_update_coherency(dev);
 
 	return 0;
@@ -193,10 +194,10 @@ static int kvm_vfio_group_add(struct kvm_device *dev, unsigned int fd)
 	return ret;
 }
 
-static int kvm_vfio_group_del(struct kvm_device *dev, unsigned int fd)
+static int kvm_vfio_file_del(struct kvm_device *dev, unsigned int fd)
 {
 	struct kvm_vfio *kv = dev->private;
-	struct kvm_vfio_group *kvg;
+	struct kvm_vfio_file *kvf;
 	struct fd f;
 	int ret;
 
@@ -208,18 +209,18 @@ static int kvm_vfio_group_del(struct kvm_device *dev, unsigned int fd)
 
 	mutex_lock(&kv->lock);
 
-	list_for_each_entry(kvg, &kv->group_list, node) {
-		if (kvg->file != f.file)
+	list_for_each_entry(kvf, &kv->file_list, node) {
+		if (kvf->file != f.file)
 			continue;
 
-		list_del(&kvg->node);
+		list_del(&kvf->node);
 		kvm_arch_end_assignment(dev->kvm);
 #ifdef CONFIG_SPAPR_TCE_IOMMU
-		kvm_spapr_tce_release_vfio_group(dev->kvm, kvg);
+		kvm_spapr_tce_release_vfio_group(dev->kvm, kvf);
 #endif
-		kvm_vfio_file_set_kvm(kvg->file, NULL);
-		fput(kvg->file);
-		kfree(kvg);
+		kvm_vfio_file_set_kvm(kvf->file, NULL);
+		fput(kvf->file);
+		kfree(kvf);
 		ret = 0;
 		break;
 	}
@@ -234,12 +235,12 @@ static int kvm_vfio_group_del(struct kvm_device *dev, unsigned int fd)
 }
 
 #ifdef CONFIG_SPAPR_TCE_IOMMU
-static int kvm_vfio_group_set_spapr_tce(struct kvm_device *dev,
-					void __user *arg)
+static int kvm_vfio_file_set_spapr_tce(struct kvm_device *dev,
+				       void __user *arg)
 {
 	struct kvm_vfio_spapr_tce param;
 	struct kvm_vfio *kv = dev->private;
-	struct kvm_vfio_group *kvg;
+	struct kvm_vfio_file *kvf;
 	struct fd f;
 	int ret;
 
@@ -254,20 +255,20 @@ static int kvm_vfio_group_set_spapr_tce(struct kvm_device *dev,
 
 	mutex_lock(&kv->lock);
 
-	list_for_each_entry(kvg, &kv->group_list, node) {
-		if (kvg->file != f.file)
+	list_for_each_entry(kvf, &kv->file_list, node) {
+		if (kvf->file != f.file)
 			continue;
 
-		if (!kvg->iommu_group) {
-			kvg->iommu_group = kvm_vfio_file_iommu_group(kvg->file);
-			if (WARN_ON_ONCE(!kvg->iommu_group)) {
+		if (!kvf->iommu_group) {
+			kvf->iommu_group = kvm_vfio_file_iommu_group(kvf->file);
+			if (WARN_ON_ONCE(!kvf->iommu_group)) {
 				ret = -EIO;
 				goto err_fdput;
 			}
 		}
 
 		ret = kvm_spapr_tce_attach_iommu_group(dev->kvm, param.tablefd,
-						       kvg->iommu_group);
+						       kvf->iommu_group);
 		break;
 	}
 
@@ -278,8 +279,8 @@ static int kvm_vfio_group_set_spapr_tce(struct kvm_device *dev,
 }
 #endif
 
-static int kvm_vfio_set_group(struct kvm_device *dev, long attr,
-			      void __user *arg)
+static int kvm_vfio_set_file(struct kvm_device *dev, long attr,
+			     void __user *arg)
 {
 	int32_t __user *argp = arg;
 	int32_t fd;
@@ -288,16 +289,16 @@ static int kvm_vfio_set_group(struct kvm_device *dev, long attr,
 	case KVM_DEV_VFIO_GROUP_ADD:
 		if (get_user(fd, argp))
 			return -EFAULT;
-		return kvm_vfio_group_add(dev, fd);
+		return kvm_vfio_file_add(dev, fd);
 
 	case KVM_DEV_VFIO_GROUP_DEL:
 		if (get_user(fd, argp))
 			return -EFAULT;
-		return kvm_vfio_group_del(dev, fd);
+		return kvm_vfio_file_del(dev, fd);
 
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 	case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE:
-		return kvm_vfio_group_set_spapr_tce(dev, arg);
+		return kvm_vfio_file_set_spapr_tce(dev, arg);
 #endif
 	}
 
@@ -309,8 +310,8 @@ static int kvm_vfio_set_attr(struct kvm_device *dev,
 {
 	switch (attr->group) {
 	case KVM_DEV_VFIO_GROUP:
-		return kvm_vfio_set_group(dev, attr->attr,
-					  u64_to_user_ptr(attr->addr));
+		return kvm_vfio_set_file(dev, attr->attr,
+					 u64_to_user_ptr(attr->addr));
 	}
 
 	return -ENXIO;
@@ -339,16 +340,16 @@ static int kvm_vfio_has_attr(struct kvm_device *dev,
 static void kvm_vfio_release(struct kvm_device *dev)
 {
 	struct kvm_vfio *kv = dev->private;
-	struct kvm_vfio_group *kvg, *tmp;
+	struct kvm_vfio_file *kvf, *tmp;
 
-	list_for_each_entry_safe(kvg, tmp, &kv->group_list, node) {
+	list_for_each_entry_safe(kvf, tmp, &kv->file_list, node) {
 #ifdef CONFIG_SPAPR_TCE_IOMMU
-		kvm_spapr_tce_release_vfio_group(dev->kvm, kvg);
+		kvm_spapr_tce_release_vfio_group(dev->kvm, kvf);
 #endif
-		kvm_vfio_file_set_kvm(kvg->file, NULL);
-		fput(kvg->file);
-		list_del(&kvg->node);
-		kfree(kvg);
+		kvm_vfio_file_set_kvm(kvf->file, NULL);
+		fput(kvf->file);
+		list_del(&kvf->node);
+		kfree(kvf);
 		kvm_arch_end_assignment(dev->kvm);
 	}
 
@@ -382,7 +383,7 @@ static int kvm_vfio_create(struct kvm_device *dev, u32 type)
 	if (!kv)
 		return -ENOMEM;
 
-	INIT_LIST_HEAD(&kv->group_list);
+	INIT_LIST_HEAD(&kv->file_list);
 	mutex_init(&kv->lock);
 
 	dev->private = kv;
-- 
2.34.1

