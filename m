Return-Path: <linux-s390+bounces-21228-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VLfpB3XBO2oecQgAu9opvQ
	(envelope-from <linux-s390+bounces-21228-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 13:37:25 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AB06BDB38
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 13:37:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CToDUxtG;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21228-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21228-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E4524300A271
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 11:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FA6364953;
	Wed, 24 Jun 2026 11:37:18 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931F1A6810;
	Wed, 24 Jun 2026 11:37:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301038; cv=none; b=r7pD9tlTiALN6+Q/aQzTmmN/dz3JylYcTXmzn1H5zfgaVSkeRFDxCILYS2NpzXtt/WiMqSwfrigt4LuBVAUoS4RRiwZ7Qw9+yejW/WrqRpJ/N9q/+UD0Edh4GNQt0Lpk/Kw4fkXbda9pro6MxY2f+F2dEqi71EC7J4SKHd+jIGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301038; c=relaxed/simple;
	bh=BXttZtIjYhmZniM9h6DEz+dCCFljyrUJR1AUoon+7t4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G5sp7umeUrvr7UOdSj3MiqJGpr7PSojUSdxEoGqds9lYl+pMEJSpTamM/ZZh0+5lDgMa5TOYahsbvuu0hc0YrR6XNwQq9OBF0AsNGOF4U1SvG7kIn5xJOCpiA65P8Q120P9C2qJ/qhFmY3Q80d4bXLRwEXqPEqK1EQDHf0OmYW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CToDUxtG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC951F00A3A;
	Wed, 24 Jun 2026 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782301037;
	bh=dbsdz1Se4yBvj37WN7WCUGl/KxY/Tc8U7Ys4raJWlj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CToDUxtGv6ZShizRxteLUUfkDzeZPWAB0Hu3NgXy9E0Abn4ZKuJl4rLDaj3wTR7sl
	 EzF3UuJcp3E52AC5fGorOG3CWshPJw6UInPFuAEIxDGp7L4BDA+PrE2UpbV/NW/YMc
	 REkK+wfv/OeibfaaQgxIpE9ZrZq1T9+NIo/agLCn4L1fuxJjrrnNI7/VWMpqbHvVZA
	 sKYyZgMhu4ddLNdj8dsopz74YoKTNdFls7Ij5M8JskbSlTwyZmVq5IEn3JyOyUFfe+
	 8eDqu2n+0m+ootjO7wNb2qy6scoZOYxaJpw2qRlyWYCrtIWDLUarU9EexnA11k/iIw
	 SdOlHUZOA89MQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 06/12] KVM: s390: Do not set special large pages
 dirty
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260624111928.144283-7-imbrenda@linux.ibm.com>
References: <20260624111928.144283-1-imbrenda@linux.ibm.com>
 <20260624111928.144283-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 11:37:16 +0000
Message-Id: <20260624113717.3CC951F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21228-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:agordeev@linux.ibm.com,m:kvm@vger.kernel.org,m:hca@linux.ibm.com,m:linux-s390@vger.kernel.org,m:gor@linux.ibm.com,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 08AB06BDB38

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing validation for special pages in KVM GMAP unmap and des=
troy paths leads to host kernel crash on invalid folio pointer dereference.
- [Critical] Missing check for a valid `struct page` before folio conversio=
n during PV guest secure page creation causes host crash.
--

commit 5f6958e6ac1a501221bda61b5fd8d27af20f157d
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Do not set special large pages dirty

Special pages / folios should not be set dirty. This also applies to
large pages.

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
>  		new.s.fc1.d =3D 0;
>  		new.h.p =3D 1;

[Severity: Critical]
This isn't a bug introduced by this patch, but since you are fixing the
special page check here, do we need similar checks in other places?

For instance, in _gmap_unmap_pte(), does this code safely handle special=20
pages when calling pfn_folio() on the PTE's PFN?

arch/s390/kvm/gmap.c:_gmap_unmap_pte() {
    ...
	if (ptep->s.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->flags))
		folio =3D pfn_folio(ptep->h.pfra);
    ...
}

Similarly, in _gmap_unmap_crste(), does this code need a check for=20
!old.s.fc1.s before calling phys_to_folio() on a large page origin?

arch/s390/kvm/gmap.c:_gmap_unmap_crste() {
    ...
	if (old.s.fc1.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->flags=
))
		folio =3D phys_to_folio(crste_origin_large(old));
    ...
}

And in _destroy_pages_pte(), does it need a check for !ptep->s.s to avoid=20
an invalid struct page dereference?

arch/s390/kvm/gmap.c:_destroy_pages_pte() {
    ...
	__kvm_s390_pv_destroy_page(phys_to_page(pte_origin(*ptep)));
    ...
}

Also in _destroy_pages_crste(), should there be a check for !crstep->s.fc1.s
before calling phys_to_page()?

arch/s390/kvm/gmap.c:_destroy_pages_crste() {
    ...
	for ( ; cur < end; cur +=3D PAGE_SIZE)
		__kvm_s390_pv_destroy_page(phys_to_page(cur));
    ...
}

Can unprivileged userspace trigger a host kernel crash by mapping a memory
region backed by special PFNs without struct pages, converting it to a
protected VM, and then tearing it down or unmapping it?

[Severity: Critical]
This is also a pre-existing issue, but does _kvm_s390_pv_make_secure()=20
need a check for a valid struct page before converting the folio and=20
attempting to acquire its lock?

arch/s390/kvm/pv.c:_kvm_s390_pv_make_secure() {
    ...
	folio =3D pfn_folio(f->pfn);
    ...
	if (folio_trylock(folio)) {
    ...
}

Could unprivileged userspace map PFNMAP memory without a backing struct=20
page into a PV guest and cause a host crash when this path is triggered
during guest memory fault?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624111928.1442=
83-1-imbrenda@linux.ibm.com?part=3D6

