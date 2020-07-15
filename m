Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A821221675
	for <lists+linux-s390@lfdr.de>; Wed, 15 Jul 2020 22:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGOUoy (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 15 Jul 2020 16:44:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgGOUox (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Jul 2020 16:44:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15E342065F;
        Wed, 15 Jul 2020 20:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594845893;
        bh=lSC8kgUvJWuaUKxsKjBjCdclZg7uZic1lS/dXUaF4qU=;
        h=From:To:Cc:Subject:Date:From;
        b=Rd1HgCn+i2GELxHAvY1++7DeYlnlASEqXe0kXTtOIoywbloM3mdxRmiKeaJJxZAun
         XEKJqSmapHsBZF0OgNqGHOTzbq9DYdcdD+x+JsHtRGnpksIXE4GskpmC2Kod73ecwk
         mMAB8jTtYGl/WH2yrOysvfXAtJ6OPjQ4zgOBq5hY=
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] arm64: Convert to ARCH_STACKWALK
Date:   Wed, 15 Jul 2020 21:28:18 +0100
Message-Id: <20200715202821.12220-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This series updates the arm64 stacktrace code to use the newer and much
simpler arch_stack_walk() interface, the main benefit being a single
entry point to the arch code with no need for the arch code to worry
about skipping frames. Along the way I noticed that the reliable
parameter to the arch_stack_walk() callback appears to now be redundant
so there's also a patch here removing that from the existing code to
simplify the interface.

This depends on 0de674afe83cb2367 (arm64: stacktrace: Move export for
save_stack_trace_tsk()) due to the code that was fixed there being
removed.

Mark Brown (3):
  stacktrace: Remove reliable argument from arch_stack_walk() callback
  arm64: stacktrace: Make stack walk callback consistent with generic
    code
  arm64: stacktrace: Convert to ARCH_STACKWALK

 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/stacktrace.h |  2 +-
 arch/arm64/kernel/perf_callchain.c  |  6 +--
 arch/arm64/kernel/return_address.c  |  8 +--
 arch/arm64/kernel/stacktrace.c      | 84 ++++-------------------------
 arch/s390/kernel/stacktrace.c       |  4 +-
 arch/x86/kernel/stacktrace.c        | 10 ++--
 include/linux/stacktrace.h          |  5 +-
 kernel/stacktrace.c                 |  8 ++-
 9 files changed, 30 insertions(+), 98 deletions(-)

-- 
2.20.1

