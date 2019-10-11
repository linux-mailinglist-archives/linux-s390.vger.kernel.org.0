Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8FB1D358F
	for <lists+linux-s390@lfdr.de>; Fri, 11 Oct 2019 02:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfJKANf (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 10 Oct 2019 20:13:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36884 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbfJKAM4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Oct 2019 20:12:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id u20so3595604plq.4
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 17:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bvYKnL/TaFkIaenIAvKRMlAb1gjfrMgYQ33pk+cyLNw=;
        b=VJjnLJGIO0uGgKBCPhgyxZ/iGefUMJczEPz55L/NXxQm4X5HtH7Z6IwSEISlxXbPIi
         0AKWMzRKkEkFoTXpqSQ6so/StMfOF2yJFPqmtCJOuv0Jt6L5qcDOFqlnVgUtBy87cn2m
         oVq9vePrz89q5V3+gDCK4GhXWqgAgeYpXsYQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bvYKnL/TaFkIaenIAvKRMlAb1gjfrMgYQ33pk+cyLNw=;
        b=Z60VwPRV6xULbXuXMXUJka7dhfe9h8GHDyC96ZN/bLDp0KsTwxL7lbcsD1+6fGrxGv
         ZwaZP6UKBA8c58WD68kA0TmfuJLV0BNtF+Li0LNIj1Kdsg5pY+mBroRzo4KtMpNSWtDX
         E6UF/v9AN07QqGh+qdUkXmmGR7ByQffmDUcC90TWCsHdFoquTAWrf98Ad4QAfDH6PM/t
         WX71BskfQM6x1lc7e2dxJFc00mJ3GpTicYTks0Y65C1/xJiycbKDIlUjFxqOnnfGhT3r
         AqRZPtr13A2mpFWHvGatSNZF4mddIDNj7gUJ1hH5alkKqng6ijBTKILlARQ+KPdU6Gzx
         d+Fw==
X-Gm-Message-State: APjAAAWRBphcNdS6/RghXq1hduwEk1JSUJpj/ED3v7D9kZr0pmOVNqTW
        E3dAGmaIgI5JTpM4yvLLzg3kJw==
X-Google-Smtp-Source: APXvYqz1nJHbdicuisYaMkUGL4dW9cHVrS4hPr3bZVo4nTa2ffJhe6O1BBJ7QgwtCPb4vvcDzPVB3A==
X-Received: by 2002:a17:902:b410:: with SMTP id x16mr12316640plr.46.1570752775741;
        Thu, 10 Oct 2019 17:12:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j128sm7319082pfg.51.2019.10.10.17.12.52
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
Subject: [PATCH v2 22/29] microblaze: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Thu, 10 Oct 2019 17:06:02 -0700
Message-Id: <20191011000609.29728-23-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011000609.29728-1-keescook@chromium.org>
References: <20191011000609.29728-1-keescook@chromium.org>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Since the EXCEPTION_TABLE is read-only, collapse it into RO_DATA.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/microblaze/kernel/vmlinux.lds.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index b8efb08204a1..760cac41cbfe 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -11,6 +11,8 @@
 OUTPUT_ARCH(microblaze)
 ENTRY(microblaze_start)
 
+#define RO_EXCEPTION_TABLE_ALIGN	16
+
 #include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
@@ -52,7 +54,6 @@ SECTIONS {
 
 	. = ALIGN(16);
 	RO_DATA(4096)
-	EXCEPTION_TABLE(16)
 
 	/*
 	 * sdata2 section can go anywhere, but must be word aligned
-- 
2.17.1

