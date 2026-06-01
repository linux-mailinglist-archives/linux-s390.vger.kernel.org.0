Return-Path: <linux-s390+bounces-20297-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHHNOPp5HWrEbAkAu9opvQ
	(envelope-from <linux-s390+bounces-20297-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 01 Jun 2026 14:24:26 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4BB61F37C
	for <lists+linux-s390@lfdr.de>; Mon, 01 Jun 2026 14:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 326AA3039C6F
	for <lists+linux-s390@lfdr.de>; Mon,  1 Jun 2026 12:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC9A368D6B;
	Mon,  1 Jun 2026 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F55OsVzb"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05CD369D6D;
	Mon,  1 Jun 2026 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316134; cv=none; b=askhkElKGTxKygaDZw6e9gOys6AGe2MWT7/GDD8GJyGGX+3MZRLxSFJuh/u6ltlNej3Ic6BSOa+wH7QJkq+ZsNU/sYbLTlrnu09l9QTLfveCfwZFZCnyZP0RJAzAE68GGvqSuteqd5nMFycV/eiJ4fVIIYNGnGAe3UHqlDtjq/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316134; c=relaxed/simple;
	bh=nxKEDNkoPhHrBnnYxSjHGc2mqklG0DWCSFpNLIT4D9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=so7AYdHeKGJbLK8TZdTqTMXl46cuMnWtxfaOrbJdcDAsGgO2bB0FEWuSG2Feb6GZ076O2qHbHf0/sXXOVQwpQJexDcqThMBlTW0XBjE9HKLqfhBzIqK/me0N2NGISt5i+AA7iRSPPksuidDUXb2vBJEmkiWsGhjNEbTdcDti1QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F55OsVzb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765E51F00898;
	Mon,  1 Jun 2026 12:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780316133;
	bh=FXkAepVa1/erCLfvymJS4sclZ5BQh2ct7L6wEI3zzIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F55OsVzbB+sqFBKP7J+BrH1GvFPebPOdbR2Xge/GQqrDhiq6nT70vQBscS1ZeIMds
	 OedYpOxhrTriQ6Tjk7mkgfoCInabP2ZllSulKNe+yA3uTlHp61tqzBjp/aadhkwyyX
	 J1/wIuso3mvLmLHBEwRC7IwIo/89O/EqeNGzUnKZxQHeEDUUqy9SFEDIuHahiTIuSD
	 qAPyRTQgC/4jaAbr3H7z6jRj/qMPq74wdf7QngCRn32RJhLSiGrQTt1942aMoBCWAj
	 4iTQT+0UwzHKLgw2n8z8ksTOBU6RH9RiJCID2DipMbOv96pYXwm0yBL2l15LnO4tht
	 889wlCgfQX9ew==
Date: Mon, 1 Jun 2026 13:15:29 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Oscar Salvador <osalvador@suse.de>, Wei Yang <richard.weiyang@gmail.com>, linux-s390@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_vma_mapped_walk: Use ptep_get_lockless() for
 lockless access
Message-ID: <ah13yAwIl7vfHGjC@lucifer>
References: <20260528075507.1821939-1-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528075507.1821939-1-agordeev@linux.ibm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20297-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,redhat.com,arm.com,suse.de,gmail.com,vger.kernel.org,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8A4BB61F37C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 09:55:07AM +0200, Alexander Gordeev wrote:
> Switch from ptep_get() to ptep_get_lockless() accessor for
> PTE reads when no lock is taken.
>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Oh and the logic looks good so with the commit message updated, feel free to
add:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
>  mm/page_vma_mapped.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index a4d52fdb3056..2ccbabfb2cc1 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -41,7 +41,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
>  	if (!pvmw->pte)
>  		return false;
>
> -	ptent = ptep_get(pvmw->pte);
> +	ptent = ptep_get_lockless(pvmw->pte);
>
>  	if (pte_none(ptent)) {
>  		return false;
> @@ -183,6 +183,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  	struct mm_struct *mm = vma->vm_mm;
>  	unsigned long end;
>  	spinlock_t *ptl;
> +	pte_t pteval;
>  	pgd_t *pgd;
>  	p4d_t *p4d;
>  	pud_t *pud;
> @@ -310,7 +311,11 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  				goto restart;
>  			}
>  			pvmw->pte++;
> -		} while (pte_none(ptep_get(pvmw->pte)));
> +			if (!pvmw->ptl)
> +				pteval = ptep_get_lockless(pvmw->pte);
> +			else
> +				pteval = ptep_get(pvmw->pte);
> +		} while (pte_none(pteval));
>
>  		if (!pvmw->ptl) {
>  			spin_lock(ptl);
> --
> 2.51.0
>

