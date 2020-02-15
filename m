Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3F91600A9
	for <lists+linux-s390@lfdr.de>; Sat, 15 Feb 2020 22:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBOVZV (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 15 Feb 2020 16:25:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbgBOVZV (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 15 Feb 2020 16:25:21 -0500
Subject: Re: [GIT PULL] s390 updates for 5.6-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581801921;
        bh=xQAUDgrlEIKwRrqLbOqqWwr6wGKKscusEN73BeAbVaM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dKF8uMNNhZxNcCLxW5jjJ6W+rXMpCBj8nVW1OxLF5Bv8hNK1EwnCJHSkak2zEEmw5
         BIXf411pefN5ufK14LqNhwI/X1Scl4ehNgglWQASupZCVf2pX+ZQQkxZWn6+Mp0BRX
         bEct49BSGa9rQnuMffDHXFOi6ZdJ/O3oKgmsMsNM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01581769647-ext-0154@work.hours>
References: <your-ad-here.call-01581769647-ext-0154@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01581769647-ext-0154@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.6-3
X-PR-Tracked-Commit-Id: c7ff8573ad21dcdcbcffd66fbfca3b53cd67d2b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e71e1214b6643faf90157e6655a86227938b080
Message-Id: <158180192101.10388.9567014108023645818.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Feb 2020 21:25:21 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Sat, 15 Feb 2020 13:27:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.6-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e71e1214b6643faf90157e6655a86227938b080

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
