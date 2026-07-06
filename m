Return-Path: <linux-s390+bounces-21607-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id odYkLjORS2qbVgEAu9opvQ
	(envelope-from <linux-s390+bounces-21607-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 13:27:47 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1145270FD5D
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 13:27:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cttosrQR;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21607-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21607-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 436E334CCD4F
	for <lists+linux-s390@lfdr.de>; Mon,  6 Jul 2026 09:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2A4422545;
	Mon,  6 Jul 2026 09:12:40 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7E63148BF;
	Mon,  6 Jul 2026 09:12:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329157; cv=none; b=uj2GMBihDfdGsK5hRTFUuu1xkbT2yZqfhWaYFUF5dOoIUovFrkC/ccAu9+6xETb1w59m4CYj5OnwsYREFOyAaO1QHMdGMd7LXQHkqhb4TTAjG8IRoey/9JjyN7XQn8JKvucFwFM0boO5reymX7rViYxbdcAO48gFZKdcwhE+W8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329157; c=relaxed/simple;
	bh=HL8qyHysHWY3xOD2dPiQ9gG6bwdSHGfRY2uuEqDNM6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uIb+Xs/EGDhNVN4z6MGhNQrynQtv/fIxgSay5otH31DIe970kC7xxj9tcpRc//v4Aj4qSi9TsiDa8M1pQIzGJIyUulDXM5HvxUcLOt4X5G5d/JTBi6ChkTc6F3OJqKk1ss/n7k8WYDHwzh7Xd0D9CuY1SxnLKGN1kjTL4Quk1sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cttosrQR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32F31F000E9;
	Mon,  6 Jul 2026 09:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783329144;
	bh=BVqvU0WQJ9NLRoCzs9l1uxuT858R40HfVD4wmKVXCGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cttosrQRNMwIpSGcpqGYX4vimHduXekem0aV1jbatjLPGiTLkiPO6qTh9iALoW7/j
	 BONKpY0XRqlbIAgSb2W6yuPyBPIui2zUZ2pHTRfCpt//yyn9ODxXXGOrOgeWivHmId
	 yIAFiXfpwe1p6+VBDAlxenPthv80zLAZxaidY8UI/Imd6EQpsLeM5BDlxXLGNJUXqA
	 RZXbuI00uJT6nvjMoKfdK6s1EQqY3kWPAfZxm/snlSdYVLABXIPC2nSJ/cjdDFKLSo
	 oPmn6b9YQCjMg/i5RUckzxwu+IJo9BOVaEDVQkUKUb1HbdvAXZ16loR5SsX0d2Y/yr
	 ap7fC1UG6p7jQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/27] VFIO: take reference to the KVM module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>
In-Reply-To: <20260706085229.979525-2-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-2-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:12:23 +0000
Message-Id: <20260706091223.E32F31F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21607-lists,linux-s390=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:seiden@linux.ibm.com,m:kvmarm@lists.linux.dev,m:linux-s390@vger.kernel.org,m:gor@linux.ibm.com,m:maz@kernel.org,m:kvm@vger.kernel.org,m:agordeev@linux.ibm.com,m:hca@linux.ibm.com,m:oupton@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1145270FD5D

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In the VFIO cdev binding path, concurrent or repeated calls to `VF=
IO_DEVICE_BIND_IOMMUFD` on multiple file descriptors for the same device ca=
use KVM reference leaks and state corruption.
--

commit 298282ceb4d6390cae8f782bcdd7f84408cf4d30
Author: Paolo Bonzini <pbonzini@redhat.com>

VFIO: take reference to the KVM module

This patch modifies VFIO to store a pointer to the KVM module alongside the
KVM pointer. It updates the get/set paths to take and release a module
reference to prevent the KVM module from unloading while in use, in
preparation for removing symbol_get and symbol_put.

> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index ed538aebb0b8e..8289aca97b6be 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
[ ... ]
> @@ -448,7 +448,8 @@ void vfio_unregister_group_dev(struct vfio_device *de=
vice)
>  EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
> =20
>  #if IS_ENABLED(CONFIG_KVM)
> -void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kv=
m)
> +void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kv=
m,
> +			      struct module *kvm_module)
>  {
>  	void (*pfn)(struct kvm *kvm);
>  	bool (*fn)(struct kvm *kvm);
> @@ -459,25 +460,31 @@ void vfio_device_get_kvm_safe(struct vfio_device *d=
evice, struct kvm *kvm)
>  	if (!kvm)
>  		return;
> =20
> +	if (!try_module_get(kvm_module))
> +		return;
> +
>  	pfn =3D symbol_get(kvm_put_kvm);
>  	if (WARN_ON(!pfn))
> -		return;
> +		goto out_put_mod;
> =20
>  	fn =3D symbol_get(kvm_get_kvm_safe);
> -	if (WARN_ON(!fn)) {
> -		symbol_put(kvm_put_kvm);
> -		return;
> -	}
> +	if (WARN_ON(!fn))
> +		goto out_put_sym;
> =20
>  	ret =3D fn(kvm);
>  	symbol_put(kvm_get_kvm_safe);
> -	if (!ret) {
> -		symbol_put(kvm_put_kvm);
> -		return;
> -	}
> +	if (!ret)
> +		goto out_put_sym;
> =20
>  	device->put_kvm =3D pfn;
>  	device->kvm =3D kvm;
> +	device->kvm_module =3D kvm_module;
> +	return;

[Severity: High]
This is a pre-existing issue, but can concurrent or repeated calls to
VFIO_DEVICE_BIND_IOMMUFD on multiple file descriptors for the same device
cause KVM reference leaks and state corruption here?

In vfio_device_get_kvm_safe() in drivers/vfio/vfio_main.c, the assignments
above blindly overwrite device->kvm (and now device->kvm_module) without
dropping any existing references.

If a user opens the VFIO device node twice (fd1 and fd2) and binds fd1,
device->kvm is set and the reference is taken. If they then call
VFIO_DEVICE_BIND_IOMMUFD on fd2, this function overwrites the pointers,
leaking the initial KVM and module references.

Furthermore, when vfio_df_open() subsequently fails in the fd2 bind path
because device->open_count > 0, the error path in vfio_df_ioctl_bind_iommuf=
d()
unconditionally calls vfio_device_put_kvm(device). This drops the newly
overwritten reference and clears device->kvm to NULL, entirely breaking the
KVM integration for the still-active fd1.

> +
> +out_put_sym:
> +	symbol_put(kvm_put_kvm);
> +out_put_mod:
> +	module_put(kvm_module);
>  }
> =20
>  void vfio_device_put_kvm(struct vfio_device *device)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706085229.9795=
25-1-seiden@linux.ibm.com?part=3D1

