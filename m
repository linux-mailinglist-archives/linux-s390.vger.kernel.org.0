Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 506937C72B
	for <lists+linux-s390@lfdr.de>; Wed, 31 Jul 2019 17:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfGaPqi (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 31 Jul 2019 11:46:38 -0400
Received: from foss.arm.com ([217.140.110.172]:49736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729758AbfGaPqg (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 31 Jul 2019 11:46:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 230CC1570;
        Wed, 31 Jul 2019 08:46:36 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21C233F694;
        Wed, 31 Jul 2019 08:46:33 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH v10 08/22] s390: mm: Add p?d_leaf() definitions
Date:   Wed, 31 Jul 2019 16:45:49 +0100
Message-Id: <20190731154603.41797-9-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731154603.41797-1-steven.price@arm.com>
References: <20190731154603.41797-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information is provided by the
p?d_leaf() functions/macros.

For s390, pud_large() and pmd_large() are already implemented as static
inline functions. Add a macro to provide the p?d_leaf names for the
generic code to use.

CC: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Vasily Gorbik <gor@linux.ibm.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
CC: linux-s390@vger.kernel.org
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/s390/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 9b274fcaacb6..f99a5f546e5e 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -674,6 +674,7 @@ static inline int pud_none(pud_t pud)
 	return pud_val(pud) == _REGION3_ENTRY_EMPTY;
 }
 
+#define pud_leaf	pud_large
 static inline int pud_large(pud_t pud)
 {
 	if ((pud_val(pud) & _REGION_ENTRY_TYPE_MASK) != _REGION_ENTRY_TYPE_R3)
@@ -691,6 +692,7 @@ static inline unsigned long pud_pfn(pud_t pud)
 	return (pud_val(pud) & origin_mask) >> PAGE_SHIFT;
 }
 
+#define pmd_leaf	pmd_large
 static inline int pmd_large(pmd_t pmd)
 {
 	return (pmd_val(pmd) & _SEGMENT_ENTRY_LARGE) != 0;
-- 
2.20.1

