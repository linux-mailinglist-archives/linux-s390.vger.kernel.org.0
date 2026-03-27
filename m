Return-Path: <linux-s390+bounces-18184-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDOXErXoxWlTDQUAu9opvQ
	(envelope-from <linux-s390+bounces-18184-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 03:17:25 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C22533E303
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 03:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0391B304C429
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 02:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FC97081E;
	Fri, 27 Mar 2026 02:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ffpxHw+P"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF573002B3
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577735; cv=none; b=rnIJOskB9gcRNwbW6IAmlmtMudwfxo7wxyfFOBQYIucnufG3E1kV+88gIW6BkvMHQ8k/euft+afnGUIrkOP91vCe022eFvB5tWcvwcdu8t+2gPiz2SUQC0JTHziWB4sw2T2QXxOOtwhnEvRb9PT0UXmCPPr/HUD2a03tU6fBNtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577735; c=relaxed/simple;
	bh=4BdZVzg7p5U+3is7QnIcqItm+JxYIoZNwRJVRSBVrTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wxl5FN644RIsyyDkjIHJ7kLYaVRhyfLjd6tmxmJqf/cPGWIM/3fqO5NEWIZVaCt2mF0pwe7DrUV9hPUg0DgMNr+SBVf7c+C0ZyOJCf+0A/lY4nXbScS8Xo1zoHSYIu9Y0y4mipce4GjblDE2S7AZhHhdg704Auqt+Lfdj1X5iR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ffpxHw+P; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XO0R5fX+FiXnuLY0HoKuyc3BzHok+k+2YVFrwxlOH1U=;
	b=ffpxHw+PDquRIY7PsBB+gYIVU0HGhnrg/lszSQI4Ss/ylyOhYh/GY54SqX/Gjmz298GChe
	CK1RQEiqAUEGH9vhPBlSkxZYbNei6tVRaaPyX3jC8Yd6BbKN5MzHnqPEqfYrvEF6cG/SMn
	RA3uLKxe+69mdcNlUOoR18d3XTq3a4c=
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
Subject: [v3 13/24] mm: proc: handle split_huge_pmd failure in pagemap_scan
Date: Thu, 26 Mar 2026 19:08:55 -0700
Message-ID: <20260327021403.214713-14-usama.arif@linux.dev>
In-Reply-To: <20260327021403.214713-1-usama.arif@linux.dev>
References: <20260327021403.214713-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18184-lists,linux-s390=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 1C22533E303
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

pagemap_scan_thp_entry() splits a huge PMD when the PAGEMAP_SCAN ioctl
needs to write-protect only a portion of a THP. It then returns -ENOENT
so pagemap_scan_pmd_entry() falls through to PTE-level handling.

Check the split_huge_pmd() return value and propagate the error on
failure. Returning -ENOMEM instead of -ENOENT prevents the fallthrough
to PTE handling, and the error propagates through walk_page_range() to
do_pagemap_scan() where it becomes the ioctl return value.
pagemap_scan_backout_range() already undoes the buffered output, and
walk_end is written back to userspace so the caller knows where the
scan stopped.

If the split fails, the PMD remains huge. An alternative to the approach
in the patch is to return -ENOENT, causing the caller to proceed to
pte_offset_map_lock(). ___pte_offset_map() detects the trans_huge PMD
and returns NULL, which sets ACTION_AGAIN — restarting the walker on the
same PMD by which time the system might have enough memory to satisfy
the split from succeeding.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 fs/proc/task_mmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e091931d7ca19..f5f459140b5c0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2714,9 +2714,13 @@ static int pagemap_scan_thp_entry(pmd_t *pmd, unsigned long start,
 	 * needs to be performed on a portion of the huge page.
 	 */
 	if (end != start + HPAGE_SIZE) {
+		int err;
+
 		spin_unlock(ptl);
-		split_huge_pmd(vma, pmd, start);
+		err = split_huge_pmd(vma, pmd, start);
 		pagemap_scan_backout_range(p, start, end);
+		if (err)
+			return err;
 		/* Report as if there was no THP */
 		return -ENOENT;
 	}
-- 
2.52.0


