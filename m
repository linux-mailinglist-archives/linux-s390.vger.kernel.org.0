Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F646186D75
	for <lists+linux-s390@lfdr.de>; Mon, 16 Mar 2020 15:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbgCPOlt (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 16 Mar 2020 10:41:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35362 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731534AbgCPOlt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 16 Mar 2020 10:41:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id 7so9885297pgr.2
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2020 07:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eirw1+CPEwOm9XDny2XZP8XgLLmqTIbu051zNlJl2YI=;
        b=BcUu/qEEKClkKnpXgI3q3V6khj8IpC2a07GWHZIS/cr6Fb4nNDLbhXbdOCHRroK6L4
         ro0wccURxr4wDaYw64s/ljpNl9dLHr13jsdHV0PenUisf6MFApAooUzSDzk3FScrWx9w
         5oyNFyPrxI4bHYDB9aiLGSRTMV+C567KMX5ZUWurCcceMY9ukOeszTlbNv3bqbZoHDkO
         e8R6LNu97lmLaJS7qWq7BRJET51MFPKGp205IP40HYNWxNtM1Kgdz5gNdvvQb96b4LDZ
         YnuLBV+ZR4loerJ5CsjUhI5DyQsqML8V95JuVNawxivCDa1bi1gUBQAhRzPTMcwBP5i3
         qE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eirw1+CPEwOm9XDny2XZP8XgLLmqTIbu051zNlJl2YI=;
        b=uBDfXDiteujMxtr8/NUkkV0QEBIv5QdSouC5pAV1gM6zVswze1BvDPE4k5dS+1lwue
         plPVRikk7eCORK1J63sqac/Tjc4vQ5OUIILn0YwdBRoJMwwHgW7Utiotfqr6Wu/MbSmR
         IfahfFdAYSOTRH1eiHG9U7hvsM8cb6+RVqyQbgrkWFlxLFz0OOs+J6TugH4HltJ5093/
         cKYaqmOoSZjMJm+7c/eB+wZzt6cMiDhk238mnLDcKKeI6CDEhiYinQyTWousBJBJ7GYX
         V+AhsRMNQ4fh2Af8XrjJuhrBzBt2w8051GDbgndb7c+PfIoBVDcpCXRVX7sx76ho28Bq
         xoyA==
X-Gm-Message-State: ANhLgQ3JLfGDg4DKWYpWqoyqPa2xwoLWLbrYg+0DQoPAhV4YtzaLZ4yR
        8QCQGotkNwZOvBURLGX04QtFGg==
X-Google-Smtp-Source: ADFU+vtmKxkjoaf5j4+z2trd3YLJQDV0qB59iuP8qelC8HGL/enlXyLmnej0EP3ur2rgqjBHdpEtcw==
X-Received: by 2002:a65:5a8a:: with SMTP id c10mr160621pgt.315.1584369708294;
        Mon, 16 Mar 2020 07:41:48 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:41:47 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCHv2 28/50] s390: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:38:54 +0000
Message-Id: <20200316143916.195608-29-dima@arista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316143916.195608-1-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Currently, the log-level of show_stack() depends on a platform
realization. It creates situations where the headers are printed with
lower log level or higher than the stacktrace (depending on
a platform or user).

Furthermore, it forces the logic decision from user to an architecture
side. In result, some users as sysrq/kdb/etc are doing tricks with
temporary rising console_loglevel while printing their messages.
And in result it not only may print unwanted messages from other CPUs,
but also omit printing at all in the unlucky case where the printk()
was deferred.

Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
an easier approach than introducing more printk buffers.
Also, it will consolidate printings with headers.

Introduce show_stack_loglvl(), that eventually will substitute
show_stack().

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/s390/kernel/dumpstack.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index 2c122d8bab93..887a054919fc 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -126,18 +126,24 @@ int get_stack_info(unsigned long sp, struct task_struct *task,
 	return -EINVAL;
 }
 
-void show_stack(struct task_struct *task, unsigned long *stack)
+void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+		       const char *loglvl)
 {
 	struct unwind_state state;
 
-	printk("Call Trace:\n");
+	printk("%sCall Trace:\n", loglvl);
 	unwind_for_each_frame(&state, task, NULL, (unsigned long) stack)
-		printk(state.reliable ? " [<%016lx>] %pSR \n" :
-					"([<%016lx>] %pSR)\n",
-		       state.ip, (void *) state.ip);
+		printk(state.reliable ? "%s [<%016lx>] %pSR \n" :
+					"%s([<%016lx>] %pSR)\n",
+		       loglvl, state.ip, (void *) state.ip);
 	debug_show_held_locks(task ? : current);
 }
 
+void show_stack(struct task_struct *task, unsigned long *stack)
+{
+	show_stack_loglvl(task, stack, KERN_DEFAULT);
+}
+
 static void show_last_breaking_event(struct pt_regs *regs)
 {
 	printk("Last Breaking-Event-Address:\n");
-- 
2.25.1

