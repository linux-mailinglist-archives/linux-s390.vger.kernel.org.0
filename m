Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A807BF801
	for <lists+linux-s390@lfdr.de>; Thu, 26 Sep 2019 19:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfIZR4T (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 26 Sep 2019 13:56:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46457 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfIZR4S (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 26 Sep 2019 13:56:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id a3so1924958pgm.13
        for <linux-s390@vger.kernel.org>; Thu, 26 Sep 2019 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RJAKRXgj/kaRPgvukPvg+1dwSCdKJa1mCaEQYaeOHdg=;
        b=cgLBIK2I68VieSmLoKuVJtCF3SylTocfsX1gD0Zs19cToPMkoDiwNmt929x1jNUOgM
         aS469WaQkJpluXBWk8krsQRT5IpbWVxb+hJFQczm9Jyie4qjp5mT/a44DKLoq641n34N
         GcYWI51/QHsLK6gyjooxRPZO/pVEfarMYPph0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RJAKRXgj/kaRPgvukPvg+1dwSCdKJa1mCaEQYaeOHdg=;
        b=FRV3FEd6P5wxBfKzbUGzP+DYajzzISvseYmnFHoymLGfzE5uGI3W9TwtZ/6gGyj+YX
         aW7QuShb+LjOKzij3z6J7pugXAFisTlAyiS1T7Wtulgz7sckACdn6IfkmVwkkXPojw6K
         8tqmRTtfSuZkT2n+gRzk5FeG7BDf0AgXSnpQLlp25m8MLobYqMAL8CZxD1YWJMlEvPT6
         /PS6gGlAYlsQlzc8B/OXpKXUHtLwc9ha4edCUeFggVIhOABO8u22425UbT3QY8naKe5U
         7kzWnxnJomFVoOlQaRX6n3h+mDY2yV73kbMsWLIKIqrEDU1kr10h+NoMCBFBlu4hmE0f
         bCFw==
X-Gm-Message-State: APjAAAUXkO9pHoh+sXOBSTM9fb1k9MJJEmPTyLfr/THQRdLyvBuSfMYH
        4RktrROyf8s4Gfxi7EbC1VMbyw==
X-Google-Smtp-Source: APXvYqw9bqVEzqvhNYWWHWCOecHFyvs7kCSvbBABX1UJtGaZhRU8CZacQlRri1ZquDN9vFG1tzvxgA==
X-Received: by 2002:a62:d406:: with SMTP id a6mr5185002pfh.213.1569520577934;
        Thu, 26 Sep 2019 10:56:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c8sm3054165pfi.117.2019.09.26.10.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:56:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/29] powerpc: Remove PT_NOTE workaround
Date:   Thu, 26 Sep 2019 10:55:35 -0700
Message-Id: <20190926175602.33098-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926175602.33098-1-keescook@chromium.org>
References: <20190926175602.33098-1-keescook@chromium.org>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The kernel requires gcc 4.6 now, so this PT_NOTE workaround can be
removed in preparation for moving NOTES into RO_DATA.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/kernel/vmlinux.lds.S | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 81e672654789..a3c8492b2b19 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -20,20 +20,6 @@ ENTRY(_stext)
 PHDRS {
 	kernel PT_LOAD FLAGS(7); /* RWX */
 	note PT_NOTE FLAGS(0);
-	dummy PT_NOTE FLAGS(0);
-
-	/* binutils < 2.18 has a bug that makes it misbehave when taking an
-	   ELF file with all segments at load address 0 as input.  This
-	   happens when running "strip" on vmlinux, because of the AT() magic
-	   in this linker script.  People using GCC >= 4.2 won't run into
-	   this problem, because the "build-id" support will put some data
-	   into the "notes" segment (at a non-zero load address).
-
-	   To work around this, we force some data into both the "dummy"
-	   segment and the kernel segment, so the dummy segment will get a
-	   non-zero load address.  It's not enough to always create the
-	   "notes" segment, since if nothing gets assigned to it, its load
-	   address will be zero.  */
 }
 
 #ifdef CONFIG_PPC64
@@ -178,14 +164,8 @@ SECTIONS
 	EXCEPTION_TABLE(0)
 
 	NOTES :kernel :note
-
-	/* The dummy segment contents for the bug workaround mentioned above
-	   near PHDRS.  */
-	.dummy : AT(ADDR(.dummy) - LOAD_OFFSET) {
-		LONG(0)
-		LONG(0)
-		LONG(0)
-	} :kernel :dummy
+	/* Restore program header away from PT_NOTE. */
+	.dummy : { *(.dummy) } :kernel
 
 /*
  * Init sections discarded at runtime
-- 
2.17.1

