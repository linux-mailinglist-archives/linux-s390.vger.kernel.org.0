Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608D6516D95
	for <lists+linux-s390@lfdr.de>; Mon,  2 May 2022 11:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384330AbiEBJnI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 2 May 2022 05:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384325AbiEBJnH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 May 2022 05:43:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D188E15A22;
        Mon,  2 May 2022 02:39:38 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2429SZtK013266;
        Mon, 2 May 2022 09:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BuVbl2O7LaJ7JVVaPTqpvp4eyadMsrWMX984dIIZ/Eg=;
 b=gwMaNkbSEe/tsUnyhDsnvYiXPlgAG6MPJa5uf9n3T119X9facrr2NwAQOo6CepjJdT3I
 w4l45aTNoAacvujEEyP45gdXcnWDpgJjXPfX45roOGrbZzw5NgVYX4NLeHvSQ0x+NJrP
 e4m0PIie+EKNju64ZG70ffuVWexJF1l3dsRt7Oh3CIAS/1WnR1tGxUJntEJDWnk1Zhkx
 gwCfDk2SQzdQzPTPvI/2tqX+s2m7kMHjLMUlrsJZPDN5dRZ0UU8aNEWmngDq5XtCQmro
 ZKZ9ZGgqgdEZZ4nbepCMOD/5n6JQCTWArOb2ks+kWyg2VVbfkIL+narCpVANEKv8Il5G PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ftcpxr6bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 09:39:37 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2429UkVD024803;
        Mon, 2 May 2022 09:39:37 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ftcpxr6b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 09:39:37 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2429dY5c004421;
        Mon, 2 May 2022 09:39:35 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3frvr8tfan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 09:39:35 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2429dWex49611192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 May 2022 09:39:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EBD8AE045;
        Mon,  2 May 2022 09:39:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD68AAE04D;
        Mon,  2 May 2022 09:39:31 +0000 (GMT)
Received: from linux7.. (unknown [9.114.12.92])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 May 2022 09:39:31 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     Thomas Huth <thuth@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH v5 6/6] s390x: Add attestation tests
Date:   Mon,  2 May 2022 09:39:25 +0000
Message-Id: <20220502093925.4118-7-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220502093925.4118-1-seiden@linux.ibm.com>
References: <20220502093925.4118-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z1bd9dN7TEvEB9eoF94sV9nCDEWe9YNm
X-Proofpoint-GUID: ah_F3ku9vA296L0wnGXw5fazFY0ZjAPw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_03,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205020074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Adds several tests to verify correct error paths of attestation.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 lib/s390x/asm/uv.h |   5 +-
 s390x/Makefile     |   1 +
 s390x/pv-attest.c  | 225 +++++++++++++++++++++++++++++++++++++++++++++
 s390x/uv-guest.c   |  11 ++-
 4 files changed, 240 insertions(+), 2 deletions(-)
 create mode 100644 s390x/pv-attest.c

diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
index 7c8c399d..38920461 100644
--- a/lib/s390x/asm/uv.h
+++ b/lib/s390x/asm/uv.h
@@ -108,7 +108,10 @@ struct uv_cb_qui {
 	u8  reserved88[158 - 136];	/* 0x0088 */
 	uint16_t max_guest_cpus;	/* 0x009e */
 	u64 uv_feature_indications;	/* 0x00a0 */
-	u8  reserveda8[200 - 168];	/* 0x00a8 */
+	uint8_t  reserveda8[224 - 168];	/* 0x00a8 */
+	uint64_t supp_att_hdr_ver;	/* 0x00e0 */
+	uint64_t supp_paf;		/* 0x00e8 */
+	uint8_t  reservedf0[256 - 240];	/* 0x00f0 */
 }  __attribute__((packed))  __attribute__((aligned(8)));
 
 struct uv_cb_cgc {
diff --git a/s390x/Makefile b/s390x/Makefile
index 8ff84db5..5a49d1e7 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -29,6 +29,7 @@ tests += $(TEST_DIR)/mvpg-sie.elf
 tests += $(TEST_DIR)/spec_ex-sie.elf
 tests += $(TEST_DIR)/firq.elf
 tests += $(TEST_DIR)/epsw.elf
+tests += $(TEST_DIR)/pv-attest.elf
 
 pv-tests += $(TEST_DIR)/pv-diags.elf
 
diff --git a/s390x/pv-attest.c b/s390x/pv-attest.c
new file mode 100644
index 00000000..65048349
--- /dev/null
+++ b/s390x/pv-attest.c
@@ -0,0 +1,225 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Retrieve Attestation Measurement Utravisor Call tests
+ *
+ * Copyright IBM Corp. 2022
+ *
+ * Authors:
+ *  Steffen Eiden <seiden@linux.ibm.com>
+ */
+
+#include <libcflat.h>
+#include <alloc_page.h>
+#include <asm/page.h>
+#include <asm/facility.h>
+#include <asm/uv.h>
+#include <sclp.h>
+#include <uv.h>
+
+#define ARCB_VERSION_NONE 0
+#define ARCB_VERSION_1 0x100
+#define ARCB_MEAS_NONE 0
+#define ARCB_MEAS_HMAC_SHA512 1
+#define MEASUREMENT_SIZE_HMAC_SHA512 64
+#define PAF_PHKH_ATT (1ULL << 61)
+#define ADDITIONAL_SIZE_PAF_PHKH_ATT 32
+/* arcb with one key slot and no nonce */
+struct uv_arcb_v1 {
+	uint64_t reserved0;		/* 0x0000 */
+	uint32_t req_ver;		/* 0x0008 */
+	uint32_t req_len;		/* 0x000c */
+	uint8_t  iv[12];		/* 0x0010 */
+	uint32_t reserved1c;		/* 0x001c */
+	uint8_t  reserved20[7];		/* 0x0020 */
+	uint8_t  nks;			/* 0x0027 */
+	int32_t reserved28;		/* 0x0028 */
+	uint32_t sea;			/* 0x002c */
+	uint64_t plaint_att_flags;	/* 0x0030 */
+	uint32_t meas_alg_id;		/* 0x0038 */
+	uint32_t reserved3c;		/* 0x003c */
+	uint8_t  cpk[160];		/* 0x0040 */
+	uint8_t  key_slot[80];		/* 0x00e0 */
+	uint8_t  meas_key[64];		/* 0x0130 */
+	uint8_t  tag[16];		/* 0x0170 */
+} __attribute__((packed));
+
+struct attest_request_v1 {
+	struct uv_arcb_v1 arcb;
+	uint8_t measurement[MEASUREMENT_SIZE_HMAC_SHA512];
+	uint8_t additional[ADDITIONAL_SIZE_PAF_PHKH_ATT];
+};
+
+static void test_attest_v1(uint64_t page)
+{
+	struct uv_cb_attest uvcb = {
+		.header.cmd = UVC_CMD_ATTESTATION,
+		.header.len = sizeof(uvcb),
+	};
+	const struct uv_cb_qui *uvcb_qui = uv_get_query_data();
+	struct attest_request_v1 *attest_req = (void *)page;
+	struct uv_arcb_v1 *arcb = &attest_req->arcb;
+	int cc;
+
+	report_prefix_push("v1");
+	if (!test_bit_inv(0, &uvcb_qui->supp_att_hdr_ver)) {
+		report_skip("Attestation version 1 not supported");
+		goto done;
+	}
+
+	memset((void *)page, 0, PAGE_SIZE);
+
+	/*
+	 * Create a minimal arcb/uvcb such that FW has everything to start
+	 * unsealing the request. However, this unsealing will fail as the
+	 * kvm-unit-test framework provides no cryptography functions that
+	 * would be needed to seal such requests.
+	 */
+	arcb->req_ver = ARCB_VERSION_1;
+	arcb->req_len = sizeof(*arcb);
+	arcb->nks = 1;
+	arcb->sea = sizeof(arcb->meas_key);
+	arcb->plaint_att_flags = PAF_PHKH_ATT;
+	arcb->meas_alg_id = ARCB_MEAS_HMAC_SHA512;
+	uvcb.arcb_addr = (uint64_t)&attest_req->arcb;
+	uvcb.measurement_address = (uint64_t)attest_req->measurement;
+	uvcb.measurement_length = sizeof(attest_req->measurement);
+	uvcb.add_data_address = (uint64_t)attest_req->additional;
+	uvcb.add_data_length = sizeof(attest_req->additional);
+
+	uvcb.continuation_token = 0xff;
+	cc = uv_call(0, (uint64_t)&uvcb);
+	report(cc == 1 && uvcb.header.rc == 0x101, "invalid continuation token");
+	uvcb.continuation_token = 0;
+
+	uvcb.user_data_length = sizeof(uvcb.user_data) + 1;
+	cc = uv_call(0, (uint64_t)&uvcb);
+	report(cc == 1 && uvcb.header.rc == 0x102, "invalid user data size");
+	uvcb.user_data_length = 0;
+
+	uvcb.arcb_addr = get_ram_size() + PAGE_SIZE;
+	cc = uv_call(0, (uint64_t)&uvcb);
+	report(cc == 1 && uvcb.header.rc == 0x103, "invalid arcb address");
+	uvcb.arcb_addr = page;
+
+	/* 0x104 - 0x105 need an unseal-able request */
+
+	arcb->req_ver = ARCB_VERSION_NONE;
+	cc = uv_call(0, (uint64_t)&uvcb);
+	report(cc == 1 && uvcb.header.rc == 0x106, "unsupported version");
+	arcb->req_ver = ARCB_VERSION_1;
+
+	arcb->req_len += 1;
+	cc = uv_call(0, (uint64_t)&uvcb);
+	report(cc == 1 && uvcb.header.rc == 0x107, "arcb too big");
+	arcb->req_len -= 1;
+
+	/*
+	 * The arcb needs to grow as well if number of key slots (nks)
+	 * is increased. However, this is not the case and there is no explicit
+	 * 'too many/less nks for that arcb size' error code -> expect 0x107
+	 */
+	arcb->nks = 2;
+	cc = uv_call(0, (uint64_t)&uvcb);
+	report(cc == 1 && uvcb.header.rc == 0x107, "too many nks for arcb");
+	arcb->nks = 1;
+
+	arcb->nks = 0;
+	cc = uv_call(0, (uint64_t)&uvcb);
+	report(cc == 1 && uvcb.header.rc == 0x108, "invalid num key slots");
+	arcb->nks = 1;
+
+	/*
+	 * Possible valid size (when using nonce).
+	 * However, req_len too small to host a nonce
+	 */
+	arcb->sea = 80;
+	cc = uv_call(0, (uint64_t)&uvcb);
+	report(cc == 1 && uvcb.header.rc == 0x109, "encrypted size too big");
+	arcb->sea = 17;
+	cc = uv_call(0, (uint64_t)&uvcb);
+	report(cc == 1 && uvcb.header.rc == 0x109, "encrypted size too small");
+	arcb->sea = 64;
+
+	arcb->plaint_att_flags = uvcb_qui->supp_paf ^ GENMASK_ULL(63, 0);
+	cc = uv_call(0, (uint64_t)&uvcb);
+	report(cc == 1 && uvcb.header.rc == 0x10a, "invalid flag");
+	arcb->plaint_att_flags = PAF_PHKH_ATT;
+
+	arcb->meas_alg_id = ARCB_MEAS_NONE;
+	cc = uv_call(0, (uint64_t)&uvcb);
+	report(cc == 1 && uvcb.header.rc == 0x10b, "invalid measurement algorithm");
+	arcb->meas_alg_id = ARCB_MEAS_HMAC_SHA512;
+
+	cc = uv_call(0, (uint64_t)&uvcb);
+	report(cc == 1 && uvcb.header.rc == 0x10c, "unable unseal");
+
+	uvcb.measurement_length = 0;
+	cc = uv_call(0, (uint64_t)&uvcb);
+	report(cc == 1 && uvcb.header.rc == 0x10d, "invalid measurement size");
+	uvcb.measurement_length = sizeof(attest_req->measurement);
+
+	uvcb.add_data_length = 0;
+	cc = uv_call(0, (uint64_t)&uvcb);
+	report(cc == 1 && uvcb.header.rc == 0x10e, "invalid additional size");
+	uvcb.add_data_length = sizeof(attest_req->additional);
+
+done:
+	report_prefix_pop();
+}
+
+static void test_attest(uint64_t page)
+{
+	struct uv_cb_attest uvcb = {
+		.header.cmd = UVC_CMD_ATTESTATION,
+		.header.len = sizeof(uvcb),
+	};
+	const struct uv_cb_qui *uvcb_qui = uv_get_query_data();
+	int cc;
+
+	/* Verify that the UV supports at least one header version */
+	report(uvcb_qui->supp_att_hdr_ver, "has hdr support");
+
+	memset((void *)page, 0, PAGE_SIZE);
+
+	uvcb.header.len -= 1;
+	cc = uv_call(0, (uint64_t)&uvcb);
+	report(cc && uvcb.header.rc == UVC_RC_INV_LEN, "uvcb too small");
+	uvcb.header.len += 1;
+
+	uvcb.header.len += 1;
+	cc = uv_call(0, (uint64_t)&uvcb);
+	report(cc && uvcb.header.rc == UVC_RC_INV_LEN, "uvcb too large");
+	uvcb.header.len -= 1;
+}
+
+int main(void)
+{
+	bool has_uvc = test_facility(158);
+	uint64_t page;
+
+
+	report_prefix_push("attestation");
+	if (!has_uvc) {
+		report_skip("Ultravisor call facility is not available");
+		goto done;
+	}
+
+	if (!uv_os_is_guest()) {
+		report_skip("Not a protected guest");
+		goto done;
+	}
+
+	if (!uv_query_test_call(BIT_UVC_CMD_ATTESTATION)) {
+		report_skip("Attestation not supported.");
+		goto done;
+	}
+
+	page = (uint64_t)alloc_page();
+	/* The privilege check is done in uv-guest.c */
+	test_attest(page);
+	test_attest_v1(page);
+	free_page((void *)page);
+done:
+	report_prefix_pop();
+	return report_summary();
+}
diff --git a/s390x/uv-guest.c b/s390x/uv-guest.c
index 152ad807..c16f19d4 100644
--- a/s390x/uv-guest.c
+++ b/s390x/uv-guest.c
@@ -2,7 +2,7 @@
 /*
  * Guest Ultravisor Call tests
  *
- * Copyright (c) 2020 IBM Corp
+ * Copyright IBM Corp. 2020, 2022
  *
  * Authors:
  *  Janosch Frank <frankja@linux.ibm.com>
@@ -53,6 +53,15 @@ static void test_priv(void)
 	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
 	report_prefix_pop();
 
+	report_prefix_push("attest");
+	uvcb.cmd = UVC_CMD_ATTESTATION;
+	uvcb.len = sizeof(struct uv_cb_attest);
+	expect_pgm_int();
+	enter_pstate();
+	uv_call_once(0, (uint64_t)&uvcb);
+	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
+	report_prefix_pop();
+
 	report_prefix_pop();
 }
 
-- 
2.30.2

