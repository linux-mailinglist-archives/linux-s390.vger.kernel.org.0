Return-Path: <linux-s390+bounces-21066-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2je7Da9qNWosvwYAu9opvQ
	(envelope-from <linux-s390+bounces-21066-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 18:13:35 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B92256A6FBF
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 18:13:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KcHyKdja;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21066-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21066-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AE703008C12
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 16:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3059A3B47F5;
	Fri, 19 Jun 2026 16:13:32 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123C528506C;
	Fri, 19 Jun 2026 16:13:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885612; cv=none; b=OBbG5oCCppqc79l9GZBednIuAAoWM1KgDLH0Du/vNK6dtNKTQ5XZ8f3zrHei/n56GiKCfs1n7q/XmjQRtbMJpPnPS/ByF7jJP7oFL5B/rSvqM3fkPoI8FG45EueZptfourhWXg2sY4tBYHeDXEW7T2IXJLy3pLhpwvcT15Uo/uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885612; c=relaxed/simple;
	bh=cOgZu3rrqVtChnX3vD9dCExO8/2SnJk1uqq6qfTf1QA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YWserY/pN4d5vJyP+2R+FYSEcM0u6zIUjx2V6CCalaWKzApd0AApKKQnGZVNNdXEG02/DtmMJkcKkrDpjzwFry5qEugRg2jtGyRAhLUCm7nIsd8ir5p/J5BXsnVIu2Siz7T7LWwYRRDHHlUJwiqJ0xXbP3wSWUR76DFo4x2xAAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcHyKdja; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663051F000E9;
	Fri, 19 Jun 2026 16:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781885610;
	bh=fcM6SB8vHLGttAk6ZR3dHrbm2oeC4Sbrx6m2kXNRZqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KcHyKdjanYsTrDe0n+gd2Bc4y5yUREwXYYIARkVqI+gtD9VqRgk6DL40Dy1L6G2US
	 mVzGtvdzes5FqaDX3ZgH1Fq6sH1K7iRmj61i/uRTkVWsywL/X0g03V71HIcmQueoFb
	 UNiq3Q6jzRQiLBOEeeYkOkdGDJ8RkgsiMIOtqwDVS5J7oKbJJ8nklgr9xUipHsSleb
	 XolOW9Q2mxlKCHCao2g+nRPDAtFy3Yqwjxxeg2fu/WmA7MAkHaLNAseaN4B0BaBUji
	 B2xVLhgeKxK50DTzf0/eTFgHqQtJueIzXOZH9/omO1MomMVO9qv1TCifgswsEjKH8V
	 Ywh/1rQDjyZFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/7] KVM: s390: Do not set special large pages dirty
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260619155154.307572-4-imbrenda@linux.ibm.com>
References: <20260619155154.307572-1-imbrenda@linux.ibm.com>
 <20260619155154.307572-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 16:13:29 +0000
Message-Id: <20260619161330.663051F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21066-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,m:kvm@vger.kernel.org,m:hca@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B92256A6FBF

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing Special Page Validations in PV / Unmap Paths
- [Critical] Unsafe SSKE Execution on Special Pages
--

commit 2d60ecc18379805e67b3a6ad94ddb8516f4d4167
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Do not set special large pages dirty

This commit prevents setting special large pages dirty. It adds a missing
check in gmap_clear_young_crste() to ensure the large page is not a
special page before setting it dirty.

> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
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
This is a pre-existing issue, but I noticed there are other places where
special page validation seems to be missing in PV and unmap paths.

If a malicious userspace maps device memory (VM_PFNMAP) to a PV guest,
special shadow page table entries are created. When KVM unmaps these pages,
_gmap_unmap_crste() calls phys_to_folio() on the physical frame number:

arch/s390/kvm/gmap.c:_gmap_unmap_crste() {
    ...
    if (old.s.fc1.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->fl=
ags))
        folio =3D phys_to_folio(crste_origin_large(old));
    ...
}

Could this result in a garbage pointer if the entry is a special page,
leading to a host panic when passed to uv_convert_from_secure_folio()
which immediately calls folio_get()?

A similar pattern appears in _gmap_unmap_pte() without checking ptep->s.s:

arch/s390/kvm/gmap.c:_gmap_unmap_pte() {
    ...
    if (ptep->s.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->flag=
s))
        folio =3D pfn_folio(ptep->h.pfra);
    ...
}

And in _destroy_pages_crste():

arch/s390/kvm/gmap.c:_destroy_pages_crste() {
    ...
    for ( ; cur < end; cur +=3D PAGE_SIZE)
        __kvm_s390_pv_destroy_page(phys_to_page(cur));
    ...
}

As well as _destroy_pages_pte() and _kvm_s390_pv_make_secure() in
arch/s390/kvm/pv.c. Do these paths also need special bit checks to
prevent panics from malicious userspace or guests?


[Severity: Critical]
This is also a pre-existing issue, but does KVM_S390_RESET_SKEYS safely
handle special pages?

When userspace triggers the KVM_S390_RESET_SKEYS ioctl, dat_reset_skeys_pte=
()
and dat_reset_skeys_crste() walk the gmap and invoke page_set_storage_key()
without checking if the page is special. For example:

arch/s390/kvm/dat.c:dat_reset_skeys_pte() {
    ...
    if (ptep->s.pr)
        page_set_storage_key(pte_origin(*ptep), PAGE_DEFAULT_KEY, 1);
    ...
}

arch/s390/kvm/dat.c:dat_reset_skeys_crste() {
    ...
    for ( ; addr < end; addr +=3D PAGE_SIZE)
        page_set_storage_key(addr, PAGE_DEFAULT_KEY, 1);
    ...
}

If page_set_storage_key() executes the hardware sske instruction on a physi=
cal
address not backed by valid system RAM, could this cause an s390 Addressing
Exception and panic the host?

>  		new.s.fc1.d =3D 0;
>  		new.h.p =3D 1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619155154.3075=
72-1-imbrenda@linux.ibm.com?part=3D3

