Return-Path: <linux-s390+bounces-21098-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JlS3DJhhOWpmrQcAu9opvQ
	(envelope-from <linux-s390+bounces-21098-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 18:23:52 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 976FA6B119E
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 18:23:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=n3lSje7S;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21098-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-21098-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 984E930193AE
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 16:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4A3315D46;
	Mon, 22 Jun 2026 16:23:49 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A6F18FDBD;
	Mon, 22 Jun 2026 16:23:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145429; cv=none; b=C1jgcoQsKrvUD88MKR4mOWnfUOdVLAx7JTk5pYq8IrEhBirL1EiUKFQIvhSGttaT7/D7+1rijo2FaREhRP4s+LZ+K5eCND2V9uGO+x1hNQ3g//q48f9OlyhCGy9AY7Bcqmukul+LTTDo/hLxjt7SQbpW3XdlwzKFkG4kGr5EtHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145429; c=relaxed/simple;
	bh=RgdaPvhkpmS7WhDbF5RgP7GJAT9Pv3FYk3udCe3PYNU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XYmw1lCMAnURPACFzYRlMDVxMy718/nmmmZVOp+Cd2NH1yJthphYcg01p176Lxrw/7voXgKlGnCKnEtS5JPsK7DxavOso2t7XGmZ4tClunZwIe1Jy4VZ8Q9Ds8XB47MeeOqnvZWred53qB33qa8ajGf1GDHNpoGU3LovDeqNT8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3lSje7S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B201F000E9;
	Mon, 22 Jun 2026 16:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782145428;
	bh=u2P1UN6ALKMG8Dc29rymykvnJlNOEfojmFJcCZvfIUY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n3lSje7SNjUVI0mHhpeTq71FgVgDvGeCcwJ6n/dlZ39CUtmake9PV1DHvWg+9ec2v
	 i3VlODSYzUn0/SKevdzq+r0Zxid8tsC4rpiEXE+2wEtSXRmlkV10Yxg6RPkXlXYvKP
	 ggOppfW1C3CGK48e2noVNdhbL7zZPVID1J5dGxJF5Xq6zgqoaa2ot3zv5DeyNXrKfr
	 uVNEkSKVzavmNg42vhQi1LmKzNPGYSfu98nJft8G5lg3huvlhTKCyoAHjpBvc2PHAj
	 EjinZ3vKSt8WOgJJ/hLovz/DqpdQg0KSzIj7+jevYSY2Q3pWsLAfnnblHDUjlra4/7
	 xBgFesYdArkQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/9] KVM: s390: Fix dat_peek_cmma() overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260622160739.202044-3-imbrenda@linux.ibm.com>
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
 <20260622160739.202044-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 16:23:47 +0000
Message-Id: <20260622162348.33B201F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21098-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:hca@linux.ibm.com,m:kvm@vger.kernel.org,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 976FA6B119E

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized kernel memory is leaked to userspace during CMMA pee=
k and get operations due to gaps left in the vmalloc'd buffer.
--

commit 7a3f41eb2c82217db779d886fe0375b646e0440a
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix dat_peek_cmma() overflow

This commit addresses an integer underflow in dat_peek_cmma() where an
out-of-bounds start address returns -EFAULT but leaves state.end at 0. It
corrects the behavior by ensuring the returned count is only updated if
the end address is greater than or equal to the starting address.

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
This is a pre-existing issue and was not introduced by this patch, but does
this leave uninitialized kernel memory in the values array that gets copied
to userspace?

Looking at kvm_s390_get_cmma_bits() in arch/s390/kvm/kvm-s390.c, the values
buffer is allocated with vmalloc() instead of vzalloc():

kvm_s390_get_cmma_bits() {
    ...
    values =3D vmalloc(args->count);
    ...
}

During the page table walk, if __dat_peek_cmma_crste() encounters an
invalid PMD, it advances state->end without populating state->values:

__dat_peek_cmma_crste() {
    ...
    state->end =3D min(walk->end, next);
    ...
}

Similarly, in __dat_get_cmma_pte(), clean pages are skipped without writing
to the values buffer:

__dat_get_cmma_pte() {
    ...
    if (!READ_ONCE(*pgste_of(ptep)).cmma_d)
        return 0;
    ...
}

Because the count returned by dat_peek_cmma() and dat_get_cmma() represents
the span from the start to state.end, any unpopulated gaps in the values
array will contain whatever uninitialized kernel heap memory vmalloc()
provided.

When kvm_s390_get_cmma_bits() later copies this buffer:

kvm_s390_get_cmma_bits() {
    ...
    if (copy_to_user((void __user *)args->values, values, args->count))
    ...
}

Can these gaps leak uninitialized memory to userspace? Should the buffer be
allocated with vzalloc() to ensure any gaps left by the walk are safely
zeroed out?

>  	/* Return success if at least one value was saved, otherwise an error. =
*/
>  	return (rc =3D=3D -EFAULT && *count > 0) ? 0 : rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622160739.2020=
44-1-imbrenda@linux.ibm.com?part=3D2

