Return-Path: <linux-s390+bounces-20883-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q3/BNbJJMGqoQwUAu9opvQ
	(envelope-from <linux-s390+bounces-20883-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 20:51:30 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39358689508
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 20:51:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ee4DIQ91;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20883-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20883-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C887C3094B04
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 18:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775A33ACA7E;
	Mon, 15 Jun 2026 18:50:51 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C163AC0C2;
	Mon, 15 Jun 2026 18:50:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549451; cv=none; b=nD1G8BRTeascawIM/pvRTVj2FidcXDXZ48/iIHYVt+xkHjmS4EpOIU4snRxbN8/uVl9g8Qqvzb69ByHuLZaieqpsGeu4d1apxlloEgpq7MP9VquWjbasX0CCmWvu30gnSy2jdON6zgXdT/K2bJwzbGfSUhMbq6XYwW4PAvtdPbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549451; c=relaxed/simple;
	bh=ECRBd0yB/AOyNZ+Be3sTENwJlqWC/Y9GJqF0SiLvA8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UarIogDE1Qj3KLxr75gpsblnzM03cEpL7v68s4iA6ujcT/1ECl9N23uP7rVoAn/4w4spekCIeXbG4mhLG0ph/B1S8+kqxdq2dIHdN5tUytHuBWg1ZQzv72m9PIba1rvt0KvkrUG2SdwDHVKRLkdQVmF7W/bkipj1EVNlJNhPOrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ee4DIQ91; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B161F000E9;
	Mon, 15 Jun 2026 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781549450;
	bh=jvRhRgJ4Eb8IELZRVbYsiQBNA9aMvBn4mITBhcx4cxw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ee4DIQ91PkLWm0TDiYOPx4FEdBp5/6Ia0sffiM+HK5/Rr1P/RU5wofv28EaK4eOSM
	 PawVw4MHP47bVc8Ca+MGKxWj74tS4BThp2g6USfvZs2U7TkeRV3965g05rCNj3I9S9
	 xVlFDpKSL8hLzU7SehwJ/WQHjp2nsjxmCK9+er4z8aSNY0gouIsnsD1WDAD2PM7A8I
	 gxv2coUtj7cAEGeIB8myCq9DCg7qxqx/jmjhx6ef8H/2V+GttVSYyl6u6Eudnb36mz
	 fPEQ5X5FW9z8PiBOIqDP+iLx5O5deAsU7EmGWrugdDutvIwr12CMjDsKgmbuft1xgQ
	 bXxZXIyOoCW4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 1/4] PCI: Allow per function PCI slots to fix slot
 reset on s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-pci@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260615183524.2880-2-alifm@linux.ibm.com>
References: <20260615183524.2880-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 18:50:49 +0000
Message-Id: <20260615185049.B1B161F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-20883-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alifm@linux.ibm.com,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,m:linux-pci@vger.kernel.org,m:hca@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39358689508

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Global enforcement of per_func_slot on S390 breaks standard generi=
c PCI hotplug (e.g., pciehp) slot matching.

Pre-existing issues:
- [High] Pre-existing Race Conditions and Use-After-Free in PCI slot lifecy=
cle and dev->slot management.
--

commit 39801ae4eb8c8847b623fb1ef810dd413b455ecc
Author: Farhan Ali <alifm@linux.ibm.com>
Subject: PCI: Allow per function PCI slots to fix slot reset on s390

This commit adds a per_func_slot flag to struct pci_slot to support
resetting individual PCI functions on s390 systems. It modifies the slot
matching and reset logic to account for this new flag, and adjusts the
slot number type to handle placeholder values.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc000901..d0c9f0166af5c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4865,8 +4865,9 @@ static int pci_reset_hotplug_slot(struct hotplug_sl=
ot *hotplug, bool probe)
> =20
>  static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>  {
> -	if (dev->multifunction || dev->subordinate || !dev->slot ||
> -	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
> +	if (dev->subordinate || !dev->slot ||
> +	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
> +	    (dev->multifunction && !dev->slot->per_func_slot))

[Severity: High]
This is a pre-existing issue, but does reading dev->slot->per_func_slot here
expose a use-after-free vulnerability?

In pci_dev_reset_slot_function(), dev->slot is dereferenced locklessly with=
out
holding pci_bus_sem. If a concurrent hotplug removal triggers
pci_slot_release(), the slot could be freed.

Furthermore, pci_slot_release() iterates over bus->devices to clear dev->sl=
ot,
but this can miss devices currently undergoing probing that haven't been ad=
ded
to the bus list yet, leaving a dangling pointer.

>  		return -ENOTTY;
> =20
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);

[ ... ]

> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 6d5cd37bfb1e7..894d6213ed306 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -72,6 +72,23 @@ static ssize_t cur_speed_read_file(struct pci_slot *sl=
ot, char *buf)
>  	return bus_speed_read(slot->bus->cur_bus_speed, buf);
>  }
> =20
> +static bool pci_dev_matches_slot(struct pci_dev *dev, struct pci_slot *s=
lot)
> +{
> +	if (slot->per_func_slot)
> +		return dev->devfn =3D=3D slot->number;
> +

[Severity: High]
Does this logic break generic hotplug drivers like pciehp on s390 systems?

Because pci_slot_enabled_per_func() unconditionally returns true for
CONFIG_S390, per_func_slot is enabled globally. When generic hotplug drivers
create slots using PCI_SLOT_ALL_DEVICES (0xfeff), slot->number is 0xfeff.

If slot->per_func_slot is true, this evaluates dev->devfn =3D=3D 0xfeff bef=
ore
checking for the PCI_SLOT_ALL_DEVICES wildcard. Since devfn is an 8-bit val=
ue,
this always evaluates to false, preventing downstream devices from matching
their hotplug slots.

> +	return slot->number =3D=3D PCI_SLOT_ALL_DEVICES ||
> +		PCI_SLOT(dev->devfn) =3D=3D slot->number;
> +}
> +
> +static bool pci_slot_enabled_per_func(void)
> +{
> +	if (IS_ENABLED(CONFIG_S390))
> +		return true;
> +
> +	return false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615183524.2880=
-1-alifm@linux.ibm.com?part=3D1

