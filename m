Return-Path: <linux-s390+bounces-18182-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qESEEWzpxWlTDQUAu9opvQ
	(envelope-from <linux-s390+bounces-18182-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 03:20:28 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C726333E3DA
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 03:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A61030F3550
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 02:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E02332FA18;
	Fri, 27 Mar 2026 02:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZIxjF05t"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E968329367
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577726; cv=none; b=LFCbzFTTEN2p1HyAKYs+K9SXKVOnrdcwZotL+rKJ3NMniiNoNFSis571qbyNMNQ4wvrh6xMI4RPXvqT9EksR5dlHBgEa93R1wDtiCm9LmTEKv09H0cdY2rypoMwnoMQS5pj2b7no8ht0qMP6Z9REq/wfam1wtY2exCd1i0d2mWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577726; c=relaxed/simple;
	bh=ECEG/Uw4ckEOnjxk0ggFgRuoQFR0FzH4I0uSFBXT4mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAmA3pkjOsaIjo/Sem6cXHlxp/4GseHKAQkatJrQNVNDEHSQM/7rH2hNWRYsYJYCuGW9beCuppJa7jpBUSTDU4okdeLamam4dTvBIMDCBPjZMg/dHA9unTqgGT+pyfKwrqXBWVSTR9D3Sah2s+vPuES6hy/irptsf77r3BvK+K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZIxjF05t; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MnIHRq/fqfQAry7CsjH3C0Gk1Kzxzc2ZoqIQPSTrMd8=;
	b=ZIxjF05tNow9dzUHFs4hqWlnAIWjdc/ZiKkgAVcRdwnfvfmpyyBGO5uiLBm/6z5QMsmkqr
	ztEHZPBtu0iiXBGTFC271TxvM49AQMco70eXk+ARnt2wNg+T9bIFsUICK9N4z8qczvq+p2
	or1an7NL4GSoQ5bKiLd41MfIKi+EWcU=
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
Subject: [v3 11/24] mm: thp: handle split failure in userfaultfd move_pages()
Date: Thu, 26 Mar 2026 19:08:53 -0700
Message-ID: <20260327021403.214713-12-usama.arif@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18182-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: C726333E3DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The UFFDIO_MOVE ioctl's move_pages() loop splits a huge PMD when the
folio is pinned and can't be moved at PMD granularity.

If the split fails, the PMD stays huge and move_pages_pte() can't
process individual pages. Break out of the loop on split failure
and return -ENOMEM to the caller. This is similar to how other
allocation failures (__pte_alloc, mm_alloc_pmd) are handled in
move_pages().

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/userfaultfd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 481ec7eb44420..a04d62dd1e065 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1946,7 +1946,13 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 				}
 
 				spin_unlock(ptl);
-				split_huge_pmd(src_vma, src_pmd, src_addr);
+				/*
+				 * If split fails, the PMD stays huge and
+				 * move_pages_pte can't process it.
+				 */
+				err = split_huge_pmd(src_vma, src_pmd, src_addr);
+				if (err)
+					break;
 				/* The folio will be split by move_pages_pte() */
 				continue;
 			}
-- 
2.52.0


