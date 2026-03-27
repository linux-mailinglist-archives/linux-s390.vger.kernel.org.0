Return-Path: <linux-s390+bounces-18175-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG5xJi/oxWlTDQUAu9opvQ
	(envelope-from <linux-s390+bounces-18175-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 03:15:11 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2FC33E20A
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 03:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 998FA3014A29
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 02:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC533290D2;
	Fri, 27 Mar 2026 02:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lWTo7Sxh"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D748285CA3
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 02:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577682; cv=none; b=EKT8MGdqCzvsQvGFQCDeEBtIU2FQHdjaDbTp4dm5+2KuYHHjYA3FZRuAmOy4nXB8kzaRRZzczDKQmdQ1zYACbFG3iehCzcjEjTmzHvFrwyNn5AfA9yZHGpVpO+xSbsa5xDqrCldSd6C6QAPrZUIrFLEzrLz9xhG486t5CMDT2Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577682; c=relaxed/simple;
	bh=hoI8HXVgTW3QKeCmiQ8BY+fI6mXjuan+bCtnpnDK8I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIwkmz0NC+rI9SyzqWAy2a8qR/Qgq8M47dxIMPnNxRc0s1FgNkYBpNZN5w4XsVVfVGKd/h0lZ1o9sWBgVFzRVjCNMihOqh5caXPp4PKVB27tkAc8IsstodUOzYlg7LHQQzyn65v6LwYzTMiGJTdtXWNnQmLSayzcV+r0Xa9w7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lWTo7Sxh; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HoJOR/NIUvMGOPs6vSvgMHM3cn3cr848MTO9YNsr9oY=;
	b=lWTo7SxhC2/el6n5yFl/mHGjsk9IDwHTkAjGiFljw5zNKe4kG/HDpe+AsO9ZpB7Xn6yD+M
	lcl/hkBeI86GVj/xnEw8geiYoIXVZyBgQnR/YjKR6jzAP1uj+D4R7LeXEfle4CWzYnGNLi
	3qFtTl8j3HQslYlUdM8vuHjTd+DqRMA=
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
Subject: [v3 03/24] mm: thp: handle split failure in copy_huge_pmd()
Date: Thu, 26 Mar 2026 19:08:45 -0700
Message-ID: <20260327021403.214713-4-usama.arif@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18175-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD2FC33E20A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

copy_huge_pmd() splits the source PMD when a folio is pinned and can't
be COW-shared at PMD granularity.  It then returns -EAGAIN so
copy_pmd_range() falls through to copy_pte_range().

If the split fails, the PMD is still huge.  Returning -EAGAIN would cause
copy_pmd_range() to call copy_pte_range(), which would dereference the
huge PMD entry as if it were a pointer to a PTE page table.
Return -ENOMEM on split failure instead (which is already done in
copy_huge_pmd() if pte_alloc_one() fails), which causes copy_page_range()
to abort the fork with -ENOMEM, similar to how copy_pmd_range() would
be aborted if pmd_alloc() and copy_pte_range() fail.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/huge_memory.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 99f3b8b24c682..8ad43897bdf80 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1913,7 +1913,13 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte_free(dst_mm, pgtable);
 		spin_unlock(src_ptl);
 		spin_unlock(dst_ptl);
-		__split_huge_pmd(src_vma, src_pmd, addr, false);
+		/*
+		 * If split fails, the PMD is still huge so copy_pte_range
+		 * (via -EAGAIN) would misinterpret it as a page table
+		 * pointer.  Return -ENOMEM directly to copy_pmd_range.
+		 */
+		if (__split_huge_pmd(src_vma, src_pmd, addr, false))
+			return -ENOMEM;
 		return -EAGAIN;
 	}
 	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
-- 
2.52.0


