Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17BCCE7ADB
	for <lists+linux-s390@lfdr.de>; Mon, 28 Oct 2019 22:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389536AbfJ1VGJ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 28 Oct 2019 17:06:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42378 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389622AbfJ1VGJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Oct 2019 17:06:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id r1so11376073wrs.9
        for <linux-s390@vger.kernel.org>; Mon, 28 Oct 2019 14:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OA1lEVPUVah/nj9y4NPe9mpA4YmtUJ45alybXkd0IGY=;
        b=odEkHLjSN3JWnD5C17Txi1cL9gpWHsxbz/541i6HonY1afq+jCmqm6gjraAZ5IF+E5
         3g5eNOzZKQSnRPN35Ido+e/kuRQqORGuoNGHzAuQQLx6oWni+DDSeDvsOW+yofnFtlQC
         0KTVYObE7IiOiNlxdatiKqYf37B1LSAWNDDPYMxFahwK4p9pedn8j6CNfwVcs42oflWp
         TBmfFgdkCjRAYh0LIo2msRLbcL3jnQA1v2rQNPiG8DZnE2NWXfwmz4QQHDhLGC2CkMdP
         kiWYPILROM1iiiG5p0Wz8b4RcFHnytBC85i2qQ/q7Tt0PafGD08vMQ2L1YqvEoDTrMkQ
         gE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OA1lEVPUVah/nj9y4NPe9mpA4YmtUJ45alybXkd0IGY=;
        b=Cn+VWSHLQRoEGtuThnVavWRYdHKYhizEOeeOt9jmONndy9xsblhXNoYCHY6mh1vLH7
         yUBZhOlQ9ahEaXTYo6tWISn6eElOhvyh6ooD+f8Wxf5Iw1fGEhhqXF1/kdzgAvXmzv7W
         LfeWNfaYKR1eS/RhIoZ47UJpIU+jX9hy5lG85/zuWAplSUZ4CCI+xxs9sPZfTl+LHSm7
         bL5KcjDZQRkad4chEDOjugSfQHNJOw64p4J7HbI8wV2El+0dtdaYPaNYuLp4qMbE1+Fu
         a7QIlTV0+ebH6j2jCoNRJ+r9gGcoCC69iGUUv1By+PAR618qdkGghlGNSWkG9xirA2nQ
         IDUw==
X-Gm-Message-State: APjAAAU0nKYBsWGiZkxGqwqOhsceX+KioNmQycYMDmBiAH8VTXPtxjbE
        hsoYk80BaNTh8c3Cesr7zui1hA==
X-Google-Smtp-Source: APXvYqxc7HPshldpApCL1t58Sst+B72c5dhOqq43UkylGW9qCLLj3H1LeTQb93H8/kIqXI/hDnfPUg==
X-Received: by 2002:adf:82d2:: with SMTP id 76mr15985163wrc.52.1572296766984;
        Mon, 28 Oct 2019 14:06:06 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net. [88.138.106.230])
        by smtp.gmail.com with ESMTPSA id b196sm927822wmd.24.2019.10.28.14.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 14:06:06 -0700 (PDT)
From:   Richard Henderson <richard.henderson@linaro.org>
X-Google-Original-From: Richard Henderson <rth@twiddle.net>
To:     linux-arch@vger.kernel.org
Cc:     x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4/6] powerpc: Use bool in archrandom.h
Date:   Mon, 28 Oct 2019 22:05:57 +0100
Message-Id: <20191028210559.8289-5-rth@twiddle.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028210559.8289-1-rth@twiddle.net>
References: <20191028210559.8289-1-rth@twiddle.net>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The generic interface uses bool not int; match that.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/archrandom.h | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
index 9c63b596e6ce..f8a887c8b7f8 100644
--- a/arch/powerpc/include/asm/archrandom.h
+++ b/arch/powerpc/include/asm/archrandom.h
@@ -6,27 +6,28 @@
 
 #include <asm/machdep.h>
 
-static inline int arch_get_random_long(unsigned long *v)
+static inline bool arch_get_random_long(unsigned long *v)
 {
-	return 0;
+	return false;
 }
 
-static inline int arch_get_random_int(unsigned int *v)
+static inline bool arch_get_random_int(unsigned int *v)
 {
-	return 0;
+	return false;
 }
 
-static inline int arch_get_random_seed_long(unsigned long *v)
+static inline bool arch_get_random_seed_long(unsigned long *v)
 {
 	if (ppc_md.get_random_seed)
 		return ppc_md.get_random_seed(v);
 
-	return 0;
+	return false;
 }
-static inline int arch_get_random_seed_int(unsigned int *v)
+
+static inline bool arch_get_random_seed_int(unsigned int *v)
 {
 	unsigned long val;
-	int rc;
+	bool rc;
 
 	rc = arch_get_random_long(&val);
 	if (rc)
@@ -35,15 +36,16 @@ static inline int arch_get_random_seed_int(unsigned int *v)
 	return rc;
 }
 
-static inline int arch_has_random(void)
+static inline bool arch_has_random(void)
 {
-	return 0;
+	return false;
 }
 
-static inline int arch_has_random_seed(void)
+static inline bool arch_has_random_seed(void)
 {
 	return !!ppc_md.get_random_seed;
 }
+
 #endif /* CONFIG_ARCH_RANDOM */
 
 #ifdef CONFIG_PPC_POWERNV
-- 
2.17.1

