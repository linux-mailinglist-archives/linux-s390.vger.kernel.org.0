Return-Path: <linux-s390+bounces-20922-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2uxSFYKEMWq6lQUAu9opvQ
	(envelope-from <linux-s390+bounces-20922-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2026 19:14:42 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EAE692E75
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2026 19:14:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ABOckunw;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20922-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20922-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 528F632414BC
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2026 17:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1564779B1;
	Tue, 16 Jun 2026 17:03:44 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E28328610;
	Tue, 16 Jun 2026 17:03:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629424; cv=none; b=FrKDp/3PFuEsoPW3+ZVMNYJq89sfefXQJYjdlAGXbRnADXPMZFDTvNVZYXkT3eeEAH6t10EVMDzs+67ll5rJvITcNjXZ4ZPQQLqJywwrGPu6DoLby0TE7/icNU6eoKVvvnB8Kx2sboJWqnNU4ThK3AHPzyuniRjdGJ4t3Fhz6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629424; c=relaxed/simple;
	bh=b4OWftl7QvwrjMR+uykCb/YJCG7izcr3evAJqvvqwb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wj4Wl+BLax2+Hi5d0pHCTETaPe62uetOM+M0k8Mx5wAiokqzXwKKB6WR573klUtC4GUyGUP9c/5XaJqyoAIoI4OpgQQmkIeknxUlyup3C1wyHMvhqiMf0N+QFs1e4RjkTan1Mi4dCqm7LO/oghbRSwUqKY9cw8ledQ+qXN9MsNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABOckunw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6961F000E9;
	Tue, 16 Jun 2026 17:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781629423;
	bh=heh+0+fn1QlyQuK6UCL2qSShItxfzKRue+vROYYsbSw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ABOckunw3I1iY60iih/TSjOAbHDfyaDdS9QSR3FO2U8vtQGmwwxX9FKPUe3D1oJgs
	 pZE6pler3ft0bUJeXMbK3nWbZyiaETDJZ5Cr+83PvQ3Y7Law9gP+Zr2poaQAbSMtiM
	 91fibdQKXe0SFAvcOsx9JnXOmr9lHk+5jOGapvJzC6RrF+KGXCe/OPOVqiCM3el6YS
	 u+uDGT7KBNRkYUvO+TMXMBQmjBppTVds9gwhP+Q0GstrWJgJm2gCkG1xvHGKY9m/K2
	 Jpgf1t9l8B9X4awl4xbUE+8I7gx395jefXDwLykeNbWD8V5sjBxA5H9hbugLb7iFNM
	 U9Mb8x+2NpXGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] KVM: s390: Fix dat_peek_cmma() overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260616165110.360921-3-imbrenda@linux.ibm.com>
References: <20260616165110.360921-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 17:03:42 +0000
Message-Id: <20260616170343.4E6961F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20922-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9EAE692E75

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] kvm_s390_get_cmma_bits() leaks uninitialized kernel heap memor=
y to userspace because the vmalloc buffer is partially populated and skippe=
d indices remain uninitialized.
--

commit f6af8b3c3817150f3fd3255f80c30b252be59298
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix dat_peek_cmma() overflow

If userspace passes a start address that is out of bounds,
_dat_walk_gfn_range() will fail with -EFAULT, but state.end will not be
touched and will stay 0. This will cause *count to underflow and report
a very high number, and the function will end up erroneously reporting
success.

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

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential information leak to
userspace related to how this count is populated.

In arch/s390/kvm/kvm-s390.c:kvm_s390_get_cmma_bits(), the buffer is
allocated with vmalloc() instead of vzalloc():

	values =3D vmalloc(args->count);

During the walk, __dat_peek_cmma_crste() can skip unmapped regions by
advancing state->end without writing to the values array:

	if (crstep->h.i)
		state->end =3D min(walk->end, next);

Similarly, __dat_get_cmma_pte() can skip clean pages within the max bit
distance without writing anything:

	if (!READ_ONCE(*pgste_of(ptep)).cmma_d)
		return 0;

Since this *count value directly determines how many bytes copy_to_user()
copies in kvm_s390_get_cmma_bits(), can this leak uninitialized kernel
memory to userspace if the skipped entries leave gaps in the array?

>  	/* Return success if at least one value was saved, otherwise an error. =
*/
>  	return (rc =3D=3D -EFAULT && *count > 0) ? 0 : rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616165110.3609=
21-1-imbrenda@linux.ibm.com?part=3D2

