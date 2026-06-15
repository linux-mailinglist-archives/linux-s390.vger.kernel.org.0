Return-Path: <linux-s390+bounces-20878-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lOJnLdJHMGovQwUAu9opvQ
	(envelope-from <linux-s390+bounces-20878-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 20:43:30 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37454689427
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 20:43:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UEH+P9qt;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20878-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20878-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCC0A300F517
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 18:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D61A3876BE;
	Mon, 15 Jun 2026 18:43:28 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91978384CFE;
	Mon, 15 Jun 2026 18:43:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549008; cv=none; b=b+RmnYVLiFwpvevUbwSl4VAGOGap3HvFgX5vyOOAC7LOq6HBogZDDglugpq6435kNHMIxe/4kTmpXbpL5tcFS9sUP/T0BLzFA5ZeTCdxVjstIABiIPHXITHl6GfzT/53uADIAqahKX5x68dq4mXrYBGfGbMMMxvRB/S2kyycT+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549008; c=relaxed/simple;
	bh=gAHWoaIMppzVt4xsEJ3Z53tk/3acxcW84EX9P8gk0Dk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gqlYMResI/frZ/gc8LYf5m0UesKhjG1RbqoFSsAxjJhuuap39TeoOQAYnsBYYEZj39dSijKACxOLhsitrHgIjcTwrqF+Gohwlk4vamiGo4NFknRs1+aEJMSn+EGBJOyhjMHSFjvzvsqwWwWFh0ecxo8ywL8AXDWuUVWqWTAIa88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEH+P9qt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7381F000E9;
	Mon, 15 Jun 2026 18:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781549007;
	bh=gAHWoaIMppzVt4xsEJ3Z53tk/3acxcW84EX9P8gk0Dk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UEH+P9qtUnWpum6Uv0JM5BzUog6xJQo9+cl3cQD/tcVhN5fE8fdU5y9/8DCku2ZV2
	 oWU3dLiUTqNHAvLTcTvPvHymMoQBlSQhs0EVg/PlBrnERvDlXWB+dltksgDZUOF3jI
	 mf4JN8su4p+bHkBN+T0zp6fNIhSA2Umm8l7crAmLPufPbnu74mUY61qEZCArH6c3Qt
	 MQX377ivylDK0SimuyDBMra3s+kYfj1fIOfX/ziAPeB5Tz6xbZtNUSNdFlcX7i0FoO
	 XW9xCNXOjlHPj3iX3eueSqnJjq04DRZ1qOLSACXNsqS5SM3aYXeuVh2+4yD51PBcBO
	 y8e5xn5zoKhWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 3/4] PCI: Fail FLR when config space is inaccessible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260615183524.2880-4-alifm@linux.ibm.com>
References: <20260615183524.2880-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 18:43:26 +0000
Message-Id: <20260615184327.0B7381F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-20878-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alifm@linux.ibm.com,m:linux-pci@vger.kernel.org,m:linux-s390@vger.kernel.org,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:hca@linux.ibm.com,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 37454689427

> If a device is in an error state, then it's config space may not be
> accssible. Add additional check to validate if a device's config space is
> accessible before doing an FLR reset.
>=20
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615183524.2880=
-1-alifm@linux.ibm.com?part=3D3


