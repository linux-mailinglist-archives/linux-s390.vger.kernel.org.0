Return-Path: <linux-s390+bounces-18523-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKlaBraZ0Gm69gYAu9opvQ
	(envelope-from <linux-s390+bounces-18523-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Sat, 04 Apr 2026 06:55:18 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 656AF399F08
	for <lists+linux-s390@lfdr.de>; Sat, 04 Apr 2026 06:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAF1F3036610
	for <lists+linux-s390@lfdr.de>; Sat,  4 Apr 2026 04:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F41935B64C;
	Sat,  4 Apr 2026 04:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAuLa0cT"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3D035AC12;
	Sat,  4 Apr 2026 04:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775278490; cv=none; b=ptAPnNJ+w5nvsamFNNJUStMEkm12lnnbPwQ9jAqa/oWhw3jcTEEZkxvKuhtq/h1/7zmN0e8/yzAC4mI+gdBq32XKyygiAcUltZQByPlWxECVsSMm7077v+4U1smabvxV/QJEAgim7Ms0NmZl+jSANz4dVgP8ZLA93z6psVGeSnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775278490; c=relaxed/simple;
	bh=XOjd2Whwe/4ddsMcf3m4XyeGoChHNUN+v3ZHHMawjJo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tqjYF/F7za8X9+fBu43K4nwqkCeF+hEeCVFdW1QLvQo1RANvAmU7MmpeUSnjJR89qnbsy/8GQOTsq6HJdw2L3qzG8th86mcAcogZRiF6IiWBgre631r2WFgfslL0iv179XycXHx1eG/MgYYZ2HX3qMgyLYOdd5hzT9FzyQDjKck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAuLa0cT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C0BC19423;
	Sat,  4 Apr 2026 04:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775278490;
	bh=XOjd2Whwe/4ddsMcf3m4XyeGoChHNUN+v3ZHHMawjJo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eAuLa0cTbtFzrzBYqg/L/0cDd62Ozb2/TVXHlbmYasJxhyvSZglVEHjhcWRPYRaYz
	 jhdNlSSa7+QoXzg08f4fu2QjxVy1llKNcVwzZ0wOYcmtvWwrCyrvnzngNebsFvaFxq
	 9iKZTS6pa+VZQSmOUsgZRB1XmEKWPcNpPvrdjkmSjCnyDrbLOnzYL0uM6KvnEjOAp8
	 ErczjkTgjtgCkXs2ZfBB2WIIfjVISBAwBZCvUp6u7gGZZJqKeNY4oMQtqQ3fGY74cI
	 MYhgsWdrVGXfgl34rWsNRwqCcO3o9mQ6VhYMzuvkrGqJkKunMQLqSvBQRXrGFkjVLf
	 6VvvmPjPBRa0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0243809A18;
	Sat,  4 Apr 2026 04:54:32 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 7.0-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ttcy1mq@ub.hpns>
References: <ttcy1mq@ub.hpns>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ttcy1mq@ub.hpns>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-7
X-PR-Tracked-Commit-Id: c8d46f17c2fc7d25c18e60c008928aecab26184d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3719114091cea0d3a896581e4fe5bed4eba4604b
Message-Id: <177527847115.1572522.4942123965089613634.pr-tracker-bot@kernel.org>
Date: Sat, 04 Apr 2026 04:54:31 +0000
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18523-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 656AF399F08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Sat, 4 Apr 2026 02:35:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3719114091cea0d3a896581e4fe5bed4eba4604b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

