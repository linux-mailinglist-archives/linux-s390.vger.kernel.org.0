Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE2A10C8DD
	for <lists+linux-s390@lfdr.de>; Thu, 28 Nov 2019 13:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfK1Mq0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 28 Nov 2019 07:46:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726610AbfK1MqT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Nov 2019 07:46:19 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xASCh9Se024607
        for <linux-s390@vger.kernel.org>; Thu, 28 Nov 2019 07:46:18 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wje2hgyam-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 28 Nov 2019 07:46:18 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 28 Nov 2019 12:46:15 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Nov 2019 12:46:13 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xASCkCUc17825804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Nov 2019 12:46:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A5F1AE051;
        Thu, 28 Nov 2019 12:46:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00C56AE045;
        Thu, 28 Nov 2019 12:46:12 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.185.119])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Nov 2019 12:46:11 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@redhat.com, thuth@redhat.com, cohuck@redhat.com
Subject: [kvm-unit-tests PATCH v2 6/9] s390x: css: stsch, enumeration test
Date:   Thu, 28 Nov 2019 13:46:04 +0100
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19112812-0008-0000-0000-000003396180
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112812-0009-0000-0000-00004A586DA3
Message-Id: <1574945167-29677-7-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_03:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911280112
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

First step by testing the channel subsystem is to enumerate the css and
retrieve the css devices.

This test the success of STSCH I/O instruction.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 s390x/Makefile      |  4 ++-
 s390x/css.c         | 86 +++++++++++++++++++++++++++++++++++++++++++++
 s390x/unittests.cfg |  4 +++
 3 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 s390x/css.c

diff --git a/s390x/Makefile b/s390x/Makefile
index e9da618..167ba05 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -1,4 +1,4 @@
-tests = $(TEST_DIR)/selftest.elf
+#tests = $(TEST_DIR)/selftest.elf
 tests += $(TEST_DIR)/intercept.elf
 tests += $(TEST_DIR)/emulator.elf
 tests += $(TEST_DIR)/sieve.elf
@@ -19,6 +19,7 @@ tests += $(TEST_DIR)/smp.elf
 tests += $(TEST_DIR)/uv-guest.elf
 tests += $(TEST_DIR)/uv-host.elf
 tests += $(TEST_DIR)/uv-limit.elf
+tests += $(TEST_DIR)/css.elf
 tests_binary = $(patsubst %.elf,%.bin,$(tests))
 tests_img = $(patsubst %.elf,%.img,$(tests))
 
@@ -56,6 +57,7 @@ cflatobjs += lib/s390x/sclp-console.o
 cflatobjs += lib/s390x/interrupt.o
 cflatobjs += lib/s390x/mmu.o
 cflatobjs += lib/s390x/smp.o
+cflatobjs += lib/s390x/css_dump.o
 
 OBJDIRS += lib/s390x
 
diff --git a/s390x/css.c b/s390x/css.c
new file mode 100644
index 0000000..8186f55
--- /dev/null
+++ b/s390x/css.c
@@ -0,0 +1,86 @@
+/*
+ * Channel Sub-System tests
+ *
+ * Copyright (c) 2019 IBM Corp
+ *
+ * Authors:
+ *  Pierre Morel <pmorel@linux.ibm.com>
+ *
+ * This code is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2.
+ */
+
+#include <libcflat.h>
+
+#include <css.h>
+
+#define SID_ONE		0x00010000
+
+static struct schib schib;
+
+static const char *Channel_type[3] = {
+	"I/O", "CHSC", "MSG"
+};
+
+static int test_device_sid;
+
+static void test_enumerate(void)
+{
+	struct pmcw *pmcw = &schib.pmcw;
+	int sid;
+	int ret, i;
+	int found = 0;
+
+	for (sid = 0; sid < 0xffff; sid++) {
+		ret = stsch(sid|SID_ONE, &schib);
+		if (!ret && (pmcw->flags & PMCW_DNV)) {
+			report_info("SID %04x Type %s PIM %x", sid,
+				     Channel_type[pmcw->st], pmcw->pim);
+			for (i = 0; i < 8; i++)  {
+				if ((pmcw->pim << i) & 0x80) {
+					report_info("CHPID[%d]: %02x", i,
+						    pmcw->chpid[i]);
+					break;
+				}
+			}
+			found++;
+	
+		}
+		if (found && !test_device_sid)
+			test_device_sid = sid|SID_ONE;
+	}
+	if (!found) {
+		report("Found %d devices", 0, found);
+		return;
+	}
+	ret = stsch(test_device_sid, &schib);
+	if (ret) {
+		report("Err %d on stsch on sid %08x", 0, ret, test_device_sid);
+		return;
+	}
+	report("Tested", 1);
+	return;
+}
+
+static struct {
+	const char *name;
+	void (*func)(void);
+} tests[] = {
+	{ "enumerate (stsch)", test_enumerate },
+	{ NULL, NULL }
+};
+
+int main(int argc, char *argv[])
+{
+	int i;
+
+	report_prefix_push("Channel Sub-System");
+	for (i = 0; tests[i].name; i++) {
+		report_prefix_push(tests[i].name);
+		tests[i].func();
+		report_prefix_pop();
+	}
+	report_prefix_pop();
+
+	return report_summary();
+}
diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
index ff4c088..efdf954 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -78,3 +78,7 @@ extra_params =-smp 2
 
 [uv-guest]
 file = uv-guest.elf
+
+[css]
+file = css.elf
+extra_params =-device ccw-pong
-- 
2.17.0

