Return-Path: <linux-s390+bounces-20858-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sUrnLpj6L2o0LAUAu9opvQ
	(envelope-from <linux-s390+bounces-20858-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 15:14:00 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C986869A5
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 15:13:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=a82XwiHS;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20858-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20858-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAE52302E9E1
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 13:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA543F39E1;
	Mon, 15 Jun 2026 13:07:28 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F403EB0F2;
	Mon, 15 Jun 2026 13:07:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528848; cv=none; b=JmE7IlbbUmbaM7XmmooxMhs3k+baJlj8sSRE6mTLbOKXhxqa94sv5qpWUWBCI08jLNhFFrdAoCiTv6ykpwyIzekT9rxxQgKnEr4NoMr0gxbXLE9u5Uv71OWyPVwineUodMQzScFEO43BdTc3c33NtRXfgHQUTFlmAq2gCGMveIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528848; c=relaxed/simple;
	bh=e+9J+xR3ilcFt1flWZK/6j8o2++oWVoMYiJTu4vdrrE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dyRSUyd78E2MjDnZrVGH98pVFk4rOwMN9i4aVbpYM1/qp7+XXvJC4fvH80Zl+pAQfCI8PZfIk2ONMlwbA5WtmFbSLQa6etyfOMOC7JNQX8pbXF48kZtG+TQJSCcI2e3zvChzaKzKUu5qJMqD4WjtwWs+B2ItyvEliEBXCeqCgUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a82XwiHS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDFA1F00A3A;
	Mon, 15 Jun 2026 13:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781528847;
	bh=+6l0Dacb9ahm6att4v+pTLyr9UPV4fIHFd6mdDyl5mA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a82XwiHSOVTmoand7pMLVaifI80JeG8Am1b6ybcUD7u+SDavWGd2Cq6hCPhlExrzT
	 s/PNTLk/kqyxTJrRXccyMuiW/qIXSZHS20q6RML6TzgRIKKqlZS/CNXhHQlIp+x3di
	 ydUMyn0IV2WBzt8jOac9IpC2r90HwRIEWOSr+Fx4luwCx0A572qZysHWivC1/7BGEj
	 jIAz6fSrZlzD/JZT+TVqyvZonScmkuAvkmMKfrRqSpbDAWytpWAI8soxYC8qEkgRza
	 39NBGuLYmZX7nmb1G50u4l8HTtRV8qzTODk5QQKDSyT7+Fe6/+m5otcmlLSU269RMw
	 CwlEX4jW0uzpA==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 10/17] KVM: s390: Initialize
 KVM_S390_GET_CMMA_BITS memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260615124243.187614-11-imbrenda@linux.ibm.com>
References: <20260615124243.187614-11-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 13:07:26 +0000
Message-Id: <20260615130727.3BDFA1F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-20858-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,m:gor@linux.ibm.com,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: B3C986869A5

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] In `dat_peek_cmma()`, if the provided `start` guest frame numb=
er (GFN) is out of bounds, `_dat_walk_gfn_range()` immediately returns `-EF=
AULT` without executing any callbacks. Consequently, `state.end` remains `0=
`. The function then computes `*count =3D state.end - start`, which underfl=
ows into a large unsigned integer. This underflow bypasses the error check =
and causes `kvm_s390_get_cmma_bits()` to perform a massive out-of-bounds re=
ad and copy kernel memory to userspace.
--

commit d8e920ce2bbd8785a01a3239ce6dc856e44c18b4
Author: Christian Borntraeger <borntraeger@linux.ibm.com>
KVM: s390: Initialize KVM_S390_GET_CMMA_BITS memory

This commit changes the output buffer allocation in kvm_s390_get_cmma_bits()
from vmalloc to vzalloc. This prevents unmapped or clean pages from exposing
uninitialized kernel memory to userspace during migration.

Message-ID: <20260611105036.11491-1-borntraeger@linux.ibm.com>

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 35e5971a474f6..f643cf512f127 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2284,7 +2284,7 @@ static int kvm_s390_get_cmma_bits(struct kvm *kvm,
>  		return 0;
>  	}
> =20
> -	values =3D vmalloc(args->count);
> +	values =3D vzalloc(args->count);

[Severity: Critical]
This is a pre-existing issue, but does the error handling in the peek path
allow an underflow of args->count that leads to an out-of-bounds read later?

If an out-of-bounds start_gfn is passed, dat_peek_cmma() calls
_dat_walk_gfn_range() which returns -EFAULT immediately, leaving state.end
at 0:

arch/s390/kvm/dat.c:dat_peek_cmma() {
    ...
	rc =3D _dat_walk_gfn_range(start, start + *count, asce, &ops, DAT_WALK_DEF=
AULT, &state);
	*count =3D state.end - start;
	/* Return success if at least one value was saved, otherwise an error. */
	return (rc =3D=3D -EFAULT && *count > 0) ? 0 : rc;
}

If start is greater than 0 and state.end is 0, *count will underflow to a
large unsigned integer. Because this underflowed *count is greater than 0,
dat_peek_cmma() masks the -EFAULT and incorrectly returns 0 for success.

When execution continues in kvm_s390_get_cmma_bits(), this underflowed
args->count is passed directly to copy_to_user():

	if (copy_to_user((void __user *)args->values, values, args->count))
		ret =3D -EFAULT;

Can this allow a user to craft a start_gfn that triggers this underflow and
copies memory beyond the vzalloc buffer to userspace?

>  	if (!values)
>  		return -ENOMEM;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615124243.1876=
14-1-imbrenda@linux.ibm.com?part=3D10

