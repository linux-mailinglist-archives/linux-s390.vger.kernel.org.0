Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51644669FFB
	for <lists+linux-s390@lfdr.de>; Fri, 13 Jan 2023 18:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjAMRT6 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 13 Jan 2023 12:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjAMRTK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 13 Jan 2023 12:19:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008C591535
        for <linux-s390@vger.kernel.org>; Fri, 13 Jan 2023 09:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673629992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iq3NJjdIXoIIFXuABXPEN69O+eZCmfZSMHyuPIjJQUs=;
        b=B/F5KAiIG+db5uitxUG3Tq8le91lqF8etfoeZ0xfdm087xolTiDnlFMCD1o08GHchaBZZv
        yKuWpm1JKtvNgNuWwumNpO75+iZmD6BsDVVONECT7G7LExbVgfzkNcHLZbw87rhPmSRe4T
        sIavJOEZBJxUopD2ZyyAoPhgB5UGM0c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-tcQ5phS1Ng-WmjPesDZNfg-1; Fri, 13 Jan 2023 12:13:10 -0500
X-MC-Unique: tcQ5phS1Ng-WmjPesDZNfg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6769100F902;
        Fri, 13 Jan 2023 17:13:08 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CFF640C2064;
        Fri, 13 Jan 2023 17:13:02 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        David Hildenbrand <david@redhat.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Subject: [PATCH mm-unstable v1 20/26] sh/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date:   Fri, 13 Jan 2023 18:10:20 +0100
Message-Id: <20230113171026.582290-21-david@redhat.com>
In-Reply-To: <20230113171026.582290-1-david@redhat.com>
References: <20230113171026.582290-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by using bit 6 in the PTE,
reducing the swap type in the !CONFIG_X2TLB case to 5 bits. Generic MM
currently only uses 5 bits for the type (MAX_SWAPFILES_SHIFT), so the
stolen bit is effectively unused.

Interrestingly, the swap type in the !CONFIG_X2TLB case could currently
overlap with the _PAGE_PRESENT bit, because there is a sneaky shift by 1 in
__pte_to_swp_entry() and __swp_entry_to_pte(). Bit 0-7 in the architecture
specific swap PTE would get shifted to bit 1-8 in the PTE. As generic MM
uses 5 bits only, this didn't matter so far.

While at it, mask the type in __swp_entry().

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/sh/include/asm/pgtable_32.h | 54 +++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index d0240decacca..c34aa795a9d2 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -423,40 +423,70 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 #endif
 
 /*
- * Encode and de-code a swap entry
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
  *
  * Constraints:
  *	_PAGE_PRESENT at bit 8
  *	_PAGE_PROTNONE at bit 9
  *
- * For the normal case, we encode the swap type into bits 0:7 and the
- * swap offset into bits 10:30. For the 64-bit PTE case, we keep the
- * preserved bits in the low 32-bits and use the upper 32 as the swap
- * offset (along with a 5-bit type), following the same approach as x86
- * PAE. This keeps the logic quite simple.
+ * For the normal case, we encode the swap type and offset into the swap PTE
+ * such that bits 8 and 9 stay zero. For the 64-bit PTE case, we use the
+ * upper 32 for the swap offset and swap type, following the same approach as
+ * x86 PAE. This keeps the logic quite simple.
  *
  * As is evident by the Alpha code, if we ever get a 64-bit unsigned
  * long (swp_entry_t) to match up with the 64-bit PTEs, this all becomes
  * much cleaner..
- *
- * NOTE: We should set ZEROs at the position of _PAGE_PRESENT
- *       and _PAGE_PROTNONE bits
  */
+
 #ifdef CONFIG_X2TLB
+/*
+ * Format of swap PTEs:
+ *
+ *   6 6 6 6 5 5 5 5 5 5 5 5 5 5 4 4 4 4 4 4 4 4 4 4 3 3 3 3 3 3 3 3
+ *   3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2
+ *   <--------------------- offset ----------------------> < type ->
+ *
+ *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *   <------------------- zeroes --------------------> E 0 0 0 0 0 0
+ */
 #define __swp_type(x)			((x).val & 0x1f)
 #define __swp_offset(x)			((x).val >> 5)
-#define __swp_entry(type, offset)	((swp_entry_t){ (type) | (offset) << 5})
+#define __swp_entry(type, offset)	((swp_entry_t){ ((type) & 0x1f) | (offset) << 5})
 #define __pte_to_swp_entry(pte)		((swp_entry_t){ (pte).pte_high })
 #define __swp_entry_to_pte(x)		((pte_t){ 0, (x).val })
 
 #else
-#define __swp_type(x)			((x).val & 0xff)
+/*
+ * Format of swap PTEs:
+ *
+ *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *   <--------------- offset ----------------> 0 0 0 0 E < type -> 0
+ *
+ *   E is the exclusive marker that is not stored in swap entries.
+ */
+#define __swp_type(x)			((x).val & 0x1f)
 #define __swp_offset(x)			((x).val >> 10)
-#define __swp_entry(type, offset)	((swp_entry_t){(type) | (offset) <<10})
+#define __swp_entry(type, offset)	((swp_entry_t){((type) & 0x1f) | (offset) << 10})
 
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> 1 })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val << 1 })
 #endif
 
+/* In both cases, we borrow bit 6 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	_PAGE_USER
+
+#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
+static inline int pte_swp_exclusive(pte_t pte)
+{
+	return pte.pte_low & _PAGE_SWP_EXCLUSIVE;
+}
+
+PTE_BIT_FUNC(low, swp_mkexclusive, |= _PAGE_SWP_EXCLUSIVE);
+PTE_BIT_FUNC(low, swp_clear_exclusive, &= ~_PAGE_SWP_EXCLUSIVE);
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_SH_PGTABLE_32_H */
-- 
2.39.0

