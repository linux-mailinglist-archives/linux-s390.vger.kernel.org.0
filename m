Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 408FD14F875
	for <lists+linux-s390@lfdr.de>; Sat,  1 Feb 2020 16:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgBAP3H (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 1 Feb 2020 10:29:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726668AbgBAP3G (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 1 Feb 2020 10:29:06 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 011FFVUN027263
        for <linux-s390@vger.kernel.org>; Sat, 1 Feb 2020 10:29:05 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xw7b4736n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 01 Feb 2020 10:29:05 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Sat, 1 Feb 2020 15:29:03 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 1 Feb 2020 15:28:59 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 011FSwjK44433906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 1 Feb 2020 15:28:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5BB952050;
        Sat,  1 Feb 2020 15:28:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.30.110])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id DCBD65204E;
        Sat,  1 Feb 2020 15:28:57 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     thuth@redhat.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com
Subject: [kvm-unit-tests PATCH v5 2/7] s390x: smp: Fix ecall and emcall report strings
Date:   Sat,  1 Feb 2020 10:28:46 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201152851.82867-1-frankja@linux.ibm.com>
References: <20200201152851.82867-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020115-0028-0000-0000-000003D6867A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020115-0029-0000-0000-0000249ADAC7
Message-Id: <20200201152851.82867-3-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-01_03:2020-01-31,2020-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=899 clxscore=1015 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=1
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002010113
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Instead of "smp: ecall: ecall" we now get "smp: ecall: received".

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/s390x/smp.c b/s390x/smp.c
index e37eb56..93a9594 100644
--- a/s390x/smp.c
+++ b/s390x/smp.c
@@ -125,7 +125,7 @@ static void ecall(void)
 	load_psw_mask(mask);
 	set_flag(1);
 	while (lc->ext_int_code != 0x1202) { mb(); }
-	report(1, "ecall");
+	report(1, "received");
 	set_flag(1);
 }
 
@@ -160,7 +160,7 @@ static void emcall(void)
 	load_psw_mask(mask);
 	set_flag(1);
 	while (lc->ext_int_code != 0x1201) { mb(); }
-	report(1, "ecall");
+	report(1, "received");
 	set_flag(1);
 }
 
-- 
2.20.1

