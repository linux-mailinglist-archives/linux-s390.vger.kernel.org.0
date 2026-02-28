Return-Path: <linux-s390+bounces-16653-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D3oDWclo2kO+AQAu9opvQ
	(envelope-from <linux-s390+bounces-16653-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Sat, 28 Feb 2026 18:27:03 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB8B1C4E2C
	for <lists+linux-s390@lfdr.de>; Sat, 28 Feb 2026 18:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8F6C307AA20
	for <lists+linux-s390@lfdr.de>; Sat, 28 Feb 2026 17:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C35329E60;
	Sat, 28 Feb 2026 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSF2Z/mL"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DAD328B78;
	Sat, 28 Feb 2026 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299583; cv=none; b=Fn162ps+Jy4sUXzb/mOxf3x5EtQVJUMT6knEAHtlXPXvkWWN6DTZNBkiupLcjhxfL5BdZXRo35NvrdKcEdKTi4iQFneCnng+mCJylL2lVBuBa+eg/cMXdGt04gDm6MjwkcwAMSTkpvhbO5PhpE+2P+z7M67ThvvFRPeU7rwJ9Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299583; c=relaxed/simple;
	bh=WjjPpnTVBAQpOOwHrKc9DLq4OeY0DlMTz6D638EeP+E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uqufmLA7KQrWmOsn7mz8Z38h8IlCpNTbKxfty7DGLpjg5KyCXzwM13Kv04WUGRxbQ13mOcZwErOWXNpVYhum+pu3jl/MgMOmLuQ8fVm6pfwVRqyz0RFTMJ3ueR9nDdMWhHy6BvO4XEo3+LH616LLKllwUTN8eUJCyXiGi2TKHT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSF2Z/mL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0B5C2BC9E;
	Sat, 28 Feb 2026 17:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772299583;
	bh=WjjPpnTVBAQpOOwHrKc9DLq4OeY0DlMTz6D638EeP+E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oSF2Z/mL4wMuUbgan1wtVzl0dBU9GtPUl/uRRkgXQkgYhxiL8RffNywWVgplzMQEV
	 2HkYzHnZSSLx5fuy3STIG7m8wrYC42l5k9e1NFYCKi84nrC8hKXF2422qVFG2tzu5H
	 a+GM1NdwqVfB6B9aEq1KO7Jc6Qqm+YEyAFoJtFr53/d7yyUyuJItUl0Rv4lq9J55Ke
	 gtH97X21BcYzP98hD1el1F5c8+0dLhqSdbm01L9kSMXC6CcGjwRDOeK9Fb6PhnJ2nV
	 45XTl831oiy0pOkJHzA+EmjIjsPtlpqf72T0+INSAXOvHs0As4tCp6smEwj7HpLOVZ
	 4qP5idD97sEYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F4439F2022;
	Sat, 28 Feb 2026 17:26:27 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 7.0-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01772291314-ext-5802@work.hours>
References: <your-ad-here.call-01772291314-ext-5802@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01772291314-ext-5802@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-3
X-PR-Tracked-Commit-Id: d879ac6756b662a085a743e76023c768c3241579
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 201795a1b72570374e6d2c72d5c1c23c9cfc3929
Message-Id: <177229958641.3021088.8858996152469840683.pr-tracker-bot@kernel.org>
Date: Sat, 28 Feb 2026 17:26:26 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16653-lists,linux-s390=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-s390@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CB8B1C4E2C
X-Rspamd-Action: no action

The pull request you sent on Sat, 28 Feb 2026 16:08:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/201795a1b72570374e6d2c72d5c1c23c9cfc3929

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

