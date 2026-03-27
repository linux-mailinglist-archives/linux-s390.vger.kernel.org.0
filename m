Return-Path: <linux-s390+bounces-18194-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK4wNkTpxWlTDQUAu9opvQ
	(envelope-from <linux-s390+bounces-18194-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 03:19:48 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD0533E3B5
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 03:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E2813099749
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 02:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D88329C54;
	Fri, 27 Mar 2026 02:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XE9dZB9f"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED13290D2
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 02:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577786; cv=none; b=jPDSyhIt/h6B9zfGUeKtP59wNqueXDBIeEP3Tq9OPIH4EysAQnKwbnx2o3doisqDVTAk5LNAJracVX6kSWqwxFVvItye6aNwU2DqVg00kXd44/J1QMQMqigfYkL5x/HTTy8H3WcU9EuvO7PFndSClzykeNLuYZCsQATCFNU1jsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577786; c=relaxed/simple;
	bh=GRBA492nikdnvv9JLnq+tQVYDGMzkv2WY+smoK7uTJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VezCgaIIVVrqZplEKO/ymnWmEV5I1a53BuoemSnUcCy1fK2WXmeuOy/jB49zv3qCas5/cjK4pqKgxS8s9XAhY9AC8v0jHP/ga9JAq2YeuJWrmx8EOIBTladps6BOOoNv1QDfqSIPJi8EJJ5Tf1c0LFSZtEE5NoScUeifKpVUfEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XE9dZB9f; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lE7v5lDGM/JWEaWuAACCuFGk8rRw4V1pzGfx+4tEAgA=;
	b=XE9dZB9fLZ/OArOngsedrObo//4dofSQ7egtq16n4UZmnM75/spWLYNbGNXdNBcCTBB+Fo
	cnGQD1gdIQDl3tgpRirkYMGiJR0/XwR2Cvg+8mZxq+a73pFDK7w6i+bpfpGytLEzfpmE/g
	n0aN0IQDsz7hR+A1FcsvHnMT47HCL70=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	willy@infradead.org,
	linux-mm@kvack.org
Cc: fvdl@google.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kas@kernel.org,
	baohua@kernel.org,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	Vlastimil Babka <vbabka@kernel.org>,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	Usama Arif <usama.arif@linux.dev>
Subject: [v3 23/24] selftests/mm: add partial_mremap test for move_page_tables
Date: Thu, 26 Mar 2026 19:09:05 -0700
Message-ID: <20260327021403.214713-24-usama.arif@linux.dev>
In-Reply-To: <20260327021403.214713-1-usama.arif@linux.dev>
References: <20260327021403.214713-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18194-lists,linux-s390=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7DD0533E3B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add test for partial mremap on THP which exercises move_page_tables().
This verifies that partial mremap correctly splits the PMD, moves
only the requested page, and preserves data integrity in both the
moved region and the original mapping.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 .../testing/selftests/mm/thp_pmd_split_test.c | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/mm/thp_pmd_split_test.c b/tools/testing/selftests/mm/thp_pmd_split_test.c
index 3c9f05457efec..1f29296759a5b 100644
--- a/tools/testing/selftests/mm/thp_pmd_split_test.c
+++ b/tools/testing/selftests/mm/thp_pmd_split_test.c
@@ -203,4 +203,54 @@ TEST_F(thp_pmd_split, partial_mlock)
 		self->split_pmd_failed_before);
 }
 
+/*
+ * Partial mremap (move_page_tables)
+ *
+ * Tests that partial mremap of a THP correctly splits the PMD and
+ * moves only the requested portion. This exercises move_page_tables()
+ * which now handles split failures.
+ */
+TEST_F(thp_pmd_split, partial_mremap)
+{
+	void *new_addr;
+	unsigned long *ptr = (unsigned long *)self->aligned;
+	unsigned long *new_ptr;
+	unsigned long pattern = 0xABCDUL;
+	int ret;
+
+	ret = allocate_thp(self->aligned, self->pmdsize);
+	if (ret)
+		SKIP(return, "Failed to allocate THP");
+
+	/* Write pattern to the page we'll move */
+	ptr[self->pagesize / sizeof(unsigned long)] = pattern;
+
+	/* Also write to first and last page to verify they stay intact */
+	ptr[0] = 0x1234UL;
+	ptr[(self->pmdsize - self->pagesize) / sizeof(unsigned long)] = 0x4567UL;
+
+	/* Partial mremap - move one base page from the THP */
+	new_addr = mremap((char *)self->aligned + self->pagesize, self->pagesize,
+			  self->pagesize, MREMAP_MAYMOVE);
+	if (new_addr == MAP_FAILED) {
+		if (errno == ENOMEM)
+			SKIP(return, "mremap failed with ENOMEM");
+		ASSERT_NE(new_addr, MAP_FAILED);
+	}
+
+	/* Verify data was moved correctly */
+	new_ptr = (unsigned long *)new_addr;
+	ASSERT_EQ(new_ptr[0], pattern);
+
+	/* Verify surrounding data is intact */
+	ASSERT_EQ(ptr[0], 0x1234UL);
+	ASSERT_EQ(ptr[(self->pmdsize - self->pagesize) / sizeof(unsigned long)], 0x4567UL);
+
+	/* Cleanup the moved page */
+	munmap(new_addr, self->pagesize);
+
+	log_and_check_pmd_split(_metadata, self->split_pmd_before,
+		self->split_pmd_failed_before);
+}
+
 TEST_HARNESS_MAIN
-- 
2.52.0


