Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E822F6BD04C
	for <lists+linux-s390@lfdr.de>; Thu, 16 Mar 2023 13:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjCPM4l (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 16 Mar 2023 08:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjCPM4c (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Mar 2023 08:56:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E4CA0B26;
        Thu, 16 Mar 2023 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678971373; x=1710507373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ss+PjQUhxjU+laSJWlhUlqNe75tvnb7MmIudub+LfG4=;
  b=YbXOpAsDStqgqsVG9XZCVoekyHYx51Kdd9NUMewD9U51z8WMvj8E6fqs
   lRbnGv8UKjNoijk0aZfiGUiUYk5mgaWNJ863hszSXN4gAbmX3pRjaPi9t
   r+52wNZHCMJe24DHPwCkpG8fX38z8Oc5t211tXH34ErljEyvCCL+IUrXp
   UCimLLVz3mO36etYUrhkOJfJ7kpooe10ZlKWi0xDnwUefYIvlqfZvMplL
   6WrW7y9YFLOKgV8FmZmOccGNq8ZgF6TOZw5j5bKt4r7qhWjcbZktC4w4S
   NiYZMhPGUMmCvpXt0QdETp+9HovOuN2qi/OqvBlZZ2ZQoP6I1OQgg/Arm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10650"; a="336668267"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="336668267"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 05:56:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10650"; a="790277919"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="790277919"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 16 Mar 2023 05:56:10 -0700
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
Subject: [PATCH v7 22/22] docs: vfio: Add vfio device cdev description
Date:   Thu, 16 Mar 2023 05:55:34 -0700
Message-Id: <20230316125534.17216-23-yi.l.liu@intel.com>
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

This gives notes for userspace applications on device cdev usage.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 Documentation/driver-api/vfio.rst | 125 ++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api/vfio.rst
index 363e12c90b87..287e1bdede04 100644
--- a/Documentation/driver-api/vfio.rst
+++ b/Documentation/driver-api/vfio.rst
@@ -239,6 +239,123 @@ group and can access them as follows::
 	/* Gratuitous device reset and go... */
 	ioctl(device, VFIO_DEVICE_RESET);
 
+IOMMUFD and vfio_iommu_type1
+----------------------------
+
+IOMMUFD is the new user API to manage I/O page tables from userspace.
+It intends to be the portal of delivering advanced userspace DMA
+features (nested translation [5], PASID [6], etc.) while being backward
+compatible with the vfio_iommu_type1 driver.  Eventually vfio_iommu_type1
+will be deprecated.
+
+With the backward compatibility, no change is required for legacy VFIO
+drivers or applications to connect a VFIO device to IOMMUFD.
+
+	When CONFIG_IOMMUFD_VFIO_CONTAINER=n, VFIO container still provides
+	/dev/vfio/vfio which connects to vfio_iommu_type1.  To disable VFIO
+	container and vfio_iommu_type1, the administrator could symbol link
+	/dev/vfio/vfio to /dev/iommu to enable VFIO container emulation
+	in IOMMUFD.
+
+	When CONFIG_IOMMUFD_VFIO_CONTAINER=y, IOMMUFD directly provides
+	/dev/vfio/vfio while the VFIO container and vfio_iommu_type1 are
+	explicitly disabled.
+
+VFIO Device cdev
+----------------
+
+Traditionally user acquires a device fd via VFIO_GROUP_GET_DEVICE_FD
+in a VFIO group.
+
+With CONFIG_VFIO_DEVICE_CDEV=y the user can now acquire a device fd
+by directly opening a character device /dev/vfio/devices/vfioX where
+"X" is the number allocated uniquely by VFIO for registered devices.
+
+The cdev only works with IOMMUFD.  Both VFIO drivers and applications
+must adapt to the new cdev security model which requires using
+VFIO_DEVICE_BIND_IOMMUFD to claim DMA ownership before starting to
+actually use the device.  Once BIND succeeds then a VFIO device can
+be fully accessed by the user.
+
+VFIO device cdev doesn't rely on VFIO group/container/iommu drivers.
+Hence those modules can be fully compiled out in an environment
+where no legacy VFIO application exists.
+
+So far SPAPR does not support IOMMUFD yet.  So it cannot support device
+cdev neither.
+
+Device cdev Example
+-------------------
+
+Assume user wants to access PCI device 0000:6a:01.0::
+
+	$ ls /sys/bus/pci/devices/0000:6a:01.0/vfio-dev/
+	vfio0
+
+This device is therefore represented as vfio0.  The user can verify
+its existence::
+
+	$ ls -l /dev/vfio/devices/vfio0
+	crw------- 1 root root 511, 0 Feb 16 01:22 /dev/vfio/devices/vfio0
+	$ cat /sys/bus/pci/devices/0000:6a:01.0/vfio-dev/vfio0/dev
+	511:0
+	$ ls -l /dev/char/511\:0
+	lrwxrwxrwx 1 root root 21 Feb 16 01:22 /dev/char/511:0 -> ../vfio/devices/vfio0
+
+Then provide the user with access to the device if unprivileged
+operation is desired::
+
+	$ chown user:user /dev/vfio/devices/vfio0
+
+Finally the user could get cdev fd by::
+
+	cdev_fd = open("/dev/vfio/devices/vfio0", O_RDWR);
+
+An opened cdev_fd doesn't give the user any permission of accessing
+the device except binding the cdev_fd to an iommufd.  After that point
+then the device is fully accessible including attaching it to an
+IOMMUFD IOAS/HWPT to enable userspace DMA::
+
+	struct vfio_device_bind_iommufd bind = {
+		.argsz = sizeof(bind),
+		.flags = 0,
+	};
+	struct iommu_ioas_alloc alloc_data  = {
+		.size = sizeof(alloc_data),
+		.flags = 0,
+	};
+	struct vfio_device_attach_iommufd_pt attach_data = {
+		.argsz = sizeof(attach_data),
+		.flags = 0,
+	};
+	struct iommu_ioas_map map = {
+		.size = sizeof(map),
+		.flags = IOMMU_IOAS_MAP_READABLE |
+			 IOMMU_IOAS_MAP_WRITEABLE |
+			 IOMMU_IOAS_MAP_FIXED_IOVA,
+		.__reserved = 0,
+	};
+
+	iommufd = open("/dev/iommu", O_RDWR);
+
+	bind.iommufd = iommufd; // negative value means vfio-noiommu mode
+	ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
+
+	ioctl(iommufd, IOMMU_IOAS_ALLOC, &alloc_data);
+	attach_data.pt_id = alloc_data.out_ioas_id;
+	ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
+
+	/* Allocate some space and setup a DMA mapping */
+	map.user_va = (int64_t)mmap(0, 1024 * 1024, PROT_READ | PROT_WRITE,
+				    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	map.iova = 0; /* 1MB starting at 0x0 from device view */
+	map.length = 1024 * 1024;
+	map.ioas_id = alloc_data.out_ioas_id;;
+
+	ioctl(iommufd, IOMMU_IOAS_MAP, &map);
+
+	/* Other device operations as stated in "VFIO Usage Example" */
+
 VFIO User API
 -------------------------------------------------------------------------------
 
@@ -566,3 +683,11 @@ This implementation has some specifics:
 				\-0d.1
 
 	00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 90)
+
+.. [5] Nested translation is an IOMMU feature which supports two stage
+   address translations.  This improves the address translation efficiency
+   in IOMMU virtualization.
+
+.. [6] PASID stands for Process Address Space ID, introduced by PCI
+   Express.  It is a prerequisite for Shared Virtual Addressing (SVA)
+   and Scalable I/O Virtualization (Scalable IOV).
-- 
2.34.1

