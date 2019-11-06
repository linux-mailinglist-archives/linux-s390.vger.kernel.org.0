Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED556F181C
	for <lists+linux-s390@lfdr.de>; Wed,  6 Nov 2019 15:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbfKFOOB (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 6 Nov 2019 09:14:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38176 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731878AbfKFONg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 09:13:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id j15so5325327wrw.5
        for <linux-s390@vger.kernel.org>; Wed, 06 Nov 2019 06:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U6fBBHvVLMFc3f5G49uqUA0oEjUKRfSKZZVGrXe7yqU=;
        b=oHHyP9AxSmf/91/+kpsv96IW5mCrfizqwOEzQn77TJGE4AA2TD2YE3WvYlno86vRrQ
         3StHv1NQbhGvXwAhJk/7vyPl7kycnXc0qSnPpxKeCGP/oUNgicAcN3rLEnV4yJ2ZPWxI
         CcnqFRzZJteQfh75tsK/Dt4GRIgBQyKsAz4bB/OplfiKxsnhAYgXcW77Qa7uOUBHdNRn
         z/EO4axjbLqUY1SiZ0WZo/MIzMQotVjg9Ny55z9wlWKbVipolH1vvOmbccbra6On6B2W
         pnOOwOtcRR3Af+/5TPl6TnpoBlTy+VoxpdgYTBzZzIpphqhdQS2iv3RM/Blyw8vyoFAM
         FBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U6fBBHvVLMFc3f5G49uqUA0oEjUKRfSKZZVGrXe7yqU=;
        b=oUYj4Cuk2j1930xHYb212RGqKoURLMJ2fhEAIWjjpGwGN7YSgJi2P+TyttEB9XqkuV
         a2cKlNHs0jfok3+mpKhwQw44YKbm3q6IwJRXJCNU6KbddqIQ5uApG6KUoUyPWlfafVGr
         FMLZS8paejECNCsJRFOJrGkGC482jekdOgI7HSj3WpPkNqTSqVhdTFUMKOGEn/+P6Hs9
         Y5RVP1na08gbqle9IkDhrrwJi5FxYwQ1kie+FBKn3mNQtOXE8uyNSCNR/Y7XnlSH18h5
         8JSfOZVSfd1tBY0DGhyyw25mz5mrhtiWifUFjkKjLa83lTivmuD9B9HhwjVoSFgv+eXe
         ahOQ==
X-Gm-Message-State: APjAAAWvMkWkba5nUJEKXiRt+Gla66FD4ozZFCsjw9gF8zdBw3+Evcyy
        U266OT3dppyt4LQtd9Y3drzW18WRR7mJWg==
X-Google-Smtp-Source: APXvYqwTW8Co1NkDLMiDoMz76SFxqWV6RP7eDEW8xmbcxt45PK42CapSIJfdZxsGpwR+XbY41YQJxg==
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr2719969wrr.257.1573049614286;
        Wed, 06 Nov 2019 06:13:34 -0800 (PST)
Received: from localhost.localdomain (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
        by smtp.gmail.com with ESMTPSA id b3sm2837556wma.13.2019.11.06.06.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 06:13:33 -0800 (PST)
From:   Richard Henderson <richard.henderson@linaro.org>
X-Google-Original-From: Richard Henderson <rth@twiddle.net>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 07/10] x86: Mark archrandom.h functions __must_check
Date:   Wed,  6 Nov 2019 15:13:05 +0100
Message-Id: <20191106141308.30535-8-rth@twiddle.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106141308.30535-1-rth@twiddle.net>
References: <20191106141308.30535-1-rth@twiddle.net>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

We must not use the pointer output without validating the
success of the random read.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 arch/x86/include/asm/archrandom.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
index feb59461046c..7a4bb1bd4bdb 100644
--- a/arch/x86/include/asm/archrandom.h
+++ b/arch/x86/include/asm/archrandom.h
@@ -27,7 +27,7 @@
 
 /* Unconditional execution of RDRAND and RDSEED */
 
-static inline bool rdrand_long(unsigned long *v)
+static inline bool __must_check rdrand_long(unsigned long *v)
 {
 	bool ok;
 	unsigned int retry = RDRAND_RETRY_LOOPS;
@@ -41,7 +41,7 @@ static inline bool rdrand_long(unsigned long *v)
 	return false;
 }
 
-static inline bool rdrand_int(unsigned int *v)
+static inline bool __must_check rdrand_int(unsigned int *v)
 {
 	bool ok;
 	unsigned int retry = RDRAND_RETRY_LOOPS;
@@ -55,7 +55,7 @@ static inline bool rdrand_int(unsigned int *v)
 	return false;
 }
 
-static inline bool rdseed_long(unsigned long *v)
+static inline bool __must_check rdseed_long(unsigned long *v)
 {
 	bool ok;
 	asm volatile(RDSEED_LONG
@@ -64,7 +64,7 @@ static inline bool rdseed_long(unsigned long *v)
 	return ok;
 }
 
-static inline bool rdseed_int(unsigned int *v)
+static inline bool __must_check rdseed_int(unsigned int *v)
 {
 	bool ok;
 	asm volatile(RDSEED_INT
@@ -80,22 +80,22 @@ static inline bool rdseed_int(unsigned int *v)
  */
 #ifdef CONFIG_ARCH_RANDOM
 
-static inline bool arch_get_random_long(unsigned long *v)
+static inline bool __must_check arch_get_random_long(unsigned long *v)
 {
 	return static_cpu_has(X86_FEATURE_RDRAND) ? rdrand_long(v) : false;
 }
 
-static inline bool arch_get_random_int(unsigned int *v)
+static inline bool __must_check arch_get_random_int(unsigned int *v)
 {
 	return static_cpu_has(X86_FEATURE_RDRAND) ? rdrand_int(v) : false;
 }
 
-static inline bool arch_get_random_seed_long(unsigned long *v)
+static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
 {
 	return static_cpu_has(X86_FEATURE_RDSEED) ? rdseed_long(v) : false;
 }
 
-static inline bool arch_get_random_seed_int(unsigned int *v)
+static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
 {
 	return static_cpu_has(X86_FEATURE_RDSEED) ? rdseed_int(v) : false;
 }
-- 
2.17.1

