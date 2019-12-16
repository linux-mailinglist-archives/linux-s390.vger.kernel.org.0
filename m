Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE0411F49C
	for <lists+linux-s390@lfdr.de>; Sat, 14 Dec 2019 23:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLNWFg (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 14 Dec 2019 17:05:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbfLNWFP (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 14 Dec 2019 17:05:15 -0500
Subject: Re: [GIT PULL] s390 updates for 5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576361114;
        bh=7t1evyNR7hgGjMsXzZTdRERzbmsXgpGY/ZvFLZ+Fe1o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bN0yWJlGU24op1/SPS/RyIOR9L03TlEwRNjSAI1lmjgbqMiFW4g/8HAcjQ6G2wo/+
         mwIEI58QpBzdXHnKTk5338iT7WKLLqwz78xo5wvJJzBF/Ff0G9NQz0mns7jaED9hOl
         DYEJenflvle2xw5S1pmAewyXoFBioO7wrQgcJMiU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01576325419-ext-4863@work.hours>
References: <your-ad-here.call-01576325419-ext-4863@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01576325419-ext-4863@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.5-3
X-PR-Tracked-Commit-Id: 3e39ce266a273e5751e5792aee248cb8d9630c8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81d559849aa4d972a2d297840eefdd20c4054131
Message-Id: <157636111465.10255.15224540830413807139.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Dec 2019 22:05:14 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The pull request you sent on Sat, 14 Dec 2019 13:10:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.5-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81d559849aa4d972a2d297840eefdd20c4054131

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
