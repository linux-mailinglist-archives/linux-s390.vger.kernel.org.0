Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 323C0F0C85
	for <lists+linux-s390@lfdr.de>; Wed,  6 Nov 2019 04:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388039AbfKFDH5 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 5 Nov 2019 22:07:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42502 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387725AbfKFDH4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Nov 2019 22:07:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id s5so9473246pfh.9
        for <linux-s390@vger.kernel.org>; Tue, 05 Nov 2019 19:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ltvHqBOKpiD2l5ND4e2zUJLZaNbuv0rVXPgSgZl66Aw=;
        b=Hd8PtdO4WQgjJ2rZRc4lcPgXWh5Jl+NOyxQUhpCFlJ/5w+XtRMZuPAOhNgsYMeOAUQ
         KJAgOP4ckJdkVZkm83U7EVX5LWc+H/LXqs9wmjMwCAEnZbNu4kHvao4lMC6iNpj5hbzG
         F5kc5v5Nm4ct7kNDcK5fbff3sx1DouD/iQ8J9Y/mJl34ESyofu7gVM6Ro1ROaVFijim7
         olOnKD9ptcmp9Nh68d0gSGbzBiahE+C9UqxngJqIoCsFb8Ea5QPFGaL9VI5d5IyyURym
         I5UvsjyXbUSooDh0PtSLxRiSqKe6KpldH623QhAN+rMonDk3siwjmXxTC36dahgARnTV
         YbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltvHqBOKpiD2l5ND4e2zUJLZaNbuv0rVXPgSgZl66Aw=;
        b=PbMS4gXf2FxRK5EcHe1ZOJQkKrnZIelFZpGTmUgwrlUcRkyq1OBEwEZUN3o6fx8TSA
         OgPBkt5kNHocDNbdyZ3TRCzpidYdA3sN4NJNUhKBnivRwjE8Yvac+xfsIqUYLBUsWYy5
         FXUC37/4KMIEL4calV3MrEqb0IDnZDEKGaxyL2X662VATjb6r+Q+fommEyGz7/oW5yIy
         7pT9016dLNmEKqwWIyVIxAHuU824g/t+NcDGRtqHPuGqYrLXfiX3lWw2y0G1XjnaavmG
         zfnl5VzuQ++xIAufmPMKzMhws+mDu1OvE0TjW7CVTf+OxoIG6TSfAn/OGZuyU+5pGSc5
         lDjw==
X-Gm-Message-State: APjAAAX4LyvXGgtdanrsb1342c9OOOOy9agWwuwb0qk4+gYoHaANZcYV
        C7c5DDHOAt7Mi4N3BecKFpOT8uu74Ww=
X-Google-Smtp-Source: APXvYqxoh7SswIGfcGLUzP2eWTaPnr/Qq6dF9alaThcEfJbeFh98Jk6bm8sZB2XHEVJZ02GQMNrwLw==
X-Received: by 2002:a17:90a:bf16:: with SMTP id c22mr570965pjs.83.1573009676053;
        Tue, 05 Nov 2019 19:07:56 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:07:55 -0800 (PST)
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
Subject: [PATCH 28/50] s390: Add show_stack_loglvl()
Date:   Wed,  6 Nov 2019 03:05:19 +0000
Message-Id: <20191106030542.868541-29-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
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
index 34bdc60c0b11..1a89f0968742 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -123,20 +123,26 @@ int get_stack_info(unsigned long sp, struct task_struct *task,
 	return -EINVAL;
 }
 
-void show_stack(struct task_struct *task, unsigned long *stack)
+void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+		       const char *loglvl)
 {
 	struct unwind_state state;
 
-	printk("Call Trace:\n");
+	printk("%sCall Trace:\n", loglvl);
 	if (!task)
 		task = current;
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
2.23.0

