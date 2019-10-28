Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3FBCE7AD8
	for <lists+linux-s390@lfdr.de>; Mon, 28 Oct 2019 22:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389623AbfJ1VGI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 28 Oct 2019 17:06:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46928 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389553AbfJ1VGH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Oct 2019 17:06:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id n15so11347857wrw.13
        for <linux-s390@vger.kernel.org>; Mon, 28 Oct 2019 14:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HzpPHgz9dkPSBTYUxRiI5N3ILdBG2Y7xG5fdNi+CmCc=;
        b=n0bvaGSjcdm/n45EiluVOG4AFB7gD0MPIRsc9+ExLOlf95yU+Kh2aP0sBqtAI65Oje
         UI559g1TCAZjdGhIXtuL5Uw2TSU3U1tljgnLdt78YFaVCsugwccldmNW5IIRHMv1pSMM
         iNxLx2d4vvfVH859fXX7ZOZXfxhv5Wx0fkfaWZD4cCzNI056eMVSXDaQeBXzfzk52Psh
         wN/3e7MUW6L4UJyR1iFMilspC/8EJCVAJdRo8tof4+mnyYsoRAmdYJYj6JyAWwKNIYNz
         X+oLXH8QJHW0C4Wna6USrQVxiYU7+pn6klAdBYi+Gm6i/GEijMO30OgppJ/ZUOT8eJHz
         o5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HzpPHgz9dkPSBTYUxRiI5N3ILdBG2Y7xG5fdNi+CmCc=;
        b=AETsw57rG5tXyxHsIlo4KGtxBM+vizmtKVAOYN1QkVmjBbTLs2UYjc801ULGQ3/IHh
         UrPSm5OAbUx3NL40eI63HPjS2+jVHLZFWBj3LHkjOIU6TBYM52cS4/uNNdMhI854NcVg
         23qY3VN/NrAWfOntE67T4+Gm1JhfYOlziW2xudicAl3Le6dTyVFp61oUIO9q47Tvo5rs
         Bi6n9n5nd1f/E43Kg0S0p75bjycypS3oAEnqS7hxor5PwOnHHjI/Klv89vTgOVqvXbs4
         E6ikYUn5ZR1ivoIwhHSqAtMl7OfTZYVN/82kJi9krg0zzvRlEnPnwADOPNAzZ452Lznf
         a4iQ==
X-Gm-Message-State: APjAAAXXgIGj3WhJdc9M3jCDG4/WuMLjiAnFH8ZoG+mGM+2xiRMGA0R+
        R6a+LF/Mq8sWvhPYHeimOaBaFA==
X-Google-Smtp-Source: APXvYqzFqJnVOjSOYydSnQlBlFKEVK/uejnJRRcq3NDp8SAQpeKxQWcPsIMvCpbINphaS0TGA2jWDg==
X-Received: by 2002:adf:f84f:: with SMTP id d15mr17155903wrq.112.1572296764917;
        Mon, 28 Oct 2019 14:06:04 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net. [88.138.106.230])
        by smtp.gmail.com with ESMTPSA id b196sm927822wmd.24.2019.10.28.14.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 14:06:04 -0700 (PDT)
From:   Richard Henderson <richard.henderson@linaro.org>
X-Google-Original-From: Richard Henderson <rth@twiddle.net>
To:     linux-arch@vger.kernel.org
Cc:     x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/6] x86: Move arch_has_random* inside CONFIG_ARCH_RANDOM
Date:   Mon, 28 Oct 2019 22:05:55 +0100
Message-Id: <20191028210559.8289-3-rth@twiddle.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028210559.8289-1-rth@twiddle.net>
References: <20191028210559.8289-1-rth@twiddle.net>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

These functions are declared generically without CONFIG_ARCH_RANDOM.
The only reason this compiles for x86 is that we currently have a
mix of inline functions are preprocessor defines.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/archrandom.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
index af45e1452f09..5904d7d9e703 100644
--- a/arch/x86/include/asm/archrandom.h
+++ b/arch/x86/include/asm/archrandom.h
@@ -73,10 +73,6 @@ static inline bool rdseed_int(unsigned int *v)
 	return ok;
 }
 
-/* Conditional execution based on CPU type */
-#define arch_has_random()	static_cpu_has(X86_FEATURE_RDRAND)
-#define arch_has_random_seed()	static_cpu_has(X86_FEATURE_RDSEED)
-
 /*
  * These are the generic interfaces; they must not be declared if the
  * stubs in <linux/random.h> are to be invoked,
@@ -84,6 +80,10 @@ static inline bool rdseed_int(unsigned int *v)
  */
 #ifdef CONFIG_ARCH_RANDOM
 
+/* Conditional execution based on CPU type */
+#define arch_has_random()	static_cpu_has(X86_FEATURE_RDRAND)
+#define arch_has_random_seed()	static_cpu_has(X86_FEATURE_RDSEED)
+
 static inline bool arch_get_random_long(unsigned long *v)
 {
 	return arch_has_random() ? rdrand_long(v) : false;
-- 
2.17.1

