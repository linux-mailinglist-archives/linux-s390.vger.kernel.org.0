Return-Path: <linux-s390+bounces-21097-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EezZKKBgOWpNrQcAu9opvQ
	(envelope-from <linux-s390+bounces-21097-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 18:19:44 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C39B6B114C
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 18:19:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lohE3Uq9;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21097-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21097-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 108A930048EF
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 16:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AD11AE877;
	Mon, 22 Jun 2026 16:19:41 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68DF2C21F2;
	Mon, 22 Jun 2026 16:19:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145181; cv=none; b=Dntfd8URyf8OYeyz2ijhs5DBzQtdm7ExjDMLXvOFe91xR88LpdK3giUqY5cNB8xwNnHAS/XdPxWyAUA18pKcHis7L0U/pIErRPuhnHjOYV4K77Czq4SfsPWA6rdbASSYibObwBrVANff0eIYyFWD+27gsO8QceUIxJHkv6xhby8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145181; c=relaxed/simple;
	bh=sLbT6th8HNg4rw7taDUBIKUHUP4m7hQQ/0/9Wou64+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BBOEnfqGoIRjA+ubzlq91HLpngGARhF1HQIi+Dx7C6gbVwzrH8cYI38lxrzpqI1ltGlSPvOfYBLQYlpT2+Htc4aNSZXumX7vCR0NzipJTGsIPSd7sxe6tblzvYgTSPEW2sgaODc6ZwpcuKYgPd36BNOyOZpDOYq5gms5vPSdZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lohE3Uq9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2E71F00AC4;
	Mon, 22 Jun 2026 16:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782145180;
	bh=fjuiD63wezbHUx9p4+c9r+Ww1S8hjQmzlPuLPFA6HZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lohE3Uq9YEgBbt0PZ3G3M575C4gQEYg74cMXnKJ5bjNjW6+bHEQ6+aD6Hkq2R+hvW
	 JcPTQbws5soiL6jRfDF0KPZ0e0uscZrXb1D8yAHEWeyyqt54dmfC3Hj1u6+xEGDvfL
	 S7/EICITzOxK7YZfKR4UE/8z/PBfxRLvwUE04+5E7KQKZ3s0o8YS+YsuCheW+Yz/LJ
	 UXZs97NErVj2rH374yIwvZgjlP6MKDxFYrTfEVwS7xDV62rOn5FglnAndGFruk+TYN
	 EPzx37o8EBCY15imODAHnNo/2xhAGAANWhKzmdUUKwEvVUKpy4u7Q9Gqry9c6sFbvR
	 NuhLZbrjy9enw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/9] KVM: s390: Fix locking in
 kvm_s390_set_mem_control()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260622160739.202044-7-imbrenda@linux.ibm.com>
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
 <20260622160739.202044-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 16:19:39 +0000
Message-Id: <20260622161940.4C2E71F00AC4@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21097-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:gor@linux.ibm.com,m:kvm@vger.kernel.org,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C39B6B114C

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Holding `kvm->lock` across `get_user()` introduces a userfaultfd d=
eadlock risk and denial of service vector.
--

commit 86b3447d27dc01346bae78704ae167d2c9133c5c
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix locking in kvm_s390_set_mem_control()

This commit refactors kvm_s390_set_mem_control() by moving the kvm->lock
acquisition to the top of the function using a scope-based guard, and adds
missing locking around dat_reset_cmma().

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -962,6 +962,8 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, =
struct kvm_device_attr *att
>  {
>  	int ret;
> =20
> +	guard(mutex)(&kvm->lock);
> +
>  	switch (attr->attr) {

[ ... ]

>  	case KVM_S390_VM_MEM_LIMIT_SIZE: {
>  		struct kvm_memslots *slots;
>  		struct kvm_memory_slot *ms;
>  		unsigned long new_limit;
>  		int bkt;
> =20
>  		if (kvm_is_ucontrol(kvm))
>  			return -EINVAL;
> =20
>  		if (get_user(new_limit, (u64 __user *)attr->addr))
>  			return -EFAULT;
> =20
> -		guard(mutex)(&kvm->lock);
> -

[Severity: High]
Does this new lock placement introduce a userfaultfd deadlock risk?

By moving the guard(mutex)(&kvm->lock) to the top of the function, the lock
is now held during the get_user() call in the KVM_S390_VM_MEM_LIMIT_SIZE ca=
se.

If a userspace application backs the attr->addr pointer with a userfaultfd
region, the kernel page fault triggered by get_user() will block waiting for
the userspace handler to resolve it.

If that userspace handler then attempts to execute another KVM ioctl that
acquires kvm->lock (such as KVM_SET_USER_MEMORY_REGION), could this result
in an ABBA deadlock that hangs the kernel thread and permanently locks the
KVM instance?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622160739.2020=
44-1-imbrenda@linux.ibm.com?part=3D6

