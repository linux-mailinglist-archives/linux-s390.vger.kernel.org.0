Return-Path: <linux-s390+bounces-21396-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z/CUCOuqRGrWygoAu9opvQ
	(envelope-from <linux-s390+bounces-21396-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 07:51:39 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA70B6E9F55
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 07:51:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oVUePrtd;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21396-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21396-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 341BB304DCBF
	for <lists+linux-s390@lfdr.de>; Wed,  1 Jul 2026 05:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C553914E8;
	Wed,  1 Jul 2026 05:50:08 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E559737AA66;
	Wed,  1 Jul 2026 05:50:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885007; cv=none; b=Wqvg284RBzmZ7vHSKckbOFa3Z7yLjp/AITSmXTleQ+OKZEaZ8oZ1ReJoJGxN/TVtag9Ysl3+Bh4oaCVlWxLc3U7YMMPsYoxaoWfllMz0NOyUoQRSu6L12s+ISU+yEh1tv3WktadjcQaU/hl07hE6Hs6CsQKExpetxg3C0KhKunk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885007; c=relaxed/simple;
	bh=zjrTFFJTF+0LUM6y1NQ+bFpwvWbXP11LMsscgiL0JeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bpqy0qTPnLmTRyrANbNdBNrJD1eK1P+nJ2gsqdQDBXWoJwkcbznYiP+TJurgYpDG4uGF4vab7XqjoXYCcfWZO4M9QHzrZb2EIgOZGCYXN1/QugU9ZdIfEZZEMyUfmQ3YcVRpaBCZmbMAyYNMlXnRVKhhVdBIRlkLuPLfkn5RoGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVUePrtd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628A81F00A3E;
	Wed,  1 Jul 2026 05:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885006;
	bh=YM/kzkdd2b4wz0/QuPV8d4m9Lm+x6hpDFjkd4v2KLO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oVUePrtdGdfcHjX+cljzkAXWX8yQtKPyHxYbs9+rDOOIfIvI8HQob1dUJF+TOW/y0
	 fC5sqXl8TCTqr/8FrheOkNk8daMgGh8mpyaLj/+fVYuN40wIzhFqgHFJqQqshM2AAZ
	 QmS72TRjtqkOOrJbTcnATbGlXL4fSZouBBLMvDsNWlaDXpAHcdKnbWVdTCKxRWvKLi
	 FTiOEZh/3FHlbfRr7w7c+MZ7DEEe6AFLEpev1I+D+hE0x8kTOk80LKi5+7NbwXm/+H
	 JynSNQfMR3DglTV2+o+PCwvEpadWmlRiKgqn7fA8aS8g9TTAXMf6o7W7ysUHuYt6E1
	 ytVN3wRJb/NYQ==
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
	x86@kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v7 02/22] dma-pool: fix page leak in atomic_pool_expand() cleanup
Date: Wed,  1 Jul 2026 11:19:06 +0530
Message-ID: <20260701054926.825925-3-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701054926.825925-1-aneesh.kumar@kernel.org>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21396-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:aneesh.kumar@kernel.org,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:jgg@ziepe.ca,m:smostafa@google.com,m:ptesarik@suse.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aneesh.kumar@kernel.org,linux-s390@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,samsung.com,resnulli.us,ziepe.ca,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,vger.kernel.org,linux.ibm.com,ellerman.id.au,gmail.com,outlook.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aneesh.kumar@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA70B6E9F55

atomic_pool_expand() frees the allocated pages from the remove_mapping
error path only when CONFIG_DMA_DIRECT_REMAP is enabled.

When CONFIG_DMA_DIRECT_REMAP is disabled, failures after page allocation,
such as gen_pool_add_virt(), jump to remove_mapping and return without
freeing the pages.

Move __free_pages(page, order) out of the CONFIG_DMA_DIRECT_REMAP block so
that cleanup paths always release the allocation.

Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/pool.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 2b2fbb709242..b0303efbc153 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -81,6 +81,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 {
 	unsigned int order;
 	struct page *page = NULL;
+	bool leak_pages = false;
 	void *addr;
 	int ret = -ENOMEM;
 
@@ -115,8 +116,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	 */
 	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
 				   1 << order);
-	if (ret)
+	if (ret) {
+		leak_pages = true;
 		goto remove_mapping;
+	}
 	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
 				pool_size, NUMA_NO_NODE);
 	if (ret)
@@ -130,14 +133,15 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 				   1 << order);
 	if (WARN_ON_ONCE(ret)) {
 		/* Decrypt succeeded but encrypt failed, purposely leak */
-		goto out;
+		leak_pages = true;
 	}
 remove_mapping:
 #ifdef CONFIG_DMA_DIRECT_REMAP
 	dma_common_free_remap(addr, pool_size);
 free_page:
-	__free_pages(page, order);
 #endif
+	if (!leak_pages)
+		__free_pages(page, order);
 out:
 	return ret;
 }
-- 
2.43.0


