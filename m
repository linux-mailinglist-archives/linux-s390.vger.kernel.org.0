Return-Path: <linux-s390+bounces-22307-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uTarCEPIVmqYBAEAu9opvQ
	(envelope-from <linux-s390+bounces-22307-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 15 Jul 2026 01:37:39 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 664DD75978B
	for <lists+linux-s390@lfdr.de>; Wed, 15 Jul 2026 01:37:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Eqp8BhQl;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22307-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22307-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41152302573A
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 23:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB370369D51;
	Tue, 14 Jul 2026 23:37:35 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E08367B9C;
	Tue, 14 Jul 2026 23:37:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072255; cv=none; b=L8vw7Bi9mWFejQhA0uRaq3OQ7OxDORkGwCnbHEX4tbpUQsMK6NQJrYFCIrZL74Nz2oRrihinv/DmiYPTgPkKTaBOb77NqIMIL65zSNM7c6QTHi+E10+8+iTVX+xFggX/KLyZx5GXwrK/EV4XTD5MapHxf9FQSNVs9a65m6GrrPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072255; c=relaxed/simple;
	bh=q7iui2SuUBNcROptVu15a+C51X7LRi9XV/N3/avqKg0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k0UYnyCx78SKf8Pq0UG5MMyIJNlPuEKJm/O7lrIYTlZ4DsS8ovzvbhOFh9WPbsjtSvLPhFEEEuhulELbgen16gMtjI7IIDRjHDtFlhUoIvr+a48b2kNkAUfndKuTjCx3ih5+QmStmeDSw/P0nTzJ2ntsYDgs6G31bFQdsXn5I+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eqp8BhQl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DEA1F000E9;
	Tue, 14 Jul 2026 23:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784072253;
	bh=AnLe87W1tYC1nmpN/VXwPJ4ZdOBYRmyU5hFbRR7qVyw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eqp8BhQltfKXsxUnojO8VdHsgHEVHzsA+8VnZaTjtEagB86X7PeOsQ8KM92RV901O
	 CsOZMw/ZOBjG3GmqEr1NQpLq4Xo/riQRXn64tLE0557ssHslPT9XV7+mY7/EVUvzU5
	 YUxLLcD2yqWu9tAOJo54cmBcbV8UR+nwYyuuqWsxHVgunMRW3xmiyMtrG0ChiShP79
	 EV64k4GBwm3XJxMLYyMCVI0njF/TKwtzIVRGy/R8tEYVTkRWPAYjrJSTGkfuAstZzH
	 lk7bZ69uW+poWHTUaXAaQ7e5WMghtvr1QDZTxOXcPgrNPIrnYS2hZfTTs5esq0Km2c
	 Ms4xCAlvyWE2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/6] s390/vfio_ccw: fix out of bounds check on CCW
 array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260714232208.1683788-2-farman@linux.ibm.com>
References: <20260714232208.1683788-1-farman@linux.ibm.com>
 <20260714232208.1683788-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 23:37:32 +0000
Message-Id: <20260714233733.73DEA1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22307-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:farman@linux.ibm.com,m:linux-s390@vger.kernel.org,m:gor@linux.ibm.com,m:kvm@vger.kernel.org,m:agordeev@linux.ibm.com,m:hca@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 664DD75978B

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces an off-by-one regression that incorrectly rej=
ects valid channel programs consisting of exactly CCWCHAIN_LEN_MAX (256) CC=
Ws.

Pre-existing issues:
- [High] Leaked ccwchain structures when a subsequent TIC processing fails.
--

--- Patch [1]: [PATCH v1 1/6] s390/vfio_ccw: fix out of bounds check on CCW=
 array ---
commit ccfdffefc50adaae37db8e069d19bc3ab3f7721c
Author: Eric Farman <farman@linux.ibm.com>
s390/vfio_ccw: fix out of bounds check on CCW array

This commit limits the channel command word counting loop to 256 iterations
to prevent out-of-bounds array access. It changes the loop condition and
the subsequent error check to reject chains larger than 256 words.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 7561aa7d3e017..80c3d87f54822 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -393,9 +393,9 @@ static int ccwchain_calc_length(u64 iova, struct chan=
nel_program *cp)
>  			break;
> =20
>  		ccw++;
> -	} while (cnt < CCWCHAIN_LEN_MAX + 1);
> +	} while (cnt < CCWCHAIN_LEN_MAX);
> =20
> -	if (cnt =3D=3D CCWCHAIN_LEN_MAX + 1)
> +	if (cnt >=3D CCWCHAIN_LEN_MAX)

[Severity: High]
Does this code incorrectly reject valid channel programs consisting of
exactly 256 command words?

If a guest issues a valid request with exactly 256 command words in a chain,
the loop will correctly process all of them and cnt will reach 256. The
new check evaluates to true since 256 >=3D 256, incorrectly conflating
this valid termination with an over-length chain and unconditionally
returning -EINVAL.

>  		cnt =3D -EINVAL;
> =20
>  	return cnt;

[Severity: High]
This is a pre-existing issue, but does this code leak ccwchain structures
if a subsequent transfer in channel fails?

Looking at ccwchain_handle_ccw(), if a guest issues a request with
multiple transfer in channel commands, and an earlier command is valid but
a later one fails, the valid chain allocated during ccwchain_loop_tic()
is added to cp->ccwchain_list.

When the invalid command fails, ccwchain_handle_ccw() catches the error
and only frees its own top-level chain:

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_handle_ccw() {
...
	ret =3D ccwchain_loop_tic(chain, cp);

	if (ret)
		ccwchain_free(chain);
...
}

The error is returned to cp_init(), which leaves cp->initialized as false:

drivers/s390/cio/vfio_ccw_cp.c:cp_init() {
...
	INIT_LIST_HEAD(&cp->ccwchain_list);
...
	ret =3D ccwchain_handle_ccw(orb->cmd.cpa, cp);

	if (!ret)
		cp->initialized =3D true;
...
}

Because cp->initialized is false, cp_free() ignores the list during
device teardown:

drivers/s390/cio/vfio_ccw_cp.c:cp_free() {
...
	if (!cp->initialized)
		return;
...
}

When the next request arrives, cp_init() calls INIT_LIST_HEAD again,
which permanently orphans the leaked chains on the list.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714232208.1683=
788-1-farman@linux.ibm.com?part=3D1

