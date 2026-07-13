Return-Path: <linux-s390+bounces-22170-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tbu+L9AjVWqrkQAAu9opvQ
	(envelope-from <linux-s390+bounces-22170-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 19:43:44 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3340074E1E4
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 19:43:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="C16/SslN";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22170-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-22170-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BABAD30048C2
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 17:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D88A34B43F;
	Mon, 13 Jul 2026 17:43:26 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E544333A005;
	Mon, 13 Jul 2026 17:43:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964606; cv=none; b=ccl7TsHBwHT/PYwzgl8ZQwfSKimiY7llxFWshIFqfottZhioJ7XdbvqhJiIoq6stDts+Nat0qXKM85gd7vCaLiCj9CVxl3bMNMJNvYj/wUwtsl2VibpQS8NzCSdfrfFLnwhPJhDAbzjeSyQ1DE3JskcqA0Wmq8EpSVR6aNxRgMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964606; c=relaxed/simple;
	bh=b6qSWw3PRoDgqfxecCiTmopGGxKBItqsL5JAktOhe5s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u2DwHEPXsmKP2Ctj92WH7UJF40O4DjAglZ8Ay2KaPZGmLEn3c4nqNHp1V1LRPDz3CBfxBOlq13O6PHaLORgYJcv7ZIWZdZryOClepll8/l+zMhi4EyG7r5DGHEnzUX8fXSys1FikvbYZZh+lUPYFsKeu3iTg5HooZyGqCi6wrX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C16/SslN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BCB1F000E9;
	Mon, 13 Jul 2026 17:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783964604;
	bh=T8GnWJtXAV1F34VmsEgqk8B90vb+TbG649Ii0HwT41A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C16/SslNYPgk56MxTjeQcqElgYyKVT+OvLRDBrYvWIKYoqn6U/p/QCCr5X2hILNIf
	 mgFrFn5eZJuGxfD4IYfktBjBX66eSSvAi/hHmdaeo+ZiTJNyf1Ci/Xtok+seZ8m1m1
	 +XIO+rVIgNiCM5SrjcGmvo5I7hG02cs42XRb6/136Qvg29rDrCo61UB8j1LRYpyFAI
	 PH2INONMv0aao00Q3wikWG2+h2IH9aaF7QyeBf/GM15j87/JdFwGBiFB2CzJb0TeNi
	 N+NfjhXNBZxVUDl65yyQ2LMusfK7XCXHE03pw+K30Y/dtaRQ0713atbhSRkxwRouBQ
	 qlLj2YI6sp6Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/5] KVM: s390: pci: Fix resource leak on IRQ
 registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260713172600.1284-5-alifm@linux.ibm.com>
References: <20260713172600.1284-1-alifm@linux.ibm.com>
 <20260713172600.1284-5-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:43:23 +0000
Message-Id: <20260713174324.24BCB1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22170-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alifm@linux.ibm.com,m:gor@linux.ibm.com,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3340074E1E4

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The error path for `kvm_zpci_set_airq()` failure unregisters the w=
rong Interruption Subclass (ISC), leading to a reference count leak for the=
 guest ISC and potential state corruption for the host ISC.

Pre-existing issues:
- [High] `kvm_s390_pci_aif_enable` lacks a check to prevent multiple AEN re=
gistrations for the same device, allowing a malicious userspace to trigger =
repeated allocations that leak pinned pages and `airq_iv` structures.
--

--- Patch [4]: [PATCH v1 4/5] KVM: s390: pci: Fix resource leak on IRQ regi=
stration failure ---
commit 3065114852ad54412b30b74a97b10b479bcd1a82
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Fix resource leak on IRQ registration failure

Currently if kvm_zpci_set_airq() fails, kvm_s390_pci_aif_enable() returns
the error code but doesn't do any resource cleanup thus leaking resources.
Fix this by cleaning up all the resources such as the GAITE, AIBV, AISB and
unpinning any pinned pages.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index b3ffb8c255107..9a16a2eac65b8 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -334,11 +334,29 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev =
*zdev, struct zpci_fib *fib,
>  	/* Save some guest fib values in the host for later use */
>  	zdev->kzdev->fib.fmt0.isc =3D fib->fmt0.isc;
>  	zdev->kzdev->fib.fmt0.aibv =3D fib->fmt0.aibv;
> -	mutex_unlock(&aift->aift_lock);

[Severity: High]
This is a pre-existing issue, but does kvm_s390_pci_aif_enable() lack a
check to prevent multiple AEN registrations for the same device?

If userspace repeatedly invokes the KVM_S390_ZPCIOP_REG_AEN ioctl on the
same device, could it blindly allocate new structures and overwrite tracking
fields like kzdev->aibv_pages and zdev->aibv?

kvm_s390_pci_aif_enable() {
    ...
    npinned =3D pin_user_pages_fast(hva, npages, FOLL_WRITE | FOLL_LONGTERM,
                                  kzdev->aibv_pages);
    ...
    zdev->aibv =3D airq_iv_create(msi_vecs, AIRQ_IV_DATA |
                                AIRQ_IV_BITLOCK |
                                AIRQ_IV_GUESTVEC,
                                phys_to_virt(fib->fmt0.aibv));
    ...
}

Would this irrevocably leak the previously pinned pages and airq_iv
structures?

> =20
>  	/* Issue the clp to setup the irq now */
>  	rc =3D kvm_zpci_set_airq(zdev);
> -	return rc;
> +	if (!rc) {
> +		mutex_unlock(&aift->aift_lock);
> +		return rc;
> +	}
> +
> +	/* Start cleanup */
> +	zdev->kzdev->fib.fmt0.isc =3D 0;
> +	zdev->kzdev->fib.fmt0.aibv =3D 0;

[Severity: High]
Will this error path unregister the wrong Interruption Subclass (ISC)?

Since fib->fmt0.isc is overwritten with gisc earlier in
kvm_s390_pci_aif_enable():

    fib->fmt0.isc =3D gisc;
    ...
    rc =3D kvm_zpci_set_airq(zdev);

If kvm_zpci_set_airq() fails, the cleanup path eventually reaches out:

out:
    kvm_s390_gisc_unregister(kvm, fib->fmt0.isc);

Could this cause the host to unregister the host NISC instead of the guest
ISC, potentially leaking the guest ISC's reference count and corrupting
state for the host ISC?

> +
> +	spin_lock_irq(&aift->gait_lock);
> +	gaite->count--;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713172600.1284=
-1-alifm@linux.ibm.com?part=3D4

