Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6F45B2C95
	for <lists+linux-s390@lfdr.de>; Fri,  9 Sep 2022 05:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiIIDF5 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 8 Sep 2022 23:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiIIDFh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Sep 2022 23:05:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8952237E0;
        Thu,  8 Sep 2022 20:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662692704; x=1694228704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Twck9BA6OHNULTPl1B/ow9Z+KAQ9ZqcK5vq27ZI7Z0=;
  b=GGAD34nqSoUKZ4+wZXv1ixCAkmdq3ahXP0Mwm+T2hhdomDylAl2Y0Kfo
   rwgX3IlqVvJNQPoUpUfRWQTwpaFHCCECizEpzaI7jIl3550o0RNJ+lwVz
   PbAdyF+o0FvRsThVmwLf+eK9sTbDq6dZ78rBzJKztAY1SPWPi4GSlm6q4
   6+zIGZtlN/ZIs9My/hYeRVzzATcpOIrGo2Z6PtdSOr1hGmdM+yFn+oQVv
   nN3ocP/LXd8RWCOkru4PxzAFq9vKgtfKpc5qpw+4Vr5i8RZhIES0Hwo6O
   /jg8T3XGnBFmn9Wwor6A0C8m14Hwf/lwq31AovRAglPe8Kaz5lBpN17L/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="277116703"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="277116703"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 20:05:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="740909141"
Received: from sqa-gate.sh.intel.com (HELO michael.clx.dev.tsp.org) ([10.239.48.212])
  by orsmga004.jf.intel.com with ESMTP; 08 Sep 2022 20:04:50 -0700
From:   Kevin Tian <kevin.tian@intel.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 09/15] vfio/ap: Use the new device life cycle helpers
Date:   Fri,  9 Sep 2022 18:22:41 +0800
Message-Id: <20220909102247.67324-10-kevin.tian@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20220909102247.67324-1-kevin.tian@intel.com>
References: <20220909102247.67324-1-kevin.tian@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Yi Liu <yi.l.liu@intel.com>

and manage available_instances inside @init/@release.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 50 ++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 6c8c41fac4e1..803aadfd0876 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -684,42 +684,44 @@ static bool vfio_ap_mdev_filter_matrix(unsigned long *apm, unsigned long *aqm,
 			     AP_DOMAINS);
 }
 
-static int vfio_ap_mdev_probe(struct mdev_device *mdev)
+static int vfio_ap_mdev_init_dev(struct vfio_device *vdev)
 {
-	struct ap_matrix_mdev *matrix_mdev;
-	int ret;
+	struct ap_matrix_mdev *matrix_mdev =
+		container_of(vdev, struct ap_matrix_mdev, vdev);
 
 	if ((atomic_dec_if_positive(&matrix_dev->available_instances) < 0))
 		return -EPERM;
 
-	matrix_mdev = kzalloc(sizeof(*matrix_mdev), GFP_KERNEL);
-	if (!matrix_mdev) {
-		ret = -ENOMEM;
-		goto err_dec_available;
-	}
-	vfio_init_group_dev(&matrix_mdev->vdev, &mdev->dev,
-			    &vfio_ap_matrix_dev_ops);
-
-	matrix_mdev->mdev = mdev;
+	matrix_mdev->mdev = to_mdev_device(vdev->dev);
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
 	matrix_mdev->pqap_hook = handle_pqap;
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->shadow_apcb);
 	hash_init(matrix_mdev->qtable.queues);
 
+	return 0;
+}
+
+static int vfio_ap_mdev_probe(struct mdev_device *mdev)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+	int ret;
+
+	matrix_mdev = vfio_alloc_device(ap_matrix_mdev, vdev, &mdev->dev,
+					&vfio_ap_matrix_dev_ops);
+	if (IS_ERR(matrix_mdev))
+		return PTR_ERR(matrix_mdev);
+
 	ret = vfio_register_emulated_iommu_dev(&matrix_mdev->vdev);
 	if (ret)
-		goto err_list;
+		goto err_put_vdev;
 	dev_set_drvdata(&mdev->dev, matrix_mdev);
 	mutex_lock(&matrix_dev->mdevs_lock);
 	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
 	mutex_unlock(&matrix_dev->mdevs_lock);
 	return 0;
 
-err_list:
-	vfio_uninit_group_dev(&matrix_mdev->vdev);
-	kfree(matrix_mdev);
-err_dec_available:
-	atomic_inc(&matrix_dev->available_instances);
+err_put_vdev:
+	vfio_put_device(&matrix_mdev->vdev);
 	return ret;
 }
 
@@ -766,6 +768,12 @@ static void vfio_ap_mdev_unlink_fr_queues(struct ap_matrix_mdev *matrix_mdev)
 	}
 }
 
+static void vfio_ap_mdev_release_dev(struct vfio_device *vdev)
+{
+	vfio_free_device(vdev);
+	atomic_inc(&matrix_dev->available_instances);
+}
+
 static void vfio_ap_mdev_remove(struct mdev_device *mdev)
 {
 	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(&mdev->dev);
@@ -779,9 +787,7 @@ static void vfio_ap_mdev_remove(struct mdev_device *mdev)
 	list_del(&matrix_mdev->node);
 	mutex_unlock(&matrix_dev->mdevs_lock);
 	mutex_unlock(&matrix_dev->guests_lock);
-	vfio_uninit_group_dev(&matrix_mdev->vdev);
-	kfree(matrix_mdev);
-	atomic_inc(&matrix_dev->available_instances);
+	vfio_put_device(&matrix_mdev->vdev);
 }
 
 static ssize_t name_show(struct mdev_type *mtype,
@@ -1794,6 +1800,8 @@ static const struct attribute_group vfio_queue_attr_group = {
 };
 
 static const struct vfio_device_ops vfio_ap_matrix_dev_ops = {
+	.init = vfio_ap_mdev_init_dev,
+	.release = vfio_ap_mdev_release_dev,
 	.open_device = vfio_ap_mdev_open_device,
 	.close_device = vfio_ap_mdev_close_device,
 	.ioctl = vfio_ap_mdev_ioctl,
-- 
2.21.3

