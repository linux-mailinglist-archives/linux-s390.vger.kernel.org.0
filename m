Return-Path: <linux-s390+bounces-21063-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R2yxD6NpNWq0vgYAu9opvQ
	(envelope-from <linux-s390+bounces-21063-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 18:09:07 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 977BC6A6F44
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 18:09:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b4TgIq23;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21063-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21063-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3320B3009B29
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 16:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4258E3B42F6;
	Fri, 19 Jun 2026 16:04:00 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EF61FA859;
	Fri, 19 Jun 2026 16:03:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885040; cv=none; b=FtgZgaemyeC3IGzV+jw0nRzZTr5+/3kegY1c60HOPngGfGDWgtSVQjEy1cCIazTX4j11m0AdzRZNCa8tUPjWUOdJiBQTLRYut/dBkpaYg1l69IUr7Ft+yMaAv3sIExBcLBiPzoxHA2XoHumxFV+xvDgZPPLjALDLecQMfIyVmjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885040; c=relaxed/simple;
	bh=Te145RrHc/p3fzNCUwpeB+l0piTDE+I4fpAvMqOmdRE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JuUvm8mUDVUvmtMcwhabk8gkiGESRaFYp+0LYKhObhgYe1kTImHJg0tTviIVe8yg6/M2NqrpG+9sbcTjRAImS99wYosoZvm/fYQdPRWjlQ8bLUkrZvtw4FZ5IJgLvJYRx10vVXFhGBiLStPf/fZd1T1DOju5QxXbIlaw1P/twvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4TgIq23; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC1D1F000E9;
	Fri, 19 Jun 2026 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781885038;
	bh=9kQsR7gVwkg6gv09NlyNYXKgEDGahBiot11d/PQxd6o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b4TgIq230TAJoIFPQgNk8FUAlgXskR5+dvXsW2K5GHgqIC/NYoXh/KeCiMdImDUvI
	 MmCpxAgBtUZcvd1xdfWAY2bunGk4AkqkFKlGazObLv+Jc64j5mvgXgzfSVkTRQIEBM
	 n7McG8lF0Kh4icz/1sq0LjC/itoVQmdEUoqazC4g+Wy0Y3CFQe0GxDHY89qysjrnY2
	 6b3K1w/l+FiwiLtLMhLx3G84Kv3LfzOHOXADAWel/mu/cfmmeOTvhdU1FukIEr24s9
	 YNd8fUuFs8b8DJfb6uJMZzwdt8q3HPEsqXY+Rv2AObsWAtUYTN0OhKiOc8jRQxYvUQ
	 gsYJW/tRaEhFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/7] KVM: s390: selftests: Fix cmma selftest
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260619155154.307572-8-imbrenda@linux.ibm.com>
References: <20260619155154.307572-1-imbrenda@linux.ibm.com>
 <20260619155154.307572-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 16:03:57 +0000
Message-Id: <20260619160358.1FC1D1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21063-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 977BC6A6F44

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Outdated comments and function naming due to inline assembly change=
s.
--

commit 007cfe6c8e5c96330ecd4725d320fa59c950105a
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: selftests: Fix cmma selftest

The existing cmma selftest depended on the host allocating page tables
for all present memslots. Since the gmap rewrite, memory that is not
accessed by the guest might not have page tables allocated yet.

> diff --git a/tools/testing/selftests/kvm/s390/cmma_test.c b/tools/testing=
/selftests/kvm/s390/cmma_test.c
> index e39a724fe860e..04f34b7ec1279 100644
> --- a/tools/testing/selftests/kvm/s390/cmma_test.c
> +++ b/tools/testing/selftests/kvm/s390/cmma_test.c
> @@ -39,11 +39,14 @@ static void guest_do_one_essa(void)
>  {
>  	asm volatile(
>  		/* load TEST_DATA_START_GFN into r1 */
> +		"	xgr 1,1\n"
>  		"	llilf 1,%[start_gfn]\n"
>  		/* calculate the address from the gfn */
>  		"	sllg 1,1,12(0)\n"
>  		/* set the first page in TEST_DATA memslot to STABLE */
>  		"	.insn rrf,0xb9ab0000,2,1,1,0\n"
> +		"	agfi 1,0x100000\n"
> +		"	.insn rrf,0xb9ab0000,2,1,1,0\n"

[Severity: Low]
This isn't a bug, but with the addition of the second .insn instruction, the
code now accesses a second page. Should the inline comment and the function
name guest_do_one_essa (along with its docstring claiming it dirties exactly
one page) be updated to reflect that multiple pages are now being touched?

>  		/* hypercall */
>  		"	diag 0,0,0x501\n"
>  		"0:	j 0b"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619155154.3075=
72-1-imbrenda@linux.ibm.com?part=3D7

