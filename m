Return-Path: <linux-s390+bounces-19575-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K+rFI7yAmrpywEAu9opvQ
	(envelope-from <linux-s390+bounces-19575-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 11:27:42 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C19B751DA7C
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 11:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EDAF31F63E9
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 09:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC6748C8C4;
	Tue, 12 May 2026 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYt8EqYI"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD7A3B9601;
	Tue, 12 May 2026 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576822; cv=none; b=IgbJkLjJz91NEFAzmDrvxlhwMkdBUhMADnYa077HRlUD2lPKjPMXcZJnaw7SWr0BRK9RLi9aYDq8Zp6N4wQBdF2jEJ0CeGMNc+kb9jPzXm8rHztdkojl9m/8uiIM6gq3i4/ZX7TD8lEoR5tebP5OZp0Rss+siOPzLlqlKcpN5FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576822; c=relaxed/simple;
	bh=SSIb9AffiyCb4tbfwh2yXw5+hoFTxTK0yIF3uaiiYAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euVGwUeuiVX9S2I9gOzTUpAfiO83ROhDJkrMtYJbR3QKOVRlDQlqA6WXOU3CZnoHg1olfEs3bEV7XhOZo7JZxJBaEe8Uar7jAbkUf1Y3OHOvO1PhBUQvK07Zy69FEyaAisvU9WFa7ZFksNPRgA34XFVEPGvZ0H8iqrv0iQUes7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYt8EqYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33B4C4AF0B;
	Tue, 12 May 2026 09:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778576822;
	bh=SSIb9AffiyCb4tbfwh2yXw5+hoFTxTK0yIF3uaiiYAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GYt8EqYIRUIaavvPuaPJBda78vHlfhOtAKKCeYDhg/engtvJHFapVeF+Ah9i0/FJE
	 fmqDPRJJt7SSe8N9iKzSLfWg1ueFG/uoakkMNldaxV0NBL8W795piGnbSbOjFxer3x
	 tHzfEvWrtUMhKxo/JyVufOYkwYsug6srjyXOEIjelTyvy9oZ/2taZiPlIsn2rzbK3O
	 RiLHESdmu1hBj05ocJaxuEA7CLneYuZT5I0BkcjWHL1PfZiP2VuP1VgdVY++Z4b7Lu
	 bhpIZ1gADFwea0mdzaZWhQa/8g6VijT0S7COzlnLvOSszVAynSv150Z4ZnbbeAHNjR
	 D6fbBzbPj/3lw==
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
Subject: [PATCH v4 13/13] x86/amd-gart: preserve the direct DMA address until GART mapping succeeds
Date: Tue, 12 May 2026 14:34:08 +0530
Message-ID: <20260512090408.794195-14-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512090408.794195-1-aneesh.kumar@kernel.org>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C19B751DA7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,samsung.com,resnulli.us,ziepe.ca,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,vger.kernel.org,linux.ibm.com,ellerman.id.au,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19575-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

gart_alloc_coherent() first allocates memory through dma_direct_alloc(),
which returns a direct-mapped DMA address in dma_addr. When force_iommu is
enabled, the buffer is then remapped.

Do not overwrite dma_addr before dma_map_area() has succeeded. Keep the
dma_map_area result in a temporary variable so the direct DMA address
remains available for dma_direct_free() on the error path.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/x86/kernel/amd_gart_64.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index b5f1f031d45b..a109649c5649 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -467,18 +467,20 @@ gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
 		    gfp_t flag, unsigned long attrs)
 {
 	void *vaddr;
+	dma_addr_t dma_map_addr;
 
 	vaddr = dma_direct_alloc(dev, size, dma_addr, flag, attrs);
 	if (!vaddr ||
 	    !force_iommu || dev->coherent_dma_mask <= DMA_BIT_MASK(24))
 		return vaddr;
 
-	*dma_addr = dma_map_area(dev, virt_to_phys(vaddr), size,
-				 DMA_BIDIRECTIONAL,
-				 (1UL << get_order(size)) - 1, attrs);
+	dma_map_addr = dma_map_area(dev, virt_to_phys(vaddr), size,
+				     DMA_BIDIRECTIONAL,
+				     (1UL << get_order(size)) - 1, attrs);
 	flush_gart();
-	if (unlikely(*dma_addr == DMA_MAPPING_ERROR))
+	if (unlikely(dma_map_addr == DMA_MAPPING_ERROR))
 		goto out_free;
+	*dma_addr = dma_map_addr;
 	return vaddr;
 out_free:
 	dma_direct_free(dev, size, vaddr, *dma_addr, attrs);
-- 
2.43.0


