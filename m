Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C87440FD
	for <lists+linux-s390@lfdr.de>; Thu, 13 Jun 2019 18:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389330AbfFMQK6 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 13 Jun 2019 12:10:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731240AbfFMIne (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Jun 2019 04:43:34 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E166594E45C93772A88C;
        Thu, 13 Jun 2019 16:43:31 +0800 (CST)
Received: from HGHY4L002753561.china.huawei.com (10.133.215.186) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 13 Jun 2019 16:43:24 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc <linux-doc@vger.kernel.org>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        x86 <x86@kernel.org>, linux-ia64 <linux-ia64@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v9 5/7] iommu/vt-d: add support for IOMMU default DMA mode build options
Date:   Thu, 13 Jun 2019 16:42:38 +0800
Message-ID: <20190613084240.16768-6-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20190613084240.16768-1-thunder.leizhen@huawei.com>
References: <20190613084240.16768-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.133.215.186]
X-CFilter-Loop: Reflected
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The default DMA mode of INTEL IOMMU is LAZY, this patch make it can be
set to STRICT at build time. It can be overridden by boot option.

There is no functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/Kconfig       | 2 +-
 drivers/iommu/intel-iommu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index bfbcaa24e283aad..fd297b0e0330d27 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -79,7 +79,7 @@ choice
 	prompt "IOMMU default DMA mode"
 	depends on IOMMU_API
 	default IOMMU_DEFAULT_PASSTHROUGH if (PPC_POWERNV && PCI)
-	default IOMMU_DEFAULT_LAZY if S390_IOMMU
+	default IOMMU_DEFAULT_LAZY if (INTEL_IOMMU || S390_IOMMU)
 	default IOMMU_DEFAULT_STRICT
 	help
 	  This option allows an IOMMU DMA mode to be chosen at build time, to
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 162b3236e72c3c8..ec5515b7831b23f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -354,7 +354,7 @@ static int domain_detach_iommu(struct dmar_domain *domain,
 
 static int dmar_map_gfx = 1;
 static int dmar_forcedac;
-static int intel_iommu_strict;
+static int intel_iommu_strict = IS_ENABLED(CONFIG_IOMMU_DEFAULT_STRICT);
 static int intel_iommu_superpage = 1;
 static int intel_iommu_sm;
 static int iommu_identity_mapping;
-- 
1.8.3


