Return-Path: <linux-s390+bounces-7695-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AA49F1963
	for <lists+linux-s390@lfdr.de>; Fri, 13 Dec 2024 23:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ADD1188A437
	for <lists+linux-s390@lfdr.de>; Fri, 13 Dec 2024 22:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A891E3DEF;
	Fri, 13 Dec 2024 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UAw76aLS"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D8F1974EA;
	Fri, 13 Dec 2024 22:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734130205; cv=none; b=n+EfHrVzmn4pWoFYa2zu5JuWGv1UoA5EyWvLj2xW8WHmZA/FzPa/usyZwkUAGpn9xkTfcGk8GIn/mqlGD0WD0uwxaiwGkfW7MBgcQuQO172Vve2qe0zPMHANsGIjJ9QjMDjRG/qRGqgTIhoBcK3e9uSc0AHIQ0yFOkkfPEfcYDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734130205; c=relaxed/simple;
	bh=0QrxwDumdv9ylh/ETp9pcFH7MM4XVeh5MXPIRYyG6vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vo7ipE3PGcJT3+PTcSRGtiYoVS/eOpQWETTwHzOMTxAcsuurnXfhj2BiI39JtvrjdSY9WQakp06YOu07j7gBLMa42Q/6idxjAIR0P+62GRP9+hd1kG3gn7EWg49DZHFsV9nFaL2WFSIVW7Lo/s61K/xZsLuTy2C35i6JJH/9D+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UAw76aLS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDGfGaM026699;
	Fri, 13 Dec 2024 22:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XlZ7QWe3g498nZiSw
	gZp6D/1c5C+8eNDxfmcCpETGq0=; b=UAw76aLSePYWOlnh7yozAwkxQUCLqBZbN
	hukhww4S7xxM7X+dvvgQKjIb1eRybVA4P9MKN3KjH3Cr+rAzklLUUo7t7U2tHXJp
	oiaXuYgZw7bSyXDT0lssSuXciAjKBfsA421LrszGmMqlu4tXuNXzdexdFWnBhrWu
	su/1kOLUSnzyLvgfTzg4VVwAPYoQwuRCEh/E0MnpMXwTGr7G7KEnrkOArNdDfL3D
	kUacNDwAxu9GiV4l6AEAWat2i1xXywdFByOuB7YKi1mNTFdhjBoaj5aVmMxFWZW6
	pV6jBKAO6vaxgOyNQ+1Rb2N3HQgwCMTVwVqbquZpPs12z+PCI5qNA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43g9yhnqwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 22:49:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDIjudC029309;
	Fri, 13 Dec 2024 22:49:51 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43gcprv9vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 22:49:51 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDMno9c26149410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 22:49:50 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03EC85805A;
	Fri, 13 Dec 2024 22:49:50 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C25A58054;
	Fri, 13 Dec 2024 22:49:48 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.107.222])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 22:49:48 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 3/3] iommu/s390: implement iommu passthrough via identity domain
Date: Fri, 13 Dec 2024 17:49:41 -0500
Message-ID: <20241213224941.571060-4-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213224941.571060-1-mjrosato@linux.ibm.com>
References: <20241213224941.571060-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xEitcT7Om9Vv-MH5wyhxCzaQDno0AFNw
X-Proofpoint-ORIG-GUID: xEitcT7Om9Vv-MH5wyhxCzaQDno0AFNw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130159

Enabled via the kernel command-line 'iommu.passthrough=1' option.

Introduce the concept of identity domains to s390-iommu, which relies on
the bus_dma_region to offset identity mappings to the start of the DMA
aperture advertized by CLP.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/pci/pci.c        |  6 ++-
 drivers/iommu/s390-iommu.c | 95 +++++++++++++++++++++++++++++---------
 2 files changed, 76 insertions(+), 25 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 88f72745fa59..758b23331754 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -124,14 +124,16 @@ int zpci_register_ioat(struct zpci_dev *zdev, u8 dmaas,
 	struct zpci_fib fib = {0};
 	u8 cc;
 
-	WARN_ON_ONCE(iota & 0x3fff);
 	fib.pba = base;
 	/* Work around off by one in ISM virt device */
 	if (zdev->pft == PCI_FUNC_TYPE_ISM && limit > base)
 		fib.pal = limit + (1 << 12);
 	else
 		fib.pal = limit;
-	fib.iota = iota | ZPCI_IOTA_RTTO_FLAG;
+	if (iota == 0)
+		fib.iota = iota;
+	else
+		fib.iota = iota | ZPCI_IOTA_RTTO_FLAG;
 	fib.gd = zdev->gisa;
 	cc = zpci_mod_fc(req, &fib, status);
 	if (cc)
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index fbdeded3d48b..3d93a9644fca 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -16,7 +16,7 @@
 
 #include "dma-iommu.h"
 
-static const struct iommu_ops s390_iommu_ops;
+static const struct iommu_ops s390_iommu_ops, s390_iommu_rtr_ops;
 
 static struct kmem_cache *dma_region_table_cache;
 static struct kmem_cache *dma_page_table_cache;
@@ -392,9 +392,11 @@ static int blocking_domain_attach_device(struct iommu_domain *domain,
 		return 0;
 
 	s390_domain = to_s390_domain(zdev->s390_domain);
-	spin_lock_irqsave(&s390_domain->list_lock, flags);
-	list_del_rcu(&zdev->iommu_list);
-	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+	if (zdev->dma_table) {
+		spin_lock_irqsave(&s390_domain->list_lock, flags);
+		list_del_rcu(&zdev->iommu_list);
+		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+	}
 
 	zpci_unregister_ioat(zdev, 0);
 	zdev->dma_table = NULL;
@@ -723,7 +725,13 @@ int zpci_init_iommu(struct zpci_dev *zdev)
 	if (rc)
 		goto out_err;
 
-	rc = iommu_device_register(&zdev->iommu_dev, &s390_iommu_ops, NULL);
+	if (zdev->rtr_avail) {
+		rc = iommu_device_register(&zdev->iommu_dev,
+					   &s390_iommu_rtr_ops, NULL);
+	} else {
+		rc = iommu_device_register(&zdev->iommu_dev, &s390_iommu_ops,
+					   NULL);
+	}
 	if (rc)
 		goto out_sysfs;
 
@@ -787,6 +795,39 @@ static int __init s390_iommu_init(void)
 }
 subsys_initcall(s390_iommu_init);
 
+static int s390_attach_dev_identity(struct iommu_domain *domain,
+				    struct device *dev)
+{
+	struct zpci_dev *zdev = to_zpci_dev(dev);
+	u8 status;
+	int cc;
+
+	blocking_domain_attach_device(&blocking_domain, dev);
+
+	/* If we fail now DMA remains blocked via blocking domain */
+	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
+				0, &status);
+	/*
+	 * If the device is undergoing error recovery the reset code
+	 * will re-establish the new domain.
+	 */
+	if (cc && status != ZPCI_PCI_ST_FUNC_NOT_AVAIL)
+		return -EIO;
+
+	zdev_s390_domain_update(zdev, domain);
+
+	return 0;
+}
+
+static const struct iommu_domain_ops s390_identity_ops = {
+	.attach_dev = s390_attach_dev_identity,
+};
+
+static struct iommu_domain s390_identity_domain = {
+	.type = IOMMU_DOMAIN_IDENTITY,
+	.ops = &s390_identity_ops,
+};
+
 static struct iommu_domain blocking_domain = {
 	.type = IOMMU_DOMAIN_BLOCKED,
 	.ops = &(const struct iommu_domain_ops) {
@@ -794,23 +835,31 @@ static struct iommu_domain blocking_domain = {
 	}
 };
 
-static const struct iommu_ops s390_iommu_ops = {
-	.blocked_domain		= &blocking_domain,
-	.release_domain		= &blocking_domain,
-	.capable = s390_iommu_capable,
-	.domain_alloc_paging = s390_domain_alloc_paging,
-	.probe_device = s390_iommu_probe_device,
-	.device_group = generic_device_group,
-	.pgsize_bitmap = SZ_4K,
-	.get_resv_regions = s390_iommu_get_resv_regions,
-	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= s390_iommu_attach_device,
-		.map_pages	= s390_iommu_map_pages,
-		.unmap_pages	= s390_iommu_unmap_pages,
-		.flush_iotlb_all = s390_iommu_flush_iotlb_all,
-		.iotlb_sync      = s390_iommu_iotlb_sync,
-		.iotlb_sync_map  = s390_iommu_iotlb_sync_map,
-		.iova_to_phys	= s390_iommu_iova_to_phys,
-		.free		= s390_domain_free,
+#define S390_IOMMU_COMMON_OPS() \
+	.blocked_domain		= &blocking_domain, \
+	.release_domain		= &blocking_domain, \
+	.capable = s390_iommu_capable, \
+	.domain_alloc_paging = s390_domain_alloc_paging, \
+	.probe_device = s390_iommu_probe_device, \
+	.device_group = generic_device_group, \
+	.pgsize_bitmap = SZ_4K, \
+	.get_resv_regions = s390_iommu_get_resv_regions, \
+	.default_domain_ops = &(const struct iommu_domain_ops) { \
+		.attach_dev	= s390_iommu_attach_device, \
+		.map_pages	= s390_iommu_map_pages, \
+		.unmap_pages	= s390_iommu_unmap_pages, \
+		.flush_iotlb_all = s390_iommu_flush_iotlb_all, \
+		.iotlb_sync      = s390_iommu_iotlb_sync, \
+		.iotlb_sync_map  = s390_iommu_iotlb_sync_map, \
+		.iova_to_phys	= s390_iommu_iova_to_phys, \
+		.free		= s390_domain_free, \
 	}
+
+static const struct iommu_ops s390_iommu_ops = {
+	S390_IOMMU_COMMON_OPS()
+};
+
+static const struct iommu_ops s390_iommu_rtr_ops = {
+	.identity_domain	= &s390_identity_domain,
+	S390_IOMMU_COMMON_OPS()
 };
-- 
2.47.1


