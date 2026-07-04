Return-Path: <linux-s390+bounces-21563-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dOrVNk05SWqpzQAAu9opvQ
	(envelope-from <linux-s390+bounces-21563-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Sat, 04 Jul 2026 18:48:13 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FED707FF7
	for <lists+linux-s390@lfdr.de>; Sat, 04 Jul 2026 18:48:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EVJHiaiM;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21563-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21563-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A67B302F5AE
	for <lists+linux-s390@lfdr.de>; Sat,  4 Jul 2026 16:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8716372EE3;
	Sat,  4 Jul 2026 16:42:55 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFC434A796;
	Sat,  4 Jul 2026 16:42:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183375; cv=none; b=nz54J5etPVFYx27V5JroY2lW51ou6NG0hCrge9IhCGQLKAUAtnJR9V7tR0qTOjq7afh9p2F6LqlkFj1o5ISFPkY2Ago7Zv9kX5HtZqDJR+65eOnggPob8TFQxDxoho5XzUUWfoPUb6bZD/g7suGmT4qPWPtOMJr52MdQwNZ1coQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183375; c=relaxed/simple;
	bh=k3/zIyAuvN9oGfXm4d6oyjwB2rX7c1Pv7AaW0gNQsoI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nXxjIRTLn3hCAZio0dZ0SBDZYJTXbQVxjiKeCGzXS7449hnZxVhUsxXJHJd+0NL3H7OjVagx+ArKGdobwT139zv8+P2wm97KD+BLNBVEJ32a4n+Z8rFll6iTlaA2Dmjk3Js/3tV4dgy67KI2hAGQiKCNSI4cUAz5eUM6WTop+sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVJHiaiM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8B01F000E9;
	Sat,  4 Jul 2026 16:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783183374;
	bh=954g+7+gOFjr2iYKYGn5iDPqr2IJHedyXxcx2EJWE34=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=EVJHiaiMs6xNodI6+O0zt6xTzdFAMggPLHB93SdiBIsl62VzUig8A983F/DOC86tW
	 cE1AbMAHENwq5y5RYPGyrenGSRpEBu8v7We2KCN7qDVQYErbXjrS+dRQrELdOvyO/k
	 kQG19gc9GIkAjU/CMLmYrLPMpuAioAJ7jceyDAlrvzALVeELUr4fjf/BTJRZKmNYD7
	 QStj7Ie+UTt+yGRz9j9e5sECZxUcgX/5s9U1l+hgoKxAzL5FQ6/l+Tmtl9qTcKgLQm
	 u6e809+22tfRf65fwXXOippOjvxIqiG52puVoCR6dvm7tSboAi8+tBBpsHeFpPdA+q
	 wv+6a02OWlJ4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1993138119CA;
	Sat,  4 Jul 2026 16:42:37 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 7.2-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <t@ub.hpns>
References: <t@ub.hpns>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <t@ub.hpns>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-3
X-PR-Tracked-Commit-Id: 2995ccec260caa9e85b3301a4aba1e66ed80ad74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7404ce51637231382873d0b55edabc2f3b841a9d
Message-Id: <178318335568.3585371.6070001375676672298.pr-tracker-bot@kernel.org>
Date: Sat, 04 Jul 2026 16:42:35 +0000
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:gor@linux.ibm.com,m:torvalds@linux-foundation.org,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21563-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60FED707FF7

The pull request you sent on Sat, 4 Jul 2026 18:27:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.2-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7404ce51637231382873d0b55edabc2f3b841a9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

