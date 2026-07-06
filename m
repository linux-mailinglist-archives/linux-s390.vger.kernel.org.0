Return-Path: <linux-s390+bounces-21614-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /ONDO9qHS2o3UwEAu9opvQ
	(envelope-from <linux-s390+bounces-21614-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 12:47:54 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 599FA70F73B
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 12:47:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZeBya+8V;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21614-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-21614-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3CAA315AC55
	for <lists+linux-s390@lfdr.de>; Mon,  6 Jul 2026 09:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C4D41D4F7;
	Mon,  6 Jul 2026 09:36:58 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F71641DEF3;
	Mon,  6 Jul 2026 09:36:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330617; cv=none; b=Xi5a27yxAIDSgwdvCb0Yz9NLc6irxWERWhXJoqATqQJPMSJgvXkL/zmrph2SIsnpMbFgbcYuhRuIfh+sC8lvl7MfDjHTjlf1sorLmpc4lpUNBF5hyhTJvlDeeetEDePxk8HkQDkSCAf97tPprBDS2TYjwcTEPo3Wp6QaL+oO6Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330617; c=relaxed/simple;
	bh=JFQxxQWKrmxxXex/Zp1iGB/UYVTEYDYiQzY427mF2zQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pYTerlCGZoj0Z2AsYplkkD5YUNPZri/9HZmMpy2Vcjl1EzRceevHee6cH1mQ76kvNOmn8ubfleXoHIOl3wNbfiSG8QcYGhr1/3jS7gOhCQgvDFXoweWBGY0HaPLYLbNLaf6QAsfInRNI3ggUm60lgbfZ7vzmE7psGlUUJ0gFsEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeBya+8V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10C21F000E9;
	Mon,  6 Jul 2026 09:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783330613;
	bh=6eCNPxXv6mrWXltL5DWFvqnsqciwWuR2dJO+WJGbCOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZeBya+8VnsWpA+nGjOE+k7ZRIWtQ7o/a8B40BGJG88+QMPvt6rIr+Sq8sjccdHdkK
	 nvOsowpOj3rbilotbNX4Wyg55ncbecAAZOkfen6BAL+XnmP/fI+h71xPAJpSwH2wUk
	 sEGygA53WKEnd/b2z1UbFZxOgp1X3AK7QeqMtwfDFmcGTPMCmN52mp8FpC3zQ02iYF
	 G3xkoqdtgbXJbCcGRbrIoKQHQs7g/4fisOlqyz/UNxyfZub/RsPyPWtpc+pbJo36o7
	 C0KOZGRiw7ftHOzWmdiaIR1HRnTabtX3BWl4g+vt5+jKD2GhizGYCd91bTQ4H3P44V
	 9j58LP1TUf62A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/27] KVM: S390: Prepare gmap for a second KVM
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>
In-Reply-To: <20260706085229.979525-16-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-16-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:36:51 +0000
Message-Id: <20260706093652.A10C21F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21614-lists,linux-s390=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:seiden@linux.ibm.com,m:maz@kernel.org,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:kvmarm@lists.linux.dev,m:oupton@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 599FA70F73B

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Fallible memory allocation during the infallible memslot commi=
t phase causes silent Use-After-Free and guest crashes.
- [High] Non-atomic clearing of the memory slot dirty bitmap via `memset` c=
an race with concurrent atomic `set_bit` operations, leading to lost dirty =
bits.
--

commit 2aa486852c957946a99960f65fceb0012466db06
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: S390: Prepare gmap for a second KVM implementation

Refactor gmap code such that a second s390 (host) KVM implementation can
use the gmap code as well. Move relevant definitions into the shared
kvm_host.h. Move mmu code from s390 to gmap so the other KVM
implementation can use it as well.

> diff --git a/arch/s390/kvm/gmap/mmu.c b/arch/s390/kvm/gmap/mmu.c
> new file mode 100644
> index 0000000000000..5bb6609b974b2
> --- /dev/null
> +++ b/arch/s390/kvm/gmap/mmu.c
[ ... ]
> +int gmap_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
> +{
[ ... ]
> +	/* Clear the dirty log */
> +	if (is_dirty) {
> +		n =3D kvm_dirty_bitmap_bytes(memslot);
> +		memset(memslot->dirty_bitmap, 0, n);
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but since the code is being
moved here, I noticed this clearing logic. Can this non-atomic memset()
race with concurrent atomic bit setting operations?

If KVM concurrently calls mark_page_dirty() (for example, from
kvm_s390_sync_request() for virtio indicators), which sets bits in this
same bitmap using set_bit_le(), it seems we could lose dirty bits in the
gap between the copy and this clear, or have the atomic set overwritten by
the memset().

Could this lead to lost dirty bits and memory corruption during live
migration?

[ ... ]
> +void gmap_commit_memory_region(struct kvm *kvm,
> +			       struct kvm_memory_slot *old,
> +			       const struct kvm_memory_slot *new,
> +			       enum kvm_mr_change change)
> +{
> +	struct kvm_s390_mmu_cache *mc =3D NULL;
> +	int rc =3D 0;
> +
> +	if (change =3D=3D KVM_MR_FLAGS_ONLY)
> +		return;
> +
> +	mc =3D kvm_s390_new_mmu_cache();
> +	if (!mc) {
> +		rc =3D -ENOMEM;
> +		goto out;
> +	}

[Severity: Critical]
This is a pre-existing issue, but is it safe for this memory allocation to
fail during the memslot commit phase?

If kvm_s390_new_mmu_cache() fails under memory pressure, the error
is only printed at the goto out label and the required gmap table updates
are skipped:

[ ... ]
> +out:
> +	if (rc)
> +		pr_warn("failed to commit memory region\n");
> +	kvm_s390_free_mmu_cache(mc);
> +}

For KVM_MR_DELETE and KVM_MR_MOVE, skipping dat_delete_slot() could
leave the guest with a stale, usable hardware mapping to host memory.

Does this lead to a guest-to-host use-after-free if userspace issues
KVM_SET_USER_MEMORY_REGION under high memory pressure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706085229.9795=
25-1-seiden@linux.ibm.com?part=3D15

