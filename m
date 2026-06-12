Return-Path: <linux-s390+bounces-20800-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /uqaMKn/K2onJQQAu9opvQ
	(envelope-from <linux-s390+bounces-20800-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 12 Jun 2026 14:46:33 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1750F67975F
	for <lists+linux-s390@lfdr.de>; Fri, 12 Jun 2026 14:46:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MAf9Seln;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20800-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20800-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBD4831317A6
	for <lists+linux-s390@lfdr.de>; Fri, 12 Jun 2026 12:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4CE3E5A3A;
	Fri, 12 Jun 2026 12:42:42 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240FE3E2ABB;
	Fri, 12 Jun 2026 12:42:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268161; cv=none; b=R+5Mjzsqv+u5L3niy5bOZxgn35c7Fun1DKzjEhnVgrmMluIoH3N+UUO4cRRN1nbznuUZcqriv6q7Bs/rHtb9k1w7D4YwKoHGkks3BDXyOncpFXufPvd4BM0kRoGBjZkjZe/sLZSKX+zey9vfjXDG2XiVCAaQyfD1lpTGI+JdgJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268161; c=relaxed/simple;
	bh=9DiUdu9Cevk6g9+QHdS2/l+7K81+YdfJnDkSVSXZMfg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MmS6+ZiYINfPbrVJiWb1XHEhhRGc/L8oN++6887SdLzPiYw8/W1oXfnMqoBCTUHeige4ET05nVJd/jdf98CjeiLFy6quV1kIUQ2TBqsVSl5gxnPPsexbCR3SMpa4v9fRL+F8gktp8F/GyOnGDMPFO6S/pxWyCyn01ja7i8HbqcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAf9Seln; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E68B1F00A3A;
	Fri, 12 Jun 2026 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781268159;
	bh=RgL8Y3oOAr8EaxDC1KuoLqUI2TNKEcYOZozUX58UI68=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MAf9Selnw6lXrRzRwD//GCOKystzG943ty9yTN70p9W+ZLM7e+BfPwfWsmAU6YgDC
	 VLw8enCJQy/bi4N6CC5SjHD9mp8HkgLK/+PQgNKuu49ZbSDUg/CcOAFAFFv9OnfyTJ
	 BicI8cGMjtADcRoL2ouHDrQfI6p6JMMRsCbCi/VRb+GQ+Ywfyd6ZSX+rEqUJKlYUix
	 HECNZWBhp5Hql1GAuf59Zlwlm81D1fM+hhMun0c6iBK2yS2LD6DliCGIC7Oc7vlDQk
	 WNsbJuQChucn6ghx2dbUPVLPZ07Yp8V0ippA+jPImK8xYJt1Yp3ZF25LHc4oHRTqMd
	 AjNkTQwRKrwJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] KVM: s390: vsie: Implement ASTFLEIE facility 2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260612-vsie-alter-stfle-fac-v4-4-74f0e1559929@linux.ibm.com>
References: <20260612-vsie-alter-stfle-fac-v4-4-74f0e1559929@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 12:42:38 +0000
Message-Id: <20260612124239.6E68B1F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-20800-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:schlameuss@linux.ibm.com,m:hca@linux.ibm.com,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,s:lists@lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1750F67975F

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect offset comment for `fac` array in `struct vsie_page`.
--

commit 533d12a005c16677069ec80d3450892c247155e9
Author: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

KVM: s390: vsie: Implement ASTFLEIE facility 2

This commit implements shadowing of the format-2 facility list when
running in VSIE, introducing ASTFLEIE2 support.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 2ea3bbaf568e5..4c20bd787b8b2 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -65,9 +65,9 @@ struct vsie_page {
>  	gpa_t scb_gpa;				/* 0x0258 */
>  	/* the shadow gmap in use by the vsie_page */
>  	struct gmap_cache gmap_cache;		/* 0x0260 */
> -	__u8 reserved[0x0700 - 0x0278];		/* 0x0278 */
> -	struct kvm_s390_crypto_cb crycb;	/* 0x0700 */
> -	__u8 fac[S390_ARCH_FAC_LIST_SIZE_BYTE];	/* 0x0800 */
> +	__u8 reserved[0x06f8 - 0x0278];		/* 0x0278 */
> +	struct kvm_s390_crypto_cb crycb;	/* 0x06f8 */
> +	__u8 fac[8 + S390_ARCH_FAC_LIST_SIZE_BYTE];/* 0x0800 */

[Severity: Low]
This isn't a bug, but the comment indicating the offset for the fac
array appears to be incorrect after this layout change.

Since crycb was shifted back 8 bytes to start at 0x06f8, and=20
struct kvm_s390_crypto_cb is 256 bytes in size (0x0100), the fac array=20
now starts at 0x07f8.=20

Should this comment be updated to /* 0x07f8 */ to reflect the new offset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-vsie-alter=
-stfle-fac-v4-0-74f0e1559929@linux.ibm.com?part=3D4

