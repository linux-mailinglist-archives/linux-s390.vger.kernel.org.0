Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FE152C589
	for <lists+linux-s390@lfdr.de>; Wed, 18 May 2022 23:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242511AbiERV0h (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 18 May 2022 17:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243060AbiERV0g (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 May 2022 17:26:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66473B013;
        Wed, 18 May 2022 14:26:33 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ILCEFc025644;
        Wed, 18 May 2022 21:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0OoZR7YW3JYuhk9QoOit9EnNS3V8lt2qJkg0/GdM4xQ=;
 b=V5+WWV4VZdMR3UqOKBQ2TM3QcBrpWjIZfUfoeercazTkjSb/MkhTkUUJjTxpz3dRyAT/
 SAveW7N0AXOEvcy1qUy6QUqPWZuK8WsZuCZDjppb+Ne+8tN9gISTm/Azmk0rI34dEUMk
 l6S/JH1z372hUnDRU7ALXeTCrqHeLKm2CnDT/e/nDNIy4g+TvDE5nbjLEqRvShOB6M8Z
 J1qSydAmSuUfBhrkEf6Y169G9++kMhYgLa7F7mNqL/1kScA/Fm3njHnBr/YyAYp7X3JY
 0HS5X8lYNaJeVrW3PlxWi6NOuk78raCA3rdPVdhcDEHIwgkLgFLjqvOQLCX/N+wPmlUw CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g58ghr830-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 21:26:24 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24ILE20P032367;
        Wed, 18 May 2022 21:26:23 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g58ghr82d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 21:26:23 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24IL2eMH001514;
        Wed, 18 May 2022 21:26:22 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 3g4wp5bwpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 21:26:22 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24ILQLD020316558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 21:26:21 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 515D12805C;
        Wed, 18 May 2022 21:26:21 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2AD228060;
        Wed, 18 May 2022 21:26:17 +0000 (GMT)
Received: from li-c92d2ccc-254b-11b2-a85c-a700b5bfb098.ibm.com.com (unknown [9.211.37.97])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 18 May 2022 21:26:17 +0000 (GMT)
From:   Matthew Rosato <mjrosato@linux.ibm.com>
To:     jgg@nvidia.com, alex.williamson@redhat.com
Cc:     cohuck@redhat.com, borntraeger@linux.ibm.com,
        jjherne@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com, hch@infradead.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] vfio: remove VFIO_GROUP_NOTIFY_SET_KVM
Date:   Wed, 18 May 2022 17:26:07 -0400
Message-Id: <20220518212607.467538-2-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220518212607.467538-1-mjrosato@linux.ibm.com>
References: <20220518212607.467538-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cZO__lhE0imUZpN5c1Hx-Vu5D1daExeo
X-Proofpoint-GUID: 9lsdZ9dN5tmxflXtdgDSh2dP_DIeYHA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=831 mlxscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205180121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Rather than relying on a notifier for associating the KVM with
the group, let's assume that the association has already been
made prior to device_open.  The first time a device is opened
associate the group KVM with the device.

This fixes a user-triggerable oops in GVT.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/gpu/drm/i915/gvt/gtt.c        |  4 +-
 drivers/gpu/drm/i915/gvt/gvt.h        |  3 -
 drivers/gpu/drm/i915/gvt/kvmgt.c      | 82 ++++++---------------------
 drivers/s390/crypto/vfio_ap_ops.c     | 38 ++++---------
 drivers/s390/crypto/vfio_ap_private.h |  3 -
 drivers/vfio/vfio.c                   | 75 ++++++++----------------
 include/linux/vfio.h                  |  5 +-
 7 files changed, 56 insertions(+), 154 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 9c5cc2800975..b4f69364f9a1 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -51,7 +51,7 @@ static int preallocated_oos_pages = 8192;
 
 static bool intel_gvt_is_valid_gfn(struct intel_vgpu *vgpu, unsigned long gfn)
 {
-	struct kvm *kvm = vgpu->kvm;
+	struct kvm *kvm = vgpu->vfio_device.kvm;
 	int idx;
 	bool ret;
 
@@ -1185,7 +1185,7 @@ static int is_2MB_gtt_possible(struct intel_vgpu *vgpu,
 
 	if (!vgpu->attached)
 		return -EINVAL;
-	pfn = gfn_to_pfn(vgpu->kvm, ops->get_pfn(entry));
+	pfn = gfn_to_pfn(vgpu->vfio_device.kvm, ops->get_pfn(entry));
 	if (is_error_noslot_pfn(pfn))
 		return -EINVAL;
 	return PageTransHuge(pfn_to_page(pfn));
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index 2af4c83e733c..aee1a45da74b 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -227,9 +227,6 @@ struct intel_vgpu {
 	struct mutex cache_lock;
 
 	struct notifier_block iommu_notifier;
-	struct notifier_block group_notifier;
-	struct kvm *kvm;
-	struct work_struct release_work;
 	atomic_t released;
 
 	struct kvm_page_track_notifier_node track_node;
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 7655ffa97d51..e2f6c56ab342 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -228,8 +228,6 @@ static void intel_gvt_cleanup_vgpu_type_groups(struct intel_gvt *gvt)
 	}
 }
 
-static void intel_vgpu_release_work(struct work_struct *work);
-
 static void gvt_unpin_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
 		unsigned long size)
 {
@@ -761,23 +759,6 @@ static int intel_vgpu_iommu_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static int intel_vgpu_group_notifier(struct notifier_block *nb,
-				     unsigned long action, void *data)
-{
-	struct intel_vgpu *vgpu =
-		container_of(nb, struct intel_vgpu, group_notifier);
-
-	/* the only action we care about */
-	if (action == VFIO_GROUP_NOTIFY_SET_KVM) {
-		vgpu->kvm = data;
-
-		if (!data)
-			schedule_work(&vgpu->release_work);
-	}
-
-	return NOTIFY_OK;
-}
-
 static bool __kvmgt_vgpu_exist(struct intel_vgpu *vgpu)
 {
 	struct intel_vgpu *itr;
@@ -789,7 +770,7 @@ static bool __kvmgt_vgpu_exist(struct intel_vgpu *vgpu)
 		if (!itr->attached)
 			continue;
 
-		if (vgpu->kvm == itr->kvm) {
+		if (vgpu->vfio_device.kvm == itr->vfio_device.kvm) {
 			ret = true;
 			goto out;
 		}
@@ -806,7 +787,6 @@ static int intel_vgpu_open_device(struct vfio_device *vfio_dev)
 	int ret;
 
 	vgpu->iommu_notifier.notifier_call = intel_vgpu_iommu_notifier;
-	vgpu->group_notifier.notifier_call = intel_vgpu_group_notifier;
 
 	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
 	ret = vfio_register_notifier(vfio_dev, VFIO_IOMMU_NOTIFY, &events,
@@ -817,38 +797,32 @@ static int intel_vgpu_open_device(struct vfio_device *vfio_dev)
 		goto out;
 	}
 
-	events = VFIO_GROUP_NOTIFY_SET_KVM;
-	ret = vfio_register_notifier(vfio_dev, VFIO_GROUP_NOTIFY, &events,
-				     &vgpu->group_notifier);
-	if (ret != 0) {
-		gvt_vgpu_err("vfio_register_notifier for group failed: %d\n",
-			ret);
-		goto undo_iommu;
-	}
-
 	ret = -EEXIST;
 	if (vgpu->attached)
-		goto undo_register;
+		goto undo_iommu;
 
 	ret = -ESRCH;
-	if (!vgpu->kvm || vgpu->kvm->mm != current->mm) {
+	if (!vgpu->vfio_device.kvm ||
+	    vgpu->vfio_device.kvm->mm != current->mm) {
 		gvt_vgpu_err("KVM is required to use Intel vGPU\n");
-		goto undo_register;
+		goto undo_iommu;
 	}
 
+	kvm_get_kvm(vgpu->vfio_device.kvm);
+
 	ret = -EEXIST;
 	if (__kvmgt_vgpu_exist(vgpu))
-		goto undo_register;
+		goto undo_iommu;
 
 	vgpu->attached = true;
-	kvm_get_kvm(vgpu->kvm);
 
 	kvmgt_protect_table_init(vgpu);
 	gvt_cache_init(vgpu);
 
 	vgpu->track_node.track_write = kvmgt_page_track_write;
 	vgpu->track_node.track_flush_slot = kvmgt_page_track_flush_slot;
-	kvm_page_track_register_notifier(vgpu->kvm, &vgpu->track_node);
+	kvm_page_track_register_notifier(vgpu->vfio_device.kvm,
+					 &vgpu->track_node);
 
 	debugfs_create_ulong(KVMGT_DEBUGFS_FILENAME, 0444, vgpu->debugfs,
 			     &vgpu->nr_cache_entries);
@@ -858,10 +832,6 @@ static int intel_vgpu_open_device(struct vfio_device *vfio_dev)
 	atomic_set(&vgpu->released, 0);
 	return 0;
 
-undo_register:
-	vfio_unregister_notifier(vfio_dev, VFIO_GROUP_NOTIFY,
-				 &vgpu->group_notifier);
-
 undo_iommu:
 	vfio_unregister_notifier(vfio_dev, VFIO_IOMMU_NOTIFY,
 				 &vgpu->iommu_notifier);
@@ -880,8 +850,9 @@ static void intel_vgpu_release_msi_eventfd_ctx(struct intel_vgpu *vgpu)
 	}
 }
 
-static void __intel_vgpu_release(struct intel_vgpu *vgpu)
+static void intel_vgpu_close_device(struct vfio_device *vfio_dev)
 {
+	struct intel_vgpu *vgpu = vfio_dev_to_vgpu(vfio_dev);
 	struct drm_i915_private *i915 = vgpu->gvt->gt->i915;
 	int ret;
 
@@ -898,35 +869,19 @@ static void __intel_vgpu_release(struct intel_vgpu *vgpu)
 	drm_WARN(&i915->drm, ret,
 		 "vfio_unregister_notifier for iommu failed: %d\n", ret);
 
-	ret = vfio_unregister_notifier(&vgpu->vfio_device, VFIO_GROUP_NOTIFY,
-				       &vgpu->group_notifier);
-	drm_WARN(&i915->drm, ret,
-		 "vfio_unregister_notifier for group failed: %d\n", ret);
-
 	debugfs_remove(debugfs_lookup(KVMGT_DEBUGFS_FILENAME, vgpu->debugfs));
 
-	kvm_page_track_unregister_notifier(vgpu->kvm, &vgpu->track_node);
-	kvm_put_kvm(vgpu->kvm);
+	kvm_page_track_unregister_notifier(vgpu->vfio_device.kvm,
+					   &vgpu->track_node);
 	kvmgt_protect_table_destroy(vgpu);
 	gvt_cache_destroy(vgpu);
 
 	intel_vgpu_release_msi_eventfd_ctx(vgpu);
 
-	vgpu->kvm = NULL;
 	vgpu->attached = false;
-}
-
-static void intel_vgpu_close_device(struct vfio_device *vfio_dev)
-{
-	__intel_vgpu_release(vfio_dev_to_vgpu(vfio_dev));
-}
-
-static void intel_vgpu_release_work(struct work_struct *work)
-{
-	struct intel_vgpu *vgpu =
-		container_of(work, struct intel_vgpu, release_work);
 
-	__intel_vgpu_release(vgpu);
+	if (vgpu->vfio_device.kvm)
+		kvm_put_kvm(vgpu->vfio_device.kvm);
 }
 
 static u64 intel_vgpu_get_bar_addr(struct intel_vgpu *vgpu, int bar)
@@ -1675,7 +1630,6 @@ static int intel_vgpu_probe(struct mdev_device *mdev)
 		return PTR_ERR(vgpu);
 	}
 
-	INIT_WORK(&vgpu->release_work, intel_vgpu_release_work);
 	vfio_init_group_dev(&vgpu->vfio_device, &mdev->dev,
 			    &intel_vgpu_dev_ops);
 
@@ -1713,7 +1667,7 @@ static struct mdev_driver intel_vgpu_mdev_driver = {
 
 int intel_gvt_page_track_add(struct intel_vgpu *info, u64 gfn)
 {
-	struct kvm *kvm = info->kvm;
+	struct kvm *kvm = info->vfio_device.kvm;
 	struct kvm_memory_slot *slot;
 	int idx;
 
@@ -1743,7 +1697,7 @@ int intel_gvt_page_track_add(struct intel_vgpu *info, u64 gfn)
 
 int intel_gvt_page_track_remove(struct intel_vgpu *info, u64 gfn)
 {
-	struct kvm *kvm = info->kvm;
+	struct kvm *kvm = info->vfio_device.kvm;
 	struct kvm_memory_slot *slot;
 	int idx;
 
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index e8914024f5b1..17a56bb4cf25 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1196,6 +1196,8 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 {
 	struct ap_matrix_mdev *m;
 
+	kvm_get_kvm(kvm);
+
 	if (kvm->arch.crypto.crycbd) {
 		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
 		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
@@ -1282,25 +1284,9 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 		mutex_unlock(&kvm->lock);
 		mutex_unlock(&matrix_dev->lock);
 	}
-}
 
-static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
-				       unsigned long action, void *data)
-{
-	int notify_rc = NOTIFY_OK;
-	struct ap_matrix_mdev *matrix_mdev;
-
-	if (action != VFIO_GROUP_NOTIFY_SET_KVM)
-		return NOTIFY_OK;
-
-	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
-
-	if (!data)
-		vfio_ap_mdev_unset_kvm(matrix_mdev);
-	else if (vfio_ap_mdev_set_kvm(matrix_mdev, data))
-		notify_rc = NOTIFY_DONE;
-
-	return notify_rc;
+	if (kvm)
+		kvm_put_kvm(kvm);
 }
 
 static struct vfio_ap_queue *vfio_ap_find_queue(int apqn)
@@ -1402,11 +1388,10 @@ static int vfio_ap_mdev_open_device(struct vfio_device *vdev)
 	unsigned long events;
 	int ret;
 
-	matrix_mdev->group_notifier.notifier_call = vfio_ap_mdev_group_notifier;
-	events = VFIO_GROUP_NOTIFY_SET_KVM;
+	if (!vdev->kvm)
+		return -EPERM;
 
-	ret = vfio_register_notifier(vdev, VFIO_GROUP_NOTIFY, &events,
-				     &matrix_mdev->group_notifier);
+	ret = vfio_ap_mdev_set_kvm(matrix_mdev, vdev->kvm);
 	if (ret)
 		return ret;
 
@@ -1415,12 +1400,11 @@ static int vfio_ap_mdev_open_device(struct vfio_device *vdev)
 	ret = vfio_register_notifier(vdev, VFIO_IOMMU_NOTIFY, &events,
 				     &matrix_mdev->iommu_notifier);
 	if (ret)
-		goto out_unregister_group;
+		goto err_kvm;
 	return 0;
 
-out_unregister_group:
-	vfio_unregister_notifier(vdev, VFIO_GROUP_NOTIFY,
-				 &matrix_mdev->group_notifier);
+err_kvm:
+	vfio_ap_mdev_unset_kvm(matrix_mdev);
 	return ret;
 }
 
@@ -1431,8 +1415,6 @@ static void vfio_ap_mdev_close_device(struct vfio_device *vdev)
 
 	vfio_unregister_notifier(vdev, VFIO_IOMMU_NOTIFY,
 				 &matrix_mdev->iommu_notifier);
-	vfio_unregister_notifier(vdev, VFIO_GROUP_NOTIFY,
-				 &matrix_mdev->group_notifier);
 	vfio_ap_mdev_unset_kvm(matrix_mdev);
 }
 
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 648fcaf8104a..a26efd804d0d 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -81,8 +81,6 @@ struct ap_matrix {
  * @node:	allows the ap_matrix_mdev struct to be added to a list
  * @matrix:	the adapters, usage domains and control domains assigned to the
  *		mediated matrix device.
- * @group_notifier: notifier block used for specifying callback function for
- *		    handling the VFIO_GROUP_NOTIFY_SET_KVM event
  * @iommu_notifier: notifier block used for specifying callback function for
  *		    handling the VFIO_IOMMU_NOTIFY_DMA_UNMAP even
  * @kvm:	the struct holding guest's state
@@ -94,7 +92,6 @@ struct ap_matrix_mdev {
 	struct vfio_device vdev;
 	struct list_head node;
 	struct ap_matrix matrix;
-	struct notifier_block group_notifier;
 	struct notifier_block iommu_notifier;
 	struct kvm *kvm;
 	crypto_hook pqap_hook;
diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index cfcff7764403..272acb62facd 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1083,11 +1083,22 @@ static struct file *vfio_device_open(struct vfio_device *device)
 
 	mutex_lock(&device->dev_set->lock);
 	device->open_count++;
+	down_read(&device->group->group_rwsem);
+	if (device->open_count == 1 && device->group->kvm) {
+		/*
+		 * Here we pass the KVM pointer with the group under the read
+		 * lock.  If the device driver will use it, it must obtain a
+		 * reference and release it during close_device.
+		 */
+		device->kvm = device->group->kvm;
+	}
+
 	if (device->open_count == 1 && device->ops->open_device) {
 		ret = device->ops->open_device(device);
 		if (ret)
 			goto err_undo_count;
 	}
+	up_read(&device->group->group_rwsem);
 	mutex_unlock(&device->dev_set->lock);
 
 	/*
@@ -1119,10 +1130,14 @@ static struct file *vfio_device_open(struct vfio_device *device)
 
 err_close_device:
 	mutex_lock(&device->dev_set->lock);
+	down_read(&device->group->group_rwsem);
 	if (device->open_count == 1 && device->ops->close_device)
 		device->ops->close_device(device);
 err_undo_count:
 	device->open_count--;
+	if (device->open_count == 0 && device->kvm)
+		device->kvm = NULL;
+	up_read(&device->group->group_rwsem);
 	mutex_unlock(&device->dev_set->lock);
 	module_put(device->dev->driver->owner);
 err_unassign_container:
@@ -1315,9 +1330,13 @@ static int vfio_device_fops_release(struct inode *inode, struct file *filep)
 
 	mutex_lock(&device->dev_set->lock);
 	vfio_assert_device_open(device);
+	down_read(&device->group->group_rwsem);
 	if (device->open_count == 1 && device->ops->close_device)
 		device->ops->close_device(device);
 	device->open_count--;
+	if (device->open_count == 0 && device->kvm)
+		device->kvm = NULL;
+	up_read(&device->group->group_rwsem);
 	mutex_unlock(&device->dev_set->lock);
 
 	module_put(device->dev->driver->owner);
@@ -1726,8 +1745,8 @@ EXPORT_SYMBOL_GPL(vfio_file_enforced_coherent);
  * @file: VFIO group file
  * @kvm: KVM to link
  *
- * The kvm pointer will be forwarded to all the vfio_device's attached to the
- * VFIO file via the VFIO_GROUP_NOTIFY_SET_KVM notifier.
+ * When a VFIO device is first opened the KVM will be available in
+ * device->kvm if one was associated with the group.
  */
 void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
 {
@@ -1738,8 +1757,6 @@ void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
 
 	down_write(&group->group_rwsem);
 	group->kvm = kvm;
-	blocking_notifier_call_chain(&group->notifier,
-				     VFIO_GROUP_NOTIFY_SET_KVM, kvm);
 	up_write(&group->group_rwsem);
 }
 EXPORT_SYMBOL_GPL(vfio_file_set_kvm);
@@ -2006,7 +2023,8 @@ static int vfio_register_iommu_notifier(struct vfio_group *group,
 	struct vfio_iommu_driver *driver;
 	int ret;
 
-	down_read(&group->group_rwsem);
+	lockdep_assert_held_read(&group->group_rwsem);
+
 	container = group->container;
 	driver = container->iommu_driver;
 	if (likely(driver && driver->ops->register_notifier))
@@ -2014,7 +2032,6 @@ static int vfio_register_iommu_notifier(struct vfio_group *group,
 						     events, nb);
 	else
 		ret = -ENOTTY;
-	up_read(&group->group_rwsem);
 
 	return ret;
 }
@@ -2026,7 +2043,8 @@ static int vfio_unregister_iommu_notifier(struct vfio_group *group,
 	struct vfio_iommu_driver *driver;
 	int ret;
 
-	down_read(&group->group_rwsem);
+	lockdep_assert_held_read(&group->group_rwsem);
+
 	container = group->container;
 	driver = container->iommu_driver;
 	if (likely(driver && driver->ops->unregister_notifier))
@@ -2034,47 +2052,10 @@ static int vfio_unregister_iommu_notifier(struct vfio_group *group,
 						       nb);
 	else
 		ret = -ENOTTY;
-	up_read(&group->group_rwsem);
 
 	return ret;
 }
 
-static int vfio_register_group_notifier(struct vfio_group *group,
-					unsigned long *events,
-					struct notifier_block *nb)
-{
-	int ret;
-	bool set_kvm = false;
-
-	if (*events & VFIO_GROUP_NOTIFY_SET_KVM)
-		set_kvm = true;
-
-	/* clear known events */
-	*events &= ~VFIO_GROUP_NOTIFY_SET_KVM;
-
-	/* refuse to continue if still events remaining */
-	if (*events)
-		return -EINVAL;
-
-	ret = blocking_notifier_chain_register(&group->notifier, nb);
-	if (ret)
-		return ret;
-
-	/*
-	 * The attaching of kvm and vfio_group might already happen, so
-	 * here we replay once upon registration.
-	 */
-	if (set_kvm) {
-		down_read(&group->group_rwsem);
-		if (group->kvm)
-			blocking_notifier_call_chain(&group->notifier,
-						     VFIO_GROUP_NOTIFY_SET_KVM,
-						     group->kvm);
-		up_read(&group->group_rwsem);
-	}
-	return 0;
-}
-
 int vfio_register_notifier(struct vfio_device *device,
 			   enum vfio_notify_type type, unsigned long *events,
 			   struct notifier_block *nb)
@@ -2090,9 +2071,6 @@ int vfio_register_notifier(struct vfio_device *device,
 	case VFIO_IOMMU_NOTIFY:
 		ret = vfio_register_iommu_notifier(group, events, nb);
 		break;
-	case VFIO_GROUP_NOTIFY:
-		ret = vfio_register_group_notifier(group, events, nb);
-		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -2114,9 +2092,6 @@ int vfio_unregister_notifier(struct vfio_device *device,
 	case VFIO_IOMMU_NOTIFY:
 		ret = vfio_unregister_iommu_notifier(group, nb);
 		break;
-	case VFIO_GROUP_NOTIFY:
-		ret = blocking_notifier_chain_unregister(&group->notifier, nb);
-		break;
 	default:
 		ret = -EINVAL;
 	}
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 45b287826ce6..5f691453e3fb 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -36,6 +36,7 @@ struct vfio_device {
 	struct vfio_device_set *dev_set;
 	struct list_head dev_set_list;
 	unsigned int migration_flags;
+	struct kvm *kvm;
 
 	/* Members below here are private, not for driver use */
 	refcount_t refcount;
@@ -155,15 +156,11 @@ extern int vfio_dma_rw(struct vfio_device *device, dma_addr_t user_iova,
 /* each type has independent events */
 enum vfio_notify_type {
 	VFIO_IOMMU_NOTIFY = 0,
-	VFIO_GROUP_NOTIFY = 1,
 };
 
 /* events for VFIO_IOMMU_NOTIFY */
 #define VFIO_IOMMU_NOTIFY_DMA_UNMAP	BIT(0)
 
-/* events for VFIO_GROUP_NOTIFY */
-#define VFIO_GROUP_NOTIFY_SET_KVM	BIT(0)
-
 extern int vfio_register_notifier(struct vfio_device *device,
 				  enum vfio_notify_type type,
 				  unsigned long *required_events,
-- 
2.27.0

