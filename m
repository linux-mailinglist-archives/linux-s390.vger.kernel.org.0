Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72422FA27A
	for <lists+linux-s390@lfdr.de>; Mon, 18 Jan 2021 15:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391440AbhAROE6 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 18 Jan 2021 09:04:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392619AbhAROEj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Jan 2021 09:04:39 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10IE3Roc060525
        for <linux-s390@vger.kernel.org>; Mon, 18 Jan 2021 09:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=bMxYMRLFNbrxbl/skq1rrM9mRTpKKcgCFZSIMBDShPQ=;
 b=WFgyIkfR4V4iYcq8YaETZjl6aYER84csyOLoq6jY2/Mkqtte3t5ChX6Ej61U/PCHFP2T
 seUn2lhj2gLvpYJubV6bMCuFI01PeBHxlL8PoL9llnNa3b6cyAk4SsNKMUjp7wtaONUI
 CYzB5NeyOahpXOHomjdLWgWmEIL45PjiNchzFn3NwRetOUDL+iOAv7EZNAMQwTu3h4Z1
 Ao9cc7Qmh2IUqPQHnm/b7eJkxSTt/fJ+Vpo1pkJBY3ZJejr4d5pTn5aKglQNgf9nSgGd
 Lq8uhMXpeVuvIsbB69ZGEP+0lfZ7WauYWoDKCuNUZPqb2cqCzLJQuM9wp7Z378VI2Z+J lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3657y36r7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 18 Jan 2021 09:03:59 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10IE3w9B065622
        for <linux-s390@vger.kernel.org>; Mon, 18 Jan 2021 09:03:58 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3657y36r63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jan 2021 09:03:58 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10IE3unv018532;
        Mon, 18 Jan 2021 14:03:56 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 363qs8938d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jan 2021 14:03:56 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10IE3rq035127636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jan 2021 14:03:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8763211C04C;
        Mon, 18 Jan 2021 14:03:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3C1411C058;
        Mon, 18 Jan 2021 14:03:52 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Jan 2021 14:03:52 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm390 mailing list <kvm390-list@tuxmaker.boeblingen.de.ibm.com>
Cc:     thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com,
        imbrenda@linux.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH] s390x: Fix uv_call() exception behavior
Date:   Mon, 18 Jan 2021 09:03:44 -0500
Message-Id: <20210118140344.3074-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-18_11:2021-01-18,2021-01-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101180085
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On a program exception we usually skip the instruction that caused the
exception and continue. That won't work for UV calls since a "brc 3,0b"
will retry the instruction if the CC is > 1.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---

I know this isn't very pretty.
I'm open for suggestions.

---
 lib/s390x/asm/uv.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
index 4c2fc48..252f1a3 100644
--- a/lib/s390x/asm/uv.h
+++ b/lib/s390x/asm/uv.h
@@ -53,21 +53,23 @@ struct uv_cb_share {
 static inline int uv_call(unsigned long r1, unsigned long r2)
 {
 	int cc;
+	struct lowcore *lc = 0x0;
 
 	/*
-	 * The brc instruction will take care of the cc 2/3 case where
-	 * we need to continue the execution because we were
-	 * interrupted. The inline assembly will only return on
-	 * success/error i.e. cc 0/1.
-	*/
+	 * CC 2 and 3 tell us to re-execute because the instruction
+	 * hasn't yet finished.
+	 */
+	lc->pgm_int_code = 0;
+retry:
 	asm volatile(
 		"0:	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
-		"		brc	3,0b\n"
 		"		ipm	%[cc]\n"
 		"		srl	%[cc],28\n"
 		: [cc] "=d" (cc)
 		: [r1] "a" (r1), [r2] "a" (r2)
 		: "memory", "cc");
+	if (!lc->pgm_int_code && cc > 1)
+		goto retry;
 	return cc;
 }
 
-- 
2.25.1

