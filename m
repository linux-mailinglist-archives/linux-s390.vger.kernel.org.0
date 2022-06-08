Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7B9543BCF
	for <lists+linux-s390@lfdr.de>; Wed,  8 Jun 2022 20:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiFHSzd (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 8 Jun 2022 14:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiFHSzY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jun 2022 14:55:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EC841038A8
        for <linux-s390@vger.kernel.org>; Wed,  8 Jun 2022 11:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654714521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=abRjllu/MyfASe6azFb9CaVijW10O/mJJvktDxulCkE=;
        b=CHM0ytuYlN96KwVxCdMFtxbvwlsl0RvRpt2IcLuFNKlbSEyAS3kuFchNmipJVdNPEJbM8U
        BZl1TakYPn1u0ixi0SX+mhMbFwNiSJKVCR46I1lrEpFsAXUKvP3o+0NFkH4fEZjGng4bDo
        DCEzI6mpUgKrkB41I8DkYqzKS01Wuss=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-h8pmmRqRO52jdrOsUdygNA-1; Wed, 08 Jun 2022 14:55:15 -0400
X-MC-Unique: h8pmmRqRO52jdrOsUdygNA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C0B32999B56;
        Wed,  8 Jun 2022 18:55:14 +0000 (UTC)
Received: from [172.30.41.16] (unknown [10.22.35.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CCD21415102;
        Wed,  8 Jun 2022 18:55:13 +0000 (UTC)
Subject: [PATCH] vfio: de-extern-ify function prototypes
From:   Alex Williamson <alex.williamson@redhat.com>
To:     alex.williamson@redhat.com
Cc:     kwankhede@nvidia.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, diana.craciun@oss.nxp.com, cohuck@redhat.com,
        eric.auger@redhat.com, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, jgg@nvidia.com, yishaih@nvidia.com,
        hch@lst.de
Date:   Wed, 08 Jun 2022 12:55:13 -0600
Message-ID: <165471414407.203056.474032786990662279.stgit@omen>
User-Agent: StGit/1.5.dev2+g9ce680a52bd9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The use of 'extern' in function prototypes has been disrecommended in
the kernel coding style for several years now, remove them from all vfio
related files so contributors no longer need to decide between style and
consistency.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

A patch in the same vein was proposed about a year ago, but tied to an ill
fated series and forgotten.  Now that we're at the beginning of a new
development cycle, I'd like to propose kicking off the v5.20 vfio next
branch with this patch and would kindly ask anyone with pending respins or
significant conflicts to rebase on top of this patch.  Thanks!

 Documentation/driver-api/vfio-mediated-device.rst |   10 ++-
 drivers/s390/cio/vfio_ccw_cp.h                    |   12 ++--
 drivers/s390/cio/vfio_ccw_private.h               |    6 +-
 drivers/vfio/fsl-mc/vfio_fsl_mc_private.h         |    2 -
 drivers/vfio/platform/vfio_platform_private.h     |   21 +++---
 include/linux/vfio.h                              |   70 ++++++++++-----------
 include/linux/vfio_pci_core.h                     |   65 ++++++++++----------
 7 files changed, 91 insertions(+), 95 deletions(-)

diff --git a/Documentation/driver-api/vfio-mediated-device.rst b/Documentation/driver-api/vfio-mediated-device.rst
index eded8719180f..1c57815619fd 100644
--- a/Documentation/driver-api/vfio-mediated-device.rst
+++ b/Documentation/driver-api/vfio-mediated-device.rst
@@ -114,11 +114,11 @@ to register and unregister itself with the core driver:
 
 * Register::
 
-    extern int  mdev_register_driver(struct mdev_driver *drv);
+    int mdev_register_driver(struct mdev_driver *drv);
 
 * Unregister::
 
-    extern void mdev_unregister_driver(struct mdev_driver *drv);
+    void mdev_unregister_driver(struct mdev_driver *drv);
 
 The mediated bus driver's probe function should create a vfio_device on top of
 the mdev_device and connect it to an appropriate implementation of
@@ -127,8 +127,8 @@ vfio_device_ops.
 When a driver wants to add the GUID creation sysfs to an existing device it has
 probe'd to then it should call::
 
-	extern int  mdev_register_device(struct device *dev,
-	                                 struct mdev_driver *mdev_driver);
+    int mdev_register_device(struct device *dev,
+                             struct mdev_driver *mdev_driver);
 
 This will provide the 'mdev_supported_types/XX/create' files which can then be
 used to trigger the creation of a mdev_device. The created mdev_device will be
@@ -136,7 +136,7 @@ attached to the specified driver.
 
 When the driver needs to remove itself it calls::
 
-	extern void mdev_unregister_device(struct device *dev);
+    void mdev_unregister_device(struct device *dev);
 
 Which will unbind and destroy all the created mdevs and remove the sysfs files.
 
diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_cp.h
index e4c436199b4c..3194d887e08e 100644
--- a/drivers/s390/cio/vfio_ccw_cp.h
+++ b/drivers/s390/cio/vfio_ccw_cp.h
@@ -41,11 +41,11 @@ struct channel_program {
 	struct ccw1 *guest_cp;
 };
 
-extern int cp_init(struct channel_program *cp, union orb *orb);
-extern void cp_free(struct channel_program *cp);
-extern int cp_prefetch(struct channel_program *cp);
-extern union orb *cp_get_orb(struct channel_program *cp, u32 intparm, u8 lpm);
-extern void cp_update_scsw(struct channel_program *cp, union scsw *scsw);
-extern bool cp_iova_pinned(struct channel_program *cp, u64 iova);
+int cp_init(struct channel_program *cp, union orb *orb);
+void cp_free(struct channel_program *cp);
+int cp_prefetch(struct channel_program *cp);
+union orb *cp_get_orb(struct channel_program *cp, u32 intparm, u8 lpm);
+void cp_update_scsw(struct channel_program *cp, union scsw *scsw);
+bool cp_iova_pinned(struct channel_program *cp, u64 iova);
 
 #endif
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 7272eb788612..b7163bac8cc7 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -119,10 +119,10 @@ struct vfio_ccw_private {
 	struct work_struct	crw_work;
 } __aligned(8);
 
-extern int vfio_ccw_mdev_reg(struct subchannel *sch);
-extern void vfio_ccw_mdev_unreg(struct subchannel *sch);
+int vfio_ccw_mdev_reg(struct subchannel *sch);
+void vfio_ccw_mdev_unreg(struct subchannel *sch);
 
-extern int vfio_ccw_sch_quiesce(struct subchannel *sch);
+int vfio_ccw_sch_quiesce(struct subchannel *sch);
 
 extern struct mdev_driver vfio_ccw_mdev_driver;
 
diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc_private.h b/drivers/vfio/fsl-mc/vfio_fsl_mc_private.h
index 4ad63ececb91..7a29f572f93d 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc_private.h
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_private.h
@@ -39,7 +39,7 @@ struct vfio_fsl_mc_device {
 	struct vfio_fsl_mc_irq      *mc_irqs;
 };
 
-extern int vfio_fsl_mc_set_irqs_ioctl(struct vfio_fsl_mc_device *vdev,
+int vfio_fsl_mc_set_irqs_ioctl(struct vfio_fsl_mc_device *vdev,
 			       u32 flags, unsigned int index,
 			       unsigned int start, unsigned int count,
 			       void *data);
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 520d2a8e8375..691b43f4b2b2 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -78,21 +78,20 @@ struct vfio_platform_reset_node {
 	vfio_platform_reset_fn_t of_reset;
 };
 
-extern int vfio_platform_probe_common(struct vfio_platform_device *vdev,
-				      struct device *dev);
+int vfio_platform_probe_common(struct vfio_platform_device *vdev,
+			       struct device *dev);
 void vfio_platform_remove_common(struct vfio_platform_device *vdev);
 
-extern int vfio_platform_irq_init(struct vfio_platform_device *vdev);
-extern void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev);
+int vfio_platform_irq_init(struct vfio_platform_device *vdev);
+void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev);
 
-extern int vfio_platform_set_irqs_ioctl(struct vfio_platform_device *vdev,
-					uint32_t flags, unsigned index,
-					unsigned start, unsigned count,
-					void *data);
+int vfio_platform_set_irqs_ioctl(struct vfio_platform_device *vdev,
+				 uint32_t flags, unsigned index,
+				 unsigned start, unsigned count, void *data);
 
-extern void __vfio_platform_register_reset(struct vfio_platform_reset_node *n);
-extern void vfio_platform_unregister_reset(const char *compat,
-					   vfio_platform_reset_fn_t fn);
+void __vfio_platform_register_reset(struct vfio_platform_reset_node *n);
+void vfio_platform_unregister_reset(const char *compat,
+				    vfio_platform_reset_fn_t fn);
 #define vfio_platform_register_reset(__compat, __reset)		\
 static struct vfio_platform_reset_node __reset ## _node = {	\
 	.owner = THIS_MODULE,					\
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index aa888cc51757..49580fa2073a 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -140,19 +140,19 @@ int vfio_mig_get_next_state(struct vfio_device *device,
 /*
  * External user API
  */
-extern struct iommu_group *vfio_file_iommu_group(struct file *file);
-extern bool vfio_file_enforced_coherent(struct file *file);
-extern void vfio_file_set_kvm(struct file *file, struct kvm *kvm);
-extern bool vfio_file_has_dev(struct file *file, struct vfio_device *device);
+struct iommu_group *vfio_file_iommu_group(struct file *file);
+bool vfio_file_enforced_coherent(struct file *file);
+void vfio_file_set_kvm(struct file *file, struct kvm *kvm);
+bool vfio_file_has_dev(struct file *file, struct vfio_device *device);
 
 #define VFIO_PIN_PAGES_MAX_ENTRIES	(PAGE_SIZE/sizeof(unsigned long))
 
-extern int vfio_pin_pages(struct vfio_device *device, unsigned long *user_pfn,
-			  int npage, int prot, unsigned long *phys_pfn);
-extern int vfio_unpin_pages(struct vfio_device *device, unsigned long *user_pfn,
-			    int npage);
-extern int vfio_dma_rw(struct vfio_device *device, dma_addr_t user_iova,
-		       void *data, size_t len, bool write);
+int vfio_pin_pages(struct vfio_device *device, unsigned long *user_pfn,
+		   int npage, int prot, unsigned long *phys_pfn);
+int vfio_unpin_pages(struct vfio_device *device, unsigned long *user_pfn,
+		     int npage);
+int vfio_dma_rw(struct vfio_device *device, dma_addr_t user_iova,
+		void *data, size_t len, bool write);
 
 /* each type has independent events */
 enum vfio_notify_type {
@@ -162,13 +162,13 @@ enum vfio_notify_type {
 /* events for VFIO_IOMMU_NOTIFY */
 #define VFIO_IOMMU_NOTIFY_DMA_UNMAP	BIT(0)
 
-extern int vfio_register_notifier(struct vfio_device *device,
-				  enum vfio_notify_type type,
-				  unsigned long *required_events,
-				  struct notifier_block *nb);
-extern int vfio_unregister_notifier(struct vfio_device *device,
-				    enum vfio_notify_type type,
-				    struct notifier_block *nb);
+int vfio_register_notifier(struct vfio_device *device,
+			   enum vfio_notify_type type,
+			   unsigned long *required_events,
+			   struct notifier_block *nb);
+int vfio_unregister_notifier(struct vfio_device *device,
+			     enum vfio_notify_type type,
+			     struct notifier_block *nb);
 
 
 /*
@@ -178,25 +178,24 @@ struct vfio_info_cap {
 	struct vfio_info_cap_header *buf;
 	size_t size;
 };
-extern struct vfio_info_cap_header *vfio_info_cap_add(
-		struct vfio_info_cap *caps, size_t size, u16 id, u16 version);
-extern void vfio_info_cap_shift(struct vfio_info_cap *caps, size_t offset);
+struct vfio_info_cap_header *vfio_info_cap_add(struct vfio_info_cap *caps,
+					       size_t size, u16 id,
+					       u16 version);
+void vfio_info_cap_shift(struct vfio_info_cap *caps, size_t offset);
 
-extern int vfio_info_add_capability(struct vfio_info_cap *caps,
-				    struct vfio_info_cap_header *cap,
-				    size_t size);
+int vfio_info_add_capability(struct vfio_info_cap *caps,
+			     struct vfio_info_cap_header *cap, size_t size);
 
-extern int vfio_set_irqs_validate_and_prepare(struct vfio_irq_set *hdr,
-					      int num_irqs, int max_irq_type,
-					      size_t *data_size);
+int vfio_set_irqs_validate_and_prepare(struct vfio_irq_set *hdr,
+				       int num_irqs, int max_irq_type,
+				       size_t *data_size);
 
 struct pci_dev;
 #if IS_ENABLED(CONFIG_VFIO_SPAPR_EEH)
-extern void vfio_spapr_pci_eeh_open(struct pci_dev *pdev);
-extern void vfio_spapr_pci_eeh_release(struct pci_dev *pdev);
-extern long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
-				       unsigned int cmd,
-				       unsigned long arg);
+void vfio_spapr_pci_eeh_open(struct pci_dev *pdev);
+void vfio_spapr_pci_eeh_release(struct pci_dev *pdev);
+long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group, unsigned int cmd,
+				unsigned long arg);
 #else
 static inline void vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
 {
@@ -230,10 +229,9 @@ struct virqfd {
 	struct virqfd		**pvirqfd;
 };
 
-extern int vfio_virqfd_enable(void *opaque,
-			      int (*handler)(void *, void *),
-			      void (*thread)(void *, void *),
-			      void *data, struct virqfd **pvirqfd, int fd);
-extern void vfio_virqfd_disable(struct virqfd **pvirqfd);
+int vfio_virqfd_enable(void *opaque, int (*handler)(void *, void *),
+		       void (*thread)(void *, void *), void *data,
+		       struct virqfd **pvirqfd, int fd);
+void vfio_virqfd_disable(struct virqfd **pvirqfd);
 
 #endif /* VFIO_H */
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 23c176d4b073..22de2bce6394 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -147,23 +147,23 @@ struct vfio_pci_core_device {
 #define is_irq_none(vdev) (!(is_intx(vdev) || is_msi(vdev) || is_msix(vdev)))
 #define irq_is(vdev, type) (vdev->irq_type == type)
 
-extern void vfio_pci_intx_mask(struct vfio_pci_core_device *vdev);
-extern void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev);
+void vfio_pci_intx_mask(struct vfio_pci_core_device *vdev);
+void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev);
 
-extern int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev,
-				   uint32_t flags, unsigned index,
-				   unsigned start, unsigned count, void *data);
+int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev,
+			    uint32_t flags, unsigned index,
+			    unsigned start, unsigned count, void *data);
 
-extern ssize_t vfio_pci_config_rw(struct vfio_pci_core_device *vdev,
-				  char __user *buf, size_t count,
-				  loff_t *ppos, bool iswrite);
+ssize_t vfio_pci_config_rw(struct vfio_pci_core_device *vdev,
+			   char __user *buf, size_t count,
+			   loff_t *ppos, bool iswrite);
 
-extern ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
-			       size_t count, loff_t *ppos, bool iswrite);
+ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
+			size_t count, loff_t *ppos, bool iswrite);
 
 #ifdef CONFIG_VFIO_PCI_VGA
-extern ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
-			       size_t count, loff_t *ppos, bool iswrite);
+ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
+			size_t count, loff_t *ppos, bool iswrite);
 #else
 static inline ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev,
 				      char __user *buf, size_t count,
@@ -173,32 +173,31 @@ static inline ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev,
 }
 #endif
 
-extern long vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
-			       uint64_t data, int count, int fd);
+long vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
+			uint64_t data, int count, int fd);
 
-extern int vfio_pci_init_perm_bits(void);
-extern void vfio_pci_uninit_perm_bits(void);
+int vfio_pci_init_perm_bits(void);
+void vfio_pci_uninit_perm_bits(void);
 
-extern int vfio_config_init(struct vfio_pci_core_device *vdev);
-extern void vfio_config_free(struct vfio_pci_core_device *vdev);
+int vfio_config_init(struct vfio_pci_core_device *vdev);
+void vfio_config_free(struct vfio_pci_core_device *vdev);
 
-extern int vfio_pci_register_dev_region(struct vfio_pci_core_device *vdev,
-					unsigned int type, unsigned int subtype,
-					const struct vfio_pci_regops *ops,
-					size_t size, u32 flags, void *data);
+int vfio_pci_register_dev_region(struct vfio_pci_core_device *vdev,
+				 unsigned int type, unsigned int subtype,
+				 const struct vfio_pci_regops *ops,
+				 size_t size, u32 flags, void *data);
 
-extern int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev,
-				    pci_power_t state);
+int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev,
+			     pci_power_t state);
 
-extern bool __vfio_pci_memory_enabled(struct vfio_pci_core_device *vdev);
-extern void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device
-						    *vdev);
-extern u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
-extern void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev,
-					       u16 cmd);
+bool __vfio_pci_memory_enabled(struct vfio_pci_core_device *vdev);
+void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev);
+u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
+void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev,
+					u16 cmd);
 
 #ifdef CONFIG_VFIO_PCI_IGD
-extern int vfio_pci_igd_init(struct vfio_pci_core_device *vdev);
+int vfio_pci_igd_init(struct vfio_pci_core_device *vdev);
 #else
 static inline int vfio_pci_igd_init(struct vfio_pci_core_device *vdev)
 {
@@ -207,8 +206,8 @@ static inline int vfio_pci_igd_init(struct vfio_pci_core_device *vdev)
 #endif
 
 #ifdef CONFIG_S390
-extern int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
-				       struct vfio_info_cap *caps);
+int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
+				struct vfio_info_cap *caps);
 #else
 static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
 					      struct vfio_info_cap *caps)


