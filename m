Return-Path: <linux-s390+bounces-21637-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gl42BPeDS2oOSwEAu9opvQ
	(envelope-from <linux-s390+bounces-21637-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 12:31:19 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C54970F353
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 12:31:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="kcBaW/E1";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21637-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21637-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EFDF313EF7B
	for <lists+linux-s390@lfdr.de>; Mon,  6 Jul 2026 10:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B3B424644;
	Mon,  6 Jul 2026 09:51:45 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E3F3C2787;
	Mon,  6 Jul 2026 09:51:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331501; cv=none; b=KJ2CDihEm1i+uQ/TTMFCLvEfj6+RHGgypjnNcRuAcBtjOTjIr6aKBocOvbjBrMB4rMoCEApYKKzu7JU/bh0Axw6yapZPXNKD/nPPN9DODsbQSqIQ/AdKCWBoNeB9jZSwMEQtWvqrg/411yFnHIMNkPiSbPN2L5w0sQXjb0f740U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331501; c=relaxed/simple;
	bh=ywoaDCiitG6UUpbjXRz5XjrlLVumC9HZGxpFMZ3I8eU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n/C5ISiesENl44r8mG8BhhcoFmqZRD3nfYL7G4Xsx3YGQQmkbfcfp976XL6Zj4KqedasujBYGh09P+66PNngV483kENqwqwsteVRqUszlQeVjnIbvKIlVt2VHZQW5ramDrJ0Bvs8w3mxdREUpuPoU6L1Tz39DnY238ZOD1cRjO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcBaW/E1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB021F00A3A;
	Mon,  6 Jul 2026 09:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783331491;
	bh=zN2f75xRCPsJVmuL136Mb/updeydU4Ru6dHCSJnNi1s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kcBaW/E1zeMDTNokdLZAj+MaOAifKXjrq3xDU9jXuHvI30MI/9pGdmGKA6I/3X8Jd
	 8+02sQMRnsdesYru1hqeBxQ6hHoJ2yA3E+lI8vGjafVsFGlBXu7pmPKewBb3RNOus3
	 kZCXaCrn0sF2cxFwc695F/EUAcemj8H1jetepKOkKW4D+HizYQpk8mR0TvMaCu+C67
	 ilz/3ug6AU4lqjSPuoU3+NG0/DWm+GSnzi7s456+rpXWLdeC13xFMn0oZqfbvBapuT
	 0uyLMNNK+ZJ8ryrYUX1F1p5nHL9RC6N8np8H0a/MrjvujEToiGXb94eiz/R0d9OVij
	 KkOILjVLzTm2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 22/27] KVM: s390: Add basic arm64 kvm module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev
In-Reply-To: <20260706085229.979525-23-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-23-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:51:30 +0000
Message-Id: <20260706095130.DEB021F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21637-lists,linux-s390=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:seiden@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:kvm@vger.kernel.org,m:oupton@kernel.org,m:maz@kernel.org,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:kvmarm@lists.linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C54970F353

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Integer underflow in `kvm_max_guest_address()` allows bypassing =
IPA limit checks, leading to shift-out-of-bounds undefined behavior.
- [Medium] Falsely advertises support for `KVM_CAP_ARM_USER_IRQ` while sile=
ntly dropping interrupt injections.
--

commit cf17b7229eed87d0fba2ede0e60b154b44cdfc5e
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: Add basic arm64 kvm module
   =20
Add basic code for the new arm64 on s390 KVM implementation.
Add kernel module boilerplate code and trivial functions.

> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> new file mode 100644
> index 0000000000000..19249ec5c539f
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/arm.c
[ ... ]
> @@ -20,172 +20,192 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
>  {
>  	int ret;
> =20
>  	switch (ext) {
>  	case KVM_CAP_NR_VCPUS:
>  	case KVM_CAP_MAX_VCPUS:
>  	case KVM_CAP_MAX_VCPU_ID:
>  		ret =3D KVM_MAX_VCPUS;
>  		break;
>  	case KVM_CAP_ARM_VM_IPA_SIZE:
>  		ret =3D get_kvm_ipa_limit();
>  		break;
>  	case KVM_CAP_IOEVENTFD:
>  	case KVM_CAP_ARM_USER_IRQ:
>  		ret =3D 1;

[Severity: Medium]
Since kvm_vm_ioctl_irq_line() silently drops interrupts and returns success,
does advertising support for KVM_CAP_ARM_USER_IRQ here cause userspace to
believe the capability works, leading to lost interrupts and guest hangs?

>  		break;
>  	default:
>  		ret =3D 0;
>  	}
> =20
>  	return ret;
>  }
> =20
>  static u64 kvm_max_guest_address(void)
>  {
>  	u64 max_addr;
> =20
>  	if (sclp.hamax =3D=3D U64_MAX)
>  		max_addr =3D TASK_SIZE_MAX;
>  	else
>  		max_addr =3D min_t(u64, TASK_SIZE_MAX, sclp.hamax);
>  	return ALIGN_DOWN(max_addr + 1, 1 << 30) - 1;

[Severity: Medium]
Can this underflow if max_addr + 1 is less than 1GB?=20

If sclp.hamax restricts the maximum address to less than 1GB,=20
ALIGN_DOWN(max_addr + 1, 1 << 30) will evaluate to 0. Subtracting 1 would
then underflow to U64_MAX.

>  }
> =20
>  vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *v=
mf)
>  {
>  	return VM_FAULT_SIGBUS;
>  }
> =20
>  long kvm_arch_dev_ioctl(struct file *filp,
>  			unsigned int ioctl, unsigned long arg)
>  {
>  	return -EINVAL;
>  }
> =20
>  u32 get_kvm_ipa_limit(void)
>  {
>  	return fls64(kvm_max_guest_address() + 1) - 1;

[Severity: Medium]
If kvm_max_guest_address() returns U64_MAX due to the underflow above, this
will evaluate to U32_MAX.=20

Could this large value cause the IPA limit validation checks to be bypassed,
allowing untrusted userspace to provide a large shift value and trigger a
shift-out-of-bounds undefined behavior?

>  }
[ ... ]
>  int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_lev=
el,
>  			  bool line_status)
>  {
>  	return 0;

[Severity: Medium]
This isn't a bug in the implementation of the stub, but since
KVM_CAP_ARM_USER_IRQ is advertised as supported, will returning success here
without injecting the interrupt deceive userspace and silently drop the
interrupts?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706085229.9795=
25-1-seiden@linux.ibm.com?part=3D22

