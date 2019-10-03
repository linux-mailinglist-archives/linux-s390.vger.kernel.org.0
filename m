Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 914F7CB13D
	for <lists+linux-s390@lfdr.de>; Thu,  3 Oct 2019 23:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbfJCVgz (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 3 Oct 2019 17:36:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44823 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732887AbfJCVgy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Oct 2019 17:36:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id u40so5726515qth.11
        for <linux-s390@vger.kernel.org>; Thu, 03 Oct 2019 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pI1KmVNKpDj+42btITh2dqoDTCysg2+scSwiPIPFiPs=;
        b=LutUDiEMx/r3GUlDEZoQxxNrRPwRc4xUSrKAXOPYu5xVXn+VfeNBlV6lhujzvRtAaQ
         U2ePBJV1fEAzOyEjaeT+l37LwOnYLPkyg/yXBFVcpu2XJBQFI+npX2r4lnEC/qxLJKBS
         L/UJGl8J9qKKak4NQvd70mEFbnIHE0ieXLtIZiB9XqHExT7wD1vn5jtSZZBhOYMUbfsi
         i+KJlXUqfK/BS4mJGe8viFm7jV/XhFDwPHqcz5e2NtihmFux0FLvJwJII8w1XUSRgdSa
         bxi/cB8KERhgNPrAxUvxPzaXr/+8xMyTaXNeQMWaxNCbGyVS5rm7HOXv1k7VjfzgeHdW
         ODkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pI1KmVNKpDj+42btITh2dqoDTCysg2+scSwiPIPFiPs=;
        b=H7ar/4hFcnftXl8nHvtrduaa+5ovse3YWFh6qKmXQOQ2fqfb0O5lsQErnafDyJX+v2
         7XcNs8X0ng0QJDEjeYb5BP23dv9h2+Bv51u7pB7OgzbaKgSOtqj/xpYK9VVPNT7HXjIW
         HoCfQrsTttCLDbNdxEMkV5QWeNBjJ7l8UZyS8YB5JCLP+lNHlKWSIr8UI7ki4ocdJd2N
         eFmZRSYHKSVdGrPOmYwPrRxxqedngGLmSxAG7hrdCHNYn1qYin2tsW9GucHDY8/4gERU
         YFs1yXslWIZfWJ6j+/QPYmrbBzRNe1eLLX9dW9HTi6od1hDCI9Uxe0b0nzSs9hGLf28y
         /KZw==
X-Gm-Message-State: APjAAAXyU6EWPkM7rbKgGoolsOjr77JX39lfC4OuHjbPqa2jXzhNiqkg
        hsfISLMO2uz3DJNfRYunIMZPZYrbonU=
X-Google-Smtp-Source: APXvYqw6ZTxd6WgEr2A+6PQqwM+gDjISutNBa2bvT0qivUnj6X0lc4Zg+Q2W8sLvy5V2Xcm8KvCn5A==
X-Received: by 2002:ac8:38ef:: with SMTP id g44mr12548987qtc.277.1570138613608;
        Thu, 03 Oct 2019 14:36:53 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h68sm2047396qkf.2.2019.10.03.14.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 14:36:52 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] s390/mm: fix -Wunused-but-set-variable warnings
Date:   Thu,  3 Oct 2019 17:36:36 -0400
Message-Id: <1570138596-11913-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Convert two functions to static inline to get ride of W=1 GCC warnings
like,

mm/gup.c: In function 'gup_pte_range':
mm/gup.c:1816:16: warning: variable 'ptem' set but not used
[-Wunused-but-set-variable]
  pte_t *ptep, *ptem;
                ^~~~

mm/mmap.c: In function 'acct_stack_growth':
mm/mmap.c:2322:16: warning: variable 'new_start' set but not used
[-Wunused-but-set-variable]
  unsigned long new_start;
                ^~~~~~~~~

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/s390/include/asm/hugetlb.h | 9 +++++++--
 arch/s390/include/asm/pgtable.h | 3 ++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index bb59dd964590..de8f0bf5f238 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -12,8 +12,6 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 
-
-#define is_hugepage_only_range(mm, addr, len)	0
 #define hugetlb_free_pgd_range			free_pgd_range
 #define hugepages_supported()			(MACHINE_HAS_EDAT1)
 
@@ -23,6 +21,13 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr, pte_t *ptep);
 
+static inline bool is_hugepage_only_range(struct mm_struct *mm,
+					  unsigned long addr,
+					  unsigned long len)
+{
+	return false;
+}
+
 /*
  * If the arch doesn't supply something else, assume that hugepage
  * size aligned regions are ok without further preparation.
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 36c578c0ff96..19c2cf001df3 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1269,7 +1269,8 @@ static inline pte_t *pte_offset(pmd_t *pmd, unsigned long address)
 
 #define pte_offset_kernel(pmd, address) pte_offset(pmd, address)
 #define pte_offset_map(pmd, address) pte_offset_kernel(pmd, address)
-#define pte_unmap(pte) do { } while (0)
+
+static inline void pte_unmap(pte_t *pte) { }
 
 static inline bool gup_fast_permitted(unsigned long start, unsigned long end)
 {
-- 
1.8.3.1

