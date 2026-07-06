Return-Path: <linux-s390+bounces-21668-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 829+ImYSTGrbfwEAu9opvQ
	(envelope-from <linux-s390+bounces-21668-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 22:39:02 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CB97157E9
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 22:39:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iuc12lsL;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21668-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21668-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B0703029766
	for <lists+linux-s390@lfdr.de>; Mon,  6 Jul 2026 20:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F833DB625;
	Mon,  6 Jul 2026 20:12:35 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67043DB992;
	Mon,  6 Jul 2026 20:12:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783368755; cv=none; b=W1XzV0n1wClJ7XfapXzncgs2La3Go8lWh8DwgKqkApsiW6wLtSNagfEqyqb/vIqaIMIL//vyMlND2iST/YaUgjgzfExFyzcKlMducYzcUwqF22VDDKnzyKwTw0KZA4F6qhmVcNSz+Vu3xzCMxUOpZrgEKRqNGrDdmQERTXHDbLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783368755; c=relaxed/simple;
	bh=198kkjwdLvm+jgZOhFRiTNgrdS0886kJHSp+oMUxAd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XF5xd4pw4iFwxfsU1sAZqFPe1Wsav4OLarq6C+m3ff2wlEnRxiqm/jKREEglXTtBBByvhZErdHXQISuZtI7Lj7s6KZHhSPn41ooxhJYdt3MwH5s9kfqrNM9rTIYLYCtvLgbKb4FyvFyxqQEIzSyAQyk/pdxBb3yA22tpBxFlTiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuc12lsL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52771F000E9;
	Mon,  6 Jul 2026 20:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783368754;
	bh=6LzxoRPysS3e9PYbinI6b5iaOYUpOLco0I/aVcxYkQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iuc12lsLZ5p/YoCgH9Cuz4LF219zwNJvNCSVJV6W+XQFS/zFzSwdU314xyge1sMds
	 jj0BvfVpPUexP/h/DVChVLZCRQJlcfn9i+PfQqXeLVXKe/tNb2SIScQwKwvu1t5BAA
	 xYwa/WFeQQfHrIeuqxMFNFEBmITNVBYKGb9bMQvPtcfRUHSFXYiWN15HGLaBd9GK0B
	 WXZ09uSNycOlVjrsziA1Z70MY9aSJ6631Zq8IZLfJYpC0brxOjmdRRnZIVEKmmEhhj
	 vIGIXq6Wk3V7DceT/7MG4B+VUJem3n7s/gpzE8Kos5uwu6p/Sxk6Gkmb3xaDl+kkoo
	 AwomPJ3Ou3upA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/1] PCI: hotplug: Add 'uevent' sysfs attribute to
 trigger slot events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ramesh Errabolu" <ramesh@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260706200244.91130-2-ramesh@linux.ibm.com>
References: <20260706200244.91130-1-ramesh@linux.ibm.com>
 <20260706200244.91130-2-ramesh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 20:12:33 +0000
Message-Id: <20260706201233.C52771F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21668-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ramesh@linux.ibm.com,m:linux-pci@vger.kernel.org,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 17CB97157E9

> Add a write-only 'uevent' sysfs attribute for synthesizing
> uevents for a PCI slot. This extends the existing uevent
> support which emits a KOBJ_ADD uevent in pci_hp_add() with
> the ability to replay such uevents for cold plugged devices.
> As such events are only emitted by hotplug capable PCI slots
> so is the support for synthesizing them.
>=20
> The change was validated by manually triggering 'add' uevent
> for a specific hotplug PCI slot:
>=20
>     $ echo "add $(uuidgen)" | sudo tee   \
>                 /sys/bus/pci/slots/<slot-id>/uevent
>=20
> Signed-off-by: Ramesh Errabolu <ramesh@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706200244.9113=
0-2-ramesh@linux.ibm.com?part=3D1


