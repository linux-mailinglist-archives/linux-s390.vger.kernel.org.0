Return-Path: <linux-s390+bounces-21608-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +XvUB8F+S2plSQEAu9opvQ
	(envelope-from <linux-s390+bounces-21608-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 12:09:05 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B366270EEAF
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 12:09:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="mbPMdR//";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21608-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21608-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 042BD3565574
	for <lists+linux-s390@lfdr.de>; Mon,  6 Jul 2026 09:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC284A13A0;
	Mon,  6 Jul 2026 09:15:27 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0863BE16F;
	Mon,  6 Jul 2026 09:15:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329325; cv=none; b=FsCXTWmSqdOkpQG3lNgB8968N1MpW0uPcOV3LnN9BzmBSIE7WBLVPOjvPrjYDDQwWbmL9I91CW1UYAFeXIjdeLGvzRa3aPrzD67dhLrAogBRqhNfiVwOMfTIjAQdnFkAEKz5W0VWZabrMB+YZDxOEP3yPMWVc1RFmaUU6hAUnFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329325; c=relaxed/simple;
	bh=kY8xZkCWKF2C6mD2XWgWRvHmWLHSO2B2xFta0+3JVhw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=shme5djIthjVSAJYO5VXjaQ2rqpp39XfeRVgIuY6Wj6HxkG510yG/IK6uSFSCRxdRz9Enyc0jxUQKKQOMWgjzAZHhTYYiOFuJq2CyMjEhCF4VlQ3oIlGTQDidPpFvhBHt9oQc3bbwmlUNA8NLysfUl/HK5FqCb6FUWLlkpLTdig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbPMdR//; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500FD1F000E9;
	Mon,  6 Jul 2026 09:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783329299;
	bh=t+J2sdIKjDT+gWndWpdtIyMLjdFZDiKcDYcIhVaxXKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mbPMdR//zDO0W6CU6auY6jcCk7+PEGDfKY9qQJ65IBHNGRN8saMcK7hpS3GZrZ6I7
	 UQAQoLe9NQY8U3LfvV9M6MV3biRP7ngCw0F8dr+Y6/uj5sl59Tv4ojjTPJB4XRGYzg
	 FAiy3f80/yk4iursvTz8LcijxFHfJOXZZ2WDeLJeUPkfs7zZsYbamXaqdk65+9NrTL
	 gtGk5e3cuaIB2jMW+kN03n6SbyuOFmoV7FMAK5Er9ipwRKt+G9daxvdEaPiUpxMm91
	 NsHSfX61nTLxpyukAbDjt869R4VORIs9G+sPaE3r7ecwUXWnm4DY6tbbMKMJBEFYSf
	 yz7ffViDByxhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/27] KVM: Make device name configurable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, "Oliver Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260706085229.979525-5-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-5-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:14:58 +0000
Message-Id: <20260706091459.500FD1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21608-lists,linux-s390=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:seiden@linux.ibm.com,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:maz@kernel.org,m:kvmarm@lists.linux.dev,m:oupton@kernel.org,m:linux-s390@vger.kernel.org,m:gor@linux.ibm.com,m:kvm@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kvm_dev.name:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B366270EEAF

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Simultaneous KVM implementations will trigger sysfs duplicate na=
me warnings due to hardcoded kmem cache names.

Pre-existing issues:
- [High] Missing cleanup of `kvm_debugfs_dir` on module initialization erro=
r paths leads to debugfs memory leaks and Use-After-Free vulnerabilities.
--

commit f2ad6d3ed070aa40a377cc68203ba1a3e871cc2e
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: Make device name configurable

Allow KVM implementations to choose alternative device names. This is
especially useful for architectures providing multiple KVM
implementations simultaneously.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 271884089f58d..dcad33cc2f255 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c

[ ... ]

> @@ -6464,11 +6462,22 @@ void kvm_unregister_perf_callbacks(void)
>  }
>  #endif
> =20
> -int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *mod=
ule)
> +int kvm_init(unsigned int vcpu_size, unsigned int vcpu_align, struct mod=
ule *module)
> +{
> +	return kvm_init_with_dev(vcpu_size, vcpu_align, module, "kvm", KVM_MINO=
R);
> +}
> +
> +int kvm_init_with_dev(unsigned int vcpu_size, unsigned int vcpu_align,
> +		      struct module *module, const char *dev_name, int minor)
>  {
>  	int r;
>  	int cpu;
> =20
> +	kvm_dev.minor =3D minor;
> +	kvm_dev.name =3D kstrdup(dev_name, GFP_KERNEL);
> +	if (!kvm_dev.name)
> +		return -ENOMEM;
> +
>  	/* A kmem cache lets us meet the alignment requirements of fx_save. */
>  	if (!vcpu_align)
>  		vcpu_align =3D __alignof__(struct kvm_vcpu);
> @@ -6479,8 +6488,9 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_alig=
n, struct module *module)
>  					   offsetofend(struct kvm_vcpu, stats_id)
>  					   - offsetof(struct kvm_vcpu, arch),
>  					   NULL);

[Severity: Medium]
Since the goal is to allow multiple KVM implementations simultaneously,
will the hardcoded "kvm_vcpu" string passed to kmem_cache_create_usercopy()
in kvm_init_with_dev() cause a sysfs duplicate name warning?

If a second KVM implementation is loaded, SLUB might attempt to create a
duplicate /sys/kernel/slab/kvm_vcpu sysfs directory, triggering a warning
that could crash systems with panic_on_warn enabled. Does this need to use
the configurable dev_name instead?

> +	r =3D -ENOMEM;
>  	if (!kvm_vcpu_cache)
> -		return -ENOMEM;
> +		goto err_dev_name;

[ ... ]

> @@ -6547,6 +6557,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_alig=
n, struct module *module)
>  	for_each_possible_cpu(cpu)
>  		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
>  	kmem_cache_destroy(kvm_vcpu_cache);
> +err_dev_name:
> +	kfree(kvm_dev.name);
>  	return r;
>  }

[Severity: High]
This is a pre-existing issue, but is there a missing cleanup of
kvm_debugfs_dir in the error handling path of kvm_init_with_dev()?

If initialization fails during a late step like misc_register, the error
unwinding labels are executed, but debugfs_remove_recursive() is never
called for the debugfs directory created earlier by kvm_init_debug().

Since the initialization fails and the module memory is freed, could
accessing the abandoned debugfs files later cause a use-after-free when
the kernel tries to dereference invalid fops pointers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706085229.9795=
25-1-seiden@linux.ibm.com?part=3D4

