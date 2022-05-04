Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E00519751
	for <lists+linux-s390@lfdr.de>; Wed,  4 May 2022 08:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344906AbiEDG2J (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 4 May 2022 02:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiEDG2I (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 May 2022 02:28:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6AA1928D;
        Tue,  3 May 2022 23:24:31 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2446KaRt024473;
        Wed, 4 May 2022 06:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4peIxgeC2GMG9EApjRY1a4AhCNTXNzpV+8n5kJHmMdk=;
 b=b2XY8WvnJtQtiPioe+4mt4/a3INNZ+alVWM694AagWxgBtFo3nYiVj3Z3heko7ja1n+n
 pUdoyLP7ExCrTcoSFe2lzYctT/9IaQRz7vP7WhQw9mICIaIkN+WHiOTXpBN8nyl3BdbG
 sVBqYyRof3mhLu99eOaXg0UhzJ+Agwb/PX8YeDHSw22qppZfJLrXamP6uBiTU9lDEE1f
 eLv3cn2i8RLMb5vKpHw/ECUVN+RnflqEn3Fm+mtdg96knive4OkWvQJTVHvLCPYGpF/T
 gusyze07hmTZdPeiR7JoTQwPCMx8ESaAOKVSv961ZamY/5S+GtSdw1hugcYdd0tqI88M Dg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fum4u811m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 06:24:31 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2446IYKG030705;
        Wed, 4 May 2022 06:24:28 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3frvr8w5bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 06:24:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2446OPMU49217808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 May 2022 06:24:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72476AE045;
        Wed,  4 May 2022 06:24:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32EB1AE051;
        Wed,  4 May 2022 06:24:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 May 2022 06:24:25 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Subject: [PATCH 2/2] s390/pai: Add support for cryptography counters
Date:   Wed,  4 May 2022 08:23:51 +0200
Message-Id: <20220504062351.2954280-3-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504062351.2954280-1-tmricht@linux.ibm.com>
References: <20220504062351.2954280-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: biP_d0nXvLimUn98nlEavyUGNniQ3SiH
X-Proofpoint-GUID: biP_d0nXvLimUn98nlEavyUGNniQ3SiH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_01,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

PMU device driver perf_pai_crypto supports Processor Activity
Instrumentation (PAI), available with IBM z16:
- maps a full page to lowcore address 0x1500.
- uses CR0 bit 13 to turn PAI crypto counting on and off.
- creates a sample with raw data on each context switch out when
  at context switch some mapped counters have a value of nonzero.
This device driver only supports CPU wide context, no task context
is allowed.

Support for counting:
- one or more counters can be specified using
  perf stat -e pai_crypto/xxx/
  where xxx stands for the counter event name. Multiple invocation
  of this command is possible. The counter names are listed in
  /sys/devices/pai_crypto/events directory.
- one special counters can be specified using
  perf stat -e pai_crypto/CRYPTO_ALL/
  which returns the sum of all incremented crypto counters.
- one event pai_crypto/CRYPTO_ALL/ is reserved for sampling.
  No multiple invocations are possible. The event collects data at
  context switch out and saves them in the ring buffer.

Add qpaci assembly instruction to query supported memory mapped crypto
counters. It returns the number of counters (no holes allowed in that
range).

The PAI crypto counter events are system wide and can not be executed
in parallel. Therefore some restrictions documented in function
paicrypt_busy apply.
In particular event CRYPTO_ALL for sampling must run exclusive.
Only counting events can run in parallel.

PAI crypto counter events can not be created when a CPU hot plug
add is processed. This means a CPU hot plug add does not get
the necessary PAI event to record PAI cryptography counter increments
on the newly added CPU. CPU hot plug remove removes the event and
terminates the counting of PAI counters immediately.

Co-developed-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 arch/s390/include/asm/ctl_reg.h      |   4 +-
 arch/s390/include/asm/entry-common.h |  10 +-
 arch/s390/include/asm/lowcore.h      |   5 +-
 arch/s390/include/asm/nmi.h          |   2 +-
 arch/s390/include/asm/pai.h          |  74 +++
 arch/s390/kernel/Makefile            |   1 +
 arch/s390/kernel/entry.S             |   1 +
 arch/s390/kernel/nmi.c               |   6 +-
 arch/s390/kernel/perf_pai_crypto.c   | 688 +++++++++++++++++++++++++++
 9 files changed, 784 insertions(+), 7 deletions(-)
 create mode 100644 arch/s390/include/asm/pai.h
 create mode 100644 arch/s390/kernel/perf_pai_crypto.c

diff --git a/arch/s390/include/asm/ctl_reg.h b/arch/s390/include/asm/ctl_reg.h
index 82388da3f95f..267a8f88e143 100644
--- a/arch/s390/include/asm/ctl_reg.h
+++ b/arch/s390/include/asm/ctl_reg.h
@@ -93,7 +93,9 @@ union ctlreg0 {
 		unsigned long tcx  : 1;	/* Transactional-Execution control */
 		unsigned long pifo : 1;	/* Transactional-Execution Program-
 					   Interruption-Filtering Override */
-		unsigned long	   : 22;
+		unsigned long	   : 3;
+		unsigned long ccc  : 1; /* Cryptography counter control */
+		unsigned long	   : 18;
 		unsigned long	   : 3;
 		unsigned long lap  : 1; /* Low-address-protection control */
 		unsigned long	   : 4;
diff --git a/arch/s390/include/asm/entry-common.h b/arch/s390/include/asm/entry-common.h
index 99d654ccd3db..000de2b1e67a 100644
--- a/arch/s390/include/asm/entry-common.h
+++ b/arch/s390/include/asm/entry-common.h
@@ -9,19 +9,21 @@
 #include <linux/uaccess.h>
 #include <asm/timex.h>
 #include <asm/fpu/api.h>
+#include <asm/pai.h>
 
 #define ARCH_EXIT_TO_USER_MODE_WORK (_TIF_GUARDED_STORAGE | _TIF_PER_TRAP)
 
 void do_per_trap(struct pt_regs *regs);
 
-#ifdef CONFIG_DEBUG_ENTRY
 static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
 {
-	debug_user_asce(0);
+	if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
+		debug_user_asce(0);
+
+	pai_kernel_enter(regs);
 }
 
 #define arch_enter_from_user_mode arch_enter_from_user_mode
-#endif /* CONFIG_DEBUG_ENTRY */
 
 static __always_inline void arch_exit_to_user_mode_work(struct pt_regs *regs,
 							unsigned long ti_work)
@@ -44,6 +46,8 @@ static __always_inline void arch_exit_to_user_mode(void)
 
 	if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 		debug_user_asce(1);
+
+	pai_kernel_exit(current_pt_regs());
 }
 
 #define arch_exit_to_user_mode arch_exit_to_user_mode
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index 56002aeacabf..26fe5e535728 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -200,7 +200,10 @@ struct lowcore {
 	__u64	last_break_save_area;		/* 0x1338 */
 	__u32	access_regs_save_area[16];	/* 0x1340 */
 	__u64	cregs_save_area[16];		/* 0x1380 */
-	__u8	pad_0x1400[0x1800-0x1400];	/* 0x1400 */
+	__u8	pad_0x1400[0x1500-0x1400];	/* 0x1400 */
+	/* Cryptography-counter designation */
+	__u64	ccd;				/* 0x1500 */
+	__u8	pad_0x1508[0x1800-0x1508];	/* 0x1508 */
 
 	/* Transaction abort diagnostic block */
 	struct pgm_tdb pgm_tdb;			/* 0x1800 */
diff --git a/arch/s390/include/asm/nmi.h b/arch/s390/include/asm/nmi.h
index 292083083830..af1cd3a6f406 100644
--- a/arch/s390/include/asm/nmi.h
+++ b/arch/s390/include/asm/nmi.h
@@ -101,7 +101,7 @@ void nmi_alloc_mcesa_early(u64 *mcesad);
 int nmi_alloc_mcesa(u64 *mcesad);
 void nmi_free_mcesa(u64 *mcesad);
 
-void s390_handle_mcck(void);
+void s390_handle_mcck(struct pt_regs *regs);
 void __s390_handle_mcck(void);
 int s390_do_machine_check(struct pt_regs *regs);
 
diff --git a/arch/s390/include/asm/pai.h b/arch/s390/include/asm/pai.h
new file mode 100644
index 000000000000..5b7e33ac6f0b
--- /dev/null
+++ b/arch/s390/include/asm/pai.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Processor Activity Instrumentation support for cryptography counters
+ *
+ *  Copyright IBM Corp. 2022
+ *  Author(s): Thomas Richter <tmricht@linux.ibm.com>
+ */
+#ifndef _ASM_S390_PAI_H
+#define _ASM_S390_PAI_H
+
+#include <linux/jump_label.h>
+#include <asm/lowcore.h>
+#include <asm/ptrace.h>
+
+struct qpaci_info_block {
+	u64 header;
+	struct {
+		u64 : 8;
+		u64 num_cc : 8;	/* # of supported crypto counters */
+		u64 : 48;
+	};
+};
+
+static inline int qpaci(struct qpaci_info_block *info)
+{
+	/* Size of info (in double words minus one) */
+	size_t size = sizeof(*info) / sizeof(u64) - 1;
+	int cc;
+
+	asm volatile(
+		"	lgr	0,%[size]\n"
+		"	.insn	s,0xb28f0000,%[info]\n"
+		"	lgr	%[size],0\n"
+		"	ipm	%[cc]\n"
+		"	srl	%[cc],28\n"
+		: [cc] "=d" (cc), [info] "=Q" (*info), [size] "+&d" (size)
+		:
+		: "0", "cc", "memory");
+	return cc ? (size + 1) * sizeof(u64) : 0;
+}
+
+#define PAI_CRYPTO_BASE			0x1000	/* First event number */
+#define PAI_CRYPTO_MAXCTR		256	/* Max # of event counters */
+#define PAI_CRYPTO_KERNEL_OFFSET	2048
+
+DECLARE_STATIC_KEY_FALSE(pai_key);
+
+static __always_inline void pai_kernel_enter(struct pt_regs *regs)
+{
+	if (!IS_ENABLED(CONFIG_PERF_EVENTS))
+		return;
+	if (!static_branch_unlikely(&pai_key))
+		return;
+	if (!S390_lowcore.ccd)
+		return;
+	if (!user_mode(regs))
+		return;
+	WRITE_ONCE(S390_lowcore.ccd, S390_lowcore.ccd | PAI_CRYPTO_KERNEL_OFFSET);
+}
+
+static __always_inline void pai_kernel_exit(struct pt_regs *regs)
+{
+	if (!IS_ENABLED(CONFIG_PERF_EVENTS))
+		return;
+	if (!static_branch_unlikely(&pai_key))
+		return;
+	if (!S390_lowcore.ccd)
+		return;
+	if (!user_mode(regs))
+		return;
+	WRITE_ONCE(S390_lowcore.ccd, S390_lowcore.ccd & ~PAI_CRYPTO_KERNEL_OFFSET);
+}
+
+#endif
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index c8d1b6aa823e..5851041bb214 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_cpum_cf_common.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_cpum_cf.o perf_cpum_sf.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_cpum_cf_events.o perf_regs.o
+obj-$(CONFIG_PERF_EVENTS)	+= perf_pai_crypto.o
 
 obj-$(CONFIG_TRACEPOINTS)	+= trace.o
 obj-$(findstring y, $(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) $(CONFIG_PGSTE))	+= uv.o
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 59b69c8ab5e1..e3d1e01a37ea 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -602,6 +602,7 @@ ENTRY(mcck_int_handler)
 	mvc	STACK_FRAME_OVERHEAD(__PT_SIZE,%r1),0(%r11)
 	xc	__SF_BACKCHAIN(8,%r1),__SF_BACKCHAIN(%r1)
 	la	%r11,STACK_FRAME_OVERHEAD(%r1)
+	lgr	%r2,%r11
 	lgr	%r15,%r1
 	brasl	%r14,s390_handle_mcck
 .Lmcck_return:
diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index fc60e29b8690..53ed3884fe64 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -29,6 +29,8 @@
 #include <asm/switch_to.h>
 #include <asm/ctl_reg.h>
 #include <asm/asm-offsets.h>
+#include <asm/pai.h>
+
 #include <linux/kvm_host.h>
 
 struct mcck_struct {
@@ -169,10 +171,12 @@ void __s390_handle_mcck(void)
 	}
 }
 
-void noinstr s390_handle_mcck(void)
+void noinstr s390_handle_mcck(struct pt_regs *regs)
 {
 	trace_hardirqs_off();
+	pai_kernel_enter(regs);
 	__s390_handle_mcck();
+	pai_kernel_exit(regs);
 	trace_hardirqs_on();
 }
 /*
diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
new file mode 100644
index 000000000000..8c1545946d85
--- /dev/null
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -0,0 +1,688 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Performance event support - Processor Activity Instrumentation Facility
+ *
+ *  Copyright IBM Corp. 2022
+ *  Author(s): Thomas Richter <tmricht@linux.ibm.com>
+ */
+#define KMSG_COMPONENT	"pai_crypto"
+#define pr_fmt(fmt)	KMSG_COMPONENT ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/kernel_stat.h>
+#include <linux/percpu.h>
+#include <linux/notifier.h>
+#include <linux/init.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/perf_event.h>
+
+#include <asm/ctl_reg.h>
+#include <asm/pai.h>
+#include <asm/debug.h>
+
+static debug_info_t *cfm_dbg;
+static unsigned int paicrypt_cnt;	/* Size of the mapped counter sets */
+					/* extracted with QPACI instruction */
+
+DEFINE_STATIC_KEY_FALSE(pai_key);
+
+struct pai_userdata {
+	u16 num;
+	u64 value;
+} __packed;
+
+struct paicrypt_map {
+	unsigned long *page;		/* Page for CPU to store counters */
+	struct pai_userdata *save;	/* Page to store no-zero counters */
+	unsigned int users;		/* # of PAI crypto users */
+	unsigned int sampler;		/* # of PAI crypto samplers */
+	unsigned int counter;		/* # of PAI crypto counters */
+	struct perf_event *event;	/* Perf event for sampling */
+};
+
+static DEFINE_PER_CPU(struct paicrypt_map, paicrypt_map);
+
+/* Release the PMU if event is the last perf event */
+static DEFINE_MUTEX(pai_reserve_mutex);
+
+/* Adjust usage counters and remove allocated memory when all users are
+ * gone.
+ */
+static void paicrypt_event_destroy(struct perf_event *event)
+{
+	struct paicrypt_map *cpump = per_cpu_ptr(&paicrypt_map, event->cpu);
+
+	cpump->event = NULL;
+	static_branch_dec(&pai_key);
+	mutex_lock(&pai_reserve_mutex);
+	if (event->attr.sample_period)
+		cpump->sampler -= 1;
+	else
+		cpump->counter -= 1;
+	debug_sprintf_event(cfm_dbg, 5, "%s event %#llx cpu %d"
+			    " sampler %d counter %d\n", __func__,
+			    event->attr.config, event->cpu, cpump->sampler,
+			    cpump->counter);
+	if (!cpump->counter && !cpump->sampler) {
+		debug_sprintf_event(cfm_dbg, 4, "%s page %#lx save %p\n",
+				    __func__, (unsigned long)cpump->page,
+				    cpump->save);
+		free_page((unsigned long)cpump->page);
+		cpump->page = NULL;
+		kvfree(cpump->save);
+		cpump->save = NULL;
+	}
+	mutex_unlock(&pai_reserve_mutex);
+}
+
+static u64 paicrypt_getctr(struct paicrypt_map *cpump, int nr, bool kernel)
+{
+	if (kernel)
+		nr += PAI_CRYPTO_MAXCTR;
+	return cpump->page[nr];
+}
+
+/* Read the counter values. Return value from location in CMP. For event
+ * CRYPTO_ALL sum up all events.
+ */
+static u64 paicrypt_getdata(struct perf_event *event, bool kernel)
+{
+	struct paicrypt_map *cpump = this_cpu_ptr(&paicrypt_map);
+	u64 sum = 0;
+	int i;
+
+	if (event->attr.config != PAI_CRYPTO_BASE) {
+		return paicrypt_getctr(cpump,
+				       event->attr.config - PAI_CRYPTO_BASE,
+				       kernel);
+	}
+
+	for (i = 1; i <= paicrypt_cnt; i++) {
+		u64 val = paicrypt_getctr(cpump, i, kernel);
+
+		if (!val)
+			continue;
+		sum += val;
+	}
+	return sum;
+}
+
+static u64 paicrypt_getall(struct perf_event *event)
+{
+	u64 sum = 0;
+
+	if (!event->attr.exclude_kernel)
+		sum += paicrypt_getdata(event, true);
+	if (!event->attr.exclude_user)
+		sum += paicrypt_getdata(event, false);
+
+	return sum;
+}
+
+/* Used to avoid races in checking concurrent access of counting and
+ * sampling for crypto events
+ *
+ * Only one instance of event pai_crypto/CRYPTO_ALL/ for sampling is
+ * allowed and when this event is running, no counting event is allowed.
+ * Several counting events are allowed in parallel, but no sampling event
+ * is allowed while one (or more) counting events are running.
+ *
+ * This function is called in process context and it is save to block.
+ * When the event initialization functions fails, no other call back will
+ * be invoked.
+ *
+ * Allocate the memory for the event.
+ */
+static int paicrypt_busy(struct perf_event_attr *a, struct paicrypt_map *cpump)
+{
+	unsigned int *use_ptr;
+	int rc = 0;
+
+	mutex_lock(&pai_reserve_mutex);
+	if (a->sample_period) {		/* Sampling requested */
+		use_ptr = &cpump->sampler;
+		if (cpump->counter || cpump->sampler)
+			rc = -EBUSY;	/* ... sampling/counting active */
+	} else {			/* Counting requested */
+		use_ptr = &cpump->counter;
+		if (cpump->sampler)
+			rc = -EBUSY;	/* ... and sampling active */
+	}
+	if (rc)
+		goto unlock;
+
+	/* Allocate memory for counter page and counter extraction.
+	 * Only the first counting event has to allocate a page.
+	 */
+	if (cpump->page)
+		goto unlock;
+
+	rc = -ENOMEM;
+	cpump->page = (unsigned long *)get_zeroed_page(GFP_KERNEL);
+	if (!cpump->page)
+		goto unlock;
+	cpump->save = kvmalloc_array(paicrypt_cnt + 1,
+				     sizeof(struct pai_userdata), GFP_KERNEL);
+	if (!cpump->save) {
+		free_page((unsigned long)cpump->page);
+		cpump->page = NULL;
+		goto unlock;
+	}
+	rc = 0;
+
+unlock:
+	/* If rc is non-zero, do not increment counter/sampler. */
+	if (!rc)
+		*use_ptr += 1;
+	debug_sprintf_event(cfm_dbg, 5, "%s sample_period %#llx sampler %d"
+			    " counter %d page %#lx save %p rc %d\n", __func__,
+			    a->sample_period, cpump->sampler, cpump->counter,
+			    (unsigned long)cpump->page, cpump->save, rc);
+	mutex_unlock(&pai_reserve_mutex);
+	return rc;
+}
+
+/* Might be called on different CPU than the one the event is intended for. */
+static int paicrypt_event_init(struct perf_event *event)
+{
+	struct perf_event_attr *a = &event->attr;
+	struct paicrypt_map *cpump;
+	int rc;
+
+	/* PAI crypto PMU registered as PERF_TYPE_RAW, check event type */
+	if (a->type != PERF_TYPE_RAW && event->pmu->type != a->type)
+		return -ENOENT;
+	/* PAI crypto event must be valid */
+	if (a->config > PAI_CRYPTO_BASE + paicrypt_cnt)
+		return -EINVAL;
+	/* Allow only CPU wide operation, no process context for now. */
+	if (event->hw.target || event->cpu == -1)
+		return -ENOENT;
+	/* Allow only CRYPTO_ALL for sampling. */
+	if (a->sample_period && a->config != PAI_CRYPTO_BASE)
+		return -EINVAL;
+
+	cpump = per_cpu_ptr(&paicrypt_map, event->cpu);
+	rc = paicrypt_busy(a, cpump);
+	if (rc)
+		return rc;
+
+	cpump->event = event;
+	event->destroy = paicrypt_event_destroy;
+
+	if (a->sample_period) {
+		a->sample_period = 1;
+		a->freq = 0;
+		/* Register for paicrypt_sched_task() to be called */
+		event->attach_state |= PERF_ATTACH_SCHED_CB;
+		/* Add raw data which contain the memory mapped counters */
+		a->sample_type |= PERF_SAMPLE_RAW;
+		/* Turn off inheritance */
+		a->inherit = 0;
+	}
+
+	static_branch_inc(&pai_key);
+	return 0;
+}
+
+static void paicrypt_read(struct perf_event *event)
+{
+	u64 prev, new, delta;
+
+	prev = local64_read(&event->hw.prev_count);
+	new = paicrypt_getall(event);
+	local64_set(&event->hw.prev_count, new);
+	delta = (prev <= new) ? new - prev
+			      : (-1ULL - prev) + new + 1;	 /* overflow */
+	local64_add(delta, &event->count);
+}
+
+static void paicrypt_start(struct perf_event *event, int flags)
+{
+	u64 sum;
+
+	sum = paicrypt_getall(event);		/* Get current value */
+	local64_set(&event->hw.prev_count, sum);
+	local64_set(&event->count, 0);
+}
+
+static int paicrypt_add(struct perf_event *event, int flags)
+{
+	struct paicrypt_map *cpump = this_cpu_ptr(&paicrypt_map);
+	unsigned long ccd;
+
+	if (cpump->users++ == 0) {
+		ccd = virt_to_phys(cpump->page) | PAI_CRYPTO_KERNEL_OFFSET;
+		WRITE_ONCE(S390_lowcore.ccd, ccd);
+		__ctl_set_bit(0, 50);
+	}
+	cpump->event = event;
+	if (flags & PERF_EF_START && !event->attr.sample_period) {
+		/* Only counting needs initial counter value */
+		paicrypt_start(event, PERF_EF_RELOAD);
+	}
+	event->hw.state = 0;
+	if (event->attr.sample_period)
+		perf_sched_cb_inc(event->pmu);
+	return 0;
+}
+
+static void paicrypt_stop(struct perf_event *event, int flags)
+{
+	paicrypt_read(event);
+	event->hw.state = PERF_HES_STOPPED;
+}
+
+static void paicrypt_del(struct perf_event *event, int flags)
+{
+	struct paicrypt_map *cpump = this_cpu_ptr(&paicrypt_map);
+
+	if (event->attr.sample_period)
+		perf_sched_cb_dec(event->pmu);
+	if (!event->attr.sample_period)
+		/* Only counting needs to read counter */
+		paicrypt_stop(event, PERF_EF_UPDATE);
+	if (cpump->users-- == 1) {
+		__ctl_clear_bit(0, 50);
+		WRITE_ONCE(S390_lowcore.ccd, 0);
+	}
+}
+
+/* Create raw data and save it in buffer. Returns number of bytes copied.
+ * Saves only positive counter entries of the form
+ * 2 bytes: Number of counter
+ * 8 bytes: Value of counter
+ */
+static size_t paicrypt_copy(struct pai_userdata *userdata,
+			    struct paicrypt_map *cpump,
+			    bool exclude_user, bool exclude_kernel)
+{
+	int i, outidx = 0;
+
+	for (i = 1; i <= paicrypt_cnt; i++) {
+		u64 val = 0;
+
+		if (!exclude_kernel)
+			val += paicrypt_getctr(cpump, i, true);
+		if (!exclude_user)
+			val += paicrypt_getctr(cpump, i, false);
+		if (val) {
+			userdata[outidx].num = i;
+			userdata[outidx].value = val;
+			outidx++;
+		}
+	}
+	return outidx * sizeof(struct pai_userdata);
+}
+
+static int paicrypt_push_sample(void)
+{
+	struct paicrypt_map *cpump = this_cpu_ptr(&paicrypt_map);
+	struct perf_event *event = cpump->event;
+	struct perf_sample_data data;
+	struct perf_raw_record raw;
+	struct pt_regs regs;
+	size_t rawsize;
+	int overflow;
+
+	if (!cpump->event)		/* No event active */
+		return 0;
+	rawsize = paicrypt_copy(cpump->save, cpump,
+				cpump->event->attr.exclude_user,
+				cpump->event->attr.exclude_kernel);
+	if (!rawsize)			/* No incremented counters */
+		return 0;
+
+	/* Setup perf sample */
+	memset(&regs, 0, sizeof(regs));
+	memset(&raw, 0, sizeof(raw));
+	memset(&data, 0, sizeof(data));
+	perf_sample_data_init(&data, 0, event->hw.last_period);
+	if (event->attr.sample_type & PERF_SAMPLE_TID) {
+		data.tid_entry.pid = task_tgid_nr(current);
+		data.tid_entry.tid = task_pid_nr(current);
+	}
+	if (event->attr.sample_type & PERF_SAMPLE_TIME)
+		data.time = event->clock();
+	if (event->attr.sample_type & (PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER))
+		data.id = event->id;
+	if (event->attr.sample_type & PERF_SAMPLE_CPU) {
+		data.cpu_entry.cpu = smp_processor_id();
+		data.cpu_entry.reserved = 0;
+	}
+	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
+		raw.frag.size = rawsize;
+		raw.frag.data = cpump->save;
+		raw.size = raw.frag.size;
+		data.raw = &raw;
+	}
+
+	overflow = perf_event_overflow(event, &data, &regs);
+	perf_event_update_userpage(event);
+	/* Clear lowcore page after read */
+	memset(cpump->page, 0, PAGE_SIZE);
+	return overflow;
+}
+
+/* Called on schedule-in and schedule-out. No access to event structure,
+ * but for sampling only event CRYPTO_ALL is allowed.
+ */
+static void paicrypt_sched_task(struct perf_event_context *ctx, bool sched_in)
+{
+	/* We started with a clean page on event installation. So read out
+	 * results on schedule_out and if page was dirty, clear values.
+	 */
+	if (!sched_in)
+		paicrypt_push_sample();
+}
+
+/* Attribute definitions for paicrypt interface. As with other CPU
+ * Measurement Facilities, there is one attribute per mapped counter.
+ * The number of mapped counters may vary per machine generation. Use
+ * the QUERY PROCESSOR ACTIVITY COUNTER INFORMATION (QPACI) instruction
+ * to determine the number of mapped counters. The instructions returns
+ * a positive number, which is the highest number of supported counters.
+ * All counters less than this number are also supported, there are no
+ * holes. A returned number of zero means no support for mapped counters.
+ *
+ * The identification of the counter is a unique number. The chosen range
+ * is 0x1000 + offset in mapped kernel page.
+ * All CPU Measurement Facility counters identifiers must be unique and
+ * the numbers from 0 to 496 are already used for the CPU Measurement
+ * Counter facility. Numbers 0xb0000, 0xbc000 and 0xbd000 are already
+ * used for the CPU Measurement Sampling facility.
+ */
+PMU_FORMAT_ATTR(event, "config:0-63");
+
+static struct attribute *paicrypt_format_attr[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group paicrypt_events_group = {
+	.name = "events",
+	.attrs = NULL			/* Filled in attr_event_init() */
+};
+
+static struct attribute_group paicrypt_format_group = {
+	.name = "format",
+	.attrs = paicrypt_format_attr,
+};
+
+static const struct attribute_group *paicrypt_attr_groups[] = {
+	&paicrypt_events_group,
+	&paicrypt_format_group,
+	NULL,
+};
+
+/* Performance monitoring unit for mapped counters */
+static struct pmu paicrypt = {
+	.task_ctx_nr  = perf_invalid_context,
+	.event_init   = paicrypt_event_init,
+	.add	      = paicrypt_add,
+	.del	      = paicrypt_del,
+	.start	      = paicrypt_start,
+	.stop	      = paicrypt_stop,
+	.read	      = paicrypt_read,
+	.sched_task   = paicrypt_sched_task,
+	.attr_groups  = paicrypt_attr_groups
+};
+
+/* List of symbolic PAI counter names. */
+static const char * const paicrypt_ctrnames[] = {
+	[0] = "CRYPTO_ALL",
+	[1] = "KM_DEA",
+	[2] = "KM_TDEA_128",
+	[3] = "KM_TDEA_192",
+	[4] = "KM_ENCRYPTED_DEA",
+	[5] = "KM_ENCRYPTED_TDEA_128",
+	[6] = "KM_ENCRYPTED_TDEA_192",
+	[7] = "KM_AES_128",
+	[8] = "KM_AES_192",
+	[9] = "KM_AES_256",
+	[10] = "KM_ENCRYPTED_AES_128",
+	[11] = "KM_ENCRYPTED_AES_192",
+	[12] = "KM_ENCRYPTED_AES_256",
+	[13] = "KM_XTS_AES_128",
+	[14] = "KM_XTS_AES_256",
+	[15] = "KM_XTS_ENCRYPTED_AES_128",
+	[16] = "KM_XTS_ENCRYPTED_AES_256",
+	[17] = "KMC_DEA",
+	[18] = "KMC_TDEA_128",
+	[19] = "KMC_TDEA_192",
+	[20] = "KMC_ENCRYPTED_DEA",
+	[21] = "KMC_ENCRYPTED_TDEA_128",
+	[22] = "KMC_ENCRYPTED_TDEA_192",
+	[23] = "KMC_AES_128",
+	[24] = "KMC_AES_192",
+	[25] = "KMC_AES_256",
+	[26] = "KMC_ENCRYPTED_AES_128",
+	[27] = "KMC_ENCRYPTED_AES_192",
+	[28] = "KMC_ENCRYPTED_AES_256",
+	[29] = "KMC_PRNG",
+	[30] = "KMA_GCM_AES_128",
+	[31] = "KMA_GCM_AES_192",
+	[32] = "KMA_GCM_AES_256",
+	[33] = "KMA_GCM_ENCRYPTED_AES_128",
+	[34] = "KMA_GCM_ENCRYPTED_AES_192",
+	[35] = "KMA_GCM_ENCRYPTED_AES_256",
+	[36] = "KMF_DEA",
+	[37] = "KMF_TDEA_128",
+	[38] = "KMF_TDEA_192",
+	[39] = "KMF_ENCRYPTED_DEA",
+	[40] = "KMF_ENCRYPTED_TDEA_128",
+	[41] = "KMF_ENCRYPTED_TDEA_192",
+	[42] = "KMF_AES_128",
+	[43] = "KMF_AES_192",
+	[44] = "KMF_AES_256",
+	[45] = "KMF_ENCRYPTED_AES_128",
+	[46] = "KMF_ENCRYPTED_AES_192",
+	[47] = "KMF_ENCRYPTED_AES_256",
+	[48] = "KMCTR_DEA",
+	[49] = "KMCTR_TDEA_128",
+	[50] = "KMCTR_TDEA_192",
+	[51] = "KMCTR_ENCRYPTED_DEA",
+	[52] = "KMCTR_ENCRYPTED_TDEA_128",
+	[53] = "KMCTR_ENCRYPTED_TDEA_192",
+	[54] = "KMCTR_AES_128",
+	[55] = "KMCTR_AES_192",
+	[56] = "KMCTR_AES_256",
+	[57] = "KMCTR_ENCRYPTED_AES_128",
+	[58] = "KMCTR_ENCRYPTED_AES_192",
+	[59] = "KMCTR_ENCRYPTED_AES_256",
+	[60] = "KMO_DEA",
+	[61] = "KMO_TDEA_128",
+	[62] = "KMO_TDEA_192",
+	[63] = "KMO_ENCRYPTED_DEA",
+	[64] = "KMO_ENCRYPTED_TDEA_128",
+	[65] = "KMO_ENCRYPTED_TDEA_192",
+	[66] = "KMO_AES_128",
+	[67] = "KMO_AES_192",
+	[68] = "KMO_AES_256",
+	[69] = "KMO_ENCRYPTED_AES_128",
+	[70] = "KMO_ENCRYPTED_AES_192",
+	[71] = "KMO_ENCRYPTED_AES_256",
+	[72] = "KIMD_SHA_1",
+	[73] = "KIMD_SHA_256",
+	[74] = "KIMD_SHA_512",
+	[75] = "KIMD_SHA3_224",
+	[76] = "KIMD_SHA3_256",
+	[77] = "KIMD_SHA3_384",
+	[78] = "KIMD_SHA3_512",
+	[79] = "KIMD_SHAKE_128",
+	[80] = "KIMD_SHAKE_256",
+	[81] = "KIMD_GHASH",
+	[82] = "KLMD_SHA_1",
+	[83] = "KLMD_SHA_256",
+	[84] = "KLMD_SHA_512",
+	[85] = "KLMD_SHA3_224",
+	[86] = "KLMD_SHA3_256",
+	[87] = "KLMD_SHA3_384",
+	[88] = "KLMD_SHA3_512",
+	[89] = "KLMD_SHAKE_128",
+	[90] = "KLMD_SHAKE_256",
+	[91] = "KMAC_DEA",
+	[92] = "KMAC_TDEA_128",
+	[93] = "KMAC_TDEA_192",
+	[94] = "KMAC_ENCRYPTED_DEA",
+	[95] = "KMAC_ENCRYPTED_TDEA_128",
+	[96] = "KMAC_ENCRYPTED_TDEA_192",
+	[97] = "KMAC_AES_128",
+	[98] = "KMAC_AES_192",
+	[99] = "KMAC_AES_256",
+	[100] = "KMAC_ENCRYPTED_AES_128",
+	[101] = "KMAC_ENCRYPTED_AES_192",
+	[102] = "KMAC_ENCRYPTED_AES_256",
+	[103] = "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_DEA",
+	[104] = "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_TDEA_128",
+	[105] = "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_TDEA_192",
+	[106] = "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_DEA",
+	[107] = "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_TDEA_128",
+	[108] = "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_TDEA_192",
+	[109] = "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_AES_128",
+	[110] = "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_AES_192",
+	[111] = "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_AES_256",
+	[112] = "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_128",
+	[113] = "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_192",
+	[114] = "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_256A",
+	[115] = "PCC_COMPUTE_XTS_PARAMETER_USING_AES_128",
+	[116] = "PCC_COMPUTE_XTS_PARAMETER_USING_AES_256",
+	[117] = "PCC_COMPUTE_XTS_PARAMETER_USING_ENCRYPTED_AES_128",
+	[118] = "PCC_COMPUTE_XTS_PARAMETER_USING_ENCRYPTED_AES_256",
+	[119] = "PCC_SCALAR_MULTIPLY_P256",
+	[120] = "PCC_SCALAR_MULTIPLY_P384",
+	[121] = "PCC_SCALAR_MULTIPLY_P521",
+	[122] = "PCC_SCALAR_MULTIPLY_ED25519",
+	[123] = "PCC_SCALAR_MULTIPLY_ED448",
+	[124] = "PCC_SCALAR_MULTIPLY_X25519",
+	[125] = "PCC_SCALAR_MULTIPLY_X448",
+	[126] = "PRNO_SHA_512_DRNG",
+	[127] = "PRNO_TRNG_QUERY_RAW_TO_CONDITIONED_RATIO",
+	[128] = "PRNO_TRNG",
+	[129] = "KDSA_ECDSA_VERIFY_P256",
+	[130] = "KDSA_ECDSA_VERIFY_P384",
+	[131] = "KDSA_ECDSA_VERIFY_P521",
+	[132] = "KDSA_ECDSA_SIGN_P256",
+	[133] = "KDSA_ECDSA_SIGN_P384",
+	[134] = "KDSA_ECDSA_SIGN_P521",
+	[135] = "KDSA_ENCRYPTED_ECDSA_SIGN_P256",
+	[136] = "KDSA_ENCRYPTED_ECDSA_SIGN_P384",
+	[137] = "KDSA_ENCRYPTED_ECDSA_SIGN_P521",
+	[138] = "KDSA_EDDSA_VERIFY_ED25519",
+	[139] = "KDSA_EDDSA_VERIFY_ED448",
+	[140] = "KDSA_EDDSA_SIGN_ED25519",
+	[141] = "KDSA_EDDSA_SIGN_ED448",
+	[142] = "KDSA_ENCRYPTED_EDDSA_SIGN_ED25519",
+	[143] = "KDSA_ENCRYPTED_EDDSA_SIGN_ED448",
+	[144] = "PCKMO_ENCRYPT_DEA_KEY",
+	[145] = "PCKMO_ENCRYPT_TDEA_128_KEY",
+	[146] = "PCKMO_ENCRYPT_TDEA_192_KEY",
+	[147] = "PCKMO_ENCRYPT_AES_128_KEY",
+	[148] = "PCKMO_ENCRYPT_AES_192_KEY",
+	[149] = "PCKMO_ENCRYPT_AES_256_KEY",
+	[150] = "PCKMO_ENCRYPT_ECC_P256_KEY",
+	[151] = "PCKMO_ENCRYPT_ECC_P384_KEY",
+	[152] = "PCKMO_ENCRYPT_ECC_P521_KEY",
+	[153] = "PCKMO_ENCRYPT_ECC_ED25519_KEY",
+	[154] = "PCKMO_ENCRYPT_ECC_ED448_KEY",
+	[155] = "IBM_RESERVED_155",
+	[156] = "IBM_RESERVED_156",
+};
+
+static void __init attr_event_free(struct attribute **attrs, int num)
+{
+	struct perf_pmu_events_attr *pa;
+	int i;
+
+	for (i = 0; i < num; i++) {
+		struct device_attribute *dap;
+
+		dap = container_of(attrs[i], struct device_attribute, attr);
+		pa = container_of(dap, struct perf_pmu_events_attr, attr);
+		kfree(pa);
+	}
+	kfree(attrs);
+}
+
+static int __init attr_event_init_one(struct attribute **attrs, int num)
+{
+	struct perf_pmu_events_attr *pa;
+
+	pa = kzalloc(sizeof(*pa), GFP_KERNEL);
+	if (!pa)
+		return -ENOMEM;
+
+	sysfs_attr_init(&pa->attr.attr);
+	pa->id = PAI_CRYPTO_BASE + num;
+	pa->attr.attr.name = paicrypt_ctrnames[num];
+	pa->attr.attr.mode = 0444;
+	pa->attr.show = cpumf_events_sysfs_show;
+	pa->attr.store = NULL;
+	attrs[num] = &pa->attr.attr;
+	return 0;
+}
+
+/* Create PMU sysfs event attributes on the fly. */
+static int __init attr_event_init(void)
+{
+	struct attribute **attrs;
+	int ret, i;
+
+	attrs = kmalloc_array(ARRAY_SIZE(paicrypt_ctrnames) + 1, sizeof(*attrs),
+			      GFP_KERNEL);
+	if (!attrs)
+		return -ENOMEM;
+	for (i = 0; i < ARRAY_SIZE(paicrypt_ctrnames); i++) {
+		ret = attr_event_init_one(attrs, i);
+		if (ret) {
+			attr_event_free(attrs, i - 1);
+			return ret;
+		}
+	}
+	attrs[i] = NULL;
+	paicrypt_events_group.attrs = attrs;
+	return 0;
+}
+
+static int __init paicrypt_init(void)
+{
+	struct qpaci_info_block ib;
+	int rc;
+
+	if (!test_facility(196))
+		return 0;
+
+	qpaci(&ib);
+	paicrypt_cnt = ib.num_cc;
+	if (paicrypt_cnt == 0)
+		return 0;
+	if (paicrypt_cnt >= PAI_CRYPTO_MAXCTR)
+		paicrypt_cnt = PAI_CRYPTO_MAXCTR - 1;
+
+	rc = attr_event_init();		/* Export known PAI crypto events */
+	if (rc) {
+		pr_err("Creation of PMU pai_crypto /sysfs failed\n");
+		return rc;
+	}
+
+	/* Setup s390dbf facility */
+	cfm_dbg = debug_register(KMSG_COMPONENT, 2, 256, 128);
+	if (!cfm_dbg) {
+		pr_err("Registration of s390dbf pai_crypto failed\n");
+		return -ENOMEM;
+	}
+	debug_register_view(cfm_dbg, &debug_sprintf_view);
+
+	rc = perf_pmu_register(&paicrypt, "pai_crypto", -1);
+	if (rc) {
+		pr_err("Registering the pai_crypto PMU failed with rc=%i\n",
+		       rc);
+		debug_unregister_view(cfm_dbg, &debug_sprintf_view);
+		debug_unregister(cfm_dbg);
+		return rc;
+	}
+	return 0;
+}
+
+device_initcall(paicrypt_init);
-- 
2.32.0

