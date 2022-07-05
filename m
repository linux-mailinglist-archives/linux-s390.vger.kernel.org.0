Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556F5567549
	for <lists+linux-s390@lfdr.de>; Tue,  5 Jul 2022 19:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiGERI5 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 5 Jul 2022 13:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiGERIz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Jul 2022 13:08:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E1541C13A;
        Tue,  5 Jul 2022 10:08:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64EC61576;
        Tue,  5 Jul 2022 10:08:54 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 85CBF3F66F;
        Tue,  5 Jul 2022 10:08:52 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/15] iommu/arm-smmu: Clean up bus_set_iommu()
Date:   Tue,  5 Jul 2022 18:08:29 +0100
Message-Id: <e623f02647fee2a9edf761f1ab7f4a84d09aae2c.1657034828.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1657034827.git.robin.murphy@arm.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Stop calling bus_set_iommu() since it's now unnecessary. With device
probes now replayed for every IOMMU instance registration, the whole
sorry ordering workaround for legacy DT bindings goes too, hooray!

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: No change

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 84 +--------------------------
 1 file changed, 2 insertions(+), 82 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 2ed3594f384e..83c9f2144541 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -37,7 +37,6 @@
 #include <linux/ratelimit.h>
 #include <linux/slab.h>
 
-#include <linux/amba/bus.h>
 #include <linux/fsl/mc.h>
 
 #include "arm-smmu.h"
@@ -93,8 +92,6 @@ static struct platform_driver arm_smmu_driver;
 static struct iommu_ops arm_smmu_ops;
 
 #ifdef CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS
-static int arm_smmu_bus_init(struct iommu_ops *ops);
-
 static struct device_node *dev_get_dev_node(struct device *dev)
 {
 	if (dev_is_pci(dev)) {
@@ -180,20 +177,6 @@ static int arm_smmu_register_legacy_master(struct device *dev,
 	kfree(sids);
 	return err;
 }
-
-/*
- * With the legacy DT binding in play, we have no guarantees about
- * probe order, but then we're also not doing default domains, so we can
- * delay setting bus ops until we're sure every possible SMMU is ready,
- * and that way ensure that no probe_device() calls get missed.
- */
-static int arm_smmu_legacy_bus_init(void)
-{
-	if (using_legacy_binding)
-		return arm_smmu_bus_init(&arm_smmu_ops);
-	return 0;
-}
-device_initcall_sync(arm_smmu_legacy_bus_init);
 #else
 static int arm_smmu_register_legacy_master(struct device *dev,
 					   struct arm_smmu_device **smmu)
@@ -2025,52 +2008,6 @@ static int arm_smmu_device_dt_probe(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static int arm_smmu_bus_init(struct iommu_ops *ops)
-{
-	int err;
-
-	/* Oh, for a proper bus abstraction */
-	if (!iommu_present(&platform_bus_type)) {
-		err = bus_set_iommu(&platform_bus_type, ops);
-		if (err)
-			return err;
-	}
-#ifdef CONFIG_ARM_AMBA
-	if (!iommu_present(&amba_bustype)) {
-		err = bus_set_iommu(&amba_bustype, ops);
-		if (err)
-			goto err_reset_platform_ops;
-	}
-#endif
-#ifdef CONFIG_PCI
-	if (!iommu_present(&pci_bus_type)) {
-		err = bus_set_iommu(&pci_bus_type, ops);
-		if (err)
-			goto err_reset_amba_ops;
-	}
-#endif
-#ifdef CONFIG_FSL_MC_BUS
-	if (!iommu_present(&fsl_mc_bus_type)) {
-		err = bus_set_iommu(&fsl_mc_bus_type, ops);
-		if (err)
-			goto err_reset_pci_ops;
-	}
-#endif
-	return 0;
-
-err_reset_pci_ops: __maybe_unused;
-#ifdef CONFIG_PCI
-	bus_set_iommu(&pci_bus_type, NULL);
-#endif
-err_reset_amba_ops: __maybe_unused;
-#ifdef CONFIG_ARM_AMBA
-	bus_set_iommu(&amba_bustype, NULL);
-#endif
-err_reset_platform_ops: __maybe_unused;
-	bus_set_iommu(&platform_bus_type, NULL);
-	return err;
-}
-
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -2187,7 +2124,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
 	if (err) {
 		dev_err(dev, "Failed to register iommu\n");
-		goto err_sysfs_remove;
+		iommu_device_sysfs_remove(&smmu->iommu);
+		return err;
 	}
 
 	platform_set_drvdata(pdev, smmu);
@@ -2205,24 +2143,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		pm_runtime_enable(dev);
 	}
 
-	/*
-	 * For ACPI and generic DT bindings, an SMMU will be probed before
-	 * any device which might need it, so we want the bus ops in place
-	 * ready to handle default domain setup as soon as any SMMU exists.
-	 */
-	if (!using_legacy_binding) {
-		err = arm_smmu_bus_init(&arm_smmu_ops);
-		if (err)
-			goto err_unregister_device;
-	}
-
 	return 0;
-
-err_unregister_device:
-	iommu_device_unregister(&smmu->iommu);
-err_sysfs_remove:
-	iommu_device_sysfs_remove(&smmu->iommu);
-	return err;
 }
 
 static int arm_smmu_device_remove(struct platform_device *pdev)
@@ -2235,7 +2156,6 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
 		dev_notice(&pdev->dev, "disabling translation\n");
 
-	arm_smmu_bus_init(NULL);
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
 
-- 
2.36.1.dirty

