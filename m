Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EA37E2AA7
	for <lists+linux-s390@lfdr.de>; Mon,  6 Nov 2023 18:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjKFRI7 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 6 Nov 2023 12:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjKFRI6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Nov 2023 12:08:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D775D4D;
        Mon,  6 Nov 2023 09:08:55 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6GqWFx009758;
        Mon, 6 Nov 2023 17:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ECHjvgKn7T8h70uC82BKY6deboTIePxxtdBahCWAHa0=;
 b=oPfR9abO5ReLHDpwymIWB7blNVZieqs6/NpO20jEu3aC1260Lsfqz27mGw4ayGG+Duj0
 /HXKXLknSdBYQG+/WJxmd3QtPz6AFvKUQ4/yM4NueL1ZEEk/GHHwpx3oFo9oDIaKGmkq
 OaeJARHZIUNWfbiiucBfmy4hK6RGiRgfnByIO8EV2rgBQnGWncOKfjXiFgolxz+CsHB8
 szxr8u3US3LVU7sdpBPFEmCr99HBW8GrXpltFNlb3U86jPjVffz+d063bZ9YoiXAFU8H
 PoQSxMY4djq2KYnlz8uAcPnUFHr/+xJxaSd1oWEmXMmcyFIb2fo1vYWf60djZjbTHFOe JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u741tgj3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 17:08:54 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A6H2LtX012136;
        Mon, 6 Nov 2023 17:08:54 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u741tgj2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 17:08:54 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6FRnqu016958;
        Mon, 6 Nov 2023 17:08:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u6301j9e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 17:08:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A6H8o5j12321326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 17:08:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDCFF20040;
        Mon,  6 Nov 2023 17:08:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6235D2004B;
        Mon,  6 Nov 2023 17:08:50 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Nov 2023 17:08:50 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     frankja@linux.ibm.com, imbrenda@linux.ibm.com, thuth@redhat.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH v2 1/3] s390x: spec_ex-sie: refactor to use snippet API
Date:   Mon,  6 Nov 2023 18:08:00 +0100
Message-ID: <20231106170849.1184162-2-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106170849.1184162-1-nrb@linux.ibm.com>
References: <20231106170849.1184162-1-nrb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tniNvpb7yg9-Bmo_ql48ggQ67NYiOT0k
X-Proofpoint-GUID: jHVwing4ZadFmE4RZg-J8yLCY4Z07_uq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311060139
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

spec_ex-sie uses a snippet, but allocated the memory on its own without
obvious reason to do so.

Refactor the test to use snippet_init().

Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
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

