Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01E62FA43A
	for <lists+linux-s390@lfdr.de>; Mon, 18 Jan 2021 16:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405378AbhARPLD (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 18 Jan 2021 10:11:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14630 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405458AbhARPKd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Jan 2021 10:10:33 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10IF2p3p014235
        for <linux-s390@vger.kernel.org>; Mon, 18 Jan 2021 10:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=V47L6UbHiSg0Dqe0TLGFXQbAaHN0EtV2DmYzrwbOql4=;
 b=MNA62Duvkw6b2NJLnirsyGu/ueynnEOwzVXCTs0cieo/MGqNI67tBF15Jt0fmd6x3OTY
 CA+qFOOV/bECmX6EnfXOVjn9bAx/dsMaw5LvG6qkQBA3sEssFBhwm1maCX5y7WP49mdQ
 VTtTnFi8nzUSWl3q6+BCzIV9dmHjwBi+wThKINSAxcAJiI2PUcD6SoQffw4hfMrdS3cG
 Fbj+Ew6i/TFf8rJBcqrIdXfrE7GMfgjJ3vzf9uUwg1vkx7dVzIrwgOiRYv4Ld8lTXiMv
 Pem36M6Pkd4fddwIyAcPxbO6WG4kZyHmGiEGVBVZQvLtCzb8fYa84bGNr8I6fKagJEA5 Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 365aspkdfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 18 Jan 2021 10:09:50 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10IF2tQk014398
        for <linux-s390@vger.kernel.org>; Mon, 18 Jan 2021 10:09:49 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 365aspkded-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jan 2021 10:09:49 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10IF1jQv029110;
        Mon, 18 Jan 2021 15:09:46 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 363t0y92pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jan 2021 15:09:46 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10IF9hlo41681404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jan 2021 15:09:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8443AAE05F;
        Mon, 18 Jan 2021 15:09:43 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C29AEAE045;
        Mon, 18 Jan 2021 15:09:42 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Jan 2021 15:09:42 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm390 mailing list <kvm390-list@tuxmaker.boeblingen.de.ibm.com>
Cc:     thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com,
        imbrenda@linux.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH v2] s390x: Fix uv_call() exception behavior
Date:   Mon, 18 Jan 2021 10:09:22 -0500
Message-Id: <20210118150922.5229-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118140344.3074-1-frankja@linux.ibm.com>
References: <20210118140344.3074-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-18_13:2021-01-18,2021-01-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101180092
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On a program exception we usually skip the instruction that caused the
exception and continue. That won't work for UV calls since a "brc
3,0b" will retry the instruction if the CC is > 1. Let's forgo the brc
when checking for privilege exceptions and use a uv_call_once().

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Suggested-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

---
 lib/s390x/asm/uv.h | 24 ++++++++++++++++--------
 s390x/uv-guest.c   |  6 +++---
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
index 4c2fc48..39d2dc0 100644
--- a/lib/s390x/asm/uv.h
+++ b/lib/s390x/asm/uv.h
@@ -50,19 +50,12 @@ struct uv_cb_share {
 	u64 reserved28;
 } __attribute__((packed))  __attribute__((aligned(8)));
 
-static inline int uv_call(unsigned long r1, unsigned long r2)
+static inline int uv_call_once(unsigned long r1, unsigned long r2)
 {
 	int cc;
 
-	/*
-	 * The brc instruction will take care of the cc 2/3 case where
-	 * we need to continue the execution because we were
-	 * interrupted. The inline assembly will only return on
-	 * success/error i.e. cc 0/1.
-	*/
 	asm volatile(
 		"0:	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
-		"		brc	3,0b\n"
 		"		ipm	%[cc]\n"
 		"		srl	%[cc],28\n"
 		: [cc] "=d" (cc)
@@ -71,4 +64,19 @@ static inline int uv_call(unsigned long r1, unsigned long r2)
 	return cc;
 }
 
+static inline int uv_call(unsigned long r1, unsigned long r2)
+{
+	int cc;
+
+	/*
+	 * CC 2 and 3 tell us to re-execute because the instruction
+	 * hasn't yet finished.
+	 */
+	do {
+		cc = uv_call_once(r1, r2);
+	} while (cc > 1);
+
+	return cc;
+}
+
 #endif
diff --git a/s390x/uv-guest.c b/s390x/uv-guest.c
index d47333e..091a19b 100644
--- a/s390x/uv-guest.c
+++ b/s390x/uv-guest.c
@@ -31,7 +31,7 @@ static void test_priv(void)
 	uvcb.len = sizeof(struct uv_cb_qui);
 	expect_pgm_int();
 	enter_pstate();
-	uv_call(0, (u64)&uvcb);
+	uv_call_once(0, (u64)&uvcb);
 	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
 	report_prefix_pop();
 
@@ -40,7 +40,7 @@ static void test_priv(void)
 	uvcb.len = sizeof(struct uv_cb_share);
 	expect_pgm_int();
 	enter_pstate();
-	uv_call(0, (u64)&uvcb);
+	uv_call_once(0, (u64)&uvcb);
 	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
 	report_prefix_pop();
 
@@ -49,7 +49,7 @@ static void test_priv(void)
 	uvcb.len = sizeof(struct uv_cb_share);
 	expect_pgm_int();
 	enter_pstate();
-	uv_call(0, (u64)&uvcb);
+	uv_call_once(0, (u64)&uvcb);
 	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
 	report_prefix_pop();
 
-- 
2.25.1

