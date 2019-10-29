Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC01E917F
	for <lists+linux-s390@lfdr.de>; Tue, 29 Oct 2019 22:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfJ2VOW (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 29 Oct 2019 17:14:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33237 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbfJ2VOT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 29 Oct 2019 17:14:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id c184so7548pfb.0
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 14:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l+J574mlC+dRmZJG9pHhpppQFEze5VvTPTaNiTnbyaQ=;
        b=XxYZzxUJLSS1EjXOu0N/W8WJ4nsXkGW0wuYPPQz4S9Q7ybSmxfOvzX4/Pbx0hRVhwL
         IrpMdG7OEhiyZc3pXm3O/EWpZWxxrVnOcBtrFviHXzAXJGTEX7UE4FQN2re4YmyUukvg
         kN8X/p4Rc2H96j4CDSRi5o2KB2cQvjaVsgVbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l+J574mlC+dRmZJG9pHhpppQFEze5VvTPTaNiTnbyaQ=;
        b=i38r4YJ0DYZNHMFtbzJqsTat+h62MSE9dwwqZLBi0MfHPl8f7rrSJconzFrZG4lIn8
         Th+PsgH+TNyMjTDUQHU3XrCSl6dfEfIDTCLxa86yC39AolJSKc5B17FAyJRyJI//ImBG
         oRdclxMlUE3UGdHOmTIbsF6Ux9v3ciH/tgpsr6v831ipS762zHALqVOulaPcmxsgtMp1
         v/QfJYQvMd8yuiHh46/e/BoPQYt7VW8ZwtyrCvRBi0rwDx9YLuDOxtLiEh/W/u/Flaoa
         0RUh0wA1iCMGdivN8tfBDc/Q1mGj+Va2kWQXBlWaqKj175xUERnWFeoLwlFw5LpXZWbD
         29rg==
X-Gm-Message-State: APjAAAWcqL5Q6aPVzFMJ57SvjXlYkz22t0J/1jxKJWdTPoj28+5eB5FG
        tYHihK/M8dR0bdZTdaTnEVGhxg==
X-Google-Smtp-Source: APXvYqwDTCHy7ekbXHpuxYWgHEZHkPXVWMIgLthR/cRPbNMgyLncTh1RVOtUSpgF7h0Elx7DzeS6cg==
X-Received: by 2002:a65:5382:: with SMTP id x2mr1341257pgq.420.1572383658639;
        Tue, 29 Oct 2019 14:14:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i11sm150632pgd.7.2019.10.29.14.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:14:12 -0700 (PDT)
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
Subject: [PATCH v3 19/29] c6x: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Tue, 29 Oct 2019 14:13:41 -0700
Message-Id: <20191029211351.13243-20-keescook@chromium.org>
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
 arch/c6x/kernel/vmlinux.lds.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/c6x/kernel/vmlinux.lds.S b/arch/c6x/kernel/vmlinux.lds.S
index a3547f9d415b..ac99ba0864bf 100644
--- a/arch/c6x/kernel/vmlinux.lds.S
+++ b/arch/c6x/kernel/vmlinux.lds.S
@@ -5,6 +5,9 @@
  *  Copyright (C) 2010, 2011 Texas Instruments Incorporated
  *  Mark Salter <msalter@redhat.com>
  */
+
+#define RO_EXCEPTION_TABLE_ALIGN	16
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

