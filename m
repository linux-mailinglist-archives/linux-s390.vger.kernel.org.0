Return-Path: <linux-s390+bounces-19498-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JAfBgfjAWoEmAEAu9opvQ
	(envelope-from <linux-s390+bounces-19498-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 11 May 2026 16:09:11 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 749D950FBEA
	for <lists+linux-s390@lfdr.de>; Mon, 11 May 2026 16:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 583E63047E4C
	for <lists+linux-s390@lfdr.de>; Mon, 11 May 2026 14:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5075C3FA5FE;
	Mon, 11 May 2026 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVqW/8uB"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1863A1D05;
	Mon, 11 May 2026 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508344; cv=none; b=ZBz7T0Xm7LzevLJ5eyi70PZggvtW0jjG/QOgF/MHpok/iu9kTjvG5OwKYVChKu69vFJEeUOuJqQUdqgAi9vuuh+SfjKPuY5dp38RpEmIDEO1f4Onv59RkD1ekGqWKe0DbtlTRzMRo7acWKJUyVVt45BuTIT0dIXBjimeP4YGkfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508344; c=relaxed/simple;
	bh=zGEwXeQeeaa/yetEDRVp5+lm1X5UYQ4s449U39c7KOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dzmZQ8EPXgRv2XUS+q5ajDJ3PPYitfLrPmnckQccwEekjJYX+HoDqNbzizh3MrFcoEl69L/E6S8E2A/j6kZI0WUfKU263lSDMDq4Br/xJrDA6mwZ9slOuWn/wM8TeSFXaTQVK6csHuBx11SfEwK4A/RX2K8qusIzkuOtPhP1KyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVqW/8uB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD66C2BCB0;
	Mon, 11 May 2026 14:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508343;
	bh=zGEwXeQeeaa/yetEDRVp5+lm1X5UYQ4s449U39c7KOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZVqW/8uBvCQNuH1FvNzPpfFfOV3fXvq9+aGIjhZjuuGqpF1t7+7+jnJnz2fGIA+/D
	 yxYGeANt8K3XRNU9rBN3mNKFQ+2z65C4F0WaEymY9eIT42HUwFGIU35Eb4InQAFnZw
	 9tKd3WH7g8BdkcFMxeaxQoBX4UoNqEc/YvxkV3cx1VktE0HUZwsiTxNo4b95L8Va7o
	 QEBPTERhjBauEwb1ned73L8nMQCwv2VkyNbRrjtncsuhg7G7zOIjCHkibLXIpKONG4
	 1JdBvkGT+0r4+PiZFrgPk/5vVPlDICWGR2QQJJ3jB2zi39CRKDKza7z1iF9RCoh54s
	 M1DoU+naPhh3Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 11 May 2026 16:05:29 +0200
Subject: [PATCH 1/8] sparc/mm: remove register_page_bootmem_info()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-bootmem_info_prep-v1-1-3fb0be6fc688@kernel.org>
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
X-Rspamd-Queue-Id: 749D950FBEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[davemloft.net,gaisler.com,kernel.org,linux-foundation.org,linux.ibm.com,ellerman.id.au,gmail.com,infradead.org,google.com,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19498-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

sparc does not select CONFIG_HAVE_BOOTMEM_INFO_NODE, therefore,
register_page_bootmem_info_node() is a nop.

Let's just get rid of register_page_bootmem_info().

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/sparc/mm/init_64.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 367c269305e5..3b679b1d1d72 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -27,7 +27,6 @@
 #include <linux/percpu.h>
 #include <linux/mmzone.h>
 #include <linux/gfp.h>
-#include <linux/bootmem_info.h>
 
 #include <asm/head.h>
 #include <asm/page.h>
@@ -2477,17 +2476,6 @@ int page_in_phys_avail(unsigned long paddr)
 	return 0;
 }
 
-static void __init register_page_bootmem_info(void)
-{
-#ifdef CONFIG_NUMA
-	int i;
-
-	for_each_online_node(i)
-		if (NODE_DATA(i)->node_spanned_pages)
-			register_page_bootmem_info_node(NODE_DATA(i));
-#endif
-}
-
 void __init arch_setup_zero_pages(void)
 {
 	phys_addr_t zero_page_pa = kern_base +
@@ -2498,14 +2486,6 @@ void __init arch_setup_zero_pages(void)
 
 void __init mem_init(void)
 {
-	/*
-	 * Must be done after boot memory is put on freelist, because here we
-	 * might set fields in deferred struct pages that have not yet been
-	 * initialized, and memblock_free_all() initializes all the reserved
-	 * deferred pages for us.
-	 */
-	register_page_bootmem_info();
-
 	if (tlb_type == cheetah || tlb_type == cheetah_plus)
 		cheetah_ecache_flush_init();
 }

-- 
2.43.0


