Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F044388841
	for <lists+linux-s390@lfdr.de>; Wed, 19 May 2021 09:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbhESHmH (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 19 May 2021 03:42:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39066 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240620AbhESHmG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 May 2021 03:42:06 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14J7YwUp105831;
        Wed, 19 May 2021 03:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bThTQ1Wpivr9h6ESx2ObTmYPBqdaVdJyCLpeVXTxs48=;
 b=GahniPky3xsAntZP/dxJSP23B74u1qtgQP0hmPTygHlexVsapN5ur/ufVfK/8K1dck70
 33U9WPBmdmtBbemDqFN0KwrVU5/JU4PcPeyFd9QXXLeGEESBYla4QWg2hGRfO8/u6vWI
 RyQMNOj2r2cIcgBnpoAHIUL0XR1fXDT4F/+xPVURW0mzQbi4Q1JQ0qA9ex4Ann1U0I+l
 5RyjJdyUPtDVCPVhqv2kjVk5lf5RxdJPrk4NdCrCf82ooqGmx9w/FD/BTVfgxLR55vUr
 sljaYDkAHwTIIgrZEQPXkk4xMt6KeJFrRdO2Wws3sVhzwVoss7SN6KM7XdyxbmChzFit xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38mxbs0a1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 03:40:46 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14J7ZMTj107274;
        Wed, 19 May 2021 03:40:46 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38mxbs0a02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 03:40:45 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14J7bkGf010075;
        Wed, 19 May 2021 07:40:44 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 38m19sreqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 07:40:43 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14J7efma33882560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 07:40:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B0C3A4054;
        Wed, 19 May 2021 07:40:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DD40A405C;
        Wed, 19 May 2021 07:40:40 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 May 2021 07:40:40 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        thuth@redhat.com
Subject: [kvm-unit-tests PATCH v3 6/6] s390x: Add UV host test
Date:   Wed, 19 May 2021 07:40:22 +0000
Message-Id: <20210519074022.7368-7-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210519074022.7368-1-frankja@linux.ibm.com>
References: <20210519074022.7368-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WDwz757QkV4MFPnnRJ09Av9a2XpMncwH
X-Proofpoint-ORIG-GUID: _6--r5jvhChrbDy25EXeex4HpUSE3Rdv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_02:2021-05-18,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190055
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Let's also test the UV host interfaces.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 s390x/Makefile  |   1 +
 s390x/uv-host.c | 480 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 481 insertions(+)
 create mode 100644 s390x/uv-host.c

diff --git a/s390x/Makefile b/s390x/Makefile
index bbf177fa..8de926ab 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -21,6 +21,7 @@ tests += $(TEST_DIR)/css.elf
 tests += $(TEST_DIR)/uv-guest.elf
 tests += $(TEST_DIR)/sie.elf
 tests += $(TEST_DIR)/mvpg.elf
+tests += $(TEST_DIR)/uv-host.elf
 
 tests_binary = $(patsubst %.elf,%.bin,$(tests))
 ifneq ($(HOST_KEY_DOCUMENT),)
diff --git a/s390x/uv-host.c b/s390x/uv-host.c
new file mode 100644
index 00000000..49c66f17
--- /dev/null
+++ b/s390x/uv-host.c
@@ -0,0 +1,480 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Guest Ultravisor Call tests
+ *
+ * Copyright (c) 2021 IBM Corp
+ *
+ * Authors:
+ *  Janosch Frank <frankja@linux.ibm.com>
+ */
+
+#include <libcflat.h>
+#include <alloc.h>
+#include <vmalloc.h>
+#include <sclp.h>
+#include <smp.h>
+#include <uv.h>
+#include <asm/page.h>
+#include <asm/sigp.h>
+#include <asm/pgtable.h>
+#include <asm/asm-offsets.h>
+#include <asm/interrupt.h>
+#include <asm/facility.h>
+#include <asm/uv.h>
+#include <asm-generic/barrier.h>
+
+static struct uv_cb_qui uvcb_qui;
+static struct uv_cb_init uvcb_init;
+static struct uv_cb_cgc uvcb_cgc;
+static struct uv_cb_csc uvcb_csc;
+
+extern int diag308_load_reset(u64 code);
+
+struct cmd_list{
+	const char *name;
+	uint16_t cmd;
+	uint16_t len;
+	int call_bit;
+};
+
+static void cpu_loop(void)
+{
+	for (;;) {}
+}
+
+static struct cmd_list cmds[] = {
+	{ "init", UVC_CMD_INIT_UV, sizeof(struct uv_cb_init), BIT_UVC_CMD_INIT_UV },
+	{ "create conf", UVC_CMD_CREATE_SEC_CONF, sizeof(struct uv_cb_cgc), BIT_UVC_CMD_CREATE_SEC_CONF },
+	{ "destroy conf", UVC_CMD_DESTROY_SEC_CONF, sizeof(struct uv_cb_nodata), BIT_UVC_CMD_DESTROY_SEC_CONF },
+	{ "create cpu", UVC_CMD_CREATE_SEC_CPU, sizeof(struct uv_cb_csc), BIT_UVC_CMD_CREATE_SEC_CPU },
+	{ "destroy cpu", UVC_CMD_DESTROY_SEC_CPU, sizeof(struct uv_cb_nodata), BIT_UVC_CMD_DESTROY_SEC_CPU },
+	{ "conv to", UVC_CMD_CONV_TO_SEC_STOR, sizeof(struct uv_cb_cts), BIT_UVC_CMD_CONV_TO_SEC_STOR },
+	{ "conv from", UVC_CMD_CONV_FROM_SEC_STOR, sizeof(struct uv_cb_cfs), BIT_UVC_CMD_CONV_FROM_SEC_STOR },
+	{ "set sec conf", UVC_CMD_SET_SEC_CONF_PARAMS, sizeof(struct uv_cb_ssc), BIT_UVC_CMD_SET_SEC_PARMS },
+	{ "unpack", UVC_CMD_UNPACK_IMG, sizeof(struct uv_cb_unp), BIT_UVC_CMD_UNPACK_IMG },
+	{ "verify", UVC_CMD_VERIFY_IMG, sizeof(struct uv_cb_nodata), BIT_UVC_CMD_VERIFY_IMG },
+	{ "cpu reset", UVC_CMD_CPU_RESET, sizeof(struct uv_cb_nodata), BIT_UVC_CMD_CPU_RESET },
+	{ "cpu initial reset", UVC_CMD_CPU_RESET_INITIAL, sizeof(struct uv_cb_nodata), BIT_UVC_CMD_CPU_RESET_INITIAL },
+	{ "conf clear reset", UVC_CMD_PERF_CONF_CLEAR_RESET, sizeof(struct uv_cb_nodata), BIT_UVC_CMD_PREPARE_CLEAR_RESET },
+	{ "cpu clear reset", UVC_CMD_CPU_RESET_CLEAR, sizeof(struct uv_cb_nodata), BIT_UVC_CMD_CPU_PERFORM_CLEAR_RESET },
+	{ "cpu set state", UVC_CMD_CPU_SET_STATE, sizeof(struct uv_cb_cpu_set_state), BIT_UVC_CMD_CPU_SET_STATE },
+	{ "pin shared", UVC_CMD_PIN_PAGE_SHARED, sizeof(struct uv_cb_cfs), BIT_UVC_CMD_PIN_PAGE_SHARED },
+	{ "unpin shared", UVC_CMD_UNPIN_PAGE_SHARED, sizeof(struct uv_cb_cts), BIT_UVC_CMD_UNPIN_PAGE_SHARED },
+	{ NULL, 0, 0 },
+};
+
+static void test_priv(void)
+{
+	struct uv_cb_header uvcb = {};
+	uint16_t pgm;
+	int i;
+
+	report_prefix_push("privileged");
+	for (i = 0; cmds[i].name; i++) {
+		expect_pgm_int();
+		uvcb.cmd = cmds[i].cmd;
+		uvcb.len = cmds[i].len;
+		enter_pstate();
+		uv_call(0, (uint64_t)&uvcb);
+		pgm = clear_pgm_int();
+		report(pgm == PGM_INT_CODE_PRIVILEGED_OPERATION, "%s", cmds[i].name);
+	}
+	report_prefix_pop();
+}
+
+static void test_config_destroy(void)
+{
+	int rc;
+	struct uv_cb_nodata uvcb = {
+		.header.cmd = UVC_CMD_DESTROY_SEC_CONF,
+		.header.len = sizeof(uvcb),
+		.handle = uvcb_cgc.guest_handle,
+	};
+
+	report_prefix_push("dsc");
+	uvcb.header.len -= 8;
+	rc = uv_call(0, (uint64_t)&uvcb);
+	report(rc == 1 && uvcb.header.rc == UVC_RC_INV_LEN,
+	       "hdr invalid length");
+	uvcb.header.len += 8;
+
+	uvcb.handle += 1;
+	rc = uv_call(0, (uint64_t)&uvcb);
+	report(rc == 1 && uvcb.header.rc == UVC_RC_INV_GHANDLE, "invalid handle");
+	uvcb.handle -= 1;
+
+	rc = uv_call(0, (uint64_t)&uvcb);
+	report(rc == 0 && uvcb.header.rc == UVC_RC_EXECUTED, "success");
+	report_prefix_pop();
+}
+
+static void test_cpu_destroy(void)
+{
+	int rc;
+	struct uv_cb_nodata uvcb = {
+		.header.len = sizeof(uvcb),
+		.header.cmd = UVC_CMD_DESTROY_SEC_CPU,
+		.handle = uvcb_csc.cpu_handle,
+	};
+
+	report_prefix_push("dcpu");
+
+	uvcb.header.len -= 8;
+	rc = uv_call(0, (uint64_t)&uvcb);
+	report(rc == 1 && uvcb.header.rc == UVC_RC_INV_LEN,
+	       "hdr invalid length");
+	uvcb.header.len += 8;
+
+	uvcb.handle += 1;
+	rc = uv_call(0, (uint64_t)&uvcb);
+	report(rc == 1 && uvcb.header.rc == UVC_RC_INV_CHANDLE, "invalid handle");
+	uvcb.handle -= 1;
+
+	rc = uv_call(0, (uint64_t)&uvcb);
+	report(rc == 0 && uvcb.header.rc == UVC_RC_EXECUTED, "success");
+
+	report_prefix_pop();
+}
+
+static void test_cpu_create(void)
+{
+	int rc;
+	unsigned long tmp;
+
+	report_prefix_push("csc");
+	uvcb_csc.header.len = sizeof(uvcb_csc);
+	uvcb_csc.header.cmd = UVC_CMD_CREATE_SEC_CPU;
+	uvcb_csc.guest_handle = uvcb_cgc.guest_handle;
+	uvcb_csc.stor_origin = (unsigned long)memalign(PAGE_SIZE, uvcb_qui.cpu_stor_len);
+	uvcb_csc.state_origin = (unsigned long)memalign(PAGE_SIZE, PAGE_SIZE);
+
+	uvcb_csc.header.len -= 8;
+	rc = uv_call(0, (uint64_t)&uvcb_csc);
+	report(uvcb_csc.header.rc == UVC_RC_INV_LEN && rc == 1 &&
+	       !uvcb_csc.cpu_handle, "hdr invalid length");
+	uvcb_csc.header.len += 8;
+
+	uvcb_csc.guest_handle += 1;
+	rc = uv_call(0, (uint64_t)&uvcb_csc);
+	report(uvcb_csc.header.rc == UVC_RC_INV_GHANDLE && rc == 1,
+	       "invalid guest handle");
+	uvcb_csc.guest_handle -= 1;
+
+	uvcb_csc.num = uvcb_qui.max_guest_cpus + 1;
+	rc = uv_call(0, (uint64_t)&uvcb_csc);
+	report(uvcb_csc.header.rc == 0x103 && rc == 1,
+	       "invalid cpu #");
+	uvcb_csc.num = 0;
+
+	tmp = uvcb_csc.stor_origin;
+	uvcb_csc.stor_origin = get_max_ram_size() + PAGE_SIZE;
+	rc = uv_call(0, (uint64_t)&uvcb_csc);
+	report(uvcb_csc.header.rc == 0x105 && rc == 1,
+	       "cpu stor inaccessible");
+	uvcb_csc.stor_origin = tmp;
+
+	tmp = uvcb_csc.stor_origin;
+	uvcb_csc.stor_origin = 0;
+	rc = uv_call(0, (uint64_t)&uvcb_csc);
+	report(uvcb_csc.header.rc == 0x106 && rc == 1,
+	       "cpu stor in lowcore");
+	uvcb_csc.stor_origin = tmp;
+
+	tmp = uvcb_csc.state_origin;
+	uvcb_csc.state_origin = get_max_ram_size() + PAGE_SIZE;
+	rc = uv_call(0, (uint64_t)&uvcb_csc);
+	report(uvcb_csc.header.rc == 0x107 && rc == 1,
+	       "SIE SD inaccessible");
+	uvcb_csc.state_origin = tmp;
+
+	rc = uv_call(0, (uint64_t)&uvcb_csc);
+	report(rc == 0 && uvcb_csc.header.rc == UVC_RC_EXECUTED &&
+	       uvcb_csc.cpu_handle, "success");
+
+	tmp = uvcb_csc.stor_origin;
+	uvcb_csc.stor_origin = (unsigned long)memalign(PAGE_SIZE, uvcb_qui.cpu_stor_len);
+	rc = uv_call(0, (uint64_t)&uvcb_csc);
+	report(rc == 1 && uvcb_csc.header.rc == 0x104, "already defined");
+	uvcb_csc.stor_origin = tmp;
+	report_prefix_pop();
+}
+
+static void test_config_create(void)
+{
+	int rc;
+	unsigned long vsize, tmp;
+	static struct uv_cb_cgc uvcb;
+
+	uvcb_cgc.header.cmd = UVC_CMD_CREATE_SEC_CONF;
+	uvcb_cgc.header.len = sizeof(uvcb_cgc);
+	report_prefix_push("cgc");
+
+	uvcb_cgc.guest_stor_origin = 0;
+	uvcb_cgc.guest_stor_len = 42 * (1UL << 20);
+	vsize = uvcb_qui.conf_base_virt_stor_len +
+		((uvcb_cgc.guest_stor_len / (1UL << 20)) * uvcb_qui.conf_virt_var_stor_len);
+
+	uvcb_cgc.conf_base_stor_origin = (uint64_t)memalign(PAGE_SIZE * 4, uvcb_qui.conf_base_phys_stor_len);
+	uvcb_cgc.conf_var_stor_origin = (uint64_t)memalign(PAGE_SIZE, vsize);
+	uvcb_cgc.guest_asce = (uint64_t)memalign(PAGE_SIZE, 4 * PAGE_SIZE) | ASCE_DT_SEGMENT | REGION_TABLE_LENGTH | ASCE_P;
+	uvcb_cgc.guest_sca = (uint64_t)memalign(PAGE_SIZE * 4, PAGE_SIZE * 4);
+
+	uvcb_cgc.header.len -= 8;
+	rc = uv_call(0, (uint64_t)&uvcb_cgc);
+	report(uvcb_cgc.header.rc == UVC_RC_INV_LEN && rc == 1 &&
+	       !uvcb_cgc.guest_handle, "hdr invalid length");
+	uvcb_cgc.header.len += 8;
+
+	uvcb_cgc.guest_stor_origin = uvcb_qui.max_guest_stor_addr + (1UL << 20) * 2 + 1;
+	rc = uv_call(0, (uint64_t)&uvcb_cgc);
+	report(uvcb_cgc.header.rc == 0x101 && rc == 1,
+	       "MSO > max guest addr");
+	uvcb_cgc.guest_stor_origin = 0;
+
+	uvcb_cgc.guest_stor_origin = uvcb_qui.max_guest_stor_addr - (1UL << 20);
+	rc = uv_call(0, (uint64_t)&uvcb_cgc);
+	report(uvcb_cgc.header.rc == 0x102 && rc == 1,
+	       "MSO + MSL > max guest addr");
+	uvcb_cgc.guest_stor_origin = 0;
+
+	uvcb_cgc.guest_asce &= ~ASCE_P;
+	rc = uv_call(0, (uint64_t)&uvcb_cgc);
+	report(uvcb_cgc.header.rc == 0x105 && rc == 1,
+	       "ASCE private bit missing");
+	uvcb_cgc.guest_asce |= ASCE_P;
+
+	uvcb_cgc.guest_asce |= 0x20;
+	rc = uv_call(0, (uint64_t)&uvcb_cgc);
+	report(uvcb_cgc.header.rc == 0x105 && rc == 1,
+	       "ASCE bit 58 set");
+	uvcb_cgc.guest_asce &= ~0x20;
+
+	tmp = uvcb_cgc.conf_base_stor_origin;
+	uvcb_cgc.conf_base_stor_origin = get_max_ram_size() + 8;
+	rc = uv_call(0, (uint64_t)&uvcb_cgc);
+	report(uvcb_cgc.header.rc == 0x108 && rc == 1,
+	       "base storage origin > available memory");
+	uvcb_cgc.conf_base_stor_origin = tmp;
+
+	tmp = uvcb_cgc.conf_base_stor_origin;
+	uvcb_cgc.conf_base_stor_origin = 0x1000;
+	rc = uv_call(0, (uint64_t)&uvcb_cgc);
+	report(uvcb_cgc.header.rc == 0x109 && rc == 1,
+	       "base storage origin contains lowcore");
+	uvcb_cgc.conf_base_stor_origin = tmp;
+
+	if (smp_query_num_cpus() == 1) {
+		sigp_retry(1, SIGP_SET_PREFIX,
+			   uvcb_cgc.conf_var_stor_origin + PAGE_SIZE, NULL);
+		rc = uv_call(0, (uint64_t)&uvcb_cgc);
+		report(uvcb_cgc.header.rc == 0x10e && rc == 1 &&
+		       !uvcb_cgc.guest_handle, "variable storage area contains lowcore");
+		sigp_retry(1, SIGP_SET_PREFIX, 0x0, NULL);
+	}
+
+	tmp = uvcb_cgc.guest_sca;
+	uvcb_cgc.guest_sca = 0;
+	rc = uv_call(0, (uint64_t)&uvcb_cgc);
+	report(uvcb_cgc.header.rc == 0x10c && rc == 1,
+	       "sca == 0");
+	uvcb_cgc.guest_sca = tmp;
+
+	tmp = uvcb_cgc.guest_sca;
+	uvcb_cgc.guest_sca = get_max_ram_size() + + PAGE_SIZE * 4;
+	rc = uv_call(0, (uint64_t)&uvcb_cgc);
+	report(uvcb_cgc.header.rc == 0x10d && rc == 1,
+	       "sca inaccessible");
+	uvcb_cgc.guest_sca = tmp;
+
+	rc = uv_call(0, (uint64_t)&uvcb_cgc);
+	report(rc == 0 && uvcb_cgc.header.rc == UVC_RC_EXECUTED, "successful");
+
+	uvcb_cgc.header.rc = 0;
+	uvcb_cgc.header.rrc = 0;
+	tmp = uvcb_cgc.guest_handle;
+	uvcb_cgc.guest_handle = 0;
+	rc = uv_call(0, (uint64_t)&uvcb_cgc);
+	report(uvcb_cgc.header.rc >= 0x100 && rc == 1, "reuse uvcb");
+	uvcb_cgc.guest_handle = tmp;
+
+	/* Copy over most data from uvcb_cgc, so we have the ASCE that was used. */
+	memcpy(&uvcb, &uvcb_cgc, sizeof(uvcb));
+
+	/* Reset the header and handle */
+	uvcb.header.rc = 0;
+	uvcb.header.rrc = 0;
+	uvcb.guest_handle = 0;
+
+	/* Use new storage areas. */
+	uvcb.conf_base_stor_origin = (uint64_t)memalign(PAGE_SIZE * 4, uvcb_qui.conf_base_phys_stor_len);
+	uvcb.conf_var_stor_origin = (uint64_t)memalign(PAGE_SIZE, vsize);
+
+	rc = uv_call(0, (uint64_t)&uvcb);
+	report(uvcb.header.rc >= 0x104 && rc == 1 && !uvcb.guest_handle,
+	       "reuse ASCE");
+	free((void *)uvcb.conf_base_stor_origin);
+	free((void *)uvcb.conf_var_stor_origin);
+
+	/* Missing: 106, 10a, a0b */
+	report_prefix_pop();
+}
+
+static void test_init(void)
+{
+	int rc;
+	uint64_t mem;
+	struct psw psw;
+
+	/* Donated storage needs to be over 2GB */
+	mem = (uint64_t)memalign(1UL << 31, uvcb_qui.uv_base_stor_len);
+
+	uvcb_init.header.len = sizeof(uvcb_init);
+	uvcb_init.header.cmd = UVC_CMD_INIT_UV;
+	uvcb_init.stor_origin = mem;
+	uvcb_init.stor_len = uvcb_qui.uv_base_stor_len;
+
+	report_prefix_push("init");
+	uvcb_init.header.len -= 8;
+	rc = uv_call(0, (uint64_t)&uvcb_init);
+	report(rc == 1 && uvcb_init.header.rc == UVC_RC_INV_LEN,
+	       "hdr invalid length");
+	uvcb_init.header.len += 8;
+
+	uvcb_init.stor_len -= 8;
+	rc = uv_call(0, (uint64_t)&uvcb_init);
+	report(rc == 1 && uvcb_init.header.rc == 0x103,
+	       "storage invalid length");
+	uvcb_init.stor_len += 8;
+
+	uvcb_init.stor_origin =  get_max_ram_size() + 8;
+	rc = uv_call(0, (uint64_t)&uvcb_init);
+	report(rc == 1 && uvcb_init.header.rc == 0x104,
+	       "storage origin invalid");
+	uvcb_init.stor_origin = mem;
+
+	uvcb_init.stor_origin = get_max_ram_size() - 8;
+	rc = uv_call(0, (uint64_t)&uvcb_init);
+	report(rc == 1 && uvcb_init.header.rc == 0x105,
+	       "storage + length invalid");
+	uvcb_init.stor_origin = mem;
+
+	uvcb_init.stor_origin = 1UL << 30;
+	rc = uv_call(0, (uint64_t)&uvcb_init);
+	report(rc == 1 && uvcb_init.header.rc == 0x108,
+	       "storage below 2GB");
+	uvcb_init.stor_origin = mem;
+
+	psw.mask = extract_psw_mask();
+	psw.addr = (unsigned long)cpu_loop;
+	smp_cpu_setup(1, psw);
+	rc = uv_call(0, (uint64_t)&uvcb_init);
+	report(rc == 1 && uvcb_init.header.rc == 0x102,
+	       "too many running cpus");
+	smp_cpu_stop(1);
+
+	rc = uv_call(0, (uint64_t)&uvcb_init);
+	report(rc == 0 && uvcb_init.header.rc == UVC_RC_EXECUTED, "successful");
+
+	mem = (uint64_t)memalign(1UL << 31, uvcb_qui.uv_base_stor_len);
+	rc = uv_call(0, (uint64_t)&uvcb_init);
+	report(rc == 1 && uvcb_init.header.rc == 0x101, "double init");
+	free((void *)mem);
+
+	report_prefix_pop();
+}
+
+static void test_query(void)
+{
+	int i = 0;
+
+	uvcb_qui.header.cmd = UVC_CMD_QUI;
+	uvcb_qui.header.len = sizeof(uvcb_qui);
+
+	report_prefix_push("query");
+	uvcb_qui.header.len = 0xa0;
+	uv_call(0, (uint64_t)&uvcb_qui);
+	report(uvcb_qui.header.rc == UVC_RC_INV_LEN, "length");
+
+	uvcb_qui.header.len = 0xa8;
+	uv_call(0, (uint64_t)&uvcb_qui);
+	report(uvcb_qui.header.rc == 0x100, "insf length");
+
+	uvcb_qui.header.len = sizeof(uvcb_qui);
+	uv_call(0, (uint64_t)&uvcb_qui);
+	report(uvcb_qui.header.rc == UVC_RC_EXECUTED, "successful query");
+
+	for (i = 0; cmds[i].name; i++)
+		report(uv_query_test_call(cmds[i].call_bit), "%s", cmds[i].name);
+
+	report_prefix_pop();
+}
+
+static struct cmd_list invalid_cmds[] = {
+	{ "bogus", 0x4242, sizeof(struct uv_cb_header), -1},
+	{ "share", UVC_CMD_SET_SHARED_ACCESS, sizeof(struct uv_cb_share), BIT_UVC_CMD_SET_SHARED_ACCESS },
+	{ "unshare", UVC_CMD_REMOVE_SHARED_ACCESS, sizeof(struct uv_cb_share), BIT_UVC_CMD_REMOVE_SHARED_ACCESS },
+	{ NULL, 0, 0 },
+};
+
+static void test_invalid(void)
+{
+	struct uv_cb_header hdr = {};
+	int i, cc;
+
+	report_prefix_push("invalid");
+	for (i = 0; invalid_cmds[i].name; i++) {
+		hdr.cmd = invalid_cmds[i].cmd;
+		hdr.len = invalid_cmds[i].len;
+		cc = uv_call(0, (uint64_t)&hdr);
+		report(cc == 1 && hdr.rc == UVC_RC_INV_CMD &&
+		       (invalid_cmds[i].call_bit == -1 || !uv_query_test_call(invalid_cmds[i].call_bit)),
+		       "%s", invalid_cmds[i].name);
+	}
+	report_prefix_pop();
+}
+
+static void test_clear(void)
+{
+	uint64_t *tmp = (void *)uvcb_init.stor_origin;
+
+	diag308_load_reset(1);
+	sclp_console_setup();
+	report(!*tmp, "memory cleared after reset 1");
+}
+
+static void setup_vmem(void)
+{
+	uint64_t asce, mask;
+
+	setup_mmu(get_max_ram_size());
+	asce = stctg(1);
+	lctlg(13, asce);
+	mask = extract_psw_mask() | 0x0000C00000000000UL;
+	load_psw_mask(mask);
+}
+
+int main(void)
+{
+	bool has_uvc = test_facility(158);
+
+	report_prefix_push("uvc");
+	if (!has_uvc) {
+		report_skip("Ultravisor call facility is not available");
+		goto done;
+	}
+
+	test_priv();
+	test_invalid();
+	test_query();
+	test_init();
+
+	setup_vmem();
+	test_config_create();
+	test_cpu_create();
+	test_cpu_destroy();
+	test_config_destroy();
+	test_clear();
+
+done:
+	return report_summary();
+}
-- 
2.30.2

