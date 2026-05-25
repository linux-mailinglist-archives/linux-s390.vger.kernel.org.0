Return-Path: <linux-s390+bounces-20032-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMgDAJ1wFGrNNQcAu9opvQ
	(envelope-from <linux-s390+bounces-20032-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 25 May 2026 17:54:05 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6033C5CC8DA
	for <lists+linux-s390@lfdr.de>; Mon, 25 May 2026 17:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB756302D944
	for <lists+linux-s390@lfdr.de>; Mon, 25 May 2026 15:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9863F54DF;
	Mon, 25 May 2026 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8KczC78"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C38A3F54AC;
	Mon, 25 May 2026 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779724152; cv=none; b=JGcKlhEcEk3WqbUtRTyEiaxM/6jawRRp0aIZrQCUmZ8CTkFQvWUYKAXYKHEBiqjkEda6TwCZ065rPJwTixsgLVPg9ser/3emcmAP4ZiwmGElgS61nyUQqL9rsSSqycMvuUfEDuOOfLHYQFdd5MFtYyvdipia6Vi07yU8rdWRjmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779724152; c=relaxed/simple;
	bh=YZtKoM/a/CTrNr/NXer57PB2adeZTwdJ8R2O9Ner4K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCTULHmfu1L2PgMB+frS5LwjklUj7DM/AIKe1ks82j8czrRn4IoFLMCfe+kT6ORubP+e3lEKFDfQdgV+b+Wzj7hOCDlxzGojGI71E9j2/n0eW7/wN7Q7sHZyVrPzGrHPH5b10m2L1HwrYvU9q2bnL6oY3zgcKOXQjKybB9vwqM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8KczC78; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7131F00ACF;
	Mon, 25 May 2026 15:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779724151;
	bh=7tyAQCrPqe5cIWkqIQCLhlpGkaY0VQtDzrIlPeSjyt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P8KczC78qfEjWLSOdSj1HvCCpcHhE75yOt+uDt5gDqj5nGAgbCBYhTtGILS7swmSr
	 bihI2AdNEyFrpFr5UlT4jp2kNjMq6ctHgKE6NUx8YJB0yC2SS5rn6VP5nUwRNLZZH6
	 jz9Xg1icixIqcEZr6S0/b+Jy4kxicAj2FSygag1JLLtygPKP5xrYeH8OIp1DXEt1zQ
	 /rC2RvsZRJyVaXFPzhO4kMgEwirpLbf1rSBsYpAxd1SrTkPdf9wVcgh7zCvNJVpWtH
	 NO4Dsu5ljhO1AK2kfj1JOg75Af3YCVufxSlvjWeHFeIUc56zlvTGboiQuPFXqLmMnj
	 iX4yc/e5Np+zg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tony Krowiak <akrowiak@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH v5 3/5] iommufd/viommu: Keep a reference to the KVM file
Date: Mon, 25 May 2026 21:18:14 +0530
Message-ID: <20260525154816.1029642-4-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
References: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20032-lists,linux-s390=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aneesh.kumar@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 6033C5CC8DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nicolin Chen <nicolinc@nvidia.com>

The TSM vDevice operations need access to the KVM associated with the
device's vIOMMU. Save the device's KVM file in the iommufd_viommu when the
vIOMMU is allocated, and take a file reference so it remains valid for the
lifetime of the vIOMMU.

Release the reference when the vIOMMU is destroyed.

Based on an original patch by Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

[nicolinc: hold kvm's users_count]
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
[aneesh.kumar: Switch to use kvm_file]
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/viommu.c | 5 +++++
 include/linux/iommufd.h        | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 4081deda9b33..bf5d58d55939 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
  */
+#include <linux/file.h>
 #include "iommufd_private.h"
 
 void iommufd_viommu_destroy(struct iommufd_object *obj)
@@ -11,6 +12,8 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 	if (viommu->ops && viommu->ops->destroy)
 		viommu->ops->destroy(viommu);
 	refcount_dec(&viommu->hwpt->common.obj.users);
+	if (viommu->kvm_file)
+		fput(viommu->kvm_file);
 	xa_destroy(&viommu->vdevs);
 }
 
@@ -76,6 +79,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	}
 
 	xa_init(&viommu->vdevs);
+	if (idev->kvm_file)
+		viommu->kvm_file = get_file(idev->kvm_file);
 	viommu->type = cmd->type;
 	viommu->ictx = ucmd->ictx;
 	viommu->hwpt = hwpt_paging;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 0a0bb4abfbd2..3267717f676d 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -103,6 +103,7 @@ struct iommufd_viommu {
 	struct iommufd_ctx *ictx;
 	struct iommu_device *iommu_dev;
 	struct iommufd_hwpt_paging *hwpt;
+	struct file *kvm_file;
 
 	const struct iommufd_viommu_ops *ops;
 
-- 
2.43.0


