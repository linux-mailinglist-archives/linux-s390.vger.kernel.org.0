Return-Path: <linux-s390+bounces-16521-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKQZJwowoGmLgAQAu9opvQ
	(envelope-from <linux-s390+bounces-16521-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 26 Feb 2026 12:35:38 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6376F1A5245
	for <lists+linux-s390@lfdr.de>; Thu, 26 Feb 2026 12:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E4BC3065018
	for <lists+linux-s390@lfdr.de>; Thu, 26 Feb 2026 11:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6898637418D;
	Thu, 26 Feb 2026 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bQvZ3Bk9"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FF837649A
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105703; cv=none; b=hjmy+7ca3VCdxedBbdXW3itmnok6UFHisRXCe1ocuuRsZEGn1cqK4r+HHMPY1bkWnQ7sJiV5aXQxbbPMr5+uQ7Ea84CZ9JUJRBCnLovVDKARiGbJeXkfUMDZQyc5+AGwP4LXajZAJeZ1vqmE3dwb6Y+8ABLZJJ6zbmu7kYe6JfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105703; c=relaxed/simple;
	bh=TeFOgDy04XSCL/ncyij56PW4PSGxEyn+mw4Y/51SYoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBvNywR43rc96LNJxLjRl+CY5VZy+7gte1s2iKQIc4phw0WqYziJoLfb6968zqxAjzAMExpctvCZVUj1AdOe4UAO9r2iwtEbQly5WFoHH/sMhRBkH/0xJYI8aDRDzxTL9Lim3ZJjSnfSVEdfEvpxdHQBlhpJ0M7B9wwAzfWnMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bQvZ3Bk9; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZL1HqFM5fa36Uz0JOdbh5qV5iDmtrECipMEqRvI7/A=;
	b=bQvZ3Bk9zABmR2QjQC7aS7RsAH/+WnY/o7rjw0sMM8KWnVjY1pM/mPaqV2KVkr7y1+1yqV
	D95OAuC1N714g5HBViSG7olcJX86gP0ns8b9QPlaHVVrOOimKpItd/woUJYp5+xK0IrmW4
	ebj/YYCu6frGA2CLRuuQD3QUhJIoTZs=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
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
Subject: [RFC v2 19/21] selftests/mm: add partial_mlock test
Date: Thu, 26 Feb 2026 03:23:48 -0800
Message-ID: <20260226113233.3987674-20-usama.arif@linux.dev>
In-Reply-To: <20260226113233.3987674-1-usama.arif@linux.dev>
References: <20260226113233.3987674-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16521-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6376F1A5245
X-Rspamd-Action: no action

Add test for partial mlock on THP which exercises walk_page_range()
with a subset of the THP. This should trigger a PMD split since
mlock operates at page granularity.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 .../testing/selftests/mm/thp_pmd_split_test.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/mm/thp_pmd_split_test.c b/tools/testing/selftests/mm/thp_pmd_split_test.c
index 4944a5a516da9..3c9f05457efec 100644
--- a/tools/testing/selftests/mm/thp_pmd_split_test.c
+++ b/tools/testing/selftests/mm/thp_pmd_split_test.c
@@ -177,4 +177,30 @@ TEST_F(thp_pmd_split, partial_mprotect)
 		self->split_pmd_failed_before);
 }
 
+/*
+ * Partial mlock triggering split (walk_page_range)
+ *
+ * Tests mlock on a partial THP region which should trigger a PMD split.
+ */
+TEST_F(thp_pmd_split, partial_mlock)
+{
+	int ret;
+
+	ret = allocate_thp(self->aligned, self->pmdsize);
+	if (ret)
+		SKIP(return, "Failed to allocate THP");
+
+	/* Partial mlock - should trigger PMD split */
+	ret = mlock((char *)self->aligned + self->pagesize, self->pagesize);
+	if (ret && errno == ENOMEM)
+		SKIP(return, "mlock failed with ENOMEM (resource limit)");
+	ASSERT_EQ(ret, 0);
+
+	/* Cleanup */
+	munlock((char *)self->aligned + self->pagesize, self->pagesize);
+
+	log_and_check_pmd_split(_metadata, self->split_pmd_before,
+		self->split_pmd_failed_before);
+}
+
 TEST_HARNESS_MAIN
-- 
2.47.3


