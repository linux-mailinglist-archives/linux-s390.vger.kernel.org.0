Return-Path: <linux-s390+bounces-21177-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U/yEEn2rOmrqDAgAu9opvQ
	(envelope-from <linux-s390+bounces-21177-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 17:51:25 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 239646B872E
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 17:51:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZcmqJMI4;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21177-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21177-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 042413018CD6
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 15:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6852F5313;
	Tue, 23 Jun 2026 15:51:19 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3EF285041;
	Tue, 23 Jun 2026 15:51:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229879; cv=none; b=NcHhV4LkySG58bj33uZEd9HuF6MuvFj1pQSZxGJcZiyA9+b3hM1ftFUABRlfAv7UqL79gkJEvX++8B+VRGdek9SRsxuaJebVudkj/pVJqU9FNnuD7hvQ/+COKJnVa6Mygu8inZhcM8f95M/G3vxcIM6wyJlOvZ18BaIzdHq8vao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229879; c=relaxed/simple;
	bh=1AlAu76uRWYJzegr2Z06iAPOrnvLI5014zVrqS42p88=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JpSO4xcNdrMpZiAIfZR3bu/bIT/NDzc+oprLa299Rj/ADsJAtmJbwjmYRiQHHi9sfTAUfhA78EXAUtZgZilCEkrCZ5yegaVTW5OtlH6R1y+daMVBctnME85VB4yk7XC9fiATDvp9gtFDH86bZpF53Qa6R7RezqSpfloL6sOuzzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcmqJMI4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E211F00A3A;
	Tue, 23 Jun 2026 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782229878;
	bh=1Bh+C9iZ76WBwi9dVLvF08yn3rMy6JGnq3swinbzDgk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZcmqJMI4LqxHKEGHtzDcCQbvr5f67RtMrJ6vM5P3KYNXcQkDCtMGQMsIm4K1FQmSP
	 LF2T2eUgwi3vkhI+1KaeVXCc4aDObWsFJIo7if/tqc/oD6XvEnYYVDwewhSC+BaNmX
	 wr4mHpt5uEgsgCGOsOShGirUQ5mxp3A0mWkWB7jALNNtiC0fn8cwUASswYKkMQ6gbO
	 fY80OFYV4m7Bbp3AkkpXKokqCGKNpkFLd3+eToge2vn+ajs1N+jGt5NkrMnIixDq1T
	 kg8xLNLEm056BH1nIT+bf2BDtS9sIMzZxLvNbzwl04Cg/lK0Ik+IFfv6EPAd+Ng2xu
	 lULIxcQDEJAOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/10] KVM: s390: vsie: Avoid potential deadlock with
 real spaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260623153331.233784-11-imbrenda@linux.ibm.com>
References: <20260623153331.233784-1-imbrenda@linux.ibm.com>
 <20260623153331.233784-11-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 15:51:17 +0000
Message-Id: <20260623155118.30E211F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21177-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,smtp.kernel.org:mid,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 239646B872E

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Returning `-EAGAIN` without releasing the newly allocated `gmap` s=
tructure causes a severe memory leak, potentially leading to a host DoS und=
er lock contention.
--

commit 50740591beb78c10a0032430dbcc9d8cf4291017
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: vsie: Avoid potential deadlock with real spaces

This commit converts the inner locking of kvm->mmu_lock in gmap_create_shad=
ow()
to a trylock. It returns -EAGAIN if the lock is busy to avoid a potential
deadlock with real spaces when the natural lock ordering is reversed.

> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
> --- a/arch/s390/kvm/gmap.c
> +++ b/arch/s390/kvm/gmap.c
[ ... ]
> @@ -1349,8 +1349,12 @@ struct gmap *gmap_create_shadow(struct kvm_s390_mm=
u_cache *mc, struct gmap *pare
>  			/* Only allow one real-space gmap shadow. */
>  			list_for_each_entry(sg, &parent->children, list) {
>  				if (sg->guest_asce.r) {
> -					scoped_guard(write_lock, &parent->kvm->mmu_lock)
> +					if (write_trylock(&parent->kvm->mmu_lock)) {
>  						gmap_unshadow(sg);
> +						write_unlock(&parent->kvm->mmu_lock);
> +					} else {
> +						return ERR_PTR(-EAGAIN);
> +					}

[Severity: High]
Does returning here leak the memory allocated for the new gmap structure?

Looking at the code earlier in gmap_create_shadow(), the new gmap is alloca=
ted
unconditionally before this lock attempt:

arch/s390/kvm/gmap.c:gmap_create_shadow() {
    ...
	/* Create a new shadow gmap. */
	new =3D gmap_new(parent->kvm, asce.r ? 1UL << (64 - PAGE_SHIFT) : asce_end=
(asce));
	if (!new)
		return ERR_PTR(-ENOMEM);
    ...
	scoped_guard(spinlock, &parent->children_lock) {
		...
		if (asce.r) {
			/* Only allow one real-space gmap shadow. */
			list_for_each_entry(sg, &parent->children, list) {
				if (sg->guest_asce.r) {
					if (write_trylock(&parent->kvm->mmu_lock)) {
						gmap_unshadow(sg);
						write_unlock(&parent->kvm->mmu_lock);
					} else {
						return ERR_PTR(-EAGAIN);
					}

When write_trylock() fails, should we call gmap_put(new) before returning
ERR_PTR(-EAGAIN) to avoid leaking the gmap structure and its page tables?

Since callers like vsie_run() will loop and retry on -EAGAIN, could this
lead to rapid memory exhaustion under lock contention?

>  					break;
>  				}
>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623153331.2337=
84-1-imbrenda@linux.ibm.com?part=3D10

