Return-Path: <linux-s390+bounces-21064-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qkOzEcVqNWo2vwYAu9opvQ
	(envelope-from <linux-s390+bounces-21064-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 18:13:57 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0B56A6FC9
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 18:13:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VByAs5rF;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21064-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-21064-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D47313062A7B
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 16:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C2A3BE659;
	Fri, 19 Jun 2026 16:07:42 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882103BE651;
	Fri, 19 Jun 2026 16:07:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885262; cv=none; b=dOFPTUzK+Mc+MK5/jLwn4Mp7Z9jPHNZX2zcHRDNtxpxP18FUIje8N7R75EK6u6WPwqJKhrb2UhuJ6CVJK8l7XKBjGemRnmPh1wHR8MnZSrJnheP0GIO0FmRVYMuhPHpHVSWiX4xYfv7yGYeUAbWp5yypm8eM7EnJFCBZFbw+smQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885262; c=relaxed/simple;
	bh=pMeG0Yt4sroTMK4A3H1jmTR5Br3fTANChHh8riTDzmg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q/G3+wCnPvallDndgqMEhPQ7TEcoD+wZYZ1mxDOncD5UdBsyS9aXSe02hCSI9z1Nbvp7IwdGUJwc/fDtMYrgTHnIhfY14jSI/Hwitwnz37QqsbTLNJuvW5lzj7ta/BKoRpWXuOnt372s/i6qasSn+3ReK4mRotVijFUwRu6eSHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VByAs5rF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7361F000E9;
	Fri, 19 Jun 2026 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781885261;
	bh=BKCJcujHc5X7XeC8KOW30bxhpDd8OznKWhkH+zeaagg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VByAs5rFBo9qMhUK5pafn5TZP0GErScyRaYEaO1frgl8u/MtgL2gzIecK5YHL0WYS
	 nGJE2nXdN/XJeS8+iY8MnR/KvnOmuFeKJJUmBkvVvxqec6H7UqnnfYW52YcFjCN0Qm
	 gDT3Gxdk8OH+QTp4S/wd3uzTTQVU4eiaFuSqVwY2v57n5caGNDt/8BlRb2+F76h67d
	 raZTjic7NLkcwwsB8Fm2AFG+aqSKz2E8vMQ0X7syyB/NtIiA1NNf2FPvHLwRMVD9o+
	 U8E6CgEOKHVGULldqO6nhM/1cCgl034nski6UhgKvQCKr7BsaWg5b94NruRud5gBYX
	 28Bkp73jflXUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/7] KVM: s390: Fix dat_peek_cmma() overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260619155154.307572-3-imbrenda@linux.ibm.com>
References: <20260619155154.307572-1-imbrenda@linux.ibm.com>
 <20260619155154.307572-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 16:07:40 +0000
Message-Id: <20260619160740.DE7361F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21064-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:hca@linux.ibm.com,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: AE0B56A6FC9

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Uninitialized kernel memory leak in kvm_s390_get_cmma_bits() v=
ia vmalloc array.
- [High] kvm_s390_set_cmma_bits() silently ignores memory allocation failur=
es.
--

commit 198324f8297a62f137ba34c4a9aa74e25bb30e54
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix dat_peek_cmma() overflow

This commit fixes an underflow in dat_peek_cmma() when userspace passes an
out-of-bounds start address. By enforcing that the count is set to zero if
the end address is smaller than the start address, it correctly propagates
the -EFAULT error instead of erroneously reporting success.

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
>  	/* Return success if at least one value was saved, otherwise an error. =
*/

[Severity: Critical]
This isn't a bug introduced by this patch, but does the CMMA retrieval path
leak uninitialized kernel memory to userspace?

In kvm_s390_get_cmma_bits(), the values array is allocated with vmalloc():

arch/s390/kvm/kvm-s390.c:kvm_s390_get_cmma_bits() {
    ...
    values =3D vmalloc(args->count);
    if (!values)
    ...
}

During the page table walk, if __dat_peek_cmma_crste() encounters an invalid
CRSTE, it advances the boundary but leaves the corresponding state.values
unpopulated:

arch/s390/kvm/dat.c:__dat_peek_cmma_crste() {
    ...
    if (crstep->h.i)
        state->end =3D min(walk->end, next);
    ...
}

Similarly, __dat_get_cmma_pte() skips clean pages:

arch/s390/kvm/dat.c:__dat_get_cmma_pte() {
    ...
    if (!READ_ONCE(*pgste_of(ptep)).cmma_d)
        return 0;
    ...
}

Because vmalloc() does not zero-initialize memory, could these gaps in the
array leak kernel heap memory when the array is unconditionally copied back
to userspace using the advanced state.end count?

[Severity: High]
This is a pre-existing issue, but does kvm_s390_set_cmma_bits() silently
ignore memory allocation failures?

If vmalloc() fails to allocate the bits array, the code jumps to the out
label:

arch/s390/kvm/kvm-s390.c:kvm_s390_set_cmma_bits() {
    ...
    bits =3D vmalloc(array_size(sizeof(*bits), args->count));
    if (!bits)
        goto out;
    ...
}

Since the return variable is initialized to 0 and not updated to a negative
error code like -ENOMEM before this jump, will this return 0 to userspace
and silently drop the CMMA bits, potentially leading to guest memory
attribute corruption during migration?

>  	return (rc =3D=3D -EFAULT && *count > 0) ? 0 : rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619155154.3075=
72-1-imbrenda@linux.ibm.com?part=3D2

