Return-Path: <linux-s390+bounces-19871-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHtuLF2pDWpr1AUAu9opvQ
	(envelope-from <linux-s390+bounces-19871-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 20 May 2026 14:30:21 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1471158DAD6
	for <lists+linux-s390@lfdr.de>; Wed, 20 May 2026 14:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47AE8310B24E
	for <lists+linux-s390@lfdr.de>; Wed, 20 May 2026 12:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06753D3D01;
	Wed, 20 May 2026 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CxR4mGr/"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B163DB313;
	Wed, 20 May 2026 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279325; cv=none; b=Whth+MjB0FWAfe0AKokhEZjAyjwE7Lmz7DMWcp7e3XChy6hbNc795Y7KBag9emyFgq0ZG90qfyAzb3xG5vbqUkbkLUDwEcb2Zk1SNxcYPFyjkNanB/3a0I9Oaud2i8PdLUJ5DF6ZsgKgAcfGte6rfjjVZxmvu7ALEz6q8aXiy6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279325; c=relaxed/simple;
	bh=3tdAJI8XIZgWJFVgKSkNIeLL1HS/t3CWBHC7BMxsuqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpRlQBfAGSKuE8T5vD4AZ1NfpYAG+8P2LxrmPQt+YfhR3vtX8vmHqT7VyJ1wqnLhcSRAQWXNWFSEoq2rk2WlsWNU5PrxHjuuRlLVNEDK8xbmqqps/zeNUYnr2uZN6ZZJSH9njEbY2Jlztcl1G27PVAN38MMyR4RraU4xrYVlGek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CxR4mGr/; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779279320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpVD7PvJ3yLAhhJddRj1iqDdwuhUY+Ubp+n7mSO2yuo=;
	b=CxR4mGr/kbCFb8VOKtUL9MJeH5OxsnTYvxgXmVOSe0Z9v82ZfRdNB3x4IjDWyCRj/mcar0
	2MlOZFVwz6UAb24nlbVSQvG8zVgEBTUcHXyjchJ9+S+e3On01dfRhOwahPNI2CzLOC+eU2
	2RM45/OVYi7NgcXDE3Ms3iA9ru4uu3M=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: osalvador@suse.de,
	davem@davemloft.net,
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
Subject: Re: [PATCH 4/8] mm/bootmem_info: remove call to kmemleak_free_part_phys()
Date: Wed, 20 May 2026 20:15:05 +0800
Message-Id: <20260520121505.60854-1-lance.yang@linux.dev>
In-Reply-To: <b2a8e918-7ed2-46b4-bf59-e65dc9359310@kernel.org>
References: <b2a8e918-7ed2-46b4-bf59-e65dc9359310@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.de,davemloft.net,gaisler.com,kernel.org,linux-foundation.org,linux.ibm.com,ellerman.id.au,gmail.com,infradead.org,google.com,suse.com,vger.kernel.org,kvack.org,lists.ozlabs.org,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19871-lists,linux-s390=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1471158DAD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, May 12, 2026 at 10:45:03AM +0200, David Hildenbrand (Arm) wrote:
>On 5/12/26 10:34, Oscar Salvador wrote:
[...]
>>> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
>>> index 6e2aaab3dca9..74c1116626c8 100644
>>> --- a/mm/bootmem_info.c
>>> +++ b/mm/bootmem_info.c
>>> @@ -32,7 +32,6 @@ void put_page_bootmem(struct page *page)
>>>  
>>>  	if (page_ref_dec_return(page) == 1) {
>>>  		set_page_private(page, 0);
>>> -		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
>> 
>> A bit odd that kmemleak_free_part_phys() did not complain if we never
>> did kmemleak_alloc_phys() for these pages?
>
>delete_object_part() calls __find_and_remove_object() and essentially just skips
>if it didn't find anything.
>
>Maybe the kmemleak_warn() would trigger, but it's guarded by "#ifdef DEBUG" ...

Right! With kmemleak DEBUG enabled, kmemleak_free_part_phys() does warns
whenever delete_object_part() cannot find the corresponding physical
object ...

Before this patch, booting with:

"kmemleak=on hugetlb_free_vmemmap=on default_hugepagesz=2M hugepagesz=2M hugepages=512"

I got a lot of warnings, something like:

[   44.481883] kmemleak: Partially freeing unknown object at 0x2acc59000 (size 4096)
[   44.482754] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.1.0-rc3 #206 PREEMPT(full)
[   44.482758] Hardware name: Red Hat KVM, BIOS 1.11.0-2.el7 04/01/2014
[   44.482760] Call Trace:
[   44.482762]  <TASK>
[   44.482764]  dump_stack_lvl+0x60/0x90
[   44.482769]  dump_stack+0x14/0x1a
[   44.482774]  delete_object_part.cold+0x28/0x2d
[   44.482779]  kmemleak_free_part_phys+0x67/0x80
[   44.482783]  put_page_bootmem+0xc0/0x100
[   44.482787]  free_vmemmap_page_list+0x13e/0x230
[   44.482791]  __hugetlb_vmemmap_optimize_folios+0x351/0x430
[...]

So, yeah, looks like these calls are trying to free physical kmemleak
objects that are no longer tracked after memmap_alloc() started using
MEMBLOCK_ALLOC_NOLEAKTRACE :)

With this patch applied, those stale calls are gone, and so are the
warnings :P

Tested-by: Lance Yang <lance.yang@linux.dev>

