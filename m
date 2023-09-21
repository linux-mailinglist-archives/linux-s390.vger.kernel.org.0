Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907107A9ADE
	for <lists+linux-s390@lfdr.de>; Thu, 21 Sep 2023 20:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjIUSv0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 21 Sep 2023 14:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjIUSvR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 21 Sep 2023 14:51:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28BC77EA31;
        Thu, 21 Sep 2023 10:37:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECB2D1713;
        Thu, 21 Sep 2023 09:21:05 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 811AA3F59C;
        Thu, 21 Sep 2023 09:20:24 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: [PATCH v1 1/8] parisc: hugetlb: Convert set_huge_pte_at() to take vma
Date:   Thu, 21 Sep 2023 17:20:00 +0100
Message-Id: <20230921162007.1630149-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921162007.1630149-1-ryan.roberts@arm.com>
References: <20230921162007.1630149-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

In order to fix a bug, arm64 needs access to the vma inside it's
implementation of set_huge_pte_at(). Provide for this by converting the
mm parameter to be a vma. Any implementations that require the mm can
access it via vma->vm_mm.

This commit makes the required parisc modifications. Separate commits
update the other arches and core code, before the actual bug is fixed in
arm64.

No behavioral changes intended.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/parisc/include/asm/hugetlb.h | 2 +-
 arch/parisc/mm/hugetlbpage.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
index f7f078c2872c..29ba631862c5 100644
--- a/arch/parisc/include/asm/hugetlb.h
+++ b/arch/parisc/include/asm/hugetlb.h
@@ -5,7 +5,7 @@
 #include <asm/page.h>
 
 #define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
-void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+void set_huge_pte_at(struct vm_area_struct *vma, unsigned long addr,
 		     pte_t *ptep, pte_t pte);
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index a8a1a7c1e16e..fc5e1ad8e5e8 100644
--- a/arch/parisc/mm/hugetlbpage.c
+++ b/arch/parisc/mm/hugetlbpage.c
@@ -139,10 +139,10 @@ static void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	purge_tlb_entries_huge(mm, addr_start);
 }
 
-void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+void set_huge_pte_at(struct vm_area_struct *vma, unsigned long addr,
 		     pte_t *ptep, pte_t entry)
 {
-	__set_huge_pte_at(mm, addr, ptep, entry);
+	__set_huge_pte_at(vma->vm_mm, addr, ptep, entry);
 }
 
 
-- 
2.25.1

