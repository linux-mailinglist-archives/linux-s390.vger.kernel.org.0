Return-Path: <linux-s390+bounces-22108-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SqmsAc+nVGqiowMAu9opvQ
	(envelope-from <linux-s390+bounces-22108-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 10:54:39 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3724748FBE
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 10:54:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MHwGSzwp;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22108-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22108-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A004F300BD74
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 08:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6707D3CEB99;
	Mon, 13 Jul 2026 08:47:36 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC3D3CF05E;
	Mon, 13 Jul 2026 08:47:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932456; cv=none; b=kyeJp40zfwXo15k6TwmkM2HWIQ8vn/UK3QjUNNeHWnmQc5Rz6Cipy2VMFFlETO0rHUTPx6o6tRBeKqN3Xj8ZJZyz8B3ZyEHj7jiCm+ExFtNyPPQ4+kauiluKiOuCx5OgZep4M3bN+VEfb/T/xPCFx1H2jlcsnBrHJd7Dm7XfRJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932456; c=relaxed/simple;
	bh=HxpbuDBUCW0CPcuCj0jBPwJqeuKQ59rjkxl5o+sEmXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HQOIvWZs/Zkik4sJxBTOou2NI+kYKG+weJZEnwYgQt1vjqX6UD11lLNOqd/GZAX+RDBqoIgLv5xbna6lfojP/BEH7YDHcJrRjMzJ6N4YTOHm852tq2hYF1H0ctfcPJXsphtpxE2NOWu9zkIJiNCAy2WeS6vgn9EgJ+uP4W6rEgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHwGSzwp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65111F000E9;
	Mon, 13 Jul 2026 08:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783932452;
	bh=fEEMYKLgZySn/ysi4H2GfXtjcjLXq/b2ydjGJYWEnCE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MHwGSzwpruZWx0jpXfqHydfCpitlyFORAqX8VdQybCdvAhxjE1XJ6yYzVPtSANd4D
	 nmnjkHtwGRxmwgxfoE6OeFea0buQplQD7wfbPUnMiYxEFqGHjJbNbyM0GK/IW8Ryrz
	 y+4n1Rr6/w7P+tbyDCLVMebpuLn2YWowhPhMU/7anUsy7RWND5VdSmoOHNgqOr0Ubk
	 JI3F78kwpoHFkM+C9zEb8Nkp8Y86QJFAKALwD6lYgrIDzQyvRDqPBC2fHmCBtJh8sm
	 8u+UsL/pfYuOEKGDN4u82TI4691JDDsBMiXL6f5ZtY6W2yjOsUeUxs18XeSe1y8QMl
	 ibkR8Gd1zgt8A==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 5/5] KVM: s390: pci: Fix handling of AIF enable
 without AISB
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@de.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260713083007.65863-6-borntraeger@de.ibm.com>
References: <20260713083007.65863-1-borntraeger@de.ibm.com>
 <20260713083007.65863-6-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 08:47:31 +0000
Message-Id: <20260713084731.A65111F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22108-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:borntraeger@de.ibm.com,m:kvm@vger.kernel.org,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3724748FBE

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unchecked return value from `airq_iv_create()` causes a host k=
ernel panic in `kvm_zpci_set_airq()`.
- [Critical] Insufficient page pinning for the Adapter Interrupt Bit Vector=
 (AIBV) allows hardware DMA to write beyond the pinned page into arbitrary =
host memory.
- [Critical] The `set_bit_inv()` call in the interrupt forwarding path can =
write outside the bounds of the single pinned AISB page due to an unvalidat=
ed page offset and bit index.
- [High] Repeated KVM_S390_ZPCIOP_REG_AEN ioctl calls unconditionally overw=
rite existing AIF allocations, causing unbounded memory and resource exhaus=
tion.
- [High] Error paths in `kvm_s390_pci_aif_enable()` fail to update `rc`, er=
roneously returning success to userspace when enabling fails.
- [High] Early error paths in `kvm_s390_pci_aif_enable()` fail to rollback =
successfully allocated resources like GISC registrations and memory quotas.
- [High] `account_mem()` and `unaccount_mem()` perpetually leak `struct use=
r_struct` reference counts.
- [High] `unaccount_mem()` blindly uses `current_user()` and `current->mm`,=
 risking quota corruption when invoked asynchronously or from a different c=
ontext.
--

--- Patch [1]: [GIT PULL 5/5] KVM: s390: pci: Fix handling of AIF enable wi=
thout AISB ---
commit e5fbf43dd647bd07ede442137b445e6821685004
Author: Matthew Rosato <mjrosato@linux.ibm.com>
KVM: s390: pci: Fix handling of AIF enable without AISB

When a guest seeks to register IRQs without a summary bit specified, ensure
that the associated GAITE stores 0 for the guest AISB location instead of an
invalid physical address.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 5b075c38998e3..dc748cde4703b 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -300,9 +300,14 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *=
zdev, struct zpci_fib *fib,
> =20
>  	gaite->gisc =3D fib->fmt0.isc;
>  	gaite->count++;
> -	gaite->aisbo =3D fib->fmt0.aisbo;
> -	gaite->aisb =3D virt_to_phys(page_address(aisb_page) + (fib->fmt0.aisb &
> -							      ~PAGE_MASK));
> +	if (fib->fmt0.sum =3D=3D 1) {
> +		gaite->aisbo =3D fib->fmt0.aisbo;
> +		gaite->aisb =3D virt_to_phys(page_address(aisb_page) +
> +					   (fib->fmt0.aisb & ~PAGE_MASK));

[Severity: Critical]
This is a pre-existing issue, but does this setup allow for an out-of-bounds
write during interrupt forwarding?

If a guest provides a summary bit address near a page boundary and a large
summary bit offset (up to 255), we might exceed the bounds of the single
pinned page. When a host interrupt arrives, aen_host_forward() executes:

    set_bit_inv(gaite->aisbo, phys_to_virt(gaite->aisb));

Since set_bit_inv() modifies a 64-bit word, could this read and write up to
31 bytes into the adjacent, unpinned virtual page in the host linear mappin=
g?

> +	} else {
> +		gaite->aisbo =3D 0;
> +		gaite->aisb =3D 0;
> +	}
>  	aift->kzdev[zdev->aisb] =3D zdev->kzdev;
>  	spin_unlock_irq(&aift->gait_lock);

[Severity: High]
This is a pre-existing issue, but does repeated invocation of the
KVM_S390_ZPCIOP_REG_AEN ioctl leak AIF allocations?

Looking at kvm_s390_pci_aif_enable(), we allocate and assign new resources
to zdev without checking for or freeing prior state:

    zdev->aisb =3D bit; /* store the summary bit number */
    zdev->aibv =3D airq_iv_create(...);

Could a guest or malicious userspace repeatedly invoke the ioctl to cause
unbounded memory exhaustion of pinned pages and airq_iv structures?

[Severity: High]
This is a pre-existing issue, but do the error paths in
kvm_s390_pci_aif_enable() accidentally return success?

If account_mem() or airq_iv_alloc_bit() fail, the code jumps to cleanup lab=
els:

    if (account_mem(pcount))
        goto unpin2;
    ...
    if (bit =3D=3D -1UL)
        goto unlock;

Since rc remains initialized to 0, does this erroneously return success to
userspace when enabling actually failed?

[Severity: High]
This is a pre-existing issue, but do the early error paths in
kvm_s390_pci_aif_enable() leak resources?

If pin_user_pages_fast(), account_mem(), or airq_iv_alloc_bit() fail, we
jump to the cleanup labels:

    unlock:
        mutex_unlock(&aift->aift_lock);
    unpin2:
        if (fib->fmt0.sum =3D=3D 1)
            unpin_user_page(aisb_page);
    unpin1:
        unpin_user_page(aibv_page);
    out:
        return rc;

Does this miss calling kvm_s390_gisc_unregister() and unaccount_mem(),
leaving GISC registrations and locked_vm quotas permanently leaked?

[Severity: High]
This is a pre-existing issue, but do account_mem() and unaccount_mem() leak
struct user_struct reference counts?

Both functions increment the user refcount via get_uid():

    struct user_struct *user =3D get_uid(current_user());

However, free_uid() is never called in these functions. Could this lead to a
persistent memory leak and potential refcount overflow?

[Severity: High]
This is a pre-existing issue, but does unaccount_mem() risk quota corruption
by blindly using current_user() and current->mm?

When unaccount_mem() is called:

    struct user_struct *user =3D get_uid(current_user());
    if (user)
        atomic_long_sub(nr_pages, &user->locked_vm);

If this is invoked asynchronously during VFIO device closure (e.g., via fput
in a system workqueue), the current user will resolve to the worker thread.
Does this mean the original user's quota is never restored, and an unrelated
system worker's quota is incorrectly reduced?

[Severity: Critical]
This is a pre-existing issue, but does an unchecked return value from
airq_iv_create() risk a host kernel panic?

In kvm_s390_pci_aif_enable():

    zdev->aibv =3D airq_iv_create(msi_vecs, ...);

If airq_iv_create() returns NULL due to memory pressure, this is assigned to
zdev->aibv. Immediately after, kvm_zpci_set_airq() is called, which execute=
s:

    fib.fmt0.noi =3D airq_iv_end(zdev->aibv);

Does airq_iv_end() unconditionally dereference the potentially NULL pointer,
allowing unprivileged userspace or a guest to trigger a panic?

[Severity: Critical]
This is a pre-existing issue, but is the page pinning for the Adapter
Interrupt Bit Vector (AIBV) insufficient?

In kvm_s390_pci_aif_enable(), only a single page is pinned:

    npages =3D pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM, page=
s);

The physical address passed to hardware contains the unvalidated offset:

    gaddr =3D page_to_phys(aibv_page) + (fib->fmt0.aibv & ~PAGE_MASK);

If a guest specifies an AIBV offset close to the end of the page, could the
hardware DMA engine write beyond the pinned page boundary and corrupt
adjacent host memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713083007.6586=
3-6-borntraeger@de.ibm.com?part=3D1

