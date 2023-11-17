Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A045E7EF503
	for <lists+linux-s390@lfdr.de>; Fri, 17 Nov 2023 16:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjKQPUH (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 17 Nov 2023 10:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjKQPUG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Nov 2023 10:20:06 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25467D56;
        Fri, 17 Nov 2023 07:20:03 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHFGAMo031822;
        Fri, 17 Nov 2023 15:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LdSTOCRF/Y2mm7f4UJzdgFcO5CKZJDr3FoCQzhucFNA=;
 b=fM9nXUPJIydB2jEB4W11clbjyMPmPTIBUhjdzEqt6Ym9ntZ740HKamk7Mgpk6MMibNKE
 yE7TI+2UOXboQOGd9MEa+nNFoD3Je94RhTCLHV82XpUAUvnGaxql7S9b2KEvdowwM6Wt
 PODUBIf1Rerze2aigHfAC7KM+zHeUBBUtyMr2N06cKUTAqaL6DbBK4xWLVws+TvMUyue
 Gsjyb+WXjzVFewnR2TmCZ04eJy4HZiV9v7CSE2r32BDiFVX/uhpj8rRk0fwTHy0KWa1f
 1zV28yYD1jIGzUOmpTiqkU6cDEdQqvOoXvMTASU07MuMzIVbquiyuO8BNChAhjOmdpwF XA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ueanvg41g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 15:20:00 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AHFGKHl000321;
        Fri, 17 Nov 2023 15:20:00 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ueanvg40p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 15:20:00 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHD3wkc005145;
        Fri, 17 Nov 2023 15:19:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uakxtf7vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 15:19:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AHFJu8T51446046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 15:19:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1AF420040;
        Fri, 17 Nov 2023 15:19:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7264A20043;
        Fri, 17 Nov 2023 15:19:56 +0000 (GMT)
Received: from a46lp67.. (unknown [9.152.108.100])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Nov 2023 15:19:56 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        thuth@redhat.com, david@redhat.com, nsg@linux.ibm.com,
        nrb@linux.ibm.com
Subject: [kvm-unit-tests PATCH v3 6/7] lib: s390x: ap: Add tapq test facility bit
Date:   Fri, 17 Nov 2023 15:19:38 +0000
Message-Id: <20231117151939.971079-7-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117151939.971079-1-frankja@linux.ibm.com>
References: <20231117151939.971079-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bkKkS7ay5LcPMSm8MSfGzLjpTdhiW7nw
X-Proofpoint-GUID: 5UeLMQdZCDScPY_bxImV3pk7Qx1aXuDz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_14,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

When the t bit is one the first 32 bits of register 2 are populated on
a tapq. Those bits tell us in which mode the queu is and which
facilities it supports.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/ap.c |  5 +++--
 lib/s390x/ap.h |  2 +-
 s390x/ap.c     | 12 ++++++------
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib/s390x/ap.c b/lib/s390x/ap.c
index c1acfda8..fbc33227 100644
--- a/lib/s390x/ap.c
+++ b/lib/s390x/ap.c
@@ -26,11 +26,12 @@ static uint8_t *array_queue;
 static struct ap_config_info qci;
 
 int ap_pqap_tapq(uint8_t ap, uint8_t qn, struct ap_queue_status *apqsw,
-		 struct pqap_r2 *r2)
+		 struct pqap_r2 *r2, bool t)
 {
 	struct pqap_r0 r0 = {
 		.ap = ap,
 		.qn = qn,
+		.t = t,
 		.fc = PQAP_TEST_APQ
 	};
 	int cc;
@@ -169,7 +170,7 @@ static int pqap_reset_wait(uint8_t ap, uint8_t qn, struct ap_queue_status *apqsw
 	do {
 		/* Give it some time to process before the retry */
 		mdelay(20);
-		cc = ap_pqap_tapq(ap, qn, apqsw, &r2);
+		cc = ap_pqap_tapq(ap, qn, apqsw, &r2, false);
 	} while (apqsw->rc == AP_RC_RESET_IN_PROGRESS);
 
 	if (apqsw->rc)
diff --git a/lib/s390x/ap.h b/lib/s390x/ap.h
index e037a974..17f8016d 100644
--- a/lib/s390x/ap.h
+++ b/lib/s390x/ap.h
@@ -109,7 +109,7 @@ enum {
 
 int ap_setup(uint8_t **ap_array, uint8_t **qn_array, uint8_t *naps, uint8_t *nqns);
 int ap_pqap_tapq(uint8_t ap, uint8_t qn, struct ap_queue_status *apqsw,
-		 struct pqap_r2 *r2);
+		 struct pqap_r2 *r2, bool t);
 int ap_pqap_reset(uint8_t ap, uint8_t qn, struct ap_queue_status *apqsw);
 int ap_pqap_reset_zeroize(uint8_t ap, uint8_t qn, struct ap_queue_status *apqsw);
 int ap_pqap_qci(struct ap_config_info *info);
diff --git a/s390x/ap.c b/s390x/ap.c
index 0ae2809e..05664df8 100644
--- a/s390x/ap.c
+++ b/s390x/ap.c
@@ -325,7 +325,7 @@ static void test_pqap_aqic(void)
 
 	do {
 		mdelay(20);
-		cc = ap_pqap_tapq(apn, qn, &apqsw, &r2);
+		cc = ap_pqap_tapq(apn, qn, &apqsw, &r2, false);
 	} while (cc == 0 && apqsw.irq_enabled == 0);
 	report(cc == 0 && apqsw.irq_enabled == 1, "enable IRQs tapq data");
 
@@ -338,7 +338,7 @@ static void test_pqap_aqic(void)
 
 	do {
 		mdelay(20);
-		cc = ap_pqap_tapq(apn, qn, &apqsw, &r2);
+		cc = ap_pqap_tapq(apn, qn, &apqsw, &r2, false);
 	} while (cc == 0 && apqsw.irq_enabled == 1);
 	report(cc == 0 && apqsw.irq_enabled == 0, "disable IRQs tapq data");
 
@@ -365,12 +365,12 @@ static void test_pqap_resets(void)
 
 	do {
 		mdelay(20);
-		cc = ap_pqap_tapq(apn, qn, &apqsw, &r2);
+		cc = ap_pqap_tapq(apn, qn, &apqsw, &r2, false);
 	} while (cc == 0 && apqsw.irq_enabled == 0);
 	report(apqsw.irq_enabled == 1, "IRQs enabled tapq data");
 
 	ap_pqap_reset(apn, qn, &apqsw);
-	cc = ap_pqap_tapq(apn, qn, &apqsw, &r2);
+	cc = ap_pqap_tapq(apn, qn, &apqsw, &r2, false);
 	assert(!cc);
 	report(apqsw.irq_enabled == 0, "IRQs have been disabled via reset");
 
@@ -385,12 +385,12 @@ static void test_pqap_resets(void)
 
 	do {
 		mdelay(20);
-		cc = ap_pqap_tapq(apn, qn, &apqsw, &r2);
+		cc = ap_pqap_tapq(apn, qn, &apqsw, &r2, false);
 	} while (cc == 0 && apqsw.irq_enabled == 0);
 	report(apqsw.irq_enabled == 1, "IRQs enabled tapq data");
 
 	ap_pqap_reset_zeroize(apn, qn, &apqsw);
-	cc = ap_pqap_tapq(apn, qn, &apqsw, &r2);
+	cc = ap_pqap_tapq(apn, qn, &apqsw, &r2, false);
 	assert(!cc);
 	report(apqsw.irq_enabled == 0, "IRQs have been disabled via reset");
 
-- 
2.34.1

