Return-Path: <linux-s390+bounces-20527-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yEooCyvkIWonQQEAu9opvQ
	(envelope-from <linux-s390+bounces-20527-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 22:46:35 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8236564374D
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 22:46:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VEeok7F+;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20527-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20527-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D80530799F4
	for <lists+linux-s390@lfdr.de>; Thu,  4 Jun 2026 20:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256F6366DB9;
	Thu,  4 Jun 2026 20:38:45 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328FA2C028F;
	Thu,  4 Jun 2026 20:38:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605525; cv=none; b=p281CvQQ1DK0avtYUJaktgDwbA17cJBjCnIFgSFK48TnupMRspaMIqsoHNbo+k6ul+4YEGBZDCsy0gu8jDlThnocwfigaBDCKQzHaT86Kwn71dkGmUcwMAw+QufPhPG16/8Z2ARWG20k6usRVKSBloMoi0JqLh2MlGmJFS0yspI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605525; c=relaxed/simple;
	bh=mMW8XkZ/wXYXP5QDtELklp2xNePhOlFMhVQYtUiE6pM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=byEZY2botJ6Bpwf1s/mhOHye5cC/G+gIi70P2ngWxO5DCe71TW38z26fR10j4hhYw8kqBWCRR0+BZjZqnHlQIziLNI7Ls4Pn+UdgnLX+E1IUpMg8SAK9B9+IJJ9oVyC28/NbX8UENx5UtdMT8ovvY6+KAmqvUV6CLr5xRR0hPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEeok7F+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAB91F00893;
	Thu,  4 Jun 2026 20:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605524;
	bh=1MIxQhexAt5Z7qCyiRocHr15F20+HAzUJplRDaIidyk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=VEeok7F+/soSTHNuKtSD9t6pdLMkkIeJCUWjAvfR74R0PdQjq4OHrV64X07KnVzl1
	 E6VdG+xXkYVc9Jb+Cr9zzb6ete7nwMFiZv9Yi9/z77Wy8Ird5RotSauU9PWtJ8TYqz
	 BR6d064GKwrxBwb3GxDh0+wgzNP96NjprtpeBQk3mUz8new4kDXdJofPPP4ei+ZXMm
	 GErq7op6Cs6axIhd7EYAhSlOob0BGn+a1UinumPiJdiX3jBUEvdhdCcirO6f3RdzzB
	 ohaEELNpcghq90O8UWQqdzj0ZP+UClxkw4y16mX9nmzrmLCzmuLcrHViGtURS0ecLb
	 FA9Hf6J2kM90Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A633930A26;
	Thu,  4 Jun 2026 20:38:46 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 7.1-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260604064416.1461269A9a-agordeev@linux.ibm.com>
References: <20260604064416.1461269A9a-agordeev@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260604064416.1461269A9a-agordeev@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.1-4
X-PR-Tracked-Commit-Id: 7c6535c37dbc03c1c35926b7420d66fb122b513a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a08076f009e3d9460bebae9f209c1dc1d8a46b7
Message-Id: <178060552474.3015695.17001244396675736287.pr-tracker-bot@kernel.org>
Date: Thu, 04 Jun 2026 20:38:44 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20527-lists,linux-s390=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,linux-s390@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:agordeev@linux.ibm.com,m:torvalds@linux-foundation.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8236564374D

The pull request you sent on Thu, 4 Jun 2026 08:44:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.1-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a08076f009e3d9460bebae9f209c1dc1d8a46b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

