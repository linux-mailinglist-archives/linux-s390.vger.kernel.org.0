Return-Path: <linux-s390+bounces-21022-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rMSrHw/3NGqxlQYAu9opvQ
	(envelope-from <linux-s390+bounces-21022-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 10:00:15 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C96516A47A7
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 10:00:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HGQtZ5S0;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21022-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21022-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EF73302801F
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 08:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F181B32B11D;
	Fri, 19 Jun 2026 08:00:12 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08383546C5
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:00:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781856012; cv=none; b=QC2h5i5oz47P4Kb5sxhp96drXpaYfbWlVTUfMhmXSyPrwGnUaKM9qFBI0U++9sQKDJ2acBN6J4AYd/BaGNq3aoBZ7m+rCKL26DPE/vH35DmR7OvsmC/ketk3aHWnFBLza+hd/ruqD0W66jw2zuw0bnPS+eOdGYMgLEPKcQ1B+vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781856012; c=relaxed/simple;
	bh=Fyns6vW9v/6AYJfupVOUmEEpzx6NQJ1A9HJaqSRvUgw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AF/DEI2BNMNa4dnHicx7DRJnmkDDuyDXxZcR+cbHLInvgQnBn8KK9TZa0yY7L1fYxoF5xk4uL49YwN6VMQbmX2bhh7SOKb7haL6fDNnYjhtsWiw9BECvMk1Eil5nZAEYljCTBqSY+dGPej/bjNgaHy9/GnYJlOuJ4PgBeEXiISs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGQtZ5S0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1A71F00A3D;
	Fri, 19 Jun 2026 08:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781856011;
	bh=IMDto07e6HUuUPw82jjci6ORfz4Xt0Y1hdja47VVFKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HGQtZ5S0qS1wxARK87Xa5NBX72TftAcGwI3tvMnLdFEDf7JORB7WtIPrc0BmyPNZe
	 O1TcVoW/cEmAl3DmvlqPAP+N07bbRBJKznFs17NKlPYncVbdd+VrSULlzBMngrSXks
	 w5AB3RlOek3v2dFqOIjOeFMOXwTKBznWa/EFT39sI/+25IzU0udbrFgEEDi24NxjFb
	 pfLUXzNeVrpGRg2j9Bn6l+apfIg/anN1Ja8jR9XQzZKkbanXhUDQx1NTA73zDzMWQM
	 NBThbAoeuJziP5DLAeQmjfDWMyEkmsgNkT4woXl/cysVuno12cuUKwBHYyLIc+kgoT
	 eEbdUt0OapdGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] pkey: Fix bitsize check in PKEY_VERIFYPROTK
 ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Holger Dengler" <dengler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260619074541.1710716-2-dengler@linux.ibm.com>
References: <20260619074541.1710716-1-dengler@linux.ibm.com>
 <20260619074541.1710716-2-dengler@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 08:00:10 +0000
Message-Id: <20260619080011.4E1A71F00A3D@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21022-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dengler@linux.ibm.com,m:linux-s390@vger.kernel.org,m:gor@linux.ibm.com,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C96516A47A7

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] An integer wrap-around in the key bit-size calculation bypasse=
s length validation, leading to massive out-of-bounds memory accesses durin=
g a subsequent memcpy().
--

commit 26c99ec1350980042dcf4518941f9831c98478fc
Author: Holger Dengler <dengler@linux.ibm.com>

pkey: Fix bitsize check in PKEY_VERIFYPROTK ioctl

This commit updates the bit-size calculation for protected keys in the
PKEY_VERIFYPROTK ioctl to account for the wrapping key verification pattern
(WKVP). It subtracts the length of the WKVP from the protected key length to
fix the calculation.

> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_ap=
i.c
> --- a/drivers/s390/crypto/pkey_api.c
> +++ b/drivers/s390/crypto/pkey_api.c
> @@ -334,7 +334,8 @@ static int pkey_ioctl_verifyprotk(struct pkey_verifyp=
rotk __user *uvp)
>  	if (copy_from_user(&kvp, uvp, sizeof(kvp)))
>  		return -EFAULT;
> =20
> -	keytype =3D pkey_aes_bitsize_to_keytype(8 * kvp.protkey.len);
> +	keytype =3D pkey_aes_bitsize_to_keytype(8 * (kvp.protkey.len -
> +						   AES_WK_VP_SIZE));

[Severity: Critical]
This is a pre-existing issue, but does this calculation allow an integer
wrap-around that bypasses length validation?

Because kvp.protkey.len is a user-controlled 32-bit unsigned integer and
there is no explicit bounds check against MAXPROTKEYSIZE, a malicious user
can provide an enormous length. For example, if kvp.protkey.len is
536870960 (0x20000030), subtracting AES_WK_VP_SIZE (32) yields 536870928.
Multiplying by 8 results in 4294967424 (0x100000080), which truncates to
128 in 32-bit arithmetic.=20

pkey_aes_bitsize_to_keytype(128) then returns PKEY_KEYTYPE_AES_128, passing
the !keytype check.

Further down in pkey_ioctl_verifyprotk(), the unvalidated oversized length
is passed into memcpy(t->protkey, kvp.protkey.protkey, kvp.protkey.len).
Since kvp.protkey.protkey is a 64-byte array on the kernel stack and t
points to an 80-byte heap allocation, wouldn't this cause catastrophic
out-of-bounds memory accesses?

>  	if (!keytype) {
>  		PKEY_DBF_ERR("%s unknown/unsupported protkey length %u\n",
>  			     __func__, kvp.protkey.len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619074541.1710=
716-2-dengler@linux.ibm.com?part=3D1

