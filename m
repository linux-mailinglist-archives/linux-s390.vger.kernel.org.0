Return-Path: <linux-s390+bounces-22153-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2g0ZH9kGVWpkjAAAu9opvQ
	(envelope-from <linux-s390+bounces-22153-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 17:40:09 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CC274D290
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 17:40:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OWyz74N0;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22153-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-22153-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F9EA3096A6F
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 15:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF61931F9B7;
	Mon, 13 Jul 2026 15:33:35 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C143B31A572;
	Mon, 13 Jul 2026 15:33:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956815; cv=none; b=A6Pm26xoy+I+kZ8NdmAUAcQTqBNmIk0EqQxY1aSpvB/WajNS6hE4tWdRBlQYrr+Hrl1YiVrFYc7q9JlQY4nSfx73ItBwsDSs1hEO/VzhTn9hl0tmAOkV1i0RSH7xTcuQAybvBerhMD5UYjYh93qevHbV5QZPMgFEokFo63Y7OAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956815; c=relaxed/simple;
	bh=tkNbMVe5c/rYR4w2Af3NClkk691YYhetvcrZ0CfIlvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E+gAUqt1rHGyboND9qf89bCHiG9t90rhUo+86yFuDJxQmfrIHwQjFYRPC6+AoP7STbxXFmcBcxcwAY5+uax88Z3vqm6fCp4ppsd1HAP4jbwsdLid61p0HosKi/auw9wzzEbehgqdKus7pcjUR9BgpYyjtBj5zyOWqnkT/HNidek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWyz74N0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6C11F00AC4;
	Mon, 13 Jul 2026 15:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783956814;
	bh=04XgTq2rfwqDK3x0zzoRGeXuC5a1a5Ocha3hlm77s1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OWyz74N0HFOj8JR+WNzzNfn36MNfZ3h/u1OvMdG7RoimbQ4PXlW8RpuVUcQyiikY5
	 7TstA8XDPqsd1k1+9VmoqV+/eoa1ZipxStTC1rBePMmIIaxMF4bYZ8IUxLrXSaDgCC
	 2VWiTkDn5cMz/avlAmS3gXCQDCeTo4IhcanvYaGMTbTec7CO8rJhKJePbuB/9HCznJ
	 3I0HiApPHSHkqsbRswcaIVBliNhJCif+ZxeDAyF6NDLKosXTioEMmJ1ud+o63GNLPl
	 hx3SXTfUCLzyugZGPVSChwTgIz9/mtvrhmE6NjygShU1akbSp91CxoLHot3ZfxPMm4
	 FPHjHRls7DJeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] KVM: s390: Return -EINTR if a signal was pending
 while faulting-in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260713150857.269954-8-imbrenda@linux.ibm.com>
References: <20260713150857.269954-1-imbrenda@linux.ibm.com>
 <20260713150857.269954-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 15:33:33 +0000
Message-Id: <20260713153334.0C6C11F00AC4@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-22153-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:hca@linux.ibm.com,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4CC274D290

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Returning -EINTR from kvm_s390_faultin_gfn bypasses explicit -=
EAGAIN handling in callers, causing skipped instructions (missed PSW rewind=
s) and failed PV_UNPACK ioctl retries.
--

--- Patch [7]: [PATCH v2 7/7] KVM: s390: Return -EINTR if a signal was pend=
ing while faulting-in ---
commit f252af4580d9ab98014328b1d85bbc46f505b01c
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Return -EINTR if a signal was pending while faulting-in
   =20
If a signal is pending while trying to fault-in a page, return -EINTR
instead of -EAGAIN.

> diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
> index fee80047bd94f..235b9c66ce542 100644
> --- a/arch/s390/kvm/faultin.c
> +++ b/arch/s390/kvm/faultin.c
> @@ -93,7 +93,7 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct =
kvm *kvm, struct guest_fa
>  			return PGM_ADDRESSING;
>  		/* Signal pending: try again. */
>  		if (f->pfn =3D=3D KVM_PFN_ERR_SIGPENDING)
> -			return -EAGAIN;
> +			return -EINTR;

[Severity: Critical]
Will returning -EINTR here bypass explicit -EAGAIN handling in callers?

For example, in arch/s390/kvm/intercept.c:handle_mvpg_pei(), there is
the following loop:

	do {
		rc =3D kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(dstaddr), true);
	} while (rc =3D=3D -EAGAIN);
	if (rc)
		return rc;

	kvm_s390_retry_instr(vcpu);

If a non-fatal signal is pending, handle_mvpg_pei() will return -EINTR
and bypass kvm_s390_retry_instr(vcpu). Since the hardware has already
advanced the guest PSW for the intercept, does exiting to userspace without
rewinding the PSW cause the guest to resume at the next instruction,
silently skipping the MVPG instruction?

Similarly, in arch/s390/kvm/vsie.c:vsie_run(), returning -EINTR from
map_prefix() skips the rc =3D=3D -EAGAIN check:

		rc =3D map_prefix(vcpu, vsie_page, sg);
...
		if (rc =3D=3D -EAGAIN)
			rc =3D 0;

		/* Exit the loop if the guest needs to process the intercept */
		if (rc || scb_s->icptcode)
			break;

This breaks out of vsie_run() and exits to userspace without rewinding the
SIE instruction.

Finally, in arch/s390/kvm/pv.c:kvm_s390_pv_unpack(), the loop handles -EAGA=
IN
explicitly to absorb non-fatal signals:

	while (offset < size) {
		ret =3D unpack_one(kvm, addr, tweak, offset, rc, rrc);
		if (ret =3D=3D -EAGAIN) {
			cond_resched();
			if (fatal_signal_pending(current))
				break;
			continue;
		}
		if (ret)
			break;

Returning -EINTR terminates the unpacking prematurely. When userspace
retries the KVM_PV_UNPACK ioctl, it restarts from offset 0, which could
cause the Ultravisor to reject the attempt to unpack already-secured pages,
permanently failing the VM boot process.

>  		/* Check if it's read-only memory; don't try to actually handle that c=
ase. */
>  		if (f->pfn =3D=3D KVM_PFN_ERR_RO_FAULT)
>  			return -EOPNOTSUPP;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713150857.2699=
54-1-imbrenda@linux.ibm.com?part=3D7

