Return-Path: <linux-s390+bounces-21418-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9g81NqiwRGo5zAoAu9opvQ
	(envelope-from <linux-s390+bounces-21418-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 08:16:08 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F456EA264
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 08:16:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Otpl3XCv;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21418-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21418-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3EFB3018755
	for <lists+linux-s390@lfdr.de>; Wed,  1 Jul 2026 06:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC613A48E6;
	Wed,  1 Jul 2026 06:14:12 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B4386C24
	for <linux-s390@vger.kernel.org>; Wed,  1 Jul 2026 06:14:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782886452; cv=none; b=cZtEepGSk+4NqxIthjUgX4z1VEeW5HlNGI0zrhbp39+es7KQTAjl+XSXqO0H9w7/tB3YDG6kGkDaCrtYpdkWjoPq+XBKt2XOSXK9CtVzl17x47I6Tdiqj+OE6T0sXYaUjNPcR+aIumtErm0MiEdPAFVVTkF4DdJp6pgxZnGJUkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782886452; c=relaxed/simple;
	bh=TJtk39p9GeF3lodWbyOKS3asKYOKwCFMa1cAsTccJP4=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=abRWVBM0frASP7gSKTuFwSvAVcx0X5vZkyLMsJyMfjEW5peOoBPyYFsHXc0ganvS66MEEnYcKK2szqSTEePf7kECK/SA5hkJmSlSetFvxvUoDmYqwQDjCs4yOKXkE7j/eJhJ/P22u4kATExd7ub49rTMEzxYP0auoZGwk9DM2jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Otpl3XCv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B4A1F000E9;
	Wed,  1 Jul 2026 06:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782886449;
	bh=Ebanz5j1FnGHj+79A2OIMWDR9YSWGglOoGwyt+5OjeA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Otpl3XCvF8RRsmVyX3iZ3EZziP2C2N7Is1XsnKTAjdAc+ZDQghrdKHewDahgeLYKN
	 +g25oQIWzHV6ycEMzrI2ViO8XTy9JJkvhzXkavvoi5XHebxsAN89uSZK/L4uVMknLJ
	 oTX+l/6rK7qsw/75HAhlja6U6Cvo34s3c361W4oJGYj0vO6k6Qa8QBtbDvFnnWipco
	 qhdblb/R1M2KXBL6BDVy5oyiZE479iF4v+Fn5eRjqhb8N09VNOQTOY2V0prhQoEw5k
	 amnehE7vyVgpYMo2o6PC14PwWLQkh2ifUpyoufP0vvlR3rggtWZRg9bMVPKcI6RpzJ
	 Y2V0p0DxSZ+qQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Reply-To: sashiko-reviews@lists.linux.dev
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260701054926.825925-17-aneesh.kumar@kernel.org>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 06:14:08 +0000
Message-Id: <20260701061409.56B4A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	MISSING_TO(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21418-lists,linux-s390=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46F456EA264

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] dma_map_resource() fails for devices using a dma_range_map that do=
es not cover MMIO regions, as DMA_ATTR_MMIO mappings are now unconditionall=
y subjected to phys_to_dma() translation.
- [High] Peer-to-Peer DMA (MMIO) breaks on AMD SME systems because the memo=
ry encryption mask (C-bit) is erroneously applied to MMIO addresses, potent=
ially causing memory corruption.
--

commit 5904e27516915147560df0a4dd16561a829eaf9e
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED

This commit modifies dma_direct_map_phys() to select the DMA address
encoding based on DMA_ATTR_CC_SHARED. It uses phys_to_dma_unencrypted() for
decrypted mappings and phys_to_dma_encrypted() otherwise, while preventing
the swiotlb force option for several architectures' secure-guest setups.

> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index e05dc7649366a..f3fc28f352ba1 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -88,37 +88,40 @@ static inline dma_addr_t dma_direct_map_phys(struct d=
evice *dev,
>  {
>  	dma_addr_t dma_addr;
> =20
> +	/*
> +	 * For a device requiring unencrypted DMA, MMIO memory is treated
> +	 * as shared by default.
> +	 */
> +	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
> +		attrs |=3D DMA_ATTR_CC_SHARED;
> +
>  	if (is_swiotlb_force_bounce(dev)) {
> -		if (!(attrs & DMA_ATTR_CC_SHARED)) {
> -			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> -				return DMA_MAPPING_ERROR;
> +		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> +			return DMA_MAPPING_ERROR;
> =20
> -			return swiotlb_map(dev, phys, size, dir, attrs);
> -		}
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> -		return DMA_MAPPING_ERROR;
>  	}
> =20
> -	if (attrs & DMA_ATTR_MMIO) {
> -		dma_addr =3D phys;
> -		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
> -			goto err_overflow;
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> +	if (attrs & DMA_ATTR_CC_SHARED)
>  		dma_addr =3D phys_to_dma_unencrypted(dev, phys);
> +	else
> +		dma_addr =3D phys_to_dma_encrypted(dev, phys);
> +
> +	if (attrs & DMA_ATTR_MMIO) {

[Severity: High]
Will this break dma_map_resource() for devices that use a dma_range_map?

Previously, DMA_ATTR_MMIO addresses bypassed translation and directly used
dma_addr =3D phys. By routing MMIO addresses through phys_to_dma_encrypted()
or phys_to_dma_unencrypted(), they now pass through __phys_to_dma().

Since MMIO addresses do not reside in system RAM, they will be absent from
the device's dma_range_map. Doesn't this cause translate_phys_to_dma() to
return DMA_MAPPING_ERROR and fail the mapping?

[Severity: High]
On AMD SME systems, does this inadvertently apply the memory encryption
mask (C-bit) to MMIO addresses?

If a capable device performs Peer-to-Peer DMA, force_dma_unencrypted(dev)
returns false, so DMA_ATTR_CC_SHARED is not set. The MMIO address then
passes through phys_to_dma_encrypted(), which injects the C-bit via
__sme_set().

If the PCIe Root Complex receives an MMIO address with the C-bit set,
will it misroute the transaction to system RAM instead of the target PCI
BAR, potentially causing memory corruption?

>  		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
>  			goto err_overflow;
> -	} else {
> -		dma_addr =3D phys_to_dma(dev, phys);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701054926.8259=
25-1-aneesh.kumar@kernel.org?part=3D16

