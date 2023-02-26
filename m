Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4D76A31E3
	for <lists+linux-s390@lfdr.de>; Sun, 26 Feb 2023 16:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjBZPJ1 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 26 Feb 2023 10:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjBZPJN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 26 Feb 2023 10:09:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EBB23339;
        Sun, 26 Feb 2023 06:59:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5EFCACE0E8C;
        Sun, 26 Feb 2023 14:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93344C4339B;
        Sun, 26 Feb 2023 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677422784;
        bh=c66ZqseNXtvYab1W9Mmr1L9hnpx98bZ6fpgNuOsd55Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NMmy6CbePPneNL5JJf/3bmzXOIc4GQYfkxpmbDlmTur3RNISE31w1iKWvpnxs6s9z
         Lcje0sqXukZjG18GCcTbGcOvZrKY3gDJWL3+hewaUA0bQV9XptQStQcsNzqaawPgAa
         hTrA+KlmVbApJe10+5u5oJhByk/N+4wfIXlTfOX6cs+Z6psG2L6RcioWffT4/+mndQ
         /6XfJ2JOUIH3oQ9msaeqtaHbVkbgusq1eBEbevWslaWxY1HADuACWj7ZOfCVwWgldz
         IuU0JJbj4VhZ2HTv3St7YcN79JTbv0ei6dtFj/YCR+Itm9OxB5LLaG1SFDs0Jk4C3b
         VSNEh+Qz2OmGQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, gor@linux.ibm.com,
        agordeev@linux.ibm.com, peterz@infradead.org, mingo@kernel.org,
        npiggin@gmail.com, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 41/53] s390/idle: mark arch_cpu_idle() noinstr
Date:   Sun, 26 Feb 2023 09:44:33 -0500
Message-Id: <20230226144446.824580-41-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230226144446.824580-1-sashal@kernel.org>
References: <20230226144446.824580-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit a9cbc1b471d291c865907542394f1c483b93a811 ]

linux-next commit ("cpuidle: tracing: Warn about !rcu_is_watching()")
adds a new warning which hits on s390's arch_cpu_idle() function:

RCU not on for: arch_cpu_idle+0x0/0x28
WARNING: CPU: 2 PID: 0 at include/linux/trace_recursion.h:162 arch_ftrace_ops_list_func+0x24c/0x258
Modules linked in:
CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.2.0-rc6-next-20230202 #4
Hardware name: IBM 8561 T01 703 (z/VM 7.3.0)
Krnl PSW : 0404d00180000000 00000000002b55c0 (arch_ftrace_ops_list_func+0x250/0x258)
           R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
Krnl GPRS: c0000000ffffbfff 0000000080000002 0000000000000026 0000000000000000
           0000037ffffe3a28 0000037ffffe3a20 0000000000000000 0000000000000000
           0000000000000000 0000000000f4acf6 00000000001044f0 0000037ffffe3cb0
           0000000000000000 0000000000000000 00000000002b55bc 0000037ffffe3bb8
Krnl Code: 00000000002b55b0: c02000840051        larl    %r2,0000000001335652
           00000000002b55b6: c0e5fff512d1        brasl   %r14,0000000000157b58
          #00000000002b55bc: af000000            mc      0,0
          >00000000002b55c0: a7f4ffe7            brc     15,00000000002b558e
           00000000002b55c4: 0707                bcr     0,%r7
           00000000002b55c6: 0707                bcr     0,%r7
           00000000002b55c8: eb6ff0480024        stmg    %r6,%r15,72(%r15)
           00000000002b55ce: b90400ef            lgr     %r14,%r15
Call Trace:
 [<00000000002b55c0>] arch_ftrace_ops_list_func+0x250/0x258
([<00000000002b55bc>] arch_ftrace_ops_list_func+0x24c/0x258)
 [<0000000000f5f0fc>] ftrace_common+0x1c/0x20
 [<00000000001044f6>] arch_cpu_idle+0x6/0x28
 [<0000000000f4acf6>] default_idle_call+0x76/0x128
 [<00000000001cc374>] do_idle+0xf4/0x1b0
 [<00000000001cc6ce>] cpu_startup_entry+0x36/0x40
 [<0000000000119d00>] smp_start_secondary+0x140/0x150
 [<0000000000f5d2ae>] restart_int_handler+0x6e/0x90

Mark arch_cpu_idle() noinstr like all other architectures with
CONFIG_ARCH_WANTS_NO_INSTR (should) have it to fix this.

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 4bf1ee293f2b3..a0da049e73609 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -44,7 +44,7 @@ void account_idle_time_irq(void)
 	S390_lowcore.last_update_timer = idle->timer_idle_exit;
 }
 
-void arch_cpu_idle(void)
+void noinstr arch_cpu_idle(void)
 {
 	struct s390_idle_data *idle = this_cpu_ptr(&s390_idle);
 	unsigned long idle_time;
-- 
2.39.0

