Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF5154316C
	for <lists+linux-s390@lfdr.de>; Wed,  8 Jun 2022 15:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240245AbiFHNdP (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 8 Jun 2022 09:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240194AbiFHNdN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jun 2022 09:33:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7991105D4;
        Wed,  8 Jun 2022 06:33:12 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 258DDUhh014353;
        Wed, 8 Jun 2022 13:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0N4OM40uQp66DHmxBbjlFVWkYMbGOXqsQhNa8AQiGBA=;
 b=dp0GNZZMDbpYXvBLX6zWQgzoRaLcNiC/413mt08glcz2zIFhwCKehp0aHvu3dbf6rCPk
 8vuc8GpF7FqgjtLTdp06KDcCNEjwjZW2/ptJsU9ObLLE09h46yluwma4GmGe0foh3Cvv
 NCJWf7fT5erN6HzyZGYeMTtIg8O1aZ94ngG04iug6ItaXF6SApaXW3p5t1zcReAvbtjb
 IqvSEqcXHS6JJEvgPtLlU6gQYFCjRvk08eizF9RTBDBtYLOi4j/W1HzsCaTh0gUi+h4u
 OsurOIGf56YgsL2yS4GI/1VMhec6rsfGXxA9OhM1EUQ7m0ChTesy5HEhEij1H171cCx5 cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjvf68evt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 13:33:12 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 258DT5CT015883;
        Wed, 8 Jun 2022 13:33:11 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjvf68eua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 13:33:11 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 258DJkXh018003;
        Wed, 8 Jun 2022 13:33:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3gfy19dabt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 13:33:09 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 258DX5G521627146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jun 2022 13:33:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D445E11C050;
        Wed,  8 Jun 2022 13:33:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 942D411C04A;
        Wed,  8 Jun 2022 13:33:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jun 2022 13:33:05 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Thomas Huth <thuth@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH v2 3/3] s390x: Rework TEID decoding and usage
Date:   Wed,  8 Jun 2022 15:33:03 +0200
Message-Id: <20220608133303.1532166-4-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220608133303.1532166-1-scgl@linux.ibm.com>
References: <20220608133303.1532166-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XbEJy3yymk539so68SFFcRhuP1dmRmlO
X-Proofpoint-ORIG-GUID: PBmYkXhOS0Kk5FWgloiYXFTkfKrgbcJr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_04,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206080058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The translation-exception identification (TEID) contains information to
identify the cause of certain program exceptions, including translation
exceptions occurring during dynamic address translation, as well as
protection exceptions.
The meaning of fields in the TEID is complex, depending on the exception
occurring and various potentially installed facilities.

Rework the type describing the TEID, in order to ease decoding.
Change the existing code interpreting the TEID and extend it to take the
installed suppression-on-protection facility into account.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 lib/s390x/asm/interrupt.h | 61 +++++++++++++++++++++++++++---------
 lib/s390x/fault.h         | 30 +++++-------------
 lib/s390x/fault.c         | 65 ++++++++++++++++++++++++++-------------
 lib/s390x/interrupt.c     |  2 +-
 s390x/edat.c              | 26 ++++++++++------
 5 files changed, 115 insertions(+), 69 deletions(-)

diff --git a/lib/s390x/asm/interrupt.h b/lib/s390x/asm/interrupt.h
index d9ab0bd7..3ca6bf76 100644
--- a/lib/s390x/asm/interrupt.h
+++ b/lib/s390x/asm/interrupt.h
@@ -20,23 +20,56 @@
 
 union teid {
 	unsigned long val;
-	struct {
-		unsigned long addr:52;
-		unsigned long fetch:1;
-		unsigned long store:1;
-		unsigned long reserved:6;
-		unsigned long acc_list_prot:1;
-		/*
-		 * depending on the exception and the installed facilities,
-		 * the m field can indicate several different things,
-		 * including whether the exception was triggered by a MVPG
-		 * instruction, or whether the addr field is meaningful
-		 */
-		unsigned long m:1;
-		unsigned long asce_id:2;
+	union {
+		/* common fields DAT exc & protection exc */
+		struct {
+			uint64_t addr			: 52 -  0;
+			uint64_t acc_exc_f_s		: 54 - 52;
+			uint64_t side_effect_acc	: 55 - 54;
+			uint64_t /* reserved */		: 62 - 55;
+			uint64_t asce_id		: 64 - 62;
+		};
+		/* DAT exc */
+		struct {
+			uint64_t /* pad */		: 61 -  0;
+			uint64_t dat_move_page		: 62 - 61;
+		};
+		/* suppression on protection */
+		struct {
+			uint64_t /* pad */		: 60 -  0;
+			uint64_t sop_acc_list		: 61 - 60;
+			uint64_t sop_teid_predictable	: 62 - 61;
+		};
+		/* enhanced suppression on protection 2 */
+		struct {
+			uint64_t /* pad */		: 56 -  0;
+			uint64_t esop2_prot_code_0	: 57 - 56;
+			uint64_t /* pad */		: 60 - 57;
+			uint64_t esop2_prot_code_1	: 61 - 60;
+			uint64_t esop2_prot_code_2	: 62 - 61;
+		};
 	};
 };
 
+enum prot_code {
+	PROT_KEY_LAP,
+	PROT_DAT,
+	PROT_KEY,
+	PROT_ACC_LIST,
+	PROT_LAP,
+	PROT_IEP,
+};
+
+static inline enum prot_code teid_esop2_prot_code(union teid teid)
+{
+	int code = (teid.esop2_prot_code_0 << 2 |
+		    teid.esop2_prot_code_1 << 1 |
+		    teid.esop2_prot_code_2);
+
+	assert(code < 6);
+	return (enum prot_code)code;
+}
+
 void register_pgm_cleanup_func(void (*f)(void));
 void handle_pgm_int(struct stack_frame_int *stack);
 void handle_ext_int(struct stack_frame_int *stack);
diff --git a/lib/s390x/fault.h b/lib/s390x/fault.h
index 726da2f0..867997f2 100644
--- a/lib/s390x/fault.h
+++ b/lib/s390x/fault.h
@@ -11,32 +11,16 @@
 #define _S390X_FAULT_H_
 
 #include <bitops.h>
+#include <asm/facility.h>
+#include <asm/interrupt.h>
 
 /* Instruction execution prevention, i.e. no-execute, 101 */
-static inline bool prot_is_iep(uint64_t teid)
+static inline bool prot_is_iep(union teid teid)
 {
-	if (test_bit_inv(56, &teid) && !test_bit_inv(60, &teid) && test_bit_inv(61, &teid))
-		return true;
-
-	return false;
-}
-
-/* Standard DAT exception, 001 */
-static inline bool prot_is_datp(uint64_t teid)
-{
-	if (!test_bit_inv(56, &teid) && !test_bit_inv(60, &teid) && test_bit_inv(61, &teid))
-		return true;
-
-	return false;
-}
-
-/* Low-address protection exception, 100 */
-static inline bool prot_is_lap(uint64_t teid)
-{
-	if (test_bit_inv(56, &teid) && !test_bit_inv(60, &teid) && !test_bit_inv(61, &teid))
-		return true;
-
-	return false;
+	if (!test_facility(130))
+		return false;
+	/* IEP installed -> ESOP2 installed */
+	return teid_esop2_prot_code(teid) == PROT_IEP;
 }
 
 void print_decode_teid(uint64_t teid);
diff --git a/lib/s390x/fault.c b/lib/s390x/fault.c
index efa62fcb..b75152f5 100644
--- a/lib/s390x/fault.c
+++ b/lib/s390x/fault.c
@@ -13,35 +13,56 @@
 #include <asm/page.h>
 #include <fault.h>
 
-/* Decodes the protection exceptions we'll most likely see */
-static void print_decode_pgm_prot(uint64_t teid)
-{
-	if (prot_is_lap(teid)) {
-		printf("Type: LAP\n");
-		return;
-	}
 
-	if (prot_is_iep(teid)) {
-		printf("Type: IEP\n");
-		return;
-	}
+static void print_decode_pgm_prot(union teid teid, bool dat)
+{
+	switch (get_supp_on_prot_facility()) {
+	case SOP_NONE:
+		printf("Type: ?\n");
+		break;
+	case SOP_BASIC:
+		if (teid.sop_teid_predictable && dat && teid.sop_acc_list)
+			printf("Type: ACC\n");
+		else
+			printf("Type: ?\n");
+		break;
+	case SOP_ENHANCED_1:
+		if (teid.sop_teid_predictable) {/* implies access list or DAT */
+			if (teid.sop_acc_list)
+				printf("Type: ACC\n");
+			else
+				printf("Type: DAT\n");
+		} else {
+			printf("Type: KEY or LAP\n");
+		}
+		break;
+	case SOP_ENHANCED_2: {
+		static const char * const prot_str[] = {
+			"KEY or LAP",
+			"DAT",
+			"KEY",
+			"ACC",
+			"LAP",
+			"IEP",
+		};
+		int prot_code = teid_esop2_prot_code(teid);
 
-	if (prot_is_datp(teid)) {
-		printf("Type: DAT\n");
-		return;
+		assert(0 <= prot_code && prot_code < ARRAY_SIZE(prot_str));
+		printf("Type: %s\n", prot_str[prot_code]);
+		}
 	}
 }
 
-void print_decode_teid(uint64_t teid)
+void print_decode_teid(uint64_t raw_teid)
 {
-	int asce_id = teid & 3;
+	union teid teid = { .val = raw_teid };
 	bool dat = lowcore.pgm_old_psw.mask & PSW_MASK_DAT;
 
 	printf("Memory exception information:\n");
 	printf("DAT: %s\n", dat ? "on" : "off");
 
 	printf("AS: ");
-	switch (asce_id) {
+	switch (teid.asce_id) {
 	case AS_PRIM:
 		printf("Primary\n");
 		break;
@@ -57,7 +78,7 @@ void print_decode_teid(uint64_t teid)
 	}
 
 	if (lowcore.pgm_int_code == PGM_INT_CODE_PROTECTION)
-		print_decode_pgm_prot(teid);
+		print_decode_pgm_prot(teid, dat);
 
 	/*
 	 * If teid bit 61 is off for these two exception the reported
@@ -65,10 +86,10 @@ void print_decode_teid(uint64_t teid)
 	 */
 	if ((lowcore.pgm_int_code == PGM_INT_CODE_SECURE_STOR_ACCESS ||
 	     lowcore.pgm_int_code == PGM_INT_CODE_SECURE_STOR_VIOLATION) &&
-	    !test_bit_inv(61, &teid)) {
-		printf("Address: %lx, unpredictable\n ", teid & PAGE_MASK);
+	    !teid.sop_teid_predictable) {
+		printf("Address: %lx, unpredictable\n ", raw_teid & PAGE_MASK);
 		return;
 	}
-	printf("TEID: %lx\n", teid);
-	printf("Address: %lx\n\n", teid & PAGE_MASK);
+	printf("TEID: %lx\n", raw_teid);
+	printf("Address: %lx\n\n", raw_teid & PAGE_MASK);
 }
diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
index 6da20c44..ac3d1ecd 100644
--- a/lib/s390x/interrupt.c
+++ b/lib/s390x/interrupt.c
@@ -77,7 +77,7 @@ static void fixup_pgm_int(struct stack_frame_int *stack)
 		break;
 	case PGM_INT_CODE_PROTECTION:
 		/* Handling for iep.c test case. */
-		if (prot_is_iep(lowcore.trans_exc_id))
+		if (prot_is_iep((union teid) { .val = lowcore.trans_exc_id }))
 			/*
 			 * We branched to the instruction that caused
 			 * the exception so we can use the return
diff --git a/s390x/edat.c b/s390x/edat.c
index c6c25042..89ff4f51 100644
--- a/s390x/edat.c
+++ b/s390x/edat.c
@@ -26,8 +26,8 @@ static void *root, *mem, *m;
 volatile unsigned int *p;
 
 /*
- * Check if a non-access-list protection exception happened for the given
- * address, in the primary address space.
+ * Check if the exception is consistent with DAT protection and has the correct
+ * address and primary address space.
  */
 static bool check_pgm_prot(void *ptr)
 {
@@ -37,14 +37,22 @@ static bool check_pgm_prot(void *ptr)
 		return false;
 
 	teid.val = lowcore.trans_exc_id;
-
-	/*
-	 * depending on the presence of the ESOP feature, the rest of the
-	 * field might or might not be meaningful when the m field is 0.
-	 */
-	if (!teid.m)
+	switch (get_supp_on_prot_facility()) {
+	case SOP_NONE:
 		return true;
-	return (!teid.acc_list_prot && !teid.asce_id &&
+	case SOP_BASIC:
+		if (!teid.sop_teid_predictable)
+			return true;
+		break;
+	case SOP_ENHANCED_1:
+		if (!teid.sop_teid_predictable) /* implies key or low addr */
+			return false;
+		break;
+	case SOP_ENHANCED_2:
+		if (teid_esop2_prot_code(teid) != PROT_DAT)
+			return false;
+	}
+	return (!teid.sop_acc_list && !teid.asce_id &&
 		(teid.addr == ((unsigned long)ptr >> PAGE_SHIFT)));
 }
 
-- 
2.33.1

