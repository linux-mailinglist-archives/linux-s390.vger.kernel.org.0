Return-Path: <linux-s390+bounces-21477-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LJIvI1NdRWoU/AoAu9opvQ
	(envelope-from <linux-s390+bounces-21477-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 20:32:51 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EA86F09FE
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 20:32:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OqXlL7D9;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21477-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-21477-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECBAD3035FFA
	for <lists+linux-s390@lfdr.de>; Wed,  1 Jul 2026 18:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB6F394EA7;
	Wed,  1 Jul 2026 18:32:42 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD2E3939A4
	for <linux-s390@vger.kernel.org>; Wed,  1 Jul 2026 18:32:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930762; cv=none; b=AFtx0VtmUizxBuBhH55ZrfmQu2SaVeCHma47i7tk+pB9uShwJzlLxS2ziqqq0IFhAZChcbnhV5lgVsTc7vVNSqCKRG4Oqb/iJCEWO4ls1yp+p12w/kpBzjWfuvbTLb/sDKdaCq/6+VjRXc8hW6MQrz69OtkI+P4+HcIfA9rjt6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930762; c=relaxed/simple;
	bh=nnOdkZ839dTacMtunbH9M8x9gx+2wPdTaFrQO+KdrBA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DLKvWKLp8ZLzgAxhw9Fwkub+a80nmYADSv+vrbgASBL9yyMwyRQvblCOgerHlT1NF/zjxElpkABBGx88l7Qz2Y3HLCWYwjglc9indpn0YEDwP3PfheQ6eR2p1Iv1rIRHByylBMlvdkOIJqzbpPMccl9QC4SGe1Vu5EoZrpOmRLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqXlL7D9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0B71F000E9;
	Wed,  1 Jul 2026 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782930761;
	bh=xWWWlyGl3Y17NCTySDqt+jHXocWWL1S5+Th8aqT2C8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OqXlL7D9BB9makq9uVuIDw886CLx6yAX3g/cvWEsBsiAj15kiWhQbZK8ifEtn2hha
	 H1IGdruqCjnRQvXFoGt4S7lo6miVBP+CWqBWlHDqP7o3yobbshuxzUidk7+Ud8weUL
	 FuiZaxJwUdYWRo43NTf9SmZEiBcK0Dw8nxuGE3LnyAGkMMx+ojcjNFUNXWMnEcMHSP
	 RJZq3QwviO3SwTQb7fNMN+FBYyzbyBitYwAFYrfxepU03a1e3iVpfnK/EWuUHezHjw
	 iuhDuyiyKvycgQc/gx75Vqj9Ro3gfM2BD7A9SmHF/yRn8UBLZmam0YDGZwZW6qmGvH
	 PHB8VHZra/5+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net/smc: fix UAF in smc_cdc_rx_handler() by
 pinning the socket
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiang Mei" <xmei5@asu.edu>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260630183227.2044998-1-xmei5@asu.edu>
References: <20260630183227.2044998-1-xmei5@asu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 18:32:40 +0000
Message-Id: <20260701183240.ED0B71F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21477-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,smtp.kernel.org:mid,asu.edu:email,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25EA86F09FE

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Concurrent unprotected bitfield modifications in `struct smc_c=
onnection` can lead to lost updates for `freed`, `killed`, or `out_of_sync`=
 flags, causing reference count underflows and Use-After-Free.
--

commit 2f1e95dfacd6a1bad8a756fc60b2dadb865fcaac
Author: Xiang Mei <xmei5@asu.edu>

net/smc: fix UAF in smc_cdc_rx_handler() by pinning the socket

This commit fixes a use-after-free in smc_cdc_rx_handler() by taking a sock=
et
reference while holding conns_lock. This ensures the connection and socket
remain valid while the receive handler runs.

> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 619b3bab38248..32d6d03df3214 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c

[ ... ]

> @@ -483,21 +483,26 @@ static void smc_cdc_rx_handler(struct ib_wc *wc, vo=
id *buf)
>  	lgr =3D smc_get_lgr(link);
>  	read_lock_bh(&lgr->conns_lock);
>  	conn =3D smc_lgr_find_conn(ntohl(cdc->token), lgr);
> -	read_unlock_bh(&lgr->conns_lock);
> -	if (!conn || conn->out_of_sync)
> +	if (!conn || conn->out_of_sync) {
> +		read_unlock_bh(&lgr->conns_lock);
>  		return;
> +	}
>  	smc =3D container_of(conn, struct smc_sock, conn);
> +	sock_hold(&smc->sk);
> +	read_unlock_bh(&lgr->conns_lock);
> =20
>  	if (cdc->prod_flags.failover_validation) {
>  		smc_cdc_msg_validate(smc, cdc, link);
> -		return;
> +		goto out;

[Severity: Critical]
This is a pre-existing issue, but can concurrent bitfield modifications in
struct smc_connection lead to lost updates and a use-after-free?

In net/smc/smc.h, we have:

struct smc_connection {
	...
	u8			killed : 1;	/* abnormal termination */
	u8			freed : 1;	/* normal termination */
	u8			out_of_sync : 1; /* out of sync with peer */
};

When smc_cdc_msg_validate() is called from softirq (tasklet) context here,
it sets conn->out_of_sync =3D 1 locklessly.

If a softirq interrupts a process context that is simultaneously setting
conn->freed =3D 1 in smc_conn_free(), or if they execute concurrently on
different CPUs, the compiler's read-modify-write on the shared byte could
cause one update to overwrite the other.

If the update to conn->freed =3D 1 is lost, could smc_conn_free() be execut=
ed
multiple times on the same connection, bypassing an early if (conn->freed)
check? This seems like it could underflow the link and link-group reference
counts, leading to a use-after-free of those structures.

>  	}
>  	if (smc_cdc_before(ntohs(cdc->seqno),
>  			   conn->local_rx_ctrl.seqno))
>  		/* received seqno is old */
> -		return;
> +		goto out;
> =20
>  	smc_cdc_msg_recv(smc, cdc);
> +out:
> +	sock_put(&smc->sk);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630183227.2044=
998-1-xmei5@asu.edu?part=3D1

