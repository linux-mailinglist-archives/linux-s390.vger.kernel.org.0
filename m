Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6F56B4FE0
	for <lists+linux-s390@lfdr.de>; Fri, 10 Mar 2023 19:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCJSLw (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 10 Mar 2023 13:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCJSLu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Mar 2023 13:11:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8B51241CA;
        Fri, 10 Mar 2023 10:11:48 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AHHLT3003147;
        Fri, 10 Mar 2023 18:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=noMnFGpQ82ybOcsraTvZhV/XFUc0Bu00cBe2srAYGx8=;
 b=FUwgKZlAZG+DmpSPPaMhc7RuSNYfrUz9JYHMEoBxIxIzN311TTjFnD6loZPyur4l3oNr
 3N9e/bVNSAeNLfk+BXc0wlV7nC15zbJt1qHRznR90r69Q6uOeO75MxArjcCdY6UzySue
 YCeQE+Je83ulrmPhZpqtH9af6V3Xd2qWK4eTn7VDLZxwJYQxHKG1uu1/bxOCs07wNZGF
 FJqhrBdsuFFiCcFhwn3ccrU9F4KVkHQwBhc/3UUj0LoTIr6buhsBfs7wvs536VVZMMcw
 4Cvrhw2oPqzYXPOjj/eMOqXI9WQBJx7xnqlqNiJvgUkM+WGO0HfTaDG+AEFQFkyCQ4xX uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p88tch4dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 18:11:48 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32AHbTMn022433;
        Fri, 10 Mar 2023 18:11:48 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p88tch4d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 18:11:47 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32A7uaF7023013;
        Fri, 10 Mar 2023 18:11:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3p6fysv7ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 18:11:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32AIBfWb48103802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 18:11:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAB232004B;
        Fri, 10 Mar 2023 18:11:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DDDA20043;
        Fri, 10 Mar 2023 18:11:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Mar 2023 18:11:41 +0000 (GMT)
From:   Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To:     Thomas Huth <thuth@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH v5] s390x: Add tests for execute-type instructions
Date:   Fri, 10 Mar 2023 19:11:31 +0100
Message-Id: <20230310181131.2138736-1-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VC7XSel_L5qUfFsGq1RA9uVHSL1ZOd8x
X-Proofpoint-GUID: yolj0SXFsYUyY8P4lx8gs0AH7jWpBmz-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_09,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Test the instruction address used by targets of an execute instruction.
When the target instruction calculates a relative address, the result is
relative to the target instruction, not the execute instruction.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---


v4 -> v5:
 * word align the execute-type instruction, preventing a specification
   exception if the address calculation is wrong, since LLGFRL requires
   word alignment
 * change wording of comment

v3 -> v4:
 * fix nits (thanks Janosch)
 * pickup R-b (thanks Janosch)

v2 -> v3:
 * add some comments (thanks Janosch)
 * add two new tests (drop Nico's R-b)
 * push prefix

v1 -> v2:
 * add test to unittests.cfg and .gitlab-ci.yml
 * pick up R-b (thanks Nico)


TCG does the address calculation relative to the execute instruction.
Everything that has an operand that is relative to the instruction given by
the immediate in the instruction and goes through in2_ri2 in TCG has this
problem, because in2_ri2 does the calculation relative to pc_next which is the
address of the EX(RL).
That should make fixing it easier tho.


Range-diff against v4:
1:  f29ef634 ! 1:  57f8f256 s390x: Add tests for execute-type instructions
    @@ s390x/ex.c (new)
     +		"	.popsection\n"
     +
     +		"	llgfrl	%[target],0b\n"
    ++		//align (pad with nop), in case the wrong operand is used
    ++		"	.balignw 4,0x0707\n"
     +		"	exrl	0,0b\n"
     +		: [target] "=d" (target),
     +		  [value] "=d" (value)
    @@ s390x/ex.c (new)
     +		"	.popsection\n"
     +
     +		"	lrl	%[crl_word],0b\n"
    -+		//align (pad with nop), in case the wrong bad operand is used
    ++		//align (pad with nop), in case the wrong operand is used
     +		"	.balignw 4,0x0707\n"
     +		"	exrl	0,0b\n"
     +		"	ipm	%[program_mask]\n"

 s390x/Makefile      |   1 +
 s390x/ex.c          | 172 ++++++++++++++++++++++++++++++++++++++++++++
 s390x/unittests.cfg |   3 +
 .gitlab-ci.yml      |   1 +
 4 files changed, 177 insertions(+)
 create mode 100644 s390x/ex.c

diff --git a/s390x/Makefile b/s390x/Makefile
index 97a61611..6cf8018b 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -39,6 +39,7 @@ tests += $(TEST_DIR)/panic-loop-extint.elf
 tests += $(TEST_DIR)/panic-loop-pgm.elf
 tests += $(TEST_DIR)/migration-sck.elf
 tests += $(TEST_DIR)/exittime.elf
+tests += $(TEST_DIR)/ex.elf
 
 pv-tests += $(TEST_DIR)/pv-diags.elf
 
diff --git a/s390x/ex.c b/s390x/ex.c
new file mode 100644
index 00000000..f05f8f90
--- /dev/null
+++ b/s390x/ex.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright IBM Corp. 2023
+ *
+ * Test EXECUTE (RELATIVE LONG).
+ * These instructions execute a target instruction. The target instruction is formed
+ * by reading an instruction from memory and optionally modifying some of its bits.
+ * The execution of the target instruction is the same as if it was executed
+ * normally as part of the instruction sequence, except for the instruction
+ * address and the instruction-length code.
+ */
+
+#include <libcflat.h>
+
+/*
+ * BRANCH AND SAVE, register register variant.
+ * Saves the next instruction address (address from PSW + length of instruction)
+ * to the first register. No branch is taken in this test, because 0 is
+ * specified as target.
+ * BASR does *not* perform a relative address calculation with an intermediate.
+ */
+static void test_basr(void)
+{
+	uint64_t ret_addr, after_ex;
+
+	report_prefix_push("BASR");
+	asm volatile ( ".pushsection .rodata\n"
+		"0:	basr	%[ret_addr],0\n"
+		"	.popsection\n"
+
+		"	larl	%[after_ex],1f\n"
+		"	exrl	0,0b\n"
+		"1:\n"
+		: [ret_addr] "=d" (ret_addr),
+		  [after_ex] "=d" (after_ex)
+	);
+
+	report(ret_addr == after_ex, "return address after EX");
+	report_prefix_pop();
+}
+
+/*
+ * BRANCH RELATIVE AND SAVE.
+ * According to PoP (Branch-Address Generation), the address calculated relative
+ * to the instruction address is relative to BRAS when it is the target of an
+ * execute-type instruction, not relative to the execute-type instruction.
+ */
+static void test_bras(void)
+{
+	uint64_t after_target, ret_addr, after_ex, branch_addr;
+
+	report_prefix_push("BRAS");
+	asm volatile ( ".pushsection .text.ex_bras, \"x\"\n"
+		"0:	bras	%[ret_addr],1f\n"
+		"	nopr	%%r7\n"
+		"1:	larl	%[branch_addr],0\n"
+		"	j	4f\n"
+		"	.popsection\n"
+
+		"	larl	%[after_target],1b\n"
+		"	larl	%[after_ex],3f\n"
+		"2:	exrl	0,0b\n"
+		"3:	larl	%[branch_addr],0\n"
+		"4:\n"
+
+		"	.if (1b - 0b) != (3b - 2b)\n"
+		"	.error	\"right and wrong target must have same offset\"\n"
+		"	.endif\n"
+		: [after_target] "=d" (after_target),
+		  [ret_addr] "=d" (ret_addr),
+		  [after_ex] "=d" (after_ex),
+		  [branch_addr] "=d" (branch_addr)
+	);
+
+	report(after_target == branch_addr, "address calculated relative to BRAS");
+	report(ret_addr == after_ex, "return address after EX");
+	report_prefix_pop();
+}
+
+/*
+ * LOAD ADDRESS RELATIVE LONG.
+ * If it is the target of an execute-type instruction, the address is relative
+ * to the LARL.
+ */
+static void test_larl(void)
+{
+	uint64_t target, addr;
+
+	report_prefix_push("LARL");
+	asm volatile ( ".pushsection .rodata\n"
+		"0:	larl	%[addr],0\n"
+		"	.popsection\n"
+
+		"	larl	%[target],0b\n"
+		"	exrl	0,0b\n"
+		: [target] "=d" (target),
+		  [addr] "=d" (addr)
+	);
+
+	report(target == addr, "address calculated relative to LARL");
+	report_prefix_pop();
+}
+
+/* LOAD LOGICAL RELATIVE LONG.
+ * If it is the target of an execute-type instruction, the address is relative
+ * to the LLGFRL.
+ */
+static void test_llgfrl(void)
+{
+	uint64_t target, value;
+
+	report_prefix_push("LLGFRL");
+	asm volatile ( ".pushsection .rodata\n"
+		"	.balign	4\n"
+		"0:	llgfrl	%[value],0\n"
+		"	.popsection\n"
+
+		"	llgfrl	%[target],0b\n"
+		//align (pad with nop), in case the wrong operand is used
+		"	.balignw 4,0x0707\n"
+		"	exrl	0,0b\n"
+		: [target] "=d" (target),
+		  [value] "=d" (value)
+	);
+
+	report(target == value, "loaded correct value");
+	report_prefix_pop();
+}
+
+/*
+ * COMPARE RELATIVE LONG
+ * If it is the target of an execute-type instruction, the address is relative
+ * to the CRL.
+ */
+static void test_crl(void)
+{
+	uint32_t program_mask, cc, crl_word;
+
+	report_prefix_push("CRL");
+	asm volatile ( ".pushsection .rodata\n"
+		 //operand of crl must be word aligned
+		 "	.balign	4\n"
+		"0:	crl	%[crl_word],0\n"
+		"	.popsection\n"
+
+		"	lrl	%[crl_word],0b\n"
+		//align (pad with nop), in case the wrong operand is used
+		"	.balignw 4,0x0707\n"
+		"	exrl	0,0b\n"
+		"	ipm	%[program_mask]\n"
+		: [program_mask] "=d" (program_mask),
+		  [crl_word] "=d" (crl_word)
+		:: "cc"
+	);
+
+	cc = program_mask >> 28;
+	report(!cc, "operand compared to is relative to CRL");
+	report_prefix_pop();
+}
+
+int main(int argc, char **argv)
+{
+	report_prefix_push("ex");
+	test_basr();
+	test_bras();
+	test_larl();
+	test_llgfrl();
+	test_crl();
+	report_prefix_pop();
+
+	return report_summary();
+}
diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
index d97eb5e9..b61faf07 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -215,3 +215,6 @@ file = migration-skey.elf
 smp = 2
 groups = migration
 extra_params = -append '--parallel'
+
+[execute]
+file = ex.elf
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ad7949c9..a999f64a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -275,6 +275,7 @@ s390x-kvm:
   - ACCEL=kvm ./run_tests.sh
       selftest-setup intercept emulator sieve sthyi diag10 diag308 pfmf
       cmm vector gs iep cpumodel diag288 stsi sclp-1g sclp-3g css skrf sie
+      execute
       | tee results.txt
   - grep -q PASS results.txt && ! grep -q FAIL results.txt
  only:

base-commit: e3c5c3ef2524c58023073c0fadde2e8ae3c04ec6
-- 
2.39.1

