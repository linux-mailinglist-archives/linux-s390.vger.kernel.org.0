Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F536D3591
	for <lists+linux-s390@lfdr.de>; Fri, 11 Oct 2019 02:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfJKANg (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 10 Oct 2019 20:13:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34693 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbfJKAMz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Oct 2019 20:12:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id y35so4715102pgl.1
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 17:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O8SEsfE9Vx0Hoh9SzPjKsL9yL1yAPo1QWRZUpqQZ5BE=;
        b=Gv7TLEhljmk67n05hXgtlXOGcw9tGWMBrimWEdgAzAJXSYD424xsVS93uPgKCKbOtA
         KpknhwokmtlZdLNepzxzaEOUq/9kMlkIhbFFmT4rtodx7TYV09GcbgOeE2Tx2zJJHzL4
         OqaceGT7qpam5Y2W3jNCRpS/l3/Ec0FSl0z+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O8SEsfE9Vx0Hoh9SzPjKsL9yL1yAPo1QWRZUpqQZ5BE=;
        b=rXLcEjp/kWD9hNaFKkJFSpGHdgRUGt/QjNYZGVl08XkMxTo0cW9zsQzV4TVGsbdeiy
         GTCmtj2JVxPmb05ROJaD9L8Lb4YpQNw2KtrkKOWUVxCfRe9rOeuAXGWM8Yq6xse+NRu3
         YKuJ+evYw5Fc4PitKAsnRoAt9zIcp0NcYifX2W6LVmRGTAgFK0fL4FjmY7wnSJzPy6GB
         rdZjrSZXvpw726+Cahrw6byq6As16+qCfgW+o0jvl6cJdTAwE5KMbto/J+avlUlkmen0
         Tcw+4Egw8rGL44CrqUcvL5/aMRoHZNxq4ZVsSZeE5ak1rp0E6ZLevnQzp9jlk4W0Lymn
         sQxA==
X-Gm-Message-State: APjAAAW5lHzXYcTVsIZV+8D3J4lgQ95ypkf2nYvltxT7wfh4/5BcHz3T
        T6uj7pR7meEcE97Koymfi2CMUA==
X-Google-Smtp-Source: APXvYqzyaJSRYesLvc9/cYfNuiEyqu7JRw4xKIgMuM24rG56rksdn8ZIgzTA7SEJDJgU0X32uEGKXg==
X-Received: by 2002:a63:4624:: with SMTP id t36mr11232771pga.376.1570752775059;
        Thu, 10 Oct 2019 17:12:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 2sm6371584pfo.91.2019.10.10.17.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:12:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
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
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/29] vmlinux.lds.h: Allow EXCEPTION_TABLE to live in RO_DATA
Date:   Thu, 10 Oct 2019 17:05:54 -0700
Message-Id: <20191011000609.29728-15-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011000609.29728-1-keescook@chromium.org>
References: <20191011000609.29728-1-keescook@chromium.org>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Many architectures have an EXCEPTION_TABLE that only needs to
be readable. As such, it should live in RO_DATA. Create a macro to
identify this case for the architectures that can move EXCEPTION_TABLE
into RO_DATA.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 356078e50a5c..9867d8e41eed 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -69,6 +69,17 @@
 #define NOTES_HEADERS_RESTORE
 #endif
 
+/*
+ * Some architectures have non-executable read-only exception tables.
+ * They can be added to the RO_DATA segment by specifying their desired
+ * alignment.
+ */
+#ifdef RO_EXCEPTION_TABLE_ALIGN
+#define RO_EXCEPTION_TABLE	EXCEPTION_TABLE(RO_EXCEPTION_TABLE_ALIGN)
+#else
+#define RO_EXCEPTION_TABLE
+#endif
+
 /* Align . to a 8 byte boundary equals to maximum function alignment. */
 #define ALIGN_FUNCTION()  . = ALIGN(8)
 
@@ -513,6 +524,7 @@
 		__stop___modver = .;					\
 	}								\
 									\
+	RO_EXCEPTION_TABLE						\
 	NOTES								\
 									\
 	. = ALIGN((align));						\
-- 
2.17.1

