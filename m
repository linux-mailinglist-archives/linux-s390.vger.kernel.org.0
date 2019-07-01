Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60E122EEB4
	for <lists+linux-s390@lfdr.de>; Thu, 30 May 2019 05:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbfE3DtV (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 29 May 2019 23:49:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18047 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729827AbfE3DtU (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 May 2019 23:49:20 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A41468F06A13BCCAA76D;
        Thu, 30 May 2019 11:49:17 +0800 (CST)
Received: from HGHY4L002753561.china.huawei.com (10.133.215.186) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 30 May 2019 11:49:10 +0800
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
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v8 0/7] iommu: enhance IOMMU default DMA mode build options
Date:   Thu, 30 May 2019 11:48:24 +0800
Message-ID: <20190530034831.4184-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.133.215.186]
X-CFilter-Loop: Reflected
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

v7--> v8
1. Split into multiple small patches base on ARCHs or IOMMU drivers.
2. Hide the unsupported build options on the related ARCH or IOMMU.

v6 --> v7:
1. Fix some text editing errors

v5 --> v6:
1. give up adding boot option iommu.dma_mode

v4 --> v5:
As Hanjun and Thomas Gleixner's suggestion:
1. Keep the old ARCH specific boot options no change.
2. Keep build option CONFIG_IOMMU_DEFAULT_PASSTHROUGH no change.

v4:
As Robin Murphy's suggestion:
"It's also not necessarily obvious to the user how this interacts with
IOMMU_DEFAULT_PASSTHROUGH, so if we really do go down this route, maybe it
would be better to refactor the whole lot into a single selection of something
like IOMMU_DEFAULT_MODE anyway."

In this version, I tried to normalize the IOMMU dma mode boot options for all
ARCHs. When IOMMU is enabled, there are 3 dma modes: paasthrough(bypass),
lazy(mapping but defer the IOTLB invalidation), strict. But currently each
ARCHs defined their private boot options, different with each other. For
example, to enable/disable "passthrough", ARM64 use iommu.passthrough=1/0,
X86 use iommu=pt/nopt, PPC/POWERNV use iommu=nobypass.

Zhen Lei (7):
  iommu: enhance IOMMU default DMA mode build options
  x86/dma: use IS_ENABLED() to simplify the code
  s390/pci: add support for IOMMU default DMA mode build options
  powernv/iommu: add support for IOMMU default DMA mode build options
  iommu/vt-d: add support for IOMMU default DMA mode build options
  iommu/amd: add support for IOMMU default DMA mode build options
  ia64: hide build option IOMMU_DEFAULT_PASSTHROUGH

 arch/powerpc/platforms/powernv/pci-ioda.c |  3 +-
 arch/s390/pci/pci_dma.c                   |  2 +-
 arch/x86/kernel/pci-dma.c                 |  7 ++---
 drivers/iommu/Kconfig                     | 46 ++++++++++++++++++++++++++-----
 drivers/iommu/amd_iommu_init.c            |  3 +-
 drivers/iommu/intel-iommu.c               |  2 +-
 drivers/iommu/iommu.c                     |  3 +-
 7 files changed, 49 insertions(+), 17 deletions(-)

-- 
1.8.3


