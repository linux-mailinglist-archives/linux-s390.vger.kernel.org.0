Return-Path: <linux-s390+bounces-21102-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qTp3DMpkOWocrgcAu9opvQ
	(envelope-from <linux-s390+bounces-21102-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 18:37:30 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2906B12CE
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 18:37:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HcwLpWu4;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21102-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21102-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5BD5300CF33
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5751E238D52;
	Mon, 22 Jun 2026 16:37:01 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AF422579E;
	Mon, 22 Jun 2026 16:37:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146221; cv=none; b=cKUW1KRDN/hNeeeDTFdKccWShPNAJMLeLdQ2jJp6niRuZKgCXv71N8ll5YRlSO86wx9P1QrTVQSUvPzsigGIuhNTpC9jwT5uC84RXUPEbX6miXWoofZMmlpFgAkKObBPlc43jPxPkYVB2abol7dSceVYY34flZVwvqgBumrBruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146221; c=relaxed/simple;
	bh=OgMwpc/6q+EKZALzX5KiJg/COU8HV/Nyz0Rb8fLF9f0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YQRFyDEYjeVN2u/9jEVfwPti0os+3qqaBjsL45hdiFq0+WpGa/lMMf1vRmoYac5QF2LqBjQYg6KcI5eauhdtJqWGBYaI/OCFx0iP7k0EcJrbEPqGsLeFfupq5FpQcn7aDZg664G6egRZcp5PvTxldNCTMBWEaNugk+yOMIapUJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcwLpWu4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476561F000E9;
	Mon, 22 Jun 2026 16:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782146220;
	bh=QhiOy9Tg/ZjtE3P4f0w8kywY9aCJ+Jli6IrpFKMI82o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=HcwLpWu4U9pIBryRVd83BOVF+wpfMzj+VHf5D+7JQM2e3DPzzLLlcmmReZfdFNzSZ
	 4DrXWuc541B306QrG14/5VPTvpPGOvzgP/2rqlWvxQFgeowMIb8n3sF9Si99M+cSfa
	 DLycJSpCgqAUGFDX+Sz0Gn7CFJpxJ/Y+3vkEO0bzUK7mHWD7uLCpxT3LmSCQVVVE9p
	 8k624wJjs06RCzCFZpQfhzhd6KXxsXbApOEzoohbP2krOrMxMjxZgDPhZbRdY5stGV
	 SLnuaG140+zzjT+jUGjvW+gcMYKfWoZgCtgF5ar63rKEPDSxa1UokeKE05LJp7krW5
	 AoUlysD6N2prw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B3C3930907;
	Mon, 22 Jun 2026 16:36:52 +0000 (UTC)
Subject: Re: [GIT PULL] more s390 updates for 7.2 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260622142639.2082404A0b-agordeev@linux.ibm.com>
References: <20260622142639.2082404A0b-agordeev@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260622142639.2082404A0b-agordeev@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-2
X-PR-Tracked-Commit-Id: 1ac287e2af9a9112fe271427ef45eceb26bce8b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2580f89860460f38bcc13fce75db8626d555c0cd
Message-Id: <178214621060.1310507.10331342306449967038.pr-tracker-bot@kernel.org>
Date: Mon, 22 Jun 2026 16:36:50 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:agordeev@linux.ibm.com,m:torvalds@linux-foundation.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21102-lists,linux-s390=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E2906B12CE

The pull request you sent on Mon, 22 Jun 2026 16:26:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2580f89860460f38bcc13fce75db8626d555c0cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

