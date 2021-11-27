Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDC245FB22
	for <lists+linux-s390@lfdr.de>; Sat, 27 Nov 2021 02:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348416AbhK0Bgk (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 26 Nov 2021 20:36:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40700 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348397AbhK0Bei (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 26 Nov 2021 20:34:38 -0500
Message-ID: <20211126232735.790472764@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TGj6QTdrqi/+rBbBw9aAzTJFtE/Dj0UpsCqlfUJ2p/4=;
        b=2D+SHUmxvFSIyLDAUMBXyMoSoxsoW0m7ZTjuzIcfxhVNl6MFov+ApwmvIWse/9fZboaraO
        mZ0wbggtYDNob+MYueK6OIPw6rUgHtdnXHUbGP5LtNQ4GTtt0woBr/jRvz4t2NAPG+r/Xt
        VRNHdYKJFxh/YENdy3lmDVK9T/PTfHxli4OjPKMw7YJljPSR1SMUNaNI/umEwlJ1NibKUH
        jIGQP04XBzAWdqPJqXlvEu63aOn4sAV9t3DOrjRLVk3Z8TC97bHXyb1Vw98ySAKL0cFa7y
        dNqhf2Tfle7S0Z4wkD9mtGUVFOz07YhIftQ2GBxtS+kEjc2x9yJt73sRnCEWaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TGj6QTdrqi/+rBbBw9aAzTJFtE/Dj0UpsCqlfUJ2p/4=;
        b=ONl0VPO/cRjcGngWBIDqKpbroLJYz/w+/+pXOtnyLHi1dWdIosE1PdAgNhxbSz8R8ab+/J
        2tKjJw6/hQNQjgAA==
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
Subject: [patch 25/32] platform-msi: Let core code handle MSI descriptors
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:24:07 +0100 (CET)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use the core functionality for platform MSI interrupt domains. The platform
device MSI interrupt domains will be converted in a later step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/base/platform-msi.c |  112 ++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 64 deletions(-)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -107,57 +107,6 @@ static void platform_msi_update_chip_ops
 		info->flags &= ~MSI_FLAG_LEVEL_CAPABLE;
 }
 
-static void platform_msi_free_descs(struct device *dev, int base, int nvec)
-{
-	struct msi_desc *desc, *tmp;
-
-	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
-		if (desc->msi_index >= base &&
-		    desc->msi_index < (base + nvec)) {
-			list_del(&desc->list);
-			free_msi_entry(desc);
-		}
-	}
-}
-
-static int platform_msi_alloc_descs_with_irq(struct device *dev, int virq,
-					     int nvec)
-{
-	struct msi_desc *desc;
-	int i, base = 0;
-
-	if (!list_empty(dev_to_msi_list(dev))) {
-		desc = list_last_entry(dev_to_msi_list(dev),
-				       struct msi_desc, list);
-		base = desc->msi_index + 1;
-	}
-
-	for (i = 0; i < nvec; i++) {
-		desc = alloc_msi_entry(dev, 1, NULL);
-		if (!desc)
-			break;
-
-		desc->msi_index = base + i;
-		desc->irq = virq ? virq + i : 0;
-
-		list_add_tail(&desc->list, dev_to_msi_list(dev));
-	}
-
-	if (i != nvec) {
-		/* Clean up the mess */
-		platform_msi_free_descs(dev, base, nvec);
-
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static int platform_msi_alloc_descs(struct device *dev, int nvec)
-{
-	return platform_msi_alloc_descs_with_irq(dev, 0, nvec);
-}
-
 /**
  * platform_msi_create_irq_domain - Create a platform MSI interrupt domain
  * @fwnode:		Optional fwnode of the interrupt controller
@@ -180,7 +129,8 @@ struct irq_domain *platform_msi_create_i
 		platform_msi_update_dom_ops(info);
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		platform_msi_update_chip_ops(info);
-	info->flags |= MSI_FLAG_DEV_SYSFS;
+	info->flags |= MSI_FLAG_DEV_SYSFS | MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS |
+		       MSI_FLAG_FREE_MSI_DESCS;
 
 	domain = msi_create_irq_domain(fwnode, info, parent);
 	if (domain)
@@ -262,20 +212,10 @@ int platform_msi_domain_alloc_irqs(struc
 	if (err)
 		return err;
 
-	err = platform_msi_alloc_descs(dev, nvec);
-	if (err)
-		goto out_free_priv_data;
-
 	err = msi_domain_alloc_irqs(dev->msi.domain, dev, nvec);
 	if (err)
-		goto out_free_desc;
-
-	return 0;
+		platform_msi_free_priv_data(dev);
 
-out_free_desc:
-	platform_msi_free_descs(dev, 0, nvec);
-out_free_priv_data:
-	platform_msi_free_priv_data(dev);
 	return err;
 }
 EXPORT_SYMBOL_GPL(platform_msi_domain_alloc_irqs);
@@ -287,7 +227,6 @@ EXPORT_SYMBOL_GPL(platform_msi_domain_al
 void platform_msi_domain_free_irqs(struct device *dev)
 {
 	msi_domain_free_irqs(dev->msi.domain, dev);
-	platform_msi_free_descs(dev, 0, MAX_DEV_MSIS);
 	platform_msi_free_priv_data(dev);
 }
 EXPORT_SYMBOL_GPL(platform_msi_domain_free_irqs);
@@ -361,6 +300,51 @@ struct irq_domain *
 	return NULL;
 }
 
+static void platform_msi_free_descs(struct device *dev, int base, int nvec)
+{
+	struct msi_desc *desc, *tmp;
+
+	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
+		if (desc->msi_index >= base &&
+		    desc->msi_index < (base + nvec)) {
+			list_del(&desc->list);
+			free_msi_entry(desc);
+		}
+	}
+}
+
+static int platform_msi_alloc_descs_with_irq(struct device *dev, int virq,
+					     int nvec)
+{
+	struct msi_desc *desc;
+	int i, base = 0;
+
+	if (!list_empty(dev_to_msi_list(dev))) {
+		desc = list_last_entry(dev_to_msi_list(dev),
+				       struct msi_desc, list);
+		base = desc->msi_index + 1;
+	}
+
+	for (i = 0; i < nvec; i++) {
+		desc = alloc_msi_entry(dev, 1, NULL);
+		if (!desc)
+			break;
+
+		desc->msi_index = base + i;
+		desc->irq = virq + i;
+
+		list_add_tail(&desc->list, dev_to_msi_list(dev));
+	}
+
+	if (i != nvec) {
+		/* Clean up the mess */
+		platform_msi_free_descs(dev, base, nvec);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 /**
  * platform_msi_device_domain_free - Free interrupts associated with a platform-msi
  *				     device domain

