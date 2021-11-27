Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5466B45FA7A
	for <lists+linux-s390@lfdr.de>; Sat, 27 Nov 2021 02:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348650AbhK0BcP (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 26 Nov 2021 20:32:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40508 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348618AbhK0BaO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 26 Nov 2021 20:30:14 -0500
Message-ID: <20211126232734.472421030@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6oZqwpJI2ncU7744G6NHeAq/N32euzli5OU76GfrY2c=;
        b=VbOWGVVlmOPh1TS4Xrj9D6HgUpfqhO1l7tvsXfDAB558Dk/zPvlxDypDEGGx9osf8hr296
        bAwA0BVTb4lYKXIDqVjJ6nshbcmAHvHOo+CykSD3ReZkz7W8QZFPN7eMv2Hyj8FPH+n0Wq
        0bX9BarnlTgtKPKMSM6EH5sUgvq2T2mXmFLk6W4UfWx6fcH8lGgPr0deLRksEGxZJXgRW4
        omBE+pDbD+4MEnaTdMd1lqKHb6YFnei9Hrhum+a9DSetZpSKuYr13dk+3hGcLb7x4vtRG8
        lyX6joofPA+RE5CY7qX8ebgVqVMzQg7sqx71svxzuCqB0UuqmMmwU2f6oBtzLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6oZqwpJI2ncU7744G6NHeAq/N32euzli5OU76GfrY2c=;
        b=93gGtkcFCzWxBX0p3W9sp7WChxkl2SjuVM2o6t23XDoHdyxAqyRu2I61ljH0okLrgivuoS
        AH6Cxxo+oGNeqdDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: [patch 03/32] genirq/msi: Provide msi_domain_alloc/free_irqs_descs_locked()
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:22:32 +0100 (CET)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Usage sites which do allocations of the MSI descriptors before invoking
msi_domain_alloc_irqs() require to lock the MSI decriptors accross the
operation.

Provide entry points which can be called with the MSI mutex held and lock
the mutex in the existing entry points.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    3 ++
 kernel/irq/msi.c    |   74 ++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 61 insertions(+), 16 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -413,9 +413,12 @@ struct irq_domain *msi_create_irq_domain
 					 struct irq_domain *parent);
 int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec);
+int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,
+				       int nvec);
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			  int nvec);
 void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
+void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev);
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
 
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -691,10 +691,8 @@ int __msi_domain_alloc_irqs(struct irq_d
 		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
 					       dev_to_node(dev), &arg, false,
 					       desc->affinity);
-		if (virq < 0) {
-			ret = msi_handle_pci_fail(domain, desc, allocated);
-			goto cleanup;
-		}
+		if (virq < 0)
+			return msi_handle_pci_fail(domain, desc, allocated);
 
 		for (i = 0; i < desc->nvec_used; i++) {
 			irq_set_msi_desc_off(virq, i, desc);
@@ -728,7 +726,7 @@ int __msi_domain_alloc_irqs(struct irq_d
 		}
 		ret = irq_domain_activate_irq(irq_data, can_reserve);
 		if (ret)
-			goto cleanup;
+			return ret;
 	}
 
 skip_activate:
@@ -743,38 +741,63 @@ int __msi_domain_alloc_irqs(struct irq_d
 		}
 	}
 	return 0;
-
-cleanup:
-	msi_domain_free_irqs(domain, dev);
-	return ret;
 }
 
 /**
- * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
+ * msi_domain_alloc_irqs_descs_locked - Allocate interrupts from a MSI interrupt domain
  * @domain:	The domain to allocate from
  * @dev:	Pointer to device struct of the device for which the interrupts
  *		are allocated
  * @nvec:	The number of interrupts to allocate
  *
+ * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
+ * pair. Use this for MSI irqdomains which implement their own vector
+ * allocation/free.
+ *
  * Return: %0 on success or an error code.
  */
-int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
-			  int nvec)
+int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,
+				       int nvec)
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
 	int ret;
 
+	lockdep_assert_held(&dev->msi.data->mutex);
+
 	ret = ops->domain_alloc_irqs(domain, dev, nvec);
 	if (ret)
-		return ret;
+		goto cleanup;
 
 	if (!(info->flags & MSI_FLAG_DEV_SYSFS))
 		return 0;
 
 	ret = msi_device_populate_sysfs(dev);
 	if (ret)
-		msi_domain_free_irqs(domain, dev);
+		goto cleanup;
+	return 0;
+
+cleanup:
+	msi_domain_free_irqs_descs_locked(domain, dev);
+	return ret;
+}
+
+/**
+ * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
+ * @domain:	The domain to allocate from
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are allocated
+ * @nvec:	The number of interrupts to allocate
+ *
+ * Return: %0 on success or an error code.
+ */
+int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int nvec)
+{
+	int ret;
+
+	msi_lock_descs(dev);
+	ret = msi_domain_alloc_irqs_descs_locked(domain, dev, nvec);
+	msi_unlock_descs(dev);
 	return ret;
 }
 
@@ -804,22 +827,41 @@ void __msi_domain_free_irqs(struct irq_d
 }
 
 /**
- * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated to @dev
+ * msi_domain_free_irqs_descs_locked - Free interrupts from a MSI interrupt @domain associated to @dev
  * @domain:	The domain to managing the interrupts
  * @dev:	Pointer to device struct of the device for which the interrupts
  *		are free
+ *
+ * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
+ * pair. Use this for MSI irqdomains which implement their own vector
+ * allocation.
  */
-void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev)
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
 
+	lockdep_assert_held(&dev->msi.data->mutex);
+
 	if (info->flags & MSI_FLAG_DEV_SYSFS)
 		msi_device_destroy_sysfs(dev);
 	ops->domain_free_irqs(domain, dev);
 }
 
 /**
+ * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated to @dev
+ * @domain:	The domain to managing the interrupts
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are free
+ */
+void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+{
+	msi_lock_descs(dev);
+	msi_domain_free_irqs_descs_locked(domain, dev);
+	msi_unlock_descs(dev);
+}
+
+/**
  * msi_get_domain_info - Get the MSI interrupt domain info for @domain
  * @domain:	The interrupt domain to retrieve data from
  *

