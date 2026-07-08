Return-Path: <linux-s390+bounces-21804-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9DjrJXtdTmpeLQIAu9opvQ
	(envelope-from <linux-s390+bounces-21804-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 08 Jul 2026 16:23:55 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E790A727487
	for <lists+linux-s390@lfdr.de>; Wed, 08 Jul 2026 16:23:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="hN/SiEhT";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21804-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21804-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99DB63081B6D
	for <lists+linux-s390@lfdr.de>; Wed,  8 Jul 2026 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC25643F4DA;
	Wed,  8 Jul 2026 14:11:07 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54EB37BE7A;
	Wed,  8 Jul 2026 14:11:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519867; cv=none; b=gRHMKsyrfGpqtbpROIodOVTHANBNBN3c/gPlgzIxO5qszqdEomiV9sCVqB3zgiHaMx9n3EfrZmHwotdIgmtTAxt6pjo7g9vqDt2zD49nB+L24XrtUaLW9XjOQgbfRWfSK0J12ngXVItwj85C6xccy+FcANK6faO1Qh4yKWwBFTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519867; c=relaxed/simple;
	bh=uc6ZOQ7T0n3e1exPQijjNLq/oiv/QGunVCeNk1bzDG0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TizrTdUVsFBSEnLrfK49V8zqSiSaanjbtq8lTG6yszaRnMYbNKchEJY7UD9V+skjYS7AjBoUVjasdzFv7UGM2RQi+2oeviS2sNyxNuH6nOC4I35bIJc2ZcAIy09E3wJYL/8HHHW0dY73cb4u8r/BECp133+1bCiI3Q+bdJinu+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN/SiEhT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3D41F000E9;
	Wed,  8 Jul 2026 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783519866;
	bh=Ko4Hdlv9loLHMeM4kMSWr4+ckWdvKkB6i/m+lF4LdTE=;
	h=From:Subject:Date:To:Cc;
	b=hN/SiEhTywl8ROd8W5sQTNgOaPwlrPqNaKn1PwiH4xjk4c8RCtMwP5MIq/zye8n/1
	 AMsqvOw8AsRS/YWKgazxPunLd+6nmh4gofbHsSwHmtNqxVxUiGpiaqc1RjhERCEoB3
	 OPMbft3hBw5/p9OOcBLH2fqZ7UktJBuHCDUd2o40KLGzqP3xMgGBakYiJhYl1fL+MW
	 JzRE+ebX2nGw/tvXWsl1Dbsno6N2eETLR6WoUtnJVpZFXLM7/LVqz8aA6ogU78XWSS
	 YJdJrLYcpV6XVxLChmpq8+8kLJa421lxsAwHRPeYYTgdNZ0ZjE+cK4ZTyeH96wODoT
	 GsPA3y9CHNA4A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 00/10] mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE (Part 2)
Date: Wed, 08 Jul 2026 16:10:55 +0200
Message-Id: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG9aTmoC/x3MQQqAIBBA0avErBPKLKqrRISTU80iDZUIpLsnL
 d/i/wSBPFOAsUjg6ebAzmbUZQHroe1Ogk02yEp2lZK9QOfiSefCdnPLpX2UQiGiUq0ZsDGQw8v
 Txs8/neb3/QBoG3oHZAAAAA==
X-Change-ID: 20260428-bootmem_info_part2-4bbb445d9b3d
To: Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-s390@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dave.hansen@linux.intel.com,m:luto@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:jackmanb@google.com,m:hannes@cmpxchg.org,m:ziy@nvidia.com,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:muchun.song@linux.dev,m:osalvador@suse.de,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-s390@vger.kernel.org,m:david@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[david@kernel.org,linux-s390@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21804-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E790A727487

Let's remove the remaining pieces of CONFIG_HAVE_BOOTMEM_INFO_NODE,
performing some smaller cleanups around freeing of reserved vmemmap
pages on the way.

Tested on x86-64 with hugetlb vmemmap optimization in combination with
KMEMLEAK. Heavily cross-compiled.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
David Hildenbrand (Arm) (10):
      x86/mm: drop order parameter from free_pagetable()
      mm: provide free_reserved_pages(), removing x86 variant
      s390/mm: use free_reserved_pages() in vmem_free_pages()
      mm/bootmem_info: allow calling free_bootmem_page() on pages without a bootmem_type
      x86/mm: stop marking vmemmap as SECTION_INFO
      x86/mm: stop marking page tables as MIX_SECTION_INFO
      x86/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE
      mm/hugetlb_vmemmap: remove bootmem_info leftovers
      mm/sparse: remove bootmem_info.h include
      mm/bootmem_info: remove CONFIG_HAVE_BOOTMEM_INFO_NODE

 MAINTAINERS                  |   1 -
 arch/s390/mm/vmem.c          |   4 +-
 arch/x86/mm/init_64.c        | 134 ++++---------------------------------------
 include/linux/bootmem_info.h |  89 ----------------------------
 include/linux/mm.h           |   8 ++-
 mm/Kconfig                   |   8 ---
 mm/Makefile                  |   1 -
 mm/bootmem_info.c            |  72 -----------------------
 mm/hugetlb_vmemmap.c         |   8 +--
 mm/page_alloc.c              |  33 ++++++++---
 mm/sparse.c                  |   1 -
 11 files changed, 46 insertions(+), 313 deletions(-)

---

base-commit: d11ba1f570615ec8d4814d6313ee1d7075a33787

change-id: 20260428-bootmem_info_part2-4bbb445d9b3d

--

Cheers,

David


