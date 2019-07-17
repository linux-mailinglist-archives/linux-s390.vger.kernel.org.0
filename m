Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9C16B348
	for <lists+linux-s390@lfdr.de>; Wed, 17 Jul 2019 03:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfGQB3U (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 16 Jul 2019 21:29:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33295 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfGQB3T (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 16 Jul 2019 21:29:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id f20so1069319pgj.0
        for <linux-s390@vger.kernel.org>; Tue, 16 Jul 2019 18:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=Zt2cGhW98jjWE3OdliFocFdkTeCj4B287sEGZ0SpTug=;
        b=LRzFJFoIhdEmL95807L32ZJIuoUYPRnejcM4WZZAS5I0UeznU/mAzk5GHoafmOmsHO
         IM1q2PeVsvlEPnevADzvUbNh7W588och2Rq5fZ7FuM8MS5EZgdQu/E3L+BqIYSfN2XU/
         fS7NBtFCaQBxI26WtshKHqrbJwSXRxg0DRH2E+7ihFfC5kinDvs9QAQl4LeKl3WMrLal
         EZk+GjuTQmWvWRkiN6fD0Uh9EK++IoK7hPKkpfs3WJ+9PYY0m//oOKVgI1hVB+8KwfWp
         /ROJj7wU7v2lVN33h5c47bRwWtpAubgsifHDAD3lPqVXVzkWPuUCHQEfzucJpkMLwZmo
         z7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=Zt2cGhW98jjWE3OdliFocFdkTeCj4B287sEGZ0SpTug=;
        b=FZhp0gF8Koht8Y0X1HI6m3ahyLi9LrQaKRiVQfaNUQb97vbqnYt95mHq4hodFE6Smh
         MeeiSL9BE0bhgy5qfUOVgd21TwbFEsfwLngr0ow7cLvWfi3w7MVWCVgTkgnsD4kiSqT+
         irty/kS4Zc8/Aox30uCKbdt/ds2REA9pIr8Sp6JOzcM/K5RbZIjA4OCRNHp1bLhw4hDW
         n96C91DRQeaH5SP8OgvjbZLhCC3Yj/SLpB0j++qmNqz9LUDnt2l2RAL/gI/yQ07mwJQc
         ZSyGOe+UsrrmS1/8byEPajTZAfFKXEJp8cDUNSd88IC7lSRAs029U81yX1CTuOPn6tll
         FLQA==
X-Gm-Message-State: APjAAAVxF3MMGKeeZFZ/2HrRsfZ6sf2cx+LrFZaPzEMaN7M4Pgu1h6y2
        bsQJCWvSIpb1t6Y5nv8axKb51w==
X-Google-Smtp-Source: APXvYqxMG1qk1WTJLj8KetMfpnmMGNIO6J68LTkGZfygoiTvSJog6FgoAv0IrheBQXCx4vxGr6+m3Q==
X-Received: by 2002:a63:e5a:: with SMTP id 26mr36209824pgo.3.1563326958663;
        Tue, 16 Jul 2019 18:29:18 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id i3sm23567398pfo.138.2019.07.16.18.29.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 18:29:17 -0700 (PDT)
Subject: [PATCH v2 4/4] tools: Add fchmodat4
Date:   Tue, 16 Jul 2019 18:27:19 -0700
Message-Id: <20190717012719.5524-5-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190717012719.5524-1-palmer@sifive.com>
References: <20190717012719.5524-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org,
        monstr@monstr.eu, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        peterz@infradead.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        dhowells@redhat.com, firoz.khan@linaro.org, stefan@agner.ch,
        schwidefsky@de.ibm.com, axboe@kernel.dk, christian@brauner.io,
        hare@suse.com, deepa.kernel@gmail.com, tycho@tycho.ws,
        kim.phillips@arm.com, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

I'm not sure why it's necessary to add this explicitly to tools/ as well
as arch/, but there were a few instances of fspick in here so I blindly
added fchmodat4 in the same fashion.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 tools/include/uapi/asm-generic/unistd.h           | 4 +++-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index a87904daf103..36232ea94956 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -844,9 +844,11 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
+#define __NR_fchmodat4 434
+__SYSCALL(__NR_fchmodat4, sys_fchmodat4)
 
 #undef __NR_syscalls
-#define __NR_syscalls 434
+#define __NR_syscalls 435
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index b4e6f9e6204a..b92d5b195e66 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,7 @@
 431	common	fsconfig		__x64_sys_fsconfig
 432	common	fsmount			__x64_sys_fsmount
 433	common	fspick			__x64_sys_fspick
+434	common	fchmodat4		__x64_sys_fchmodat4
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
-- 
2.21.0

