Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEDF5B2C9D
	for <lists+linux-s390@lfdr.de>; Fri,  9 Sep 2022 05:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiIIDE6 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 8 Sep 2022 23:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiIIDEt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Sep 2022 23:04:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECB214D08;
        Thu,  8 Sep 2022 20:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662692684; x=1694228684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fTTvGXDm3y5vxlunNw3lM7XvdJmmRuB7BkP4htaMFu0=;
  b=GxmYnv/4y59RmEsTeSNfXo5ORyeBnsyr6dN5S4C+od48yxZJUxbR7jgi
   Hf3NS2+l7ybCe9At+Kp50WQ6H8oLbEvSvT9ReEPznwmWNvQpgm1PAp3Ou
   8ihLcuxBoV0WGaVdijwWVP5PO+vq+xfhgxkMAWpNmxQE1ozUFutPJ0kBp
   O4DagxVFSK1jYYBBFzDfgpxEwUPDJY/cCKe3g5kGQ2r82rdh9QCxWLjET
   s6fqazmGzHgfAm/zoVpC/4z8k33RyQZjB4mOmcIq2Uz6nLrlQ5P9XnPPE
   JyrDzhrA7tBY337PCMNtkFoJQGo3YMhaF6Joh+iEcZgU4mNVRx7vUbn3Y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="298721632"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="298721632"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 20:04:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="740908979"
Received: from sqa-gate.sh.intel.com (HELO michael.clx.dev.tsp.org) ([10.239.48.212])
  by orsmga004.jf.intel.com with ESMTP; 08 Sep 2022 20:04:31 -0700
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
Subject: [PATCH v3 07/15] vfio/mbochs: Use the new device life cycle helpers
Date:   Fri,  9 Sep 2022 18:22:39 +0800
Message-Id: <20220909102247.67324-8-kevin.tian@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20220909102247.67324-1-kevin.tian@intel.com>
References: <20220909102247.67324-1-kevin.tian@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Yi Liu <yi.l.liu@intel.com>

and manage avail_mbytes inside @init/@release.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 samples/vfio-mdev/mbochs.c | 73 ++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
index 344c2901a82b..df95f25fbc0e 100644
--- a/samples/vfio-mdev/mbochs.c
+++ b/samples/vfio-mdev/mbochs.c
@@ -505,13 +505,14 @@ static int mbochs_reset(struct mdev_state *mdev_state)
 	return 0;
 }
 
-static int mbochs_probe(struct mdev_device *mdev)
+static int mbochs_init_dev(struct vfio_device *vdev)
 {
-	int avail_mbytes = atomic_read(&mbochs_avail_mbytes);
+	struct mdev_state *mdev_state =
+		container_of(vdev, struct mdev_state, vdev);
+	struct mdev_device *mdev = to_mdev_device(vdev->dev);
 	const struct mbochs_type *type =
 		&mbochs_types[mdev_get_type_group_id(mdev)];
-	struct device *dev = mdev_dev(mdev);
-	struct mdev_state *mdev_state;
+	int avail_mbytes = atomic_read(&mbochs_avail_mbytes);
 	int ret = -ENOMEM;
 
 	do {
@@ -520,14 +521,9 @@ static int mbochs_probe(struct mdev_device *mdev)
 	} while (!atomic_try_cmpxchg(&mbochs_avail_mbytes, &avail_mbytes,
 				     avail_mbytes - type->mbytes));
 
-	mdev_state = kzalloc(sizeof(struct mdev_state), GFP_KERNEL);
-	if (mdev_state == NULL)
-		goto err_avail;
-	vfio_init_group_dev(&mdev_state->vdev, &mdev->dev, &mbochs_dev_ops);
-
 	mdev_state->vconfig = kzalloc(MBOCHS_CONFIG_SPACE_SIZE, GFP_KERNEL);
-	if (mdev_state->vconfig == NULL)
-		goto err_mem;
+	if (!mdev_state->vconfig)
+		goto err_avail;
 
 	mdev_state->memsize = type->mbytes * 1024 * 1024;
 	mdev_state->pagecount = mdev_state->memsize >> PAGE_SHIFT;
@@ -535,10 +531,7 @@ static int mbochs_probe(struct mdev_device *mdev)
 				    sizeof(struct page *),
 				    GFP_KERNEL);
 	if (!mdev_state->pages)
-		goto err_mem;
-
-	dev_info(dev, "%s: %s, %d MB, %ld pages\n", __func__,
-		 type->name, type->mbytes, mdev_state->pagecount);
+		goto err_vconfig;
 
 	mutex_init(&mdev_state->ops_lock);
 	mdev_state->mdev = mdev;
@@ -553,19 +546,47 @@ static int mbochs_probe(struct mdev_device *mdev)
 	mbochs_create_config_space(mdev_state);
 	mbochs_reset(mdev_state);
 
+	dev_info(vdev->dev, "%s: %s, %d MB, %ld pages\n", __func__,
+		 type->name, type->mbytes, mdev_state->pagecount);
+	return 0;
+
+err_vconfig:
+	kfree(mdev_state->vconfig);
+err_avail:
+	atomic_add(type->mbytes, &mbochs_avail_mbytes);
+	return ret;
+}
+
+static int mbochs_probe(struct mdev_device *mdev)
+{
+	struct mdev_state *mdev_state;
+	int ret = -ENOMEM;
+
+	mdev_state = vfio_alloc_device(mdev_state, vdev, &mdev->dev,
+				       &mbochs_dev_ops);
+	if (IS_ERR(mdev_state))
+		return PTR_ERR(mdev_state);
+
 	ret = vfio_register_emulated_iommu_dev(&mdev_state->vdev);
 	if (ret)
-		goto err_mem;
+		goto err_put_vdev;
 	dev_set_drvdata(&mdev->dev, mdev_state);
 	return 0;
-err_mem:
-	vfio_uninit_group_dev(&mdev_state->vdev);
+
+err_put_vdev:
+	vfio_put_device(&mdev_state->vdev);
+	return ret;
+}
+
+static void mbochs_release_dev(struct vfio_device *vdev)
+{
+	struct mdev_state *mdev_state =
+		container_of(vdev, struct mdev_state, vdev);
+
 	kfree(mdev_state->pages);
 	kfree(mdev_state->vconfig);
-	kfree(mdev_state);
-err_avail:
-	atomic_add(type->mbytes, &mbochs_avail_mbytes);
-	return ret;
+	vfio_free_device(vdev);
+	atomic_add(mdev_state->type->mbytes, &mbochs_avail_mbytes);
 }
 
 static void mbochs_remove(struct mdev_device *mdev)
@@ -573,11 +594,7 @@ static void mbochs_remove(struct mdev_device *mdev)
 	struct mdev_state *mdev_state = dev_get_drvdata(&mdev->dev);
 
 	vfio_unregister_group_dev(&mdev_state->vdev);
-	vfio_uninit_group_dev(&mdev_state->vdev);
-	atomic_add(mdev_state->type->mbytes, &mbochs_avail_mbytes);
-	kfree(mdev_state->pages);
-	kfree(mdev_state->vconfig);
-	kfree(mdev_state);
+	vfio_put_device(&mdev_state->vdev);
 }
 
 static ssize_t mbochs_read(struct vfio_device *vdev, char __user *buf,
@@ -1397,6 +1414,8 @@ static struct attribute_group *mdev_type_groups[] = {
 
 static const struct vfio_device_ops mbochs_dev_ops = {
 	.close_device = mbochs_close_device,
+	.init = mbochs_init_dev,
+	.release = mbochs_release_dev,
 	.read = mbochs_read,
 	.write = mbochs_write,
 	.ioctl = mbochs_ioctl,
-- 
2.21.3

