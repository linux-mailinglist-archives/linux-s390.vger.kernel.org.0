Return-Path: <linux-s390+bounces-21110-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /HbQH/hwOWrYswcAu9opvQ
	(envelope-from <linux-s390+bounces-21110-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 19:29:28 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C70166B1790
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 19:29:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SMDfIBbx;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21110-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21110-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DAAA7300BD57
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 17:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A25340286;
	Mon, 22 Jun 2026 17:29:21 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E8E33F597;
	Mon, 22 Jun 2026 17:29:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149361; cv=none; b=VwEcARLZNN/Vdu08epJj4OgEAarvIkRnSKcmlLs8OYMAE1Qwrvs+vjIdkVtCbRIvqU62VjnedrCnXHOXCwf5bezHk16vMWFo0Si/e5MST7b/JKIugXgM+vHtFo4GAIDR7mw6EsDU5iSZYb365ST3I5NQky/cvFQ/yJ2Bhsm0m3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149361; c=relaxed/simple;
	bh=P8/xpr1iBFRLslqS+cPhcEu7b0DhY2Sgnw5AUoGtClU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aMd4c5QJEaOajadeHEoIzeJNA/ILmWF3N3dhTL/p6M/4IqeEdfh/7uJGRecveMG5GdL83IvrIDQ+TCfNWG4CkB2PvtB9w0oTUMHQ9l5z64GxCFgOJWBvM46+JbeQvuQwmlY/oden+8Wzjxttl0eQprM8+jf0I1ddP2c1WRrK7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMDfIBbx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B091F000E9;
	Mon, 22 Jun 2026 17:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782149360;
	bh=KhEQncDBKejb1FIrJj6yHPW+YT1G6LMz0c3Q/EZ5hmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SMDfIBbxgECkZ92+52210vPSd5/tFdIu+TQdOnp6LT5LNMH2+XHD5vW1myEK9nIHS
	 TtIW8Amk99ntutncVkTKmfqbJ/QsZzhBZdUxfccuxxUmghEAE9GB2PyUZQx/LLTmjM
	 4cNRfEi4nJxGua2Dt2u0PU/vJu11krQaPDDria/Q8Hdi18fPjXRsJKcfovLnx80WzO
	 jNrzP5qCHyeczE3ttjHTyhLhwl00huwGS1bT3IgjnCWa4JEL1BTOjZiWcrXrXL2sUf
	 dva4hxq0JBCqAkQY/uGYhSq1CC7oAhOl1CusY9Qo82TEJYLYuRDGMvj7WpmZjDxRvo
	 zsLbrceCsT31Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 2/4] PCI: Avoid saving config space state if
 inaccessible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260622171840.1618-3-alifm@linux.ibm.com>
References: <20260622171840.1618-1-alifm@linux.ibm.com>
 <20260622171840.1618-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 17:29:19 +0000
Message-Id: <20260622172920.50B091F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21110-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alifm@linux.ibm.com,m:hca@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-pci@vger.kernel.org,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C70166B1790

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `msg` parameter in `pci_dev_config_accessible` is declared as `=
char *` but is passed string literals.
--

commit 9495eb9f8f7d4d9784f1bb256b565bf60e0d2bb7
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Avoid saving config space state if inaccessible

This commit modifies the device reset process to check if the device's
configuration space is accessible before attempting to save its state. If
the space is inaccessible, it skips saving to prevent invalid values from
being written back during state restoration.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d0c9f0166af5c..e71b814153921 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> @@ -722,6 +722,27 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u=
16 vendor, u16 dvsec)
>  }
>  EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
> =20
> +static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)

[Severity: Low]
This isn't a bug, but could the msg parameter be declared as const char *
instead?

This function is passed string literals like "save state" when called from
pci_dev_save_and_disable(), and using a const pointer would ensure
const-correctness and help prevent potential compiler warnings.

> +{
> +	u32 val;
> +
> +	/*
> +	 * If device's config space is inaccessible it can return ~0 for
> +	 * any reads. Since VFs can also return ~0 for Device and Vendor ID
> +	 * check Command and Status registers. Note that this is racy
> +	 * because the device may become inaccessible partway through
> +	 * next access.
> +	 */
> +	pci_read_config_dword(dev, PCI_COMMAND, &val);
> +	if (PCI_POSSIBLE_ERROR(val)) {
> +		pci_warn(dev, "Device config space inaccessible; unable to %s\n",
> +				msg);
> +		return false;
> +	}
> +
> +	return true;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622171840.1618=
-1-alifm@linux.ibm.com?part=3D2

