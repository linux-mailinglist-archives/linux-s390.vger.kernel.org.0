Return-Path: <linux-s390+bounces-21003-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ff2nMzILNGrFLwYAu9opvQ
	(envelope-from <linux-s390+bounces-21003-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 17:13:54 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3706A1261
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 17:13:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bRV47cGo;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21003-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21003-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52C32306BA82
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 15:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A4A1DDC1D;
	Thu, 18 Jun 2026 15:10:49 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7EC1C3BFC
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 15:10:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795449; cv=none; b=hzgJo/I3DXOVLJf/pxYuV1cEkvAuNr59rAygRVMZGNlv4Zcjta5/iHNE9BKKOmM1x7LW5ku35nl0NqtNQF4T6gxHF5HFmH9UA24Ws9BwAqgK/3vuFcZrDBDtlc8XrrFmnk4C/UU6L+aqF4w+QqpRFtNTSzAEs//TzMNkeRtB1DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795449; c=relaxed/simple;
	bh=DaMEyzJte5E7wdGtpMpplPaC7uYintnRlwN+wY90eBI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TPslwSG14BYEMUBRWXcATjMW7RDZPXToqQbhhDJ+VwsBXDToSW9Oshz7UfndeCunfZeVVMuJypyzjpq2iPEwDFOgdtI7f+RVLqSg7lZgNWjpNat3+YKXBq7m5wni3N2TBDJXKtHN17MxYMp3XRVR1megZKZsUiEIJYzSGfy+FzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRV47cGo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063661F000E9;
	Thu, 18 Jun 2026 15:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795448;
	bh=BDfOv6Z9L5c4Wbjuw4xAGcEDmevB0FSlB9lPj1gs270=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bRV47cGo2ReNt9TjJZN8bZIK/VbxGLMFRqemR4mDAJtVlo+9OESy+r4fmP/vhZaQI
	 qrMoTJwRxAjJv67H0n6lDM/bBcbXn8WZKKKvqiZslXRdHvdVhGK+SpcR7qqe23Pq+L
	 sj3i6YQst1VeU+lCEVMhsmy/p9YUydYHAIHQhWKR7UKi6oUYtqTO2GZNY50Kt30oEZ
	 4YTQTrXLdcOd8PaHKROBUULu2vI26qnWcZxwoIkvycXSbkLajHALgmuicJoWcSo/Ho
	 lzFCSTNt0UT+P/SNP/VfqBvTAmW5R7SfdBh1u+asi1mLIPRghpPVIQxQUx5TCNJq9i
	 eNlCwElbJkKOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next v4 2/4] s390/mm: Batch PTE updates in lazy MMU
 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <e50680152fc7d99215d53758fab4b87280d25c20.1781789772.git.agordeev@linux.ibm.com>
References: <cover.1781789772.git.agordeev@linux.ibm.com>
 <e50680152fc7d99215d53758fab4b87280d25c20.1781789772.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 15:10:47 +0000
Message-Id: <20260618151048.063661F000E9@smtp.kernel.org>
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
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21003-lists,linux-s390=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,m:hca@linux.ibm.com,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E3706A1261

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Deferred PTE updates to a per-CPU cache break synchronization =
with lockless page table walkers like GUP-fast, allowing them to pin pages =
being concurrently write-protected for COW.
- [High] The lazy MMU cache bypasses the `full=3D1` TLB flush optimization =
during process teardown, causing an O(N) IPTE storm.
--

commit 38614c455538c6b6144011b070bbbf41513506e6
Author: Alexander Gordeev <agordeev@linux.ibm.com>

s390/mm: Batch PTE updates in lazy MMU mode

This commit introduces a per-CPU cache to batch PTE updates while in lazy
MMU mode. By caching PTE changes and applying them simultaneously with the
IPTE instruction's "Additional Entries" feature, it reduces overall IPTE
traffic.

> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgta=
ble.h
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h

[ ... ]

> @@ -1259,11 +1373,13 @@ static inline pte_t ptep_get_and_clear_full(struc=
t mm_struct *mm,
>  {
>  	pte_t res;
> =20
> -	if (full) {
> -		res =3D ptep_get(ptep);
> -		set_pte(ptep, __pte(_PAGE_INVALID));
> -	} else {
> -		res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
> +	if (!lazy_mmu_ptep_get_and_clear(addr, ptep, &res)) {

[Severity: High]
Does checking lazy_mmu_ptep_get_and_clear() before the 'full' flag bypass
the teardown optimization and cause an IPTE storm?

During process teardown, exit_mmap() and zap_pte_range() use
ptep_get_and_clear_full(..., full=3D1) to clear PTEs without issuing indivi=
dual
TLB invalidations, deferring the flush to a global teardown at the end.
If lazy_mmu_mode_enable_with_ptes() is active, this intercepts the call,
writes _PAGE_INVALID to the cache, and bypasses the if (full) path.

Later, when lazy_mmu_mode_disable() flushes the cache, it calls
__invalidate_pte_range() in arch/s390/mm/lazy_mmu.c:

static void __invalidate_pte_range(...)
{
	...
	if (cpu_has_tlb_lc() && ...)
		__ptep_ipte_range(addr, nr_ptes - 1, ptep, IPTE_LOCAL);
	else
		__ptep_ipte_range(addr, nr_ptes - 1, ptep, IPTE_GLOBAL);
	...
}

This unconditionally executes batched IPTE instructions for all cached PTEs.
For multi-threaded processes, does this turn an O(1) TLB flush operation
into an O(N) global IPTE broadcast, causing a regression in system
performance during process termination?

> +		if (full) {
> +			res =3D __ptep_get(ptep);
> +			__set_pte(ptep, __pte(_PAGE_INVALID));
> +		} else {
> +			res =3D ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
> +		}
>  	}
>  	page_table_check_pte_clear(mm, addr, res);

[ ... ]

> @@ -1289,10 +1405,15 @@ static inline pte_t ptep_get_and_clear_full(struc=
t mm_struct *mm,
>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>  				      unsigned long addr, pte_t *ptep)
>  {
> -	pte_t pte =3D ptep_get(ptep);
> +	pte_t pte;
> =20
> -	if (pte_write(pte))
> -		ptep_xchg_lazy(mm, addr, ptep, pte_wrprotect(pte));
> +	if (!lazy_mmu_ptep_set_wrprotect(addr, ptep)) {

[Severity: Critical]
Can intercepting the write-protect operation here break synchronization with
lockless page table walkers like GUP-fast?

During fork(), copy_pte_range() calls lazy_mmu_mode_enable_with_ptes().
When copy_present_pte() attempts to write-protect the parent's PTE by
calling ptep_set_wrprotect(), the lazy MMU mode intercepts the call via
__lazy_mmu_ptep_set_wrprotect() in arch/s390/mm/lazy_mmu.c:

bool __lazy_mmu_ptep_set_wrprotect(...)
{
	...
	pte =3D __ipte_range_ptep_get(range, ptep);
	if (pte_write(pte)) {
		pte =3D pte_wrprotect(pte);
		__ipte_range_set_pte(range, ptep, pte);
	}
	return true;
}

This updates the per-CPU cache but leaves the physical PTE completely valid
and writable until the cache is flushed at the end of the PMD range. Because
GUP-fast operates locklessly, a concurrent thread in the parent process can
read the physical PTE, observe that it is still writable, and successfully
take a FOLL_WRITE pin on the page.

Meanwhile, fork() proceeds, sees no pins, and shares the page with the
child. Does this create a regression where the parent retains a writable
GUP pin to a page shared with the child, allowing writes to corrupt the
child's memory and break COW isolation?

> +		pte =3D __ptep_get(ptep);
> +		if (pte_write(pte)) {
> +			pte =3D pte_wrprotect(pte);
> +			ptep_xchg_lazy(mm, addr, ptep, pte);
> +		}
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781789772.gi=
t.agordeev@linux.ibm.com?part=3D2

