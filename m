Return-Path: <linux-s390+bounces-22278-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9FQzKyVMVmoa3AAAu9opvQ
	(envelope-from <linux-s390+bounces-22278-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:48:05 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B73BE7560A1
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:48:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nii4LqUT;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22278-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-22278-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4027C31A6BE3
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 14:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7B1481FAF;
	Tue, 14 Jul 2026 14:42:49 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377E8245019
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 14:42:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040168; cv=none; b=aOfIYX7RRABP1ToNhrD/h5XC3Ho2qFY5fwQSuis1zgqy2SrSxFfUWsGY2M+XWUX7dbo1RqxLvMUkVJwU16vHPEgxhQOA6FkT31ZwD/yawVfm9ewDmpYM5624/+xvIrbFkjB4AkK8AP0skfJP2KAfa7pEmdR6Gv9THlTgDg4q8As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040168; c=relaxed/simple;
	bh=pywX3Xsz0qNBhUnGp2hnl5t5n8f960UHShK/7mqpttg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YZc9ZotZDMFfwh65tYyE9iiF7pc2m1EYeLV2MBwQNKIYFbNMjwaEG9xuukdp26pwf450owEsb3J6erUKj1sexvv22/Nl6jjVbuHs3cQoiNFN22eOQBzidwRpj/Cxr6bCjgty5AoDWopfPe8g00TWuYAlSq3nEM2BEoaBVx8A7QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nii4LqUT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641C81F000E9;
	Tue, 14 Jul 2026 14:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784040152;
	bh=02naE/FBngPObjMizTz9qTUL3h29NRxoQl2OwhWRgDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nii4LqUT+DWkfOaJGX4BBvyiPIcWHuSSeeIQzWsYN7HeGZe1YNA8fzr0kGhSuJo42
	 348HE0eTGV83F8hzwZfw/BrhwAn7D96diaI0Lu1lJHQVYZEtrlD1QsgZ2n552HgGY3
	 jFpZW6vD09gQiim8yn5gvHoACDwsUeBI2d+tPco8uHfCMmHtVXsQ5Zsmxbmpnrf9Lo
	 8NvP0Y5MMyIc0UpxJt0/k34rq+CG9C2qxK7FSGuiqPh/aT61ahkZ4YeFLaJVNiCSv5
	 TJDUKvWo44+41NAFWYrqJ902F62t8X6FlfxrnZbcO9yvWPyGwBA0iPk1xX8kFN1gkX
	 25Ddd9O7XwgwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/22] mm: pagewalk: drop redundant address check for
 kernel mm walks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kevin Brodsky" <kevin.brodsky@arm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260714-remove_pgtable_cdtor-v1-17-44be8a7685d7@arm.com>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
 <20260714-remove_pgtable_cdtor-v1-17-44be8a7685d7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 14:42:31 +0000
Message-Id: <20260714144232.641C81F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-22278-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kevin.brodsky@arm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B73BE7560A1

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the `addr >=3D TASK_SIZE` check in `walk_pte_range()` cau=
ses `ptdump` to clear valid kernel PMDs, leading to memory corruption and a=
 kernel panic.
--

--- Patch [17]: [PATCH 17/22] mm: pagewalk: drop redundant address check fo=
r kernel mm walks ---
commit 85b512e55cb35ec57a18d00b67fbf62a68320627
Author: Kevin Brodsky <kevin.brodsky@arm.com>

mm: pagewalk: drop redundant address check for kernel mm walks

This commit removes the addr >=3D TASK_SIZE check from walk_pte_range() for
no-VMA walks. It relies entirely on mm_is_kernel() to determine whether
to use pte_offset_kernel() or pte_offset_map().

> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index a3f47d1de3c5a..0dd9d4ad9b689 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -68,17 +68,14 @@ static int walk_pte_range(pmd_t *pmd, unsigned long a=
ddr, unsigned long end,
>  	if (walk->no_vma) {
>  		/*
>  		 * pte_offset_map() might apply user-specific validation.
> -		 * Indeed, on x86_64 the pmd entries set up by init_espfix_ap()
> -		 * fit its pmd_bad() check (_PAGE_NX set and _PAGE_RW clear),
> -		 * and CONFIG_EFI_PGT_DUMP efi_mm goes so far as to walk them.
>  		 */
> -		if (mm_is_kernel(walk->mm) || addr >=3D TASK_SIZE)
> +		if (mm_is_kernel(walk->mm))
>  			pte =3D pte_offset_kernel(pmd, addr);
>  		else
>  			pte =3D pte_offset_map(pmd, addr);

[Severity: High]
Does removing the addr >=3D TASK_SIZE check here cause ptdump to clear valid
kernel PMDs?

When tools like ptdump walk the address space (e.g. via
/sys/kernel/debug/page_tables/current_kernel), they may walk kernel address=
es
using current->mm, which is a user mm. In this case, mm_is_kernel() returns
false, causing walk_pte_range() to use pte_offset_map() for kernel addresse=
s.

On x86, pte_offset_map() eventually calls __pte_offset_map(), which validat=
es
the PMD using pmd_bad(). If a kernel PMD (such as the espfix mapping) fails
this check because it intentionally lacks _PAGE_RW and sets _PAGE_NX,
__pte_offset_map() unconditionally clears it via pmd_clear_bad().

Since kernel page tables are shared via init_mm, clearing the PMD permanent=
ly
destroys the global espfix mapping. The next IRET to a 16-bit userspace
segment would then encounter a missing page table, triggering a Double Fault
kernel panic.

Should we keep the addr >=3D TASK_SIZE check to ensure kernel addresses alw=
ays
use pte_offset_kernel(), even when walked via a user mm?

>  		if (pte) {
>  			err =3D walk_pte_range_inner(pte, addr, end, walk);
> -			if (!mm_is_kernel(walk->mm) && addr < TASK_SIZE)
> +			if (!mm_is_kernel(walk->mm))
>  				pte_unmap(pte);
>  		}
>  	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-remove_pgt=
able_cdtor-v1-0-44be8a7685d7@arm.com?part=3D17

