Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C88BBF8BB
	for <lists+linux-s390@lfdr.de>; Thu, 26 Sep 2019 20:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbfIZSFh (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 26 Sep 2019 14:05:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39872 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbfIZSFZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 26 Sep 2019 14:05:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id o10so1969848pgs.6
        for <linux-s390@vger.kernel.org>; Thu, 26 Sep 2019 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UZe87vLT1sniPvXW68EajTgvCPzHcGOx1KtJdkMO+C4=;
        b=ftNNGKytJacyrySBqQdQBy+Wtbqo4hjOH8JbjKAUhiSKwHnh85Hu/NyJx15BBuO1wF
         yvNx/PBqQnIZ6l+s3uDBiFHBJFB+mgrq10000RAmGyv/9dd3TBhxlAe1FDs1ODYyqFBp
         20hAVjREm+IqibqFYhMmuhOtQ05fbch5Col5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UZe87vLT1sniPvXW68EajTgvCPzHcGOx1KtJdkMO+C4=;
        b=buxSTA5waceAb0CCTNe1QmcJzkf3yfL4sg++8aG05+/9TBd033f2NC4xPLsFO/Jz0E
         00VoWndgwfUp19pxIij8aWFwXW7qIenhBafSuzZQh9NZR+DhGqAxKijWO/swncCE13DF
         4D48UyRSAPkDhpwy8tockHg/Gb+VG7aFmy52s1R+J89WRlV1c20dLSXTLqdLmLD+S00E
         neUNFu3fo0DEog9e2HjwNTDdDbvDXRCbBpJlFugeTOGuZFbNtc1lABrWKjf8w/tzuD11
         Dk+fSeJ8nRENz2A1P5POypCJt6qOxPyh2OaxyAOw0E3Fl70fWRusPZFYa6nR27GmnXFX
         c8Fw==
X-Gm-Message-State: APjAAAWIE/21BNknp0xWlQautCa7DfdywikJtekIkGytrb7I2skQord7
        rG77mjJNYAY6Zny13lNB/+IikA==
X-Google-Smtp-Source: APXvYqxQ+qIP8fVJv40/72tfoaela/T+aeXyqhEWc1AJXKMb1mslUhfwVxI+PEohiV5y6ZiRW2Bx2Q==
X-Received: by 2002:a65:5689:: with SMTP id v9mr4732387pgs.228.1569521124506;
        Thu, 26 Sep 2019 11:05:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p17sm5229278pfn.50.2019.09.26.11.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 11:05:23 -0700 (PDT)
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
Subject: [PATCH 21/29] ia64: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Thu, 26 Sep 2019 10:55:54 -0700
Message-Id: <20190926175602.33098-22-keescook@chromium.org>
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
 arch/ia64/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/vmlinux.lds.S b/arch/ia64/kernel/vmlinux.lds.S
index 0d86fc8e88d5..18a732597112 100644
--- a/arch/ia64/kernel/vmlinux.lds.S
+++ b/arch/ia64/kernel/vmlinux.lds.S
@@ -6,6 +6,7 @@
 #include <asm/thread_info.h>
 
 #define EMITS_PT_NOTE
+#define RO_DATA_EXCEPTION_TABLE_ALIGN	16
 
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

