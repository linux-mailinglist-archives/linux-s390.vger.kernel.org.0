Return-Path: <linux-s390+bounces-21961-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7jukLLm+T2rXngIAu9opvQ
	(envelope-from <linux-s390+bounces-21961-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 09 Jul 2026 17:31:05 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C44EC732EBF
	for <lists+linux-s390@lfdr.de>; Thu, 09 Jul 2026 17:31:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HtdHyGQQ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21961-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21961-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6EED3094AB1
	for <lists+linux-s390@lfdr.de>; Thu,  9 Jul 2026 15:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEC236A37C;
	Thu,  9 Jul 2026 15:24:23 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE99366DA5;
	Thu,  9 Jul 2026 15:24:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610663; cv=none; b=GaPXktF/VRE7Z37DfldGDWksN8L6aZBOp2qOFRltx1Owmyfe381mnFAZ+ztqGWLHNvHgcxVAdwcAE+X6h1QQJ05ybTKouPgTBknpo6IaCG68xYaO4BM3oKTN62wkSetpmBsEvUr/37+yzCEHzDKxpqIzPnw4TSe9Qf/6PqBzCKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610663; c=relaxed/simple;
	bh=QTO/KwfTKYRfQTvk8rmzU8RzBGdq1O6inmmKcEJAjyU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oVHDpTCQzk6CSvy/3PgGsBy1907440Dh6oB1/ug3soyszh35wp2nWbdTYsxXCr+upK/69Q0dGAAt+Bt5ctspwEWfaigQcJrIZcsShs79tvlmjOVq0BN0MAVp9btYjI7SJk4nDlgqW3Qnvz2CIkydz9NgA6F6yDbSzCMRY734WxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtdHyGQQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745F31F000E9;
	Thu,  9 Jul 2026 15:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783610661;
	bh=2A9Qwwc5PCGjxMwBh53S0LUspyP6EmGOYT+OrUCZmx4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HtdHyGQQEFB4EhokRb9vPQ8x5UckacL+tLDORMzEnniSkUGiv/IEhYCZvFu2oIRWG
	 GCgzUV+a1F45pmYBu+Yq9lBlrr5qcaJYtt5A441cZkXcQbKTxyxbX/8z9mLG7YhRZx
	 kdFbUzevoysXVkIkFpMUO4QadPoXlIGd67YEGwggl34jIAhCPFo7HwtBJGlXeA2WIE
	 LM6znbtKdZFoLZ3ArhNnPW9rRTTyZ55uIYpCQeo1+58sndGZSBvzYNzgXMI+/KVd2C
	 7wuKMenGyjyWNowgaL+PWXFr2Qgsc2nd+K/kc6T0P/nXlw8TINn9+a04MAjVJ2Bt5V
	 lLhBjEPdMkgEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/21] KVM: s390: vsie: Add SCAO read and write helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-4-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-4-ea9f12066408@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:24:21 +0000
Message-Id: <20260709152421.745F31F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21961-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:schlameuss@linux.ibm.com,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C44EC732EBF

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] read_scao() incorrectly truncates the 64-bit Host Physical Add=
ress (HPA) when unpinning the shadow SCB if the guest lacks the 64BSCAO fea=
ture, leading to host memory corruption and leaked pages.
--

--- Patch [4]: [PATCH 04/21] KVM: s390: vsie: Add SCAO read and write helpe=
rs ---
commit ef50a3af344aad608f5c9779f347c6f56923a4f5
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Add SCAO read and write helpers

This commit introduces helper functions to get and set the system control
area origin address from the SIE control block.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 937f9c99bc002..aa0cebece2d50 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -72,6 +72,22 @@ struct vsie_page {
> =20
>  static_assert(sizeof(struct vsie_page) =3D=3D PAGE_SIZE);
> =20
> +static unsigned long read_scao(struct kvm *kvm, struct kvm_s390_sie_bloc=
k *scb)
> +{
> +	unsigned long vsie_sca =3D READ_ONCE(scb->scaol) & ~0xfUL;
> +
> +	if (test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_64BSCAO))
> +		vsie_sca |=3D (u64)READ_ONCE(scb->scaoh) << 32;
> +
> +	return vsie_sca;
> +}
> +
> +static void write_scao(struct kvm_s390_sie_block *scb, unsigned long hpa)
> +{
> +	scb->scaoh =3D (u32)((u64)hpa >> 32);
> +	scb->scaol =3D (u32)(u64)hpa;
> +}
> +

[ ... ]

> @@ -712,12 +728,11 @@ static void unpin_blocks(struct kvm_vcpu *vcpu, str=
uct vsie_page *vsie_page)
>  	struct kvm_s390_sie_block *scb_s =3D &vsie_page->scb_s;
>  	hpa_t hpa;
> =20
> -	hpa =3D (u64) scb_s->scaoh << 32 | scb_s->scaol;
> +	hpa =3D read_scao(vcpu->kvm, scb_s);

[Severity: Critical]
Does this truncate the 64-bit Host Physical Address (HPA) when unpinning
the shadow SCB if the guest lacks the 64BSCAO feature?

When a guest is instantiated without KVM_S390_VM_CPU_FEAT_64BSCAO, KVM will
still pin the guest's SCA page to an HPA that can be > 4GB, writing the full
64-bit address to the shadow SCB via write_scao().

During unpin_blocks(), read_scao() will conditionally mask off the upper 32
bits because the guest lacks the CPU feature.

Could this cause unpin_guest_page() to receive a truncated, invalid address,
causing the host to decrement the reference count of the wrong host page and
permanently leak the originally pinned page?

>  	if (hpa) {
>  		unpin_guest_page(vcpu->kvm, vsie_page->sca_gpa, hpa);
>  		vsie_page->sca_gpa =3D 0;
> -		scb_s->scaol =3D 0;
> -		scb_s->scaoh =3D 0;
> +		write_scao(scb_s, 0);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-vsie-sigpi=
-v1-0-ea9f12066408@linux.ibm.com?part=3D4

