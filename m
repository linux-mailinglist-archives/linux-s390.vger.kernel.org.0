Return-Path: <linux-s390+bounces-22281-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gPbBM15OVmqh3AAAu9opvQ
	(envelope-from <linux-s390+bounces-22281-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:57:34 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0E075626D
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:57:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DMB7cwR0;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22281-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-22281-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EE8F300D149
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 14:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489DD48AE35;
	Tue, 14 Jul 2026 14:54:37 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF95480968
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 14:54:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040877; cv=none; b=dx1TrGMv9j8EIuoojPOrQcoMZdr6/rKB7M1v5EOt2KqzTfKz+N+5/OhVR1rjgLFHDxSMXzIM/WNvVlTUpITYyiqxPY58dj2CcKwKyaLzyL5SDMHC+rbQm4U4gEKcM3uFnuUdW15ouL2/CmBzqkhogdxhHMlS0oF2+MJkLn11Jsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040877; c=relaxed/simple;
	bh=9cmv/FZ0CcrkcDaSnDQG95wKDmvYkymSpeNLWiwb0f4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sV8m4AJX7+mqGV2W6VL6pnEmItM9pxoCsiXRHMgkNV/7nVp+tYsQaFEA9ISJXMTmqUS8f5LzmHNJ69gGJeqqXSOmrHgFp5p7ye4pDHWq7nYaqsU/0F0y5ieWxxi+KjF3i5Oj1+C/HikaF0zNwkHbsBS5SkaIGgBb+v7ETiGmjWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMB7cwR0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589761F00A3A;
	Tue, 14 Jul 2026 14:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784040875;
	bh=nhNkkNKJ2kiRx0qNjR9UwDai8c/Ykb9viyG2uqx9c8Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DMB7cwR0Ri3VF6Uch/WZ8Oszvn5Oe77dQwcd1a35lPtklW4++KrgNKQ/sgukmqPiT
	 Pn1dCgRvH5jY1JosL7YZoMFpV62SHkdJHVbce+2Aq5B1AT4Yz4YeKX7NhECgp2Pl3e
	 xCoxYvZOnMI72ODpYQjVcrrszApxUG4s0dvZdg7Gd4JPgmpGhnVaUvT11FsJELBTj+
	 sxPaFtGcSS40I3EekDE2naS0kZ99rQJlG56pSgCAy9g3ptUESihhUkxFBJhQXsWgd+
	 dH/MU1+fV1s7Os6VyaZT95P/mz+bhWHWYj5ZfBg6v9ql69A65wXL9gvep7DA95JH4x
	 K+f+8A2JGnI9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/22] mm: set page table page type when allocated
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kevin Brodsky" <kevin.brodsky@arm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260714-remove_pgtable_cdtor-v1-14-44be8a7685d7@arm.com>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
 <20260714-remove_pgtable_cdtor-v1-14-44be8a7685d7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 14:54:34 +0000
Message-Id: <20260714145435.589761F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22281-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kevin.brodsky@arm.com,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,m:gor@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E0E075626D

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing PG_table page type initialization for custom allocators =
that bypass pagetable_alloc_noprof().
- [Medium] Bypassing pagetable_free() causes leaked PG_table state and perm=
anent NR_PAGETABLE accounting leaks.
--

--- Patch [14]: [PATCH 14/22] mm: set page table page type when allocated -=
--
commit ec9e373da7e406797591704d23e05fdbf402dfe3
Author: Kevin Brodsky <kevin.brodsky@arm.com>

mm: set page table page type when allocated

This commit moves page table page type updates from the constructors and
destructors directly into pagetable_alloc_noprof() and __pagetable_free().
It leaves __pagetable_ctor() empty and removes it.

Link: https://lore.kernel.org/r/20251113140448.1814860-4-willy@infradead.org

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 361a0d7b74c51..94f0fb1c662ae 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
[ ... ]
> @@ -3799,19 +3801,9 @@ static inline bool ptlock_init(struct ptdesc *ptde=
sc) { return true; }
>  static inline void ptlock_free(struct ptdesc *ptdesc) {}
>  #endif /* defined(CONFIG_SPLIT_PTE_PTLOCKS) */
> =20
> -static inline void __pagetable_ctor(struct ptdesc *ptdesc)
> -{
> -	struct folio *folio =3D ptdesc_folio(ptdesc);
> -
> -	__folio_set_pgtable(folio);
> -}
> -
>  static inline void pagetable_dtor(struct ptdesc *ptdesc)
>  {
> -	struct folio *folio =3D ptdesc_folio(ptdesc);
> -
>  	ptlock_free(ptdesc);
> -	__folio_clear_pgtable(folio);
>  }

[Severity: Medium]
Since __folio_clear_pgtable() was moved to __pagetable_free(), what happens=
 to
architectures that bypass __pagetable_free() entirely?

For example, without CONFIG_MMU_GATHER_TABLE_FREE, tlb_remove_table() calls
pagetable_dtor() and frees the page directly via the batcher:

include/asm-generic/tlb.h:tlb_remove_table() {
    ...
	pagetable_dtor(ptdesc);
	tlb_remove_page(tlb, ptdesc_page(ptdesc));
}

Similarly, arm64 memory hot-remove frees pages directly:

arch/arm64/mm/mmu.c:free_hotplug_pgtable_page() {
	pagetable_dtor(page_ptdesc(page));
	free_hotplug_page_range(page, PAGE_SIZE, NULL);
}

Will this bypass cause a permanent leak in the NR_PAGETABLE counter and lea=
ve
the PG_table flag set on the page as it enters the buddy allocator?

>  static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
> @@ -3825,7 +3817,6 @@ static inline bool pagetable_pte_ctor(struct mm_str=
uct *mm,
>  {
>  	if (!mm_is_kernel(mm) && !ptlock_init(ptdesc))
>  		return false;
> -	__pagetable_ctor(ptdesc);
>  	return true;
>  }

[Severity: Medium]
Are there custom allocators that rely on pagetable_pte_ctor() to initialize
the page type?

For instance, on SPARC32, user PTE tables are allocated via a custom pool
using srmmu_get_nocache() which bypasses pagetable_alloc_noprof(). They
rely on pagetable_pte_ctor() to set the page type:

arch/sparc/mm/srmmu.c:pte_alloc_one() {
    ...
	if (page_ref_inc_return(page) =3D=3D 2 &&
			!pagetable_pte_ctor(mm, page_ptdesc(page))) {
    ...
}

By removing __pagetable_ctor() here, it seems these pages will no longer
have the PG_table flag set. Is this the intended behavior?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-remove_pgt=
able_cdtor-v1-0-44be8a7685d7@arm.com?part=3D14

