Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C61734E0D
	for <lists+linux-s390@lfdr.de>; Mon, 19 Jun 2023 10:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjFSIhm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 19 Jun 2023 04:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjFSIhV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 19 Jun 2023 04:37:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119BB171D;
        Mon, 19 Jun 2023 01:35:04 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J8LsAF028457;
        Mon, 19 Jun 2023 08:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=huzk1GvlBydAsRnwcD+SkNYO/BWmYOhFKSb8WjIXIyE=;
 b=j5/steU706eNnCgWh0fG9v+UB+rfr+i+BbRiT9ga8DbYVJC52TcFFalwGL9d3Gq6SEnM
 6NxN+9xzCYeI+7MlFoJeRrqR7iWsNFPbrjs9QRGD5CNKXjusUFfombgKTeUnl2VVnMBE
 ff3j25iaWm4RjHZCDfKW4SNMmDKVkh6KMlIFuwwr5U+7TTu2R/yy4s7Up7FA4gz2dqtd
 +fSDeu88sMfmFWidZfgSwf8oIYSqtm1wQdMWBeLAs/+wQOc4pqAohyrL6XqO9uZ3pW95
 6oUlMuhOW//iiFttLPtAOYJEcwZmjG0kDFRnqZps5b5hJeast9fnByGEt5ds6YX3sY/5 QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3raken06tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 08:34:01 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35J8RR74018407;
        Mon, 19 Jun 2023 08:34:01 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3raken06t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 08:34:01 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35J8OqNO022366;
        Mon, 19 Jun 2023 08:33:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3r94f50x9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 08:33:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35J8XtOb27329242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 08:33:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E1A62004E;
        Mon, 19 Jun 2023 08:33:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5935820043;
        Mon, 19 Jun 2023 08:33:54 +0000 (GMT)
Received: from linux6.. (unknown [9.114.12.104])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 19 Jun 2023 08:33:54 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        thuth@redhat.com, david@redhat.com, nsg@linux.ibm.com,
        nrb@linux.ibm.com
Subject: [kvm-unit-tests PATCH v5 3/8] lib: s390x: uv: Add intercept data check library function
Date:   Mon, 19 Jun 2023 08:33:24 +0000
Message-Id: <20230619083329.22680-4-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619083329.22680-1-frankja@linux.ibm.com>
References: <20230619083329.22680-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S_6IfGP8hTQrERt13EpzzBuDkD_BXExZ
X-Proofpoint-GUID: qSl6X0YC-hb_Ce3lcanXHhSLEgvlBDcK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306190077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

When working with guests it's essential to check the SIE intercept
data for the correct values. Fortunately on PV guests these values are
constants so we can create check functions which test for the
constants.

While we're at it let's make pv-diags.c use this new function.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 lib/s390x/pv_icptdata.h | 42 +++++++++++++++++++++++++++++++++++++++++
 s390x/pv-diags.c        | 14 ++++++--------
 2 files changed, 48 insertions(+), 8 deletions(-)
 create mode 100644 lib/s390x/pv_icptdata.h

diff --git a/lib/s390x/pv_icptdata.h b/lib/s390x/pv_icptdata.h
new file mode 100644
index 00000000..4746117e
--- /dev/null
+++ b/lib/s390x/pv_icptdata.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Commonly used checks for PV SIE intercept data
+ *
+ * Copyright IBM Corp. 2023
+ * Author: Janosch Frank <frankja@linux.ibm.com>
+ */
+
+#ifndef _S390X_PV_ICPTDATA_H_
+#define _S390X_PV_ICPTDATA_H_
+
+#include <sie.h>
+
+/*
+ * Checks the diagnose instruction intercept data for consistency with
+ * the constants defined by the PV SIE architecture
+ *
+ * Supports: 0x44, 0x9c, 0x288, 0x308, 0x500
+ */
+static bool pv_icptdata_check_diag(struct vm *vm, int diag)
+{
+	int icptcode;
+
+	switch (diag) {
+	case 0x44:
+	case 0x9c:
+	case 0x288:
+	case 0x308:
+		icptcode = ICPT_PV_NOTIFY;
+		break;
+	case 0x500:
+		icptcode = ICPT_PV_INSTR;
+		break;
+	default:
+		/* If a new diag is introduced add it to the cases above! */
+		assert(0);
+	}
+
+	return vm->sblk->icptcode == icptcode && vm->sblk->ipa == 0x8302 &&
+	       vm->sblk->ipb == 0x50000000 && vm->save_area.guest.grs[5] == diag;
+}
+#endif
diff --git a/s390x/pv-diags.c b/s390x/pv-diags.c
index 5165937a..096ac61f 100644
--- a/s390x/pv-diags.c
+++ b/s390x/pv-diags.c
@@ -9,6 +9,7 @@
  */
 #include <libcflat.h>
 #include <snippet.h>
+#include <pv_icptdata.h>
 #include <sie.h>
 #include <sclp.h>
 #include <asm/facility.h>
@@ -31,8 +32,7 @@ static void test_diag_500(void)
 			size_gbin, size_hdr, SNIPPET_UNPACK_OFF);
 
 	sie(&vm);
-	report(vm.sblk->icptcode == ICPT_PV_INSTR && vm.sblk->ipa == 0x8302 &&
-	       vm.sblk->ipb == 0x50000000 && vm.save_area.guest.grs[5] == 0x500,
+	report(pv_icptdata_check_diag(&vm, 0x500),
 	       "intercept values");
 	report(vm.save_area.guest.grs[1] == 1 &&
 	       vm.save_area.guest.grs[2] == 2 &&
@@ -45,9 +45,8 @@ static void test_diag_500(void)
 	 */
 	vm.sblk->iictl = IICTL_CODE_OPERAND;
 	sie(&vm);
-	report(vm.sblk->icptcode == ICPT_PV_NOTIFY && vm.sblk->ipa == 0x8302 &&
-	       vm.sblk->ipb == 0x50000000 && vm.save_area.guest.grs[5] == 0x9c
-	       && vm.save_area.guest.grs[0] == PGM_INT_CODE_OPERAND,
+	report(pv_icptdata_check_diag(&vm, 0x9c) &&
+	       vm.save_area.guest.grs[0] == PGM_INT_CODE_OPERAND,
 	       "operand exception");
 
 	/*
@@ -58,9 +57,8 @@ static void test_diag_500(void)
 	vm.sblk->iictl = IICTL_CODE_SPECIFICATION;
 	/* Inject PGM, next exit should be 9c */
 	sie(&vm);
-	report(vm.sblk->icptcode == ICPT_PV_NOTIFY && vm.sblk->ipa == 0x8302 &&
-	       vm.sblk->ipb == 0x50000000 && vm.save_area.guest.grs[5] == 0x9c
-	       && vm.save_area.guest.grs[0] == PGM_INT_CODE_SPECIFICATION,
+	report(pv_icptdata_check_diag(&vm, 0x9c) &&
+	       vm.save_area.guest.grs[0] == PGM_INT_CODE_SPECIFICATION,
 	       "specification exception");
 
 	/* No need for cleanup, just tear down the VM */
-- 
2.34.1

