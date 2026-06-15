Return-Path: <linux-s390+bounces-20856-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OA31NUD4L2pYKgUAu9opvQ
	(envelope-from <linux-s390+bounces-20856-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 15:04:00 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69274686819
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 15:04:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="a/j/lTxw";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20856-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20856-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D30A930010FC
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 13:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449F01C5F39;
	Mon, 15 Jun 2026 13:03:58 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3434831E841;
	Mon, 15 Jun 2026 13:03:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528638; cv=none; b=Qbvd2TuS/VcQf+C/RQ3m5xIGoOEP6wBitvrA7+KV2oC4lq2hme2pcdZ9IbT8JKSXWVHrb48jdjW1Tn1mCMIPdyQfFSWGfwEkrcNi/mn908vWTOxaP9MaXW5mSv3vVkWhKzbXzSRCZGlWviRNmiVJIOS81jfc7b1d19LD4wWBBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528638; c=relaxed/simple;
	bh=5bx8pvcHeH0yZUDG/oQAjHVDFjW7NkD5zKCPn6FM5QE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iryY54w4xyp7kZccSd2VYw/DdZwOivEL6BUYYtOtoiVHIil9+1BniwTu9n74dRa5uH3+on0WS/c2VerwWDmgHM7q5cmVqfuDX2hmSRLELzXDZ2+0JllrUyxeIU8k3isaTpiUHc2q6fnRTpPIf84sBZRUkGAcFPUeMMFNIyXA5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/j/lTxw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F611F000E9;
	Mon, 15 Jun 2026 13:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781528636;
	bh=TUfnVdWZXDovioRWDkr1Oyxk6rRwKB+DPj19oraSopo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a/j/lTxwAQHrShw0nIPgUPUbBWek03Hnaw3NsVMfrJTe8VWKj1TkorkC2E0uqKypm
	 tJyDPuHPEeDU2dn7cJrmtNjtA6Ge3uZ9Gkgv+GiO9THLYSpzrjHs7INtxdx9ceVS49
	 um+g9ye5nQojINYN4lx6qHMLCrbCRpl4JVYolvM3QOg1RdSBK3qGXe+XsxOz9NbTGW
	 RjSoZPtj5sdFevmr+J2bzw8rvrZI1e6vY3rvfWmrgVD8yPKHiJ5kxf2X+kogTPAS9v
	 mOPVOV7oyhEV1ZDyFCPWwP4gLFte8T+Ww+9om2W00GJgrnYBNwtydPtMdNh8rlQdbX
	 AVyBCbyyBs+GQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 09/17] KVM: s390: Document the
 KVM_CAP_S390_HPAGE_2G capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260615124243.187614-10-imbrenda@linux.ibm.com>
References: <20260615124243.187614-10-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 13:03:56 +0000
Message-Id: <20260615130356.80F611F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20856-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,m:kvm@vger.kernel.org,s:lists@lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[vger.kernel.org:server fail,sashiko.dev:server fail,smtp.kernel.org:server fail];
	ALIAS_RESOLVED(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[sashiko.dev:server fail,smtp.kernel.org:server fail,vger.kernel.org:server fail];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c09:e001:a7::12fc:5321:server fail];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	TAGGED_RCPT(0.00)[linux-s390];
	FROM_NO_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69274686819

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing mutual exclusivity check between KVM_CAP_S390_HPAGE_2G and=
 KVM_S390_VM_MEM_ENABLE_CMMA allows conflicting features, leading to silent=
 loss of CMMA state.
--

commit d788facb209d12a096219ba2f554a3019dcb380e
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Document the KVM_CAP_S390_HPAGE_2G capability
   =20
Document the KVM_CAP_S390_HPAGE_2G capability, which behaves very
similarly to the existing KVM_CAP_S390_HPAGE_1M.

> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index e7998feaa940b..dfde0bfcbce61 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
[ ... ]
> @@ -8905,6 +8905,21 @@ helpful if user space wants to emulate instruction=
s which are not
>  This capability can be enabled dynamically even if VCPUs were already
>  created and are running.
> =20
> +7.47 KVM_CAP_S390_HPAGE_2G
> +--------------------------
> +
> +:Architectures: s390
> +:Parameters: none
> +:Returns: 0 on success; -EINVAL if hpage_2g module parameter was not set,
> +          cmma is enabled, or the VM has the KVM_VM_S390_UCONTROL
> +          flag set; -EBUSY if vCPUs were already created for the VM.
> +
> +With this capability the KVM support for memory backing with 2g pages
> +through hugetlbfs can be enabled for a VM. After the capability is
> +enabled, cmma can't be enabled anymore and pfmfi and the storage key

[Severity: High]
This is a pre-existing issue, but does the implementation actually enforce
this restriction when enabling CMMA?

Looking at arch/s390/kvm/kvm-s390.c:kvm_s390_set_mem_control(), when
KVM_S390_VM_MEM_ENABLE_CMMA is called:

	else {
		kvm->arch.use_cmma =3D 1;
		/* Not compatible with cmma. */
		kvm->arch.use_pfmfi =3D 0;
		ret =3D 0;
	}

It appears it sets kvm->arch.use_cmma =3D 1 without verifying if
GMAP_FLAG_ALLOW_HPAGE_2G (or 1M) has already been enabled in the gmap flags.
If userspace enables the 2G hugepage capability first and subsequently calls
the KVM_S390_VM_MEM_ENABLE_CMMA ioctl, could this allow conflicting feature=
s?

When both are enabled, the MMU table walker (_dat_walk_gfn_range) skips over
huge pages during CMMA operations, which might lead to CMMA state for
hugepages being silently lost. Could this cause guest memory corruption or
incorrect functional behavior during live migration?

> +interpretation are disabled. If cmma has already been enabled or the
> +hpage_2g module parameter is not set to 1, -EINVAL is returned.
> +
>  8. Other capabilities.
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615124243.1876=
14-1-imbrenda@linux.ibm.com?part=3D9

