Return-Path: <linux-s390+bounces-20812-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vyjZAnZQLGoRPQQAu9opvQ
	(envelope-from <linux-s390+bounces-20812-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 12 Jun 2026 20:31:18 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5803967BBB8
	for <lists+linux-s390@lfdr.de>; Fri, 12 Jun 2026 20:31:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=beXSFYkB;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20812-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20812-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35E95300A10D
	for <lists+linux-s390@lfdr.de>; Fri, 12 Jun 2026 18:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ECE395DBE;
	Fri, 12 Jun 2026 18:26:36 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181AD399031;
	Fri, 12 Jun 2026 18:26:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288796; cv=none; b=WFUkebxzjSJQTfP3h02o6iAmqgEMyIzec3yFgOzWJDeRSo0kQIY1Lbc1erl71IAwx9H97AOJf9qh+90CDQE8WCuLRP2BlGf2oECzJVBgMpgaeNhAC5EoPe1zHaM7y7gODEdgQhkhAcOcLy2b/aUrW1fnmnIghkdBwlGd0r3HZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288796; c=relaxed/simple;
	bh=DxFw9DzADdJwvw8erhmvQIon9AtoFno5XXrR0oQp6iY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cu0IfbRxOXpeBhBBn5i9jIYE5suWiyEdQRYGyGDtEyYMCNrfr2Ee+hF5+MGvlixmYKg0013NJ8rnIpT+bpRxUZAyNMggGR5nzbFeE9+PvC6ssahvYuWElZo6+yW2Ptfsdj/7VsZ/wDjWcM+5/TU2uGQN6KP6J1QpCTFww7oyhrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beXSFYkB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EE71F000E9;
	Fri, 12 Jun 2026 18:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781288793;
	bh=geVjcGeVFeXtkciELUdBMW5RuU1hD98qGXtlXcTJi8o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=beXSFYkBuW1o8Uze6ZsaFMF34jRWAnHDHIZxi5uzrwDC55Ky0V54cQFhjT01UWOEm
	 01NxHBQ/Q9sGe7gPDowY/tFf3h/8/A1G9MjHcWCDGnLQIEBI4Mm+ZWE8VzpLV4Lr/O
	 rqgF1S9RPytySEeLbziyMwWAKZxv5L6tbL/JcY0YGsSkQ4lXGvPAHGN5TFyRgBWwMy
	 j5TC9YaXvQgQ9g8hKsRGzHpoZOyx0zQm2b5Fl2+RtdjFbfrCnDcgvhEdV8beQyCxRw
	 8jc4IwRX0I5w8rb2Qk0SVAEZwbwn/mNfvmz/H9zqO+3Ed4jn/NW3eSoVyAdawz7xzX
	 Q84mPygoikGVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] s390/pci: Preserve FMB state in device
 re-enablement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260612181048.91548-3-oelghoul@linux.ibm.com>
References: <20260612181048.91548-3-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:26:31 +0000
Message-Id: <20260612182632.E4EE71F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20812-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,fib.gd:url,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:oelghoul@linux.ibm.com,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:hca@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5803967BBB8

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] zpci_fmb_reenable_device() reuses the existing FMB hardware buff=
er without zeroing it, exposing stale hardware counter values until the fir=
st periodic hardware update occurs.
--

commit a81b1b0a067d09df54d661ddbb8985e9220d9a88
Author: Omar Elghoul <oelghoul@linux.ibm.com>

s390/pci: Preserve FMB state in device re-enablement

This commit introduces zpci_fmb_reenable_device() to reuse the existing FMB
buffer during device re-enablement instead of allocating a new one. It also
refactors the FMB enablement and software counter clearing logic into shared
helpers.

> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 2910d4038d39c..21d3fccac7894 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c

[ ... ]

> +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
> +{
> +	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
> +	struct zpci_fib fib =3D {0};
> +	u8 cc, status;
> +	int rc;
> +
> +	lockdep_assert_held(&zdev->fmb_lock);
> +
> +	if (!zdev->fmb)
> +		return zpci_fmb_enable_device(zdev);
> +
> +	fib.gd =3D zdev->gisa;
> +	cc =3D zpci_mod_fc(req, &fib, &status); /* Disable function measurement=
 */
> +
> +	/* Unlike in zpci_fmb_disable_device(), cc =3D=3D 3 is not a valid stat=
e here
> +	 * because we are re-enabling function measurement for the same function
> +	 * handle.
> +	 */
> +	if (cc)
> +		return -EIO;
> +
> +	zpci_fmb_clear_iommu_ctrs(zdev);
> +

[Severity: Medium]
Does this code need to zero the reused zdev->fmb buffer before enabling it?

The commit message states that a program resetting an FMB should see all
counters start from zero. While zpci_fmb_clear_iommu_ctrs() clears the
software-maintained IOMMU counters, the hardware-maintained FMB buffer
(zdev->fmb) is reused here without being cleared.

Could this expose stale hardware counter values to userspace until the
first asynchronous hardware update occurs? The previous behavior in
zpci_fmb_enable_device() allocated a fresh, zero-initialized buffer via
kmem_cache_zalloc().

> +	rc =3D zpci_fmb_do_enable(zdev);
> +	if (rc) {
> +		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
> +		zdev->fmb =3D NULL;
> +	}
> +
> +	return rc;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612181048.9154=
8-1-oelghoul@linux.ibm.com?part=3D2

