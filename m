Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0FBBBF80F
	for <lists+linux-s390@lfdr.de>; Thu, 26 Sep 2019 19:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfIZR43 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 26 Sep 2019 13:56:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40656 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbfIZR43 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 26 Sep 2019 13:56:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so2252464pfb.7
        for <linux-s390@vger.kernel.org>; Thu, 26 Sep 2019 10:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=boKac6TElydY4R3sQa+G+xBcabSsdI+sqtUCLKc0I3Y=;
        b=XMqGnRk/4L2zV+BAcfMhEdp30WQ7rnrwPghldhN5wojxU6yECwV0QZoiKh6iMFz9u/
         3s0+7zK9FZyUnOl5vKrLaXkQbtdXFR/JEp6wPtBe2BjahHGB5QibvDfI2zsDQKGVGwxT
         0FaowxFjLAW78Z95w7zWRvBJowS42QkoAtE9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=boKac6TElydY4R3sQa+G+xBcabSsdI+sqtUCLKc0I3Y=;
        b=aIumsuEciDFXel4u0kKmeA5ZKzyfRmrCARLNF5SsXCbIKwulTfE/aw1AL06aKuU1k/
         dXYHUdoKVMzDmF1577Opz7hnH73uV95IpPKomhZFxAdb7nGqrPnSETzLQwTiEkd6I3qE
         sawzX/Zdyp5dINZOl2IE/cI/i/DBqDmxO+cr7fRWWrSxjF/JuS45T1hlQgNj+/i1X+mk
         DpSsAI/UyEOZgjbnC5a9GYSPsyKMiKAkbD8S9id5DRh7oNyOs8QvNVebbttTh4NnpaL8
         OEFRtpOEkbLSoFzT0xitOd4E6OHlWFh1N0YQfXG5UZT7SJaIRBXl+Pxqju0O0hBRSwm6
         4NZg==
X-Gm-Message-State: APjAAAXjAIPkDpzDM2PnDk5k2bmlbtCwvF6hJW4W1hzarKkha7QwGAr/
        blAKyKni5MWLklXKhbijlpe07A==
X-Google-Smtp-Source: APXvYqw3JiUTFBC2pu3wWAh2sSRbsTCox9kS4uccJrMuCcRqw869/J5FYUi7LMMoz7vy/oYtsvV+iA==
X-Received: by 2002:a62:6489:: with SMTP id y131mr5133495pfb.71.1569520588899;
        Thu, 26 Sep 2019 10:56:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m136sm7333082pga.94.2019.09.26.10.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:56:26 -0700 (PDT)
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
Subject: [PATCH 19/29] c6x: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Thu, 26 Sep 2019 10:55:52 -0700
Message-Id: <20190926175602.33098-20-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926175602.33098-1-keescook@chromium.org>
References: <20190926175602.33098-1-keescook@chromium.org>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The EXCEPTION_TABLE is read-only, so collapse it into RO_DATA.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/c6x/kernel/vmlinux.lds.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/c6x/kernel/vmlinux.lds.S b/arch/c6x/kernel/vmlinux.lds.S
index a3547f9d415b..9a09aab63ab3 100644
--- a/arch/c6x/kernel/vmlinux.lds.S
+++ b/arch/c6x/kernel/vmlinux.lds.S
@@ -5,6 +5,9 @@
  *  Copyright (C) 2010, 2011 Texas Instruments Incorporated
  *  Mark Salter <msalter@redhat.com>
  */
+
+#define RO_DATA_EXCEPTION_TABLE_ALIGN	16
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
@@ -80,8 +83,6 @@ SECTIONS
 		*(.gnu.warning)
 	}
 
-	EXCEPTION_TABLE(16)
-
 	RO_DATA(PAGE_SIZE)
 	.const :
 	{
-- 
2.17.1

