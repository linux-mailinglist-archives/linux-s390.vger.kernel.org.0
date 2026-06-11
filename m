Return-Path: <linux-s390+bounces-20792-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nKCEEbMhK2pW3AMAu9opvQ
	(envelope-from <linux-s390+bounces-20792-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 11 Jun 2026 22:59:31 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C195B675586
	for <lists+linux-s390@lfdr.de>; Thu, 11 Jun 2026 22:59:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PqoEwNRc;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20792-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20792-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 000D13034C5D
	for <lists+linux-s390@lfdr.de>; Thu, 11 Jun 2026 20:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD524CA28D;
	Thu, 11 Jun 2026 20:58:57 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A6F4D9914;
	Thu, 11 Jun 2026 20:58:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781211536; cv=none; b=UHl9hB9uaSQZnesMxlkkP3GVMBsdbD+1w8d6jZbgFXhIx1pY7S/O8d2jBgtMxO0x73CdHXfUUXre7+srZ0J6IwIYdDM3xSmdoPKDE71sNVFkRq7Tw9vHjzjEdm+NIndoZigS5hUZKoNKzstXAudB6PcmWfXQSORFLG/c0QECZmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781211536; c=relaxed/simple;
	bh=jVYlTn4deprSNAmDB4bHrDF5Yspcy0Y4BJpwXOSgnqM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rlM3kLsHYMDzSCYDgpg9qEoCmNqqAxLjAfuxSkGICJgotv4Qruuyn25Tg3mB6JfCJa29WKm5GV8vq06QuH7IN8W8rYOa1Gl0iKzN68FnRmADhVvqmoz5KsLxaDm4TTjyOrUZrSAq2PFoJXUj/5PgoKnK0rCSc91DI/gmSmEkTAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqoEwNRc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269FC1F000E9;
	Thu, 11 Jun 2026 20:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781211534;
	bh=/r/GRHT5zJQB4AUU2KpAMr9jhT+8MyCyhkPs90XdFDU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=PqoEwNRct8T0D4snTrsgUVDcZHhwYmD9Fmg6NzoEI9U6/2OlfFt3m0QRjL5WOe3JP
	 MBIHGNuN83fo2QhtOtOa6cd14xMqxy6N/tNI83WEhPSXTURZ/b2j2vrIzbspdu0YqK
	 eiljUHTimnroy9rnUCzA5qlQoQFiWyQs2UGd+2TIoZjGJKdMNjg178MWX7AdwigV7O
	 3VUHp0ExLR5eq2U4ImlCexqump3zF0AUs+++165RTltlP3c8lsMKoFMfYIRhpzuvD/
	 Elxj8RRztuQbC3CVeEIZDVSKD9/6J/r0FKVOm155kTYE26sjpdBwJ+Xe30YWl8PAZ7
	 qB1kigHPJNesQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9390D3930FAA;
	Thu, 11 Jun 2026 20:58:52 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for final 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260611142254.3501080A79-agordeev@linux.ibm.com>
References: <20260611142254.3501080A79-agordeev@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260611142254.3501080A79-agordeev@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.1-5
X-PR-Tracked-Commit-Id: 1f57f68c4dd101e5e8ffc9ffa6428f45bcdd776a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b414a95b8f7307d42173ba9e580d6d3e2bcbfce
Message-Id: <178121153112.362744.1910205287356269043.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jun 2026 20:58:51 +0000
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:agordeev@linux.ibm.com,m:torvalds@linux-foundation.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-20792-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C195B675586

The pull request you sent on Thu, 11 Jun 2026 16:22:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.1-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b414a95b8f7307d42173ba9e580d6d3e2bcbfce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

