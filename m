Return-Path: <linux-s390+bounces-21386-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YPdHHoT9Q2rLmwoAu9opvQ
	(envelope-from <linux-s390+bounces-21386-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 19:31:48 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF57F6E6EAD
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 19:31:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ECQAGwOJ;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21386-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21386-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 332D73134F5C
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 17:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43453DEAE0;
	Tue, 30 Jun 2026 17:23:30 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC533E0234;
	Tue, 30 Jun 2026 17:23:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840210; cv=none; b=LBnmjj+2g5MaNMs76+fpi+4SqUJPg15MvtSfdMK64JMWhrSSO7fJVANOmHVJg9z1iNJ4QSftNPK9yJhc6k7hbn3ZtQqbrIhIiWKQV5pyEiqFRJs9uE0hN+fvOr4Bjo0zxOniFMKtX9+vlsFV/JkNvx76YwLP5i4Ub/ydAREZ/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840210; c=relaxed/simple;
	bh=2/PLOMBW0BkEjg72GdqLIJB72ETbgMgHbDTZU0aPQoI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=paKAGhncBsd9/s2itupMD2CRn/KOqN0Hx+MOL6I7AB7dXvS7mviD7zCWnbdT0SUpw/m0w2GC1O2zBBNx/ndHm1Owgl+4uP8m1h5fYAfYlIUdKCymEN3ye9ANpodOmKyK62Asqej2B4a8OIhlqsi8kxKUXWx5Mlz2Exke98mIrQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECQAGwOJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565E71F000E9;
	Tue, 30 Jun 2026 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782840206;
	bh=2/PLOMBW0BkEjg72GdqLIJB72ETbgMgHbDTZU0aPQoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ECQAGwOJoXCCuBrl7wvcjdp/wN7d7FRkxmc17LXc7ByQ0dRKAbZtHwThP8H1UEnoJ
	 NUfsPV6gwpTOC27avqUEVHZOzgWtyOg4QNn5KQl3rO3qZUiMTgv/yCYtSj6Bg6tgtl
	 KyL/Lu1nawbEMofZwfWjyiXkLMZKslS3W6vhrs6OwjLe+GoMKRTCaiQXcbc5qjPlHQ
	 1TIayRb4vSD5ckCYrXhIKTfepirlSzuYv4S1gy2FHDwdTOU+YgS+X0wx3d5bF52Fkn
	 KiKpy2C5HRydWIaeH5JNztym2efjwxVRdo0pfar/BWeAjlA9U4mc54VMjvJt+1Q1Ns
	 8fRAIcubizIzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 2/3] vfio-pci/zdev: Add a device feature for error
 information
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260630165553.725-3-alifm@linux.ibm.com>
References: <20260630165553.725-1-alifm@linux.ibm.com>
 <20260630165553.725-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 17:23:24 +0000
Message-Id: <20260630172325.565E71F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21386-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alifm@linux.ibm.com,m:linux-pci@vger.kernel.org,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: BF57F6E6EAD

> For zPCI devices, we have platform specific error information. The platfo=
rm
> firmware provides this error information to the operating system in an
> architecture specific mechanism. To enable recovery from userspace for
> these devices, we want to expose this error information to userspace. Add=
 a
> new device feature to expose this information.
>=20
> Userspace needs to be provide a buffer of fixed size. This size is provid=
ed
> to userspace via the VFIO_DEVICE_INFO_CAP_ZPCI_BASE capability.
>=20
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630165553.725-=
1-alifm@linux.ibm.com?part=3D2


