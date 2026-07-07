Return-Path: <linux-s390+bounces-21699-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kj5UMNvETGrEpQEAu9opvQ
	(envelope-from <linux-s390+bounces-21699-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 07 Jul 2026 11:20:27 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0B7719AA8
	for <lists+linux-s390@lfdr.de>; Tue, 07 Jul 2026 11:20:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eS7v7uwP;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21699-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21699-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 057C1305288A
	for <lists+linux-s390@lfdr.de>; Tue,  7 Jul 2026 09:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1BB38F934;
	Tue,  7 Jul 2026 09:09:19 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3554D330668;
	Tue,  7 Jul 2026 09:09:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415359; cv=none; b=QzBxeTukR1jMy4hdT6z44Dw9hr6JC/QM+emqRSyf1idr4X1i4uwYTKdFeJj4OtWE+1+tVzMLLpAdJjEcLBXMq+DUhr3rrmDAfRDL79i59R2TgWvKnB/UwEsSOxzI1F/8CjIPiEUWc4Mf45AhadCGQKt+9DtB8V4qwBz/C6YRJiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415359; c=relaxed/simple;
	bh=+Gn8P8V2vgpHp2j0JeIxfZ9ORINzyrOBYqoH9ycZDUY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FqUCK3bRYYhHLbxbk+UPJOxAbRJ/H+F0Bn3HpX/yYVyicMm8RZx7u7nsLbc4GyQzGno6VHSprnbQ51Xy1Fxbe1VrSW4cDC1shw8e4Ig1g1leTz/EOLElaETPUVaXinnUqDeWoMyPrKj5NKNGEVBwB/CuKTl77iKgoYa3wkgMkp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eS7v7uwP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6207F1F000E9;
	Tue,  7 Jul 2026 09:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783415357;
	bh=WP+vdG6RWNbVTPqqD+3QQr2E3sRsOThLFKwCXJ3Ub5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eS7v7uwPw+nMk6koBFVCsEtW9GcJmcpv8qHE0NtWzo9oetvEpqyPeSa1c36ryv0rW
	 01ZijiPYwMFVsXjeLC5HUvrArkqtzi7XhKKDugXxFUAaK1wwY8TfvzYVVnhCOGoY5V
	 4PrQYclkfKEludqUCGrntnIxxvjHOg4XU69v28xKHIepR0ykW2zuir95iXST1aPVWv
	 ipSwh6cJwuNLFT/EEJ/oPdTAB1mtCJ6OCUUNo2k89KW6rVFln+11tECipNFq2AILXf
	 Z+hpl0iYanf+/Va5IPUwisK4btKZrLjB/NXKlfXmqFNUosd6bSW5d7J9aP9rWri/Z5
	 H7kBBN3PgPuJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/15] s390/vfio-ap: Data structures for facilitating
 vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260707090226.3206695-3-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
 <20260707090226.3206695-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:09:16 +0000
Message-Id: <20260707090917.6207F1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21699-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akrowiak@linux.ibm.com,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:kvm@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 1C0B7719AA8

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Kernel-doc comments for the new migration data structures contain m=
ismatched and missing fields.
- [Low] Use of the architecture-dependent type `size_t` in a struct intende=
d for a migration data payload.
--

--- Patch [2]: [PATCH v4 02/15] s390/vfio-ap: Data structures for facilitat=
ing vfio device migration ---
commit c51eed4d1a56608445d8a10292fff2170e3cf604
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Data structures for facilitating vfio device migration

Creates the data structures used to facilitate state transitions during
vfio device migration.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> new file mode 100644
> index 0000000000000..239168c4b7fff
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
[ ... ]
> +/**
> + * vfio_ap_migration_data - the data needed to migrate a guest with pass=
-through
> + *			    access to AP devices
> + *
> + * @mig_state:		the current migration state
> + * @resuming_migf:	the object used to resume the target guest
> + * @saving_migf:	the object used to save the state of the source guest
> + */
> +struct vfio_ap_migration_data {
> +	enum vfio_device_mig_state	mig_state;
> +
> +	struct {
> +		struct file *filp;
> +		struct vfio_ap_config	*ap_config;
> +		size_t			config_sz;
> +	} resuming_mig_state;
> +
> +	struct file			*stop_copy_mig_file;
> +};

[Severity: Low]
This isn't a bug, but the kernel-doc block documents fields (@resuming_migf
and @saving_migf) that do not match the actual struct members
(resuming_mig_state and stop_copy_mig_file). Should the documentation be
updated to reflect the actual member names?

[ ... ]
> +/**
> + * vfio_ap_config - the guest's AP configuration
> + *
> + * @num_queues:	the number of queues passed through to the guest
> + * @reserved: padding to ensure proper alignment of qinfo array
> + * @qinfo:	an array of vfio_ap_queue_info objects, each specifying the
> + *		queue information for a queue passed through to the guest
> + */
> +struct vfio_ap_config {
> +	u32				num_queues;
> +	u8				reserved[4];
> +	size_t				config_sz;

[Severity: Low]
This isn't a bug, but the kernel-doc block above is missing documentation
for the config_sz member.

Also, since this struct is intended for a migration data payload, does the =
use
of size_t present an issue for serialization? While s390x is strictly 64-bi=
t,
using an architecture-dependent type in a migration stream is generally an
anti-pattern. Would a fixed-width integer type like u64 be more appropriate
here to ensure consistent structure size?

> +	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707090226.3206=
695-1-akrowiak@linux.ibm.com?part=3D2

