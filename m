Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFC9358C14
	for <lists+linux-s390@lfdr.de>; Thu,  8 Apr 2021 20:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhDHSVa (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 8 Apr 2021 14:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232287AbhDHSV3 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 8 Apr 2021 14:21:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F086661131;
        Thu,  8 Apr 2021 18:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617906078;
        bh=oq/5GaBkmH+sTSuBFD8TH80Vpb2jcEhy7pquPlDkyUY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EDev2Rc2IJm8ZQ+yrolVRfSrtgLI1gKsls/aUBdkUI4Pp6RcA2I/6mdZqgbZktJ0u
         0r04iCim0im2+r7RvAe5hAdGb05h3kXSeQ/PSG6wWyDpqPzk0/G2tgqnh0xW749euT
         npFAFWdYRsdTC+EoBJvYBgM7mdq2DYXbc8Ozk5KUNzTGU+6ZzkCt/agJz0JpVPAq1o
         A1wFKZc8lAZDY5tHyD6oKSj33YdkdmV1aYgWo2HXxsUnk7v9Cp+UtTUdTHvr8I2HBn
         /zcOSNeNK/SgoCX363FHZpcqDa1+NY5H+dDzJOBlR6Lhq8dZryyMhwl5JFBBzESpFB
         vCAxvBOgc/+WQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DC5CE60975;
        Thu,  8 Apr 2021 18:21:17 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.12-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YG9Bi8VS59wzWYXV@osiris>
References: <YG9Bi8VS59wzWYXV@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YG9Bi8VS59wzWYXV@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-6
X-PR-Tracked-Commit-Id: ad31a8c05196a3dc5283b193e9c74a72022d3c65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3fb4f979b4fa1f92a02b538ae86e725b73e703d0
Message-Id: <161790607784.31975.331667982880418001.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Apr 2021 18:21:17 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Thu, 8 Apr 2021 19:46:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3fb4f979b4fa1f92a02b538ae86e725b73e703d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
