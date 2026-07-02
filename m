Return-Path: <linux-s390+bounces-21512-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DzEZN7uGRmqLXwsAu9opvQ
	(envelope-from <linux-s390+bounces-21512-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 02 Jul 2026 17:41:47 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B436F98F2
	for <lists+linux-s390@lfdr.de>; Thu, 02 Jul 2026 17:41:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=n7hR8+dO;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21512-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21512-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2ED030AA897
	for <lists+linux-s390@lfdr.de>; Thu,  2 Jul 2026 15:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727CE353A63;
	Thu,  2 Jul 2026 15:34:39 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDBD353A71;
	Thu,  2 Jul 2026 15:34:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006479; cv=none; b=F7Im0TzSBQCn8OIA3wUdpJiXKeXzkGGZyHxJK3p+CgFVajn3r7c9Zo/pp/vzIdZDM6uCp/UKf+SH+Tq6WxRibZgMoodq894jIWP/i2zFi9eDyTmaNbDYzYasM2qTkAKMtppLcLAEZyG+sOm3FEMlU3/AQzA6dWkXW3g7H0Y0zvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006479; c=relaxed/simple;
	bh=m+JWyHuFaAW3tquVfaNXx8Zt8r6ST97WjmK8DegVi7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FdWEOosk85H6hs1P72wbcBYGTOxmPnMDV6ETHKlHEFzSgCWlak1sysj0WmbdHclmBp0bepzPUSc0/FQrVI9ESd1snqxxGCJPi1w+0s5+1yA/kvhRimzchqePIPsDnz1OHIJIE99S1zomaSrSIrumI+D2k43g1xyoJSQAjFohR9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7hR8+dO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A171F000E9;
	Thu,  2 Jul 2026 15:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783006478;
	bh=XWmtLC9ycY37iLe0Nc3F/yjVI0mioWGVpASP58QeZBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n7hR8+dOo8ys2VlebZ1VxwnvvSSPwREEhywh42khXcAxO5Tsdy6/H9e3L0Lks04Il
	 KfglL5+X5/mS3gg3hv11qI7gElIFG6N+iCLr5AVdtn5TP0ZQiO9VSZx2+I/nhcT253
	 /ThTywvOdRAlsC3DbmZ5RHlWhgR/Aigufa1JsHcd6ZQxYDmgfhpQVXViIXeDEOtkrR
	 2cWoYJ4scieVOwnrYjqTFDXfJgtYtJN2LW8VHWybv+EWy/lKGdDHC9JTMAkQSXlcZO
	 EEuKVm4ExJa5YPpFi2O4VBwRalmf//Vh5r2Y9jg77n9krmay7x3xpAXzzJtEIpA25e
	 n7XR27GrKJNCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/8] KVM: s390: Fix race in __do_essa()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260702152406.204782-6-imbrenda@linux.ibm.com>
References: <20260702152406.204782-1-imbrenda@linux.ibm.com>
 <20260702152406.204782-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:34:37 +0000
Message-Id: <20260702153437.A5A171F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21512-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:hca@linux.ibm.com,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 37B436F98F2

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Acquiring `kvm->slots_lock` inside an SRCU read-side critical sect=
ion causes an ABBA deadlock.
--

commit e40855b84f2ee647bcced37d340b4d6805640050
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix race in __do_essa()

This commit addresses a race condition between __do_essa() and VM migration
or dat_get_cmma() by acquiring kvm->slots_lock before calling __do_essa().

> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -1260,8 +1260,9 @@ static int handle_essa(struct kvm_vcpu *vcpu)
>  		/* Retry the ESSA instruction */
>  		kvm_s390_retry_instr(vcpu);
>  	} else {
> -		scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
> -			i =3D __do_essa(vcpu, orc);
> +		scoped_guard(mutex, &vcpu->kvm->slots_lock)
> +			scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
> +				i =3D __do_essa(vcpu, orc);

[Severity: High]
Does acquiring kvm->slots_lock here introduce an ABBA deadlock?

Looking at handle_essa(), it executes within an SRCU read-side critical
section, as verified by the lockdep assertion at the start of the function:

static int handle_essa(struct kvm_vcpu *vcpu)
{
	lockdep_assert_held(&vcpu->kvm->srcu);
	...

If a concurrent memslot update acquires kvm->slots_lock and then calls
synchronize_srcu(&kvm->srcu), it will wait on the SRCU lock held by this
thread, while this thread blocks waiting for kvm->slots_lock.

>  		if (i < 0)
>  			return i;
>  		/* Account for the possible extra cbrl entry */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702152406.2047=
82-1-imbrenda@linux.ibm.com?part=3D5

