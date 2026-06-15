Return-Path: <linux-s390+bounces-20861-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4G1CBn39L2qNLQUAu9opvQ
	(envelope-from <linux-s390+bounces-20861-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 15:26:21 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 654DF686BBF
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 15:26:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=caqo+Pqp;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20861-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20861-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 809FC3055DE9
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 13:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF9A36AB7C;
	Mon, 15 Jun 2026 13:23:02 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABC437E314;
	Mon, 15 Jun 2026 13:23:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529782; cv=none; b=t9TZ3tue9yQiZmTyX/wwMeBalMrh+V+1JgmoO35sUpQh997e81hEoYzzbqkOTzXx6cJtheYX7AOd9E0O8XB5QgtdSp2/V36/imRyS9qni9mnI/XoGiULy1mybo92T5t08wat4HYq4IR7TqKtqWH8o2hKW2mjf6wUC4RpTuaIUXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529782; c=relaxed/simple;
	bh=Mrsyf2pWQiTMy185MnWe6LkM9Lbf9D057xx4pfW7LPk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jpEa3+yFG9mIlGkYibHMlyV4TljQw0tB20oQpamo0Dwtt6BZgnuQvabps8aEJ/MzXpY+vVI4tkwvqB1YvnUodOnN1yYKrPbf7oQb0dNN1SXLW+tR625c1SY+EJFYjeTm6C4gcNkU4MdppM/iAe3HVPET+DVvX+qSJsIk8buO2qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caqo+Pqp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583DE1F000E9;
	Mon, 15 Jun 2026 13:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781529781;
	bh=Z19ibZVkMSu/453YekQIQm3hgNHpanv4Kta00IuUMqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=caqo+PqpafcjVnVzsv/tySf4s2K6AMO+mvNiZg1+WKY2C3wq74RKZ9+jrgA8Wxh1O
	 W4yA8gt8AO76mZ4enZX40yrgJJerL0xVMZ/5+8wwB4sVkDa8m9QhQNEOZwxg58kLO8
	 mvPLI3KEJ0aLX4hgUSNqN5Arvn+9YQQ9s5zgWg9iOjryA9LoNQ+raxkNBj2NfUF1Z7
	 j5jxI1mBQkNFRk0nbVwuvHd1ZMEL+D37JOMNaxRTPQnatKlDTqrPfqTC51ZTHCaG7K
	 jqwlqaev1wck0ptnHZH7B46lxuakrOHGS2TpWzEnIevHSSSm5Q87LUl+hqWGAjpXwS
	 rAq62zPThrOMg==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 17/17] KVM: s390: Introducing
 kvm_arch_set_irq_inatomic fast inject
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260615124243.187614-18-imbrenda@linux.ibm.com>
References: <20260615124243.187614-18-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 13:23:00 +0000
Message-Id: <20260615132301.583DE1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-20861-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:hca@linux.ibm.com,m:kvm@vger.kernel.org,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 654DF686BBF

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Guest-reachable WARN_ON_ONCE during memory allocation failure in `=
__kvm_inject_pfault_token`
- [High] Preexisting guest-triggerable WARN_ON_ONCE on interrupt queue full
--

commit 4b098d22649d526ad54d46d65ab883c23baf1ae2
Author: Douglas Freimuth <freimuth@linux.ibm.com>

KVM: s390: Introducing kvm_arch_set_irq_inatomic fast inject

This commit introduces a fast path for irq injection to prevent blocking on
the global work queue. It also converts shared resources between the fast a=
nd
slow paths to spinlocks and adds statistical counters for analysis.

Message-ID: <20260604192755.203143-4-freimuth@linux.ibm.com>

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 9265bc73cd938..dc9c7451fe979 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c

[ ... ]

> @@ -4429,19 +4439,28 @@ int kvm_s390_try_set_tod_clock(struct kvm *kvm, c=
onst struct kvm_s390_vm_tod_clo
>  }
> =20
>  static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_=
token,
> -				      unsigned long token)
> +				     unsigned long token)
>  {
>  	struct kvm_s390_interrupt inti;
>  	struct kvm_s390_irq irq;
> +	struct kvm_s390_interrupt_info *inti_mem =3D NULL;
> +	int ret =3D 0;
> =20
>  	if (start_token) {
>  		irq.u.ext.ext_params2 =3D token;
>  		irq.type =3D KVM_S390_INT_PFAULT_INIT;
>  		WARN_ON_ONCE(kvm_s390_inject_vcpu(vcpu, &irq));
>  	} else {
> +		inti_mem =3D kzalloc_obj(*inti_mem, GFP_KERNEL_ACCOUNT);
> +		if (WARN_ON_ONCE(!inti_mem))
> +			return;

[Severity: High]
This isn't a bug introduced by this patch, but does this guest-reachable
assertion pose a denial of service risk? Under host memory pressure, this
allocation can fail. Since a guest can trigger async page faults (and thus
host memory allocations) by accessing swapped-out memory, an unprivileged
guest could exhaust memory limits to force this allocation to fail. This
would intentionally hit the WARN_ON_ONCE, potentially crashing the host if
panic_on_warn is enabled.

> +
>  		inti.type =3D KVM_S390_INT_PFAULT_DONE;
>  		inti.parm64 =3D token;
> -		WARN_ON_ONCE(kvm_s390_inject_vm(vcpu->kvm, &inti));
> +		ret =3D kvm_s390_inject_vm(vcpu->kvm, &inti, inti_mem);
> +		if (ret)
> +			kfree(inti_mem);
> +		WARN_ON_ONCE(ret);

[Severity: High]
This is a pre-existing issue, but could this assertion also be driven by a
malicious guest? A guest can trigger up to ASYNC_PF_PER_VCPU * KVM_MAX_VCPUS
async page faults by continuously accessing unmapped pages and intentionally
masking floating interrupts.

This would cause the host's floating interrupt list to hit its maximum
capacity limit, causing kvm_s390_inject_vm() to return -EBUSY and triggering
this WARN_ON_ONCE. Could this be converted to a pr_warn_once() or similar
to avoid host denial of service?

>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615124243.1876=
14-1-imbrenda@linux.ibm.com?part=3D17

