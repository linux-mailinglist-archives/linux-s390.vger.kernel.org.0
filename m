Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89522213E6
	for <lists+linux-s390@lfdr.de>; Fri, 17 May 2019 08:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfEQGzK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 17 May 2019 02:55:10 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:40958 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbfEQGzK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 May 2019 02:55:10 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x4H6sQI1006236;
        Fri, 17 May 2019 15:54:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x4H6sQI1006236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558076066;
        bh=/BYTJ4zxnc9ql4xZQk+WJLrlDFM4qCpFxkd8pJzLb9c=;
        h=From:To:Cc:Subject:Date:From;
        b=Q2VtVae6Ee0HybhaWXSMg69y6q1arF8Sf/3u/XHMZTCPOpMB44H54BKHkbXrOYYN4
         sTyqKSVgGlNw7oPey6yYOSC6lOjkiel9mhOBKa/MRcGpXQ1EeRKhiJD9ciFZUJU5lo
         qG5n3KT7Slc5xaDZohnfycTLEiaOSVGvd85a6BlWsNry0dKe4AR1DBIFR3kjMMSag7
         ZEesarqfo0ZgWtXj9pt5ZSerrlX1EaZCLvJ3hArzEcceGum0qQRT0+XWSGTEGlPjId
         aZrU4OYTFZusbiPR43kGBDWduFx1qFAPX8BlT63J0EzHwxFepnxOG46QCvqob91ugR
         QTZCX5d2BYNbA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Laura Abbott <labbott@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] s390: mark __cpacf_check_opcode() and cpacf_query_func() as __always_inline
Date:   Fri, 17 May 2019 15:54:24 +0900
Message-Id: <20190517065424.24453-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Commit e60fb8bf68d4 ("s390/cpacf: mark scpacf_query() as __always_inline")
was not enough to make sure to meet the 'i' (immediate) constraint for the
asm operands.

With CONFIG_OPTIMIZE_INLINING enabled, Laura Abbott reported error
with gcc 9.1.1:

  In file included from arch/s390/crypto/prng.c:29:
  ./arch/s390/include/asm/cpacf.h: In function 'cpacf_query_func':
  ./arch/s390/include/asm/cpacf.h:170:2: warning: asm operand 3 probably doesn't match constraints
    170 |  asm volatile(
        |  ^~~
  ./arch/s390/include/asm/cpacf.h:170:2: error: impossible constraint in 'asm'

Add more __always_inline to force inlining.

Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
Reported-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/include/asm/cpacf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
index f316de40e51b..19459dfb4295 100644
--- a/arch/s390/include/asm/cpacf.h
+++ b/arch/s390/include/asm/cpacf.h
@@ -177,7 +177,7 @@ static inline void __cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
 		: "cc");
 }
 
-static inline int __cpacf_check_opcode(unsigned int opcode)
+static __always_inline int __cpacf_check_opcode(unsigned int opcode)
 {
 	switch (opcode) {
 	case CPACF_KMAC:
@@ -217,7 +217,7 @@ static inline int cpacf_test_func(cpacf_mask_t *mask, unsigned int func)
 	return (mask->bytes[func >> 3] & (0x80 >> (func & 7))) != 0;
 }
 
-static inline int cpacf_query_func(unsigned int opcode, unsigned int func)
+static __always_inline int cpacf_query_func(unsigned int opcode, unsigned int func)
 {
 	cpacf_mask_t mask;
 
-- 
2.17.1

