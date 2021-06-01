Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4386B394D30
	for <lists+linux-s390@lfdr.de>; Sat, 29 May 2021 18:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhE2Qum (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 29 May 2021 12:50:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhE2Quk (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 29 May 2021 12:50:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1EF37610FA;
        Sat, 29 May 2021 16:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622306944;
        bh=/xJ/DfyZHkqZaUTk1sY0PT+Sib8QmQOEu0K5RtUdPxE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AjO01dxxdqQs7bto/1zF3Z/7uJDfk9djeKgFaDH4b7yEYxMGoMS/nENTJObxoo6Jn
         qnCFbQTlPl94tE/vjvbBpJs/7WbalsZ4kIGy3LAZzStJVOBLB49aVL/Xc1TlDIVhFv
         RYCbnOvW0zlY93NsCZpH+GESdHnmRADOrbcL/jI2+IJ7qq3UdH7HOaGRFEouUJdaNY
         J/7ka75FMPHFvyJ/STdV5SLG22J+8AOzAr3mYX43W+dwfwV6XtTWNnIMUyNFZUglOQ
         6BfmODRQGTLzok/WRrGiThwrQbzXnHoZUvM6/mfFgHv4Ht892Jsmkrdgn75u6X1YIv
         vMg6a7YTIrN+Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 179F260987;
        Sat, 29 May 2021 16:49:04 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01622279680-ext-7982@work.hours>
References: <your-ad-here.call-01622279680-ext-7982@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01622279680-ext-7982@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.13-3
X-PR-Tracked-Commit-Id: ffa99c436aa70c0c0980866523a6ae1023c96768
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 866c4b8a18e26b7ae41c45b1af57c82a66089985
Message-Id: <162230694408.3322.2106564012439486060.pr-tracker-bot@kernel.org>
Date:   Sat, 29 May 2021 16:49:04 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Sat, 29 May 2021 11:14:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.13-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/866c4b8a18e26b7ae41c45b1af57c82a66089985

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
