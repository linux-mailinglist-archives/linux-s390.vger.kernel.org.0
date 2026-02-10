Return-Path: <linux-s390+bounces-16241-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMQDOFq9immmNQAAu9opvQ
	(envelope-from <linux-s390+bounces-16241-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 10 Feb 2026 06:08:42 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D04D116F6D
	for <lists+linux-s390@lfdr.de>; Tue, 10 Feb 2026 06:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C85E9300C0D2
	for <lists+linux-s390@lfdr.de>; Tue, 10 Feb 2026 05:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F04631355C;
	Tue, 10 Feb 2026 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+5cnl6w"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2412F5A1F;
	Tue, 10 Feb 2026 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770700111; cv=none; b=HOIhgVGg9XmRlGNLOCFkTRbmnkAIiRKprtB1jK34qFpx0Sjyf7awPA499iqjiNO0/bUg1TYrUbi8FMVC72UIYsA3C6SVPRqqWeR8mekOvFgehzMsLwZGk7XfmZvzp9aR+oas54wq1xbE1FJwErRxDu3za4ssUWcCMpvLRkzBsNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770700111; c=relaxed/simple;
	bh=9h1qsQ8IGZUCSqjBkA8+S2AmHkHbZ1xhsgTLG9VsuW8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NSSxdWfAusO2ec2WJY+RP4yBd8+ZDGnmDwGmc4FC8zv/d+VC8FjuwVf4mIJ0/MXSGZFF00kjvHGHXCsf4jPxsfuZhZ5eapq0kbQN1FVKSzPv48JVq88FMdfud9wgkxMRvwdXmNCqQi+xOW6KAAOe2gMVmV5eQs7Y0Rme/YkQrLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+5cnl6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40969C116C6;
	Tue, 10 Feb 2026 05:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770700111;
	bh=9h1qsQ8IGZUCSqjBkA8+S2AmHkHbZ1xhsgTLG9VsuW8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=m+5cnl6wq2RrRSlXGrvEr3KtDquF+Gc6iNJRSgajvhMJxDRD6wcUYoDFWoiwFkSrv
	 AIP/u/jNdq6+t3ujAt2m4GlDEOOMRsn7GgFxauPy/CvnO7pLe5Er51/ltGORWNwxFi
	 GWLKBTYUMlCp1cySt0rjFWO5G5rREEo2Q8HRu8vo3C9hjxKTJyAfFsmFpPq0fmwZYC
	 duiHCLH6Rld50Q4KCqSF+fCKFFyuQcmtQw/WtEiOETFSiUu1wmh8c2jjGcUFZF/rz4
	 mJLRMfs3S3wNTw2p28GyIpUfQEwvZarDl0No109WddsV0cZgRviHEyeNKXll5tLK09
	 WcMPZYC8bw3AA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B1EC380AA5E;
	Tue, 10 Feb 2026 05:08:28 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 7.0 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260207175105.10023Acc-hca@linux.ibm.com>
References: <20260207175105.10023Acc-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260207175105.10023Acc-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-1
X-PR-Tracked-Commit-Id: 5ae76830c76cf38708399245606e4e07a33fe51c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c48953d81972bfe16a9e3551883992aa6efe541a
Message-Id: <177070010675.3352335.10173052945914625585.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 05:08:26 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16241-lists,linux-s390=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D04D116F6D
X-Rspamd-Action: no action

The pull request you sent on Sat, 7 Feb 2026 18:51:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c48953d81972bfe16a9e3551883992aa6efe541a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

