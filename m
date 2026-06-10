Return-Path: <linux-s390+bounces-20741-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KQ5rOiCaKWr9aQMAu9opvQ
	(envelope-from <linux-s390+bounces-20741-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 10 Jun 2026 19:08:48 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDB766BDF5
	for <lists+linux-s390@lfdr.de>; Wed, 10 Jun 2026 19:08:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VRxhYtDD;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20741-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20741-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA51030067A5
	for <lists+linux-s390@lfdr.de>; Wed, 10 Jun 2026 17:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70243469FA;
	Wed, 10 Jun 2026 17:07:45 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB5A3446CE;
	Wed, 10 Jun 2026 17:07:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111265; cv=none; b=C24TTfIqcy7TW0iZyPJcn5/oZ9NB34o1Lx4H05OlRZauKu5aOjcfEwz800ynEY+sknbKHuDs1Gp44woLo6bBGtL4H/QMo6uY873Y8HCldFKw1ISo9VWEpcLgBkUZmU7A3R/cU3UVvdacG/EmXLfpCQce4q9hA2B7Xp3SR7u47Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111265; c=relaxed/simple;
	bh=+tMhV+20FS617hyKpZgdp2hdtDKpFKb6fohfN4lgg2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J5hDD7SMzmJCbhGFuglKNp9qk+zneCnyaLg6i1DEF/ZcacLHavTvhws6SgzlBFp+hBeebHPbqVlfswVlxFiklF+JKFB8rl86Ut+38aJnYoJjgiUNNC406w3j+LMg4gpwYCmITOK0I9TG7a/8mwqInTqc32Vi8a5LYe99Lb6X+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRxhYtDD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0451F00893;
	Wed, 10 Jun 2026 17:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781111264;
	bh=j2LeRrzOWY2yEBRaEePHoU9eXhpjcrsl79XG4wDvg9U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VRxhYtDDwrKQ4s2O/o0e3zLQ+VryLjlieE0yEZf+iXXkw/5jWCO0EH4bo9nbdTFYZ
	 cafZzOJ3Pqj9mrcVagW4RdtAaq1SH3CRuacgM2yAA4iSTTU2nSeP9atQ+rDDmJ5RFd
	 xWKBO3hu450b+nRqAqLm76z0wU9JZo7dYZZTh8LFAPGrTvUAOd1k60+L0+/U1t6WHZ
	 A2CBNxlT6qF5OcM/xj4UdKx0Mrx9Bvq+r16d1EjSJkhsK78KrVUkJSPL52gthg/JJY
	 B4BvtDkX+VuQg+JU6K2687nlDeCYihhqV4n2FOU+2KCU9B6zE9Ag51zW1N8e4/j+Th
	 l+bYnKdMPw8iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] KVM: s390: vsie: Fix allocation of struct
 vsie_rmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260610165247.238366-4-imbrenda@linux.ibm.com>
References: <20260610165247.238366-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 17:07:43 +0000
Message-Id: <20260610170744.2F0451F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20741-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:kvm@vger.kernel.org,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DDB766BDF5

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Infinite loop on OOM in handle_sske() and handle_pfmf() due to ign=
ored return value.
--

commit 728611fa9ca52a1777f3dfd83064a923ef5d5bf7
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: vsie: Fix allocation of struct vsie_rmap

The allocation size for struct vsie_rmap in kvm_s390_mmu_cache_topup()
was wrong due to a copy-paste error. This patch fixes it by using the
correct size.

> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index 4a41c0247ffa2..b3931e3592b52 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c
> @@ -45,7 +45,7 @@ int kvm_s390_mmu_cache_topup(struct kvm_s390_mmu_cache =
*mc)
>  		mc->pts[mc->n_pts] =3D o;
>  	}
>  	for ( ; mc->n_rmaps < KVM_S390_MMU_CACHE_N_RMAPS; mc->n_rmaps++) {
> -		o =3D kzalloc_obj(*mc->rmaps[0], GFP_KERNEL_ACCOUNT);
> +		o =3D kzalloc(sizeof(struct vsie_rmap), GFP_KERNEL_ACCOUNT);
>  		if (!o)
>  			return -ENOMEM;
>  		mc->rmaps[mc->n_rmaps] =3D o;

[Severity: High]
This isn't a bug introduced by this patch, but since we return -ENOMEM
here on allocation failure, are the callers handling this correctly?

Looking at handle_sske() in arch/s390/kvm/priv.c:

	while (start !=3D end) {
		scoped_guard(read_lock, &vcpu->kvm->mmu_lock) {
			rc =3D dat_cond_set_storage_key(...);
		}
		if (rc > 1)
			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
		if (rc =3D=3D -ENOMEM) {
			kvm_s390_mmu_cache_topup(vcpu->arch.mc);
			continue;
		}
		if (rc < 0)
			return rc;
		start +=3D PAGE_SIZE;
	}

If dat_cond_set_storage_key() fails with -ENOMEM, we call
kvm_s390_mmu_cache_topup() and then continue the loop. Since we ignore the
return value of kvm_s390_mmu_cache_topup(), if it also fails with -ENOMEM
(e.g., under severe memory pressure or with a pending SIGKILL), the loop
will restart with an empty cache.

Can this result in an endless retry loop causing a CPU soft-lockup?

The same pattern seems to exist in handle_pfmf() in the same file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610165247.2383=
66-1-imbrenda@linux.ibm.com?part=3D3

