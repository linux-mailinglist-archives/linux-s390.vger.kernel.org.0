Return-Path: <linux-s390+bounces-21229-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mlSxEdnBO2ozcQgAu9opvQ
	(envelope-from <linux-s390+bounces-21229-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 13:39:05 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C776BDB53
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 13:39:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=S7PXvJ0B;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21229-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21229-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9173B3018C29
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 11:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68AC371D11;
	Wed, 24 Jun 2026 11:39:00 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E25364953;
	Wed, 24 Jun 2026 11:38:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301140; cv=none; b=qg7+p71AL16QR+N+NCl2SpR+muekPi1iVaGkGgsHFVD81q9IV5OXuvHpdI73sRMVojB8r92QyCOe5k0ZGFed/2q1o8OApUDmbs38vCUz9QyIqcTjy76q3oCnt7Y3tdS3jQ0iAGABaY8TCGphfNyCHbxDw8GDl1r3qJpLm43q2Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301140; c=relaxed/simple;
	bh=utmBZsHIZwLBnjnfDYpd+jfnHwiZ4uZgZhVqtuh/afs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eGo6fNiM+GwN6k2fuWaai4UKlVSYHmIlC5ZOyVK50OYF+hYoFQFs9umaK6sznA04/R/hEHaU+4IPIjlGkpIs1Lu8M6BXbtpi2bK6n2O+20GaBMV0ABvfHVoB6XAA2tnhAW4uRUy9xAwmD7zS42OuFkoW0o0cV7g+jl0yFTGbQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7PXvJ0B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D741F000E9;
	Wed, 24 Jun 2026 11:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782301139;
	bh=s7MsNZFoH8x09HVwzFA00QDgOEPRObsv2QWCTBIoib8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S7PXvJ0BYIy/EIuA1TpL+9cUE4igL/dWPRbQWLpDSGqeMLiYTmpz+O/qwpg9zUgvU
	 FAc2d94pQjKnmZ7mBPXj7qEWNaqFGQzgY5HZg05SF9TRDmiXNKkIupvxCy+la6XSek
	 phaGLPN1X1xvq5zuKfQlG+v1VWFaEoSm/C5RApAOiHl7IIvgoz1Ir9zVzYN4rS6UOY
	 PThP8Le7UL+MV8d77y9gMdRLzVOrL1STIbNojSe3SrJfDYO2C67ScENz1ds2a1wJEC
	 deQgaV17ND4iEMBI8pxy0AVuv23arXotAFlIKOeQkcBO95NrYVTXPLTHMFnZSKXw3r
	 9Wr1IKO7UygYg==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 05/12] KVM: s390: Fix dat_peek_cmma() overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260624111928.144283-6-imbrenda@linux.ibm.com>
References: <20260624111928.144283-1-imbrenda@linux.ibm.com>
 <20260624111928.144283-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 11:38:58 +0000
Message-Id: <20260624113859.09D741F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21229-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,m:kvm@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: A9C776BDB53

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized kernel memory from `vmalloc` is copied to userspace =
when CMMA attributes are retrieved because skipped pages or unmapped CRSTEs=
 leave uninitialized gaps in the buffer.
- [Medium] The `KVM_S390_SET_CMMA_BITS` ioctl incorrectly returns a positiv=
e program exception code (`PGM_ADDRESSING` =3D 5) on out-of-bounds access i=
nstead of a standard negative errno.
--

commit 8344f31bea75084c2603931b9dc4f97ab83d6263
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix dat_peek_cmma() overflow

This commit fixes an underflow issue in dat_peek_cmma() when userspace
provides an out-of-bounds start address. It ensures the count is correctly
zeroed out instead of underflowing, so the function correctly returns an er=
ror
instead of erroneously reporting success.

Message-ID: <20260623153331.233784-3-imbrenda@linux.ibm.com>

> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index 4a41c0247ffa2..cffac7782c4bf 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c
> @@ -1209,7 +1209,7 @@ int dat_peek_cmma(gfn_t start, union asce asce, uns=
igned int *count, u8 *values)
>  	int rc;
> =20
>  	rc =3D _dat_walk_gfn_range(start, start + *count, asce, &ops, DAT_WALK_=
DEFAULT, &state);
> -	*count =3D state.end - start;
> +	*count =3D state.end >=3D start ? state.end - start : 0;

[Severity: High]
This is a pre-existing issue, but since we are modifying how count is
calculated for the values array, does this code leak uninitialized kernel
memory to userspace?

If KVM_S390_GET_CMMA_BITS is called on a memory range containing clean pages
or unmapped holes, it allocates the values buffer using vmalloc() which does
not zero-initialize memory:

arch/s390/kvm/kvm-s390.c:kvm_s390_get_cmma_bits() {
    ...
	values =3D vmalloc(args->count);
	if (!values)
		return -ENOMEM;
    ...
	if (copy_to_user((void __user *)args->values, values, args->count))
    ...
}

During the walk, dat_peek_cmma() and dat_get_cmma() can skip clean PTEs and
empty CRSTEs without writing to the values array. For example:

arch/s390/kvm/dat.c:__dat_peek_cmma_crste() {
    ...
	if (crstep->h.i)
		state->end =3D min(walk->end, next);
    ...
}

arch/s390/kvm/dat.c:__dat_get_cmma_pte() {
    ...
	if (!READ_ONCE(*pgste_of(ptep)).cmma_d)
		return 0;
    ...
}

Since the gap in GFNs is included in the returned count, does the
copy_to_user() call in kvm_s390_get_cmma_bits() end up copying the entire
length and leaking those uninitialized vmalloc gaps to userspace?

[Severity: Medium]
This isn't a bug introduced by this patch, but while looking at the CMMA
addressing failure paths, is there an issue with how out-of-bounds accesses
are reported by KVM_S390_SET_CMMA_BITS?

If an invalid start_gfn is provided, dat_entry_walk() returns a positive
program exception code:

arch/s390/kvm/dat.c:dat_entry_walk() {
    ...
	if (!asce_contains_gfn(asce, gfn))
		return PGM_ADDRESSING;
    ...
}

This positive value (5) appears to be propagated directly back to the ioctl
result in kvm_s390_set_cmma_bits():

arch/s390/kvm/kvm-s390.c:kvm_s390_set_cmma_bits() {
    ...
			r =3D dat_set_cmma_bits(mc, kvm->arch.gmap->asce, args->start_gfn,
					      args->count, args->mask, bits);
		}
	} while (r =3D=3D -ENOMEM);

	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);

	return r;
}

Could this cause userspace checking for standard Linux error codes
(ioctl() < 0) to incorrectly assume the KVM_S390_SET_CMMA_BITS ioctl
succeeded when it actually failed?

>  	/* Return success if at least one value was saved, otherwise an error. =
*/
>  	return (rc =3D=3D -EFAULT && *count > 0) ? 0 : rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624111928.1442=
83-1-imbrenda@linux.ibm.com?part=3D5

