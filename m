Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13D4BBF881
	for <lists+linux-s390@lfdr.de>; Thu, 26 Sep 2019 19:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfIZR5s (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 26 Sep 2019 13:57:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33218 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbfIZR4Y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 26 Sep 2019 13:56:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id i30so1989031pgl.0
        for <linux-s390@vger.kernel.org>; Thu, 26 Sep 2019 10:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BEIxyBF1HkRa8rBbPvqIJ09n3nmPR/y1tjhfe0NMzTo=;
        b=bQqqzNyNY7DBO4nvgPSIP04+h5CJyVsKfEvjzJfmS/V4+ODZb0mTUfyJbfgKxlH+Zf
         EcxsjmRdikQWm28aLyIpEcu2zYGeo3BNR4PnBQVxsPQueeDIHFJzMBwlKseyYdE8oNqC
         7R3DrfnnX5WNs3WMSqS/eB2/JT0kHs051Pfd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BEIxyBF1HkRa8rBbPvqIJ09n3nmPR/y1tjhfe0NMzTo=;
        b=sjUSU61cvgMVxNMl3aoJp4Ay0lkvUBEmH9zY4gEGNmZdWVaCGPjRln9PJnnO0tSQdd
         rBuCX5QRB35KGo+69eh1qzHwyejtQvVpuC4dDIbbkco/y50Hm66Qtz/AL5HwcWTQkQxq
         Dnt2bYkfEvSLdUKEywBvftYTXK6ATob7C9qTf0xGNfeRhrsIzwoAHpcDx0k65DBsZDJO
         otNsAW27pEUq1DG4pX9Jjlc5XNDs/Lkh/gT7UywRx3l7IriuKXvqqzjPiZ3PdKbMZDT+
         zbswyzBn2/xA8paYW7KYx5mCoS86S9mh+KqcPB5U8P5PT0MKTLts8vtro94VkRCO2mSU
         mGvQ==
X-Gm-Message-State: APjAAAXq0noVB6MU1RAzxfHbPCD2uRalyMn5ODPDsBIahf1plyh/a836
        93Zlk4eHE017bxT0o/oAfNHXbA==
X-Google-Smtp-Source: APXvYqyF69hVmYXL8iit7KpAdlylDNRysPjFRUoiDKvaG1bVd3Zxp6WjhsfeNoA0ipdH698250+hQw==
X-Received: by 2002:a62:c102:: with SMTP id i2mr5308106pfg.7.1569520584303;
        Thu, 26 Sep 2019 10:56:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h6sm3791790pfg.123.2019.09.26.10.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:56:21 -0700 (PDT)
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
Subject: [PATCH 07/29] x86: Restore "text" Program Header with dummy section
Date:   Thu, 26 Sep 2019 10:55:40 -0700
Message-Id: <20190926175602.33098-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926175602.33098-1-keescook@chromium.org>
References: <20190926175602.33098-1-keescook@chromium.org>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Instead of depending on markings in the section following NOTES to
restore the associated Program Header, use a dummy section, as done
in other architectures. This is preparation for moving NOTES into the
RO_DATA macro.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index e2feacf921a0..788e78978030 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -147,8 +147,9 @@ SECTIONS
 	} :text = 0x9090
 
 	NOTES :text :note
+	.dummy : { *(.dummy) } :text
 
-	EXCEPTION_TABLE(16) :text = 0x9090
+	EXCEPTION_TABLE(16)
 
 	/* .text should occupy whole number of pages */
 	. = ALIGN(PAGE_SIZE);
-- 
2.17.1

