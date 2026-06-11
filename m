Return-Path: <linux-s390+bounces-20770-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nYixFXCXKmqTtAMAu9opvQ
	(envelope-from <linux-s390+bounces-20770-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 11 Jun 2026 13:09:36 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9648F67129B
	for <lists+linux-s390@lfdr.de>; Thu, 11 Jun 2026 13:09:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZrBWLyGK;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20770-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20770-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3E613195A43
	for <lists+linux-s390@lfdr.de>; Thu, 11 Jun 2026 11:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EABD3D9025;
	Thu, 11 Jun 2026 11:06:32 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C443DA5B0;
	Thu, 11 Jun 2026 11:06:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781175992; cv=none; b=mVJ+r6Y2jGjZqeEMFHMTakK3gdrGtVv+8dGM8eEipu3gAYoV99UdPre/WM+XK8awCixip3hWs9HTvR1Ypb6ldJnursM66GBZMGxcfywhCzi2SWZGG6G29LeioXkrWgnArSM8TsEgtTGUUNVIb1KFGGACuSaS5iTJN0FnmWCMWBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781175992; c=relaxed/simple;
	bh=K55qjqO7FiMjt44aQQymgHKzft4/9sa+j6Sk5zLWf5k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hzuRd3DhdqJGfzwRr5X77FXBnN/0L4W6Jho/+p7YokIt6q0TfQYhBXSqn4+LtnDfBMN3JlOJVDJ4TrU830NiJM/ARS/afAMklQnlFjfLoS2bIB8Cbysh2msSnADL5NJduyN7NfSQg99kr7E713rwxGcuqcYjo2icFK1BI6zcAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrBWLyGK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826B01F00893;
	Thu, 11 Jun 2026 11:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781175990;
	bh=FVo3wDxRGP55Rl4s02CnONSU1P8za2nTBIlbWIPXvec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZrBWLyGK4XuRdi6hcXw9M6JO5wCwcMkXhn78IW7TWY53EDs2mpuaGfdunham3a1Nq
	 TrJlpFNJOTqecODXkELsZpt01oWIQuXdO1OyNiXrs+gcT+Zwfi4ID2CwDSIh4QBhA+
	 oxHBH+EIbuFMangnITtV4g1+lgbugDm8MP5sKBxu7jW2shX/c+sjYuYqBbMx0GEvIQ
	 qUCsFUfN7UNdt8dr0REMOZAeVop2/YzCxY4FDj4KEZq9LK0fZGlAnJHx258siHAaoN
	 W5j0MUibpHHvsrLmap8BAkzLitYB+YmSyCTzo/Ib46KYwCU8XXA/9XIVYra9peLLJY
	 SAz25CILpyIvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] KVM: s390: vsie: Fix allocation of struct
 vsie_rmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260611104850.110313-4-imbrenda@linux.ibm.com>
References: <20260611104850.110313-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 11:06:30 +0000
Message-Id: <20260611110630.826B01F00893@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-20770-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:kvm@vger.kernel.org,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,m:hca@linux.ibm.com,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 9648F67129B

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unhandled memory allocation failures in `handle_sske()` and `handl=
e_pfmf()` lead to an unkillable infinite kernel loop.
--

commit abe0e652d367e02d61446edc9873e41898b993e0
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: vsie: Fix allocation of struct vsie_rmap

This commit fixes a copy-paste error in the allocation size for struct
vsie_rmap in kvm_s390_mmu_cache_topup().

> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index 4a41c0247ffa2..a4fe664f65ee1 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c
> @@ -45,7 +45,7 @@ int kvm_s390_mmu_cache_topup(struct kvm_s390_mmu_cache =
*mc)
>  		mc->pts[mc->n_pts] =3D o;
>  	}
>  	for ( ; mc->n_rmaps < KVM_S390_MMU_CACHE_N_RMAPS; mc->n_rmaps++) {
> -		o =3D kzalloc_obj(*mc->rmaps[0], GFP_KERNEL_ACCOUNT);
> +		o =3D kzalloc_obj(struct vsie_rmap, GFP_KERNEL_ACCOUNT);
>  		if (!o)
>  			return -ENOMEM;

[Severity: High]
This is a pre-existing issue, but I noticed some callers of
kvm_s390_mmu_cache_topup() do not check its return value.

For example, looking at handle_sske() in arch/s390/kvm/priv.c:

    if (rc =3D=3D -ENOMEM) {
        kvm_s390_mmu_cache_topup(vcpu->arch.mc);
        continue;
    }

If kvm_s390_mmu_cache_topup() returns -ENOMEM due to memcg limits, does
this create an infinite loop since it immediately retries with an empty
cache and fails again?

The same pattern appears in handle_pfmf() in arch/s390/kvm/priv.c:

    if (rc =3D=3D -ENOMEM) {
        kvm_s390_mmu_cache_topup(vcpu->arch.mc);
        continue;
    }

Without a fatal_signal_pending() check in these loops, could this prevent
the host OOM killer from terminating the VM process?

>  		mc->rmaps[mc->n_rmaps] =3D o;
>  	}
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611104850.1103=
13-1-imbrenda@linux.ibm.com?part=3D3

