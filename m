Return-Path: <linux-s390+bounces-20884-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /o+7C+tJMGqyQwUAu9opvQ
	(envelope-from <linux-s390+bounces-20884-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 20:52:27 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8CE68950F
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 20:52:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IIcwZrXa;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20884-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20884-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EBD13053EA7
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 18:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE0A3ACEEB;
	Mon, 15 Jun 2026 18:52:24 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1663AD510;
	Mon, 15 Jun 2026 18:52:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549544; cv=none; b=oxFxm9YaTlilgvQaQ4sHs6ZgA6Ji30xabMRZLzbAbC6fMZQVKg7HKSqCpTgUPPemK0lUjSHISLjHVs0K70kSk5QC57yVkz6I15ogfS46rQLQXvKvNbWMpNnCaPbjI4HrKGpuJUHKoi+IlAeljYN3gQ3vgaV1vUdA5nkUt8ZIysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549544; c=relaxed/simple;
	bh=AzdW+5VaWGnwO28CeMXXmLTpahwshtpVzPppI25D5Zs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qHvg6UJ/NB9UMGCBsRBlQJ81dMOrz4rQnIQ7p3lxwfexCK9O1QPKexjU7oXzvASYv8QfsrIVLZ9GeJgXPmiZlnm1bBp8K4CVmwOkH/w7VA4dAsLNJGJgL86SIslsnn7do+vQGNoaRpoITGG8npmo5hAVEjkiQD27Gqjs85M09iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIcwZrXa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9A11F000E9;
	Mon, 15 Jun 2026 18:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781549543;
	bh=AzdW+5VaWGnwO28CeMXXmLTpahwshtpVzPppI25D5Zs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IIcwZrXa4xpN7MRcLnXp1Ulr60xNCM49S+x6XM5tgOB07xoyf4nuRHIYe4jFs5CyS
	 47R7j1n6oVA/Dkbf8p7rIwqke4tqhMJjEv9fTipb4LVhpWqLN52xB8xpVf8D9fz7Gm
	 EsHPNLdVgY4YL4Ffb6ZAWAS4rcHw1GQZrs322OyNa0Iim4B33njEIRqfA17VQlB5se
	 p2xiIodqvts0Nw0+Itn1to+gh4PKyZrncdzKgV7bcewc6oMjuhJPaFfW1ZYWrfqxXC
	 UUsh+swzzLwZjlCyqO6iox4m/zMv5uOMZEvQpISRHulZ1m4bSIOcax2s/aLgGb3tLP
	 E/kGOJRI1qJBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 3/3] vfio/pci: Remove the pcie check for
 VFIO_PCI_ERR_IRQ_INDEX
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260615183616.2902-4-alifm@linux.ibm.com>
References: <20260615183616.2902-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 18:52:22 +0000
Message-Id: <20260615185223.5B9A11F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-20884-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url,vger.kernel.org:from_smtp,shazbot.org:email,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alifm@linux.ibm.com,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 8A8CE68950F

> The error signaling is configured for the vast majority of devices and it=
's
> extremely rare that it fires anyway. Removing the pcie check will allow
> userspace to be notified on errors for legacy PCI devices. The Internal
> Shared Memory (ISM) device on s390 is one such device. For PCI devices on
> IBM s390 error recovery involves platform firmware and notification to
> operating system is done by architecture specific way. So the ISM device
> can still be recovered when notified of an error.
>=20
> Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Reviewed-by: Alex Williamson <alex@shazbot.org>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615183616.2902=
-1-alifm@linux.ibm.com?part=3D3


