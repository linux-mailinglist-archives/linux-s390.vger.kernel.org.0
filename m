Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 334B2135DF9
	for <lists+linux-s390@lfdr.de>; Thu,  9 Jan 2020 17:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387537AbgAIQQf (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 9 Jan 2020 11:16:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19462 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387529AbgAIQQe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jan 2020 11:16:34 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009G9p4X132186
        for <linux-s390@vger.kernel.org>; Thu, 9 Jan 2020 11:16:33 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xe0skguvp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 09 Jan 2020 11:16:33 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Thu, 9 Jan 2020 16:16:31 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Jan 2020 16:16:27 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 009GFcQn32113034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jan 2020 16:15:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25A124C052;
        Thu,  9 Jan 2020 16:16:26 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD8E54C04A;
        Thu,  9 Jan 2020 16:16:25 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.108])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jan 2020 16:16:25 +0000 (GMT)
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com
Subject: [kvm-unit-tests PATCH v6 2/4] s390x: sclp: add service call instruction wrapper
Date:   Thu,  9 Jan 2020 17:16:23 +0100
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109161625.154894-1-imbrenda@linux.ibm.com>
References: <20200109161625.154894-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010916-4275-0000-0000-000003962CBE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010916-4276-0000-0000-000038AA1D06
Message-Id: <20200109161625.154894-3-imbrenda@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_03:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 suspectscore=1 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001090138
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add a wrapper for the service call instruction, and use it for SCLP
interactions instead of using inline assembly everywhere.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/asm/arch_def.h | 13 +++++++++++++
 lib/s390x/sclp.c         |  7 +------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
index cf6e1ca..1a5e3c6 100644
--- a/lib/s390x/asm/arch_def.h
+++ b/lib/s390x/asm/arch_def.h
@@ -271,4 +271,17 @@ static inline int stsi(void *addr, int fc, int sel1, int sel2)
 	return cc;
 }
 
+static inline int servc(uint32_t command, unsigned long sccb)
+{
+	int cc;
+
+	asm volatile(
+		"       .insn   rre,0xb2200000,%1,%2\n"  /* servc %1,%2 */
+		"       ipm     %0\n"
+		"       srl     %0,28"
+		: "=&d" (cc) : "d" (command), "a" (sccb)
+		: "cc", "memory");
+	return cc;
+}
+
 #endif
diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index 123b639..4054d0e 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -116,12 +116,7 @@ int sclp_service_call(unsigned int command, void *sccb)
 	int cc;
 
 	sclp_setup_int();
-	asm volatile(
-		"       .insn   rre,0xb2200000,%1,%2\n"  /* servc %1,%2 */
-		"       ipm     %0\n"
-		"       srl     %0,28"
-		: "=&d" (cc) : "d" (command), "a" (__pa(sccb))
-		: "cc", "memory");
+	cc = servc(command, __pa(sccb));
 	sclp_wait_busy();
 	if (cc == 3)
 		return -1;
-- 
2.24.1

