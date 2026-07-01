Return-Path: <linux-s390+bounces-21402-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hkcIFtOqRGrMygoAu9opvQ
	(envelope-from <linux-s390+bounces-21402-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 07:51:15 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCAB6E9F38
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 07:51:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=j4osoUj9;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21402-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-21402-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 640FA300B9CF
	for <lists+linux-s390@lfdr.de>; Wed,  1 Jul 2026 05:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D08279DCA;
	Wed,  1 Jul 2026 05:51:13 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2E352030;
	Wed,  1 Jul 2026 05:51:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885073; cv=none; b=R6U4cIgR4m5I1FhIxRUrYzNnUOLXHjeexv97y86cViTBDS1u+HP/DwU4l6SBIfXSiw6WlxdK6pXEAAyjpvG4msLs/Tm0P+hKqZY3Auj7UCJNBGOU92HzgtQCt6xxodSUYsdtlfFDlvMN1DGU52ED5+52JGDLAGfhP6CvU3BD1qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885073; c=relaxed/simple;
	bh=ioJvyPIy7I2W5+oafDqug/br0d0fa6uYIQvbBu+r2Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKrl+6nxHnINJujG1g20WsEG5RZdTcCk0mTUgeAppIdLiauKQ31SWvK+ytFvVzZmvtPCMz12IKq6p4cM9H61ywZLZrWyibVc+q6yQcr34oyGwxVsWt5jJqdW0WyV6YYjaLG32oX/MDsQ1tXj1iz0yXaq3VWEB54E+8uR+vUtdzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4osoUj9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433C51F00A3A;
	Wed,  1 Jul 2026 05:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885072;
	bh=asRIaEd/4xjJYIGtw3zuzx+gj7hp/R5cp2IcFUGc0Jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j4osoUj9I8yeii54T3u3pBSNp8p9xiEhJWUw3aaBdBJT0G/KufvfaIpGGv8COfiNl
	 ymf6HwNOY9rr6N3Q9VVv0uuYIjwtuZiy5HxDZIPXrr0ivNbH2ZQ8+utRxN5aZcVpGE
	 aafd+DyNMFr6D3SoIqr9ms23CveKGidlx02FYfgZl7AcHEDGIttSU+r0L2ZB4WNlWO
	 IAt9UZ79529koYkCHM59leWoNs0Ragyb1uQoZv9Qooeh7QsS68CQ5ETEmTl35TjmzN
	 kBNX3L/kq3Xv6KEue8F/nWRtBjGoDTQk15zoZxtBwCtNQPOGuDbz+VofKpt3UsKxND
	 +K1R8FtJVezmw==
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
Subject: [PATCH v7 08/22] coco: arm64: s390: powerpc: Mark secure guests with CC_ATTR_GUEST_MEM_ENCRYPT
Date: Wed,  1 Jul 2026 11:19:12 +0530
Message-ID: <20260701054926.825925-9-aneesh.kumar@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21402-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:iommu@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:aneesh.kumar@kernel.org,m:robin.murphy@arm.com,m:m.szyprowski@samsung.com,m:will@kernel.org,m:maz@kernel.org,m:steven.price@arm.com,m:Suzuki.Poulose@arm.com,m:catalin.marinas@arm.com,m:jiri@resnulli.us,m:jgg@ziepe.ca,m:smostafa@google.com,m:ptesarik@suse.com,m:aik@amd.com,m:dan.j.williams@intel.com,m:yilun.xu@linux.intel.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:x86@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aneesh.kumar@kernel.org,linux-s390@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,samsung.com,resnulli.us,ziepe.ca,google.com,suse.com,amd.com,intel.com,linux.intel.com,lists.ozlabs.org,vger.kernel.org,linux.ibm.com,ellerman.id.au,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBCAB6E9F38

arm64 Realms, powerpc secure guests and s390 protected virtualization
guests currently report CC_ATTR_MEM_ENCRYPT, but not
CC_ATTR_GUEST_MEM_ENCRYPT.

These environments are all secure guest configurations. Their
force_dma_unencrypted() implementations also treat the same secure guest
state as requiring unencrypted DMA. Report CC_ATTR_GUEST_MEM_ENCRYPT for
the same condition so generic confidential-computing code can distinguish
guest memory encryption from host memory encryption instead of relying only
on CC_ATTR_MEM_ENCRYPT.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/kernel/rsi.c                      | 1 +
 arch/powerpc/platforms/pseries/cc_platform.c | 1 +
 arch/s390/mm/init.c                          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
index 92160f2e57ff..207e36db1e7a 100644
--- a/arch/arm64/kernel/rsi.c
+++ b/arch/arm64/kernel/rsi.c
@@ -27,6 +27,7 @@ bool cc_platform_has(enum cc_attr attr)
 {
 	switch (attr) {
 	case CC_ATTR_MEM_ENCRYPT:
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
 		return is_realm_world();
 	default:
 		return false;
diff --git a/arch/powerpc/platforms/pseries/cc_platform.c b/arch/powerpc/platforms/pseries/cc_platform.c
index e8021af83a19..46e110a5a717 100644
--- a/arch/powerpc/platforms/pseries/cc_platform.c
+++ b/arch/powerpc/platforms/pseries/cc_platform.c
@@ -17,6 +17,7 @@ bool cc_platform_has(enum cc_attr attr)
 {
 	switch (attr) {
 	case CC_ATTR_MEM_ENCRYPT:
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
 		return is_secure_guest();
 
 	default:
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index c29326c44af0..6b1c5a4fa9ce 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -148,6 +148,7 @@ bool cc_platform_has(enum cc_attr attr)
 {
 	switch (attr) {
 	case CC_ATTR_MEM_ENCRYPT:
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
 		return is_prot_virt_guest();
 
 	default:
-- 
2.43.0


