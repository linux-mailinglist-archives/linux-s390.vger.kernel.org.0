Return-Path: <linux-s390+bounces-22150-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iosFFMYEVWreiwAAu9opvQ
	(envelope-from <linux-s390+bounces-22150-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 17:31:18 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7DB74D103
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 17:31:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=m6Kqdtz0;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22150-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-22150-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DAA3300C0C3
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB9330D3E7;
	Mon, 13 Jul 2026 15:31:15 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174F6283FD4;
	Mon, 13 Jul 2026 15:31:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956675; cv=none; b=AbBjD55v51YgUIzoW2kZrVKGmgEe3xK/hdoRulQHPxHCqaqOXE43Y9u21ZVrvXTK5ROxRsGHz8PpBMvD61WkM8yfqNbqmd7sVBnlGFuYJ2bcsMm8K6nDp0Gk/6qdbKp0Z6HBePBQWvTvev88DvIIrB49ErvbfXHaSOkolSYy9qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956675; c=relaxed/simple;
	bh=HYEk6+1eYpDKMPI6sTrFzkkMXk5laY7EvmkzXl4g9hs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HfJIJL28LRNTqOe9je0J80YnTvhLI3kSIBu07UVGDBEah1sQtzJJ78X27ZUZpZkwQnT2FC8p015CnphZLV6Nxow6C2zNgro4E1HsjCjjQ2dacU0cg6cNg3E7iCsGu3BuaHO4OhoVSydBfwga48JLHnh4jSeL0AtpLbSoimBl6+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6Kqdtz0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625751F000E9;
	Mon, 13 Jul 2026 15:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783956673;
	bh=6pxCMIkvzyX9P5k7/qaPdywqMe93VlgTnBuaurulJcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m6Kqdtz0Rm6xM0ufbRlCYnKma0IcLCoO63gTnrB/W/HPS/iF/E1wSAFYKjSaZ8Aeg
	 7TjHdCyjUjDMOsIBteeEmhsMVs3ue2r63KzHO9bO1iGLfrfxKtPz1zFq3WyJLvWPES
	 XAqVQnd0dpiJrwi05awEJWI2ajTLDA1lZdlewtn8wFH2rD4+FdVCdHbvqVXVm7YKaV
	 F9FbrzrxQ8dKiXiwJ5D6VpBQRqavt7rLRaEODu9P//ngJUmCcr7Bl93HQcTpMXrjSA
	 /6QdN7WkqZbjVpOUnS+uCHBTejYSsCBM43bBjzQyPOeKehAbMW36ckPt7VZufoyJEU
	 RWYfRXhQUUDwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] KVM: s390: Fix race in __do_essa()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260713150857.269954-4-imbrenda@linux.ibm.com>
References: <20260713150857.269954-1-imbrenda@linux.ibm.com>
 <20260713150857.269954-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 15:31:12 +0000
Message-Id: <20260713153113.625751F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22150-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA7DB74D103

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Replacing `kvm->slots_lock` with `kvm->slots_arch_lock` removes pr=
otection for `kvm_memslots(kvm)` iteration in `kvm_s390_vm_start_migration(=
)`, leading to lockdep splats and Use-After-Free.
- [Medium] The patch updates migration ioctls and `GET_CMMA_BITS` to use `s=
lots_arch_lock`, but leaves `SET_CMMA_BITS` using `slots_lock`, breaking th=
eir mutual exclusion.
- [Medium] The commit message claims to use `kvm->slots_lock`, but the patc=
h implements the fix using `kvm->slots_arch_lock`.
--

--- Patch [3]: [PATCH v2 3/7] KVM: s390: Fix race in __do_essa() ---
commit 71095d9c71a69950c39647a27ad09d197d37fa2b
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix race in __do_essa()

This commit addresses an unlikely race condition between __do_essa() and=20
migration or cmma handlers. It intends to fix this by acquiring an addition=
al=20
lock during these operations.

> KVM: s390: Fix race in __do_essa()
>=20
> An unlikely race between __do_essa() and kvm_s390_vm_start_migration(),
> kvm_s390_vm_stop_migration(), or dat_get_cmma() was possible.
>=20
> Fix by locking kvm->slots_lock. Since this is not a hot path, the
> overhead of an additional mutex is negligible.

[Severity: Medium]
The commit message states we are locking kvm->slots_lock, but the code
below acquires kvm->slots_arch_lock. Could the commit message be updated
to match the actual implementation?

> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 9 ++++-----
>  arch/s390/kvm/priv.c     | 5 +++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 53691aaf6534c..9e3b8b5c6aa66 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1298,7 +1298,8 @@ static int kvm_s390_vm_set_migration(struct kvm *kv=
m,
>  {
>  	int res =3D -ENXIO;
> =20
> -	mutex_lock(&kvm->slots_lock);
> +	guard(mutex)(&kvm->slots_arch_lock);

[Severity: High]
By switching from slots_lock to slots_arch_lock here, does this leave the
memslots iteration in kvm_s390_vm_start_migration() unprotected?

When kvm_s390_vm_start_migration() executes, it accesses the memslots:

kvm_s390_vm_start_migration() {
    ...
    slots =3D kvm_memslots(kvm);
    if (!slots || kvm_memslots_empty(slots))
        return -EINVAL;
    ...
    kvm_for_each_memslot(ms, bkt, slots) {
    ...
}

If we aren't holding kvm->slots_lock or kvm->srcu, can a concurrent memslot
update (like KVM_SET_USER_MEMORY_REGION) free the memslots array while it
is being accessed, potentially triggering a use-after-free and a lockdep
splat?

> +
>  	switch (attr->attr) {
>  	case KVM_S390_VM_MIGRATION_START:
>  		res =3D kvm_s390_vm_start_migration(kvm);

[ ... ]

> @@ -2996,9 +2996,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned i=
nt ioctl, unsigned long arg)
>  		r =3D -EFAULT;
>  		if (copy_from_user(&args, argp, sizeof(args)))
>  			break;
> -		mutex_lock(&kvm->slots_lock);
> -		r =3D kvm_s390_get_cmma_bits(kvm, &args);
> -		mutex_unlock(&kvm->slots_lock);
> +		scoped_guard(mutex, &kvm->slots_arch_lock)
> +			r =3D kvm_s390_get_cmma_bits(kvm, &args);

[Severity: Medium]
Since GET_CMMA_BITS is updated to use kvm->slots_arch_lock here, is there a
risk of breaking mutual exclusion with KVM_S390_SET_CMMA_BITS?

Looking at KVM_S390_SET_CMMA_BITS further down in kvm_arch_vm_ioctl():

case KVM_S390_SET_CMMA_BITS: {
    ...
    mutex_lock(&kvm->slots_lock);
    r =3D kvm_s390_set_cmma_bits(kvm, &args);
    mutex_unlock(&kvm->slots_lock);
    break;
}

Since they now use different locks, can KVM_S390_SET_CMMA_BITS execute
concurrently with KVM_S390_GET_CMMA_BITS and migration operations, leading
to unpredictable CMMA state transitions?

>  		if (!r) {
>  			r =3D copy_to_user(argp, &args, sizeof(args));
>  			if (r)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713150857.2699=
54-1-imbrenda@linux.ibm.com?part=3D3

