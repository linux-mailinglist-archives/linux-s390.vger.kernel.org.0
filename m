Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED75B0BA8
	for <lists+linux-s390@lfdr.de>; Thu, 12 Sep 2019 11:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfILJkw (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 12 Sep 2019 05:40:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730597AbfILJkw (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Sep 2019 05:40:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 782F030860CB;
        Thu, 12 Sep 2019 09:40:51 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31D6B60852;
        Thu, 12 Sep 2019 09:40:31 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com,
        alex.williamson@redhat.com
Cc:     mst@redhat.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        cohuck@redhat.com, farman@linux.ibm.com, pasic@linux.ibm.com,
        sebott@linux.ibm.com, oberpar@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, akrowiak@linux.ibm.com,
        pmorel@linux.ibm.com, freude@linux.ibm.com, tiwei.bie@intel.com,
        virtualization@lists.linux-foundation.org,
        maxime.coquelin@redhat.com, cunming.liang@intel.com,
        zhihong.wang@intel.com, rob.miller@broadcom.com, idos@mellanox.com,
        xiao.w.wang@intel.com, lingshan.zhu@intel.com,
        Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH 1/2] mdev: device id support
Date:   Thu, 12 Sep 2019 17:40:11 +0800
Message-Id: <20190912094012.29653-2-jasowang@redhat.com>
In-Reply-To: <20190912094012.29653-1-jasowang@redhat.com>
References: <20190912094012.29653-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 12 Sep 2019 09:40:51 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Mdev bus only support vfio driver right now, so it doesn't implement
match method. But in the future, we may add drivers other than vfio,
one example is virtio-mdev[1] driver. This means we need to add device
id support in bus match method to pair the mdev device and mdev driver
correctly.

So this patch add id_table to mdev_driver and id for mdev parent, and
implement the match method for mdev bus.

[1] https://lkml.org/lkml/2019/9/10/135

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c  |  2 +-
 drivers/s390/cio/vfio_ccw_ops.c   |  2 +-
 drivers/s390/crypto/vfio_ap_ops.c |  3 ++-
 drivers/vfio/mdev/mdev_core.c     | 14 ++++++++++++--
 drivers/vfio/mdev/mdev_driver.c   | 14 ++++++++++++++
 drivers/vfio/mdev/mdev_private.h  |  1 +
 drivers/vfio/mdev/vfio_mdev.c     |  6 ++++++
 include/linux/mdev.h              |  6 +++++-
 include/linux/mod_devicetable.h   |  6 ++++++
 samples/vfio-mdev/mbochs.c        |  2 +-
 samples/vfio-mdev/mdpy.c          |  2 +-
 samples/vfio-mdev/mtty.c          |  2 +-
 12 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 23aa3e50cbf8..19d51a35f019 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1625,7 +1625,7 @@ static int kvmgt_host_init(struct device *dev, void *gvt, const void *ops)
 		return -EFAULT;
 	intel_vgpu_ops.supported_type_groups = kvm_vgpu_type_groups;
 
-	return mdev_register_device(dev, &intel_vgpu_ops);
+	return mdev_register_vfio_device(dev, &intel_vgpu_ops);
 }
 
 static void kvmgt_host_exit(struct device *dev)
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 5eb61116ca6f..f87d9409e290 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -578,7 +578,7 @@ static const struct mdev_parent_ops vfio_ccw_mdev_ops = {
 
 int vfio_ccw_mdev_reg(struct subchannel *sch)
 {
-	return mdev_register_device(&sch->dev, &vfio_ccw_mdev_ops);
+	return mdev_register_vfio_device(&sch->dev, &vfio_ccw_mdev_ops);
 }
 
 void vfio_ccw_mdev_unreg(struct subchannel *sch)
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 0604b49a4d32..eacbde3c7a97 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1295,7 +1295,8 @@ int vfio_ap_mdev_register(void)
 {
 	atomic_set(&matrix_dev->available_instances, MAX_ZDEV_ENTRIES_EXT);
 
-	return mdev_register_device(&matrix_dev->device, &vfio_ap_matrix_ops);
+	return mdev_register_vfio_device(&matrix_dev->device,
+					 &vfio_ap_matrix_ops);
 }
 
 void vfio_ap_mdev_unregister(void)
diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index b558d4cfd082..fc07ff3ebe96 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -135,11 +135,14 @@ static int mdev_device_remove_cb(struct device *dev, void *data)
  * mdev_register_device : Register a device
  * @dev: device structure representing parent device.
  * @ops: Parent device operation structure to be registered.
+ * @id: device id.
  *
  * Add device to list of registered parent devices.
  * Returns a negative value on error, otherwise 0.
  */
-int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
+int mdev_register_device(struct device *dev,
+			 const struct mdev_parent_ops *ops,
+			 u8 id)
 {
 	int ret;
 	struct mdev_parent *parent;
@@ -175,6 +178,7 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
 
 	parent->dev = dev;
 	parent->ops = ops;
+	parent->device_id = id;
 
 	if (!mdev_bus_compat_class) {
 		mdev_bus_compat_class = class_compat_register("mdev_bus");
@@ -208,7 +212,13 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
 		put_device(dev);
 	return ret;
 }
-EXPORT_SYMBOL(mdev_register_device);
+
+int mdev_register_vfio_device(struct device *dev,
+			      const struct mdev_parent_ops *ops)
+{
+	return mdev_register_device(dev, ops, MDEV_ID_VFIO);
+}
+EXPORT_SYMBOL(mdev_register_vfio_device);
 
 /*
  * mdev_unregister_device : Unregister a parent device
diff --git a/drivers/vfio/mdev/mdev_driver.c b/drivers/vfio/mdev/mdev_driver.c
index 0d3223aee20b..fd5e9541d18e 100644
--- a/drivers/vfio/mdev/mdev_driver.c
+++ b/drivers/vfio/mdev/mdev_driver.c
@@ -69,8 +69,22 @@ static int mdev_remove(struct device *dev)
 	return 0;
 }
 
+static int mdev_match(struct device *dev, struct device_driver *drv)
+{
+	unsigned int i;
+	struct mdev_device *mdev = to_mdev_device(dev);
+	struct mdev_driver *mdrv = to_mdev_driver(drv);
+	const struct mdev_device_id *ids = mdrv->id_table;
+
+	for (i = 0; ids[i].id; i++)
+		if (ids[i].id == mdev->parent->device_id)
+			return 1;
+	return 0;
+}
+
 struct bus_type mdev_bus_type = {
 	.name		= "mdev",
+	.match		= mdev_match,
 	.probe		= mdev_probe,
 	.remove		= mdev_remove,
 };
diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
index 7d922950caaf..7fc8153671e0 100644
--- a/drivers/vfio/mdev/mdev_private.h
+++ b/drivers/vfio/mdev/mdev_private.h
@@ -22,6 +22,7 @@ struct mdev_parent {
 	struct list_head type_list;
 	/* Synchronize device creation/removal with parent unregistration */
 	struct rw_semaphore unreg_sem;
+	u8 device_id;
 };
 
 struct mdev_device {
diff --git a/drivers/vfio/mdev/vfio_mdev.c b/drivers/vfio/mdev/vfio_mdev.c
index 30964a4e0a28..887c57f10880 100644
--- a/drivers/vfio/mdev/vfio_mdev.c
+++ b/drivers/vfio/mdev/vfio_mdev.c
@@ -120,10 +120,16 @@ static void vfio_mdev_remove(struct device *dev)
 	vfio_del_group_dev(dev);
 }
 
+static struct mdev_device_id id_table[] = {
+	{ MDEV_ID_VFIO },
+	{ 0 },
+};
+
 static struct mdev_driver vfio_mdev_driver = {
 	.name	= "vfio_mdev",
 	.probe	= vfio_mdev_probe,
 	.remove	= vfio_mdev_remove,
+	.id_table = id_table,
 };
 
 static int __init vfio_mdev_init(void)
diff --git a/include/linux/mdev.h b/include/linux/mdev.h
index 0ce30ca78db0..f85045392120 100644
--- a/include/linux/mdev.h
+++ b/include/linux/mdev.h
@@ -118,6 +118,7 @@ struct mdev_type_attribute mdev_type_attr_##_name =		\
  * @probe: called when new device created
  * @remove: called when device removed
  * @driver: device driver structure
+ * @id_table: the ids serviced by this driver.
  *
  **/
 struct mdev_driver {
@@ -125,6 +126,7 @@ struct mdev_driver {
 	int  (*probe)(struct device *dev);
 	void (*remove)(struct device *dev);
 	struct device_driver driver;
+	const struct mdev_device_id *id_table;
 };
 
 #define to_mdev_driver(drv)	container_of(drv, struct mdev_driver, driver)
@@ -135,7 +137,7 @@ const guid_t *mdev_uuid(struct mdev_device *mdev);
 
 extern struct bus_type mdev_bus_type;
 
-int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops);
+int mdev_register_vfio_device(struct device *dev, const struct mdev_parent_ops *ops);
 void mdev_unregister_device(struct device *dev);
 
 int mdev_register_driver(struct mdev_driver *drv, struct module *owner);
@@ -145,4 +147,6 @@ struct device *mdev_parent_dev(struct mdev_device *mdev);
 struct device *mdev_dev(struct mdev_device *mdev);
 struct mdev_device *mdev_from_dev(struct device *dev);
 
+#define MDEV_ID_VFIO 1 /* VFIO device */
+
 #endif /* MDEV_H */
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 5714fd35a83c..f1fc143df042 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -821,4 +821,10 @@ struct wmi_device_id {
 	const void *context;
 };
 
+/* MDEV */
+
+struct mdev_device_id {
+	__u8 id;
+};
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
index ac5c8c17b1ff..71a4469be85d 100644
--- a/samples/vfio-mdev/mbochs.c
+++ b/samples/vfio-mdev/mbochs.c
@@ -1468,7 +1468,7 @@ static int __init mbochs_dev_init(void)
 	if (ret)
 		goto failed2;
 
-	ret = mdev_register_device(&mbochs_dev, &mdev_fops);
+	ret = mdev_register_vfio_device(&mbochs_dev, &mdev_fops);
 	if (ret)
 		goto failed3;
 
diff --git a/samples/vfio-mdev/mdpy.c b/samples/vfio-mdev/mdpy.c
index cc86bf6566e4..d3029dd27d91 100644
--- a/samples/vfio-mdev/mdpy.c
+++ b/samples/vfio-mdev/mdpy.c
@@ -775,7 +775,7 @@ static int __init mdpy_dev_init(void)
 	if (ret)
 		goto failed2;
 
-	ret = mdev_register_device(&mdpy_dev, &mdev_fops);
+	ret = mdev_register_vfio_device(&mdpy_dev, &mdev_fops);
 	if (ret)
 		goto failed3;
 
diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
index 92e770a06ea2..744c88a6b22c 100644
--- a/samples/vfio-mdev/mtty.c
+++ b/samples/vfio-mdev/mtty.c
@@ -1468,7 +1468,7 @@ static int __init mtty_dev_init(void)
 	if (ret)
 		goto failed2;
 
-	ret = mdev_register_device(&mtty_dev.dev, &mdev_fops);
+	ret = mdev_register_vfio_device(&mtty_dev.dev, &mdev_fops);
 	if (ret)
 		goto failed3;
 
-- 
2.19.1

