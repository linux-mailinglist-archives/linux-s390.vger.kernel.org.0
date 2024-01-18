Return-Path: <linux-s390+bounces-1029-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B8E832218
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jan 2024 00:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C4D288C98
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jan 2024 23:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58881D684;
	Thu, 18 Jan 2024 23:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCClOrbK"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90628328B3;
	Thu, 18 Jan 2024 23:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705618912; cv=none; b=UNR9fVqQLGkQhvdVdRaEZAA+8Bv/YXRD71Apj4BSjIvk8rqla3vnmh/yY/qWp3Q079xuWuZlL/Jaw3ohT+Rdbab7TL4W+CPyka6t0c2K1OZ5vjPhigopECY3USsb913eN0XDqy7WFL9or0MOYckjUbLu6RFDECiXzFOLfv8h3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705618912; c=relaxed/simple;
	bh=d0Tyx4Cpw2lIQBdFZ6OzldvzawEpR8yaMXq7l33KRzk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=twSWZsdyNEQASmPU1A1TrSVkBKUQdpDrtMoVX2UEp+uXjWliWyzTbxuq1y/v3tFzU5vTydZfYBVJLDnFROqHpiHMxRNVwjvTJSN10tNUzLlMExqjx4Ni71WbTGSCi/lTNNHi6jVAE2TEZr79XQjHnPZMyYcm9jEHegQ4J8rZ9jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCClOrbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69262C43390;
	Thu, 18 Jan 2024 23:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705618912;
	bh=d0Tyx4Cpw2lIQBdFZ6OzldvzawEpR8yaMXq7l33KRzk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SCClOrbKMMoYT8LugMiIkq09nrjflEYuS/iQCf9hanrW+yORyLDPzF4+r1ZkSNfMK
	 VP5QGIcgkUZxWpRlo0WZK60DWdhr3RHkc7zid31D8sPbsSz9eYyLtmZ5XZj6+r7dZ4
	 Y2tdCsVcvcJryfAaBu8sVD3h7SyJIojDSX76lzHtlSs9GNfGaR9Yjm6GOzm7yEYyRK
	 EX1sQddRK3E++s55t+DgL3NpubdoI3aQ6Y7I5aLrEnvea/YOFKLsangUkZaAUK4Ldl
	 My7+0luYml9FkFzQT9BKeFES889/2nFGHHPfcg5LR5sQHMl0BF7iANW7B/EwSBAWjm
	 dgRaRHm6fiqrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55881D8C970;
	Thu, 18 Jan 2024 23:01:52 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for the 6.8 merge window part 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZalzXHWvCd8axzDj@tuxmaker.boeblingen.de.ibm.com>
References: <ZalzXHWvCd8axzDj@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZalzXHWvCd8axzDj@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.8-2
X-PR-Tracked-Commit-Id: b9bd10c43456d16abd97b717446f51afb3b88411
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 302d1858654494dbbb8541e3ea5f0f884c0e683c
Message-Id: <170561891232.14039.9014016143696485079.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jan 2024 23:01:52 +0000
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jan 2024 19:52:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/302d1858654494dbbb8541e3ea5f0f884c0e683c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

