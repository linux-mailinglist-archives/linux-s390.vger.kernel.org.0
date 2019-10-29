Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10456E91C9
	for <lists+linux-s390@lfdr.de>; Tue, 29 Oct 2019 22:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfJ2VUh (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 29 Oct 2019 17:20:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46401 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729867AbfJ2VUh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 29 Oct 2019 17:20:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id f19so10493156pgn.13
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 14:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BONbSwO3yUZE8RnSGxOUsa1O5SfUej1bEo+UUtcRz+8=;
        b=Oul5joLmyxQTlWFJ6A+hcl/iw8HGyCj6DCkGeyjgSJdywZcIXcCkpDkg/j5crt4EDF
         bhYDAsbHELzhL0Rn6NEATnn7EYUCy83UJjn7yKHmtUT0TnhtwYnlsa6tIjmvmGJHa6km
         Wea7MJXRJYBJmpaXEbKQvVL7Q/hNvQrtuzUmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BONbSwO3yUZE8RnSGxOUsa1O5SfUej1bEo+UUtcRz+8=;
        b=h95m0B0Dp5vcp5Nb6qOgie9K+8JdVuAr9lasHKxSOhpjr7Gh+z2kFVtx7jh3lXmGx/
         F+DwAKPS0HmY0YQaHJGX3Ph2TpBWac4w7uPdMuPzNBV9+21SHZY24ckFkMH9AAmCiyw6
         JjZJBRKXihgmrOAoaKdlRh0mMt22Kz6rR94smpMzzZwDD3zdx5P3iHw6Ban2ulu4fEpc
         23zzG+X1dizGAy/9HGmOE/x4b/Mq6jPbEW+364XznRZHC7iZ7j74zMj66qNL8025T3lh
         g7GumNOhGmmWJPwvRYjLnI/ho6c6bAW7avmD/T7TudSTJyWsPXQ3oh9keRkXVQ/ZOWJb
         RMtA==
X-Gm-Message-State: APjAAAUA285SJn9W6zbPKquryPqO6sa5oCiDLfL9XlArbFVtf87z8SGs
        dztOR6LcZI26puNuQj3KZYGRVg==
X-Google-Smtp-Source: APXvYqz1twxon/z5BlGEFoacQMYfl65IbbG8RzpA+ar3THOn4qavQ6gQvOM8c2UD/C5N90cAfco2AQ==
X-Received: by 2002:a17:90a:858a:: with SMTP id m10mr9848748pjn.128.1572384036327;
        Tue, 29 Oct 2019 14:20:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a5sm34040pfk.172.2019.10.29.14.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:20:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH v3 21/29] ia64: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Tue, 29 Oct 2019 14:13:43 -0700
Message-Id: <20191029211351.13243-22-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029211351.13243-1-keescook@chromium.org>
References: <20191029211351.13243-1-keescook@chromium.org>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Since the EXCEPTION_TABLE is read-only, collapse it into RO_DATA.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/ia64/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/vmlinux.lds.S b/arch/ia64/kernel/vmlinux.lds.S
index 11d5115bc44d..1ec6b703c5b4 100644
--- a/arch/ia64/kernel/vmlinux.lds.S
+++ b/arch/ia64/kernel/vmlinux.lds.S
@@ -6,6 +6,7 @@
 #include <asm/thread_info.h>
 
 #define EMITS_PT_NOTE
+#define RO_EXCEPTION_TABLE_ALIGN	16
 
 #include <asm-generic/vmlinux.lds.h>
 
@@ -70,7 +71,6 @@ SECTIONS {
 	/*
 	 * Read-only data
 	 */
-	EXCEPTION_TABLE(16)
 
 	/* MCA table */
 	. = ALIGN(16);
-- 
2.17.1

