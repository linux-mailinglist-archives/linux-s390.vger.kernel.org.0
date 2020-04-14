Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F011A7C93
	for <lists+linux-s390@lfdr.de>; Tue, 14 Apr 2020 15:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502926AbgDNNQM (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 14 Apr 2020 09:16:12 -0400
Received: from 8bytes.org ([81.169.241.247]:35298 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502895AbgDNNQF (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Apr 2020 09:16:05 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D711A672; Tue, 14 Apr 2020 15:15:54 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v2 18/33] iommu/pamu: Convert to probe/release_device() call-backs
Date:   Tue, 14 Apr 2020 15:15:27 +0200
Message-Id: <20200414131542.25608-19-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414131542.25608-1-joro@8bytes.org>
References: <20200414131542.25608-1-joro@8bytes.org>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Convert the PAMU IOMMU driver to use the probe_device() and
release_device() call-backs of iommu_ops, so that the iommu core code
does the group and sysfs setup.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/fsl_pamu_domain.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 06828e2698d5..928d37771ece 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -1016,25 +1016,13 @@ static struct iommu_group *fsl_pamu_device_group(struct device *dev)
 	return group;
 }
 
-static int fsl_pamu_add_device(struct device *dev)
+static struct iommu_device *fsl_pamu_probe_device(struct device *dev)
 {
-	struct iommu_group *group;
-
-	group = iommu_group_get_for_dev(dev);
-	if (IS_ERR(group))
-		return PTR_ERR(group);
-
-	iommu_group_put(group);
-
-	iommu_device_link(&pamu_iommu, dev);
-
-	return 0;
+	return &pamu_iommu;
 }
 
-static void fsl_pamu_remove_device(struct device *dev)
+static void fsl_pamu_release_device(struct device *dev)
 {
-	iommu_device_unlink(&pamu_iommu, dev);
-	iommu_group_remove_device(dev);
 }
 
 static const struct iommu_ops fsl_pamu_ops = {
@@ -1048,8 +1036,8 @@ static const struct iommu_ops fsl_pamu_ops = {
 	.iova_to_phys	= fsl_pamu_iova_to_phys,
 	.domain_set_attr = fsl_pamu_set_domain_attr,
 	.domain_get_attr = fsl_pamu_get_domain_attr,
-	.add_device	= fsl_pamu_add_device,
-	.remove_device	= fsl_pamu_remove_device,
+	.probe_device	= fsl_pamu_probe_device,
+	.release_device	= fsl_pamu_release_device,
 	.device_group   = fsl_pamu_device_group,
 };
 
-- 
2.17.1

