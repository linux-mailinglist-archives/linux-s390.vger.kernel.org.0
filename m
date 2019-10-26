Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE4EE59A8
	for <lists+linux-s390@lfdr.de>; Sat, 26 Oct 2019 12:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfJZKpJ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 26 Oct 2019 06:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfJZKpH (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 26 Oct 2019 06:45:07 -0400
Subject: Re: [GIT PULL] s390 updates for 5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572086707;
        bh=/O7DfNPYpSv+tqEzW3t2Yux73Vui6akwaxl+F0AQQYM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yO6j4k0VsYRVFlkBlwv5LYLTEt30DMRt/uidqaymWHmK/kYSgDW8GDmzy3f3U5S2+
         6vx3H6KBpDtTn6ZY2NtkWJ2+Y0xS9uPaRtbpNXyW9xfpENH+qME2gNM0vlHy8F6WNP
         5czIiVSpK9MTMyirwtTqvbzsM3KvHr+F/qaxNNzM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01572084898-ext-1277@work.hours>
References: <your-ad-here.call-01572084898-ext-1277@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01572084898-ext-1277@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-5
X-PR-Tracked-Commit-Id: ac49303d9ef0ad98b79867a380ef23480e48870b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f877bee5ea0b56c39cd0a243e113a577b5a4ef92
Message-Id: <157208670731.20302.6383353662643415232.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Oct 2019 10:45:07 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Sat, 26 Oct 2019 12:14:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f877bee5ea0b56c39cd0a243e113a577b5a4ef92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
