Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4815D782917
	for <lists+linux-s390@lfdr.de>; Mon, 21 Aug 2023 14:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbjHUMb1 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 21 Aug 2023 08:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbjHUMbX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Aug 2023 08:31:23 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50999CC;
        Mon, 21 Aug 2023 05:31:20 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RTsHg0Sf6z1L9Pp;
        Mon, 21 Aug 2023 20:29:51 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 20:31:16 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <surenb@google.com>, <willy@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
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
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <linux-s390@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfc v2 04/10] s390: mm: use try_vma_locked_page_fault()
Date:   Mon, 21 Aug 2023 20:30:50 +0800
Message-ID: <20230821123056.2109942-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230821123056.2109942-1-wangkefeng.wang@huawei.com>
References: <20230821123056.2109942-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use new try_vma_locked_page_fault() helper to simplify code.
No functional change intended.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/s390/mm/fault.c | 66 ++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 39 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 099c4824dd8a..fbbdebde6ea7 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -357,16 +357,18 @@ static noinline void do_fault_error(struct pt_regs *regs, vm_fault_t fault)
 static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 {
 	struct gmap *gmap;
-	struct task_struct *tsk;
-	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	enum fault_type type;
-	unsigned long address;
-	unsigned int flags;
+	struct mm_struct *mm = current->mm;
+	unsigned long address = get_fault_address(regs);
 	vm_fault_t fault;
 	bool is_write;
+	struct vm_fault vmf = {
+		.real_address = address,
+		.flags = FAULT_FLAG_DEFAULT,
+		.vm_flags = access,
+	};
 
-	tsk = current;
 	/*
 	 * The instruction that caused the program check has
 	 * been nullified. Don't signal single step via SIGTRAP.
@@ -376,8 +378,6 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	if (kprobe_page_fault(regs, 14))
 		return 0;
 
-	mm = tsk->mm;
-	address = get_fault_address(regs);
 	is_write = fault_is_write(regs);
 
 	/*
@@ -398,45 +398,33 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	}
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
-	flags = FAULT_FLAG_DEFAULT;
 	if (user_mode(regs))
-		flags |= FAULT_FLAG_USER;
+		vmf.flags |= FAULT_FLAG_USER;
 	if (is_write)
-		access = VM_WRITE;
-	if (access == VM_WRITE)
-		flags |= FAULT_FLAG_WRITE;
-	if (!(flags & FAULT_FLAG_USER))
-		goto lock_mmap;
-	vma = lock_vma_under_rcu(mm, address);
-	if (!vma)
-		goto lock_mmap;
-	if (!(vma->vm_flags & access)) {
-		vma_end_read(vma);
-		goto lock_mmap;
-	}
-	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
-	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
-		vma_end_read(vma);
-	if (!(fault & VM_FAULT_RETRY)) {
-		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
-		if (likely(!(fault & VM_FAULT_ERROR)))
-			fault = 0;
+		vmf.vm_flags = VM_WRITE;
+	if (vmf.vm_flags == VM_WRITE)
+		vmf.flags |= FAULT_FLAG_WRITE;
+
+	fault = try_vma_locked_page_fault(&vmf);
+	if (fault == VM_FAULT_NONE)
+		goto lock_mm;
+	if (!(fault & VM_FAULT_RETRY))
 		goto out;
-	}
-	count_vm_vma_lock_event(VMA_LOCK_RETRY);
+
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
 		fault = VM_FAULT_SIGNAL;
 		goto out;
 	}
-lock_mmap:
+
+lock_mm:
 	mmap_read_lock(mm);
 
 	gmap = NULL;
 	if (IS_ENABLED(CONFIG_PGSTE) && type == GMAP_FAULT) {
 		gmap = (struct gmap *) S390_lowcore.gmap;
 		current->thread.gmap_addr = address;
-		current->thread.gmap_write_flag = !!(flags & FAULT_FLAG_WRITE);
+		current->thread.gmap_write_flag = !!(vmf.flags & FAULT_FLAG_WRITE);
 		current->thread.gmap_int_code = regs->int_code & 0xffff;
 		address = __gmap_translate(gmap, address);
 		if (address == -EFAULT) {
@@ -444,7 +432,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 			goto out_up;
 		}
 		if (gmap->pfault_enabled)
-			flags |= FAULT_FLAG_RETRY_NOWAIT;
+			vmf.flags |= FAULT_FLAG_RETRY_NOWAIT;
 	}
 
 retry:
@@ -466,7 +454,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	 * we can handle it..
 	 */
 	fault = VM_FAULT_BADACCESS;
-	if (unlikely(!(vma->vm_flags & access)))
+	if (unlikely(!(vma->vm_flags & vmf.vm_flags)))
 		goto out_up;
 
 	/*
@@ -474,10 +462,10 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, regs);
+	fault = handle_mm_fault(vma, address, vmf.flags, regs);
 	if (fault_signal_pending(fault, regs)) {
 		fault = VM_FAULT_SIGNAL;
-		if (flags & FAULT_FLAG_RETRY_NOWAIT)
+		if (vmf.flags & FAULT_FLAG_RETRY_NOWAIT)
 			goto out_up;
 		goto out;
 	}
@@ -497,7 +485,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 
 	if (fault & VM_FAULT_RETRY) {
 		if (IS_ENABLED(CONFIG_PGSTE) && gmap &&
-			(flags & FAULT_FLAG_RETRY_NOWAIT)) {
+			(vmf.flags & FAULT_FLAG_RETRY_NOWAIT)) {
 			/*
 			 * FAULT_FLAG_RETRY_NOWAIT has been set, mmap_lock has
 			 * not been released
@@ -506,8 +494,8 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 			fault = VM_FAULT_PFAULT;
 			goto out_up;
 		}
-		flags &= ~FAULT_FLAG_RETRY_NOWAIT;
-		flags |= FAULT_FLAG_TRIED;
+		vmf.flags &= ~FAULT_FLAG_RETRY_NOWAIT;
+		vmf.flags |= FAULT_FLAG_TRIED;
 		mmap_read_lock(mm);
 		goto retry;
 	}
-- 
2.27.0

