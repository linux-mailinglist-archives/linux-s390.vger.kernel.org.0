Return-Path: <linux-s390+bounces-22149-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GdSXH8sGVWpfjAAAu9opvQ
	(envelope-from <linux-s390+bounces-22149-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 17:39:55 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B6F74D27C
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 17:39:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KadTou72;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22149-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-22149-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96AFB3027B5D
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 15:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559703BF676;
	Mon, 13 Jul 2026 15:30:02 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283E63914E0;
	Mon, 13 Jul 2026 15:30:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956602; cv=none; b=s/Wlb3f/+t4AAotTJagwayiAv6/J3Q1mpZ9jVtjYzkG8cUygVTnlGLCJ/AKaUbF90G04gG+dkpdokPBKzvklcRiD3nuJ5fv/Eu45V9I7pwODTGl9c6asuNHTJbT/3DSwEPiXhoM4uGbZ4u2ZrjegYEerjuZ9b94tmsqC12pn//A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956602; c=relaxed/simple;
	bh=oy/Tqq4XcTBCulcsFZWd773SuCRHvJBHsBVHHqAIv6k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DAdgub/uyo+tnt+K5BKA7cDyNVPbakwSuNlje3mPpcCN1QpVZzBLWRkSaoN8aEugfgfiZzTeEMgZVcR2YfUlpUySptB2oC0sSEyhTGliqsam1UXTq99TXOcLIbzbrx93/Sz3+SPrDiFiwJ3m9SUF+2prY9O9Qz4O1bsSWYIgRxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KadTou72; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5C71F000E9;
	Mon, 13 Jul 2026 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783956601;
	bh=MJOO1NWY46zrORn66Zmaqh5yEBKXn2Gn2/JA88xTPz4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KadTou72bINTMt+/RP7yq4Ak0pbpNLJEIXIBVMvWZH8ZbmhSW9xlJFwzT+hKAq/jj
	 b+DH9ermfzfh/WGk6CfzFGl/JvSRKn8UfEWumnihAN9BBF0hBOD9l4sXRjhVBfGUv3
	 oaWkQ47S+lDwOP9MzMq+HqrL9MS17lr/kB2MgwtBs7o29vkcEet55eZ/+sDthjopnb
	 WRf3ya7+F7VeQOMzh435GXtH0JNeHHbKJ/tpgWoKoPZujHjrxWf0vR5J21XHr+PZ/A
	 aFJj3rcLt0z4veJPcLbYRIxyoo2UwTaVutB8cLy3nAq6GqxhN4YHOgiDJy681iNrVy
	 dBuwo3QrsZajQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] KVM: s390: ucontrol: Add missing locking around
 gmap_remove_child()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260713150857.269954-6-imbrenda@linux.ibm.com>
References: <20260713150857.269954-1-imbrenda@linux.ibm.com>
 <20260713150857.269954-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 15:29:59 +0000
Message-Id: <20260713153000.AB5C71F000E9@smtp.kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22149-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:kvm@vger.kernel.org,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22B6F74D27C

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The patch introduces a scoped_guard() into a function that already =
uses goto-based error handling.

Pre-existing issues:
- [High] Missing cleanup for vcpu->arch.mc in the error paths of kvm_arch_v=
cpu_create().
- [High] Preexisting memory leak of vcpu->arch.pv.stor_base and sida_addr i=
n kvm_s390_pv_create_cpu() on UV call failure.
--

--- Patch [5]: [PATCH v2 5/7] KVM: s390: ucontrol: Add missing locking arou=
nd gmap_remove_child() ---
commit 08ba9ce959b1a049a33ef520bb8230d16cec1943
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: ucontrol: Add missing locking around gmap_remove_child()

This commit adds missing locking for the parent gmap's children_lock when
calling gmap_remove_child(). This fixes an issue in the error handling path
of kvm_arch_vcpu_create() for UCONTROL guests.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -3866,7 +3866,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
> =20
>  out_ucontrol_uninit:
>  	if (kvm_is_ucontrol(vcpu->kvm)) {
> -		gmap_remove_child(vcpu->arch.gmap);
> +		scoped_guard(spinlock, &vcpu->kvm->arch.gmap->children_lock)
> +			gmap_remove_child(vcpu->arch.gmap);

[Severity: Low]
Does this mix scoped_guard() with goto-based error handling?

The cleanup guidelines suggest converting all resources that need a goto=20
cleanup to scope-based cleanup, or converting none of them, rather than=20
mixing them in the same function.

>  		vcpu->arch.gmap =3D gmap_put(vcpu->arch.gmap);
>  	}
>  out_free_sie_block:
>  	free_page((unsigned long)(vcpu->arch.sie_block));
>  	return rc;
>  }

[Severity: High]
This is a pre-existing issue, but does this error path leak vcpu->arch.mc?

When kvm_arch_vcpu_create() allocates vcpu->arch.mc via=20
kvm_s390_new_mmu_cache(), does the out_free_sie_block path miss freeing it=
=20
before returning rc?=20

Since kvm_arch_vcpu_destroy() isn't invoked on creation failure, it seems=20
vcpu->arch.mc might remain permanently allocated.


[Severity: High]
This is a pre-existing issue, but does kvm_s390_pv_create_cpu() leak=20
vcpu->arch.pv.stor_base and sida_addr if uv_call() fails?

In arch/s390/kvm/pv.c:kvm_s390_pv_create_cpu():

    if (cc) {
        ...
        kvm_s390_pv_destroy_cpu(vcpu, &dummy, &dummy);
        return -EIO;
    }

If this fails, it calls kvm_s390_pv_destroy_cpu():

arch/s390/kvm/pv.c:kvm_s390_pv_destroy_cpu():

    if (!kvm_s390_pv_cpu_get_handle(vcpu))
        return 0;

Since vcpu->arch.pv.handle is only populated on the uv_call() success path,=
=20
will this return early and skip cleaning up stor_base and sida_addr?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713150857.2699=
54-1-imbrenda@linux.ibm.com?part=3D5

