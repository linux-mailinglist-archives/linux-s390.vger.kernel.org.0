Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653AC6F434A
	for <lists+linux-s390@lfdr.de>; Tue,  2 May 2023 14:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjEBMIv (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 2 May 2023 08:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjEBMIu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 May 2023 08:08:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F51226BB;
        Tue,  2 May 2023 05:08:49 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342C8fxJ012271;
        Tue, 2 May 2023 12:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=huzk1GvlBydAsRnwcD+SkNYO/BWmYOhFKSb8WjIXIyE=;
 b=hSY2jUEXEQY2/oaHSzs/OT8hjVsjfnq8RmEP+GbqhmQqCVglc3SlJqL+80NDDMiQGa6Z
 znKXtsABaz88oCRf4v26GD0gaJML8trg0QqXU9I4AIFZzZh6BCw3XZxVD52yh38dWvmE
 iC3aIvGkMeNQeDTF6p9QBgckW52ubdTbjM+AoDgaJxE8lxOK8WTJl9rT20aG6rkJ3Jjt
 ca+GDz4g7X4gcGENYFXEb4me8tgw9VLOi7/1hcxjpRcifMgalTtrj8N56AwupICq9DR6
 50zu9nPk28HpkI6GmHI8dFQMqTYeJGAosRXj8I3ybE/fJle7I56D+mdNHFrp2/ZaVSUh nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qb1w88k24-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 12:08:48 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 342C1mqO022927;
        Tue, 2 May 2023 12:02:01 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qb1w88hf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 12:02:00 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 342Ab93a015578;
        Tue, 2 May 2023 12:00:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3q8tgg1ju4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 12:00:47 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 342C0iQ617367800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 May 2023 12:00:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51BF820043;
        Tue,  2 May 2023 12:00:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81BBF20040;
        Tue,  2 May 2023 12:00:43 +0000 (GMT)
Received: from linux6.. (unknown [9.114.12.104])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  2 May 2023 12:00:43 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        thuth@redhat.com, nrb@linux.ibm.com, david@redhat.com
Subject: [kvm-unit-tests PATCH v4 2/7] lib: s390x: uv: Add intercept data check library function
Date:   Tue,  2 May 2023 11:59:26 +0000
Message-Id: <20230502115931.86280-3-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230502115931.86280-1-frankja@linux.ibm.com>
References: <20230502115931.86280-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gy3kcfbEc8lJ7MaR5LY2M3-2AklIjXKb
X-Proofpoint-GUID: 04nxVMag5BvmLpBkAAzo_hDo-U1if6Tp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_05,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

