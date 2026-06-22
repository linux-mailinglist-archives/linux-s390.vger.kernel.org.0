Return-Path: <linux-s390+bounces-21099-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TSVMEmBiOWqOrQcAu9opvQ
	(envelope-from <linux-s390+bounces-21099-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 18:27:12 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 931916B11EA
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 18:27:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QU2Nekfx;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21099-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21099-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35E59302AC36
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 16:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B588315D46;
	Mon, 22 Jun 2026 16:24:47 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9CB2F5485;
	Mon, 22 Jun 2026 16:24:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145487; cv=none; b=dt/QzpOM5BZZ9xqx1nFIhhqRMGKJiX3x0fvCPaHCkWO8/C3QAYg6wUlhC2j8pycRP3jY1M2y024dT5QGGDGjWwsyG7iQD9vC1bdDi6choT40Tv1bHqEKu1aa5kiDwWMVgsSGc9BtcKkxiuuqoJFfl0N44maZTcKLzH7H/x6B4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145487; c=relaxed/simple;
	bh=TphRlSpnC7iTiy86k+vqLZCVIkexI2eq04SfvbVl190=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cjPiS61QPXuZQlUWHqumeqr1/JrOQU0QDlnhifKEUcHbrOl0Hdhje6PXpSLWDGfDudPOqxN36Hvph3m4I3T7A6cW6uDKlyS8TMKYjjxzLyF6YdmIPIxHCQ9MlQ7oKk//ADSE3MrIcMI5vGUX2oIsBgQ/MsLH8HMUgl2IOE+FtSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU2Nekfx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA1B1F000E9;
	Mon, 22 Jun 2026 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782145486;
	bh=jRdgpmhjGnidM6+bAon764FnXLlnWA3Tnuk3cBYGITk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QU2NekfxvuAguZCSBGO6FbFDrUgIJ/1vuJIpFfnsGAaQ6fUsj1+0WErxzmjY2WI3c
	 sktUvi41Hg1pkQ/G7CuUsBdu8vqHoIMuBL4WtVP/H/hjPM3yDTuL6iaq1s86+mw3HU
	 pTIODJmgI69YyaSnEjFm4/mkP31oEDpNvU7WTr3yN9NouTIDMNMgbl2YrjjDwo30Gh
	 A9YoTT7GlC4vETH8ZRWctODrE0czBbXQPMvoSH6FIenhC4BxtHeMqeNvHWyl9jXQHP
	 C7NCYiSPFw235AUP8Rq55tz/SmbPg3nI7EaMOLppnc/4hT4bFEwUzEe9xMGMM8QgFW
	 Thapx+ilyzd7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/9] KVM: s390: Fix code typo in
 gmap_protect_asce_top_level()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260622160739.202044-5-imbrenda@linux.ibm.com>
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
 <20260622160739.202044-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 16:24:45 +0000
Message-Id: <20260622162445.EEA1B1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21099-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,asce.tl:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 931916B11EA

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting ABBA deadlock between KVM `mmu_lock` and gmap `childre=
n_lock`.
--

commit d8dbe6f4197c6a65f9a60ab673cf05c59e3ecf7b
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix code typo in gmap_protect_asce_top_level()

This commit fixes a typo in gmap_protect_asce_top_level() where asce.dt
was used instead of asce.tl for the length passed to
kvm_s390_get_guest_pages().

> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
> index 3192f610f6962..e6e786811db86 100644
> --- a/arch/s390/kvm/gmap.c
> +++ b/arch/s390/kvm/gmap.c
> @@ -1262,7 +1262,7 @@ static int gmap_protect_asce_top_level(struct kvm_s=
390_mmu_cache *mc, struct gma
>  	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
>  	smp_rmb();
> =20
> -	rc =3D kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.dt =
+ 1, false);
> +	rc =3D kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.tl =
+ 1, false);
>  	if (rc > 0)
>  		rc =3D -EFAULT;
>  	if (!rc)
>  		rc =3D _gmap_protect_asce_top_level(mc, sg, &context);

[Severity: High]
This isn't a bug introduced by this patch, but is there a preexisting ABBA
deadlock between parent->children_lock and parent->kvm->mmu_lock here?

In __gmap_protect_asce_top_level() (which handles setting up non-real-space
shadows), the code acquires sg->kvm->mmu_lock first, and then acquires
parent->children_lock:

arch/s390/kvm/gmap.c:__gmap_protect_asce_top_level() {
    guard(write_lock)(&sg->kvm->mmu_lock);
    ...
    scoped_guard(spinlock, &parent->children_lock) {
        ...
}

However, in gmap_create_shadow(), the lock ordering is reversed. It acquires
parent->children_lock first and then acquires parent->kvm->mmu_lock when
creating a real-space shadow:

arch/s390/kvm/gmap.c:gmap_create_shadow() {
    scoped_guard(spinlock, &parent->children_lock) {
        ...
        if (sg->guest_asce.r) {
            scoped_guard(write_lock, &parent->kvm->mmu_lock)
                ...
}

If two vCPUs of the same VM concurrently attempt to create a real-space
nested shadow and a regular nested shadow, could this lead to a soft lockup?

>  	if (rc)
>  		kvm_s390_release_faultin_array(sg->kvm, context.f, true);
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622160739.2020=
44-1-imbrenda@linux.ibm.com?part=3D4

