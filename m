Return-Path: <linux-s390+bounces-20833-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id st4eJZDnL2ovIwUAu9opvQ
	(envelope-from <linux-s390+bounces-20833-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 13:52:48 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E98A8685D70
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 13:52:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="kXDfcE/T";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20833-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20833-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED745303AA9E
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 11:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83F83E3179;
	Mon, 15 Jun 2026 11:51:14 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855CB3E556D;
	Mon, 15 Jun 2026 11:51:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524274; cv=none; b=eLG3iyIFKR4MSXRZTGhCjOjd2OEcbk8bt1ux2uSqXN6AmE6BPesP56BbhezKeyUX4RK+rVXiqlVnkp3i7GGyQ4MtWI1Pdt0atlLGV2Y2vgtGeUJxIgGeOD+mqo/1hac0QrGh/XfVWn8yNI9OuKGxZW40p6Nafc6A/IkCXPoOurk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524274; c=relaxed/simple;
	bh=G9DF+LVeRWpLBPAArYFvcpgFo4snHNQ/7SaYqW+0po8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EbNnEMSPoK9Oi7p/aimAK+reFP1MyScgTbhi/aBydU+YhFxRQw++7kfDnvboqhoL7LamiNB1pvYZSJhR8emMvTQo8S3F9hFO6N6MDutf6n/7i0xXU9qQzAb2Q6qVdsJ91EU93cmi3mTHJS87uljsqechjcBlQ4qjiS4rOu/CGD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXDfcE/T; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBEF1F000E9;
	Mon, 15 Jun 2026 11:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781524273;
	bh=yUXu4alE/KeaFloIQweWiWORoQm5MlyvR1LJ+TiFn8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kXDfcE/TNHnK2YB40CAQz8TUEE19VvFH0mQErw/X1KiIsxkuW6BOBRDFTUftjWLma
	 88L3EldxbZ+AlXikm3IFUzMIQHoR+qYHw6ZCYXlAObFF2F7xtBtU4YBbC/QvgpgxGl
	 vteZXqYYJimVZwJIGjnA3AnLynYbXv5Hy5P7pLJ/BXMJEpeUHgJIg5IkZWwp5TuW2+
	 XVktZnGOu4xmVMKCxHbfrsdz1gpOReh/2uDMkAFinniPfYg6gt3EW1rrRbQjGZy394
	 42OzLZ95uhlEfr4vmZ5wr/vJXj0WnHDWKGpcx1bUa6UAlisZ4DxLtAAK5ORfGWnxOQ
	 y+c+x+0j8mFIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] s390/mm: Fix handling of _PAGE_UNUSED pte bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260615091741.76724-2-imbrenda@linux.ibm.com>
References: <20260615091741.76724-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 11:51:12 +0000
Message-Id: <20260615115112.EBBEF1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20833-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:kvm@vger.kernel.org,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,m:gor@linux.ibm.com,m:hca@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E98A8685D70

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] `ptep_reset_dat_prot()` misses clearing the `_PAGE_UNUSED` bit=
, allowing used pages to be wrongly discarded.
- [Critical] Hardware Storage Key updates by guest accesses bypass host PTE=
 modifications, allowing `_PAGE_UNUSED` to linger and cause guest corruptio=
n.
--

commit 4a7ab46235e9a4cd801253465aae645c11c76ebb
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

s390/mm: Fix handling of _PAGE_UNUSED pte bit

The patch introduces checks to clear the _PAGE_UNUSED bit in various ptep
exchange and modify functions to prevent used pages from being discarded.
It also ensures the bit is only set for present PTEs in the gmap helper.

> diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
> index 1cfe4724fbe2a..5a7d6b9790e22 100644
> --- a/arch/s390/mm/gmap_helpers.c
> +++ b/arch/s390/mm/gmap_helpers.c

[ ... ]

> @@ -180,8 +180,8 @@ void gmap_helper_try_set_pte_unused(struct mm_struct =
*mm, unsigned long vmaddr)
>  	ptep =3D try_get_locked_pte(mm, vmaddr, &ptl);
>  	if (IS_ERR_OR_NULL(ptep))
>  		return;
> -
> -	__atomic64_or(_PAGE_UNUSED, (long *)ptep);
> +	if (pte_present(*ptep))
> +		__atomic64_or(_PAGE_UNUSED, (long *)ptep);

[Severity: Critical]
This is a pre-existing issue, but does the approach of clearing _PAGE_UNUSED
during host PTE modifications handle hardware-driven updates?

In gmap_helper_try_set_pte_unused(), __atomic64_or() sets _PAGE_UNUSED
without clearing the present or writable bits in the host PTE. If the guest
subsequently writes to this page, the CPU hardware handles it entirely via
Dynamic Address Translation, updating the hardware Storage Key without ever
trapping into the host kernel or modifying the host PTE.

Because the host PTE is never modified, the clearance logic added in this
patch is completely bypassed.

If the host later reclaims this memory via a path that skips
folio_referenced() (such as madvise(MADV_PAGEOUT), which calls
reclaim_pages() with ignore_references =3D true), the PTE is passed to
try_to_unmap_one() with _PAGE_UNUSED still set:

mm/rmap.c:try_to_unmap_one() {
    ...
    } else if (likely(pte_present(pteval)) && pte_unused(pteval) &&
               !userfaultfd_armed(vma)) {
        dec_mm_counter(mm, mm_counter(folio));
    ...
}

Because try_to_unmap_one() evaluates pte_unused() before checking the
Storage Key's dirty state, won't this unconditionally discard the page and
permanently destroy the guest's modified data?

>  	pte_unmap_unlock(ptep, ptl);
>  }

[ ... ]

> diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
> index 4acd8b140c4bd..2acc79383e7df 100644
> --- a/arch/s390/mm/pgtable.c
> +++ b/arch/s390/mm/pgtable.c

[ ... ]

> @@ -175,6 +179,8 @@ pte_t ptep_modify_prot_start(struct vm_area_struct *v=
ma, unsigned long addr,
>  void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long a=
ddr,
>  			     pte_t *ptep, pte_t old_pte, pte_t pte)
>  {
> +	if (pte_present(pte))
> +		pte =3D clear_pte_bit(pte, __pgprot(_PAGE_UNUSED));
>  	set_pte(ptep, pte);
>  }

[Severity: Critical]
This is a pre-existing issue, but it looks like the fix might be incomplete.
Does ptep_reset_dat_prot() also need to clear the _PAGE_UNUSED bit?

Unlike ptep_xchg_direct(), ptep_reset_dat_prot() directly writes the new
PTE without clearing _PAGE_UNUSED:

arch/s390/mm/pgtable.c:ptep_reset_dat_prot() {
    ...
    set_pte(ptep, new);
    ...
}

When a KVM guest unmaps a page, it is marked with _PAGE_UNUSED. If the guest
subsequently writes to this page (for example, an RO to RW transition on a
clean page), ptep_set_access_flags() is called by the host page fault handl=
er.

Because the modification only affects software bits and _PAGE_PROTECT,
pte_allow_rdp() evaluates to true, delegating the PTE update to the
architecture-specific fast path:

arch/s390/include/asm/pgtable.h:ptep_set_access_flags() {
    ...
    if (cpu_has_rdp() && pte_allow_rdp(*ptep, entry))
        ptep_reset_dat_prot(vma->vm_mm, addr, ptep, entry);
    ...
}

Since the new PTE was constructed from the old one, it inherits the
_PAGE_UNUSED flag. Won't the now-dirty page retain the unused flag and be
erroneously discarded without writeback during memory reclaim by
try_to_unmap_one()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615091741.7672=
4-2-imbrenda@linux.ibm.com?part=3D1

