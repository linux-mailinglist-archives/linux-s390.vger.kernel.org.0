Return-Path: <linux-s390+bounces-20692-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VwY9KkkxKGp7/wIAu9opvQ
	(envelope-from <linux-s390+bounces-20692-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 17:29:13 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 279D5661BE2
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 17:29:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HRHoQeWl;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20692-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20692-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26D4F3084872
	for <lists+linux-s390@lfdr.de>; Tue,  9 Jun 2026 15:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AD4480323;
	Tue,  9 Jun 2026 15:06:27 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B7747B405;
	Tue,  9 Jun 2026 15:06:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017587; cv=none; b=ZBKfxTNhDQKGJf1ZtYCdbF4n35fp5M8wk9wY3dxSWFe0ElCOcBX7KFTgXWx/wYabjI4bGX3hfuaNMKbOC6tKXGwIbW6GA/kyX802L7A+TlLcsMw+omJxm6C5B32JLdPsyNMhw/XH4WaWbUqHedMjAkZ2FQk5h7At2pMgsPp6SpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017587; c=relaxed/simple;
	bh=jQ8mZ+jLNIPyWo7g9aJQMBRuanK8xLNh75/phBYe+5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MdereQkgN94JBIbA0tjPImfZSEatAQNaeD0tOrz4yX/XgMT7LiWPxcmqdeBnkEIp0iOdNuTYLIjMl/doGc6tBLWSBqjACZvPBhr6YTHMjEE0umZkArQRIueTpQF51SFiOpa/WRS3bau9Qt0SMXHEYNENCKfflGlF6oGdqmfxvxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRHoQeWl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDA11F00898;
	Tue,  9 Jun 2026 15:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781017586;
	bh=jQ8mZ+jLNIPyWo7g9aJQMBRuanK8xLNh75/phBYe+5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=HRHoQeWl2GXtwBkAKPqGsiixcJ2zi4wNGzVhMLR+bJYPndZx9IB1lFt4ouwctlkMM
	 +xfRieoxrFZfEp3fhSvpUFv2XVJ1nlkUobeB66gz881veGeq8i0+lLpdbIFEotSJy7
	 8tnUpitWq15NA4F55VbJjRiFgUhkNJxx6AdBD862gbktwXTYW/e+/WP58HIKDjeW6S
	 qOJiFGucUHZacujDL6+3wdrwsjc0DfY2VMLb7L9b4Xsrrl7B1XEgQ2GJRZYhmXJ3Cr
	 ICbSiGOG4bFMnb7pIwc9PCLZnkHyirllf+XH18Ordo4rb3sZfc9aYjgInsBUViL7un
	 tvXP1H6UEh/cA==
From: Thomas Gleixner <tglx@kernel.org>
To: Mete Durlu <meted@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@kernel.org>
Cc: Mete Durlu <meted@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, linux-s390
 <linux-s390@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] tick: Remove arch_needs_cpu
In-Reply-To: <20260609075213.31094-3-meted@linux.ibm.com>
References: <20260609075213.31094-1-meted@linux.ibm.com>
 <20260609075213.31094-3-meted@linux.ibm.com>
Date: Tue, 09 Jun 2026 17:06:20 +0200
Message-ID: <8733yv4utv.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:meted@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:svens@linux.ibm.com,m:rafael@kernel.org,m:daniel.lezcano@kernel.org,m:christian.loehle@arm.com,m:anna-maria@linutronix.de,m:frederic@kernel.org,m:mingo@kernel.org,m:iii@linux.ibm.com,m:borntraeger@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-20692-lists,linux-s390=lfdr.de];
	FORGED_SENDER(0.00)[tglx@kernel.org,linux-s390@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fw13:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 279D5661BE2

On Tue, Jun 09 2026 at 09:52, Mete Durlu wrote:
> Remove unused arch_needs_cpu() hook. No architectures use it after
> s390 removed its use case.
>
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Reviewed-by: Thomas Gleixner <tglx@kernel.org>

