Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132875B2C9C
	for <lists+linux-s390@lfdr.de>; Fri,  9 Sep 2022 05:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIIDEp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 8 Sep 2022 23:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiIIDEi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Sep 2022 23:04:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497EF3AE;
        Thu,  8 Sep 2022 20:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662692675; x=1694228675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dLDuI98+thpob8xF2Q1O8MqmB5dG3aZ+N6d84RGyRsU=;
  b=m6iCFlvVNGeTbYl2MTTD/NEAn6gfM38sq0/capEGBIH8hRB8/NqfsTSg
   1PPjKYiQMysIo58Okcshqtfd63CfXg1IIlXqODuc0psMoLxP9l+4OKYgi
   8xZb0LV+4CAz8Y8gM/V6nc09XVqV1nRpniqLgHYnTkjuu/gqyXpLPE/Qp
   vK7XL6twqPheJbUwW+s6yHf1FONjz61EgffohQZgUgh6vzGbkOHQpyIb2
   mDxevHpxbpC4tKUAilQE+5sy/XzAf/5rdY3cbMduTsxjplUS/O1Oh92SE
   Mhozkq/QXvkxKh2R9jwMEsV5iP1p/XgU6JhMhNdF37xXuPApHYZbF9SS+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="294963104"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="294963104"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 20:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="740908564"
Received: from sqa-gate.sh.intel.com (HELO michael.clx.dev.tsp.org) ([10.239.48.212])
  by orsmga004.jf.intel.com with ESMTP; 08 Sep 2022 20:03:45 -0700
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
Subject: [PATCH v3 02/15] vfio/pci: Use the new device life cycle helpers
Date:   Fri,  9 Sep 2022 18:22:34 +0800
Message-Id: <20220909102247.67324-3-kevin.tian@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20220909102247.67324-1-kevin.tian@intel.com>
References: <20220909102247.67324-1-kevin.tian@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Yi Liu <yi.l.liu@intel.com>

Also introduce two pci core helpers as @init/@release for pci drivers:

 - vfio_pci_core_init_dev()
 - vfio_pci_core_release_dev()

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/vfio/pci/vfio_pci.c      | 20 +++++++++---------
 drivers/vfio/pci/vfio_pci_core.c | 35 ++++++++++++++++++++++++++++++++
 include/linux/vfio_pci_core.h    |  2 ++
 3 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index d9b5c03f8d5b..1d4919edfbde 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -127,6 +127,8 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
 
 static const struct vfio_device_ops vfio_pci_ops = {
 	.name		= "vfio-pci",
+	.init		= vfio_pci_core_init_dev,
+	.release	= vfio_pci_core_release_dev,
 	.open_device	= vfio_pci_open_device,
 	.close_device	= vfio_pci_core_close_device,
 	.ioctl		= vfio_pci_core_ioctl,
@@ -146,20 +148,19 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (vfio_pci_is_denylisted(pdev))
 		return -EINVAL;
 
-	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
-	if (!vdev)
-		return -ENOMEM;
-	vfio_pci_core_init_device(vdev, pdev, &vfio_pci_ops);
+	vdev = vfio_alloc_device(vfio_pci_core_device, vdev, &pdev->dev,
+				 &vfio_pci_ops);
+	if (IS_ERR(vdev))
+		return PTR_ERR(vdev);
 
 	dev_set_drvdata(&pdev->dev, vdev);
 	ret = vfio_pci_core_register_device(vdev);
 	if (ret)
-		goto out_free;
+		goto out_put_vdev;
 	return 0;
 
-out_free:
-	vfio_pci_core_uninit_device(vdev);
-	kfree(vdev);
+out_put_vdev:
+	vfio_put_device(&vdev->vdev);
 	return ret;
 }
 
@@ -168,8 +169,7 @@ static void vfio_pci_remove(struct pci_dev *pdev)
 	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
 
 	vfio_pci_core_unregister_device(vdev);
-	vfio_pci_core_uninit_device(vdev);
-	kfree(vdev);
+	vfio_put_device(&vdev->vdev);
 }
 
 static int vfio_pci_sriov_configure(struct pci_dev *pdev, int nr_virtfn)
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 0a801aee2f2d..77d33739c6e8 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2078,6 +2078,41 @@ static void vfio_pci_vga_uninit(struct vfio_pci_core_device *vdev)
 					      VGA_RSRC_LEGACY_MEM);
 }
 
+int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
+{
+	struct vfio_pci_core_device *vdev =
+		container_of(core_vdev, struct vfio_pci_core_device, vdev);
+
+	vdev->pdev = to_pci_dev(core_vdev->dev);
+	vdev->irq_type = VFIO_PCI_NUM_IRQS;
+	mutex_init(&vdev->igate);
+	spin_lock_init(&vdev->irqlock);
+	mutex_init(&vdev->ioeventfds_lock);
+	INIT_LIST_HEAD(&vdev->dummy_resources_list);
+	INIT_LIST_HEAD(&vdev->ioeventfds_list);
+	mutex_init(&vdev->vma_lock);
+	INIT_LIST_HEAD(&vdev->vma_list);
+	INIT_LIST_HEAD(&vdev->sriov_pfs_item);
+	init_rwsem(&vdev->memory_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_init_dev);
+
+void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
+{
+	struct vfio_pci_core_device *vdev =
+		container_of(core_vdev, struct vfio_pci_core_device, vdev);
+
+	mutex_destroy(&vdev->igate);
+	mutex_destroy(&vdev->ioeventfds_lock);
+	mutex_destroy(&vdev->vma_lock);
+	kfree(vdev->region);
+	kfree(vdev->pm_save);
+	vfio_free_device(core_vdev);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_release_dev);
+
 void vfio_pci_core_init_device(struct vfio_pci_core_device *vdev,
 			       struct pci_dev *pdev,
 			       const struct vfio_device_ops *vfio_pci_ops)
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 089b603bcfdc..0499ea836058 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -109,6 +109,8 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev);
 void vfio_pci_core_init_device(struct vfio_pci_core_device *vdev,
 			       struct pci_dev *pdev,
 			       const struct vfio_device_ops *vfio_pci_ops);
+int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
+void vfio_pci_core_release_dev(struct vfio_device *core_vdev);
 int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_uninit_device(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev);
-- 
2.21.3

