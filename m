Return-Path: <linux-s390+bounces-22109-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mMRHGNinVGqkowMAu9opvQ
	(envelope-from <linux-s390+bounces-22109-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 10:54:48 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70657748FC6
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 10:54:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=diujnaTQ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22109-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22109-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 289BB300E91F
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 08:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCF63BA24E;
	Mon, 13 Jul 2026 08:48:46 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C983B9928;
	Mon, 13 Jul 2026 08:48:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932523; cv=none; b=SJGVHsm9RWiNSeIh+gsxGu7SS/xVmAGXstHjpdDFf5pex/DEY0RXhEG+SDMCnugOMx6xEZtQ5ZqkAUcaAanDiJZpunzWan6u+2WXYeAkbz4sD1IkJ6A0aZ95zwJNKKXACwSmzBe1Yiium+ChdtozW4ncQppOMIe9sy2yN1oLhT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932523; c=relaxed/simple;
	bh=+XevlmmT+JfZOppaltCqI+ikm27nk8xd7kxyCWPkBr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BctmegNM2dU0M/iCRn1LMtDVcG7f4oxuws899w3M9daqUtg8axF/9q8KgiwrerKCVkrzyFRZ2HMEFA+ciMRqqZ1KjofIlCmAuYEYRBeikRNOgf0LxjWhSZ/HDlMyjogfT9z0UHAAz3e/QtpfGmdNvrZ2p5MP0PFFaCQUawCyMH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diujnaTQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56DE1F000E9;
	Mon, 13 Jul 2026 08:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783932510;
	bh=9wJ61ak+4EO+2Nyfcj2vpQF/9/vnecFJz+r7x0oHFjs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=diujnaTQwUmaQvkRbnHNw+gFVe6tQYZ4gjwgRdjS5BM13SGZd8mThxbkVkjNKZ0tZ
	 fotvPIKiy3bfvL3RvCS831Fzukp3bxFCX8iBu8vRYc76sDrLc3yu49hKQgbqa1Fp33
	 MiGbiNzY/Z4CtULgpmFrFwglqbhrQD+/RhDMRd+J+2N4VttJvOx2aUS9hmXEbw9Eaz
	 3zczjpDw8Qws0Psy28YOrnfVEjWYD8fiNIuzJG/dvzGt85pRfZsHzoMbvQSqyfo9xh
	 BogcbeHfVgmbgzYz2t01IuaxevQDbW44SqMxH5FHZqno8HmYF31w2QUzo/IOFsfawt
	 AajHV7MkaEbqQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 1/5] KVM: s390: pci: Fix GISC refcount leak on AIF
 enable failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@de.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260713083007.65863-2-borntraeger@de.ibm.com>
References: <20260713083007.65863-1-borntraeger@de.ibm.com>
 <20260713083007.65863-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 08:48:29 +0000
Message-Id: <20260713084829.A56DE1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-22109-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:borntraeger@de.ibm.com,m:gor@linux.ibm.com,m:kvm@vger.kernel.org,m:agordeev@linux.ibm.com,m:hca@linux.ibm.com,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 70657748FC6

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Lack of guest-provided AIBV/AISB address boundary validation a=
llows arbitrary host memory corruption.
- [High] Missing cleanup on KVM_S390_ZPCIOP_REG_AEN overwrite and failure p=
aths causes resource leaks and silent failures.
- [High] Missing NULL pointer check for airq_iv_create() return value cause=
s a host kernel panic.
- [High] Reference count leak of user_struct and unsafe memory un-accountin=
g context corrupts memory quotas.
--

--- Patch [1]: [GIT PULL 1/5] KVM: s390: pci: Fix GISC refcount leak on AIF=
 enable failure ---
commit 3845d6e353bdaf75c36ec128cd79d6dddde46a80
Author: Haoxiang Li <haoxiang_li2024@163.com>

KVM: s390: pci: Fix GISC refcount leak on AIF enable failure
   =20
kvm_s390_gisc_register() registers the guest ISC before pinning
the guest interrupt forwarding pages and allocating the AISB bit.
If any of the later setup steps fails, the function unwinds the
pinned pages and other local state, but does not unregister the
GISC reference. Add the missing kvm_s390_gisc_unregister() to the
error unwind path.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 5b075c38998e3..686113be05309 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -328,6 +328,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *z=
dev, struct zpci_fib *fib,
>  unpin1:
>  	unpin_user_page(aibv_page);
>  out:
> +	kvm_s390_gisc_unregister(kvm, fib->fmt0.isc);

[Severity: High]
This isn't a bug introduced by this patch, but does this function properly
handle failure paths and repeated calls?

If a guest repeatedly issues the KVM_S390_ZPCIOP_REG_AEN ioctl, is there a
check to prevent blindly overwriting existing allocations?

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
    zdev->aibv =3D airq_iv_create(...);
    ...
}

Also, if airq_iv_alloc_bit() fails, it appears we jump to unlock without
setting a negative rc or calling unaccount_mem(pcount):

    bit =3D airq_iv_alloc_bit(aift->sbv);
    if (bit =3D=3D -1UL)
        goto unlock;

Additionally, if kvm_zpci_set_airq() fails, it looks like we return the err=
or
without rolling back the pinned pages, adapter event bits, or memory
accounting:

    rc =3D kvm_zpci_set_airq(zdev);
    return rc;

Could these paths lead to resource leaks or silent failures if the hardware
rejects the registration?

[Severity: High]
This is a pre-existing issue, but is it possible for airq_iv_create() to
return NULL here?

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
    zdev->aibv =3D airq_iv_create(msi_vecs, AIRQ_IV_DATA |
                                AIRQ_IV_BITLOCK |
                                AIRQ_IV_GUESTVEC,
                                phys_to_virt(fib->fmt0.aibv));
    ...
}

If the host is under memory pressure and airq_iv_create() fails, we
immediately assign NULL to zdev->aibv. Then in kvm_zpci_set_airq(), it looks
like this is unconditionally dereferenced:

arch/s390/kvm/pci.c:kvm_zpci_set_airq() {
    ...
    fib.fmt0.noi =3D airq_iv_end(zdev->aibv);
    ...
}

Can this lead to a host kernel panic if guest userspace triggers the
registration ioctl?

[Severity: Critical]
This is a pre-existing issue, but are the bounds of the guest-provided
addresses adequately validated here?

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
    npages =3D pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM, page=
s);
    ...
    gaddr =3D page_to_phys(aibv_page) + (fib->fmt0.aibv & ~PAGE_MASK);
    fib->fmt0.aibv =3D gaddr;
    ...
}

The code pins exactly 1 page. However, could msi_vecs require more space th=
an
what remains in the page from the provided offset?=20

If a guest provides an unaligned physical address near the end of a page, a=
nd
the interrupt vectors require more space (up to 256 bytes), might the
hardware's DMA write cross the page boundary into unpinned host physical
memory?

[Severity: High]
This isn't a bug introduced by this patch, but how do the memory accounting
functions handle the user_struct reference count and quotas?

arch/s390/kvm/pci.c:account_mem() {
    ...
    struct user_struct *user =3D get_uid(current_user());
    ...
}

It seems we increment the user_struct refcount with get_uid() but never free
it, nor do we store the user pointer for accurate future teardown.=20

Then in unaccount_mem():

arch/s390/kvm/pci.c:unaccount_mem() {
    ...
    struct user_struct *user =3D get_uid(current_user());

    if (user)
        atomic_long_sub(nr_pages, &user->locked_vm);
    ...
}

Does this leak a user_struct reference on each call? Furthermore, if teardo=
wn
happens in a different context (such as a kernel thread during hot-unplug),
could it subtract quotas from an unrelated process instead of the process t=
hat
originally registered the AEN?

>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713083007.6586=
3-2-borntraeger@de.ibm.com?part=3D1

