Return-Path: <linux-s390+bounces-20146-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEGyEuomGGqZeQgAu9opvQ
	(envelope-from <linux-s390+bounces-20146-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 28 May 2026 13:28:42 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B88F15F14B4
	for <lists+linux-s390@lfdr.de>; Thu, 28 May 2026 13:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78A5A3079172
	for <lists+linux-s390@lfdr.de>; Thu, 28 May 2026 11:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22C13E3150;
	Thu, 28 May 2026 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5V4HWOr"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BF47262B;
	Thu, 28 May 2026 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779967482; cv=none; b=Mpo8mnwWuR/JP1QjPM8TbJ4zvHP9IkD83MGPMl8S7Q3VeW2ILnK8++DYWbsfTYcYnW9wtLx7b3qGLTeRY64UVz1va+4BkrwApr1HQd5msBX+s+Iz0Xnng5WJJpx+RtkZ2T+xsXiLUSOqIPXZv5okUoJokB3F0Xd2UI9wJTRFOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779967482; c=relaxed/simple;
	bh=gCfCYwr5O1HF8HrKGi8ZW5/6uQ751dyUj1fIPM1S+mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=griG3Org0/wAj3h2VkmGJ6C5FKxWCIypGmUTK/CfHsK+NQ1SNdOtyNllZJ99L+iobnURGtbhG+NWtpVQ6rzT/JegZ5Z1i25Ofa7uUrmANNvgHRqMRswT8SznD8bdrRLABYKf1w5QTTqFfgDs1Fmqq0WgTg84zECQdd6jqbnN7zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5V4HWOr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4291F000E9;
	Thu, 28 May 2026 11:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779967481;
	bh=O5hCo12AieiEvQS5ItXa2ui3IkPos7/8NxeCJceX1Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m5V4HWOrNTniIGkD6RJ7hWNU512A5PG9HjVtLbsM6xvKMRcBua/iBKeDeVeuGX/nu
	 NKWYjAa4sxiU7gyqJYZ152vRl1uwKCu8bDG7ncq0ntCA0KbLJh12t1MwBHP03tIyKA
	 TZbffnMlqF+CqYGTA5tzi4z5SLhCCzred5iqDfNicDfgsE5uQrQvxXHCApZ/zNS3C2
	 aZt7Zv1LtigVX5KOGdBftiUdxxLOA4uwzskycZbd2CiK7NqfdWLp38Yyxw987Pobx5
	 ggoOISBudB3sVaEDjpiG1dBD4OKtqASqQSY7nLOb+0rGd3EXo664eI6x1L/x+NMWcM
	 Z91A0jRsVrWvw==
Date: Thu, 28 May 2026 12:24:35 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Oscar Salvador <osalvador@suse.de>, Wei Yang <richard.weiyang@gmail.com>, linux-s390@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_vma_mapped_walk: Use ptep_get_lockless() for
 lockless access
Message-ID: <ahglqif-I4TjFK9X@lucifer>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20146-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B88F15F14B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 09:55:07AM +0200, Alexander Gordeev wrote:
> Switch from ptep_get() to ptep_get_lockless() accessor for
> PTE reads when no lock is taken.

This is an insufficient commit message that's just saying what you're doing,
which isn't very useful.

Please explain why you're doing this and what the benefit is please.

Thanks, Lorenzo

>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
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

