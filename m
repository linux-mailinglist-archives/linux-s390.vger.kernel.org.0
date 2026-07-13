Return-Path: <linux-s390+bounces-22158-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id feZeOuwLVWpsjQAAu9opvQ
	(envelope-from <linux-s390+bounces-22158-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 18:01:48 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EC874D5F3
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 18:01:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cSWDLqVa;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22158-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-22158-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74F743063EAB
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 15:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E502531B130;
	Mon, 13 Jul 2026 15:58:09 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE675286409;
	Mon, 13 Jul 2026 15:58:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958289; cv=none; b=ff+CUDJHbW8HBwI0MxIgRq8GWoq+ElvUTwZlRGMXVOqTGfilBi5NglJcbagOyJRQBD50EBL8bgxtOwwur/U2qSHeK4CrWsSJMcuOVG2V32Pc/tc2MfdcKRir/8el5IExQTQE4Cv+KQQu+6855yFotTpjqqhSGI/7xPxCvOMbtS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958289; c=relaxed/simple;
	bh=C+9/YvzBqId/u+mMybJh1+egI7DPr1leuK6RgEH/uQc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LgOIzntGkDXGVeIN2V8sSh7nuQ/GIxeGq7HezjJYVifve5j/i8MOoeJCLI2stEwqpUf2bLm1EvO1WdlRhRGk2qmJMvxaPYr966Xm9Mvvc+h6Kqkq5NJHHLCWquiCw0/Ti8LCyv5qHxwZ9RnFLJh/lLXzyl3R9C/VbxjdiVy5260=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSWDLqVa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7740D1F00A3E;
	Mon, 13 Jul 2026 15:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783958286;
	bh=7H+hSADgLrwagJlrMFBXJif9DHuRxYjYrWKpce0dBhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cSWDLqVaV8bwcRfqCfVvdSI4/cEy4zaGjymST+x+H/OMoO4lJhaXgNYs4LOnbNf4x
	 zV0MdMlt3kqU6CtGhXlybMC8l8bd9vqP0Xp+1bpQZc9KJXJX7xd8OdP3XgiusVnJ9u
	 DxoObDy+8t/BukMbRmqpmZAgvcMoMr5YFq0H9R5iad3Enyl31QCCml9pgb8JVviNkY
	 +D1dN5GSY+R64mf70j9zsftfO5xCu5nEzm+oSDeD0pEOB5ryZ5iNLNOYijuASMRsyD
	 SFu7CaKALnHc/8809j0iyCHxUDAbzMw/Z8rsJOohAzVt7VOCOVzBI9xMlyo4Q4hgTI
	 Q/7+SPmvZICqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] KVM: s390: cmma: Fix dirty tracking when
 removing memslot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260713150857.269954-5-imbrenda@linux.ibm.com>
References: <20260713150857.269954-1-imbrenda@linux.ibm.com>
 <20260713150857.269954-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 15:58:05 +0000
Message-Id: <20260713155806.7740D1F00A3E@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22158-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:agordeev@linux.ibm.com,m:kvm@vger.kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59EC874D5F3

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Data race and double-decrement of `cmma_dirty_pages` due to two-pa=
ss CMMA cleanup
--

--- Patch [4]: [PATCH v2 4/7] KVM: s390: cmma: Fix dirty tracking when remo=
ving memslot ---
commit 119121acc5129e77726627587bbb91e16dea4543
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: cmma: Fix dirty tracking when removing memslot

This patch fixes inaccurate dirty tracking during migration by appropriately
decrementing the cmma-dirty counter when a memslot is removed. It does this
by walking the page tables and decrementing the counter prior to deleting
the slot.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 9e3b8b5c6aa66..5c2408fc5a8cb 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c

[ ... ]

> @@ -5796,11 +5796,19 @@ int kvm_arch_prepare_memory_region(struct kvm *kv=
m,
>  	return 0;
>  }
> =20
> +static long cmma_d_count_pte(union pte *ptep, gfn_t gfn, gfn_t next, str=
uct dat_walk *walk)
> +{
> +	if (pgste_of(ptep)->cmma_d)
> +		atomic64_dec(walk->priv);
> +	return 0;
> +}
> +

[Severity: High]
Can this two-pass CMMA cleanup cause a double-decrement of the global count=
er?

The first pass in cmma_d_count_pte() locklessly reads cmma_d and decrements
the counter, but leaves cmma_d =3D 1.

>  void kvm_arch_commit_memory_region(struct kvm *kvm,
>  				struct kvm_memory_slot *old,
>  				const struct kvm_memory_slot *new,
>  				enum kvm_mr_change change)
>  {
> +	const struct dat_walk_ops ops =3D { .pte_entry =3D cmma_d_count_pte, };
>  	struct kvm_s390_mmu_cache *mc =3D NULL;
>  	int rc =3D 0;
> =20
> @@ -5814,6 +5822,12 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>  	}
> =20
>  	scoped_guard(write_lock, &kvm->mmu_lock) {
> +		if (kvm->arch.migration_mode && kvm->arch.use_cmma) {
> +			_dat_walk_gfn_range(old->base_gfn, old->base_gfn + old->npages,
> +					    kvm->arch.gmap->asce, &ops, DAT_WALK_IGN_HOLES,
> +					    &kvm->arch.cmma_dirty_pages);
> +		}
> +
>  		switch (change) {
>  		case KVM_MR_DELETE:
>  			rc =3D dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->=
npages);

[Severity: High]
The wide window between the first walk here (decrementing) and the second w=
alk
in dat_delete_slot() (which clears cmma_d) appears to allow a concurrent
KVM_S390_GET_CMMA_BITS ioctl to intervene.

Since the ioctl takes slots_arch_lock but not mmu_lock, could it acquire the
PGSTE lock, observe cmma_d =3D=3D 1, clear it, and decrement the
cmma_dirty_pages counter a second time for the same page?

If this happens, the counter would underflow and wrap to UINT64_MAX, causing
KVM_S390_GET_CMMA_BITS to permanently report pending dirty pages and break =
VM
live migration.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713150857.2699=
54-1-imbrenda@linux.ibm.com?part=3D4

