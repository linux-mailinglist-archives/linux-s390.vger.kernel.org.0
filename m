Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04813E1CA0
	for <lists+linux-s390@lfdr.de>; Thu,  5 Aug 2021 21:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242905AbhHET0V (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 5 Aug 2021 15:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242838AbhHET0T (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 5 Aug 2021 15:26:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EA0276056B;
        Thu,  5 Aug 2021 19:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628191565;
        bh=kaGHxD7QMRmDG5kzvQC25dk7cHg93iQFsD4zuM+MkaY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H5JayNEJgUFwP9NOYeXggLFU111f2lMeRnsLnsnRZIMgap2Z3xTnBSz6MIppdajnA
         GGi5Fisw697UMFe5Pk/os4B10hWIAviinCexgvcyK9btLnWtY7cYWtD6QeV5V0fPGF
         Xn4YQjY/cgMk+hJWr/NKW5c/jEQMCzggsXxXd0lPaTWMht7vmcgvmHJ94Wa1uUEp+w
         9jW7wV1tiIe6iJLMhPBY69Nq8ZcUBJTfFRLAEnTD6wRPHhUPG6Ii6Fh96V1sxwSGk1
         slCKOHWUKWjyv288FgB7LLbK0dxTi6PrLkDNw+eodMmULTQY7ZtRHYt2PmMGbOEp4j
         HZ0BLj2CZ1RUQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E4FA560A48;
        Thu,  5 Aug 2021 19:26:04 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.14-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YQvly2QgTY+KVfRH@osiris>
References: <YQvly2QgTY+KVfRH@osiris>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <YQvly2QgTY+KVfRH@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.14-4
X-PR-Tracked-Commit-Id: ecd92e2167c30faa18df21e3ec3dbec510ddebaa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 130951bbc61f59133ed04e244db25a63edc6935f
Message-Id: <162819156493.13342.17910198750576813678.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Aug 2021 19:26:04 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Thu, 5 Aug 2021 15:21:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.14-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/130951bbc61f59133ed04e244db25a63edc6935f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
