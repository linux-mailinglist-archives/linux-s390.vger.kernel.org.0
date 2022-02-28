Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDFA4C675B
	for <lists+linux-s390@lfdr.de>; Mon, 28 Feb 2022 11:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiB1KtY (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 28 Feb 2022 05:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiB1KtX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Feb 2022 05:49:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32CCE43486;
        Mon, 28 Feb 2022 02:48:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA0F81063;
        Mon, 28 Feb 2022 02:48:43 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.47.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6F2553F73D;
        Mon, 28 Feb 2022 02:48:36 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-alpha@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-parisc@vger.kernel.org,
        openrisc@lists.librecores.org, linux-um@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH V3 00/30] mm/mmap: Drop protection_map[] and platform's __SXXX/__PXXX requirements
Date:   Mon, 28 Feb 2022 16:17:23 +0530
Message-Id: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

protection_map[] is an array based construct that translates given vm_flags
combination. This array contains page protection map, which is populated by
the platform via [__S000 .. __S111] and [__P000 .. __P111] exported macros.
Primary usage for protection_map[] is for vm_get_page_prot(), which is used
to determine page protection value for a given vm_flags. vm_get_page_prot()
implementation, could again call platform overrides arch_vm_get_page_prot()
and arch_filter_pgprot(). Some platforms override protection_map[] that was
originally built with __SXXX/__PXXX with different runtime values.

Currently there are multiple layers of abstraction i.e __SXXX/__PXXX macros
, protection_map[], arch_vm_get_page_prot() and arch_filter_pgprot() built
between the platform and generic MM, finally defining vm_get_page_prot().

Hence this series proposes to drop all these abstraction levels and instead
just move the responsibility of defining vm_get_page_prot() to the platform
itself making it clean and simple.

This first introduces ARCH_HAS_VM_GET_PAGE_PROT which enables the platforms
to define custom vm_get_page_prot(). This starts converting platforms that
either change protection_map[] or define the overrides arch_filter_pgprot()
or arch_vm_get_page_prot() which enables for those constructs to be dropped
off completely. This series then converts remaining platforms which enables
for __SXXX/__PXXX constructs to be dropped off completely. Finally it drops
the generic vm_get_page_prot() and then ARCH_HAS_VM_GET_PAGE_PROT as every
platform now defines their own vm_get_page_prot().

The series has been inspired from an earlier discuss with Christoph Hellwig

https://lore.kernel.org/all/1632712920-8171-1-git-send-email-anshuman.khandual@arm.com/

This series applies on 5.17-rc6 after the following patch.

https://lore.kernel.org/all/1643004823-16441-1-git-send-email-anshuman.khandual@arm.com/

This series has been cross built for multiple platforms.

- Anshuman

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: sparclinux@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-s390@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-parisc@vger.kernel.org
Cc: openrisc@lists.librecores.org
Cc: linux-um@lists.infradead.org
Cc: linux-hexagon@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Changes in V3:

- Dropped variable 'i' from sme_early_init() on x86 platform
- Moved CONFIG_COLDFIRE vm_get_page_prot() inside arch/m68k/mm/mcfmmu.c
- Moved CONFIG_SUN3 vm_get_page_prot() inside arch/m68k/mm/sun3mmu.c
- Dropped cachebits for vm_get_page_prot() inside arch/m68k/mm/motorola.c
- Dropped PAGE_XXX_C definitions from arch/m68k/include/asm/motorola_pgtable.h
- Used PAGE_XXX instead for vm_get_page_prot() inside arch/m68k/mm/motorola.c
- Dropped all references to protection_map[] in the tree
- Replaced s/extensa/xtensa/ on the patch title
- Moved left over comments from pgtable.h into init.c on nios2 platform

Changes in V2:

https://lore.kernel.org/all/1645425519-9034-1-git-send-email-anshuman.khandual@arm.com/

- Dropped the entire comment block in [PATCH 30/30] per Geert
- Replaced __P010 (although commented) with __PAGE_COPY on arm platform
- Replaced __P101 with PAGE_READONLY on um platform

Changes in V1:

https://lore.kernel.org/all/1644805853-21338-1-git-send-email-anshuman.khandual@arm.com/

- Add white spaces around the | operators 
- Moved powerpc_vm_get_page_prot() near vm_get_page_prot() on powerpc
- Moved arm64_vm_get_page_prot() near vm_get_page_prot() on arm64
- Moved sparc_vm_get_page_prot() near vm_get_page_prot() on sparc
- Compacted vm_get_page_prot() switch cases on all platforms
-  _PAGE_CACHE040 inclusion is dependent on CPU_IS_040_OR_060
- VM_SHARED case should return PAGE_NONE (not PAGE_COPY) on SH platform
- Reorganized VM_SHARED, VM_EXEC, VM_WRITE, VM_READ
- Dropped the last patch [RFC V1 31/31] which added macros for vm_flags combinations
  https://lore.kernel.org/all/1643029028-12710-32-git-send-email-anshuman.khandual@arm.com/

Changes in RFC:

https://lore.kernel.org/all/1643029028-12710-1-git-send-email-anshuman.khandual@arm.com/

Anshuman Khandual (29):
  mm/debug_vm_pgtable: Drop protection_map[] usage
  mm/mmap: Clarify protection_map[] indices
  mm/mmap: Add new config ARCH_HAS_VM_GET_PAGE_PROT
  powerpc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  arm64/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  sparc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  mips/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  m68k/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  arm/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  mm/mmap: Drop protection_map[]
  mm/mmap: Drop arch_filter_pgprot()
  mm/mmap: Drop arch_vm_get_page_pgprot()
  s390/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  riscv/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  alpha/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  sh/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  arc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  csky/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  xtensa/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  parisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  openrisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  um/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  microblaze/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  nios2/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  hexagon/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  nds32/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  ia64/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  mm/mmap: Drop generic vm_get_page_prot()
  mm/mmap: Drop ARCH_HAS_VM_GET_PAGE_PROT

Christoph Hellwig (1):
  x86/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT

 arch/alpha/include/asm/pgtable.h          | 17 -----
 arch/alpha/mm/init.c                      | 37 +++++++++++
 arch/arc/include/asm/pgtable-bits-arcv2.h | 17 -----
 arch/arc/mm/mmap.c                        | 41 ++++++++++++
 arch/arm/include/asm/pgtable.h            | 20 +-----
 arch/arm/lib/uaccess_with_memcpy.c        |  2 +-
 arch/arm/mm/mmu.c                         | 44 +++++++++++--
 arch/arm64/Kconfig                        |  1 -
 arch/arm64/include/asm/memory.h           |  3 +-
 arch/arm64/include/asm/mman.h             | 24 -------
 arch/arm64/include/asm/pgtable-prot.h     | 18 ------
 arch/arm64/include/asm/pgtable.h          | 11 ----
 arch/arm64/mm/mmap.c                      | 78 +++++++++++++++++++++++
 arch/csky/include/asm/pgtable.h           | 18 ------
 arch/csky/mm/init.c                       | 32 ++++++++++
 arch/hexagon/include/asm/pgtable.h        | 24 -------
 arch/hexagon/mm/init.c                    | 67 +++++++++++++++++++
 arch/ia64/include/asm/pgtable.h           | 17 -----
 arch/ia64/mm/init.c                       | 41 +++++++++++-
 arch/m68k/include/asm/mcf_pgtable.h       | 59 -----------------
 arch/m68k/include/asm/motorola_pgtable.h  | 29 ---------
 arch/m68k/include/asm/sun3_pgtable.h      | 22 -------
 arch/m68k/mm/mcfmmu.c                     | 59 +++++++++++++++++
 arch/m68k/mm/motorola.c                   | 43 ++++++++++++-
 arch/m68k/mm/sun3mmu.c                    | 39 ++++++++++++
 arch/microblaze/include/asm/pgtable.h     | 17 -----
 arch/microblaze/mm/init.c                 | 41 ++++++++++++
 arch/mips/include/asm/pgtable.h           | 22 -------
 arch/mips/mm/cache.c                      | 60 +++++++++--------
 arch/nds32/include/asm/pgtable.h          | 17 -----
 arch/nds32/mm/mmap.c                      | 37 +++++++++++
 arch/nios2/include/asm/pgtable.h          | 24 -------
 arch/nios2/mm/init.c                      | 47 ++++++++++++++
 arch/openrisc/include/asm/pgtable.h       | 18 ------
 arch/openrisc/mm/init.c                   | 41 ++++++++++++
 arch/parisc/include/asm/pgtable.h         | 20 ------
 arch/parisc/mm/init.c                     | 40 ++++++++++++
 arch/powerpc/include/asm/mman.h           | 12 ----
 arch/powerpc/include/asm/pgtable.h        | 19 ------
 arch/powerpc/mm/mmap.c                    | 59 +++++++++++++++++
 arch/riscv/include/asm/pgtable.h          | 16 -----
 arch/riscv/mm/init.c                      | 42 ++++++++++++
 arch/s390/include/asm/pgtable.h           | 17 -----
 arch/s390/mm/mmap.c                       | 33 ++++++++++
 arch/sh/include/asm/pgtable.h             | 17 -----
 arch/sh/mm/mmap.c                         | 38 +++++++++++
 arch/sparc/include/asm/mman.h             |  6 --
 arch/sparc/include/asm/pgtable_32.h       | 19 ------
 arch/sparc/include/asm/pgtable_64.h       | 19 ------
 arch/sparc/mm/init_32.c                   | 35 ++++++++++
 arch/sparc/mm/init_64.c                   | 70 ++++++++++++++------
 arch/um/include/asm/pgtable.h             | 17 -----
 arch/um/kernel/mem.c                      | 35 ++++++++++
 arch/x86/Kconfig                          |  1 -
 arch/x86/include/asm/pgtable.h            |  5 --
 arch/x86/include/asm/pgtable_types.h      | 19 ------
 arch/x86/include/uapi/asm/mman.h          | 14 ----
 arch/x86/mm/Makefile                      |  2 +-
 arch/x86/mm/mem_encrypt_amd.c             |  6 --
 arch/x86/mm/pgprot.c                      | 71 +++++++++++++++++++++
 arch/x86/um/mem_32.c                      |  2 +-
 arch/xtensa/include/asm/pgtable.h         | 19 ------
 arch/xtensa/mm/init.c                     | 35 ++++++++++
 drivers/gpu/drm/drm_vm.c                  |  4 +-
 include/linux/mm.h                        |  6 --
 include/linux/mman.h                      |  4 --
 mm/Kconfig                                |  3 -
 mm/debug_vm_pgtable.c                     | 31 +++++----
 mm/mmap.c                                 | 44 +------------
 69 files changed, 1138 insertions(+), 729 deletions(-)
 create mode 100644 arch/x86/mm/pgprot.c

-- 
2.25.1

