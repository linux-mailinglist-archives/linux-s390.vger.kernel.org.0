Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FD81AF4A9
	for <lists+linux-s390@lfdr.de>; Sat, 18 Apr 2020 22:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgDRUUb (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 18 Apr 2020 16:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728551AbgDRUUa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFAAC061A0C
        for <linux-s390@vger.kernel.org>; Sat, 18 Apr 2020 13:20:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id u13so7187519wrp.3
        for <linux-s390@vger.kernel.org>; Sat, 18 Apr 2020 13:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kRb3VTo9fqqcoDwRC+xUbun5O8A7r81BCz7puwICl3U=;
        b=XRxInYXsCLMYHbKTV/E3Cf556LBnqifRTu7fOoVg+fnC+wo8bx+cCx/MD25ZMVoyaP
         75h7/7nJC4+2cehTfUN8ct6vyQySP9aRuzXPaDBDbd7HhC5dSoTUyhBtzVnT9P8MHVmu
         feMagN6JAAguvLTuITE3t6tOebcj0eZX4VttVo9qC4IWKmaIQOUceit+UyUkbd1B5cTH
         EpLxpP1P0xvSMp7khLb1Td954oetNnG0TlHQdqRKDMFL2CsPb0Wat+lpLOv26znzHgMY
         HZi13AKU74dFtg4sVEjBldWKY1lA3/GGUrVy83854a32VC1jFVd+vxFK8uLU9jMV2hM1
         UrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kRb3VTo9fqqcoDwRC+xUbun5O8A7r81BCz7puwICl3U=;
        b=FXQCQkrnt6LhX/3NoVPFRcUymnKW1yr4VWJDWU2HkpqNVe82YR7jA7mDJzqq895aj4
         ZrtLvSbYMje67GKOPv/MmN0gDHvTFs8TWYlB6h4JXzb9D23quE6zmU88+vn1x0VLtVqm
         tYBOOAkIV0w0773luo8WPoN4+LQQUpfTGLGrEJHsfrJBfE4rst0lU+bWgGb8LxkRddVO
         hE1oCndGZcGuYUtmDp5EhJLOyJNJQ1SrHNzrMtO2JqYdsF2b9X/EOHeOUYZyl7wbVwaP
         gqy464y8Uds4IsZzW1RH1ZYXO0iTQonGaVmxBNqWl+0RsbNSPiRoSy2cpJBrh6cnlHkE
         4gJw==
X-Gm-Message-State: AGi0PuaXU+V6QzFQz3RZKHuiOOSZ1UGeX3Izsxov9sJkhQb/src9NVV2
        ULFX7l6+S6vkQZj1N73t9fGfWQ==
X-Google-Smtp-Source: APiQypIBHNdaEr/YVaqDAJWyXWNiZxi8CYpb8zsUkWtfwA+UFh16npqb12pWxbpFTmfmiSj23d14bw==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr9457721wrl.308.1587241228309;
        Sat, 18 Apr 2020 13:20:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:27 -0700 (PDT)
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
Subject: [PATCHv3 28/50] s390: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:22 +0100
Message-Id: <20200418201944.482088-29-dima@arista.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200418201944.482088-1-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
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
2.26.0

