Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCA5567E83
	for <lists+linux-s390@lfdr.de>; Wed,  6 Jul 2022 08:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiGFG3K (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 6 Jul 2022 02:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiGFG2q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Jul 2022 02:28:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD64413DC1;
        Tue,  5 Jul 2022 23:28:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoW5OKJ5hh3bK6C3Z/9c7KPnKFPNrgMV1Xmy6pW6Oyt4TXA6DqqeoN2MonWOzyXpVT3nbyr9YE/d5aJd2JzhXVxu6XaJgTD3WT7/fva7zCuXtaOrfFrnt4nhRrO/DHPKP9dZSI3Xr2m76UB8h0l7sGzBTMvL/iAD5CvH4pnINxkrRyCFN/5IAflE/FW8TXsCSdHIesgHYkMrXQwN/uOC+Ih/mEC2a/UyI8IjDkCg5/HwNIDpahsx6KGA1Lyu/wMkofEaLaKtVSg1lnrRAsZXi8sKR5YDb3sR08+qD+doPrUESh81BWhT3qH9jUwHR9rv4LY6bAx8fgY4DDDRuuolzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6oAcJlJO1+/ppICitkgpCU1cfLnB5wXqQH3i/7mbfM=;
 b=Rx3m3iIpdmvfvYUoSf8uo7XaHEa7dFiCJouyu99WEBwO5I8eL4UaVgbxCPz/azxG/R2yn9iPiWjHDYgp0FniFi0kCgPiEzhV3RIbt9O/q18UEUEed59vhwJRfh3X8qoZnnMdKu0M/Iz8lC3Xx2Vsd5WVigXqjqCfnZpwV85oQkujIYvegXjDUkf4tkxzADTm2iarZyFJ8H6/vkszRcLJhfXJnqG1mPFm/YTHJaFL0qtK825KHFvbw5YXHQBHdUDS0gb0jiXcAhJkWe5saIWjD1ypdXEMcjlBTDg7HS/9Q9DQbm+9dWgoOL8aQY5W/e+x6cS+oeGpEsXnD0tAXbQp1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6oAcJlJO1+/ppICitkgpCU1cfLnB5wXqQH3i/7mbfM=;
 b=NRBjnvH+zYTRrO/uVzOFqZbUuemUEUhf2q79Os/hLLF1VVyKCYdzYl8t/FU64fDvzMw5MdtUOXOX+yXXfJ9u+Ej6Fv5y4zBJnrRhLz3fXxOd5TsGDFKKR5/sTeAmHhCbzO8n0a7kkdv8FdsrdJu5/6d8wcHSIsC0lH4V3X+IyZ8xSLaF8bBXGcLzvHoB++ppISvWODDoOkIjBStFpKwfBT4nD5ph9VjnogX4lpah9H2BZIFfaKuQh2TdBLo1Bmjjo4GjyfiIB1yutx2m2OBS6IJYPGe/0ZvXK8Yu5iMGW0ZZpHuAKORNnm14yNYIzC5hpF/L0d8Uc/nrPTLiVny1qQ==
Received: from DS7PR06CA0051.namprd06.prod.outlook.com (2603:10b6:8:54::21) by
 BN6PR1201MB0146.namprd12.prod.outlook.com (2603:10b6:405:59::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 06:28:37 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::53) by DS7PR06CA0051.outlook.office365.com
 (2603:10b6:8:54::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 6 Jul 2022 06:28:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 06:28:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 6 Jul
 2022 06:28:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 5 Jul 2022
 23:28:31 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Tue, 5 Jul 2022 23:28:29 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <kwankhede@nvidia.com>, <corbet@lwn.net>, <hca@linux.ibm.com>,
        <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
        <zhenyuw@linux.intel.com>, <zhi.a.wang@intel.com>,
        <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, <tvrtko.ursulin@linux.intel.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <farman@linux.ibm.com>,
        <mjrosato@linux.ibm.com>, <pasic@linux.ibm.com>,
        <vneethv@linux.ibm.com>, <oberpar@linux.ibm.com>,
        <freude@linux.ibm.com>, <akrowiak@linux.ibm.com>,
        <jjherne@linux.ibm.com>, <alex.williamson@redhat.com>,
        <cohuck@redhat.com>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <hch@infradead.org>
CC:     <jchrist@linux.ibm.com>, <kvm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-s390@vger.kernel.org>,
        <intel-gvt-dev@lists.freedesktop.org>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>
Subject: [RFT][PATCH v2 9/9] vfio: Replace phys_pfn with pages for vfio_pin_pages()
Date:   Tue, 5 Jul 2022 23:27:59 -0700
Message-ID: <20220706062759.24946-10-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220706062759.24946-1-nicolinc@nvidia.com>
References: <20220706062759.24946-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a84798d-e10f-4219-7ee9-08da5f18c249
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0146:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /wKtIgQHIwgKNJzlQZ4DM+OdvQF5R2u1B7rKIAxnt7OhuW2CBC6JV3fssTZusiLKmm7k2a68c5SeIB+UdjhOgZGAL4eD/aWDqIzwaUq94j6Cz36Le8mP82Sh0JZ0Z/l+Duf3YFVFUtKhR6qFYabJxEAxFScfRcrjRusdkeFWe7MnSe72EF6to5nlHzKkIrWr85+0CggEUFIklKHeCwJcdQnJJRO2zqblCh5p6JN6uOD3agdQ18v995BoxE4Vm1wInvVRIvnSPnSB048bsgtH0VtbqTqlZVNjKkUTePR8CLm7n9BfNG2QL+Dep1CORamxKu98IGw2+zXVu6R8BX29hsu4IAAw1qLSfdJJij2fe2n/CQrW/GA+LQzwZYSga2YvW6saRdnEsahLwNeYyBAV0z14dSi0+MVAG7yMCR2ANkKsz4+QnOtIppCLLz8JlDSNPZPDsH4SCKWj4hoKOkwWO0/xEpIjy8X9nUh15mCBeDx4Eg1Ho9BiTIatZXxm76xiJsLdMCzaLUTteMd9jcSjg0arKR/mn8C6kgofqPJ8ZWlM6RTk1HSB2X8eoAIF8dF3r4RlegWvUoaBs9TfRZTU+ZKkvDl8rTQJEsExrCBNh7l4HJVl4cQ3k/rEvGdmn8U9YnkVbfoBqizQ/htykSfgJlPDEnDiVH/4awfLSoNVoDcFGfO9s9G6HO1T+BDOHB4WKGrPIWg9YcskT++1EgoqKobI6Z6JdeKrvPLO+UdO5s2v/MaFup+jcjl6BcVnyXwYvGig4vur4YGRVB2D3Kv0f73O/NXnl2ciJoRY4oLRnmxRHn3A+hELrPEy7sJu/NZ381xW4y4nA1zm40jQiYWrSEInjbOMkEzd7jfexGsGLkV8fF+RVMft5bJbaSoujxsijEjbC+wD1x6pphtfJLnUorMlhrn4StZkf5vi2quUTWc=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(46966006)(40470700004)(36840700001)(8936002)(336012)(478600001)(86362001)(426003)(7406005)(5660300002)(7416002)(83380400001)(40460700003)(30864003)(2616005)(36756003)(186003)(1076003)(316002)(40480700001)(110136005)(54906003)(36860700001)(26005)(47076005)(82740400003)(921005)(356005)(41300700001)(81166007)(70586007)(2906002)(6666004)(70206006)(4326008)(8676002)(7696005)(82310400005)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 06:28:36.8078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a84798d-e10f-4219-7ee9-08da5f18c249
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0146
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Most of the callers of vfio_pin_pages() want "struct page *" and the
low-level mm code to pin pages returns a list of "struct page *" too.
So there's no gain in converting "struct page *" to PFN in between.

Replace the output parameter "phys_pfn" list with a "pages" list, to
simplify callers. This also allows us to replace the vfio_iommu_type1
implementation with a more efficient one.

For now, also update vfio_iommu_type1 to fit this new parameter too.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../driver-api/vfio-mediated-device.rst       |  2 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c              | 19 ++++++-------------
 drivers/s390/cio/vfio_ccw_cp.c                | 19 +++++++++----------
 drivers/s390/crypto/vfio_ap_ops.c             |  6 +++---
 drivers/vfio/vfio.c                           |  8 ++++----
 drivers/vfio/vfio.h                           |  2 +-
 drivers/vfio/vfio_iommu_type1.c               | 19 +++++++++++--------
 include/linux/vfio.h                          |  2 +-
 8 files changed, 36 insertions(+), 41 deletions(-)

diff --git a/Documentation/driver-api/vfio-mediated-device.rst b/Documentation/driver-api/vfio-mediated-device.rst
index ea32a0f13ddb..ba5fefcdae1a 100644
--- a/Documentation/driver-api/vfio-mediated-device.rst
+++ b/Documentation/driver-api/vfio-mediated-device.rst
@@ -263,7 +263,7 @@ The following APIs are provided for translating user pfn to host pfn in a VFIO
 driver::
 
 	int vfio_pin_pages(struct vfio_device *device, dma_addr_t iova,
-				  int npage, int prot, unsigned long *phys_pfn);
+				  int npage, int prot, struct page **pages);
 
 	void vfio_unpin_pages(struct vfio_device *device, dma_addr_t iova,
 				    int npage);
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index ea6041fa48ac..3a49471dcc16 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -239,7 +239,7 @@ static void gvt_unpin_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
 static int gvt_pin_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
 		unsigned long size, struct page **page)
 {
-	unsigned long base_pfn = 0;
+	struct page *base_page = NULL;
 	int total_pages;
 	int npage;
 	int ret;
@@ -251,26 +251,19 @@ static int gvt_pin_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
 	 */
 	for (npage = 0; npage < total_pages; npage++) {
 		dma_addr_t cur_iova = (gfn + npage) << PAGE_SHIFT;
-		unsigned long pfn;
+		struct page *cur_page;
 
 		ret = vfio_pin_pages(&vgpu->vfio_device, cur_iova, 1,
-				     IOMMU_READ | IOMMU_WRITE, &pfn);
+				     IOMMU_READ | IOMMU_WRITE, &cur_page);
 		if (ret != 1) {
 			gvt_vgpu_err("vfio_pin_pages failed for iova %pad, ret %d\n",
 				     &cur_iova, ret);
 			goto err;
 		}
 
-		if (!pfn_valid(pfn)) {
-			gvt_vgpu_err("pfn 0x%lx is not mem backed\n", pfn);
-			npage++;
-			ret = -EFAULT;
-			goto err;
-		}
-
 		if (npage == 0)
-			base_pfn = pfn;
-		else if (base_pfn + npage != pfn) {
+			base_page = cur_page;
+		else if (base_page + npage != cur_page) {
 			gvt_vgpu_err("The pages are not continuous\n");
 			ret = -EINVAL;
 			npage++;
@@ -278,7 +271,7 @@ static int gvt_pin_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
 		}
 	}
 
-	*page = pfn_to_page(base_pfn);
+	*page = base_page;
 	return 0;
 err:
 	gvt_unpin_guest_page(vgpu, gfn, npage * PAGE_SIZE);
diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index cd4ec4f6d6ff..8963f452f963 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -22,8 +22,8 @@
 struct page_array {
 	/* Array that stores pages need to pin. */
 	dma_addr_t		*pa_iova;
-	/* Array that receives PFNs of the pages pinned. */
-	unsigned long		*pa_pfn;
+	/* Array that receives the pinned pages. */
+	struct page		**pa_page;
 	/* Number of pages pinned from @pa_iova. */
 	int			pa_nr;
 };
@@ -68,19 +68,19 @@ static int page_array_alloc(struct page_array *pa, u64 iova, unsigned int len)
 		return -EINVAL;
 
 	pa->pa_iova = kcalloc(pa->pa_nr,
-			      sizeof(*pa->pa_iova) + sizeof(*pa->pa_pfn),
+			      sizeof(*pa->pa_iova) + sizeof(*pa->pa_page),
 			      GFP_KERNEL);
 	if (unlikely(!pa->pa_iova)) {
 		pa->pa_nr = 0;
 		return -ENOMEM;
 	}
-	pa->pa_pfn = (unsigned long *)&pa->pa_iova[pa->pa_nr];
+	pa->pa_page = (struct page **)&pa->pa_iova[pa->pa_nr];
 
 	pa->pa_iova[0] = iova;
-	pa->pa_pfn[0] = -1ULL;
+	pa->pa_page[0] = NULL;
 	for (i = 1; i < pa->pa_nr; i++) {
 		pa->pa_iova[i] = pa->pa_iova[i - 1] + PAGE_SIZE;
-		pa->pa_pfn[i] = -1ULL;
+		pa->pa_page[i] = NULL;
 	}
 
 	return 0;
@@ -144,7 +144,7 @@ static int page_array_pin(struct page_array *pa, struct vfio_device *vdev)
 
 		ret = vfio_pin_pages(vdev, *first, npage,
 				     IOMMU_READ | IOMMU_WRITE,
-				     &pa->pa_pfn[pinned]);
+				     &pa->pa_page[pinned]);
 		if (ret < 0) {
 			goto err_out;
 		} else if (ret > 0 && ret != npage) {
@@ -195,7 +195,7 @@ static inline void page_array_idal_create_words(struct page_array *pa,
 	 */
 
 	for (i = 0; i < pa->pa_nr; i++)
-		idaws[i] = pa->pa_pfn[i] << PAGE_SHIFT;
+		idaws[i] = page_to_phys(pa->pa_page[i]);
 
 	/* Adjust the first IDAW, since it may not start on a page boundary */
 	idaws[0] += pa->pa_iova[0] & (PAGE_SIZE - 1);
@@ -246,8 +246,7 @@ static long copy_from_iova(struct vfio_device *vdev, void *to, u64 iova,
 
 	l = n;
 	for (i = 0; i < pa.pa_nr; i++) {
-		struct page *page = pfn_to_page(pa.pa_pfn[i]);
-		void *from = kmap_local_page(page);
+		void *from = kmap_local_page(pa.pa_page[i]);
 
 		m = PAGE_SIZE;
 		if (i == 0) {
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 6945e0ddc08c..b0972ca0dfa3 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -234,9 +234,9 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 	struct ap_qirq_ctrl aqic_gisa = {};
 	struct ap_queue_status status = {};
 	struct kvm_s390_gisa *gisa;
+	struct page *h_page;
 	int nisc;
 	struct kvm *kvm;
-	unsigned long h_pfn;
 	phys_addr_t h_nib;
 	dma_addr_t nib;
 	int ret;
@@ -251,7 +251,7 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 	}
 
 	ret = vfio_pin_pages(&q->matrix_mdev->vdev, nib, 1,
-			     IOMMU_READ | IOMMU_WRITE, &h_pfn);
+			     IOMMU_READ | IOMMU_WRITE, &h_page);
 	switch (ret) {
 	case 1:
 		break;
@@ -267,7 +267,7 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 	kvm = q->matrix_mdev->kvm;
 	gisa = kvm->arch.gisa_int.origin;
 
-	h_nib = (h_pfn << PAGE_SHIFT) | (nib & ~PAGE_MASK);
+	h_nib = page_to_phys(h_page) | (nib & ~PAGE_MASK);
 	aqic_gisa.gisc = isc;
 
 	nisc = kvm_s390_gisc_register(kvm, isc);
diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index b95ec2d78966..96b758e06c4a 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1917,18 +1917,18 @@ EXPORT_SYMBOL(vfio_set_irqs_validate_and_prepare);
  * @npage [in]   : count of pages to be pinned.  This count should not
  *		   be greater VFIO_PIN_PAGES_MAX_ENTRIES.
  * @prot [in]    : protection flags
- * @phys_pfn[out]: array of host PFNs
+ * @pages[out]   : array of host pages
  * Return error or number of pages pinned.
  */
 int vfio_pin_pages(struct vfio_device *device, dma_addr_t iova,
-		   int npage, int prot, unsigned long *phys_pfn)
+		   int npage, int prot, struct page **pages)
 {
 	struct vfio_container *container;
 	struct vfio_group *group = device->group;
 	struct vfio_iommu_driver *driver;
 	int ret;
 
-	if (!phys_pfn || !npage || !vfio_assert_device_open(device))
+	if (!pages || !npage || !vfio_assert_device_open(device))
 		return -EINVAL;
 
 	if (npage > VFIO_PIN_PAGES_MAX_ENTRIES)
@@ -1943,7 +1943,7 @@ int vfio_pin_pages(struct vfio_device *device, dma_addr_t iova,
 	if (likely(driver && driver->ops->pin_pages))
 		ret = driver->ops->pin_pages(container->iommu_data,
 					     group->iommu_group, iova,
-					     npage, prot, phys_pfn);
+					     npage, prot, pages);
 	else
 		ret = -ENOTTY;
 
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index dbcd0e8c031b..dbfad8e20581 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -52,7 +52,7 @@ struct vfio_iommu_driver_ops {
 				     struct iommu_group *group,
 				     dma_addr_t user_iova,
 				     int npage, int prot,
-				     unsigned long *phys_pfn);
+				     struct page **pages);
 	void		(*unpin_pages)(void *iommu_data,
 				       dma_addr_t user_iova, int npage);
 	int		(*register_notifier)(void *iommu_data,
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index f10d0c4b1f26..de342d82b154 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -830,7 +830,7 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 				      struct iommu_group *iommu_group,
 				      dma_addr_t user_iova,
 				      int npage, int prot,
-				      unsigned long *phys_pfn)
+				      struct page **pages)
 {
 	struct vfio_iommu *iommu = iommu_data;
 	struct vfio_iommu_group *group;
@@ -840,7 +840,7 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 	bool do_accounting;
 	dma_addr_t iova;
 
-	if (!iommu || !phys_pfn)
+	if (!iommu || !pages)
 		return -EINVAL;
 
 	/* Supported for v2 version only */
@@ -879,6 +879,7 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 	do_accounting = list_empty(&iommu->domain_list);
 
 	for (i = 0; i < npage; i++) {
+		unsigned long phys_pfn;
 		struct vfio_pfn *vpfn;
 
 		iova = user_iova + PAGE_SIZE * i;
@@ -895,23 +896,25 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 
 		vpfn = vfio_iova_get_vfio_pfn(dma, iova);
 		if (vpfn) {
-			phys_pfn[i] = vpfn->pfn;
+			pages[i] = pfn_to_page(vpfn->pfn);
 			continue;
 		}
 
 		remote_vaddr = dma->vaddr + (iova - dma->iova);
-		ret = vfio_pin_page_external(dma, remote_vaddr, &phys_pfn[i],
+		ret = vfio_pin_page_external(dma, remote_vaddr, &phys_pfn,
 					     do_accounting);
 		if (ret)
 			goto pin_unwind;
 
-		ret = vfio_add_to_pfn_list(dma, iova, phys_pfn[i]);
+		ret = vfio_add_to_pfn_list(dma, iova, phys_pfn);
 		if (ret) {
-			if (put_pfn(phys_pfn[i], dma->prot) && do_accounting)
+			if (put_pfn(phys_pfn, dma->prot) && do_accounting)
 				vfio_lock_acct(dma, -1, true);
 			goto pin_unwind;
 		}
 
+		pages[i] = pfn_to_page(phys_pfn);
+
 		if (iommu->dirty_page_tracking) {
 			unsigned long pgshift = __ffs(iommu->pgsize_bitmap);
 
@@ -934,14 +937,14 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 	goto pin_done;
 
 pin_unwind:
-	phys_pfn[i] = 0;
+	pages[i] = NULL;
 	for (j = 0; j < i; j++) {
 		dma_addr_t iova;
 
 		iova = user_iova + PAGE_SIZE * j;
 		dma = vfio_find_dma(iommu, iova, PAGE_SIZE);
 		vfio_unpin_page_external(dma, iova, do_accounting);
-		phys_pfn[j] = 0;
+		pages[j] = NULL;
 	}
 pin_done:
 	mutex_unlock(&iommu->lock);
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 9108de34a79b..c76a2c492bbd 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -148,7 +148,7 @@ bool vfio_file_has_dev(struct file *file, struct vfio_device *device);
 #define VFIO_PIN_PAGES_MAX_ENTRIES	(PAGE_SIZE/sizeof(unsigned long))
 
 int vfio_pin_pages(struct vfio_device *device, dma_addr_t iova,
-		   int npage, int prot, unsigned long *phys_pfn);
+		   int npage, int prot, struct page **pages);
 void vfio_unpin_pages(struct vfio_device *device, dma_addr_t iova, int npage);
 int vfio_dma_rw(struct vfio_device *device, dma_addr_t iova,
 		void *data, size_t len, bool write);
-- 
2.17.1

