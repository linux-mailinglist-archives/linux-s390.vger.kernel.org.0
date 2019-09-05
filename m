Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 863E8AA000
	for <lists+linux-s390@lfdr.de>; Thu,  5 Sep 2019 12:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbfIEKkK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 5 Sep 2019 06:40:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733033AbfIEKkJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Sep 2019 06:40:09 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x85AbFdf080756
        for <linux-s390@vger.kernel.org>; Thu, 5 Sep 2019 06:40:08 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uu0qr07w5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 05 Sep 2019 06:40:08 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 5 Sep 2019 11:40:06 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Sep 2019 11:40:03 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x85Ae2Q043057182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Sep 2019 10:40:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3529A52054;
        Thu,  5 Sep 2019 10:40:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.131])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 75FC452052;
        Thu,  5 Sep 2019 10:40:01 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com
Subject: [kvm-unit-tests PATCH v2 1/6] s390x: Use interrupts in SCLP and add locking
Date:   Thu,  5 Sep 2019 12:39:46 +0200
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190905103951.36522-1-frankja@linux.ibm.com>
References: <20190905103951.36522-1-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19090510-0028-0000-0000-0000039800FE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090510-0029-0000-0000-0000245A560D
Message-Id: <20190905103951.36522-2-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-05_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909050106
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

We need to properly implement interrupt handling for SCLP, because on
z/VM and LPAR SCLP calls are not synchronous!

Also with smp CPUs have to compete for sclp. Let's add some locking,
so they execute sclp calls in an orderly fashion and don't compete for
the data buffer.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/asm/interrupt.h |  2 ++
 lib/s390x/interrupt.c     | 12 +++++++--
 lib/s390x/sclp-console.c  |  2 ++
 lib/s390x/sclp.c          | 55 +++++++++++++++++++++++++++++++++++++--
 lib/s390x/sclp.h          |  3 +++
 5 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/lib/s390x/asm/interrupt.h b/lib/s390x/asm/interrupt.h
index 013709f..f485e96 100644
--- a/lib/s390x/asm/interrupt.h
+++ b/lib/s390x/asm/interrupt.h
@@ -11,6 +11,8 @@
 #define _ASMS390X_IRQ_H_
 #include <asm/arch_def.h>
 
+#define EXT_IRQ_SERVICE_SIG	0x2401
+
 void handle_pgm_int(void);
 void handle_ext_int(void);
 void handle_mcck_int(void);
diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
index cf0a794..7832711 100644
--- a/lib/s390x/interrupt.c
+++ b/lib/s390x/interrupt.c
@@ -12,6 +12,7 @@
 #include <libcflat.h>
 #include <asm/interrupt.h>
 #include <asm/barrier.h>
+#include <sclp.h>
 
 static bool pgm_int_expected;
 static struct lowcore *lc;
@@ -107,8 +108,15 @@ void handle_pgm_int(void)
 
 void handle_ext_int(void)
 {
-	report_abort("Unexpected external call interrupt: at %#lx",
-		     lc->ext_old_psw.addr);
+	if (lc->ext_int_code != EXT_IRQ_SERVICE_SIG) {
+		report_abort("Unexpected external call interrupt: at %#lx",
+			     lc->ext_old_psw.addr);
+	} else {
+		lc->ext_old_psw.mask &= ~PSW_MASK_EXT;
+		lc->sw_int_cr0 &= ~(1UL << 9);
+		sclp_handle_ext();
+		lc->ext_int_code = 0;
+	}
 }
 
 void handle_mcck_int(void)
diff --git a/lib/s390x/sclp-console.c b/lib/s390x/sclp-console.c
index bc01f41..a5ef45f 100644
--- a/lib/s390x/sclp-console.c
+++ b/lib/s390x/sclp-console.c
@@ -17,6 +17,7 @@ static void sclp_set_write_mask(void)
 {
 	WriteEventMask *sccb = (void *)_sccb;
 
+	sclp_mark_busy();
 	sccb->h.length = sizeof(WriteEventMask);
 	sccb->mask_length = sizeof(unsigned int);
 	sccb->receive_mask = SCLP_EVENT_MASK_MSG_ASCII;
@@ -37,6 +38,7 @@ void sclp_print(const char *str)
 	int len = strlen(str);
 	WriteEventData *sccb = (void *)_sccb;
 
+	sclp_mark_busy();
 	sccb->h.length = sizeof(WriteEventData) + len;
 	sccb->h.function_code = SCLP_FC_NORMAL_WRITE;
 	sccb->ebh.length = sizeof(EventBufferHeader) + len;
diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index b60f7a4..56fca0c 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -14,6 +14,8 @@
 #include <asm/page.h>
 #include <asm/arch_def.h>
 #include <asm/interrupt.h>
+#include <asm/barrier.h>
+#include <asm/spinlock.h>
 #include "sclp.h"
 #include <alloc_phys.h>
 #include <alloc_page.h>
@@ -25,6 +27,8 @@ static uint64_t max_ram_size;
 static uint64_t ram_size;
 
 char _sccb[PAGE_SIZE] __attribute__((__aligned__(4096)));
+static volatile bool sclp_busy;
+static struct spinlock sclp_lock;
 
 static void mem_init(phys_addr_t mem_end)
 {
@@ -41,17 +45,62 @@ static void mem_init(phys_addr_t mem_end)
 	page_alloc_ops_enable();
 }
 
+static void sclp_setup_int(void)
+{
+	uint64_t mask;
+
+	ctl_set_bit(0, 9);
+
+	mask = extract_psw_mask();
+	mask |= PSW_MASK_EXT;
+	load_psw_mask(mask);
+}
+
+void sclp_handle_ext(void)
+{
+	ctl_clear_bit(0, 9);
+	spin_lock(&sclp_lock);
+	sclp_busy = false;
+	spin_unlock(&sclp_lock);
+}
+
+void sclp_wait_busy(void)
+{
+	while (sclp_busy)
+		mb();
+}
+
+void sclp_mark_busy(void)
+{
+	/*
+	 * With multiple CPUs we might need to wait for another CPU's
+	 * request before grabbing the busy indication.
+	 */
+	while (true) {
+		sclp_wait_busy();
+		spin_lock(&sclp_lock);
+		if (!sclp_busy) {
+			sclp_busy = true;
+			spin_unlock(&sclp_lock);
+			return;
+		}
+		spin_unlock(&sclp_lock);
+	}
+}
+
 static void sclp_read_scp_info(ReadInfo *ri, int length)
 {
 	unsigned int commands[] = { SCLP_CMDW_READ_SCP_INFO_FORCED,
 				    SCLP_CMDW_READ_SCP_INFO };
-	int i;
+	int i, cc;
 
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		sclp_mark_busy();
 		memset(&ri->h, 0, sizeof(ri->h));
 		ri->h.length = length;
 
-		if (sclp_service_call(commands[i], ri))
+		cc = sclp_service_call(commands[i], ri);
+		if (cc)
 			break;
 		if (ri->h.response_code == SCLP_RC_NORMAL_READ_COMPLETION)
 			return;
@@ -66,12 +115,14 @@ int sclp_service_call(unsigned int command, void *sccb)
 {
 	int cc;
 
+	sclp_setup_int();
 	asm volatile(
 		"       .insn   rre,0xb2200000,%1,%2\n"  /* servc %1,%2 */
 		"       ipm     %0\n"
 		"       srl     %0,28"
 		: "=&d" (cc) : "d" (command), "a" (__pa(sccb))
 		: "cc", "memory");
+	sclp_wait_busy();
 	if (cc == 3)
 		return -1;
 	if (cc == 2)
diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index 583c4e5..63cf609 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -213,6 +213,9 @@ typedef struct ReadEventData {
 } __attribute__((packed)) ReadEventData;
 
 extern char _sccb[];
+void sclp_handle_ext(void);
+void sclp_wait_busy(void);
+void sclp_mark_busy(void);
 void sclp_console_setup(void);
 void sclp_print(const char *str);
 int sclp_service_call(unsigned int command, void *sccb);
-- 
2.17.0

