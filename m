Return-Path: <linux-s390+bounces-21820-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PLT+FlJqTmoIMQIAu9opvQ
	(envelope-from <linux-s390+bounces-21820-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 08 Jul 2026 17:18:42 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3876727E3C
	for <lists+linux-s390@lfdr.de>; Wed, 08 Jul 2026 17:18:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=D5e2+201;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21820-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21820-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 287BF30EE3EC
	for <lists+linux-s390@lfdr.de>; Wed,  8 Jul 2026 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594AD42DA52;
	Wed,  8 Jul 2026 15:10:06 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED29542DA37
	for <linux-s390@vger.kernel.org>; Wed,  8 Jul 2026 15:10:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523406; cv=none; b=WLITns+fWJ30LI6WZMfVIN+Q/V/dAyzo1BrO1QoZanO8bwAcqLoz4xaiv0OGw7y6S4ZujWm6R+stKvb2ubRhc7f32zIGG0hV4AVODzyzOfD5z1qftdAn+fFoS44DWTx8Y9wvZWBBUvmnUG0ssAKklgCrxSVcOZzpaDo+8uq/lFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523406; c=relaxed/simple;
	bh=qUF6KsoppofOfG6wtjOCxT7Nacq3SZgawqLmlyX+ZfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IZfbYrDj3YXbuQpBerY1+guE1I4Etcds1LucLVVKiB97MY5C55rozU6Tx8pJVUUQHiWhHYezp/1pZGu5yfQcoG4DrEJksvVDbE2aZ4p0KJ0/gamerv+l7Pghbmngumye7X0E1wxomcYszDcxW+4LUn8GUIog05pJXNe6xi4ESvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5e2+201; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843391F000E9;
	Wed,  8 Jul 2026 15:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783523404;
	bh=U4ZYK7G2X5RVbPTLmLwwSbqHHt9FNi9gVxbx6LGWv+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D5e2+2015ja4I4vmwF1xXY99fVLkARpQIyC2NuGfCRKvXBDLKXXQiz1ytbZaGU9iw
	 aVxH3WFo7q2rWHGS7KBCamF4/u0P+SbOjPkPUelCTgkdDFuTkITRFq3PBn/3ozX866
	 rNzNp1nXPwtn5ku49nmxASMVRh4SsiFO3vXGWbFR6cer01+C6tRFJno5ylG/0zFtvo
	 rX1gWMQ0edZAhtoB1bGnozUivQJPAVckzV6K3phXqAXOpvPqsDwT+n+VLPCVVkw0LL
	 Uq6N8y4TUhAG5rWO2Pr28X4BxqMRImb3PTKQYmvhKoN8+0BMiG1/Ju9446ebYDUWJj
	 fZ343HtDKy1yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/10] x86/mm: stop marking vmemmap as SECTION_INFO
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260708-bootmem_info_part2-v1-5-156ce4986598@kernel.org>
References: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
 <20260708-bootmem_info_part2-v1-5-156ce4986598@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 15:10:03 +0000
Message-Id: <20260708151003.843391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	TO_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21820-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:agordeev@linux.ibm.com,m:hca@linux.ibm.com,m:linux-s390@vger.kernel.org,m:gor@linux.ibm.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3876727E3C

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Kernel page table pages (PGD, P4D, PUD, PMD) permanently leak duri=
ng memory hot-remove due to mismatched reference counting.
- [High] Kernel page table pages and vmemmap physical pages are synchronous=
ly freed to the buddy allocator BEFORE their corresponding higher-level pag=
e table entries are cleared, causing a Use-After-Free.
--

--- Patch [5]: [PATCH 05/10] x86/mm: stop marking vmemmap as SECTION_INFO -=
--
commit 9fecf5a2d51cb3529c85d6e643dda7a25adb7fd1
Author: David Hildenbrand (Arm) <david@kernel.org>

x86/mm: stop marking vmemmap as SECTION_INFO

This commit removes the remaining vmemmap bootmem registration machinery
which is no longer required. It stops marking vmemmap pages as
SECTION_INFO and allows free_vmemmap_pages() to free reserved pages
directly.

> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 320e742b0bb3f..82bb0384b8ab0 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1024,19 +1024,12 @@ static void __meminit free_vmemmap_pages(struct p=
age *page, unsigned int order,
[ ... ]
> -	} else {
> +	else
>  		__free_pages(page, order);
> -	}
>  }
> =20
>  static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)

[Severity: High]
This is a pre-existing issue, but does this function (and others like it)=20
free the PTE table page before clearing the corresponding PMD entry?

Looking at free_pte_table(), free_pagetable() frees the PTE table page=20
to the buddy allocator. Only after this does the code acquire=20
init_mm.page_table_lock and call pmd_clear() to unlink it:

arch/x86/mm/init_64.c:free_pte_table() {
    ...
    free_pagetable(pmd_page(*pmd));
    spin_lock(&init_mm.page_table_lock);
    pmd_clear(pmd);
    ...
}

Because init_mm is shared globally, could a hardware MMU page table walk=20
on another CPU speculatively traverse the still-valid PMD entry into=20
the freed page before the pmd_clear() occurs?=20

If the buddy allocator reallocates this page to userspace and it is=20
populated with user-controlled data, could this lead to a use-after-free=20
and potential privilege escalation?=20

A similar pattern appears to exist in remove_pte_table() for physical=20
vmemmap pages.

[ ... ]
> @@ -1593,12 +1586,8 @@ void register_page_bootmem_memmap(unsigned long se=
ction_nr,
>  	p4d_t *p4d;
>  	pud_t *pud;
>  	pmd_t *pmd;
> -	unsigned int nr_pmd_pages;
> -	struct page *page;
> =20
>  	for (; addr < end; addr =3D next) {

[Severity: High]
This isn't a bug introduced by this patch, but does this loop permanently=20
leak kernel page table pages during memory hot-remove?

When vmemmap is mapped with 4KB base pages (e.g., if huge pages are not=20
used), the loop steps forward by PAGE_SIZE. In each iteration, it calls=20
get_page_bootmem() on the intermediate page table pages (like pgd_page=20
and pmd_page), unconditionally incrementing the page refcount.

Because a PMD covers 2MB, the loop visits the exact same pmd_page 512=20
times, incrementing its refcount by 512.=20

However, during memory hot-remove, when the page table is emptied,=20
free_pmd_table() calls free_pagetable() exactly once, which decrements=20
the refcount by only 1:

arch/x86/mm/init_64.c:free_pmd_table() {
    ...
    free_pagetable(pud_page(*pud));
    ...
}

Will the refcount fail to reach 0, permanently leaking the page table=20
page during hot-remove?

> -		pte_t *pte =3D NULL;
> -
>  		pgd =3D pgd_offset_k(addr);
>  		if (pgd_none(*pgd)) {
>  			next =3D (addr + PAGE_SIZE) & PAGE_MASK;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bootmem_in=
fo_part2-v1-0-156ce4986598@kernel.org?part=3D5

