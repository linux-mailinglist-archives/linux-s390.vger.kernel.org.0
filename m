Return-Path: <linux-s390+bounces-21445-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GdhhFZU9RWqz9AoAu9opvQ
	(envelope-from <linux-s390+bounces-21445-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 18:17:25 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA09C6EFA4D
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 18:17:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Wc0vRORD;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21445-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21445-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFDD6307BFE2
	for <lists+linux-s390@lfdr.de>; Wed,  1 Jul 2026 16:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F4C3451CF;
	Wed,  1 Jul 2026 16:16:29 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F296E23FC41;
	Wed,  1 Jul 2026 16:16:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922588; cv=none; b=dU6SB7/NfC7Mte6oeHtPtqNswq/EyZAB/LbTPn/7x4WXS8pF/hd8sHM46A3njRYBduSe8injtUMktJ6fF9swV+DNCruij7K2TxIsjh4sI6xi2HpgAwn/QJ3iUSSBGUf53aYoYyQfMUkdicYyiYOOJgj33htIiaD0MrNmlHXt4/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922588; c=relaxed/simple;
	bh=fNHQ0TSOcHuwr5FQ7QWdZBodpCcY9rc2C+N0JKV1CBQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qPujaXQD8BiO7lMYAt8Oox69ttFb8MZB0tr03o9dNop/dWtycxXTxvzhm4/WpsYvBqYGLSYMGgYIH+o59pESos66UfhPj4akm2ycm4LMBxyViDIoZiEgQ8SLT/8xJTFmSmmJR46pxMGQF9HbsUsb7Gdu8oBKrapNf0MfptWE2Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wc0vRORD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261AE1F000E9;
	Wed,  1 Jul 2026 16:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782922587;
	bh=ULDk0dKlNaYCc4UU7uCB1fvspUD39sUqTgZWe4uD7Kk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wc0vRORD2MCCStZboly9uAHihvzPNd+m5QJiSJSD+lwellSixuAwumOoBjIZQEy7g
	 H5k2VUzX90W3OyJIpVrRec1pRxd5OH1ruMGNIDhkc/NARcD11i1pY5biDYBvCzCs1K
	 ff1c8WsiJItmlPvVY9kaDznrxDrwGOMIJrg3fEPLxrsIlqOgbi8RdVOOJIBYTLoBlJ
	 Xzu1HK7UrtRDE+z1JlvHRoUgXkUT2xdE/m/zJsyyceTrYkoqojKjT8aS6SBMJgwOJ2
	 b+bakV8+xDWVrrtqv6DnKH8eOfoqx9FGoJmLbfb/iSCvBlfv7ZbX5COhD7G5dMk3Jy
	 3dHJCPJhuc9Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/11] dt-bindings: gpu: host1x: Document
 memory-regions for NVDEC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: linux-s390@vger.kernel.org, devicetree@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, robh@kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, conor+dt@kernel.org
In-Reply-To: <20260701-tegra-vpr-v3-3-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-3-d80f7b871bb4@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 16:16:26 +0000
Message-Id: <20260701161627.261AE1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21445-lists,linux-s390=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thierry.reding@kernel.org,m:linux-s390@vger.kernel.org,m:devicetree@vger.kernel.org,m:gor@linux.ibm.com,m:dri-devel@lists.freedesktop.org,m:agordeev@linux.ibm.com,m:robh@kernel.org,m:hca@linux.ibm.com,m:conor+dt@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp,nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA09C6EFA4D

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Typo `maxitems` instead of `maxItems` in device tree binding schema.
--

commit b966754e5a0b2701616e733b8013eb6ace1487ef
Author: Thierry Reding <treding@nvidia.com>

dt-bindings: gpu: host1x: Document memory-regions for NVDEC

The video protection region is a reserved memory region that can be used
for secure video playback. NVDEC can access this region to decode images
into securely.

Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml in p=
roperties.memory-region-names:

>   memory-region-names:
>     items:
>       enum: [ framebuffer, protected ]
>     minItems: 1
>     maxitems: 2

[Severity: Low]
Is this regression a typo with maxitems? Should it be camelCase like
maxItems?

It looks like the lowercase version either disables maximum length validati=
on
for the memory-region-names array or breaks meta-schema evaluation when a
developer or CI system runs the make dt_binding_check target.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-tegra-vpr-=
v3-0-d80f7b871bb4@nvidia.com?part=3D3

