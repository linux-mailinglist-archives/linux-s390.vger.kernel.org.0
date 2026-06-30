Return-Path: <linux-s390+bounces-21383-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9W35Idb4Q2rRmQoAu9opvQ
	(envelope-from <linux-s390+bounces-21383-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 19:11:50 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC496E6C8D
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 19:11:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cFEPrBlS;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21383-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21383-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63B6130034B2
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 17:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10BA3DB330;
	Tue, 30 Jun 2026 17:11:43 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A72D3DB322;
	Tue, 30 Jun 2026 17:11:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839503; cv=none; b=WZQCzyxGzij3YFqTIf3vAqrRBnNzfEISKdZu0+v3nKGi4AC8wkfIHNd9UqVwzhBWEJWOCgohc9Vgqj09oexASkFKofx2/KiwQm41DxWxKcfAe4zzJtjANW5iLLsvqJFnCk8tUCeM3Sp/vZuVoyzxbcHOoZ9maN5o4sq71JPHzJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839503; c=relaxed/simple;
	bh=R80k4gZ7GNKO2zCHQ2y1lNcYkBM/9tKFIFs28C6arWo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nYS0o0siO/JciJ15rs/aA4p2KMqGJfkURf227CwIqYBI3stdJQj1egFZ5yRC4OW+WdB5aP12xpU6iOpPiQdCKrErVFuubhMjcuWwcMdveuBSQtovfV59LnvcKe6cxL2zOCK6KUmNaJUyp08a3vBjdIuH5ke3kh3XHMABqeU5rwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFEPrBlS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08131F000E9;
	Tue, 30 Jun 2026 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782839502;
	bh=BJ9yAP4+ZitHC+Lq6dA1jUXBybjIRdhHhZFi/oc0FCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFEPrBlSBCbPEg6HyoOLMChHAUMEcUOU051pbayhbfe3PyB9o/ltaS9Ls+tGEMt1K
	 87C284ypOJst1okE/r/IHP1ZGnAI5LixpQTRVqoQCXTVW8ZyaeDOfQ6OP03MiF9XOc
	 p0B+VcXEX9E19ahTJ0+eQD60gWWv38BxIYydf2v9QMEifcmbLWxLjAsjev359pZvRm
	 NGialaeO+VXEyk+JtaOhBB3J9F3d5/Gprsy49S00OS1YpCpeZkLDFqvwhjTmcr3fWD
	 c68V5jgDTL/mvOpxesoqn5CBbkxIKiM5MztyfyIGXgaWIFrT5NKWUcLkVNLPM5S43S
	 Th4LNrUUgpMxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 1/3] s390/pci: Store PCI error information for
 passthrough devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260630165553.725-2-alifm@linux.ibm.com>
References: <20260630165553.725-1-alifm@linux.ibm.com>
 <20260630165553.725-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 17:11:41 +0000
Message-Id: <20260630171141.F08131F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21383-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,smtp.kernel.org:mid,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alifm@linux.ibm.com,m:hca@linux.ibm.com,m:linux-pci@vger.kernel.org,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CC496E6C8D

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630165553.725-=
1-alifm@linux.ibm.com?part=3D1


