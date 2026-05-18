Return-Path: <linux-s390+bounces-19750-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKnvELbECmqa7wQAu9opvQ
	(envelope-from <linux-s390+bounces-19750-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 18 May 2026 09:50:14 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9621E5681D3
	for <lists+linux-s390@lfdr.de>; Mon, 18 May 2026 09:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FEEF3007349
	for <lists+linux-s390@lfdr.de>; Mon, 18 May 2026 07:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B555730567F;
	Mon, 18 May 2026 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sQA9gAlm"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3CA3B6BFA
	for <linux-s390@vger.kernel.org>; Mon, 18 May 2026 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090592; cv=none; b=uDJaws71YeaU1ifJERtSRWu4WijTZs05xNGPLc1Dv9armXAxUNcnl66U70BUqgvvK6IahKD/FoBSRoX2LpL3wOYvn3ujlEIHDdCr+GY2aDtAO8cwfWMPfrfJu4w3KjhMrovhKejf5XVkCFyYzV2VcRee3R3kfHoEOX0ttyx/AqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090592; c=relaxed/simple;
	bh=dlHK93f7h9wI2wKbxsG36bajUuLGo9Wq/tg0HHtlEMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/mPG+IGHDw9l47OrUwiGbpwxNxUJoLHS23ntRbcaqGZjblzNnDY3yH1vbHiY06lKSm9CovsigD+ZNgRVobiY9/N8rSHxl1dbkiwLXxI2+7r92VueZ+FvpXQ7HQBlDW7aYb9qp2WBI7KT8YjOtPfcUD6uKJ76YZnFjLMVdR+0Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sQA9gAlm; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779090587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTTRIuI2xioXcBOay/WhZ57PMiS4AlcVkZHDZZirdOs=;
	b=sQA9gAlmLXajI0q10KUnEdN1uuZqCxucU3NRWLlR3WCTWt4IvAIwwMmL9Yv6cg1ak9LTUk
	GcZJgc51RUZJ7q5loEHLNQ7RZ6YM5RGuq2Q/7SkVZott8sl3sIvYYq4EpVgjv3FmqR41gO
	tjAWCElujIzm29k6iPaM4P/xnC8SWbI=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH 2/8] mm/bootmem_info: drop initialization of page->lru
Date: Mon, 18 May 2026 15:49:31 +0800
Message-Id: <20260518074931.34380-1-lance.yang@linux.dev>
In-Reply-To: <20260511-bootmem_info_prep-v1-2-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-2-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 9621E5681D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,gaisler.com,kernel.org,linux-foundation.org,linux.ibm.com,ellerman.id.au,gmail.com,infradead.org,google.com,suse.com,vger.kernel.org,kvack.org,lists.ozlabs.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19750-lists,linux-s390=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Mon, May 11, 2026 at 04:05:30PM +0200, David Hildenbrand (Arm) wrote:
>In the past, we used to store the type in page->lru.next, introduced by
>commit 5f24ce5fd34c ("thp: remove PG_buddy"). The location changed over
>the years; ever since commit 0386aaa6e9c8 ("bootmem: stop using
>page->index"), we store it alongside the info in page->private.
>
>Consequently, there is no need to reset page->lru anymore.
>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/bootmem_info.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
>index 3d7675a3ae04..a0a1ecdec8d0 100644
>--- a/mm/bootmem_info.c
>+++ b/mm/bootmem_info.c
>@@ -34,7 +34,6 @@ void put_page_bootmem(struct page *page)
> 	if (page_ref_dec_return(page) == 1) {
> 		ClearPagePrivate(page);
> 		set_page_private(page, 0);
>-		INIT_LIST_HEAD(&page->lru);

Yep, that old INIT_LIST_HEAD() call was dead cleanup. page->lru and
page->buddy_list are in the same union:

			union {
				struct list_head lru;

				/* Or, free page */
				struct list_head buddy_list;
			};

and free_reserved_page() passes the page to the buddy allocator. The
later buddy list insertion will overwrite the values written by
INIT_LIST_HEAD(&page->lru) anyway.

> 		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
> 		free_reserved_page(page);
> 	}

LGTM, feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>

