Return-Path: <linux-s390+bounces-22168-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h58IBqkjVWqgkQAAu9opvQ
	(envelope-from <linux-s390+bounces-22168-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 19:43:05 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E7A74E1C7
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 19:43:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="lCbA+/my";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22168-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22168-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E6F430B90E6
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 17:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170A834CFA1;
	Mon, 13 Jul 2026 17:41:22 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFA34BA28;
	Mon, 13 Jul 2026 17:41:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964482; cv=none; b=WowbEqbo4VkaOX3mIeG87o+SHZnsfNmdYON7C484BTVWCMCIwrXd0jw1aJU3ypZG+epNrFkgVaFBRvqfgetR+yt0UrAQFtBPnYEm7A0G1K/nOudK+sEMJakx7yb6uRA8YfQU2h8zyi2ujdGFeUy/RUSEejEyWB8b5ptvTr7YUPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964482; c=relaxed/simple;
	bh=m65ijHuykVvQcdLGU7LPrILlHK7KgCN7bMM8TT4OKgg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qr0Y6dEKlqR1sbH7OU7EoJUct8WqgFKjM4gmpW2tXoUTJP6YKhXkNfqW6xAY5k1SKmwizDCpmNrmSkV83TQv68+EOGCEDnuHYJ+tib7dfIIvaA7MSXIwj/zPzbWBAe7DRjK8hiTSL5sKmjZfoHUtMvRUag9GoFCUeQVzXlHpsfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCbA+/my; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E881F000E9;
	Mon, 13 Jul 2026 17:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783964480;
	bh=QXkhjIjhnzWbA8fkJWkyRAe4U8l/Ube91BRO8U33Jy8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lCbA+/my9aJLLCsCJMivBzEQQOIPKQeB+Y+eCc5Ks0hXjhsVm1GlrZTGmlkglSL0+
	 wASvQ9qTEKqRT6D5E2yB6CUfe9xXmLyHoVPq5ITw8HN8hwhI2VPFH/wD6rFkg3AEAM
	 Vdo+70qMdDk+SyU7XnMNd7Jh1KY6vJYEhiezTWlfvaq6XQosPpV79teqn7EL4IXAkE
	 ftbQ9sL5gqcShqeupQK5jxO7OvIjRAoGYx0/dX1d43J1WhEF9wInHofagj1mTqmmxJ
	 JQ1qbbG8UWl5gka2mNTv5IwFqvGzF5R/rx97iHkqTjkKtSx7HSHS4EdTmjThohl1on
	 s4eEaYrh4wTuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/5] KVM: s390: pci: Fix refcount leak in memory
 accounting functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260713172600.1284-2-alifm@linux.ibm.com>
References: <20260713172600.1284-1-alifm@linux.ibm.com>
 <20260713172600.1284-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:41:19 +0000
Message-Id: <20260713174120.01E881F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22168-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alifm@linux.ibm.com,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9E7A74E1C7

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Incorrect object lifetime management allows RLIMIT_MEMLOCK bypass.

Pre-existing issues:
- [High] Incorrect accounting context causes memory accounting leaks and po=
tential local DoS via integer underflow.
- [High] Missing state check in `kvm_s390_pci_aif_enable()` allows maliciou=
s userspace to repeatedly register AIF, leaking memory and adapter interrup=
t bit vectors.
--

--- Patch [1]: [PATCH v1 1/5] KVM: s390: pci: Fix refcount leak in memory a=
ccounting functions ---
commit 81851b731e542e864a0b6023c4b3b8622937a3f3
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Fix refcount leak in memory accounting functions

This patch modifies account_mem() and unaccount_mem() to call free_uid()
after completing memory accounting operations. This is intended to fix a
reference count leak of the user_struct incremented by get_uid().

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 720bb58cabe2e..5bbbb1de4b5a0 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -198,25 +198,32 @@ static inline void unaccount_mem(unsigned long nr_p=
ages)

[Severity: High]
This isn't a bug introduced by this patch, but does this logic query the
current execution context for unaccounting instead of storing and using the
original user and mm structures?

If unaccount_mem() is called from a worker thread or another daemon's conte=
xt
where current->mm is NULL:

arch/s390/kvm/pci.c:unaccount_mem() {
    struct user_struct *user =3D get_uid(current_user());
    ...
}

Wouldn't this leak the original pinned_vm charge?

Additionally, if current_user() resolves to the current thread's user (like
root), could this subtract pages from root's locked_vm and cause an integer
underflow, while the original user's quota is never restored?

>  		atomic_long_sub(nr_pages, &user->locked_vm);
>  	if (current->mm)
>  		atomic64_sub(nr_pages, &current->mm->pinned_vm);
> +
> +	free_uid(user);
>  }
> =20
>  static inline int account_mem(unsigned long nr_pages)

[ ... ]

>  	do {
>  		new_pages =3D cur_pages + nr_pages;
> -		if (new_pages > page_limit)
> -			return -ENOMEM;
> +		if (new_pages > page_limit) {
> +			rc =3D -ENOMEM;
> +			goto out;
> +		}
>  	} while (!atomic_long_try_cmpxchg(&user->locked_vm, &cur_pages, new_pag=
es));
> =20
>  	atomic64_add(nr_pages, &current->mm->pinned_vm);
> =20
> -	return 0;
> +out:
> +	free_uid(user);
> +	return rc;

[Severity: High]
Does dropping the user_struct reference immediately here fail to tie the
lifetime of the user's accounting object to the duration of the memory pin?

If a user registers AIF, passes the file descriptor to a persistent daemon,
and terminates their own processes, the user_struct reference count drops to
zero and is freed.

When the user logs back in, a fresh user_struct is allocated with
locked_vm =3D 0. Could this allow a malicious user to bypass RLIMIT_MEMLOCK
and pin unbounded amounts of memory?

>  }
> =20
>  static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fi=
b *fib,

[Severity: High]
This is a pre-existing issue, but does the AIF registration path lack a sta=
te
check to verify if AIF is already enabled before proceeding with memory
pinning and vector allocations?

If userspace calls KVM_S390_ZPCIOP_REG_AEN multiple times:

arch/s390/kvm/pci.c:kvm_s390_pci_zpci_reg_aen() {
    ...
    hostflag =3D !(args->u.reg_aen.flags & KVM_S390_ZPCIOP_REGAEN_HOST);
    return kvm_s390_pci_aif_enable(zdev, &fib, hostflag);
}

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
    idx =3D srcu_read_lock(&kvm->srcu);
    hva =3D gfn_to_hva(kvm, gpa_to_gfn((gpa_t)fib->fmt0.aibv));
    ...
}

Will this blindly pin new pages, increment memory accounting, and allocate
new bit vectors, silently overwriting the old pointers in zdev?

Could this lead to a permanent leak of pinned host pages, airq_iv
allocations, and gaite entries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713172600.1284=
-1-alifm@linux.ibm.com?part=3D1

