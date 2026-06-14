Return-Path: <linux-s390+bounces-20821-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CPbvBFNnLmrgvQQAu9opvQ
	(envelope-from <linux-s390+bounces-20821-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Sun, 14 Jun 2026 10:33:23 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58043680AA0
	for <lists+linux-s390@lfdr.de>; Sun, 14 Jun 2026 10:33:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=fdCiwJ9K;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20821-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20821-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F6DA3008754
	for <lists+linux-s390@lfdr.de>; Sun, 14 Jun 2026 08:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D8223EAB4;
	Sun, 14 Jun 2026 08:33:17 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D895E40D573;
	Sun, 14 Jun 2026 08:33:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781425996; cv=none; b=iY18F0xEBT2K4OJHjzbngP1JJwaPxBSmotlhy2/M2tZYAMSnJSPTt6E77rLWdFOasQLmGH6iWmFgJZtuP2m549PfSBWrrrtpccIMNAY3qfot1QjGhd42nHF05gkBiOMhFJWCbGkWWhM8tTRYAzt68JSY2ndgIHWZw3q0yN5QCco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781425996; c=relaxed/simple;
	bh=n4eLSjt9MdHYuN6dcw+JD5aDWP63yMNrci619TDHdFg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5bIqz53FiyhDiGgOqNWuipgwVYoVNiW4pNEjPP+DxG5b5hB0/n5rpKmJYLmTp+EYdr6QBZ7YXWIfgNWq1dwcf5WRGap2jpCXZATpGaGIz77sz8PjfeXiAVlTEYTLbNVZvCzCBH2f57BsQioORce69spK+/5y+yx5B/VK+FshFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=fdCiwJ9K; arc=none smtp.client-ip=57.129.93.249
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781425981; x=1781685181;
	bh=IPrypqa+FqDysyZ8SCD1SoIBv9iyo915Ht1JHFvd3VI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fdCiwJ9KR6xzOziDyOXFcRPtz346JGfiOrAYYUUPVzUHNshvnGhnNsHf54mob6oEq
	 U3RJX52GbALZ7byJC7+UhfbfpKUZn7hQGrTcn/b+0fuE0HJDCrgwxo4RwmUPQZmbnL
	 tZ898CZPyl9JoAIidx3OLy8Ai0KRmQWsGDlej8/5SUCJVxppitMMGMPRApoJ3Aia/G
	 62sEn/2NGK3X+WXyI8o64H2mjtgXNJ0HIFQnAVfZCatBO2bu70qHp4+q2M1tusNMU0
	 8+0jU6zrwNYcZcGEHB2DGWGtBv/JA7MIW0Bbz04SECoKDHYeQO2Okawh4onEXAhd8I
	 BMgKNQtPuDlxw==
Date: Sun, 14 Jun 2026 08:32:53 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: "D . Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/smc: bound the peer producer cursor on SMC-D and SMC-R CDC receive
Message-ID: <20260614083242.79320-1-hexlabsecurity@proton.me>
In-Reply-To: <20260614003111.383195-1-kuba@kernel.org>
References: <20260610084803.186516-1-hexlabsecurity@proton.me> <20260614003111.383195-1-kuba@kernel.org>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: d1626491e591e7be3d5e0fc6800c309183568c24
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:raspl@linux.ibm.com,m:ubraun@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-20821-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[hexlabsecurity@proton.me,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:dkim,proton.me:mid,proton.me:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58043680AA0

On Sat, 13 Jun 2026 17:31:11 -0700, Jakub Kicinski wrote:
> Is this clamp safe against a concurrent smc_rx_recvmsg() on another CPU?

Confirmed -- the tasklet read-then-set is racy: a recvmsg()/sendmsg() on
another CPU reads the inflated value in the window between the
atomic_add() and the clamp (recvmsg() runs under lock_sock(), which
leaves the slock free, so it is not serialized against the
bh_lock_sock() CDC tasklet). Reworked as a v3 series:

  https://lore.kernel.org/netdev/20260614-b4-disp-edd64be9-v3-0-551fa514257=
e@proton.me/

The bound now lives at the consumer (smc_rx_recvmsg() / smc_tx_sendmsg()),
where it is race-free; it also rejects a sign-overflowed (negative)
accumulator (per the sashiko-bot review on the sndbuf_space patch); and
the producer-cursor clamp is applied to the producer cursor only, so the
consumer cursor stays bounded by peer_rmbe_size, not rmb_desc->len. The
sndbuf_space fix is folded in as patch 3/3.

Thanks for the review.

Bryam


