Return-Path: <linux-s390+bounces-18992-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH9uB+Ex6WndVgIAu9opvQ
	(envelope-from <linux-s390+bounces-18992-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 22 Apr 2026 22:38:57 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AFF44AAA7
	for <lists+linux-s390@lfdr.de>; Wed, 22 Apr 2026 22:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DE143099F17
	for <lists+linux-s390@lfdr.de>; Wed, 22 Apr 2026 20:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44517333730;
	Wed, 22 Apr 2026 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ru45GAwl"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208EB277C81;
	Wed, 22 Apr 2026 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776890327; cv=none; b=GuhXd56DVPCAbiywMv/xht7/cD1rXzJLcQt0F7HC0p3U620B9hDJifmekEO2QkMjyYBqV2v8DTG+01FvjLeU7stdtt+ND+uv7p83f8GR/z5KODjufaUE2kK0dboqrGE/gtZVSbCLkxI7d7nAFRkyCW0hgQkjPHW8oBl4eiElTBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776890327; c=relaxed/simple;
	bh=SrQQ0v0qlcHkxWeb01xHyHGMVrwsNiYq/IYwTSIW9VE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=u+X1Tqgolsz52V9TasxoezniCpAlWhoBZR7/Lweq5qTHTJZARiXxk6hfbRByx7pG6NkdQpOSe6Xcw7qYL0o39bxqHf+T6RK6M05w1F4QDyVWRIXIDp6TGZRxaXwloTVJg+Yx0UyiEbKhsSGwzE+nlOxhe/MTBYYsnG2zWg6436E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ru45GAwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07977C19425;
	Wed, 22 Apr 2026 20:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776890327;
	bh=SrQQ0v0qlcHkxWeb01xHyHGMVrwsNiYq/IYwTSIW9VE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ru45GAwlBV+o8SUY8zqbEUwsrgue+qvsUqmOHmW8FzMTS2bAwaAAyh5MbSdy+Jc4E
	 4BMJPHShtk7kMRpeutSyQYRWgFTo12hNRLk3+UlSPfsEIcvcsINcI434216mvN+Z3W
	 0/YRLkwEvde1GrVgEGhlgE9smCcO1cFW0uu1pk3+s3VyahEDO0rCGG1SfMa76yB+fw
	 /EBeSubnrV1vTByBZQKDL1X0ZKa+5aF5srSPu16zGhJIUpFAFfpRaUlhemPUi9bozJ
	 zDjSfzWv8B60R4JzeJ+pwWMj/wvFvAqPD+qslgtcCrF/nbhkU9lZQUmyvYdo01eRrq
	 0q6oxnNPK5EoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEBA3809A84;
	Wed, 22 Apr 2026 20:38:10 +0000 (UTC)
Subject: Re: [GIT PULL] s390 patches for the 7.1 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <ttdwlsl@ub.hpns>
References: <ttdwlsl@ub.hpns>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <ttdwlsl@ub.hpns>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.1-1
X-PR-Tracked-Commit-Id: 8d7ea40011551c2ec915ee0260cae1c746c63156
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a4c0c11c0193889446cdb6f1540cc2b9aff97dd
Message-Id: <177689028915.4027770.9279330271310415125.pr-tracker-bot@kernel.org>
Date: Wed, 22 Apr 2026 20:38:09 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18992-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0AFF44AAA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Wed, 22 Apr 2026 18:29:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a4c0c11c0193889446cdb6f1540cc2b9aff97dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

