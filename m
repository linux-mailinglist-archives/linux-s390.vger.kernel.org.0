Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B9F7E0126
	for <lists+linux-s390@lfdr.de>; Fri,  3 Nov 2023 11:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjKCGlm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 Nov 2023 02:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjKCGll (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Nov 2023 02:41:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5919E1BC;
        Thu,  2 Nov 2023 23:41:38 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A36ewOO021022;
        Fri, 3 Nov 2023 06:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bGyBTBLXGl8eNkZ76UBpVtkvlNO0ktX/HO4Js5wA1Go=;
 b=lAMEqRzWeVFERQ74/xcc5P1Ui1QJLaZmT8cpBx4dUT4uDL/NHxovdOkcuDtRdTAmrVtP
 rLoYNXqrml6FN/GYdQJWMrsBSmckP1yxvJL5m1OTljfOTRxKQImSFMxyfNh+2xB6Hq3q
 JAbpPMfmhUp6ewX9R/5ixXU1Ky2G/DOrc7i6tPqMAPP0s2jkIZp92l3+d36RSIsQSe3x
 PgbRTgVqgDOII1R7+KGFzlZeJcV77enU/YYEnRtACrzdSHerrNjoZvYQLynrgGKUHJAg
 4bpFqo7crfJDGp/uwf1kBMdG4FQIPq7Q1fjiwig2BKpqlmFqEfTFlEubH7i/tzoCpnEy qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4u1ah74t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 06:41:37 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A36fTDW023167;
        Fri, 3 Nov 2023 06:41:37 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4u1ah74p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 06:41:37 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A34N6pr031381;
        Fri, 3 Nov 2023 06:41:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1fb2kmmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 06:41:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A36fX6T16515634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Nov 2023 06:41:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A450420069;
        Fri,  3 Nov 2023 06:41:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FB942005A;
        Fri,  3 Nov 2023 06:41:33 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Nov 2023 06:41:33 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     frankja@linux.ibm.com, imbrenda@linux.ibm.com, thuth@redhat.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH v1 1/2] s390x: spec_ex-sie: refactor to use snippet API
Date:   Fri,  3 Nov 2023 07:35:46 +0100
Message-ID: <20231103064132.11358-2-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231103064132.11358-1-nrb@linux.ibm.com>
References: <20231103064132.11358-1-nrb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LGcCoNzXvqjxClsGP5ZXhkFeIXHeaoqQ
X-Proofpoint-GUID: xeImNIR9Ha4N5ETLIj9h6OUa0rZ1-dqq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_06,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

spec_ex-sie uses a snippet, but allocated the memory on its own without
obvious reason to do so.

Refactor the test to use snippet_init().

Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
---
 s390x/spec_ex-sie.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/s390x/spec_ex-sie.c b/s390x/spec_ex-sie.c
index 5fa135b81c86..fe2f23ee3d84 100644
--- a/s390x/spec_ex-sie.c
+++ b/s390x/spec_ex-sie.c
@@ -17,19 +17,18 @@
 #include <hardware.h>
 
 static struct vm vm;
-extern const char SNIPPET_NAME_START(c, spec_ex)[];
-extern const char SNIPPET_NAME_END(c, spec_ex)[];
 static bool strict;
 
 static void setup_guest(void)
 {
-	char *guest;
-	int binary_size = SNIPPET_LEN(c, spec_ex);
+	extern const char SNIPPET_NAME_START(c, spec_ex)[];
+	extern const char SNIPPET_NAME_END(c, spec_ex)[];
 
 	setup_vm();
-	guest = alloc_pages(8);
-	memcpy(guest, SNIPPET_NAME_START(c, spec_ex), binary_size);
-	sie_guest_create(&vm, (uint64_t) guest, HPAGE_SIZE);
+
+	snippet_setup_guest(&vm, false);
+	snippet_init(&vm, SNIPPET_NAME_START(c, spec_ex),
+		     SNIPPET_LEN(c, spec_ex), SNIPPET_UNPACK_OFF);
 }
 
 static void reset_guest(void)
-- 
2.41.0

