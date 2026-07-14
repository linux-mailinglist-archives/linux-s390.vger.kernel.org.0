Return-Path: <linux-s390+bounces-22283-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m4A9BhhOVmqT3AAAu9opvQ
	(envelope-from <linux-s390+bounces-22283-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:56:24 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F90775623E
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 16:56:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AEXpWRqn;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22283-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22283-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0E4730099BD
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B31248C8BC;
	Tue, 14 Jul 2026 14:56:21 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B7448AE15
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 14:56:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040981; cv=none; b=P+rsw793uEbfdS0MJfeiToHn19XIBqK4IGk5dr439QQOBbiuHfmJadRfyOgHoegDF67fMoboja0eeYbvSiRBrQ46Uam+3jbNj4qyx7RJUy2W+jIivIaYlu/FhnF/eyd3cgQdogoa0FPVSlvPOjeKAr2LVj43DqBmVq3Cdgz1R2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040981; c=relaxed/simple;
	bh=5JfPAWKh6vT8PkEJtBPviRvgp/CPC9N8IJ6cdJdxrEM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pSWCW7S3ssefMWUNoAz1C7yyiPmJoLV7irnNtqjJLh164zjQm2NDnnR7SHzW4nTQaXc2o7buTrwi2A1E6Y4iDQ/xyYGKTPzw9gVBKbcGz+bdTirh6csycQpUMGy/OhjD+g3yMh4bAPPxtVy4QTom2KhZ0yEhuIqg4tK3aGAabac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEXpWRqn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049841F00A3A;
	Tue, 14 Jul 2026 14:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784040980;
	bh=2RYdTq+gYczVW4aA6jRxLIWaR+XvVyXXFBQrwM7LaFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AEXpWRqnDGKhRZWfAINAmnXIb6iYCjDiEaZQmO6Ygqqih4+1v89CtENAZuPiuWCgA
	 GnA9d5E1nH6MNWvJISBSNuRtEEy3BYe/CIJBgVtqgt6JoqLHQpt4r8sveZRJnrLnSG
	 s4aRUq0Q/pQfgF7cZIHKhONz5VRymrrHva5JyAL9luX8+KT5QHTeHIQ8nBeJosZ9Zv
	 iKgJRXC0+hZVMHqEQBYtUuNNG1rPKuAbX+xzUaW1beCtePyBpthRUNvyv0mUDht12j
	 yB5HBYaD0xgBsB23dXwKcCLBggliBqbvtcPFE5jLbPu9SndG0USw1z/cP8H8XC3wIx
	 JzIsbBhbid+Gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/22] arm64: mm: drop ctor/dtor calls for kernel page
 tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kevin Brodsky" <kevin.brodsky@arm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260714-remove_pgtable_cdtor-v1-20-44be8a7685d7@arm.com>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
 <20260714-remove_pgtable_cdtor-v1-20-44be8a7685d7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 14:56:19 +0000
Message-Id: <20260714145620.049841F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22283-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,arm.com:email,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kevin.brodsky@arm.com,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,m:hca@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F90775623E

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Kernel page tables allocated during memory hotplug leak the NR_PAG=
ETABLE stat and retain the PG_pgtable flag when freed, causing a buddy allo=
cator BUG on reallocation.
--

--- Patch [20]: [PATCH 20/22] arm64: mm: drop ctor/dtor calls for kernel pa=
ge tables ---
commit eb398eca88012b977463df47eaf81e1fcd66213d
Author: Kevin Brodsky <kevin.brodsky@arm.com>

arm64: mm: drop ctor/dtor calls for kernel page tables
   =20
This patch removes pagetable constructor and destructor calls for kernel
page tables, under the assumption that they no longer perform necessary wor=
k.
It also removes the pgtable level callback arguments from the early
allocation wrappers.

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index f723bcf68174f..f1400c6f68ba7 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c

[ ... ]

> @@ -1445,7 +1410,6 @@ static void free_hotplug_page_range(struct page *pa=
ge, size_t size,
> =20
>  static void free_hotplug_pgtable_page(struct page *page)
>  {
> -	pagetable_dtor(page_ptdesc(page));
>  	free_hotplug_page_range(page, PAGE_SIZE, NULL);
>  }

[Severity: High]
Does this cause the buddy allocator to reject the physical page and leak the
NR_PAGETABLE statistic during memory hot-remove?

By dropping the destructor call here, the PG_pgtable flag is no longer
cleared. Since free_hotplug_page_range() eventually calls __free_pages()
directly rather than using pagetable_free(), the required cleanup is entire=
ly
skipped.

If the buddy allocator later reallocates this page, check_new_page_bad()
will detect the leftover PG_pgtable flag, trigger a bad_page() warning,
and permanently leak the page.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-remove_pgt=
able_cdtor-v1-0-44be8a7685d7@arm.com?part=3D20

