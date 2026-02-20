Return-Path: <linux-s390+bounces-16391-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO0WHljJmGl7MQMAu9opvQ
	(envelope-from <linux-s390+bounces-16391-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 20 Feb 2026 21:51:36 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A7216AC85
	for <lists+linux-s390@lfdr.de>; Fri, 20 Feb 2026 21:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D091E303C828
	for <lists+linux-s390@lfdr.de>; Fri, 20 Feb 2026 20:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5087A32F76D;
	Fri, 20 Feb 2026 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsW7bb4f"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8988632B;
	Fri, 20 Feb 2026 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771620680; cv=none; b=GAbgdyPBpFbRGvhB3mUqw9kMIwy4qdnr2g6swrWeL23Y/hlaDRgdpHCv1xWvf2tTZimLA13z478EKCAAnVSGygPn6u1DBMRySb0gKrOM9R4kMpahhFl8gsLzr9iVfQ5pa0o6yXwPesGVF7WRxsdkbBsPcsua/aR1LZk7As7odgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771620680; c=relaxed/simple;
	bh=KZuXWzbF8MxgSVRaBoRJm0sxCDXm2S6aLrC1CKLjN2E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pAlBqxbGBytm2vqkX9ijRGnzF+BpBkmuDhOWlli4WZzCtk85xIfxw02YWIEhXsBOju8dTGn2I4NvZrWIuBuekwN+RpA1jQW+cnVMkSZzgzS6n68uYv6A5bTWYHSzNW2xKS/rXoctPNUqt+lU2mqeLg/7rMmiCj8N+Ld1u731Lgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsW7bb4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C81C116C6;
	Fri, 20 Feb 2026 20:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771620680;
	bh=KZuXWzbF8MxgSVRaBoRJm0sxCDXm2S6aLrC1CKLjN2E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VsW7bb4f4oJoS+7tf2u3eLMXmNd89wtQyWCULZXTFpPx9OvVY4HXVoMXHX18zAv6p
	 ZeBanBBq16m9mWhHjet4/buI6/dTV2V/Yjr0v4PZ1xv5PXGPenHuD7qNJfau7Hn6Mh
	 ZRCK576o+f+WnjbDrn1Ah9/64DVZdSiJZO9G/3NlQL2VvUs4B5p9SRACf/cvvESeS7
	 +iFbLsObmRwvuF0hDnBDg4v3biTwLuA+iFzP3emf3Pjy0aH1NXFhxs5rb7mIu+NQGp
	 y8FEHhfgzow7bw9ROKhr0Ps0eI5SR0WI3f23kaLMiEUjF+xqK7c5eHAnA2VHsvMQs+
	 DTc4aGViYlTWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF833808200;
	Fri, 20 Feb 2026 20:51:29 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 7.0 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260220123333.20950Aed-hca@linux.ibm.com>
References: <20260220123333.20950Aed-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260220123333.20950Aed-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-2
X-PR-Tracked-Commit-Id: 123d2e75a14e8a21cecac3f3452221ba901f8111
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9806790115d1949ee0bd6ef8533293b5a293a1bb
Message-Id: <177162068784.904298.10958454176817050028.pr-tracker-bot@kernel.org>
Date: Fri, 20 Feb 2026 20:51:27 +0000
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16391-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8A7216AC85
X-Rspamd-Action: no action

The pull request you sent on Fri, 20 Feb 2026 13:33:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9806790115d1949ee0bd6ef8533293b5a293a1bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

