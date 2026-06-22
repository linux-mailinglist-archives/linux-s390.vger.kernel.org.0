Return-Path: <linux-s390+bounces-21103-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 23awN9ZrOWqwsQcAu9opvQ
	(envelope-from <linux-s390+bounces-21103-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 19:07:34 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 390756B1608
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 19:07:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Woz6bUXz;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21103-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21103-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 080BF3009514
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 17:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF4233F5B4;
	Mon, 22 Jun 2026 17:07:32 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974A523536B
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 17:07:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148052; cv=none; b=StkyzyevxBJsqhAza49GDUDZUa86ckfXfivnnX/47jIKW5st/AGEQKRoPFCspNqDOZzx0UQgNxEZ+XXdLdU5H/pEIb+Xf82AYawydgUFODb7AXXGIEpJN8Wi5tMsMvhhrJH28EhLAVlvyk64yYI4fHkIBtKHiba/bs13vc5mjnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148052; c=relaxed/simple;
	bh=c2+6ZuLDCY6ck719urD1l3DG0slVGM+vvWi5oUZnApk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVE9wFBoSrxLYnafSLHLehMd3CDaYFbvthX89aQf9V42yTU7QaoEPa1VgB9M/9HhZaj0VVATqDigSZ3s9yosuI2e6KPHWxxPSZCuSO6+gZOHtEfuY/OVSNW4rxvdmXFrTXlS/UTGDVSFX9zhonWbRvNmDMUZrOQ3kw9S5APxeUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Woz6bUXz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B331F0155A
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 17:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782148051;
	bh=c2+6ZuLDCY6ck719urD1l3DG0slVGM+vvWi5oUZnApk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Woz6bUXzEBKQEcCOEALFI8tfOJIvtuoj+wfvFWrIrMd87C/q9dGPte6mGldDcns/N
	 +H1Y70i1kUrZCbcBwc190/O23B6ij14ZLWtNlOmWctHzXXPsefFX1EGfUY8PNl0pc/
	 4ZBc73IMlIekm9rh6HFb422xoj/uYvqooj1bvosngNvy+6QhIvtqR8VmTxH5MB+f1M
	 j/BdIc7XWPFVJE70fx3c+aq18Ueid/5v1eGomzrwBcg3ngTGq3oK5uliUdZn77GkKf
	 UBIt/gVYKxUSoi5shRKivssM9MEuhgH1kv8EVwfnP4KlGTwlh2NQcdPKTJIktzufTl
	 AW7fKoVbtRZTA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa68cd8dd3so4419404e87.0
        for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 10:07:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ83mPSqxCCz8E957THGg9KnDHyGiejoiauJ763wxfpf/TBQ2/HAFayIYfmg/B2aGryjo8crKbPtK8Se@vger.kernel.org
X-Gm-Message-State: AOJu0YwWv1IPWcq2gYQ31job//a9V5pcc0ndag0QQNrKgOEfmEwtl1p+
	wP8jrnH9jRER88arn+oN8Bdbm/i3Az/cURJ+/jmwMIr+5stxjGE2XItuggLFX0yxt4+fSZreH+M
	DTKwaQckje37lz9m7j9Pvwb47/HfzcjU=
X-Received: by 2002:a05:6512:3583:b0:5ad:4ced:9ca2 with SMTP id
 2adb3069b0e04-5ad5771f134mr3185992e87.48.1782148049795; Mon, 22 Jun 2026
 10:07:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
 <e624cd2b-9b07-4e7e-bab3-0cf73e9f9db9-agordeev@linux.ibm.com>
 <749b0206-f2d5-44dc-b95b-5ade0bf3801a@arm.com> <09172d0f-e0d4-48c0-9504-698981de5495-agordeev@linux.ibm.com>
In-Reply-To: <09172d0f-e0d4-48c0-9504-698981de5495-agordeev@linux.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Jun 2026 19:07:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ifKbS3MNg34PKpr3ECr70ZR88YrdsoKn-UxXkmhYGCPQ@mail.gmail.com>
X-Gm-Features: AVVi8Ced5fKGuIGrUrjqIhM5cMHqvHrPDObXaUb3BAMePzDRDAGHRYkwazaSCOA
Message-ID: <CAJZ5v0ifKbS3MNg34PKpr3ECr70ZR88YrdsoKn-UxXkmhYGCPQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] s390/idle: CPU idle driver
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Loehle <christian.loehle@arm.com>, Mete Durlu <meted@linux.ibm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21103-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:agordeev@linux.ibm.com,m:christian.loehle@arm.com,m:meted@linux.ibm.com,m:rafael@kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:svens@linux.ibm.com,m:anna-maria@linutronix.de,m:frederic@kernel.org,m:mingo@kernel.org,m:tglx@kernel.org,m:daniel.lezcano@kernel.org,m:borntraeger@linux.ibm.com,m:iii@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[rafael@kernel.org,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 390756B1608

On Fri, Jun 19, 2026 at 1:35=E2=80=AFPM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> On Fri, Jun 19, 2026 at 11:38:07AM +0100, Christian Loehle wrote:
> > > Applied, thanks!
> >
> > All of it? Rafael should probably at least ack drivers/cpuidle/* things=
...
>
> I assumed your R-b is enough, but I will hold this series until
> Rafael or Daniel have a look then.

So please feel free to add

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

to this series and route it as you see fit.

But yes, Christian is a cpuidle reviewer officially now as per
MAINTAINERS, so his R-by is sufficient in cases like this one at least
IMV.

