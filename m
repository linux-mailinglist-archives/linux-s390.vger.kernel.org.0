Return-Path: <linux-s390+bounces-21450-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fkVcFiZBRWri9QoAu9opvQ
	(envelope-from <linux-s390+bounces-21450-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 18:32:38 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB5C6EFD38
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 18:32:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lHs0bjiF;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21450-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-21450-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87711306C3C5
	for <lists+linux-s390@lfdr.de>; Wed,  1 Jul 2026 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC576371D15;
	Wed,  1 Jul 2026 16:32:09 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674A1372052;
	Wed,  1 Jul 2026 16:32:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923529; cv=none; b=piPptcM9mhTUBMej0d1OViU+0Q92p3RAFrIP+VNnC+YsYWI5Y5/tWPs1uAduAM2GK7dvmV2DGIdzpECFu3DTxrA0tZ9IP3dsUXTcr3hIt663Yp72oh+61C9JMLrZP9zlvH2sSjSEc3h6rf6qu/6O00mTmUH5Sqt/335h80DtziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923529; c=relaxed/simple;
	bh=w2Tvuq1hvmbraq0z4o07hP/YzuQsmlX+W3w4zWdOyCw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uXIf32R3gYMew+C1QQScgD7cNDE0Tlzfq6fZKP9SyhFtiGXs30bsh0YSDdkPv9pp6OGCXs3kOKGFMaGm04dRvR6Y3MIMkxxBoj5925d0zrs9hEuwNXw2Y32ijgF31Cum82olDvuqxXa8XzCZiSMSdXh9CPtfeYlP3FslZT9/V8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHs0bjiF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE3A1F00A3A;
	Wed,  1 Jul 2026 16:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782923528;
	bh=MuqZMoa1DRV8V04R88+JlOJHWAnC/DrOvyHPNDXDFRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lHs0bjiF5qowFn7aKTZ4RGWT5WmbGHebcCBoXqiC6cITYCmbc1jsnyTlmJ+HfK4HB
	 u3LAf+y1oOGAKtbvMDI276jG4zzAn9IfXME6fACxBewWlIg+kjWJ1EPts1QLWP+yUT
	 uSMefZqRgacBf3XfPUpNNslZyH1ZG/ZPO1gvYok9yhGHlQwYjtBxg7R0/k5wmxfzrH
	 MYQh6FY1k3Drl1LoPPUi9xHgeaTlTuPU7w10gkQSd6FXPb/I5sSI92mloQidOYoq8t
	 ZBNNPS1Rtt8zcXwR1JJ4747nBFyI4c8+VOe+sXd3A0iDKBS3KMOscb+DI/77xLybuv
	 r8fQjTHjrYpzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/11] arm64: tegra: Add VPR placeholder node on
 Tegra264
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, dri-devel@lists.freedesktop.org, linux-s390@vger.kernel.org
In-Reply-To: <20260701-tegra-vpr-v3-11-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-11-d80f7b871bb4@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 16:32:06 +0000
Message-Id: <20260701163207.2AE3A1F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21450-lists,linux-s390=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thierry.reding@kernel.org,m:robh@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:hca@linux.ibm.com,m:dri-devel@lists.freedesktop.org,m:linux-s390@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,smtp.kernel.org:mid,lists.linux.dev:replyto,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEB5C6EFD38

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Meaningful contradiction between the commit message and the actu=
al device tree source regarding the "reg" property for resizable VPR. The c=
ommit message states that 'if the VPR is resizable, the firmware should rem=
ove the "reg" property', implying it is present by default. However, the de=
vice tree node explicitly comments out the `reg` property, and its comment =
states that it 'assumes resizable VPR by default' and that fixed VPR must '=
add the missing "reg" property'.
--

commit 6b6b37b0bf4380a0dd429f1a01402c6ffedb5c1f
Author: Thierry Reding <treding@nvidia.com>

arm64: tegra: Add VPR placeholder node on Tegra264

This commit adds a placeholder VPR (Video Protection Region) node for Tegra=
264
in the device tree. It includes default properties for a resizable VPR, alo=
ng
with comments indicating how firmware should update the node for either fix=
ed
or resizable VPR scenarios.

> Similarly, if the VPR is
> resizable, the firmware should remove the "reg" property since it is no
> longer needed.

[Severity: Medium]
Is this description in the commit message accurate? The device tree source
node comments out the "reg" property by default, so firmware wouldn't be ab=
le
to remove it for a resizable VPR. The inline comments in the implementation
also state that firmware should add the missing "reg" property for fixed VP=
R:

> diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra264.dtsi
> --- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
[ ... ]
> +			/*
> +			 * The below assumes resizable VPR by default. If the
> +			 * firmwares sets up fixed VPR, it is responsible for
> +			 * adding the missing "reg" property, removing any of
> +			 * the unused properties, as well as adding a unit-
> +			 * address matching the "reg" property.
> +			 */
> +
> +			/* fixed VPR */
> +			/*
> +			reg =3D <0x0 0x0 0x0 0x0>;
> +			no-map;
> +			*/

Could the commit message be updated to match the implementation, or should =
the
"reg" property be uncommented in the dtsi file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-tegra-vpr-=
v3-0-d80f7b871bb4@nvidia.com?part=3D11

