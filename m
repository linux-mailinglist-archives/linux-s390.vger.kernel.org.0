Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD81599BF4
	for <lists+linux-s390@lfdr.de>; Fri, 19 Aug 2022 14:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348984AbiHSMaC (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 19 Aug 2022 08:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348983AbiHSMaB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 19 Aug 2022 08:30:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541C6100F08;
        Fri, 19 Aug 2022 05:30:00 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JBfsCV016808;
        Fri, 19 Aug 2022 12:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=6d5xYz3i348rkn2bGaqNtfW82ghg3p8FmBpjICbEdXA=;
 b=aZapU+t4Mi4RagJWI4Exjx/MUb2jqp6WiuO0ra4VttYlg9B6bh11413jMcrgmJIGVVar
 W8pzijOxW8eKlUzs+W6EO0q7hFZ7hSy0ia/tfeTwkI1S0iRdcTYRmojfjb8Bf48KHwUF
 wNRu1ok1+c847XPi9sQWC42I46ygzCGJwu+H3+AWrVASzGu5HT7HsQeuxXxTer4/cJKv
 fKX6v73RzdjyOLB9i0H0TUIyULf91E2bP4uxSPHGe7G+0uNxblE34KuB+4R7dx5FzP5O
 tfX4zd3QCGW6Ry/itzx2351gkYwgsPwDb5VGAX0wlBhUdiyq2j/94oeUUvGAtjZYSSzj Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j29vc17hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 12:29:57 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27JBlGDn005801;
        Fri, 19 Aug 2022 12:29:56 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j29vc17gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 12:29:56 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27JCKp0L023998;
        Fri, 19 Aug 2022 12:29:54 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3hx37jf84p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 12:29:54 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27JCToKb29884804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 12:29:50 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 962B7A405B;
        Fri, 19 Aug 2022 12:29:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E00DA4054;
        Fri, 19 Aug 2022 12:29:48 +0000 (GMT)
Received: from li-c6ac47cc-293c-11b2-a85c-d421c8e4747b.ibm.com.com (unknown [9.171.40.114])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Aug 2022 12:29:48 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     mjrosato@linux.ibm.com
Cc:     rdunlap@infradead.org, linux-kernel@vger.kernel.org, lkp@intel.com,
        borntraeger@linux.ibm.com, farman@linux.ibm.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, schnelle@linux.ibm.com, frankja@linux.ibm.com,
        alex.williamson@redhat.com, cohuck@redhat.com
Subject: [PATCH v2] KVM: s390: pci: Hook to access KVM lowlevel from VFIO
Date:   Fri, 19 Aug 2022 14:29:45 +0200
Message-Id: <20220819122945.9309-1-pmorel@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gTrCtLvoPBEtCO3MN1Iy94peFugVxJy2
X-Proofpoint-GUID: pTKi6qLsfQA1GRVqUXgg4EIkBHBpht8D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_06,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=915 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190047
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

We have a cross dependency between KVM and VFIO when using
s390 vfio_pci_zdev extensions for PCI passthrough
To be able to keep both subsystem modular we add a registering
hook inside the S390 core code.

This fixes a build problem when VFIO is built-in and KVM is built
as a module.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Fixes: 09340b2fca007 ("KVM: s390: pci: add routines to start/stop interpretive execution")
Cc: <stable@vger.kernel.org>
---
 arch/s390/include/asm/kvm_host.h | 17 ++++++-----------
 arch/s390/kvm/pci.c              | 12 ++++++++----
 arch/s390/pci/Makefile           |  2 +-
 arch/s390/pci/pci_kvm_hook.c     | 11 +++++++++++
 drivers/vfio/pci/vfio_pci_zdev.c |  8 ++++++--
 5 files changed, 32 insertions(+), 18 deletions(-)
 create mode 100644 arch/s390/pci/pci_kvm_hook.c

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index f39092e0ceaa..b1e98a9ed152 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -1038,16 +1038,11 @@ static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
 #define __KVM_HAVE_ARCH_VM_FREE
 void kvm_arch_free_vm(struct kvm *kvm);
 
-#ifdef CONFIG_VFIO_PCI_ZDEV_KVM
-int kvm_s390_pci_register_kvm(struct zpci_dev *zdev, struct kvm *kvm);
-void kvm_s390_pci_unregister_kvm(struct zpci_dev *zdev);
-#else
-static inline int kvm_s390_pci_register_kvm(struct zpci_dev *dev,
-					    struct kvm *kvm)
-{
-	return -EPERM;
-}
-static inline void kvm_s390_pci_unregister_kvm(struct zpci_dev *dev) {}
-#endif
+struct zpci_kvm_hook {
+	int (*kvm_register)(void *opaque, struct kvm *kvm);
+	void (*kvm_unregister)(void *opaque);
+};
+
+extern struct zpci_kvm_hook zpci_kvm_hook;
 
 #endif
diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 4946fb7757d6..bb8c335d17b9 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -431,8 +431,9 @@ static void kvm_s390_pci_dev_release(struct zpci_dev *zdev)
  * available, enable them and let userspace indicate whether or not they will
  * be used (specify SHM bit to disable).
  */
-int kvm_s390_pci_register_kvm(struct zpci_dev *zdev, struct kvm *kvm)
+static int kvm_s390_pci_register_kvm(void *opaque, struct kvm *kvm)
 {
+	struct zpci_dev *zdev = opaque;
 	int rc;
 
 	if (!zdev)
@@ -510,10 +511,10 @@ int kvm_s390_pci_register_kvm(struct zpci_dev *zdev, struct kvm *kvm)
 	kvm_put_kvm(kvm);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(kvm_s390_pci_register_kvm);
 
-void kvm_s390_pci_unregister_kvm(struct zpci_dev *zdev)
+static void kvm_s390_pci_unregister_kvm(void *opaque)
 {
+	struct zpci_dev *zdev = opaque;
 	struct kvm *kvm;
 
 	if (!zdev)
@@ -566,7 +567,6 @@ void kvm_s390_pci_unregister_kvm(struct zpci_dev *zdev)
 
 	kvm_put_kvm(kvm);
 }
-EXPORT_SYMBOL_GPL(kvm_s390_pci_unregister_kvm);
 
 void kvm_s390_pci_init_list(struct kvm *kvm)
 {
@@ -678,6 +678,8 @@ int kvm_s390_pci_init(void)
 
 	spin_lock_init(&aift->gait_lock);
 	mutex_init(&aift->aift_lock);
+	zpci_kvm_hook.kvm_register = kvm_s390_pci_register_kvm;
+	zpci_kvm_hook.kvm_unregister = kvm_s390_pci_unregister_kvm;
 
 	return 0;
 }
@@ -685,6 +687,8 @@ int kvm_s390_pci_init(void)
 void kvm_s390_pci_exit(void)
 {
 	mutex_destroy(&aift->aift_lock);
+	zpci_kvm_hook.kvm_register = NULL;
+	zpci_kvm_hook.kvm_unregister = NULL;
 
 	kfree(aift);
 }
diff --git a/arch/s390/pci/Makefile b/arch/s390/pci/Makefile
index bf557a1b789c..5ae31ca9dd44 100644
--- a/arch/s390/pci/Makefile
+++ b/arch/s390/pci/Makefile
@@ -5,5 +5,5 @@
 
 obj-$(CONFIG_PCI)	+= pci.o pci_irq.o pci_dma.o pci_clp.o pci_sysfs.o \
 			   pci_event.o pci_debug.o pci_insn.o pci_mmio.o \
-			   pci_bus.o
+			   pci_bus.o pci_kvm_hook.o
 obj-$(CONFIG_PCI_IOV)	+= pci_iov.o
diff --git a/arch/s390/pci/pci_kvm_hook.c b/arch/s390/pci/pci_kvm_hook.c
new file mode 100644
index 000000000000..ff34baf50a3e
--- /dev/null
+++ b/arch/s390/pci/pci_kvm_hook.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VFIO ZPCI devices support
+ *
+ * Copyright (C) IBM Corp. 2022.  All rights reserved.
+ *	Author(s): Pierre Morel <pmorel@linux.ibm.com>
+ */
+#include <linux/kvm_host.h>
+
+struct zpci_kvm_hook zpci_kvm_hook;
+EXPORT_SYMBOL_GPL(zpci_kvm_hook);
diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
index e163aa9f6144..0cbdcd14f1c8 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -151,7 +151,10 @@ int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 	if (!vdev->vdev.kvm)
 		return 0;
 
-	return kvm_s390_pci_register_kvm(zdev, vdev->vdev.kvm);
+	if (zpci_kvm_hook.kvm_register)
+		return zpci_kvm_hook.kvm_register(zdev, vdev->vdev.kvm);
+
+	return -ENOENT;
 }
 
 void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
@@ -161,5 +164,6 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
 	if (!zdev || !vdev->vdev.kvm)
 		return;
 
-	kvm_s390_pci_unregister_kvm(zdev);
+	if (zpci_kvm_hook.kvm_unregister)
+		zpci_kvm_hook.kvm_unregister(zdev);
 }
-- 
2.31.1

