Return-Path: <linux-s390+bounces-20891-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XxMMG/yaMGohVAUAu9opvQ
	(envelope-from <linux-s390+bounces-20891-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2026 02:38:20 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF3C68AF9A
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2026 02:38:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="olT/LSvy";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20891-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20891-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE6BC317A289
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2026 00:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D693F2690EC;
	Tue, 16 Jun 2026 00:34:07 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA1E243376;
	Tue, 16 Jun 2026 00:34:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570047; cv=none; b=Xx/j3mUWzeEWh2wjmk/Bg6fYHreMvQpJ89Zf5Q4dyMPG4iPlNmVE2YWsD3Z6uhEPWfBigEzSi0b1CmzXteQ0sTK8IuVyPDf1kETBZXxuBxYYGDBNi7VzWqCYaZL+oWlchV/avo9v6qKsJ85XSMMtFFMe98RQ50+zHEO/2+Vm4fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570047; c=relaxed/simple;
	bh=ktycN0tqJK6K8nhD9Zuqu1mnFq7zxtISRCCwO3jMha0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ehC9PNc9sU4Z7KMvElvq7+OvFY6ee567ysnzYzcjEm5LwPu+ymmaVG4jigK+JdOWHRKDujFrEwpsejY7iwz4kOfN3Jt5VNw3v32E+js3+RI0I6Tm7efpkdsUjXH7LKHfF9y83h+YRClk8UZeiCgZDtR6SU2x7ZBJwPo0edD/oXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olT/LSvy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6B11F000E9;
	Tue, 16 Jun 2026 00:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570046;
	bh=XfKHA5FbEbWq5PeLgKh/D3NL6E5nrZywNL2zWB1Qv3s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=olT/LSvy+mt+fBW2r8y5a3L0v44Bvc4awkCmKsH+vSAqo2rwyoSLOzVvc8gJ6Ehfl
	 ZWn6AxUHyP+FFFsr+WZ59q9BnJPj2FZlOLQ9ECoNG7Lz6Z8EWX+QPHG62HvyDnwNvW
	 ya8xRcp1yWEsDqj5+mIcHSUqUnHkGDKZIXbcQJ4He7MnSiRnDD1uUjG8w4ukB5ivxg
	 vuHFFXi4bHtn5qSYkf4S5KIef7vjuCP9Q+yIw//3YnvSo5FjWTATI5bxgSubHVkdMH
	 WO37Nbws/y66ctysclTsN8l8JvRGXHAC1I5S9pihdxDHv//aU5nbnYe/FAgAcR3kSV
	 vpOgIwGwnrrDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0DD83839A26;
	Tue, 16 Jun 2026 00:34:02 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 7.2 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260615122242.535455Aa5-agordeev@linux.ibm.com>
References: <20260615122242.535455Aa5-agordeev@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260615122242.535455Aa5-agordeev@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-1
X-PR-Tracked-Commit-Id: 37540b8c287fc817bdbd0c62bb75ad6eab0e5d03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25a01b5155d207e72bdd31b138406f37788403cb
Message-Id: <178157004146.358810.7454106325776137187.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jun 2026 00:34:01 +0000
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:agordeev@linux.ibm.com,m:torvalds@linux-foundation.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-20891-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BAF3C68AF9A

The pull request you sent on Mon, 15 Jun 2026 14:22:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25a01b5155d207e72bdd31b138406f37788403cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

