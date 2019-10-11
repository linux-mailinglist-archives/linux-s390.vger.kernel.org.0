Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81E16D34FB
	for <lists+linux-s390@lfdr.de>; Fri, 11 Oct 2019 02:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfJKAG7 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 10 Oct 2019 20:06:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41959 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbfJKAGf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Oct 2019 20:06:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id t3so4686099pga.8
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 17:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aFfN5juCtHu18am/Lscu0/nkwdENrYqqL+l/G+SE/2I=;
        b=fLT/IFk/zcWpEKQQpsCuZreeSESJFRNdZ9hKHV0Y/h8n0IfaNLHOqmTYtdPHeZxkjc
         xWb/DQdE2uR1oDMr4EtvYElJra/mVKFp1aLbbQ6bJ3wnEDggQhIotPy3fghpdD1vLtdp
         EDoZ6HuknzX/OdZ89Gdo2kWzGjDi4EqKGpRbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aFfN5juCtHu18am/Lscu0/nkwdENrYqqL+l/G+SE/2I=;
        b=kUAprGnDBmMchAv1LcEFiOtOdzueossHEYzNjM0Oi+Oi4a4jvcFAIujPfZETixUumu
         5qOKa5hyzuhZ8P1649sPPlhm7mRbh+vZ3gnwjm0zcdHOKm2RTn2i5YvM/7hkm/BMLdMO
         Y+cUldUexm/Q9tnJm1si3m/8l4f/26DSMNL0bBLZYU7+yxAg4tRixecrbODCP3YiBhEp
         pwlFmG1vLtSylM2eiTemUAf9ve4ILsU6dV9B7rUl5gyoOSBkjqVjslrlMlGacxbPvUIu
         7M0LNrE0nCNVc3/LGDMMkGIveTWamFtFWSmLAUs4r3+nUzRE8QONwSbKFDQXUxarUCAo
         2VnQ==
X-Gm-Message-State: APjAAAW4y7t6ctrg3ObZpIn9U+0NY5U+tbYcIDDMGREjNndP+FWJE/OA
        Ex/Cjk6dgGju93ODKsmUCtksbA==
X-Google-Smtp-Source: APXvYqxt91xs+DlKHANMAIgcph9JiYJXmwrfwOJOztv5tZwNFPibvGy6e5lUsAYLGSGL3bBhVSlFEA==
X-Received: by 2002:a63:906:: with SMTP id 6mr13901748pgj.324.1570752394983;
        Thu, 10 Oct 2019 17:06:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f14sm10473924pfq.187.2019.10.10.17.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:06:32 -0700 (PDT)
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
Subject: [PATCH v2 16/29] x86: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Thu, 10 Oct 2019 17:05:56 -0700
Message-Id: <20191011000609.29728-17-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011000609.29728-1-keescook@chromium.org>
References: <20191011000609.29728-1-keescook@chromium.org>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The exception table was needlessly marked executable. In preparation
for execute-only memory, move the table into the RO_DATA segment via
the new macro that can be used by any architectures that want to make
a similar consolidation.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index a1a758e25b2b..b06d6e1188de 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -22,6 +22,7 @@
 #endif
 
 #define EMITS_PT_NOTE
+#define RO_EXCEPTION_TABLE_ALIGN	16
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/asm-offsets.h>
@@ -145,8 +146,6 @@ SECTIONS
 #endif
 	} :text = 0x9090
 
-	EXCEPTION_TABLE(16)
-
 	/* End of text section, which should occupy whole number of pages */
 	_etext = .;
 	. = ALIGN(PAGE_SIZE);
-- 
2.17.1

