Return-Path: <linux-s390+bounces-20860-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ibsvM1r9L2qDLQUAu9opvQ
	(envelope-from <linux-s390+bounces-20860-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 15:25:46 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 330E2686BAD
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 15:25:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cbL1sOw6;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20860-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20860-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73DF53048907
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 13:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E663F4843;
	Mon, 15 Jun 2026 13:21:59 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB103F39FE;
	Mon, 15 Jun 2026 13:21:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529719; cv=none; b=bjjAYQrPL7hy/oha/PJwPGrFt85L2aUy7jLstY7t35LR/tqZ+WRsE+Sy3OVvseCvbL4Svk/JkRKQvHtI4toPJQNTVZKhZuD8k9X4Up9MCDlWHaTn9IyZAfH54DXHKKlxygR+r8i/ER4fzzQm7F8pq7qaki+qmQIIfIeaDcQ5o0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529719; c=relaxed/simple;
	bh=iEef8TRCS9zV22imcGdC9mfgEzyAY7Y6qLs60HjnZq0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=th+e58vXyFv6rpXovyAHY9BpNvaqSCBuQZBWKgT8BWZquFafyLsGonjjxOrFYUwuHlw17r57C0rqJDbWo3m0EEPT3D0ocLsgyw+dqHusxozQOG8fTzjYNyF24M1VZAZODfTbPDcVpwIcsIhejtuFBbTDgmz2V97BNr1kXMVJeVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbL1sOw6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F84D1F000E9;
	Mon, 15 Jun 2026 13:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781529718;
	bh=5GwdBq/cMTjESFPfUzt8oxdW/f4oReIXlY197p8o+Xw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cbL1sOw6vF4LLA5f6ZRoeqUViJ4UP8yUEHuW2Eq7k1jN9Tb20+oiqaTMlsCa/X52p
	 WpcWzZWL3g/KLcSzl0rkOWNpSmCNi44bGn67sBFeYedgjQiRnQndH2Q6RSa4p4l2CJ
	 28eDkAcyHuxitRdoe+aTp8SjHsp9YEjJOKz250lYG8hpSrjMHwrrDZNa1aLODAsPIu
	 bb+cvC+pEopYgiije6rGTkTRYff0/kw8Y3O7Dae/ev7nkc/NMdaVbirTuZQX1l0VW9
	 kFKc2HuR2E9kpxgDOKwsTcYFGj7kkkX0QYjkQ2wtZiAvq36H7yjYkDpO4EQwcno3a/
	 mJUMBwHi1zl8A==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 15/17] KVM: s390: Add map/unmap ioctl and clean
 mappings post-guest
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260615124243.187614-16-imbrenda@linux.ibm.com>
References: <20260615124243.187614-16-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 13:21:57 +0000
Message-Id: <20260615132158.5F84D1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-20860-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:linux-s390@vger.kernel.org,m:gor@linux.ibm.com,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:kvm@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 330E2686BAD

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added `!addr` check in `kvm_s390_adapter_map` and `kvm_s3=
90_adapter_unmap` incorrectly rejects GPA 0.
--

commit a3f46a9fac83fcdf67e052053b6923a848a2c796
Author: Douglas Freimuth <freimuth@linux.ibm.com>

KVM: s390: Add map/unmap ioctl and clean mappings post-guest

This commit adds map and unmap ioctls for s390 adapter set indicator pages.
It introduces lifecycle tracking for mapped pages using pin_user_pages_remo=
te
and adds statistics counters to track map and unmap requests.

Message-ID: <20260604192755.203143-2-freimuth@linux.ibm.com>

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
[ ... ]
> +static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 =
addr)
> +{
> +	struct s390_io_adapter *adapter =3D get_io_adapter(kvm, id);
> +	struct s390_map_info *map;
> +	unsigned long flags;
> +	__u64 host_addr;
> +	int ret, idx;
> +
> +	if (!adapter || !addr)
> +		return -EINVAL;

[Severity: Low]
Does this address check incorrectly reject mapping guest physical address 0?

The ioctl argument addr represents a guest physical address. In the s390
architecture, guest physical address 0 points to the Prefix Save Area, which
is a valid memory location. Treating an address of 0 as an invalid mapping
request rejects a legitimate architectural address.

> +
> +	map =3D kzalloc_obj(*map, GFP_KERNEL_ACCOUNT);
[ ... ]
> +static int kvm_s390_adapter_unmap(struct kvm *kvm, unsigned int id, __u6=
4 addr)
> +{
> +	struct s390_io_adapter *adapter =3D get_io_adapter(kvm, id);
> +	struct s390_map_info *map, *tmp, *map_to_free;
> +	struct page *map_page_to_put =3D NULL;
> +	u64 map_addr_to_mark =3D 0;
> +	unsigned long flags;
> +	int found =3D 0, idx;
> +
> +	if (!adapter || !addr)
> +		return -EINVAL;

[Severity: Low]
Similarly here, should this unmap function allow guest physical address 0?

> +
> +	spin_lock_irqsave(&adapter->maps_lock, flags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615124243.1876=
14-1-imbrenda@linux.ibm.com?part=3D15

