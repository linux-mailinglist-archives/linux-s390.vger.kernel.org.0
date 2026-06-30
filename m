Return-Path: <linux-s390+bounces-21381-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zF5wEGj5Q2oBmgoAu9opvQ
	(envelope-from <linux-s390+bounces-21381-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 19:14:16 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBD26E6CD2
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 19:14:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RDuMOsEI;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21381-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21381-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2317130D78A6
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 17:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40893DB313;
	Tue, 30 Jun 2026 17:10:14 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DC93DB310;
	Tue, 30 Jun 2026 17:10:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839414; cv=none; b=E1cQk0xcj0Zo76ExA8yUy/v1Pf171sAgXdpXN8JOIUejkEw508y1DnpGHeF9oWwBGTMtquNcuc0GCwhSua2liVa2tJy36XbxwFV+5nXseIWbcBOZEINqwHl96htGtR/8sFhTWq0mueasXPAcPm6tmG7fNUqGvy+luYaLDu/pKS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839414; c=relaxed/simple;
	bh=3bEozP8+7JBElQTv9WITBwC81XJV1smgoNFCjC5r0Y4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pdUzfmajgwsBmto+Yu4fWPjY/HG67bKjWslQ8V8Xlfi3s55H0zzBb1kcwrvctjrpdW8+LFvNoFFJ658c0IVIhYrMEPuMINGdFU/tcq/zrgbPwRlR3uWb0FLE1+ds3dS7qrYBUUOOYzbB2tsqPTAzd9OrvoJWM7idpn76aCRsams=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDuMOsEI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EE61F000E9;
	Tue, 30 Jun 2026 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782839413;
	bh=64OYwcSAP/HQap74HVPzJcQkc3Mrw5BLVGfdOl0+/dU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RDuMOsEIdbZQccL++qr4tfQrw7B4VVHFxEkXEpaYxvdt3QXnwQIVV83iXr06cfQvr
	 VzSK8RQRo0cwU2tzwhfjvplzy6PUIlKDrantQdJY4p7fbqzfHXEo3vSckclCDlsPIe
	 5Wntf4z7GG6BLSK53UZGcjssyxCfzSpemw9liQCriPVp3M+63D5INN9fbzzgMMCRb6
	 8IhgH6EvYuJPfguXqSpgrVfr78X1ry98YQ+zMIQtDKowFPVlwpC7GEGlF1Y9oXgfSK
	 VcleUTMclL4xY+F5l/YGI5cR9PdU8oOQrReHt6Qf4qO0n9ci+dvYJHW2jtX/KPGTWA
	 OBbHnUyOVCv4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 1/4] PCI: Allow per function PCI slots to fix slot
 reset on s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260630164807.643-2-alifm@linux.ibm.com>
References: <20260630164807.643-1-alifm@linux.ibm.com>
 <20260630164807.643-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 17:10:12 +0000
Message-Id: <20260630171013.13EE61F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21381-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alifm@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 8BBD26E6CD2

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unconditional enablement of `per_func_slot` on S390 breaks standar=
d PCI hotplug (e.g., pciehp, shpchp) slot matching and resets.

Pre-existing issues:
- [High] Lockless access to `dev->slot` in `pci_dev_reset_slot_function` ca=
n lead to Use-After-Free if a hotplug driver is concurrently unbound.
--

commit e76ff052218a061a873ef34162524387e5e10c78
Author: Farhan Ali <alifm@linux.ibm.com>
Subject: PCI: Allow per function PCI slots to fix slot reset on s390

This commit addresses an issue on s390 systems where the hotplug driver
creates slots for individual PCI functions. It introduces a per_func_slot
flag to struct pci_slot to allow per-function PCI slots and changes the
slot number to u16 to accommodate special placeholder and all-devices
values.

Fixes: 44510d6fa0c0 ("s390/pci: Handling multifunctions")
Cc: stable@vger.kernel.org

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee615..350bae907ebf8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4897,8 +4897,9 @@ static int pci_reset_hotplug_slot(struct hotplug_sl=
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
This is a pre-existing issue, but does this lockless access to dev->slot ri=
sk
a use-after-free if a hotplug driver is concurrently unbound?

The patch expands this access by adding the check for
!dev->slot->per_func_slot. If a concurrent sysfs operation unbinds the
pciehp service driver from the parent bridge, it takes the device lock on t=
he
bridge and executes:

pci_hp_deregister() -> pci_destroy_slot()

This invokes pci_slot_release(), clearing dev->slot =3D NULL under
down_read(&pci_bus_sem) and freeing the slot memory. Since
pci_dev_reset_slot_function() does not hold pci_bus_sem or pci_slot_mutex,
could it check !dev->slot, get preempted, and then dereference freed memory
upon resuming to evaluate dev->slot->per_func_slot?

>  		return -ENOTTY;
> =20
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);

[ ... ]

> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 6d5cd37bfb1e7..894d6213ed306 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
[ ... ]
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

[Severity: High]
Does enabling per_func_slot unconditionally on S390 break standard PCI
hotplug slot matching?

When standard PCI hotplug drivers (like pciehp) create a slot on an S390
system, pci_slot_enabled_per_func() globally forces per_func_slot to 1.

This preempts the wildcard checking logic in pci_dev_matches_slot().
For drivers creating bus-wide slots using PCI_SLOT_ALL_DEVICES (0xfeff),
this rigid comparison forces dev->devfn =3D=3D 0xfeff, which will always fa=
il
since devfn is an 8-bit value.

Additionally, for drivers passing a standard slot number N,
pci_dev_matches_slot() now compares it directly against devfn instead of
calculating PCI_SLOT(dev->devfn). A slot number of 1 will match Device 0,
Function 1 instead of Device 1, Functions 0-7.

Should per_func_slot be an explicitly opted-in property provided by the
specific hotplug driver, rather than an architecture-wide global override?

> +
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
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630164807.643-=
1-alifm@linux.ibm.com?part=3D1

