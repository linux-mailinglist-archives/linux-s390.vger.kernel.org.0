Return-Path: <linux-s390+bounces-21611-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3RlKNQl6S2peSAEAu9opvQ
	(envelope-from <linux-s390+bounces-21611-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 11:48:57 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A93670EC4A
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 11:48:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nIdec6By;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21611-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21611-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 985A3303AF34
	for <lists+linux-s390@lfdr.de>; Mon,  6 Jul 2026 09:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DC142883E;
	Mon,  6 Jul 2026 09:26:30 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D2532C94A;
	Mon,  6 Jul 2026 09:26:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329989; cv=none; b=NvNrq/jHJMfCe/GWo4mhL2ZXYaC1oIS3gZaeQS7vAsimBTuWxQQRP8TsRBWko7NKQd+oVG9TlcvaoAiUqyfUjWp/IyP7VqOU1an6Fku/6DZqL6RihDdoPABn8jqYFybyMlI+4UnKl9LwNiGrlqFwUerL1FeMejEOw1TwphBMY5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329989; c=relaxed/simple;
	bh=W1L5/xADjfLEDUrZY7xWNv00tdP71VTWASg15CmARBY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bGohCqO9mm3Y5JPvaZtWH73LKqaH1C5T9QC2HnjscqoOQ4rWH8NhqOnhCilMUd8IQyP9jBL5BYTIJfxdpObtXloimy4MHUq08srTPsPcm+jYvl1MSLVGEPuaz2XbZafCMJC7RyPBA4HVWutDKcoJSbtP9rcAKNmfFGn8FQzcfsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIdec6By; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D091F000E9;
	Mon,  6 Jul 2026 09:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783329985;
	bh=S5ZxiwH96SRcePOT75jj/ZtITr285w9dQ+mCs0bmlWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nIdec6ByzX0HKbxSV7M4qnZuI6Lzxq7n0IwlfRia96Bw1QMfk9HQFu9cpPeF5rbyN
	 C+m2/c2DYlY4UsOaBUuEdJxtzX5OC5Bv1yGWHjCt3ISONOjc2xASBIK9dtxxZ6ALpu
	 dILGkVvRORfbddm5SWaQIhZ3xxBAe4flWFYhzjgKkQhHLVVx9jM5kkUF2Eke/AXRtH
	 Lw+5AJZ61H7f/t8WBbLlsEqGaTzZKK8UBf1EkhQpLlsjaAGVTv0E3OVnw+wxvQ2nMB
	 TP0Qa/ulkzL42JooR5/flSu2EXoPX0xKmbNzI02z9uvM+dcX7p3B6dy758D0J76sK/
	 pBDVP3ZNJBP1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/27] KVM: s390: Use arm64 code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260706085229.979525-13-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-13-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:26:23 +0000
Message-Id: <20260706092624.A8D091F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21611-lists,linux-s390=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:seiden@linux.ibm.com,m:linux-s390@vger.kernel.org,m:gor@linux.ibm.com,m:kvmarm@lists.linux.dev,m:oupton@kernel.org,m:kvm@vger.kernel.org,m:hca@linux.ibm.com,m:maz@kernel.org,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A93670EC4A

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] Sharing C code between architectures via textual extraction using a=
wk and architecture-specific markers is highly irregular and fragile.
- [Low] The `#undef __INCL_GEN_ARM_FILE` directive emitted by the awk scrip=
t is placed inside the `#ifndef` block, rendering it unreachable and useles=
s.
- [Low] The awk script silently succeeds and extracts the entire remainder =
of the file if an end marker is missing.
--

commit 984c79bce287186aa6e2e94e2238ab50e9164186
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: Use arm64 code

This commit adds the infrastructure to extract KVM/arm64 code into s390 at
build time. It introduces an awk script that detects ARM64_S390_COMMON mark=
ers
and extracts marked sections into an .inc file for consumption.

> diff --git a/arch/s390/kvm/arm64/copy-arm64c.awk b/arch/s390/kvm/arm64/co=
py-arm64c.awk
> new file mode 100644
> index 0000000000000..45d9c7034c177
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/copy-arm64c.awk
> @@ -0,0 +1,69 @@
> +#!/usr/bin/awk -f
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Extract marked sections from ARM64 C files for sharing with s390 KVM
> +#
> +# Usage: share-arm64-cfile.awk <input_file>
> +#
> +# Extracts all sections between start/end markers. If no markers found, =
signals failure.

[Severity: Low]
Is this code sharing approach via build-time regex extraction the intended
long-term design? Sharing C code between architectures by using awk to extr=
act
textual blocks based on markers seems unusual and could obscure dependencie=
s or
complicate maintenance compared to traditional code sharing via common file=
s or
headers.

[ ... ]

> +	print "#ifndef __INCL_GEN_ARM_FILE"
> +	print "#error included .inc file w/o proper guard definition"
> +	print "#undef __INCL_GEN_ARM_FILE"
> +	print "#endif /* __INCL_GEN_ARM_FILE */"

[Severity: Low]
Is the placement of the #undef directive correct here?

If a caller correctly defines __INCL_GEN_ARM_FILE before inclusion, the
preprocessor evaluates the #ifndef to false and skips the entire block. If =
it
is not defined, the #error halts compilation. In either case, the #undef in=
side
the #ifndef block appears to be unreachable.

[ ... ]

> +copying {
> +	gsub(/#include <asm\//, "#include <arm64/")
> +	gsub(/#include <uapi\/asm\//, "#include <uapi/arm64/")
> +	print
> +	next
> +}
> +
> +END {
> +	exit !found_marker
> +}

[Severity: Low]
Does this END block handle a missing end marker properly?

If an ARM64_S390_COMMON end marker is accidentally omitted or malformed in =
the
source file, the awk script leaves the copying flag set to 1 and dumps the
remainder of the file. Since found_marker is true, the script will exit with
status 0 (success). Could we check if copying =3D=3D 0 to catch unbalanced =
markers
during extraction instead of having it fail later during C compilation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706085229.9795=
25-1-seiden@linux.ibm.com?part=3D12

