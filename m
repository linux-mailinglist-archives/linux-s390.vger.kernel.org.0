Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF681F1F97
	for <lists+linux-s390@lfdr.de>; Mon,  8 Jun 2020 21:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgFHTPX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 8 Jun 2020 15:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbgFHTPX (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 8 Jun 2020 15:15:23 -0400
Subject: Re: [GIT PULL] s390 patches for the 5.8 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591643722;
        bh=S2dgdKz0qpO5K3PKpxbGMyF2LqS48LdWq9imrKc7RwY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=C6rCccSUVHRx/QiTwJCp/8mL7wXj7NrwNlXoUP48rluYUlHr4viCd4HBqjKk6aJry
         brnHZKSmkUvXzjOr7L9kjDLiEJY5vt8FsXmDGxFfgp27fpKKc4pSrKKvPUIj8DDF1N
         ZEiQcYX4+i76yogrSBO10aDCsXKiorPc3feNmaDM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01591630479-ext-3636@work.hours>
References: <your-ad-here.call-01591630479-ext-3636@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01591630479-ext-3636@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-1
X-PR-Tracked-Commit-Id: bfa50e1427e4608ce6941d3d0855445fcaa7dbb7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23fc02e36e4f657af242e59175c891b27c704935
Message-Id: <159164372283.1639.1958353358477472739.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jun 2020 19:15:22 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Mon, 8 Jun 2020 17:34:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23fc02e36e4f657af242e59175c891b27c704935

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
