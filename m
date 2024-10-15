Return-Path: <linux-s390+bounces-6563-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3802099F304
	for <lists+linux-s390@lfdr.de>; Tue, 15 Oct 2024 18:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE851C22323
	for <lists+linux-s390@lfdr.de>; Tue, 15 Oct 2024 16:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7CF206E74;
	Tue, 15 Oct 2024 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WOmJyNX4"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5131F76AF;
	Tue, 15 Oct 2024 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010616; cv=none; b=GpS+oq42Mq7CekX0qOcIxjuMQ9w7gDYGHldsLdJwjV+M7yl4Dqw0d0NTRolLK2VeXDGRF5nQneXwWRdKPS7CgPX809+OQTlpKFyTT4gOqoOZLm2ebdw0Lsg9DZj0RmmEFqLHe55PdaywEBrjCVVvkXyDVUPF7TMz2RRNB60CPc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010616; c=relaxed/simple;
	bh=4RZHkD/NMld5kwpvWmYSzfZX84FVCy70N4g3rhDy0YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLPdv4fgTwRwiiYXdqBnljNSN7VTbyR0mKq00HDgJucUtqEV/LHdQYiiiif0XnJPfjdbk526J5nnIulYMZLzYeot5cvnBOWJ1cZQMPXOGvyKb+TG0NDymp5etZDDxPJ1EG9fImhxydA5oCVlA0/DH90xgIHqViWEM4cHB7P9oA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WOmJyNX4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FDJljK008413;
	Tue, 15 Oct 2024 16:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=T58twZObNsWgOydiw
	mzOuHwP+2qwudqIpsSuKSB+BdM=; b=WOmJyNX4zwfCY523QscXwgAY+Vf2KgYUv
	48Y4oWeTYU14CV33pBM2id0x8vB7fF+iSGvK+fwfZOYQM0ObbMSP5HGW3wEWKrum
	Td2gVv4fjikVp9I6gRYFMtS8alF1G8OofyIGD0dJ1ZBOrYY4yqGthAbaGD7n6g6D
	spJgFIW2WUfshyTYRqkaExR0si49r26YrxBkKevN202hHyITvXvK+S8+eY2MKmWx
	hof7H67GkaXBCBDhx4qSrjaHP4lnOiXMp5GDysywxFz4TjPqhaSiVgpJacfF5NTA
	GI05LlhTgBUmVu7GxZETwsVYUMR1sKDsUsQ4MJcG9Y/Pxz3V4sTTw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429s68h428-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 16:43:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FEMcuW027451;
	Tue, 15 Oct 2024 16:43:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283txn026-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 16:43:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FGhRMe49545574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 16:43:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C887520043;
	Tue, 15 Oct 2024 16:43:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F42020040;
	Tue, 15 Oct 2024 16:43:27 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 16:43:27 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: borntraeger@de.ibm.com, nsg@linux.ibm.com, nrb@linux.ibm.com,
        frankja@linux.ibm.com, seiden@linux.ibm.com, hca@linux.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 05/11] s390/mm/fault: Handle guest-related program interrupts in KVM
Date: Tue, 15 Oct 2024 18:43:20 +0200
Message-ID: <20241015164326.124987-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015164326.124987-1-imbrenda@linux.ibm.com>
References: <20241015164326.124987-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: waekeJLRl87e-dDq8h8EyCnc2aTEHBgI
X-Proofpoint-ORIG-GUID: waekeJLRl87e-dDq8h8EyCnc2aTEHBgI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150113

Any program interrupt that happens in the host during the execution of
a KVM guest will now short circuit the fault handler and return to KVM
immediately. Guest fault handling (including pfault) will happen
entirely inside KVM.

When sie64a() returns zero, current->thread.gmap_int_code will contain
the program interrupt number that caused the exit, or zero if the exit
was not caused by a host program interrupt.

KVM will now take care of handling all guest faults in vcpu_post_run().

Since gmap faults will not be visible by the rest of the kernel, remove
GMAP_FAULT, the linux fault handlers for secure execution faults, the
exception table entries for the sie instruction, the nop padding after
the sie instruction, and all other references to guest faults from the
s390 code.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Co-developed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
[agordeev@linux.ibm.com: remove spurious flags &= ~FAULT_FLAG_RETRY_NOWAIT]
---
 arch/s390/include/asm/kvm_host.h  |   3 +
 arch/s390/include/asm/processor.h |   5 +-
 arch/s390/kernel/entry.S          |  22 ------
 arch/s390/kernel/traps.c          |  23 ++++--
 arch/s390/kvm/kvm-s390.c          | 116 ++++++++++++++++++++++++------
 arch/s390/kvm/kvm-s390.h          |   7 ++
 arch/s390/kvm/vsie.c              |  13 ++--
 arch/s390/mm/fault.c              |  99 +------------------------
 8 files changed, 132 insertions(+), 156 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 8e77afbed58e..603b56bfccd3 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -527,6 +527,9 @@ struct kvm_vcpu_stat {
 #define PGM_REGION_FIRST_TRANS		0x39
 #define PGM_REGION_SECOND_TRANS		0x3a
 #define PGM_REGION_THIRD_TRANS		0x3b
+#define PGM_SECURE_STORAGE_ACCESS	0x3d
+#define PGM_NON_SECURE_STORAGE_ACCESS	0x3e
+#define PGM_SECURE_STORAGE_VIOLATION	0x3f
 #define PGM_MONITOR			0x40
 #define PGM_PER				0x80
 #define PGM_CRYPTO_OPERATION		0x119
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 9a5236acc0a8..8761fd01a9f0 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -39,6 +39,7 @@
 #include <asm/runtime_instr.h>
 #include <asm/irqflags.h>
 #include <asm/alternative.h>
+#include <asm/fault.h>
 
 struct pcpu {
 	unsigned long ec_mask;		/* bit mask for ec_xxx functions */
@@ -187,10 +188,8 @@ struct thread_struct {
 	unsigned long hardirq_timer;		/* task cputime in hardirq context */
 	unsigned long softirq_timer;		/* task cputime in softirq context */
 	const sys_call_ptr_t *sys_call_table;	/* system call table address */
-	unsigned long gmap_addr;		/* address of last gmap fault. */
-	unsigned int gmap_write_flag;		/* gmap fault write indication */
+	union teid gmap_teid;			/* address and flags of last gmap fault */
 	unsigned int gmap_int_code;		/* int code of last gmap fault */
-	unsigned int gmap_pfault;		/* signal of a pending guest pfault */
 	int ufpu_flags;				/* user fpu flags */
 	int kfpu_flags;				/* kernel fpu flags */
 
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 454841229ef4..924bcb71a33f 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -222,17 +222,6 @@ SYM_FUNC_START(__sie64a)
 	lctlg	%c1,%c1,__LC_KERNEL_ASCE(%r14)	# load primary asce
 	lg	%r14,__LC_CURRENT(%r14)
 	mvi	__TI_sie(%r14),0
-# some program checks are suppressing. C code (e.g. do_protection_exception)
-# will rewind the PSW by the ILC, which is often 4 bytes in case of SIE. There
-# are some corner cases (e.g. runtime instrumentation) where ILC is unpredictable.
-# Other instructions between __sie64a and .Lsie_done should not cause program
-# interrupts. So lets use 3 nops as a landing pad for all possible rewinds.
-.Lrewind_pad6:
-	nopr	7
-.Lrewind_pad4:
-	nopr	7
-.Lrewind_pad2:
-	nopr	7
 SYM_INNER_LABEL(sie_exit, SYM_L_GLOBAL)
 	lg	%r14,__SF_SIE_SAVEAREA(%r15)	# load guest register save area
 	stmg	%r0,%r13,0(%r14)		# save guest gprs 0-13
@@ -244,15 +233,6 @@ SYM_INNER_LABEL(sie_exit, SYM_L_GLOBAL)
 	lmg	%r6,%r14,__SF_GPRS(%r15)	# restore kernel registers
 	lg	%r2,__SF_SIE_REASON(%r15)	# return exit reason code
 	BR_EX	%r14
-.Lsie_fault:
-	lghi	%r14,-EFAULT
-	stg	%r14,__SF_SIE_REASON(%r15)	# set exit reason code
-	j	sie_exit
-
-	EX_TABLE(.Lrewind_pad6,.Lsie_fault)
-	EX_TABLE(.Lrewind_pad4,.Lsie_fault)
-	EX_TABLE(.Lrewind_pad2,.Lsie_fault)
-	EX_TABLE(sie_exit,.Lsie_fault)
 SYM_FUNC_END(__sie64a)
 EXPORT_SYMBOL(__sie64a)
 EXPORT_SYMBOL(sie_exit)
@@ -341,7 +321,6 @@ SYM_CODE_START(pgm_check_handler)
 	jz	1f
 	BPENTER	__SF_SIE_FLAGS(%r15),_TIF_ISOLATE_BP_GUEST
 	SIEEXIT __SF_SIE_CONTROL(%r15),%r13
-	lg	%r12,__SF_SIE_GUEST_ASCE(%r15)
 	lghi	%r10,_PIF_GUEST_FAULT
 #endif
 1:	tmhh	%r8,0x4000		# PER bit set in old PSW ?
@@ -355,7 +334,6 @@ SYM_CODE_START(pgm_check_handler)
 3:	lg	%r15,__LC_KERNEL_STACK(%r13)
 4:	la	%r11,STACK_FRAME_OVERHEAD(%r15)
 	stg	%r10,__PT_FLAGS(%r11)
-	stg	%r12,__PT_CR1(%r11)
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	stmg	%r0,%r7,__PT_R0(%r11)
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA(%r13)
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 160b2acba8db..f5e978dfe5bf 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -31,6 +31,7 @@
 #include <asm/asm-extable.h>
 #include <asm/vtime.h>
 #include <asm/fpu.h>
+#include <asm/fault.h>
 #include "entry.h"
 
 static inline void __user *get_trap_ip(struct pt_regs *regs)
@@ -317,9 +318,23 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
 	struct lowcore *lc = get_lowcore();
 	irqentry_state_t state;
 	unsigned int trapnr;
+	union teid teid = { .val = lc->trans_exc_code };
 
 	regs->int_code = lc->pgm_int_code;
-	regs->int_parm_long = lc->trans_exc_code;
+	regs->int_parm_long = teid.val;
+
+	/*
+	 * In case of a guest fault, short-circuit the fault handler and return.
+	 * This way the sie64a() function will return 0; fault address and
+	 * other relevant bits are saved in current->thread.gmap_teid, and
+	 * the fault number in current->thread.gmap_int_code. KVM will be
+	 * able to use this information to handle the fault.
+	 */
+	if (test_pt_regs_flag(regs, PIF_GUEST_FAULT) && (teid.as == PSW_BITS_AS_PRIMARY)) {
+		current->thread.gmap_teid.val = regs->int_parm_long;
+		current->thread.gmap_int_code = regs->int_code & 0xffff;
+		return;
+	}
 
 	state = irqentry_enter(regs);
 
@@ -408,8 +423,8 @@ static void (*pgm_check_table[128])(struct pt_regs *regs) = {
 	[0x3b]		= do_dat_exception,
 	[0x3c]		= default_trap_handler,
 	[0x3d]		= do_secure_storage_access,
-	[0x3e]		= do_non_secure_storage_access,
-	[0x3f]		= do_secure_storage_violation,
+	[0x3e]		= default_trap_handler,
+	[0x3f]		= default_trap_handler,
 	[0x40]		= monitor_event_exception,
 	[0x41 ... 0x7f] = default_trap_handler,
 };
@@ -420,5 +435,3 @@ static void (*pgm_check_table[128])(struct pt_regs *regs) = {
 	__stringify(default_trap_handler))
 
 COND_TRAP(do_secure_storage_access);
-COND_TRAP(do_non_secure_storage_access);
-COND_TRAP(do_secure_storage_violation);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 08f0c80ef5e9..cfe3f8182aa5 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4646,12 +4646,11 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu)
 	if (!vcpu->arch.gmap->pfault_enabled)
 		return false;
 
-	hva = gfn_to_hva(vcpu->kvm, gpa_to_gfn(current->thread.gmap_addr));
-	hva += current->thread.gmap_addr & ~PAGE_MASK;
+	hva = gfn_to_hva(vcpu->kvm, current->thread.gmap_teid.addr);
 	if (read_guest_real(vcpu, vcpu->arch.pfault_token, &arch.pfault_token, 8))
 		return false;
 
-	return kvm_setup_async_pf(vcpu, current->thread.gmap_addr, hva, &arch);
+	return kvm_setup_async_pf(vcpu, current->thread.gmap_teid.addr * PAGE_SIZE, hva, &arch);
 }
 
 static int vcpu_pre_run(struct kvm_vcpu *vcpu)
@@ -4689,6 +4688,7 @@ static int vcpu_pre_run(struct kvm_vcpu *vcpu)
 	clear_bit(vcpu->vcpu_idx, vcpu->kvm->arch.gisa_int.kicked_mask);
 
 	vcpu->arch.sie_block->icptcode = 0;
+	current->thread.gmap_int_code = 0;
 	cpuflags = atomic_read(&vcpu->arch.sie_block->cpuflags);
 	VCPU_EVENT(vcpu, 6, "entering sie flags %x", cpuflags);
 	trace_kvm_s390_sie_enter(vcpu, cpuflags);
@@ -4696,7 +4696,7 @@ static int vcpu_pre_run(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static int vcpu_post_run_fault_in_sie(struct kvm_vcpu *vcpu)
+static int vcpu_post_run_addressing_exception(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_pgm_info pgm_info = {
 		.code = PGM_ADDRESSING,
@@ -4732,10 +4732,97 @@ static int vcpu_post_run_fault_in_sie(struct kvm_vcpu *vcpu)
 	return kvm_s390_inject_prog_irq(vcpu, &pgm_info);
 }
 
+static int vcpu_post_run_handle_fault(struct kvm_vcpu *vcpu)
+{
+	unsigned long gaddr;
+	unsigned int flags;
+	int rc = 0;
+
+	gaddr = current->thread.gmap_teid.addr * PAGE_SIZE;
+	if (kvm_s390_cur_gmap_fault_is_write())
+		flags = FAULT_FLAG_WRITE;
+
+	switch (current->thread.gmap_int_code) {
+	case 0:
+		vcpu->stat.exit_null++;
+		break;
+	case PGM_NON_SECURE_STORAGE_ACCESS:
+		/*
+		 * This is normal operation; a page belonging to a protected
+		 * guest has not been imported yet. Try to import the page into
+		 * the protected guest.
+		 */
+		if (gmap_convert_to_secure(vcpu->arch.gmap, gaddr) == -EINVAL)
+			send_sig(SIGSEGV, current, 0);
+		break;
+	case PGM_SECURE_STORAGE_ACCESS:
+	case PGM_SECURE_STORAGE_VIOLATION:
+		/*
+		 * This can happen after a reboot with asynchronous teardown;
+		 * the new guest (normal or protected) will run on top of the
+		 * previous protected guest. The old pages need to be destroyed
+		 * so the new guest can use them.
+		 */
+		if (gmap_destroy_page(vcpu->arch.gmap, gaddr)) {
+			/*
+			 * Either KVM messed up the secure guest mapping or the
+			 * same page is mapped into multiple secure guests.
+			 *
+			 * This exception is only triggered when a guest 2 is
+			 * running and can therefore never occur in kernel
+			 * context.
+			 */
+			pr_warn_ratelimited("Secure storage violation (%x) in task: %s, pid %d\n",
+					    current->thread.gmap_int_code, current->comm,
+					    current->pid);
+			send_sig(SIGSEGV, current, 0);
+		}
+		break;
+	case PGM_PROTECTION:
+	case PGM_SEGMENT_TRANSLATION:
+	case PGM_PAGE_TRANSLATION:
+	case PGM_ASCE_TYPE:
+	case PGM_REGION_FIRST_TRANS:
+	case PGM_REGION_SECOND_TRANS:
+	case PGM_REGION_THIRD_TRANS:
+		if (vcpu->arch.gmap->pfault_enabled) {
+			rc = gmap_fault(vcpu->arch.gmap, gaddr, flags | FAULT_FLAG_RETRY_NOWAIT);
+			if (rc == -EFAULT)
+				return vcpu_post_run_addressing_exception(vcpu);
+			if (rc == -EAGAIN) {
+				trace_kvm_s390_major_guest_pfault(vcpu);
+				if (kvm_arch_setup_async_pf(vcpu))
+					return 0;
+				vcpu->stat.pfault_sync++;
+			} else {
+				return rc;
+			}
+		}
+		rc = gmap_fault(vcpu->arch.gmap, gaddr, flags);
+		if (rc == -EFAULT) {
+			if (kvm_is_ucontrol(vcpu->kvm)) {
+				vcpu->run->exit_reason = KVM_EXIT_S390_UCONTROL;
+				vcpu->run->s390_ucontrol.trans_exc_code = gaddr;
+				vcpu->run->s390_ucontrol.pgm_code = 0x10;
+				return -EREMOTE;
+			}
+			return vcpu_post_run_addressing_exception(vcpu);
+		}
+		break;
+	default:
+		KVM_BUG(1, vcpu->kvm, "Unexpected program interrupt 0x%x, TEID 0x%016lx",
+			current->thread.gmap_int_code, current->thread.gmap_teid.val);
+		send_sig(SIGSEGV, current, 0);
+		break;
+	}
+	return rc;
+}
+
 static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 {
 	struct mcck_volatile_info *mcck_info;
 	struct sie_page *sie_page;
+	int rc;
 
 	VCPU_EVENT(vcpu, 6, "exit sie icptcode %d",
 		   vcpu->arch.sie_block->icptcode);
@@ -4757,7 +4844,7 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 	}
 
 	if (vcpu->arch.sie_block->icptcode > 0) {
-		int rc = kvm_handle_sie_intercept(vcpu);
+		rc = kvm_handle_sie_intercept(vcpu);
 
 		if (rc != -EOPNOTSUPP)
 			return rc;
@@ -4766,24 +4853,9 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 		vcpu->run->s390_sieic.ipa = vcpu->arch.sie_block->ipa;
 		vcpu->run->s390_sieic.ipb = vcpu->arch.sie_block->ipb;
 		return -EREMOTE;
-	} else if (exit_reason != -EFAULT) {
-		vcpu->stat.exit_null++;
-		return 0;
-	} else if (kvm_is_ucontrol(vcpu->kvm)) {
-		vcpu->run->exit_reason = KVM_EXIT_S390_UCONTROL;
-		vcpu->run->s390_ucontrol.trans_exc_code =
-						current->thread.gmap_addr;
-		vcpu->run->s390_ucontrol.pgm_code = 0x10;
-		return -EREMOTE;
-	} else if (current->thread.gmap_pfault) {
-		trace_kvm_s390_major_guest_pfault(vcpu);
-		current->thread.gmap_pfault = 0;
-		if (kvm_arch_setup_async_pf(vcpu))
-			return 0;
-		vcpu->stat.pfault_sync++;
-		return gmap_fault(vcpu->arch.gmap, current->thread.gmap_addr, FAULT_FLAG_WRITE);
 	}
-	return vcpu_post_run_fault_in_sie(vcpu);
+
+	return vcpu_post_run_handle_fault(vcpu);
 }
 
 #define PSW_INT_MASK (PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_MCHECK)
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 0765ad1031c4..597d7a71deeb 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -528,6 +528,13 @@ static inline int kvm_s390_use_sca_entries(void)
 void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
 				     struct mcck_volatile_info *mcck_info);
 
+static inline bool kvm_s390_cur_gmap_fault_is_write(void)
+{
+	if (current->thread.gmap_int_code == PGM_PROTECTION)
+		return true;
+	return test_facility(75) && (current->thread.gmap_teid.fsi == TEID_FSI_STORE);
+}
+
 /**
  * kvm_s390_vcpu_crypto_reset_all
  *
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 89cafea4c41f..35e7dd882148 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -925,16 +925,16 @@ static int handle_fault(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	if (current->thread.gmap_int_code == PGM_PROTECTION)
 		/* we can directly forward all protection exceptions */
 		return inject_fault(vcpu, PGM_PROTECTION,
-				    current->thread.gmap_addr, 1);
+				    current->thread.gmap_teid.addr * PAGE_SIZE, 1);
 
 	rc = kvm_s390_shadow_fault(vcpu, vsie_page->gmap,
-				   current->thread.gmap_addr, NULL);
+				   current->thread.gmap_teid.addr * PAGE_SIZE, NULL);
 	if (rc > 0) {
 		rc = inject_fault(vcpu, rc,
-				  current->thread.gmap_addr,
-				  current->thread.gmap_write_flag);
+				  current->thread.gmap_teid.addr * PAGE_SIZE,
+				  kvm_s390_cur_gmap_fault_is_write());
 		if (rc >= 0)
-			vsie_page->fault_addr = current->thread.gmap_addr;
+			vsie_page->fault_addr = current->thread.gmap_teid.addr * PAGE_SIZE;
 	}
 	return rc;
 }
@@ -1148,6 +1148,7 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	 * also kick the vSIE.
 	 */
 	vcpu->arch.sie_block->prog0c |= PROG_IN_SIE;
+	current->thread.gmap_int_code = 0;
 	barrier();
 	if (!kvm_s390_vcpu_sie_inhibited(vcpu))
 		rc = sie64a(scb_s, vcpu->run->s.regs.gprs, gmap_get_enabled()->asce);
@@ -1172,7 +1173,7 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	if (rc > 0)
 		rc = 0; /* we could still have an icpt */
-	else if (rc == -EFAULT)
+	else if (current->thread.gmap_int_code)
 		return handle_fault(vcpu, vsie_page);
 
 	switch (scb_s->icptcode) {
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index a6cf33b0f339..e48910b0b816 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -49,7 +49,6 @@
 enum fault_type {
 	KERNEL_FAULT,
 	USER_FAULT,
-	GMAP_FAULT,
 };
 
 static DEFINE_STATIC_KEY_FALSE(have_store_indication);
@@ -72,10 +71,6 @@ static enum fault_type get_fault_type(struct pt_regs *regs)
 	if (likely(teid.as == PSW_BITS_AS_PRIMARY)) {
 		if (user_mode(regs))
 			return USER_FAULT;
-		if (!IS_ENABLED(CONFIG_PGSTE))
-			return KERNEL_FAULT;
-		if (test_pt_regs_flag(regs, PIF_GUEST_FAULT))
-			return GMAP_FAULT;
 		return KERNEL_FAULT;
 	}
 	if (teid.as == PSW_BITS_AS_SECONDARY)
@@ -184,10 +179,6 @@ static void dump_fault_info(struct pt_regs *regs)
 		asce = get_lowcore()->user_asce.val;
 		pr_cont("user ");
 		break;
-	case GMAP_FAULT:
-		asce = regs->cr1;
-		pr_cont("gmap ");
-		break;
 	case KERNEL_FAULT:
 		asce = get_lowcore()->kernel_asce.val;
 		pr_cont("kernel ");
@@ -285,7 +276,6 @@ static void do_exception(struct pt_regs *regs, int access)
 	struct mm_struct *mm;
 	enum fault_type type;
 	unsigned int flags;
-	struct gmap *gmap;
 	vm_fault_t fault;
 	bool is_write;
 
@@ -304,7 +294,6 @@ static void do_exception(struct pt_regs *regs, int access)
 	case KERNEL_FAULT:
 		return handle_fault_error_nolock(regs, 0);
 	case USER_FAULT:
-	case GMAP_FAULT:
 		if (faulthandler_disabled() || !mm)
 			return handle_fault_error_nolock(regs, 0);
 		break;
@@ -348,18 +337,6 @@ static void do_exception(struct pt_regs *regs, int access)
 	}
 lock_mmap:
 	mmap_read_lock(mm);
-	gmap = NULL;
-	if (IS_ENABLED(CONFIG_PGSTE) && type == GMAP_FAULT) {
-		gmap = (struct gmap *)get_lowcore()->gmap;
-		current->thread.gmap_addr = address;
-		current->thread.gmap_write_flag = !!(flags & FAULT_FLAG_WRITE);
-		current->thread.gmap_int_code = regs->int_code & 0xffff;
-		address = __gmap_translate(gmap, address);
-		if (address == -EFAULT)
-			return handle_fault_error(regs, SEGV_MAPERR);
-		if (gmap->pfault_enabled)
-			flags |= FAULT_FLAG_RETRY_NOWAIT;
-	}
 retry:
 	vma = find_vma(mm, address);
 	if (!vma)
@@ -375,50 +352,22 @@ static void do_exception(struct pt_regs *regs, int access)
 		return handle_fault_error(regs, SEGV_ACCERR);
 	fault = handle_mm_fault(vma, address, flags, regs);
 	if (fault_signal_pending(fault, regs)) {
-		if (flags & FAULT_FLAG_RETRY_NOWAIT)
-			mmap_read_unlock(mm);
 		if (!user_mode(regs))
 			handle_fault_error_nolock(regs, 0);
 		return;
 	}
 	/* The fault is fully completed (including releasing mmap lock) */
-	if (fault & VM_FAULT_COMPLETED) {
-		if (gmap) {
-			mmap_read_lock(mm);
-			goto gmap;
-		}
+	if (fault & VM_FAULT_COMPLETED)
 		return;
-	}
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		mmap_read_unlock(mm);
 		goto error;
 	}
 	if (fault & VM_FAULT_RETRY) {
-		if (IS_ENABLED(CONFIG_PGSTE) && gmap &&	(flags & FAULT_FLAG_RETRY_NOWAIT)) {
-			/*
-			 * FAULT_FLAG_RETRY_NOWAIT has been set,
-			 * mmap_lock has not been released
-			 */
-			current->thread.gmap_pfault = 1;
-			return handle_fault_error(regs, 0);
-		}
-		flags &= ~FAULT_FLAG_RETRY_NOWAIT;
 		flags |= FAULT_FLAG_TRIED;
 		mmap_read_lock(mm);
 		goto retry;
 	}
-gmap:
-	if (IS_ENABLED(CONFIG_PGSTE) && gmap) {
-		address =  __gmap_link(gmap, current->thread.gmap_addr,
-				       address);
-		if (address == -EFAULT)
-			return handle_fault_error(regs, SEGV_MAPERR);
-		if (address == -ENOMEM) {
-			fault = VM_FAULT_OOM;
-			mmap_read_unlock(mm);
-			goto error;
-		}
-	}
 	mmap_read_unlock(mm);
 	return;
 error:
@@ -494,7 +443,6 @@ void do_secure_storage_access(struct pt_regs *regs)
 	struct folio_walk fw;
 	struct mm_struct *mm;
 	struct folio *folio;
-	struct gmap *gmap;
 	int rc;
 
 	/*
@@ -520,15 +468,6 @@ void do_secure_storage_access(struct pt_regs *regs)
 		panic("Unexpected PGM 0x3d with TEID bit 61=0");
 	}
 	switch (get_fault_type(regs)) {
-	case GMAP_FAULT:
-		mm = current->mm;
-		gmap = (struct gmap *)get_lowcore()->gmap;
-		mmap_read_lock(mm);
-		addr = __gmap_translate(gmap, addr);
-		mmap_read_unlock(mm);
-		if (IS_ERR_VALUE(addr))
-			return handle_fault_error_nolock(regs, SEGV_MAPERR);
-		fallthrough;
 	case USER_FAULT:
 		mm = current->mm;
 		mmap_read_lock(mm);
@@ -564,40 +503,4 @@ void do_secure_storage_access(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(do_secure_storage_access);
 
-void do_non_secure_storage_access(struct pt_regs *regs)
-{
-	struct gmap *gmap = (struct gmap *)get_lowcore()->gmap;
-	unsigned long gaddr = get_fault_address(regs);
-
-	if (WARN_ON_ONCE(get_fault_type(regs) != GMAP_FAULT))
-		return handle_fault_error_nolock(regs, SEGV_MAPERR);
-	if (gmap_convert_to_secure(gmap, gaddr) == -EINVAL)
-		send_sig(SIGSEGV, current, 0);
-}
-NOKPROBE_SYMBOL(do_non_secure_storage_access);
-
-void do_secure_storage_violation(struct pt_regs *regs)
-{
-	struct gmap *gmap = (struct gmap *)get_lowcore()->gmap;
-	unsigned long gaddr = get_fault_address(regs);
-
-	/*
-	 * If the VM has been rebooted, its address space might still contain
-	 * secure pages from the previous boot.
-	 * Clear the page so it can be reused.
-	 */
-	if (!gmap_destroy_page(gmap, gaddr))
-		return;
-	/*
-	 * Either KVM messed up the secure guest mapping or the same
-	 * page is mapped into multiple secure guests.
-	 *
-	 * This exception is only triggered when a guest 2 is running
-	 * and can therefore never occur in kernel context.
-	 */
-	pr_warn_ratelimited("Secure storage violation in task: %s, pid %d\n",
-			    current->comm, current->pid);
-	send_sig(SIGSEGV, current, 0);
-}
-
 #endif /* CONFIG_PGSTE */
-- 
2.47.0


