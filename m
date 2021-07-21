Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4FB3D1870
	for <lists+linux-s390@lfdr.de>; Wed, 21 Jul 2021 22:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhGUUOG (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 21 Jul 2021 16:14:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229738AbhGUUOG (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 21 Jul 2021 16:14:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9923861009;
        Wed, 21 Jul 2021 20:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626900882;
        bh=GYGNogGu+jhewfWZhRoGPpIWczxpITQfjsoJjB/iBw4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VY1sRhuQdxzlODEUTbCRdrNZyW6UbAmAYMEm5siw5GgCkKlrdruyDaW16NrKRD59l
         2YKIovtBguTsek+u8wwms5gs1pa9mw1slOYdiPzFM8e/ef5lTUV2q9deAzrgcwzpx+
         a+DXtSOIxbo3J1D6xB6w0AqSEtrxyQ2UPhR0+6SMz7kIxXWzR+cHChhbJ3L+xPAMR0
         uktMRlYVwYCAyL8H69ZfCCL/mW8Kc8+m4CptWwoDqepYfWSPRvNV3kvnc3pWQfag+O
         E3vU4ki3nUBRbPDNQOAkD3uBZmfNH755Cj1faN58noA1iwNGh5sAdLvUXn6xtMPhrh
         uanka3IqHEnUA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8646A60A4E;
        Wed, 21 Jul 2021 20:54:42 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.14-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YPhrv8YEX7pVo73Y@osiris>
References: <YPhrv8YEX7pVo73Y@osiris>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <YPhrv8YEX7pVo73Y@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.14-3
X-PR-Tracked-Commit-Id: 0cde560a8bfc3cb790715f39d4535129cca9e6ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d5895cd351757f69c9a66fb5fc8cf19f454d773
Message-Id: <162690088248.6812.4345152659534973031.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Jul 2021 20:54:42 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Wed, 21 Jul 2021 20:47:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.14-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d5895cd351757f69c9a66fb5fc8cf19f454d773

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
