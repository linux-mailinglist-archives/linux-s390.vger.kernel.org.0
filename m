Return-Path: <linux-s390+bounces-20895-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WSClEfL+MGroaAUAu9opvQ
	(envelope-from <linux-s390+bounces-20895-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2026 09:44:50 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E91968CEC9
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2026 09:44:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=vixAGDlw;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20895-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20895-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3A033167993
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2026 07:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44CA3C37A3;
	Tue, 16 Jun 2026 07:39:43 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8156340759F
	for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2026 07:39:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781595583; cv=none; b=jAJ/bzK6ubajVB0/gi1AgNJ6MLFpHEgHbFHNoSEQNtYGFWu9/tCO8YNn/BOJOaRLh0MH8gbZc+MGeeTm6LI8XoW3NDxaS/wPPhLUm3B9eUc8QwCZPO9wjDISc+Yw6G1pGCQM92Q/6F0rWIbyQcVRHB0ym5H9epJ37Qd1Q5V9Icw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781595583; c=relaxed/simple;
	bh=a9BPupFzCU9qnN+Tmw3pyrgUOK+2sME139C0iZGuU8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KmMqYTaCXEGKINYpK1aJAimLkCXZtonhujsT8EH5PVJcKZ+WF/nljZ0RVc8NWRVsGKuWNcpjmh8mqx/8SbO4/sQGOyzjhJway5wzJZh4ZzvYFwdVVNaJ8J+jQ5s4ozvhCxa/Nt3nquAM5OsR8cx3mPv8qgKSXgSY9v7+fytLdvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vixAGDlw; arc=none smtp.client-ip=209.85.128.74
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490bde3d239so28187025e9.1
        for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2026 00:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781595581; x=1782200381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeV6OWdY3YVjqB1P2Z2C3YunU6qvdcn/g4DW6HL57sE=;
        b=vixAGDlwNPO+gYqXr8zMGlc000dmG2VtAF8HmTLKqBsydTxOR7frwVSnyFcEU2N9kL
         Ru6+drV4RmrAgnyRl6VkjRj6VSzfTIhawZCCmPiy2h6SGgKjkWeDshk/ytwtg9IwXa8z
         Qhe1qeojTYLQMAyPZSxzVwX0PZkD5dGTWBWTotY0xyLFKNwhH8SHdX8GRkFNJwf6ibyR
         Va2DsC4+PzH8TbmSaW29FedljvEA5vvtsuPlRrCP8XRheFNm+Ojix3d8etKj6hA1TYV8
         2q2uGJpS8zM/renjATfIXUy1llIpxvFA3zwH2l4WvriYDF0ncrvliicxIAxJfbzNgTbE
         1Pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781595581; x=1782200381;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QeV6OWdY3YVjqB1P2Z2C3YunU6qvdcn/g4DW6HL57sE=;
        b=Nk3LbvQi9F8zSENUbnR4cHxqQ7fqdkzNwxF2lnUYAgfHbiR+dWIcPxna0Dz69HmnmO
         U8jtJz/4SBykE+V1dpcKwozPhRQgWWzyFVTeMjdCizgPJTmy9pJPs5TqyfqAoKeWZ4Mq
         W4SeVphvQ80vp88JsRnDLml+BIxgSZlW1P1yds8M3mVAgskF/VLDinprt0FT7VQJ3kM/
         /17RMRxOJ0fPEIInS4UMjTN+CWMGSERCbkszMwI9PhDVlNS7DjpFDnjtdSjuEW30CKrO
         FW/sr+AIjJOCAGY2DcuEKFZ06cd06Bk5VbLmzTocLQ49Meh0p1zYqO64iOOOZ7sgB32m
         5B3g==
X-Forwarded-Encrypted: i=1; AFNElJ+ZF1XbAvE6LV2ekzPmDFWfCGG/h8wrEZ45DEhZ3CGgOReYUfQwHG03F2QYhzv7486P4HooutMKGIi9@vger.kernel.org
X-Gm-Message-State: AOJu0YzS+69UozFbJ1Lm9AWJqNvs8w+sVYkSU7Zsim9Xp1M9fOciqieF
	dkl+BAF+nv+IdtC6IScDtQjy4qVrJBOLOQT5B2jMnURkyay3isx0kwBTJ1uyxs1E233HnVYYHX5
	LMBp9BDQ2DMPJGEX/Ng==
X-Received: from wmsk6-n2.prod.google.com ([2002:a05:600d:8486:20b0:490:3fd8:77de])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6995:b0:48f:d5b8:5b07 with SMTP id 5b1f17b1804b1-4922ffb64e2mr31069555e9.20.1781595580272;
 Tue, 16 Jun 2026 00:39:40 -0700 (PDT)
Date: Tue, 16 Jun 2026 07:39:39 +0000
In-Reply-To: <CANiq72nkm2YwxcV+vwDj+v0svd6e1dro-W_0ybVms3pG_oJiXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260608181451.3734956-1-japo@linux.ibm.com> <20260608181451.3734956-7-japo@linux.ibm.com>
 <20260615164013.GA249489@ax162> <CANiq72nkm2YwxcV+vwDj+v0svd6e1dro-W_0ybVms3pG_oJiXg@mail.gmail.com>
Message-ID: <ajD9uw7MhsisxdzY@google.com>
Subject: Re: [PATCH v6 6/6] s390: Enable Rust support
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Jan Polensky <japo@linux.ibm.com>, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, ojeda@kernel.org, 
	peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:miguel.ojeda.sandonis@gmail.com,m:nathan@kernel.org,m:japo@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:ojeda@kernel.org,m:peterz@infradead.org,m:jpoimboe@kernel.org,m:jbaron@akamai.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:dakr@kernel.org,m:rostedt@goodmis.org,m:ardb@kernel.org,m:linux-s390@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:miguelojedasandonis@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-20895-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[aliceryhl@google.com,linux-s390@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,infradead.org,akamai.com,garyguo.net,protonmail.com,umich.edu,goodmis.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E91968CEC9

On Mon, Jun 15, 2026 at 06:45:26PM +0200, Miguel Ojeda wrote:
> On Mon, Jun 15, 2026 at 6:40=E2=80=AFPM Nathan Chancellor <nathan@kernel.=
org> wrote:
> >
> > With Rust 1.96.0, I see the following warning several times when
> > building Rust code in -next:
> >
> >   warning: unstable feature specified for `-Ctarget-feature`: `backchai=
n`
> >     |
> >     =3D note: this feature is not stably supported; its behavior can ch=
ange in the future
> >
> >   warning: 1 warning emitted
> >
> > I assume this is expected? If so, is there a way to silence this warnin=
g?
>=20
> Yes, it seems so -- please see this thread:
>=20
>   https://lore.kernel.org/rust-for-linux/CANiq72m4GVWFYqnxNtCHTPu7XcGewHB=
5LNwOoayTfnXs9pPbNg@mail.gmail.com/
>=20
> If they are OK with it, then I guess it is fine, but it does mean CIs
> can suffer a bit from it.

Since fixing this requires a change in rustc to recognize the backchain
target feature, has this work been started? I think that for stuff like
this, we should make to at least start working on fixing the warning so
that we don't emit a warning forever.

Alice

