Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7405A751D72
	for <lists+linux-s390@lfdr.de>; Thu, 13 Jul 2023 11:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjGMJk1 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 13 Jul 2023 05:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjGMJk0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 13 Jul 2023 05:40:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C940210A;
        Thu, 13 Jul 2023 02:40:25 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R1qMQ0F4fzrRnX;
        Thu, 13 Jul 2023 17:39:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 17:40:21 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        <surenb@google.com>
CC:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <linux-s390@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfc -next 00/10] mm: convert to generic VMA lock-based page fault
Date:   Thu, 13 Jul 2023 17:53:28 +0800
Message-ID: <20230713095339.189715-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add a generic VMA lock-based page fault handler in mm core, and convert
architectures to use it, which eliminate architectures's duplicated codes.

With it, we can avoid multiple changes in architectures's code if we 
add new feature or bugfix.

This fixes riscv missing change about commit 38b3aec8e8d2 "mm: drop per-VMA
lock when returning VM_FAULT_RETRY or VM_FAULT_COMPLETED", and in the end,
we enable this feature on ARM32/Loongarch too.

This is based on next-20230713, only built test(no loongarch compiler,
so except loongarch).

Kefeng Wang (10):
  mm: add a generic VMA lock-based page fault handler
  x86: mm: use try_vma_locked_page_fault()
  arm64: mm: use try_vma_locked_page_fault()
  s390: mm: use try_vma_locked_page_fault()
  powerpc: mm: use try_vma_locked_page_fault()
  riscv: mm: use try_vma_locked_page_fault()
  ARM: mm: try VMA lock-based page fault handling first
  loongarch: mm: cleanup __do_page_fault()
  loongarch: mm: add access_error() helper
  loongarch: mm: try VMA lock-based page fault handling first

 arch/arm/Kconfig          |  1 +
 arch/arm/mm/fault.c       | 15 ++++++-
 arch/arm64/mm/fault.c     | 28 +++---------
 arch/loongarch/Kconfig    |  1 +
 arch/loongarch/mm/fault.c | 92 ++++++++++++++++++++++++---------------
 arch/powerpc/mm/fault.c   | 54 ++++++++++-------------
 arch/riscv/mm/fault.c     | 38 +++++++---------
 arch/s390/mm/fault.c      | 23 +++-------
 arch/x86/mm/fault.c       | 39 +++++++----------
 include/linux/mm.h        | 28 ++++++++++++
 mm/memory.c               | 42 ++++++++++++++++++
 11 files changed, 206 insertions(+), 155 deletions(-)

-- 
2.27.0

