Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B00356C65
	for <lists+linux-s390@lfdr.de>; Wed,  7 Apr 2021 14:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347293AbhDGMm3 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 7 Apr 2021 08:42:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245630AbhDGMm2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Apr 2021 08:42:28 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137CZMSV013501;
        Wed, 7 Apr 2021 08:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XrHT26QxnDgFvht30l9ZbaIjBBWzhI8jxpoYURo6gRo=;
 b=AAIYcrpNu0G4QlVmnJjgVf9qNMUKR2fBVIhY64zOVHFUQEE1DDrDnPuSNgR2ET8S71Cl
 fumwa3cj2nH/nWVVcT0wukFbgb3RGYl4hN2ycNIkrN3CMnwdaNkO+ew+DBpk+E69mCM9
 8E819lliEIoCXUhf9shGkQfGLTXXWbXbMBZ2xk0cxA7wegHi60NPGLLEjxaiIGJtcrpZ
 fYHob+TACukPDDjnLNvts0XnPzZ1IaRhzsC0A64GSB8CyKfH7RlEZ7jnxgkj7XnRLOqB
 4lMdKAk04D+Wz+gJEv3gAR/hEU3V9Sta3bKRWV9pwI7GaMNrGDO9q05z1Ti2by6Rfyhv Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvumqmv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 08:42:18 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 137CZWQi014068;
        Wed, 7 Apr 2021 08:42:18 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvumqmu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 08:42:18 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 137CXIgJ003984;
        Wed, 7 Apr 2021 12:42:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 37rvbu8qb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 12:42:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 137Cfqv932244010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Apr 2021 12:41:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65BFF52050;
        Wed,  7 Apr 2021 12:42:13 +0000 (GMT)
Received: from ibm-vm.ibmuc.com (unknown [9.145.2.56])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0C54052057;
        Wed,  7 Apr 2021 12:42:13 +0000 (GMT)
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com,
        frankja@linux.ibm.com, cohuck@redhat.com, pmorel@linux.ibm.com
Subject: [kvm-unit-tests PATCH v3 7/7] s390x: edat test
Date:   Wed,  7 Apr 2021 14:42:09 +0200
Message-Id: <20210407124209.828540-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210407124209.828540-1-imbrenda@linux.ibm.com>
References: <20210407124209.828540-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nM1CaNjjsnWLDAkyw4IGwFvtJELnF9Kc
X-Proofpoint-ORIG-GUID: VTSBoSwkh08v5-WnSwhcNpynb-S8M4-2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-07_07:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070087
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Simple EDAT test.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 s390x/Makefile      |   1 +
 s390x/edat.c        | 279 ++++++++++++++++++++++++++++++++++++++++++++
 s390x/unittests.cfg |   3 +
 3 files changed, 283 insertions(+)
 create mode 100644 s390x/edat.c

diff --git a/s390x/Makefile b/s390x/Makefile
index b92de9c5..26bb1684 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -21,6 +21,7 @@ tests += $(TEST_DIR)/css.elf
 tests += $(TEST_DIR)/uv-guest.elf
 tests += $(TEST_DIR)/sie.elf
 tests += $(TEST_DIR)/mvpg.elf
+tests += $(TEST_DIR)/edat.elf
 
 tests_binary = $(patsubst %.elf,%.bin,$(tests))
 ifneq ($(HOST_KEY_DOCUMENT),)
diff --git a/s390x/edat.c b/s390x/edat.c
new file mode 100644
index 00000000..edc3dc38
--- /dev/null
+++ b/s390x/edat.c
@@ -0,0 +1,279 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * EDAT test.
+ *
+ * Copyright (c) 2021 IBM Corp
+ *
+ * Authors:
+ *	Claudio Imbrenda <imbrenda@linux.ibm.com>
+ */
+#include <libcflat.h>
+#include <vmalloc.h>
+#include <asm/facility.h>
+#include <asm/interrupt.h>
+#include <mmu.h>
+#include <asm/pgtable.h>
+#include <asm-generic/barrier.h>
+
+#define PGD_PAGE_SHIFT (REGION1_SHIFT - PAGE_SHIFT)
+
+#define LC_SIZE	(2 * PAGE_SIZE)
+#define VIRT(x)	((void *)((unsigned long)(x) + (unsigned long)mem))
+
+static uint8_t prefix_buf[LC_SIZE] __attribute__((aligned(LC_SIZE)));
+static unsigned int tmp[1024] __attribute__((aligned(PAGE_SIZE)));
+static void *root, *mem, *m;
+static struct lowcore *lc;
+volatile unsigned int *p;
+
+/* Expect a program interrupt, and clear the TEID */
+static void expect_dat_fault(void)
+{
+	expect_pgm_int();
+	lc->trans_exc_id = 0;
+}
+
+/*
+ * Check if a non-access-list protection exception happened for the given
+ * address, in the primary address space.
+ */
+static bool check_pgm_prot(void *ptr)
+{
+	unsigned long teid = lc->trans_exc_id;
+
+	if (lc->pgm_int_code != PGM_INT_CODE_PROTECTION)
+		return false;
+	/*
+	 * if for any reason PGM_TEID_M is not present, the rest of the
+	 * field is not meaningful, so no point in checking it
+	 */
+	if (~teid & PGM_TEID_M)
+		return true;
+	return (~teid & PGM_TEID_A) &&
+		((teid & PGM_TEID_ADDR) == ((uint64_t)ptr & PAGE_MASK)) &&
+		!(teid & PGM_TEID_AI);
+}
+
+static void test_dat(void)
+{
+	report_prefix_push("edat off");
+	/* disable EDAT */
+	ctl_clear_bit(0, CTL0_EDAT);
+
+	/* Check some basics */
+	p[0] = 42;
+	report(p[0] == 42, "pte, r/w");
+	p[0] = 0;
+
+	/* Write protect the page and try to write, expect a fault */
+	protect_page(m, PAGE_ENTRY_P);
+	expect_dat_fault();
+	p[0] = 42;
+	unprotect_page(m, PAGE_ENTRY_P);
+	report(!p[0] && check_pgm_prot(m), "pte, ro");
+
+	/*
+	 * The FC bit (for large pages) should be ignored because EDAT is
+	 * off. We set a value and then we try to read it back again after
+	 * setting the FC bit. This way we can check if large pages were
+	 * erroneously enabled despite EDAT being off.
+	 */
+	p[0] = 42;
+	protect_dat_entry(m, SEGMENT_ENTRY_FC, 4);
+	report(p[0] == 42, "pmd, fc=1, r/w");
+	unprotect_dat_entry(m, SEGMENT_ENTRY_FC, 4);
+	p[0] = 0;
+
+	/*
+	 * Segment protection should work even with EDAT off, try to write
+	 * anyway and expect a fault
+	 */
+	protect_dat_entry(m, SEGMENT_ENTRY_P, 4);
+	expect_dat_fault();
+	p[0] = 42;
+	report(!p[0] && check_pgm_prot(m), "pmd, ro");
+	unprotect_dat_entry(m, SEGMENT_ENTRY_P, 4);
+
+	/* The FC bit should be ignored because EDAT is off, like above */
+	p[0] = 42;
+	protect_dat_entry(m, REGION3_ENTRY_FC, 3);
+	report(p[0] == 42, "pud, fc=1, r/w");
+	unprotect_dat_entry(m, REGION3_ENTRY_FC, 3);
+	p[0] = 0;
+
+	/*
+	 * Region1/2/3 protection should not work, because EDAT is off.
+	 * Protect the various region1/2/3 entries and write, expect the
+	 * write to be successful.
+	 */
+	protect_dat_entry(m, REGION_ENTRY_P, 3);
+	p[0] = 42;
+	report(p[0] == 42, "pud, ro");
+	unprotect_dat_entry(m, REGION_ENTRY_P, 3);
+	p[0] = 0;
+
+	protect_dat_entry(m, REGION_ENTRY_P, 2);
+	p[0] = 42;
+	report(p[0] == 42, "p4d, ro");
+	unprotect_dat_entry(m, REGION_ENTRY_P, 2);
+	p[0] = 0;
+
+	protect_dat_entry(m, REGION_ENTRY_P, 1);
+	p[0] = 42;
+	report(p[0] == 42, "pgd, ro");
+	unprotect_dat_entry(m, REGION_ENTRY_P, 1);
+	p[0] = 0;
+
+	report_prefix_pop();
+}
+
+static void test_edat1(void)
+{
+	report_prefix_push("edat1");
+	/* Enable EDAT */
+	ctl_set_bit(0, CTL0_EDAT);
+	p[0] = 0;
+
+	/*
+	 * Segment protection should work normally, try to write and expect
+	 * a fault.
+	 */
+	expect_dat_fault();
+	protect_dat_entry(m, SEGMENT_ENTRY_P, 4);
+	p[0] = 42;
+	report(!p[0] && check_pgm_prot(m), "pmd, ro");
+	unprotect_dat_entry(m, SEGMENT_ENTRY_P, 4);
+
+	/*
+	 * Region1/2/3 protection should work now, because EDAT is on. Try
+	 * to write anyway and expect a fault.
+	 */
+	expect_dat_fault();
+	protect_dat_entry(m, REGION_ENTRY_P, 3);
+	p[0] = 42;
+	report(!p[0] && check_pgm_prot(m), "pud, ro");
+	unprotect_dat_entry(m, REGION_ENTRY_P, 3);
+
+	expect_dat_fault();
+	protect_dat_entry(m, REGION_ENTRY_P, 2);
+	p[0] = 42;
+	report(!p[0] && check_pgm_prot(m), "p4d, ro");
+	unprotect_dat_entry(m, REGION_ENTRY_P, 2);
+
+	expect_dat_fault();
+	protect_dat_entry(m, REGION_ENTRY_P, 1);
+	p[0] = 42;
+	report(!p[0] && check_pgm_prot(m), "pgd, ro");
+	unprotect_dat_entry(m, REGION_ENTRY_P, 1);
+
+	/* Large pages should work */
+	p[0] = 42;
+	install_large_page(root, 0, mem);
+	report(p[0] == 42, "pmd, large");
+
+	/*
+	 * Prefixing should not work with large pages. Since the lower
+	 * addresses are mapped with small pages, which are subject to
+	 * prefixing, and the pages mapped with large pages are not subject
+	 * to prefixing, this is the resulting scenario:
+	 *
+	 * virtual 0 = real 0 -> absolute prefix_buf
+	 * virtual prefix_buf = real prefix_buf -> absolute 0
+	 * VIRT(0) -> absolute 0
+	 * VIRT(prefix_buf) -> absolute prefix_buf
+	 *
+	 * The testcase checks if the memory at virtual 0 has the same
+	 * content as the memory at VIRT(prefix_buf) and the memory at
+	 * VIRT(0) has the same content as the memory at virtual prefix_buf.
+	 * If prefixing is erroneously applied for large pages, the testcase
+	 * will therefore fail.
+	 */
+	report(!memcmp(0, VIRT(prefix_buf), LC_SIZE) &&
+		!memcmp(prefix_buf, VIRT(0), LC_SIZE),
+		"pmd, large, prefixing");
+
+	report_prefix_pop();
+}
+
+static void test_edat2(void)
+{
+	report_prefix_push("edat2");
+	p[0] = 42;
+
+	/* Huge pages should work */
+	install_huge_page(root, 0, mem);
+	report(p[0] == 42, "pud, huge");
+
+	/* Prefixing should not work with huge pages, just like large pages */
+	report(!memcmp(0, VIRT(prefix_buf), LC_SIZE) &&
+		!memcmp(prefix_buf, VIRT(0), LC_SIZE),
+		"pmd, large, prefixing");
+
+	report_prefix_pop();
+}
+
+static unsigned int setup(void)
+{
+	bool has_edat1 = test_facility(8);
+	bool has_edat2 = test_facility(78);
+	unsigned long pa, va;
+
+	if (has_edat2 && !has_edat1)
+		report_abort("EDAT2 available, but EDAT1 not available");
+
+	/* Setup DAT 1:1 mapping and memory management */
+	setup_vm();
+	root = (void *)(stctg(1) & PAGE_MASK);
+
+	/*
+	 * Get a pgd worth of virtual memory, so we can test things later
+	 * without interfering with the test code or the interrupt handler
+	 */
+	mem = alloc_vpages_aligned(BIT_ULL(PGD_PAGE_SHIFT), PGD_PAGE_SHIFT);
+	assert(mem);
+	va = (unsigned long)mem;
+
+	/* Map the first 1GB of real memory */
+	for (pa = 0; pa < SZ_1G; pa += PAGE_SIZE, va += PAGE_SIZE)
+		install_page(root, pa, (void *)va);
+
+	/*
+	 * Move the lowcore to a known non-zero location. This is needed
+	 * later to check whether prefixing is working with large pages.
+	 */
+	assert((unsigned long)&prefix_buf < SZ_2G);
+	memcpy(prefix_buf, 0, LC_SIZE);
+	set_prefix((uint32_t)(uintptr_t)prefix_buf);
+	/* Clear the old copy */
+	memset(prefix_buf, 0, LC_SIZE);
+
+	/* m will point to tmp through the new virtual mapping */
+	m = VIRT(&tmp);
+	/* p is the same as m but volatile */
+	p = (volatile unsigned int *)m;
+
+	return has_edat1 + has_edat2;
+}
+
+int main(void)
+{
+	unsigned int edat;
+
+	report_prefix_push("edat");
+	edat = setup();
+
+	test_dat();
+
+	if (edat)
+		test_edat1();
+	else
+		report_skip("EDAT not available");
+
+	if (edat >= 2)
+		test_edat2();
+	else
+		report_skip("EDAT2 not available");
+
+	report_prefix_pop();
+	return report_summary();
+}
diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
index 9f81a608..a0ec8864 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -103,3 +103,6 @@ file = sie.elf
 [mvpg]
 file = mvpg.elf
 timeout = 10
+
+[edat]
+file = edat.elf
-- 
2.26.2

