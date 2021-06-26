Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0703B4FB4
	for <lists+linux-s390@lfdr.de>; Sat, 26 Jun 2021 19:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhFZRRX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 26 Jun 2021 13:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229916AbhFZRRW (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 26 Jun 2021 13:17:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3ABC761C18;
        Sat, 26 Jun 2021 17:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624727700;
        bh=1B9Ize+vAo62y89xS61LTfdZOwFeWLB/MHYj2+6rbE4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qlaRDrmg4wsMcCPfIJjG/4kHbRkin2uKw+1Tg1q6pRjFpf8SIObL7G1pbqAG0GJJF
         FY5a5nyxDUSUu7vrGsPhQ2eAvI4EIwX2miDePCWDehQ4oiGJANPp/aLoEWZF2IS0GJ
         M9ufHZBvrpEgD8BSsbotEs/NpybByNJX4AVNRYhboViUY70vWpZhmTehkw220p103E
         RzpA8SEpJSIRcbu+ZdVWu6ozT5BKhOCRJntxkKfOHE7xb0HP9EYvJM3mhZQGXRjsfw
         4CS+qHjsGUoayszqZ5wFCwRx2y2g4vP7CIUD5Ztj1T+UzAsGMiXxswwjU5LR7HCnPt
         TKy5NAMY8pKZw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2860D60A38;
        Sat, 26 Jun 2021 17:15:00 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 5.13-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01624709806-ext-4573@work.hours>
References: <your-ad-here.call-01624709806-ext-4573@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01624709806-ext-4573@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.13-5
X-PR-Tracked-Commit-Id: 67147e96a332b56c7206238162771d82467f86c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 625acffd7ae2c52898d249e6c5c39f348db0d8df
Message-Id: <162472770010.31360.2209876330801293889.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Jun 2021 17:15:00 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Sat, 26 Jun 2021 14:16:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.13-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/625acffd7ae2c52898d249e6c5c39f348db0d8df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
