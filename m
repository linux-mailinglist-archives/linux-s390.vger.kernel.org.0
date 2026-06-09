Return-Path: <linux-s390+bounces-20698-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oGRbKyU0KGprAAMAu9opvQ
	(envelope-from <linux-s390+bounces-20698-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 17:41:25 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AEA661E62
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 17:41:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VUEWdj3X;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20698-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20698-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B16CA303B78D
	for <lists+linux-s390@lfdr.de>; Tue,  9 Jun 2026 15:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E7434B662;
	Tue,  9 Jun 2026 15:16:44 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605F82C21C5;
	Tue,  9 Jun 2026 15:16:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018204; cv=none; b=H8pXeYcc2cXRfddDK9MGQKnL+c29n2gd7nPv/9TY4OLMqa9IWJxgffFgHY+HDtCChD4g5yTHTQ2n5KYFsVsJiAjrwz7MCxfgxAsW3n5lgyGk30VPrZsAlghFbViP4UW8R8KCXVzZhd+J5jmdDIJE3pe3J3/186Ui8HQKUOZHUY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018204; c=relaxed/simple;
	bh=6cmUfXJ5jVJhf6u4rv18SjswSMx2CumbXJob3esLbx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oU81J/PdzTU0YivzBzFKPyezA0VUdSfk/pvJWp9s/jwLO9IqB1+34axRIUCBL8Cgh7b9dP7YyJ0DLvOKg/HZCyKHBsCFt99d/9TQhyl00Knca6iaGqae1G6nlxPP81TTvaFC+2RLN7QxamGPL1Th38SsVhq6Yva6gh5eWsv+WDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUEWdj3X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822741F00893;
	Tue,  9 Jun 2026 15:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781018203;
	bh=6cmUfXJ5jVJhf6u4rv18SjswSMx2CumbXJob3esLbx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=VUEWdj3XqVxNenfWuvlwH2KvEsf3i8MtsDbX9gzMi8kgBHMMsIovkgs7WjV8AJ7Xg
	 gARSl4iX5RmV2rqAmk79e73qlkID9eMd4FeVOwiVvl0ZZyxqgG1MWxfigb66IGLFcY
	 /y4n8LfX8GK8d3j7qySSzQRATD63/IsztASSyY0pyVHpE1DVyz2+TdT29819yD2ZB4
	 PDL6q5+Y24IlncXwPsczhT79B/q7qvN7D1xwWMYNIOOjlRwP8PjAiedcFdVOLnPR1o
	 uBSEf7JWFVaxT5f9hTByihk/bXpqoYdV1Ja8IB7/mrXW37pw+Ia3uQQ7IrAfZqss7w
	 yVj3Q+E+aylcQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Mete Durlu <meted@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Christian
 Loehle <christian.loehle@arm.com>
Cc: Mete Durlu <meted@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] tick: Remove arch_needs_cpu
In-Reply-To: <20260609-idledriver-v2-2-21c2f581d11f@linux.ibm.com>
References: <20260609-idledriver-v2-0-21c2f581d11f@linux.ibm.com>
 <20260609-idledriver-v2-2-21c2f581d11f@linux.ibm.com>
Date: Tue, 09 Jun 2026 17:16:40 +0200
Message-ID: <87v7br3fs7.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[tglx@kernel.org,linux-s390@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:meted@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:svens@linux.ibm.com,m:anna-maria@linutronix.de,m:frederic@kernel.org,m:mingo@kernel.org,m:rafael@kernel.org,m:daniel.lezcano@kernel.org,m:christian.loehle@arm.com,m:borntraeger@linux.ibm.com,m:iii@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-20698-lists,linux-s390=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,fw13:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50AEA661E62

On Tue, Jun 09 2026 at 15:24, Mete Durlu wrote:
> Remove unused arch_needs_cpu() hook. No architectures use it after
> s390 removed its use case.
>
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Reviewed-by: Thomas Gleixner <tglx@kernel.org>

