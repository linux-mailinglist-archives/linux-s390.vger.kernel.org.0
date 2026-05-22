Return-Path: <linux-s390+bounces-19978-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Kj/E27cD2ojQgYAu9opvQ
	(envelope-from <linux-s390+bounces-19978-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 22 May 2026 06:32:46 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E56595AEAD0
	for <lists+linux-s390@lfdr.de>; Fri, 22 May 2026 06:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BC9B3004D2A
	for <lists+linux-s390@lfdr.de>; Fri, 22 May 2026 04:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B632D0617;
	Fri, 22 May 2026 04:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnEzxNen"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BDC347C7;
	Fri, 22 May 2026 04:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779424299; cv=none; b=mjnmr2rxy+S5MpjQkS5Kkcri0rSCWqWjYzP4ZeIDM0xJBXKnzNJPrqcz1LviV3xNepIJ3jz6+aDSrxLOCD/u6RvklR2qM4xCPRq+S6zV0axBNv6eKNVwgWWh+OaWV2j0PDgFU7FuwhB5oefSdVuyalK93YY/VKbY2CGX4Z5/R4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779424299; c=relaxed/simple;
	bh=MOHjoD9Y04Fj2BUzGKub8PM2+Jom+FjSwfzhM/D0SaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGdLTrh05CSV9Pfk/CbHjObEfhCXP9fK6q+FbB7aMxrtZBLaDbEarouAK5L90fu/56td+WaaDXLDY/JiHno8uw8bstHnD0HzQdk2OhJ4CnXAUZqoCj2URddGaujFie8dKXyYXQ+yt6Q7xbmSalyUmlGI7/2uUGW+yfiMy5s3DKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnEzxNen; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB661F00A3D;
	Fri, 22 May 2026 04:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779424298;
	bh=eNxPV4X8+LJvSw+1YGCbEG9piVGDIt8Se6Gkeol8Ww0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AnEzxNenegVHPTY+nqLjqtzKZpEkvdGMmUqLl7CrAAfRurgXThzU7ToDaiLG38rB5
	 gB0hJ3EocpSYOc2M5i8i9Dp1Ui3+aFSDCE8zAYwD4S/cUQYmG1sYMCkfsxWRQy9kuZ
	 ndgnDw20jy7R+n7mbHcpPHHqs2TxMcZGJkIod2vyMBmShf+bJjxOYp+DWQ/Et0EUM3
	 zoI9t8zIj/2zVJ0ozOizxl7i8+a+Qxr4J1ssSZOz+HA+DZfmqpWkefoRIKIZP/zISp
	 rqA41qNbKiCFSBEkjyGCO7Si8F4XX/tHCby/WZearmmtasBok8wnPn+TaMvHw53sHB
	 fCKm8mG+JiYmA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	x86@kernel.org
Subject: [PATCH v5 16/20] iommu/dma: Check atomic pool allocation result directly
Date: Fri, 22 May 2026 09:58:11 +0530
Message-ID: <20260522042815.370873-17-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522042815.370873-1-aneesh.kumar@kernel.org>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,samsung.com,resnulli.us,ziepe.ca,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,vger.kernel.org,linux.ibm.com,ellerman.id.au,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19978-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aneesh.kumar@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E56595AEAD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The non-blocking, non-coherent allocation path uses dma_alloc_from_pool(),
which returns the allocated page and fills cpu_addr only on success.

Do not rely on cpu_addr to detect allocation failure in this path. Check
the returned page directly before using it for the IOMMU mapping.

Fixes: 9420139f516d ("dma-pool: fix coherent pool allocations for IOMMU mappings")
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/dma-iommu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 725c7adb0a8d..52c599f4472c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1671,13 +1671,16 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	}
 
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    !gfpflags_allow_blocking(gfp) && !coherent)
+	    !gfpflags_allow_blocking(gfp) && !coherent) {
 		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
 					   gfp, attrs, NULL);
-	else
+		if (!page)
+			return NULL;
+	} else {
 		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
-	if (!cpu_addr)
-		return NULL;
+		if (!cpu_addr)
+			return NULL;
+	}
 
 	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
 			dev->coherent_dma_mask);
-- 
2.43.0


