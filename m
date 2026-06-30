Return-Path: <linux-s390+bounces-21324-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d7KyFBVSQ2qwWwoAu9opvQ
	(envelope-from <linux-s390+bounces-21324-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 07:20:21 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D26F6E077A
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 07:20:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SMAIW8hV;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21324-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-21324-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 803DE3002533
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 05:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A057D38AC61;
	Tue, 30 Jun 2026 05:20:16 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8301C35B62C
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 05:20:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782796816; cv=none; b=UN2CMJ0JKS+gFGTW+waQ+HXhPUE5593sBKPyt2W4Q4rTPN8omMRNFFoNEW7HxvjPZw3uKCnvNpoukN0P+mfu6FXFsSlyZgtlv1YCK2oLsCE3G58A7d69mYZXw0v5MCjCxK1sfbvC6hawnLcEpYtXbmBPk1uQZTCoSEQKliavxKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782796816; c=relaxed/simple;
	bh=e6KlKtzePbV+zMcTpasV2HWulL7qaEMighWpquHawb8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ePQb+T02ZV4RFwuWN4sYBOpz5SMzlTFy93d+JKaFJL5jQKK5eih4OzcNaCtKaU4ViUCkOJNBtlrAyNIREk0/7GpkaEZIsnzKby0nyCXFZ5UkZVrcBqcN7T/OJwrTvUBZahI2UHTXffs7xKGWVp1jiLnyNIDAHnlhPYg+AMZkrHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMAIW8hV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D6A1F000E9;
	Tue, 30 Jun 2026 05:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782796815;
	bh=7aIwCncntx+37C1CwTRk8o29WntgU5kZ7FYjDeGOaCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SMAIW8hVilNvWw2NX6wd+h1CeAp+r2kYUiOatjoWs0pIt9SjhGFJ6QVklHzKbcU+J
	 FJGeOg19tcBaXavbH2RinklDP1rrz+PuDleErAdl01MGl1aiv1Y0cPy4SUk2+Htu3n
	 0ErlY3FPFhtXm4L8JOlAyf9iqQuj6NpPucYsio2Rmut6pEs4aMGE02+eiTtpbnfXrj
	 IfQ8GnnKP1Y75PnVpzHzHi9KalSdl2yaC6f0zRdpX+UGnyRYMH/5zMfqSiSW2QjtPp
	 8MjucVzZjacKkTp2erFOWFni5G8hSY5vnCP7glEuSBKA3MStYEAGrbmBf3rR5/COPZ
	 XGqfU5eCS0kpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/8] futex: Use runtime constants for __futex_hash()
 hot path
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260630045531.3939-9-kprateek.nayak@amd.com>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-9-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 05:20:13 +0000
Message-Id: <20260630052014.C7D6A1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21324-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url,infradead.org:email,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kprateek.nayak@amd.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D26F6E077A

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Accessing the runtime constant accessor `futex_queues()` immed=
iately after `runtime_const_init()` in `futex_init()` causes a deterministi=
c kernel crash during boot due to compiler hoisting and pipeline hazards.
--

commit e05e661cc5e69b283700fa99f0da313e4673aa43
Author: Peter Zijlstra <peterz@infradead.org>

futex: Use runtime constants for __futex_hash() hot path

This commit converts the read-only after init data __futex_shift,
__futex_mask, and __futex_queues used in the __futex_hash() hot path to
runtime constants. It also dynamically allocates __futex_queues based on
nr_node_ids instead of a static maximum. Runtime constants are initialized
in futex_init() using runtime_const_init().

Link: https://patch.msgid.link/20260227161841.GH606826@noisy.programming.ki=
cks-ass.net

> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c

[ ... ]

> @@ -2020,10 +2016,19 @@ static int __init futex_init(void)
>  	hashsize =3D max(4, hashsize);
>  	hashsize =3D roundup_pow_of_two(hashsize);
>  #endif
> -	futex_hashshift =3D ilog2(hashsize);
> +	__futex_mask =3D hashsize - 1;
> +	__futex_shift =3D ilog2(hashsize);
>  	size =3D sizeof(struct futex_hash_bucket) * hashsize;
>  	order =3D get_order(size);
> =20
> +	__futex_queues =3D kcalloc(nr_node_ids, sizeof(*__futex_queues), GFP_KE=
RNEL);
> +
> +	runtime_const_init(shift, __futex_shift);
> +	runtime_const_init(mask,  __futex_mask);
> +	runtime_const_init(ptr,   __futex_queues);
> +
> +	BUG_ON(!futex_queues());
> +
>  	for_each_node(n) {
>  		struct futex_hash_bucket *table;
> =20
> @@ -2037,10 +2042,9 @@ static int __init futex_init(void)
>  		for (i =3D 0; i < hashsize; i++)
>  			futex_hash_bucket_init(&table[i]);
> =20
> -		futex_queues[n] =3D table;
> +		futex_queues()[n] =3D table;

[Severity: Critical]
Does using the futex_queues() accessor here in futex_init() right after
runtime_const_init() cause a boot crash?

Since runtime_const_ptr() expands to an asm_inline block with no memory
dependencies or volatile qualifiers, the compiler might treat it as a pure
computation. This means the compiler is free to hoist the evaluation of
futex_queues() before the runtime_const_init() patching loop executes, or
it could evaluate it once and reuse the cached dummy register value.

If the compiler hoists this evaluation, won't this BUG_ON() and subsequent
assignment dereference the unpatched dummy pointer and cause a deterministic
kernel panic during early boot?

Would it be safer to directly use the raw global variable __futex_queues
instead of the futex_queues() accessor inside this initialization function?

>  	}
> =20
> -	futex_hashmask =3D hashsize - 1;
>  	pr_info("futex hash table entries: %lu (%lu bytes on %d NUMA nodes, tot=
al %lu KiB, %s).\n",
>  		hashsize, size, num_possible_nodes(), size * num_possible_nodes() / 10=
24,
>  		order > MAX_PAGE_ORDER ? "vmalloc" : "linear");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630045531.3939=
-1-kprateek.nayak@amd.com?part=3D8

