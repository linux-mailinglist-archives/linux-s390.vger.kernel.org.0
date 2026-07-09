Return-Path: <linux-s390+bounces-21974-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2rsoGcvCT2rcnwIAu9opvQ
	(envelope-from <linux-s390+bounces-21974-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 09 Jul 2026 17:48:27 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CE473315A
	for <lists+linux-s390@lfdr.de>; Thu, 09 Jul 2026 17:48:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VlCvT1Tb;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21974-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-21974-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90D463086920
	for <lists+linux-s390@lfdr.de>; Thu,  9 Jul 2026 15:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01D242379B;
	Thu,  9 Jul 2026 15:47:12 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEF654723;
	Thu,  9 Jul 2026 15:47:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612032; cv=none; b=pP2EeU3QLwk2bXdmSEN9ZVwURC5QZ5pA/rHK/DsJS4cNohn3ZISnXjh0FYyLc/aeekQoogIGKPqHfsRpn5gE2KsbQNUOFcSbz+WjAbRN93IawhucyV6SdA/EDQT4/cD8ZqwS0e39D6YzqSfd4p3LtaWzx2VYOJ1G1iEKQbF+ESk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612032; c=relaxed/simple;
	bh=vpjynq5BJlsG0KQv+rgFMfXKhfuPYUUINaiZNsFzPm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o6pIovC8qi18ZbimQ68fdr8JaMDgDuMWSJPBO+v81WCTiD1R3CfBYVfv8qqXifFoSTqxZO8GBsKhoTEVrRaHJkH9ouMgjiBeuQEHrEht2/bwuTAFsImzkOhrwLGEDXzlUbLpme9ae55YH4PogijA+8aT8mA8FvqUaCXMysfDTdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlCvT1Tb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7B01F000E9;
	Thu,  9 Jul 2026 15:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783612030;
	bh=4Iz3VetR0IW+5P+ybhmt0roE5XRS6ec9BjP0xTtEWuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VlCvT1TbaNLF4xCQ5Agua3g5v6XT627m29C/lEJuR5Di6jdwOnBqF2wvIYmWQtb7T
	 GRYIe9ZPsQNdioKS0u8J7G0cU/w5/Gk3FB5KK5dCaqLGx9jBzmJKbkk2xvsDAEZ+gL
	 K92ThSPVm4zqyr27Fv5kPK1Z/LunadMQtxagIdtubcLtBVX2rQY4Fd3KARd7CwOH2E
	 1RyTgjPiXrP8bWDmMrKr3zBma03GKYv+Fh90j1oNJYDcvpYgNbD+hsSvAOfOrimqKO
	 iwHy99W/UUUaohCVAqg7mdVCa4dNdAV2R8mErhy7ofRQbI73a7pdgQNSfN6p2k5BFR
	 da/JgJ9iy0Vug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/21] KVM: s390: vsie: Create minimal scb shadows for
 not running g3 blocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-20-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-20-ea9f12066408@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:47:09 +0000
Message-Id: <20260709154710.4B7B01F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21974-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:schlameuss@linux.ibm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:kvm@vger.kernel.org,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8CE473315A

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Critical] Out-of-bounds array access using guest-controlled `icpua`.
- [Critical] Host WARN and VM crash via invalid SCA physical address (DoS).
- [High] Lost validity intercept for side VCPUs causing silent execution di=
vergence.
- [High] SCA corruption and livelock on concurrent VSIE entry.
- [High] Pinned SCB guest pages are leaked when the VM is destroyed.

Pre-existing issues:
- [High] Guest 2 SCB memory corruption when prepare_cpuflags fails.
--

--- Patch [20]: [PATCH 20/21] KVM: s390: vsie: Create minimal scb shadows f=
or not running g3 blocks ---
commit 2f62e0dfe18aabd20de0781221d96146e1f85a9f
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Create minimal scb shadows for not running g3 blocks

Instead of creating a full shadow for vSIE control blocks, this creates a
minimal shadow for SIGP purposes for currently not running guest-3 blocks.
The full shadow is recreated when vSIE is entered with that SCB later.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 80050376eaab1..feac755d56cb5 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
[ ... ]
> @@ -692,6 +691,39 @@ static void unshadow_scb(struct kvm_vcpu *vcpu, stru=
ct vsie_page *vsie_page)
>  		scb_o->ihcpu =3D scb_s->ihcpu;
>  }
> =20
> +static int shadow_scb_minimal(struct kvm_vcpu *vcpu, struct vsie_page *v=
sie_page)
> +{
[ ... ]
> +	rc =3D prepare_cpuflags(vcpu, vsie_page);
> +	if (rc)
> +		return rc;
> +
> +	scb_s->icpua =3D scb_o->icpua;

[Severity: Critical]
Does this code allow an out-of-bounds array access if the guest provides an
invalid icpua?

If a malicious guest provides an SCB with an icpua value greater than 255,
it appears kvm_s390_handle_vsie() passes this unvalidated scb_o->icpua to
get_vsie_page_cpu_nr().

Inside get_vsie_page_cpu_nr(), the cpu_nr is used to index directly into the
fixed-size vsie_sca->pages array:

vsie_page =3D vsie_sca->pages[cpu_nr];

Could this result in an out-of-bounds read and a subsequent out-of-bounds
write of a kernel heap pointer when vsie_page_new is evaluated?

> +	scb_s->ecb2 |=3D scb_o->ecb2 & ECB2_ESCA;
[ ... ]
> @@ -711,17 +743,7 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct =
vsie_page *vsie_page)
[ ... ]
> -	rc =3D prepare_cpuflags(vcpu, vsie_page);
> +	rc =3D shadow_scb_minimal(vcpu, vsie_page);

[Severity: High]
This isn't a bug introduced by this patch, but does the error path here
corrupt guest memory when prepare_cpuflags() fails?

If shadow_scb_minimal() returns an error, the code jumps to the out label
and calls unshadow_scb().

Because the failure occurs before shadow_scb() initializes scb_s with guest
state from scb_o, scb_s might contain uninitialized zeros or stale data.

Does unshadow_scb() then copy this uninitialized data back into the guest's
scb_o, corrupting the guest's memory?

>  	if (rc)
>  		goto out;
[ ... ]
> @@ -2113,7 +2133,7 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, struc=
t vsie_page *vsie_page,
>  				rc =3D PTR_ERR(vsie_page_n);
>  			if (rc)
>  				goto err;
> -			rc =3D shadow_scb(vcpu, vsie_page_n);
> +			rc =3D shadow_scb_minimal(vcpu, vsie_page_n);

[Severity: High]
Does this error path lose the validity intercept for side VCPUs?

If a side CPU's SCB is invalid, shadow_scb_minimal() sets a validity
intercept in vsie_page_n->scb_s.icptcode and returns an error.

When _shadow_sca() propagates this error and jumps to the err label, it
doesn't seem to call unshadow_scb() on vsie_page_n. Later,
kvm_s390_handle_vsie() jumps to out_unshadow, which only unshadows the main
CPU's vsie_page.

Does this cause the guest to silently skip the SIE instruction without
notification, leading to execution divergence?

[Severity: High]
Can a concurrent VSIE entry cause SCA corruption and a livelock here?

If VCPU 1 is running, its vsie_page has VSIE_PAGE_IN_USE set. If VCPU 2
enters SIE and observes an MCN change, _shadow_sca() attempts to get
VCPU 1's page via get_vsie_page_cpu_nr(), which fails and returns -EAGAIN.

When _shadow_sca() jumps to the err label, it zeroes out
vsie_sca->ssca.cpu[cpu_nr] for all CPUs:

err:
    for_each_set_bit_inv(cpu_nr, ...) {
        vsie_sca->ssca.cpu[cpu_nr].ssda =3D 0;
        vsie_sca->ssca.cpu[cpu_nr].ossea =3D 0;
    }

Does this corrupt the SCA actively used by VCPU 1's hardware, and cause
VCPU 2 to continuously retry in a tight loop until VCPU 1 exits?

[Severity: Critical]
Does get_vsie_page_cpu_nr() trigger a host warning and VM crash if the guest
provides an invalid SCA physical address?

If a malicious guest provides an invalid physical address in its SCA for a
side CPU, pin_scb() detects this, injects a PGM_ADDRESSING exception, and
returns 1.

It appears vsie_page_init() transforms this return code into -ENOMEM.

When get_vsie_page_cpu_nr() sees this, it hits WARN_ON_ONCE(rc):

get_vsie_page_cpu_nr() {
    ...
    if (WARN_ON_ONCE(rc)) {
        put_vsie_page(vsie_page);
        return ERR_PTR(rc);
    }
}

Does this propagate the -ENOMEM up to the KVM_RUN ioctl, causing QEMU to
terminate the VM instead of resuming the guest?

>  			vsie_sca_update(vsie_sca, cpu_nr, vsie_page_n, sca_o_entry_hpa);
>  			put_vsie_page(vsie_page_n);
>  			if (rc)
>  				goto err;

[Severity: High]
Do we leak pinned SCB guest pages when the VM is destroyed?

The vsie_page_init() function pins the guest's SCB page, leaving the
vsie_page in the global kvm->arch.vsie.pages cache with a pinned host
physical page.

When the VM is destroyed, kvm_s390_vsie_destroy() frees each vsie_page in
the global cache via kvm_s390_vsie_destroy_page(). However, it appears to
miss calling unpin_scb() for these main CPU pages.

Could this permanently leak the pinned pages, potentially allowing an
unprivileged user to trigger a host physical memory leak by repeatedly
creating and destroying VMs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-vsie-sigpi=
-v1-0-ea9f12066408@linux.ibm.com?part=3D20

