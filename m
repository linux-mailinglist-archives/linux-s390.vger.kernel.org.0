Return-Path: <linux-s390+bounces-21135-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hBPBItw+Omrd4gcAu9opvQ
	(envelope-from <linux-s390+bounces-21135-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 10:07:56 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4916B5251
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 10:07:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Hf2N1mpl;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21135-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-21135-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 947DB303B65F
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 08:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F28F3CE083;
	Tue, 23 Jun 2026 08:07:35 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21023CBE7A;
	Tue, 23 Jun 2026 08:07:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782202054; cv=none; b=o0C3YEoW/gK1uDMn4I036FU7XoKt/UzRzgCpEErLz19QqRr78VUGHkPRdhqrZ3Dpx42Dpmi20TB2Wh/rpsMzMwouogbxG1RT1wSwHeeCUEfccLQDD/3rulIclWcwjaZBccoHAZ+yPum7f1RXWfiwkX7vMxq9WCrCYyGq+2AGsnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782202054; c=relaxed/simple;
	bh=2XAL0gMopWaraxGAbsCDZS+OapLc6Tv4pMaMxKCTgh8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fikEQhWCTLVJMrnt0J8U4zRp38KBLBxFBgddEMIiRSrxjJ6ER4cItVvlZfmDYHjkzmB0tfz8Y1yxu6WMbEAAK/6QYtBNiJ6PKCwRS/5/t76VX/ITSujtDLjimwdem+iUGiQT0MjjG0SnSzykVj+ql42e5TP7kMaKSGVDNVPhLno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf2N1mpl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFAC1F000E9;
	Tue, 23 Jun 2026 08:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782202051;
	bh=3JFcyftVrm69Pf4dGDQzUkkRAmfcmJoQ5jvU/ern+Uw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hf2N1mpl7nN5nH2mfbQ8ohzPgG2NIPwC97XScsEOZnyCQU5sHH+zMyxvocKUH98Jh
	 nDh5w49z2oB1oTF8hJH6COmciNyuJIQl2pWEEKjtLBhgiyevcGRpve+K0ef1NRWvQd
	 QfjhhByI5Xgg31HO56rOew74DGlvadwQBA+XuhQtl5S5uVfh/XqW5uWoxy7r7saPGH
	 WJbRwCX+W+miW9vFJh+r9Qoq15Nax2RCcEEmxUDyXHCPemHWh7Owp7o2aOmPohueYW
	 RYJflVVNC0Vs3Y1guSa7hPKtjmi9i6xodpwagb35H9yHMx0tLkEdKQFiiEHCI+mCim
	 rvv40oh44Fo5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: s390: pci: Fix GISC refcount leak on AIF enable
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoxiang Li" <haoxiang_li2024@163.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260623075220.2022613-1-haoxiang_li2024@163.com>
References: <20260623075220.2022613-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 08:07:30 +0000
Message-Id: <20260623080730.EBFAC1F000E9@smtp.kernel.org>
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21135-lists,linux-s390=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F4916B5251

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Potential hardware out-of-bounds access due to missing page bo=
undary/alignment checks for AIBV.
- [High] Calling KVM_S390_ZPCIOP_REG_AEN multiple times permanently leaks p=
reviously allocated AIF resources because there is no check if the device i=
s already registered.
- [High] `kvm_s390_pci_aif_enable` silently returns success (0) when memory=
 accounting or `aisb` bit allocation fails, and misses `unaccount_mem` duri=
ng unwind.
- [High] The result of `airq_iv_create` is never checked for NULL, leading =
to a guaranteed kernel NULL pointer dereference on allocation failure.
- [High] Missing rollback and resource leak if the final hardware setup `kv=
m_zpci_set_airq(zdev)` fails.
- [High] `account_mem` and `unaccount_mem` leak a reference to the `user_st=
ruct` on every invocation by calling `get_uid()` without a matching `free_u=
id()`.
--

commit 20ea01515bd667a22d838d6da57d809035f9fe06
Author: Haoxiang Li <haoxiang_li2024@163.com>
Subject: KVM: s390: pci: Fix GISC refcount leak on AIF enable failure

This commit adds a missing call to kvm_s390_gisc_unregister() in the
error unwind path of kvm_s390_pci_aif_enable(). Previously, if setup
failed after registering the guest ISC, the reference was not correctly
released.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 5b075c38998e3..a9d5996590e79 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -252,7 +252,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *z=
dev, struct zpci_fib *fib,
>  	srcu_read_unlock(&kvm->srcu, idx);

[Severity: High]
This is a pre-existing issue, but is there a missing check at the start of
this function to see if the device is already registered?

If userspace repeatedly issues KVM_S390_ZPCIOP_REG_AEN, it appears this
function will blindly pin new pages and allocate new objects, overwriting
zdev->aibv and zdev->aisb without freeing the old ones. Can this leak host
kernel memory and exhaust guest ISC reference counts?

>  	if (npages < 1) {
>  		rc =3D -EIO;
> -		goto out;
> +		goto out_unregister_gisc;
>  	}
>  	aibv_page =3D pages[0];
>  	pcount++;

[Severity: Critical]
This is a pre-existing issue, but does this correctly handle unaligned
guest physical addresses?

The code immediately after this pins exactly one page:

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
    npages =3D pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM, page=
s);
    ...
}

And then computes the unaligned physical address:

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
    gaddr =3D page_to_phys(aibv_page) + (fib->fmt0.aibv & ~PAGE_MASK);
    ...
}

If the guest provides an unaligned guest physical address such that the
interrupt vector size (msi_vecs bits) spans beyond the end of that single
pinned page, will the hardware write into the adjacent unpinned physical
page?

> @@ -327,6 +327,8 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *z=
dev, struct zpci_fib *fib,

[Severity: High]
This isn't a bug introduced by this patch, but earlier in this function
do the error paths leave rc set to 0?

If account_mem() fails, it jumps to unpin2:

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
    if (account_mem(pcount))
        goto unpin2;
    ...
}

And if airq_iv_alloc_bit() fails, it jumps to unlock:

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
    if (bit =3D=3D -1UL)
        goto unlock;
    ...
}

Since rc is initialized to 0, does this falsely report success to userspace?
Also, if airq_iv_alloc_bit() fails and jumps to unlock, it seems to skip
unaccount_mem(pcount), which could leak the memory accounting.

[Severity: High]
This is a pre-existing issue, but does account_mem() leak a reference
to the user_struct?

Looking at the implementation of account_mem() and unaccount_mem():

arch/s390/kvm/pci.c:account_mem() {
    struct user_struct *user =3D get_uid(current_user());
    ...
}

It appears get_uid() increments the reference count, but there is no
matching free_uid(). Can this overflow the reference count over time?

[Severity: High]
This is a pre-existing issue, but what happens if airq_iv_create() fails
and returns a null pointer?

The result is directly assigned to zdev->aibv without validation. Later,
kvm_zpci_set_airq() is called, which dereferences it:

arch/s390/kvm/pci.c:kvm_zpci_set_airq() {
    ...
    fib.fmt0.noi =3D airq_iv_end(zdev->aibv);
    ...
}

Does this cause a null pointer dereference if the allocation fails under
memory pressure?

[Severity: High]
This is a pre-existing issue, but if kvm_zpci_set_airq() fails, does the
return path leak the resources we just allocated?

If the setup fails, the function returns rc directly:

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
    rc =3D kvm_zpci_set_airq(zdev);
    return rc;

unlock:
    ...
}

This bypasses the local error unwind labels (unlock, unpin2, unpin1,
out_unregister_gisc). Should this jump to a cleanup path to free the
pinned pages, the airq_iv structures, and unregister the guest ISC?

>  		unpin_user_page(aisb_page);
>  unpin1:
>  	unpin_user_page(aibv_page);
> +out_unregister_gisc:
> +	kvm_s390_gisc_unregister(kvm, fib->fmt0.isc);
>  out:
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623075220.2022=
613-1-haoxiang_li2024@163.com?part=3D1

