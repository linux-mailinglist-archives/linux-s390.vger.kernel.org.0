Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE28530ADBC
	for <lists+linux-s390@lfdr.de>; Mon,  1 Feb 2021 18:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhBAR0c (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 1 Feb 2021 12:26:32 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:2359 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhBAR03 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Feb 2021 12:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1612200390; x=1643736390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=UFK1IsfiUbDjOVHOm6bYAdugSWEZJc1B4mmsE5imG+8=;
  b=n/q3G9Ju7GaZlLtfENFjTbKFbZHdFZcsVJ7EYV+hPXLmX4uY/1Cqn5sq
   jv3FidhTrCXkd6LRZennKL7k7p8REM99bUpPv38ceWO0cDYTk2VF5SobZ
   VQRX9x7ueUy26lOuLAtBhSvqnhr0onK6CgzeAZCSEj5r7WR6hiLg/UAH0
   g=;
X-IronPort-AV: E=Sophos;i="5.79,393,1602547200"; 
   d="scan'208";a="116237826"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 01 Feb 2021 17:25:56 +0000
Received: from EX13D08EUB004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id 2E893A01A4;
        Mon,  1 Feb 2021 17:25:53 +0000 (UTC)
Received: from uf6ed9c851f4556.ant.amazon.com (10.43.161.253) by
 EX13D08EUB004.ant.amazon.com (10.43.166.158) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 1 Feb 2021 17:25:38 +0000
From:   Adrian Catangiu <acatan@amazon.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
        <linux-s390@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <graf@amazon.com>,
        <rdunlap@infradead.org>, <arnd@arndb.de>, <ebiederm@xmission.com>,
        <rppt@kernel.org>, <0x7f454c46@gmail.com>,
        <borntraeger@de.ibm.com>, <Jason@zx2c4.com>, <jannh@google.com>,
        <w@1wt.eu>, <colmmacc@amazon.com>, <luto@kernel.org>,
        <tytso@mit.edu>, <ebiggers@kernel.org>, <dwmw@amazon.co.uk>,
        <bonzini@gnu.org>, <sblbir@amazon.com>, <raduweis@amazon.com>,
        <corbet@lwn.net>, <mst@redhat.com>, <mhocko@kernel.org>,
        <rafael@kernel.org>, <pavel@ucw.cz>, <mpe@ellerman.id.au>,
        <areber@redhat.com>, <ovzxemul@gmail.com>, <avagin@gmail.com>,
        <ptikhomirov@virtuozzo.com>, <gil@azul.com>, <asmehra@redhat.com>,
        <dgunigun@redhat.com>, <vijaysun@ca.ibm.com>, <oridgar@gmail.com>,
        <ghammer@redhat.com>, Adrian Catangiu <acatan@amazon.com>
Subject: [PATCH v5 2/2] drivers/virt: vmgenid: add vm generation id driver
Date:   Mon, 1 Feb 2021 19:24:54 +0200
Message-ID: <1612200294-17561-3-git-send-email-acatan@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612200294-17561-1-git-send-email-acatan@amazon.com>
References: <1612200294-17561-1-git-send-email-acatan@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.253]
X-ClientProxiedBy: EX13D24UWB002.ant.amazon.com (10.43.161.159) To
 EX13D08EUB004.ant.amazon.com (10.43.166.158)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

- Background

The VM Generation ID is a feature defined by Microsoft (paper:
http://go.microsoft.com/fwlink/?LinkId=260709) and supported by
multiple hypervisor vendors.

The feature can be used to drive the `sysgenid` mechanism required in
virtualized environments by software that works with local copies and
caches of world-unique data such as random values, uuids, monotonically
increasing counters, etc.

- Solution

The VM Generation ID is a hypervisor/hardware provided 128-bit unique
ID that changes each time the VM is restored from a snapshot. It can be
used to differentiate between VMs or different generations of the same
VM.
This VM Generation ID is exposed through an ACPI device by multiple
hypervisor vendors.

The `vmgenid` driver uses ACPI events to be notified by hardware
changes to the 128-bit Vm Gen Id HW UUID. The UUID is not exposed to
userspace, it is added by the driver as device randomness to improve
kernel entropy following VM snapshot events.

This driver also acts as a backend for the `sysgenid` kernel module
(`drivers/misc/sysgenid.c`, `Documentation/misc-devices/sysgenid.rst`)
to drive changes to the "System Generation Id" which is further exposed
to userspace as a system-wide monotonically increasing counter.

This patch builds on top of Or Idgar <oridgar@gmail.com>'s proposal
https://lkml.org/lkml/2018/3/1/498

Signed-off-by: Adrian Catangiu <acatan@amazon.com>
---
 Documentation/virt/vmgenid.rst |  34 +++++++++
 MAINTAINERS                    |   7 ++
 drivers/virt/Kconfig           |  14 ++++
 drivers/virt/Makefile          |   1 +
 drivers/virt/vmgenid.c         | 153 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 209 insertions(+)
 create mode 100644 Documentation/virt/vmgenid.rst
 create mode 100644 drivers/virt/vmgenid.c

diff --git a/Documentation/virt/vmgenid.rst b/Documentation/virt/vmgenid.rst
new file mode 100644
index 0000000..2106354
--- /dev/null
+++ b/Documentation/virt/vmgenid.rst
@@ -0,0 +1,34 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======
+VMGENID
+=======
+
+The VM Generation ID is a feature defined by Microsoft (paper:
+http://go.microsoft.com/fwlink/?LinkId=260709) and supported by
+multiple hypervisor vendors.
+
+The feature is required in virtualized environments by applications
+that work with local copies/caches of world-unique data such as random
+values, UUIDs, monotonically increasing counters, etc.
+Such applications can be negatively affected by VM snapshotting when
+the VM is either cloned or returned to an earlier point in time.
+
+The VM Generation ID is a simple concept meant to alleviate the issue
+by providing a unique ID that changes each time the VM is restored
+from a snapshot. The hardware provided UUID value can be used to
+differentiate between VMs or different generations of the same VM.
+
+The VM Generation ID is exposed through an ACPI device by multiple
+hypervisor vendors. The driver for it lives at
+``drivers/virt/vmgenid.c``
+
+The ``vmgenid`` driver uses ACPI events to be notified by hardware
+changes to the 128-bit Vm Gen Id UUID. This UUID is not exposed to
+userspace, it is added by the driver as device randomness to improve
+kernel entropy following VM snapshot events.
+
+This driver also acts as a backend for the ``sysgenid`` kernel module
+(``drivers/misc/sysgenid.c``, ``Documentation/misc-devices/sysgenid.rst``)
+to drive changes to the "System Generation Id" which is further exposed
+to userspace as a monotonically increasing counter.
diff --git a/MAINTAINERS b/MAINTAINERS
index f1158b0..4615612 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19009,6 +19009,13 @@ F:	drivers/staging/vme/
 F:	drivers/vme/
 F:	include/linux/vme*
 
+VMGENID
+M:	Adrian Catangiu <acatan@amazon.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	Documentation/virt/vmgenid.rst
+F:	drivers/virt/vmgenid.c
+
 VMWARE BALLOON DRIVER
 M:	Nadav Amit <namit@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 80c5f9c1..4771633 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -13,6 +13,20 @@ menuconfig VIRT_DRIVERS
 
 if VIRT_DRIVERS
 
+config VMGENID
+	tristate "Virtual Machine Generation ID driver"
+	depends on ACPI && SYSGENID
+	default N
+	help
+	  The driver uses the hypervisor provided Virtual Machine Generation ID
+	  to drive the system generation counter mechanism exposed by sysgenid.
+	  The vmgenid changes on VM snapshots or VM cloning. The hypervisor
+	  provided 128-bit vmgenid is also used as device randomness to improve
+	  kernel entropy following VM snapshot events.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called vmgenid.
+
 config FSL_HV_MANAGER
 	tristate "Freescale hypervisor management driver"
 	depends on FSL_SOC
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index f28425c..889be01 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_FSL_HV_MANAGER)	+= fsl_hypervisor.o
+obj-$(CONFIG_VMGENID)		+= vmgenid.o
 obj-y				+= vboxguest/
 
 obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
new file mode 100644
index 0000000..d9d089a
--- /dev/null
+++ b/drivers/virt/vmgenid.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Virtual Machine Generation ID driver
+ *
+ * Copyright (C) 2018 Red Hat Inc. All rights reserved.
+ *
+ * Copyright (C) 2020 Amazon. All rights reserved.
+ *
+ *	Authors:
+ *	  Adrian Catangiu <acatan@amazon.com>
+ *	  Or Idgar <oridgar@gmail.com>
+ *	  Gal Hammer <ghammer@redhat.com>
+ *
+ */
+#include <linux/acpi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/random.h>
+#include <linux/uuid.h>
+#include <linux/sysgenid.h>
+
+#define DEV_NAME "vmgenid"
+ACPI_MODULE_NAME(DEV_NAME);
+
+struct vmgenid_data {
+	uuid_t uuid;
+	void *uuid_iomap;
+};
+static struct vmgenid_data vmgenid_data;
+
+static int vmgenid_acpi_map(struct vmgenid_data *priv, acpi_handle handle)
+{
+	int i;
+	phys_addr_t phys_addr;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_status status;
+	union acpi_object *pss;
+	union acpi_object *element;
+
+	status = acpi_evaluate_object(handle, "ADDR", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status, "Evaluating ADDR"));
+		return -ENODEV;
+	}
+	pss = buffer.pointer;
+	if (!pss || pss->type != ACPI_TYPE_PACKAGE || pss->package.count != 2)
+		return -EINVAL;
+
+	phys_addr = 0;
+	for (i = 0; i < pss->package.count; i++) {
+		element = &(pss->package.elements[i]);
+		if (element->type != ACPI_TYPE_INTEGER)
+			return -EINVAL;
+		phys_addr |= element->integer.value << i * 32;
+	}
+
+	priv->uuid_iomap = acpi_os_map_memory(phys_addr, sizeof(uuid_t));
+	if (!priv->uuid_iomap) {
+		pr_err("Could not map memory at 0x%llx, size %u\n",
+			   phys_addr,
+			   (u32) sizeof(uuid_t));
+		return -ENOMEM;
+	}
+
+	memcpy_fromio(&priv->uuid, priv->uuid_iomap, sizeof(uuid_t));
+
+	return 0;
+}
+
+static int vmgenid_acpi_add(struct acpi_device *device)
+{
+	int ret;
+
+	if (!device)
+		return -EINVAL;
+	device->driver_data = &vmgenid_data;
+
+	ret = vmgenid_acpi_map(device->driver_data, device->handle);
+	if (ret < 0) {
+		pr_err("vmgenid: failed to map acpi device\n");
+		device->driver_data = NULL;
+	}
+
+	return ret;
+}
+
+static int vmgenid_acpi_remove(struct acpi_device *device)
+{
+	if (!device || acpi_driver_data(device) != &vmgenid_data)
+		return -EINVAL;
+	device->driver_data = NULL;
+
+	if (vmgenid_data.uuid_iomap)
+		acpi_os_unmap_memory(vmgenid_data.uuid_iomap, sizeof(uuid_t));
+	vmgenid_data.uuid_iomap = NULL;
+
+	return 0;
+}
+
+static void vmgenid_acpi_notify(struct acpi_device *device, u32 event)
+{
+	uuid_t old_uuid;
+
+	if (!device || acpi_driver_data(device) != &vmgenid_data) {
+		pr_err("VMGENID notify with unexpected driver private data\n");
+		return;
+	}
+
+	/* update VM Generation UUID */
+	old_uuid = vmgenid_data.uuid;
+	memcpy_fromio(&vmgenid_data.uuid, vmgenid_data.uuid_iomap, sizeof(uuid_t));
+
+	if (memcmp(&old_uuid, &vmgenid_data.uuid, sizeof(uuid_t))) {
+		/* HW uuid updated */
+		sysgenid_bump_generation();
+		add_device_randomness(&vmgenid_data.uuid, sizeof(uuid_t));
+	}
+}
+
+static const struct acpi_device_id vmgenid_ids[] = {
+	{"VMGENID", 0},
+	{"QEMUVGID", 0},
+	{"", 0},
+};
+
+static struct acpi_driver acpi_vmgenid_driver = {
+	.name = "vm_generation_id",
+	.ids = vmgenid_ids,
+	.owner = THIS_MODULE,
+	.ops = {
+		.add = vmgenid_acpi_add,
+		.remove = vmgenid_acpi_remove,
+		.notify = vmgenid_acpi_notify,
+	}
+};
+
+static int __init vmgenid_init(void)
+{
+	return acpi_bus_register_driver(&acpi_vmgenid_driver);
+}
+
+static void __exit vmgenid_exit(void)
+{
+	acpi_bus_unregister_driver(&acpi_vmgenid_driver);
+}
+
+module_init(vmgenid_init);
+module_exit(vmgenid_exit);
+
+MODULE_AUTHOR("Adrian Catangiu");
+MODULE_DESCRIPTION("Virtual Machine Generation ID");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("0.1");
-- 
2.7.4




Amazon Development Center (Romania) S.R.L. registered office: 27A Sf. Lazar Street, UBC5, floor 2, Iasi, Iasi County, 700045, Romania. Registered in Romania. Registration number J22/2621/2005.

