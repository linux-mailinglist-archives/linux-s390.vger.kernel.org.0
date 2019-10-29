Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 734C9E8136
	for <lists+linux-s390@lfdr.de>; Tue, 29 Oct 2019 07:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbfJ2GuZ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 29 Oct 2019 02:50:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733095AbfJ2Gtd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 29 Oct 2019 02:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gSXK72L3945Be32U1mETDhkMRH47vVT41OGNUHBlxH8=; b=uEWET/ucQij/R1IavLXSZNFtto
        129S5aupz0GYWjEC7d/jR3EsbWcp5Uim7aB0YQtTKZ9J2NfIRhEf/LVPmv+py+vkJdOdTJPxPnDEO
        sVSfYAC+SjqbWM8+YjYfCznHUgJxd9cmsV9AovrgHX204lYSL0v4Sy0j3rrurHYO6vlRLoNBjl5vZ
        pzZC9c9eSfp3kC+lVQsWLIh8NryNGGQvlKpRrBgrEDnLF15EFSQru0FjAsRPdjxy6MzVwHAkolclV
        BWShA5ufIKvdP7bAPnixIETEy2UUrHQlBVthsml/QIRw+Yor0BphHu56dCL1dFFKDWf9B32Fd0lGJ
        vlXD4dHw==;
Received: from [2001:4bb8:18c:c7d:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPLJW-0003ri-GT; Tue, 29 Oct 2019 06:49:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/21] asm-generic: don't provide ioremap for CONFIG_MMU
Date:   Tue, 29 Oct 2019 07:48:24 +0100
Message-Id: <20191029064834.23438-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191029064834.23438-1-hch@lst.de>
References: <20191029064834.23438-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

All MMU-enabled ports have a non-trivial ioremap and should thus provide
the prototype for their implementation instead of providing a generic
one unless a different symbol is not defined.  Note that this only
affects sparc32 nds32 as all others do provide their own version.

Also update the kerneldoc comments in asm-generic/io.h to explain the
situation around the default ioremap* implementations correctly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nds32/include/asm/io.h    |  2 ++
 arch/sparc/include/asm/io_32.h |  1 +
 include/asm-generic/io.h       | 29 ++++++++---------------------
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/arch/nds32/include/asm/io.h b/arch/nds32/include/asm/io.h
index 16f262322b8f..fb0e8a24c7af 100644
--- a/arch/nds32/include/asm/io.h
+++ b/arch/nds32/include/asm/io.h
@@ -6,6 +6,7 @@
 
 #include <linux/types.h>
 
+void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
 extern void iounmap(volatile void __iomem *addr);
 #define __raw_writeb __raw_writeb
 static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
@@ -80,4 +81,5 @@ static inline u32 __raw_readl(const volatile void __iomem *addr)
 #define writew(v,c)	({ __iowmb(); writew_relaxed((v),(c)); })
 #define writel(v,c)	({ __iowmb(); writel_relaxed((v),(c)); })
 #include <asm-generic/io.h>
+
 #endif /* __ASM_NDS32_IO_H */
diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index df2dc1784673..9a52d9506f80 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -127,6 +127,7 @@ static inline void sbus_memcpy_toio(volatile void __iomem *dst,
  * Bus number may be embedded in the higher bits of the physical address.
  * This is why we have no bus number argument to ioremap().
  */
+void __iomem *ioremap(phys_addr_t offset, size_t size);
 void iounmap(volatile void __iomem *addr);
 /* Create a virtual mapping cookie for an IO port range */
 void __iomem *ioport_map(unsigned long port, unsigned int nr);
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index a98ed6325727..6a5edc23afe2 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -922,28 +922,16 @@ static inline void *phys_to_virt(unsigned long address)
 /**
  * DOC: ioremap() and ioremap_*() variants
  *
- * If you have an IOMMU your architecture is expected to have both ioremap()
- * and iounmap() implemented otherwise the asm-generic helpers will provide a
- * direct mapping.
+ * Architectures with an MMU are expected to provide ioremap() and iounmap()
+ * themselves.  For NOMMU architectures we provide a default nop-op
+ * implementation that expect that the physical address used for MMIO are
+ * already marked as uncached, and can be used as kernel virtual addresses.
  *
- * There are ioremap_*() call variants, if you have no IOMMU we naturally will
- * default to direct mapping for all of them, you can override these defaults.
- * If you have an IOMMU you are highly encouraged to provide your own
- * ioremap variant implementation as there currently is no safe architecture
- * agnostic default. To avoid possible improper behaviour default asm-generic
- * ioremap_*() variants all return NULL when an IOMMU is available. If you've
- * defined your own ioremap_*() variant you must then declare your own
- * ioremap_*() variant as defined to itself to avoid the default NULL return.
+ * ioremap_wc() and ioremap_wt() can provide more relaxed caching attributes
+ * for specific drivers if the architecture choses to implement them.  If they
+ * are not implemented we fall back to plain ioremap.
  */
 #ifndef CONFIG_MMU
-
-/*
- * Change "struct page" to physical address.
- *
- * This implementation is for the no-MMU case only... if you have an MMU
- * you'll need to provide your own definitions.
- */
-
 #ifndef ioremap
 #define ioremap ioremap
 static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
@@ -954,14 +942,13 @@ static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
 
 #ifndef iounmap
 #define iounmap iounmap
-
 static inline void iounmap(void __iomem *addr)
 {
 }
 #endif
 #endif /* CONFIG_MMU */
+
 #ifndef ioremap_nocache
-void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
 #define ioremap_nocache ioremap_nocache
 static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
 {
-- 
2.20.1

