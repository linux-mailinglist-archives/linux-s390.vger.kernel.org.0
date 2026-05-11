Return-Path: <linux-s390+bounces-19504-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDlgBPPjAWoEmAEAu9opvQ
	(envelope-from <linux-s390+bounces-19504-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 11 May 2026 16:13:07 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6942050FD7C
	for <lists+linux-s390@lfdr.de>; Mon, 11 May 2026 16:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6750308E51D
	for <lists+linux-s390@lfdr.de>; Mon, 11 May 2026 14:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E50A3F54AB;
	Mon, 11 May 2026 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC++Iby5"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1CB377020;
	Mon, 11 May 2026 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508373; cv=none; b=Ywkynl5KQ9Rn45eBUHgSDFaekiGeiOsw18OA4KsNnGerLJU03P8onsc506nZdogjKiTQxyUqaree1Ypl6Riv/tvEAQoRsTF37DjhNLpdfCQw6mKhsq9SPa590VkfZA95AVDIkSqdjAHet2yYTVQFj9LCdG+D89C4uwi55/AGEZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508373; c=relaxed/simple;
	bh=7BplXJKZlQZOSJidAvpNkGSKkzbCMEkCK3cF3mfqU+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KBlW/O/vkc3QHH6dSyDb9frolAsIFbKtt7cVmYpxiRI2KVMmwoTtQRdA3IU1WkIADb4Qot9Cw2VhdcO+XjNKVAcZCjJmE/Dl+LIZsoJeqvHjCto7j71q48eRJSmYk+zqYL+TpT+gtjtBhLPpEW377H5B/Fxe2yGO4D+Dx89Ytok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC++Iby5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5FFC2BCC9;
	Mon, 11 May 2026 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508373;
	bh=7BplXJKZlQZOSJidAvpNkGSKkzbCMEkCK3cF3mfqU+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MC++Iby5ok7TXQGGc+uvg4Efk5zAMeJWOG3GMzC9znDRLh77sNxq1/rWfakudf+Lf
	 ryEJQVBagPaPXTKqmKiLzgUcFrnhQ8eOCrfmxUdkhB3iXLgVsV1Tvfklz9fKrJOhCN
	 CBaXJF9ug+ycGiW0eTVI5IIFRqbQjitiB9Utta6xmp5xEwQzK+PYR9jG4kLGMLYKbM
	 hB/XM1I/3Cp9r7hbhk/SBnPybVltI0bkF+F52k7f+2LivbjmQfB8GxCq2rfyHJe4xz
	 JsNU1b+6kEJ9qZjaYN5n/MZmWZxyntdGM4p4s3lOh7wJP0Bcyk/9jekF3yTJqi7Wi/
	 1sEPxTCVP5VBg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 11 May 2026 16:05:35 +0200
Subject: [PATCH 7/8] s390/mm: use free_reserved_page() in vmem_free_pages()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-bootmem_info_prep-v1-7-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
In-Reply-To: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Mike Rapoport <rppt@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 6942050FD7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[davemloft.net,gaisler.com,kernel.org,linux-foundation.org,linux.ibm.com,ellerman.id.au,gmail.com,infradead.org,google.com,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19504-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

We never select CONFIG_HAVE_BOOTMEM_INFO_NODE on s390. Therefore,
free_bootmem_page() nowadays always translates to free_reserved_page().

Let's use free_reserved_page() to replace the free_bootmem_page() loop.
We can stop including bootmem_info.h.

Likely, vmemmap freeing code could be factored out into the core in the
future.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/s390/mm/vmem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index eeadff45e0e1..d8b2a60e0c33 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -4,7 +4,6 @@
  */
 
 #include <linux/memory_hotplug.h>
-#include <linux/bootmem_info.h>
 #include <linux/cpufeature.h>
 #include <linux/memblock.h>
 #include <linux/pfn.h>
@@ -51,7 +50,7 @@ static void vmem_free_pages(unsigned long addr, int order, struct vmem_altmap *a
 	if (PageReserved(page)) {
 		/* allocated from memblock */
 		while (nr_pages--)
-			free_bootmem_page(page++);
+			free_reserved_page(page++);
 	} else {
 		free_pages(addr, order);
 	}

-- 
2.43.0


