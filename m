Return-Path: <linux-s390+bounces-20923-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ekRKOqWGMWqolgUAu9opvQ
	(envelope-from <linux-s390+bounces-20923-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2026 19:23:49 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F07A869312F
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2026 19:23:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SpNuP7Bq;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20923-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20923-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCE283019AA4
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2026 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1187449EA8;
	Tue, 16 Jun 2026 17:10:30 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F61443D4E8;
	Tue, 16 Jun 2026 17:10:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629830; cv=none; b=lkaRMqQXw+SQoMNEuJ2FzBhcMuzuMW7gUJJApZgwYdM1pgqpVCDmJsAAMF9Y5sUowKo6QPaJYmwJ4GrOUhADbUj8XTygYLq0IS1zl0AxVjQRDevRdpEWH9/VVhozxdSzptn7DjV/A69NMfotTkdWW4Mq6RJJY20Dozy2Y8xZ0uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629830; c=relaxed/simple;
	bh=FeVPw72m8Orap6K4YYKPGLgiARTfvlnnJuZffgd3MdM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l3meuCV9kbDZq5l3Q5ruMcEU2S+zgmj4UJlEwi8hCa8eD2/r9QW005dkGBQ11VlLuOebaUOhoF6mwRJhTAWewXkALfN0Y1rkAUhH63pJjVasfCfyhirh5FHsZGQxbwpKVbJdGRX8WYvQBRNp5SONC4Wpho0uw+hSV6caQ8ECkSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpNuP7Bq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0806F1F00A3A;
	Tue, 16 Jun 2026 17:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781629829;
	bh=dLL6yfb9e3BptWSL3TAI4I7VY3dtqEamsaczceShSCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SpNuP7BqYjt+KbSryyoCnJdQs828P24lrqf8sXpNsQ3kOLlFgNCNvA7TyiuUJhn/w
	 QiJhg7B+6OLdhXoWFcF7XQoRVG7ltk4kk3lAGtQ07cce4Sg6bL+TVlnXXVvjjBeWTn
	 086v3LVq2Uhdh5FusCN3ZQ4S6JfHU/PvbM2cCnM6qK5eVMXnRX2tp5kqFMtChg9vpy
	 JnMq//2lJtDxU8AmAm/O6cRot0cVCJnGdYieD2upSktPNi3KcuhaLAkatb9qd1pBqi
	 Ibn1wQfyq5JCGSFzGM/K7TWQ4rir1hFevH2BW48o/I1KV6hUeSu1rRyT67SQ3haJmE
	 bL1VoTQklzjFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] KVM: s390: Do not set special large pages dirty
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260616165110.360921-4-imbrenda@linux.ibm.com>
References: <20260616165110.360921-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 17:10:28 +0000
Message-Id: <20260616171029.0806F1F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20923-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,fc1.pr:url,smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:kvm@vger.kernel.org,m:hca@linux.ibm.com,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F07A869312F

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Commit message and code mismatch regarding 'large' vs 'special' pag=
e.

Pre-existing issues:
- [Critical] Missing checks for 'special' page table entries before resolvi=
ng to folios, leading to host kernel crashes during unmap or VM teardown.
--

commit 326f6a92844d8bfeb743555b0b3e68a96053b8ea
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Do not set special large pages dirty

This commit prevents setting special pages or folios dirty, adding a check
specifically for large pages in gmap_clear_young_crste().

> Add a missing check in gmap_clear_young_crste() to prevent setting the
> large page dirty if it is a large page.

[Severity: Low]
This isn't a bug, but there is a typo in the commit message. The code adds
a check for the special bit (!new.s.fc1.s), but the message says "if it is
a large page" instead of "if it is a special page". Should the commit
message be updated to match the code?

> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
> index 52d55ddea8d4f..3192f610f6962 100644
> --- a/arch/s390/kvm/gmap.c
> +++ b/arch/s390/kvm/gmap.c
> @@ -327,7 +327,7 @@ static long gmap_clear_young_crste(union crste *crste=
p, gfn_t gfn, gfn_t end, st
>  		new.h.i =3D 1;
>  		new.s.fc1.y =3D 0;
>  		new.s.fc1.prefix_notif =3D 0;
> -		if (new.s.fc1.d || !new.h.p)
> +		if ((new.s.fc1.d || !new.h.p) && !new.s.fc1.s)
>  			folio_set_dirty(phys_to_folio(crste_origin_large(crste)));

[Severity: Critical]
This is a pre-existing issue, but since this patch fixes a missing special
bit check here, are there other places missing this exact same check that
could lead to a host kernel crash?

For example, in arch/s390/kvm/gmap.c, _gmap_unmap_crste() calls
phys_to_folio() on a large page without checking if it is a special page:

	if (old.s.fc1.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->flags=
))
		folio =3D phys_to_folio(crste_origin_large(old));

Similarly, _gmap_unmap_pte() calls pfn_folio() on a standard PTE without
checking the special bit (ptep->s.s):

	if (ptep->s.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->flags))
		folio =3D pfn_folio(ptep->h.pfra);

_destroy_pages_crste() and _destroy_pages_pte() also appear to
unconditionally resolve PFNs to page structs without checking the special
bit before passing them to __kvm_s390_pv_destroy_page().

Could a Secure/PV VM mapping an IO memory region directly (like via VFIO)
cause a local denial of service when this memory is unmapped or the VM is
destroyed, because these IO-mapped PFNs lack a valid struct page?

Also, in ptep_get_and_clear() in arch/s390/include/asm/pgtable.h,
uv_convert_from_secure_pte() is called on any present PTE in a protected mm
without verifying !pte_special(res):

	if (mm_is_protected(mm) && pte_present(res))
		WARN_ON_ONCE(uv_convert_from_secure_pte(res));

This unconditionally calls pfn_folio() on the PFN derived from the host
PTE in arch/s390/kernel/uv.c:uv_convert_from_secure_pte(). Should these
paths also be updated to ensure they check for special page table entries
before resolving them to folios?

>  		new.s.fc1.d =3D 0;
>  		new.h.p =3D 1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616165110.3609=
21-1-imbrenda@linux.ibm.com?part=3D3

