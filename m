Return-Path: <linux-s390+bounces-21387-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MhZSHFH9Q2q6mwoAu9opvQ
	(envelope-from <linux-s390+bounces-21387-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 19:30:57 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCE86E6E9C
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 19:30:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IQY3qv43;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21387-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21387-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB648300293E
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 17:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297D9158DCF;
	Tue, 30 Jun 2026 17:27:18 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FE13AA1B5;
	Tue, 30 Jun 2026 17:27:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840438; cv=none; b=iBN7vjuaxvrGxebDpDOBResQixp4wHdMbCnfXcJQSXI4ThY5R14UmiZRShwHRJmd3gsg+xqXOCGMrGD+8ROElh3HLvaHHDw9Gt91pjVpFGm7HjKCxKGMWof6AQg+mfOSo0MZJ+2xn6qe8Ec+kyQHG+C4ByNaNukgOSiXnmjgNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840438; c=relaxed/simple;
	bh=ss2fGP3mjT1OY+/VMSawSf8lqidO9w0vy7lhQdI3bMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DAuo4Pe9PoQsG0qJHJ5AMWRj9t74G9eSAMNsyymM3mWPIccVEgrWF891B9Wk61u7KkotBjMhor+W89mrTeda9hEb1AInrRpY5KAikImuw5E6oTxoaYsdrS6yz4qZRTw0B6QVMl5FkI2ph6uFT69hKS46biUqwdj8w4asxARZfvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQY3qv43; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C2B1F000E9;
	Tue, 30 Jun 2026 17:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782840436;
	bh=ss2fGP3mjT1OY+/VMSawSf8lqidO9w0vy7lhQdI3bMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IQY3qv4378O0uHaGupWP3DTvLJS+0eQgmrR4EuoIXIWInxqiKznJnKY31qa15AUHc
	 pJ+Ine66RssE5WFv/xgNN50H9PcwCHQPgpJ8ztYPyN3/G0pZliW87oKJ1O0KibjF4r
	 es6AuoEv8PbvMqSV6eNLo/n64WLArGGTMgQAfTjm2hWzK56No1pOyzUQlJxXEUpa5l
	 ze9BW3Ai0M00qV2fcRCvWA+DX62V8Pk2RrlY+XtNJJF6AObcf46MpObZcgtX+dzM3p
	 +OF9WgTuiepVzCnzo/qXCE1ZnYjb0fm0iVydJOXgLwqWu30buPZXN+X8yVAl1BrcL6
	 74zUisvJiNGoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 3/3] vfio/pci: Remove the pcie check for
 VFIO_PCI_ERR_IRQ_INDEX
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-pci@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260630165553.725-4-alifm@linux.ibm.com>
References: <20260630165553.725-1-alifm@linux.ibm.com>
 <20260630165553.725-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 17:27:15 +0000
Message-Id: <20260630172715.E6C2B1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21387-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto,shazbot.org:email,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alifm@linux.ibm.com,m:gor@linux.ibm.com,m:linux-pci@vger.kernel.org,m:hca@linux.ibm.com,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FCE86E6E9C

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630165553.725-=
1-alifm@linux.ibm.com?part=3D3


