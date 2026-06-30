Return-Path: <linux-s390+bounces-21323-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k0JkLCdPQ2pSWwoAu9opvQ
	(envelope-from <linux-s390+bounces-21323-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 07:07:51 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CD86E06FA
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 07:07:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QmoBrmvw;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21323-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-21323-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C968300461B
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 05:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA34382F35;
	Tue, 30 Jun 2026 05:07:43 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77573E1687
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 05:07:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782796063; cv=none; b=gsly9kP4LRPzutoD9pYNyDRKQpH/DTVnGVuXt1TO2VLYTUDDphXdwmvzrYHtqB/bQn3P9Qa0KRfIcDy2dgXaPYEYwmDe+VqXE/vIbptP+RWwMAIzINe8OJKTA63FgCLxfolcQyG1y9a8AgLWxs84eeVMkGZgEBk/3y2AQAU5T7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782796063; c=relaxed/simple;
	bh=b5cY51EjznmmdH3HqdKfGY5D6HnFt12ySsLAa1AtEtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LVc18RwKwLtUKZQmDLpLFLeXD/rZOr+zgaFEvUo4J58F2ZtXswSnm56g69skyThIZLkrlsgEoEJRcBAk3dF8UrVvQe3IgxOFYp4ZCYnaq3ht6nSut67Dkenfik77HlMCc8sIo+Bzyf6WFZLV4j2crIeacezy96cDOXGWwx9b0YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmoBrmvw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBB21F000E9;
	Tue, 30 Jun 2026 05:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782796062;
	bh=5Bn7j8tE44yIYDE6KpKg9/kKcWAZGGEzxoWgkS55chs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QmoBrmvwpay1yvzLkGXGRCOyQQzIntwqKMJ8+O7nHaeyNjwBcvtBSbtbVIn+JsW2m
	 /179Coc7pn2LWARtRFQn4fgql4jgLZWTqbN9rVwCI22JrbciQGrU1TipfbEnPffqiW
	 VJnNykk1MwlGqORzAHtYBH47MwLc7svFEokqXTCIYPM22K5WwEfsFQtk9MKqGIEGbo
	 gQtBiufLWgF8qSNee5svq9dmsftCvQiIy/eRST7aj6SLfmYBZ5iBl3i5NerWHh3z+K
	 9mJmnrKpl3fJZ8igw1Jb9+KrKQtcC/R9nbH6o+87Vx5RuCR+AmUBCP963lEPrdvQ/+
	 q3lCdNmq3wm/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/8] arm64/runtime-const: Introduce
 runtime_const_mask_32()
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260630045531.3939-4-kprateek.nayak@amd.com>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-4-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 05:07:41 +0000
Message-Id: <20260630050742.0BBB21F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21323-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:email,sashiko.dev:url,arm.com:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,smtp.kernel.org:mid,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kprateek.nayak@amd.com,m:agordeev@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9CD86E06FA

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Calling `__fls(val)` before `BUG_ON(!val)` invokes undefined beh=
avior for `val =3D=3D 0`, potentially allowing the compiler to optimize awa=
y the safety check.
- [Low] The commit message incorrectly references `amd64` instead of `arm64=
` and misspells `density`.
--

commit e9b79c78d336baf757f7578713831df9b1c4c1b9
Author: K Prateek Nayak <kprateek.nayak@amd.com>

arm64/runtime-const: Introduce runtime_const_mask_32()

This patch introduces runtime_const_mask_32 to optimize the mask operation
in the futex hash computation hot path using the UBFX instruction. It also
adds __runtime_fixup_mask to patch the 32-bit mask in the asm block once
the mask is known.

Link: https://developer.arm.com/documentation/ddi0602/2026-03/Base-Instruct=
ions/ [1]
Link: https://lore.kernel.org/lkml/20260430094730.31624-4-kprateek.nayak@am=
d.com/ [2]

> instruction is used for amd64 to improve instruction dinsity and
> performance.

[Severity: Low]
This isn't a bug, but there are a couple of typos here. Should "amd64" be
"arm64", and "dinsity" be "density"?

> diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/=
asm/runtime-const.h
> index 838145bc289d2..371c9a4bc2d4b 100644
> --- a/arch/arm64/include/asm/runtime-const.h
> +++ b/arch/arm64/include/asm/runtime-const.h
[ ... ]
> +static inline void __runtime_fixup_mask(void *where, unsigned long val)
> +{
> +	unsigned int width =3D __fls(val) + 1;
> +	__le32 *p =3D where;
> +	u32 insn;
> +
> +	/*
[ ... ]
> +	 */
> +	BUG_ON(!val || width > 32 || (GENMASK(width - 1, 0) !=3D val));

[Severity: Medium]
Does evaluating __fls(val) before the BUG_ON(!val) check invoke undefined
behavior if val is 0?

Looking at __fls(), it uses __builtin_clzl(word) which is undefined when
the argument is 0:

include/asm-generic/bitops/builtin-__fls.h:__fls() {
    return (sizeof(word) * 8) - 1 - __builtin_clzl(word);
}

Could the compiler use Value Range Propagation to assume val is non-zero
due to the __fls() call, and silently optimize away the !val safety guard?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630045531.3939=
-1-kprateek.nayak@amd.com?part=3D3

