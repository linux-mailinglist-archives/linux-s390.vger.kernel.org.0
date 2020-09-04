Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082E025E30F
	for <lists+linux-s390@lfdr.de>; Fri,  4 Sep 2020 22:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgIDUtn (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 4 Sep 2020 16:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbgIDUth (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 4 Sep 2020 16:49:37 -0400
Subject: Re: [GIT PULL] s390 updates for 5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599252577;
        bh=jHZurQIJFjTXc5vQstnFYuZgTZtTqdiU/wBT6AqOKdk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0qPBQ7naZrcNUN/PzxYitnWNDt+QTSdHyyUSmz+4i9EaqGyRsQVRvAP1bl022ZThS
         zvRN4/o7h08rC3OSO78wjWmneBz+pXanN/aze/Pqe3PhhfjTES/mhY+N+IPCI+cKUe
         AEvdioRXUNFI2brYRTLgJgyZzL8l2rwt4X2mx73o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01599251714-ext-8456@work.hours>
References: <your-ad-here.call-01599251714-ext-8456@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01599251714-ext-8456@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-5
X-PR-Tracked-Commit-Id: 5c60ed283e1d87e161441bb273541a948ee96f6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c70672d8d316ebd46ea447effadfe57ab7a30a50
Message-Id: <159925257717.25529.13879443729060340087.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Sep 2020 20:49:37 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Fri, 4 Sep 2020 22:35:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c70672d8d316ebd46ea447effadfe57ab7a30a50

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
