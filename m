Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDA5757EB5
	for <lists+linux-s390@lfdr.de>; Tue, 18 Jul 2023 15:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjGRN6P (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 18 Jul 2023 09:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbjGRN54 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 Jul 2023 09:57:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4E71712;
        Tue, 18 Jul 2023 06:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689688657; x=1721224657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7/MGttU9wN35lZ6iBei+3z+TDduOsILJjnK/CTPEzDQ=;
  b=A0q6vIa1G75Yh9Uq9D+RFyboG5VuOA3LqXwm70E0o/YMm5oBK0Dz5b25
   6bFINJ9IQ44JelGBVsS0DeXrunfg4SJxhUaYO/YojIRmdSPqSJNBJr1SJ
   GXCTuLd+HbxUBF3/1Voadbwy7yIZeW6DgKQ995Zqk+XppE7lkExZCtcQe
   2oRhF3goJrHrCaRl0JBQnmWTIC8P1w9Y/w7wSLELo0kClx84vq9BH8k82
   zOMxsJulQhMt8SakW2wdQRK+BHjBDYHfz3Al6AGdFW6pB6SycEbzFEd7+
   HD+WigpiI+qPKjtec361GBaaAqIlbqIxwoeCdxPMpmK8jclBZuN4mfgpg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="452590756"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="452590756"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:56:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="970251068"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="970251068"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jul 2023 06:56:07 -0700
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
Subject: [PATCH v15 18/26] vfio: Add cdev for vfio_device
Date:   Tue, 18 Jul 2023 06:55:43 -0700
Message-Id: <20230718135551.6592-19-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718135551.6592-1-yi.l.liu@intel.com>
References: <20230718135551.6592-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This adds cdev support for vfio_device. It allows the user to directly
open a vfio device w/o using the legacy container/group interface, as a
prerequisite for supporting new iommu features like nested translation
and etc.

The device fd opened in this manner doesn't have the capability to access
the device as the fops open() doesn't open the device until the successful
VFIO_DEVICE_BIND_IOMMUFD ioctl which will be added in a later patch.

With this patch, devices registered to vfio core would have both the legacy
group and the new device interfaces created.

- group interface : /dev/vfio/$groupID
- device interface: /dev/vfio/devices/vfioX - normal device
		    ("X" is a unique number across vfio devices)

For a given device, the user can identify the matching vfioX by searching
the vfio-dev folder under the sysfs path of the device. Take PCI device
(0000:6a:01.0) as an example, /sys/bus/pci/devices/0000\:6a\:01.0/vfio-dev/vfioX
implies the matching vfioX under /dev/vfio/devices/, and vfio-dev/vfioX/dev
contains the major:minor number of the matching /dev/vfio/devices/vfioX.
The user can get device fd by opening the /dev/vfio/devices/vfioX.

The vfio_device cdev logic in this patch:
*) __vfio_register_dev() path ends up doing cdev_device_add() for each
   vfio_device if VFIO_DEVICE_CDEV configured.
*) vfio_unregister_group_dev() path does cdev_device_del();

cdev interface does not support noiommu devices, so VFIO only creates the
legacy group interface for the physical devices that do not have IOMMU.
noiommu users should use the legacy group interface.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Terrence Xu <terrence.xu@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Yanting Jiang <yanting.jiang@intel.com>
Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Tested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/vfio/Kconfig       | 12 ++++++++
 drivers/vfio/Makefile      |  1 +
 drivers/vfio/device_cdev.c | 63 ++++++++++++++++++++++++++++++++++++++
 drivers/vfio/vfio.h        | 54 ++++++++++++++++++++++++++++++++
 drivers/vfio/vfio_main.c   | 21 ++++++++++---
 include/linux/vfio.h       |  4 +++
 6 files changed, 151 insertions(+), 4 deletions(-)
 create mode 100644 drivers/vfio/device_cdev.c

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index aba36f5be4ec..26f18d92eb97 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -12,6 +12,18 @@ menuconfig VFIO
 	  If you don't know what to do here, say N.
 
 if VFIO
+config VFIO_DEVICE_CDEV
+	bool "Support for the VFIO cdev /dev/vfio/devices/vfioX"
+	depends on IOMMUFD && !SPAPR_TCE_IOMMU
+	help
+	  The VFIO device cdev is another way for userspace to get device
+	  access. Userspace gets device fd by opening device cdev under
+	  /dev/vfio/devices/vfioX, and then bind the device fd with an iommufd
+	  to set up secure DMA context for device access.  This interface does
+	  not support noiommu.
+
+	  If you don't know what to do here, say N.
+
 config VFIO_CONTAINER
 	bool "Support for the VFIO container /dev/vfio/vfio"
 	select VFIO_IOMMU_TYPE1 if MMU && (X86 || S390 || ARM || ARM64)
diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
index 66f418aef5a9..87ccb16fdd77 100644
--- a/drivers/vfio/Makefile
+++ b/drivers/vfio/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_VFIO) += vfio.o
 vfio-y += vfio_main.o \
 	  group.o \
 	  iova_bitmap.o
+vfio-$(CONFIG_VFIO_DEVICE_CDEV) += device_cdev.o
 vfio-$(CONFIG_IOMMUFD) += iommufd.o
 vfio-$(CONFIG_VFIO_CONTAINER) += container.o
 vfio-$(CONFIG_VFIO_VIRQFD) += virqfd.o
diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
new file mode 100644
index 000000000000..bf1032d00107
--- /dev/null
+++ b/drivers/vfio/device_cdev.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Intel Corporation.
+ */
+#include <linux/vfio.h>
+
+#include "vfio.h"
+
+static dev_t device_devt;
+
+void vfio_init_device_cdev(struct vfio_device *device)
+{
+	device->device.devt = MKDEV(MAJOR(device_devt), device->index);
+	cdev_init(&device->cdev, &vfio_device_fops);
+	device->cdev.owner = THIS_MODULE;
+}
+
+/*
+ * device access via the fd opened by this function is blocked until
+ * .open_device() is called successfully during BIND_IOMMUFD.
+ */
+int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
+{
+	struct vfio_device *device = container_of(inode->i_cdev,
+						  struct vfio_device, cdev);
+	struct vfio_device_file *df;
+	int ret;
+
+	/* Paired with the put in vfio_device_fops_release() */
+	if (!vfio_device_try_get_registration(device))
+		return -ENODEV;
+
+	df = vfio_allocate_device_file(device);
+	if (IS_ERR(df)) {
+		ret = PTR_ERR(df);
+		goto err_put_registration;
+	}
+
+	filep->private_data = df;
+
+	return 0;
+
+err_put_registration:
+	vfio_device_put_registration(device);
+	return ret;
+}
+
+static char *vfio_device_devnode(const struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "vfio/devices/%s", dev_name(dev));
+}
+
+int vfio_cdev_init(struct class *device_class)
+{
+	device_class->devnode = vfio_device_devnode;
+	return alloc_chrdev_region(&device_devt, 0,
+				   MINORMASK + 1, "vfio-dev");
+}
+
+void vfio_cdev_cleanup(void)
+{
+	unregister_chrdev_region(device_devt, MINORMASK + 1);
+}
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 58801adc1a7e..fb8f2fac3d23 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -266,6 +266,60 @@ vfio_iommufd_compat_attach_ioas(struct vfio_device *device,
 }
 #endif
 
+#if IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV)
+void vfio_init_device_cdev(struct vfio_device *device);
+
+static inline int vfio_device_add(struct vfio_device *device)
+{
+	/* cdev does not support noiommu device */
+	if (vfio_device_is_noiommu(device))
+		return device_add(&device->device);
+	vfio_init_device_cdev(device);
+	return cdev_device_add(&device->cdev, &device->device);
+}
+
+static inline void vfio_device_del(struct vfio_device *device)
+{
+	if (vfio_device_is_noiommu(device))
+		device_del(&device->device);
+	else
+		cdev_device_del(&device->cdev, &device->device);
+}
+
+int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep);
+int vfio_cdev_init(struct class *device_class);
+void vfio_cdev_cleanup(void);
+#else
+static inline void vfio_init_device_cdev(struct vfio_device *device)
+{
+}
+
+static inline int vfio_device_add(struct vfio_device *device)
+{
+	return device_add(&device->device);
+}
+
+static inline void vfio_device_del(struct vfio_device *device)
+{
+	device_del(&device->device);
+}
+
+static inline int vfio_device_fops_cdev_open(struct inode *inode,
+					     struct file *filep)
+{
+	return 0;
+}
+
+static inline int vfio_cdev_init(struct class *device_class)
+{
+	return 0;
+}
+
+static inline void vfio_cdev_cleanup(void)
+{
+}
+#endif /* CONFIG_VFIO_DEVICE_CDEV */
+
 #if IS_ENABLED(CONFIG_VFIO_VIRQFD)
 int __init vfio_virqfd_init(void);
 void vfio_virqfd_exit(void);
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 294bb5ecfc1c..8a9ebcc6980b 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -292,7 +292,7 @@ static int __vfio_register_dev(struct vfio_device *device,
 	if (ret)
 		return ret;
 
-	ret = device_add(&device->device);
+	ret = vfio_device_add(device);
 	if (ret)
 		goto err_out;
 
@@ -338,8 +338,11 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 	 */
 	vfio_device_group_unregister(device);
 
-	/* Balances device_add in register path */
-	device_del(&device->device);
+	/*
+	 * Balances vfio_device_add() in register path, also prevents
+	 * new device opened by userspace in the cdev path.
+	 */
+	vfio_device_del(device);
 
 	vfio_device_put_registration(device);
 	rc = try_wait_for_completion(&device->comp);
@@ -567,7 +570,8 @@ static int vfio_device_fops_release(struct inode *inode, struct file *filep)
 	struct vfio_device_file *df = filep->private_data;
 	struct vfio_device *device = df->device;
 
-	vfio_df_group_close(df);
+	if (df->group)
+		vfio_df_group_close(df);
 
 	vfio_device_put_registration(device);
 
@@ -1216,6 +1220,7 @@ static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
 
 const struct file_operations vfio_device_fops = {
 	.owner		= THIS_MODULE,
+	.open		= vfio_device_fops_cdev_open,
 	.release	= vfio_device_fops_release,
 	.read		= vfio_device_fops_read,
 	.write		= vfio_device_fops_write,
@@ -1567,9 +1572,16 @@ static int __init vfio_init(void)
 		goto err_dev_class;
 	}
 
+	ret = vfio_cdev_init(vfio.device_class);
+	if (ret)
+		goto err_alloc_dev_chrdev;
+
 	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 	return 0;
 
+err_alloc_dev_chrdev:
+	class_destroy(vfio.device_class);
+	vfio.device_class = NULL;
 err_dev_class:
 	vfio_virqfd_exit();
 err_virqfd:
@@ -1580,6 +1592,7 @@ static int __init vfio_init(void)
 static void __exit vfio_cleanup(void)
 {
 	ida_destroy(&vfio.device_ida);
+	vfio_cdev_cleanup();
 	class_destroy(vfio.device_class);
 	vfio.device_class = NULL;
 	vfio_virqfd_exit();
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 24091a7c7bdb..e0069f26488d 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -13,6 +13,7 @@
 #include <linux/mm.h>
 #include <linux/workqueue.h>
 #include <linux/poll.h>
+#include <linux/cdev.h>
 #include <uapi/linux/vfio.h>
 #include <linux/iova_bitmap.h>
 
@@ -51,6 +52,9 @@ struct vfio_device {
 	/* Members below here are private, not for driver use */
 	unsigned int index;
 	struct device device;	/* device.kref covers object life circle */
+#if IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV)
+	struct cdev cdev;
+#endif
 	refcount_t refcount;	/* user count on registered device*/
 	unsigned int open_count;
 	struct completion comp;
-- 
2.34.1

