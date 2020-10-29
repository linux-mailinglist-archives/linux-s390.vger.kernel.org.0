Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18ED629F17B
	for <lists+linux-s390@lfdr.de>; Thu, 29 Oct 2020 17:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgJ2Qbq (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 29 Oct 2020 12:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgJ2Qa7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Oct 2020 12:30:59 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D17C0613CF
        for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2020 09:21:13 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id k6so3650084ilq.2
        for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2020 09:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=mLHywIJ3QNJ995xTh2HxVL8jMUzrwmgGMZX0Gu1ngAE=;
        b=N7pUEasBg0d6BdkdsF2aa98HUWNIAUPYUlFivVebWKr3h3D2RWLzjTDEmTTub6Bydp
         P2NF7dTtEUKeJprlfBHjiP1UzKrFc5r3JW8jk2CvjNlzmZRRV57nWFk42CWDZO2DMmaV
         +ZyAsNVKFXLN+Fbr3StbuW5ibigrx76fSfpvQGYDaqtMEY0WwPakuXSJX3Xn62r0WSs3
         v7CBBIclX+qNHysMT5f43BEDc5JYaK9/1nST6YtIewLS9rI5wDR8BKTTvXkqscuReaj+
         J4DZeIE8l69u53JLFyzjvPHoKq+T7e135SaCUIwAZQShPgARehv0ds+SYX+sRCVk4/e2
         Fd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=mLHywIJ3QNJ995xTh2HxVL8jMUzrwmgGMZX0Gu1ngAE=;
        b=HxbUSs/5MLrmeSzfc8XzBjUNP3AfbRdhHEOjZbSYiGJmDFl/LTg/axsrL4zXLszE8W
         hbjujwazrtwtOxAFhcHgaJyiVk5NTFk84UJTBrRHpB4AovJ8ebUlB5+lWuWdAzBBbASR
         NNq7HfiTwP99omhUBILhkpMGoQvsP3ym/QGwoo1p4LJoGpHBD91YxU2Z79eEccHBhBaK
         70uOFiiI19L+H4+neIUdFnFgfyvap7IQ1S84koPQkTlATukTdG+ow6AGiBmPeuVDBtze
         tvSjkncdXI9j48ex/pToI3bbLGTooljfYuFXCCgCdKOZs84/fFNdjdXZkJd6+luo72xg
         PO1A==
X-Gm-Message-State: AOAM532CuF95ZgWRfORyFU3oG7/MqXGLSJXlqnX5fR743uQZMmG+Idx4
        hutnZq30LByuG3QM5zCDnCAPsD197utUgw==
X-Google-Smtp-Source: ABdhPJxTuMZ3jf+lIx676l/T/hGvW98bx/VPGQQhhfOGBCJQ8AFRYmvEG3mfBYjI/AhRCo5a5bTNXg==
X-Received: by 2002:a92:c7c6:: with SMTP id g6mr4067176ilk.230.1603988472184;
        Thu, 29 Oct 2020 09:21:12 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f203sm2658603ioa.23.2020.10.29.09.21.11
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 09:21:11 -0700 (PDT)
To:     linux-s390@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] s390: add support for TIF_NOTIFY_SIGNAL
Message-ID: <251a204d-9362-82b7-e5d9-14c55feb2df2@kernel.dk>
Date:   Thu, 29 Oct 2020 10:21:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Wire up TIF_NOTIFY_SIGNAL handling for s390.

Cc: linux-s390@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---

5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
for details:

https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/

As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
as that will enable a set of cleanups once all of them support it. I'm
happy carrying this patch if need be, or it can be funelled through the
arch tree. Let me know.

 arch/s390/include/asm/thread_info.h | 2 ++
 arch/s390/kernel/entry.S            | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index 13a04fcf7762..0045341ade48 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -65,6 +65,7 @@ void arch_setup_new_exec(void);
 #define TIF_GUARDED_STORAGE	4	/* load guarded storage control block */
 #define TIF_PATCH_PENDING	5	/* pending live patching update */
 #define TIF_PGSTE		6	/* New mm's will use 4K page tables */
+#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
 #define TIF_ISOLATE_BP		8	/* Run process with isolated BP */
 #define TIF_ISOLATE_BP_GUEST	9	/* Run KVM guests with isolated BP */
 
@@ -82,6 +83,7 @@ void arch_setup_new_exec(void);
 #define TIF_SYSCALL_TRACEPOINT	27	/* syscall tracepoint instrumentation */
 
 #define _TIF_NOTIFY_RESUME	BIT(TIF_NOTIFY_RESUME)
+#define _TIF_NOTIFY_SIGNAL	BIT(TIF_NOTIFY_SIGNAL)
 #define _TIF_SIGPENDING		BIT(TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	BIT(TIF_NEED_RESCHED)
 #define _TIF_UPROBE		BIT(TIF_UPROBE)
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 86235919c2d1..a30d891e8045 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -52,7 +52,8 @@ STACK_SIZE  = 1 << STACK_SHIFT
 STACK_INIT = STACK_SIZE - STACK_FRAME_OVERHEAD - __PT_SIZE
 
 _TIF_WORK	= (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED | \
-		   _TIF_UPROBE | _TIF_GUARDED_STORAGE | _TIF_PATCH_PENDING)
+		   _TIF_UPROBE | _TIF_GUARDED_STORAGE | _TIF_PATCH_PENDING | \
+		   _TIF_NOTIFY_SIGNAL)
 _TIF_TRACE	= (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_SECCOMP | \
 		   _TIF_SYSCALL_TRACEPOINT)
 _CIF_WORK	= (_CIF_ASCE_PRIMARY | _CIF_ASCE_SECONDARY | _CIF_FPU)
@@ -463,6 +464,8 @@ ENTRY(system_call)
 #endif
 	TSTMSK	__PT_FLAGS(%r11),_PIF_SYSCALL_RESTART
 	jo	.Lsysc_syscall_restart
+	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_SIGNAL
+	jo	.Lsysc_sigpending
 	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
 	jo	.Lsysc_sigpending
 	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
@@ -857,6 +860,8 @@ ENTRY(io_int_handler)
 #endif
 	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
 	jo	.Lio_sigpending
+	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_SIGNAL
+	jo	.Lio_sigpending
 	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
 	jo	.Lio_notify_resume
 	TSTMSK	__TI_flags(%r12),_TIF_GUARDED_STORAGE
-- 
2.29.0

-- 
Jens Axboe

