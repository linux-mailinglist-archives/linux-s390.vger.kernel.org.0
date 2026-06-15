Return-Path: <linux-s390+bounces-20835-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O+MaFQjtL2qaJAUAu9opvQ
	(envelope-from <linux-s390+bounces-20835-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 14:16:08 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1592686144
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 14:16:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TE+ps8XH;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20835-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20835-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BBCC30EAB5D
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 12:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BB83E5ECF;
	Mon, 15 Jun 2026 12:09:56 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629673E5A35;
	Mon, 15 Jun 2026 12:09:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525396; cv=none; b=okUnlUxIaMVp+uNVP/VekUPcS7t/hTEUaTLi6KcuIW8lqcOQAQ2CsbYCeO5uVWOHmKLHKgqS2nTk3NWkt0bUdlfgy0vHd51PZ/x6iZZvPan4XaNurADfoqosa1GQPei9pFYkDSiDUcYkWwc3NpWpe3qdHWYFxj3VknsLArs48dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525396; c=relaxed/simple;
	bh=y79DKARTRp3ByzlsQ9zaQTiO3Mofc2bj4NCvmUXvhQU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ihophNpMfBZShkDv0nm6RNBvpsVRnWqsRzb3SLJykvAhvqh98NQcBKNZ2ySVr7oCA4wsQ55Yq50GO3Aq4vFpRlcaKk9yVtiuuFLDuv/uILU9D+uiQE4vMi8XcM7PPlM/CzMUy6tIAU45zxX6ZV+VwDlIQ8y+uM4zyaZOMAY+tT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE+ps8XH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EA21F000E9;
	Mon, 15 Jun 2026 12:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781525395;
	bh=tjqdHbY15oVIxfVv0cACnUVqN/cL5lJGeUfwDUXAu3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TE+ps8XHBvpIURiOLbINBKwAYAeIgqIuoSBhTld0ahZyxG9jCabqyYxpGXTWG+wYK
	 nWTL24WQoOC7l/v7p6l8IWliQnXbFHgdp4LM9ca20GHF4fWjK65wG0zLroxdAIC6e+
	 whs7SNcF0BoB8rrlN5AhqRf8kaSKuPEhc4yQwTiApe/UobZbMkDxuRW8TRTJNTs3Jg
	 q7XnP/jIzdM4PAPIY0ykAdIQFxUJJ99gSvAB690fuM8AIYf5DOj+CyemCk3qlLj+TA
	 DID3wNbSGuzhpiRlNG/gb2XP+0yjWJtb13QsKceDLGrV0Mqth8aSm1AFEXrH5A+SON
	 3ZesSsbmEmFDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: fix out-of-bounds read in
 smc_clcsock_data_ready()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, bpf@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260614120931.4041687-1-rhkrqnwk98@gmail.com>
References: <20260614120931.4041687-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 12:09:54 +0000
Message-Id: <20260615120954.99EA21F000E9@smtp.kernel.org>
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,m:bpf@vger.kernel.org,m:hca@linux.ibm.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-20835-lists,linux-s390=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
X-Rspamd-Queue-Id: E1592686144

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Incomplete fix leaves inherited fallback callbacks vulnerable,=
 leading to KASAN slab-out-of-bounds read and control-flow hijack.
- [High] Silent hang of accepted child sockets when a listener is attached =
to a BPF sockmap.
--

commit 155a3b6116a31fce47421ad7bb5710d26c0e0b82
Author: Sechang Lim <rhkrqnwk98@gmail.com>

net/smc: fix out-of-bounds read in smc_clcsock_data_ready()

This patch fixes an out-of-bounds read when smc_clcsock_data_ready() is
called on a passive-open child socket that has had its sk_user_data cleared
by sk_clone_lock() and subsequently populated by a BPF sock_ops program. It
restores the inherited sk_data_ready in smc_tcp_syn_recv_sock() before
sk_user_data can be reused.

> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index b5db69073e20f..152971e8ad179 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -156,6 +156,12 @@ static struct sock *smc_tcp_syn_recv_sock(const stru=
ct sock *sk,
>  	if (child) {
>  		rcu_assign_sk_user_data(child, NULL);
> =20
> +		/*
> +		 * the child inherited the listen-specific sk_data_ready();
> +		 * restore it here, as sk_user_data may be reused before accept
> +		 */
> +		child->sk_data_ready =3D smc->clcsk_data_ready;

[Severity: Critical]
This isn't a bug introduced by this patch, but does restoring only
child->sk_data_ready leave the other inherited fallback callbacks vulnerabl=
e?

If an SMC socket is forced into fallback mode before listen() is called,
such as via setsockopt(TCP_FASTOPEN), smc_fback_replace_callbacks() replaces
all four socket callbacks (sk_state_change, sk_data_ready, sk_write_space,
and sk_error_report) with fallback handlers.

When a connection is accepted, sk_clone_lock() copies all four fallback
callbacks to the child TCP socket and zeroes sk_user_data.

If a BPF cgroup hook runs bpf_sock_hash_update() on the child socket,
sk_user_data is populated with a sk_psock.

Could a subsequent socket event trigger the inherited smc_fback_state_chang=
e()
and cause an out-of-bounds read?

net/smc/af_smc.c:smc_fback_state_change() {
    read_lock_bh(&clcsk->sk_callback_lock);
    smc =3D smc_clcsock_user_data(clcsk);
    if (smc)
        smc_fback_forward_wakeup(smc, clcsk,
                                 smc->clcsk_state_change);
    read_unlock_bh(&clcsk->sk_callback_lock);
}

smc_clcsock_user_data() would mistakenly cast the sk_psock to a struct
smc_sock, and dereference smc->clcsk_state_change past the end of the
sk_psock object.

Should child->sk_state_change, child->sk_write_space, and
child->sk_error_report also be restored here?

[ ... ]

[Severity: High]
This is a pre-existing issue, but does a similar inheritance problem exist
in the BPF sockmap subsystem itself?

When a listener socket is added to a BPF sockmap, its sk_data_ready callback
is replaced with sk_psock_strp_data_ready(), and its sk_user_data is marked
with the SK_USER_DATA_NOCOPY flag.

When an incoming connection is accepted, sk_clone_lock() copies the
listener's sk_data_ready pointer to the new child socket but zeroes out
sk_user_data.

The TCP BPF cloning hook (tcp_bpf_clone()) restores the child's sk_prot but
does not restore its sk_data_ready callback.

When the child socket receives data, it invokes the inherited callback:

net/core/skmsg.c:sk_psock_strp_data_ready() {
    struct sk_psock *psock;

    rcu_read_lock();
    psock =3D sk_psock(sk);
    if (likely(psock)) {
        ...
}

Since sk_user_data is NULL, sk_psock(sk) evaluates to NULL. Does this cause
sk_psock_strp_data_ready() to return immediately without invoking
sock_def_readable(), permanently depriving the child socket of readiness
notifications and silently hanging applications waiting in epoll_wait()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614120931.4041=
687-1-rhkrqnwk98@gmail.com?part=3D1

