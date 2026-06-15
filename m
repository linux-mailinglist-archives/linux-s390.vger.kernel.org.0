Return-Path: <linux-s390+bounces-20879-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iYhtCttIMGptQwUAu9opvQ
	(envelope-from <linux-s390+bounces-20879-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 20:47:55 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA65689481
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 20:47:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="aOETbii/";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20879-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-20879-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20CE93010BF7
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 18:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241B43AA4E1;
	Mon, 15 Jun 2026 18:47:53 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B2937FF5D;
	Mon, 15 Jun 2026 18:47:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549273; cv=none; b=XzZhOAVbT3u2u3Awec2wI8D3EyMgIO9uWnwMOHsCTA/RyNhNQXhcjObMhzgKdShtj/4rf9ps0qwVkx3TrWGtUIku2QBpoB/ObqX2SYZiTJprhn7ytX16zofzxiIDtfD3ESS3WMUVEV4ZiMygtE+pMDhX3tnaVdinplCCZaVHcng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549273; c=relaxed/simple;
	bh=Zqf0W9BX95gVsrn+zed0nO/8V1ohm4bxSr1iEajbe4s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QDMoqHh12WBZL/H3Neje67qIIgZ0EqS2nP09WrE+Ga/qyXNzO9+KIDZheqOb/ru2dQ/kLxPiNaiScVJEia7FqLj0mV/NCbqywvimovPC7gJcuOVEr1MMYhdP7F8TmEO60A76P4J6k0WDzz84GWG0cV5xFm+HoojoQZtppT10vy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOETbii/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8892A1F00A3A;
	Mon, 15 Jun 2026 18:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781549271;
	bh=UO3UHVlFn8lUUjEDD/wfmBNE3TL0G23ge1rM3YbA0p4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aOETbii/5mVMsXtpMDUzzksKiZNVWYMF72YLOsDtivr2jERzpOXkOOadCYrcESx5n
	 QR2xyavpxPrkWXlSqjsk+3PoF3zUO0nT59NHiMTeK82p1fxeISgWAlx/y9FFMUk7ev
	 IvCGS2TyKt6ydS/LixtbhlmVGydc9f9KWIIcHIvvdfjsgQ7dg/CgaNQg/O9LUOhqg4
	 J7O+R35W6JSokZ5FFw553i5QGB1hYLUC3b+a41BDwjm9dX2u7KUuc8TYw8az4wtNBH
	 gAIaDQr53a1PRcZh4YK9RbKQszb9K9bGSRMHFKLCNYBNxrClXl0ySI3sWkix5mIzjT
	 LJVuRSBhqCfmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 1/3] s390/pci: Store PCI error information for
 passthrough devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260615183616.2902-2-alifm@linux.ibm.com>
References: <20260615183616.2902-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 18:47:51 +0000
Message-Id: <20260615184751.8892A1F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20879-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alifm@linux.ibm.com,m:hca@linux.ibm.com,m:linux-pci@vger.kernel.org,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABA65689481

> For a passthrough device we need co-operation from user space to recover
> the device. This would require to bubble up any error information to user
> space.  Let's store this error information for passthrough devices, so it
> can be retrieved later.
>=20
> We can now have userspace drivers (vfio-pci based) on s390x. The userspace
> drivers will not have any KVM fd and so no kzdev associated with them. So
> we need to update the logic for detecting passthrough devices to not depe=
nd
> on struct kvm_zdev.
>=20
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615183616.2902=
-1-alifm@linux.ibm.com?part=3D1


