Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201453BAEA9
	for <lists+linux-s390@lfdr.de>; Sun,  4 Jul 2021 22:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhGDUMR (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 4 Jul 2021 16:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhGDUMR (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 4 Jul 2021 16:12:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E03C060FDA;
        Sun,  4 Jul 2021 20:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625429381;
        bh=R3Aoq5ACU1CH32EuxL2yGrJDbv3o7kcdEpxXe1NwEaQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hET1ANEIYx5LSx57WtDaQA0htYhLPbrfHQQOHqVO8qkfFgZSnsmLjQZ6+9/6re5QD
         7GN6vlcQTcT+dXDl5TihY1/c/BKI6iS0+1Jjjdvl4BiGPlAaVWso1QoKXoRsQ/mUI9
         ZRQVdE1QhHlXClW1tsdsfBLFZ8JZRGgY6Yk2xwt1hre/gS8wZvYq7+1ckQqInyjTGj
         PCZRnddHKfrgXl3ASfI+NSju0nyzI2Y0L3f7W8uyknZpoTI/nJDIwAEsODzJk+sk+M
         xr+GyGE/cySqelSHqsBeTzjd/2mjzY2wlot1wmYqAdI/pHKc42iq8STtxcC8NkIQnY
         pWMsXhE6GieAQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CC93A60A27;
        Sun,  4 Jul 2021 20:09:41 +0000 (UTC)
Subject: Re: [GIT PULL] s390 patches for the 5.14 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01625406648-ext-2488@work.hours>
References: <your-ad-here.call-01625406648-ext-2488@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01625406648-ext-2488@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.14-1
X-PR-Tracked-Commit-Id: d4a01902eb59e478ab7c7d36d7bb90d94a315f89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2bb919b62f6e5959552a90a399d09d683afa3d1d
Message-Id: <162542938177.15409.1818021014941919152.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Jul 2021 20:09:41 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Sun, 4 Jul 2021 15:50:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.14-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2bb919b62f6e5959552a90a399d09d683afa3d1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
