Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3EB7E7ADD
	for <lists+linux-s390@lfdr.de>; Mon, 28 Oct 2019 22:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389630AbfJ1VGJ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 28 Oct 2019 17:06:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52158 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389619AbfJ1VGI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Oct 2019 17:06:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id q70so428306wme.1
        for <linux-s390@vger.kernel.org>; Mon, 28 Oct 2019 14:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wt6X/0E8OEKNHUN7g3xU4aGMZDZ5EHD7/+dGHnvwGeQ=;
        b=YGEP7iPJRvBw4yNdXLHPDdf8+ai816ix7N7Bnmn+DtIkNntfuBxATktwcBQdTTghzc
         S139y8vtzCo1l3lkEZrn9e7Qr7TBeIzmnC/WIwyB/bnmVcS9v83cv/FhRIC/Yn8ghqNo
         c0RfSeGteHKp1y5HFIN2GCSf41EfH3JyBMQLdT45+h0nv7FeJ9ldioAIdVdbTRNeUu7X
         lCCe2D7wL/jdh7iRz5lkmcKKX43h5srQf5ayTjDEeb5Vaert877x5FQFZjbZS8V9MMGH
         CaT1RCOM7OWVqzXjfX4aRvXG7uuuirukdEeukUf2dmStasS8yLh7pdn0+mH4ufdgua+T
         zG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wt6X/0E8OEKNHUN7g3xU4aGMZDZ5EHD7/+dGHnvwGeQ=;
        b=GxPuw3dJJ8s9+qUYxa7GbeO9Gy8HU81hcFfM+AOdYWnu/Anp3NPOLOo88/EecHo5Ix
         hrhJYrwFIVY3u393CJMFTAF8lappAbQZMEqlJeilRfa59fc6j0SqJ3K1Xy3Tg95V8dX1
         zXQ3oHkds0NYmFV2MeTvxQ1wES7dXenfIA0gfJujWBJ5eiW6Gc8O3SHFNA2jnKDE39/w
         8jrzlBqo4rkwN05mDvHFZdfIFdEY/V8iGFjVmROh9UPzpns8TxRdGKX+0DJCqyUVIqRI
         nVyKdgFk67wBye2y1Dc/bssKByQ5oCZ1NLjuywxzxH4LPQVK4Bza+oW9k1+eone5zg+o
         37rg==
X-Gm-Message-State: APjAAAVSjeiGb4RldzOeSepFG52OczU5WRR7tTYJtzF3QGJZIi1WvX49
        TYYnaWxIRFSDqQwokjViFp9RGQ==
X-Google-Smtp-Source: APXvYqzqAvwwu8fufnMscandR8x4T4e5vo0ImUH4MNWMeVXTw6UAGYm/xpeYwYMKAveMairVDQRveQ==
X-Received: by 2002:a1c:544e:: with SMTP id p14mr1023951wmi.17.1572296765994;
        Mon, 28 Oct 2019 14:06:05 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net. [88.138.106.230])
        by smtp.gmail.com with ESMTPSA id b196sm927822wmd.24.2019.10.28.14.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 14:06:05 -0700 (PDT)
From:   Richard Henderson <richard.henderson@linaro.org>
X-Google-Original-From: Richard Henderson <rth@twiddle.net>
To:     linux-arch@vger.kernel.org
Cc:     x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 3/6] x86: Mark archrandom.h functions __must_check
Date:   Mon, 28 Oct 2019 22:05:56 +0100
Message-Id: <20191028210559.8289-4-rth@twiddle.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028210559.8289-1-rth@twiddle.net>
References: <20191028210559.8289-1-rth@twiddle.net>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

We cannot use the pointer output without validating the
success of the random read.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/archrandom.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
index 5904d7d9e703..9e4ea9e53dd0 100644
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
@@ -84,22 +84,22 @@ static inline bool rdseed_int(unsigned int *v)
 #define arch_has_random()	static_cpu_has(X86_FEATURE_RDRAND)
 #define arch_has_random_seed()	static_cpu_has(X86_FEATURE_RDSEED)
 
-static inline bool arch_get_random_long(unsigned long *v)
+static inline bool __must_check arch_get_random_long(unsigned long *v)
 {
 	return arch_has_random() ? rdrand_long(v) : false;
 }
 
-static inline bool arch_get_random_int(unsigned int *v)
+static inline bool __must_check arch_get_random_int(unsigned int *v)
 {
 	return arch_has_random() ? rdrand_int(v) : false;
 }
 
-static inline bool arch_get_random_seed_long(unsigned long *v)
+static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
 {
 	return arch_has_random_seed() ? rdseed_long(v) : false;
 }
 
-static inline bool arch_get_random_seed_int(unsigned int *v)
+static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
 {
 	return arch_has_random_seed() ? rdseed_int(v) : false;
 }
-- 
2.17.1

