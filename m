Return-Path: <linux-s390+bounces-21613-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jScrK4+CS2qASgEAu9opvQ
	(envelope-from <linux-s390+bounces-21613-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 12:25:19 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 139EE70F1EE
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 12:25:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=h0+4Eqx+;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21613-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-21613-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63E0B3074604
	for <lists+linux-s390@lfdr.de>; Mon,  6 Jul 2026 09:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9FF43B6CE;
	Mon,  6 Jul 2026 09:35:44 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0C2430312;
	Mon,  6 Jul 2026 09:35:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330543; cv=none; b=gub9CbDKJrKS7PDmj2xQwPORYV8i0EJ13TDbzwhoqtvsxr4lzQqKUEEVobOQkfo4hdjVUyGLh5iW903858SUPKT+w+RAyVBMLYswf3bdsIUtTjPvvLZt/wxqFlsypeT5eKLcbluk9OnHRHB8f8tpssH85l/S7uirDqxS4GFQvNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330543; c=relaxed/simple;
	bh=IhbG/1QV63gAFn8zPHNCerEvyNwKUHmhB8DFfJQJytE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MugDg8BD6aingOOWB8m+oup/6kB1F8NUatVp/j9LjFE5kkx+PbmbHNr4oLFw/HxGtOsAoYg/s29sv+VZrzk19Hc5zn04BVIf2oZkvzSQ44XnKiXbBZke3BDZm/AoMOkd2KBXb2c0axsNXnGHknWI08/Oa9OoSagXwfVoqHMfhn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0+4Eqx+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0AF1F000E9;
	Mon,  6 Jul 2026 09:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783330539;
	bh=tHiAZf2QB0WMW2DRWk7c4hSkp0NEHRow5vX9K/vO/js=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h0+4Eqx+pxy92SEvL6mF3g3H7y00p32rG1agX38W88kmogS2YpjnBFUeIRm8Kt71o
	 XJol6gFtTgJXO6VHoRqtVmue4WjLQoA6b/8pWntLH2EcXZL67EflUirVDai3UjTLRx
	 i/djtho+OGBqmxFR1Jug+BK5HqMMZyzKa2o0E8eEoRVgs6DgngVY6cpZdsSJVSfUcF
	 ClaPCk4EW09K8/yh5BdMA9K8UMGC44NB3JoERnYIWvhA67nNzqvBGYo+sACPv4zxWd
	 LlYQD5GlBAGKz5DkYxArVCAOSnK+5DxIXKl0l1eoMm8Lcu2xL/S5ino+HAjtEidI74
	 DoCDSLcV64u5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/27] KVM: s390: Move s390 kvm code into a
 subdirectory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>
In-Reply-To: <20260706085229.979525-15-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-15-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:35:37 +0000
Message-Id: <20260706093538.1A0AF1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21613-lists,linux-s390=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:seiden@linux.ibm.com,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:maz@kernel.org,m:kvmarm@lists.linux.dev,m:kvm@vger.kernel.org,m:oupton@kernel.org,s:lists@lfdr.de];
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
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 139EE70F1EE

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The files `pci.c` and `pci.h` were moved from `arch/s390/kvm/` to t=
he `s390/` subdirectory (`arch/s390/kvm/s390/`), but their specific entry i=
n the `MAINTAINERS` file was not updated to reflect this change.
--

commit c2f3b449a0f094fa44a079aff2968b331a351e17
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: Move s390 kvm code into a subdirectory
   =20
Move all the code required to run s390 KVM guests on s390 to a s390
subdirectory. Move gmap related code into a gmap directory to later
share gmap code between KVM implementations.
   =20
No functional change.

[ ... ]

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/s390/pci.c
> similarity index 100%
> rename from arch/s390/kvm/pci.c
> rename to arch/s390/kvm/s390/pci.c

[Severity: Low]
Since these files are moving to the new s390/ subdirectory, should the
MAINTAINERS file also be updated?

The current maintainers entry tracks this path:
F:      arch/s390/kvm/pci*

Because the path has changed, the get_maintainer script might fail to inclu=
de
the subsystem reviewers on future patches for these files. Is it worth
updating the pattern to arch/s390/kvm/s390/pci* in this commit?

> diff --git a/arch/s390/kvm/pci.h b/arch/s390/kvm/s390/pci.h
> similarity index 100%
> rename from arch/s390/kvm/pci.h
> rename to arch/s390/kvm/s390/pci.h

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706085229.9795=
25-1-seiden@linux.ibm.com?part=3D14

