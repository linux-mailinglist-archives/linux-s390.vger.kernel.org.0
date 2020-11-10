Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B18C2AD295
	for <lists+linux-s390@lfdr.de>; Tue, 10 Nov 2020 10:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgKJJgd (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 10 Nov 2020 04:36:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727991AbgKJJgc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Nov 2020 04:36:32 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AA9WvdO046244
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=M5/KSsW8UnA8YcFf2nd4RouJHaKP5NMuyFNjIGvP4xc=;
 b=CSPIh3jqPvbIW3x9YOl52iRavdRzPp30D+OjHrjgVe8qsdvRgI8WyOmCGAQYsj1f9SdF
 E1vgXvhbG09nma6EHKuuocgVVcJnTKSCoShILWTo5N+f/yjfRyCgMwDj8a8wvPxIqSmk
 UW9EjDTOK380w19gVrcDvDbWsyFO78oQHpk1Pt+YIo8KOZRbfJoXvS9Qhj6gpbe3bDfS
 MKDiItOQajzNQ9yXSfO1hVzmtqyfNfmHeOok7bfGj/nlPmYyb7xWsEVAYDOpT+DYq5IR
 1DrWxHCzURPUGy4jzOrJl+ArKHaz7dkuHE0xor0GvYRU6z/gRd7cbFh/Y3NqwmhC62vl bA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34qksy7q8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:31 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AA9X37G046669
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:31 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34qksy7q7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 04:36:31 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AA9XBpp000359;
        Tue, 10 Nov 2020 09:36:28 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 34nk789gvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 09:36:28 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AA9aQgC8716868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 09:36:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F230542042;
        Tue, 10 Nov 2020 09:36:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A80CE42049;
        Tue, 10 Nov 2020 09:36:25 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.174.65])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Nov 2020 09:36:25 +0000 (GMT)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 3/3] s390/vmem: make variable and function names consistent
Date:   Tue, 10 Nov 2020 10:36:23 +0100
Message-Id: <f9e09fe0e9c6b7d5ebc5c45c73b917a4ff39a24b.1605000280.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1605000280.git.agordeev@linux.ibm.com>
References: <cover.1605000280.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_04:2020-11-05,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 suspectscore=2 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100068
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Rename some variable and functions to better clarify
what they are and what they do.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/mm/vmem.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index d7f25884061f4..4bb198db6aa01 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -76,20 +76,20 @@ static void vmem_pte_free(unsigned long *table)
 
 /*
  * The unused vmemmap range, which was not yet memset(PAGE_UNUSED) ranges
- * from unused_pmd_start to next PMD_SIZE boundary.
+ * from unused_sub_pmd_start to next PMD_SIZE boundary.
  */
-static unsigned long unused_pmd_start;
+static unsigned long unused_sub_pmd_start;
 
-static void vmemmap_flush_unused_pmd(void)
+static void vmemmap_flush_unused_sub_pmd(void)
 {
-	if (!unused_pmd_start)
+	if (!unused_sub_pmd_start)
 		return;
-	memset(__va(unused_pmd_start), PAGE_UNUSED,
-	       ALIGN(unused_pmd_start, PMD_SIZE) - unused_pmd_start);
-	unused_pmd_start = 0;
+	memset(__va(unused_sub_pmd_start), PAGE_UNUSED,
+	       ALIGN(unused_sub_pmd_start, PMD_SIZE) - unused_sub_pmd_start);
+	unused_sub_pmd_start = 0;
 }
 
-static void __vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
+static void vmemmap_mark_sub_pmd_used(unsigned long start, unsigned long end)
 {
 	unsigned long size = min(end - start, sizeof(struct page));
 
@@ -108,24 +108,24 @@ static void vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
 	 * We only optimize if the new used range directly follows the
 	 * previously unused range (esp., when populating consecutive sections).
 	 */
-	if (unused_pmd_start == start) {
-		unused_pmd_start = end;
-		if (likely(IS_ALIGNED(unused_pmd_start, PMD_SIZE)))
-			unused_pmd_start = 0;
+	if (unused_sub_pmd_start == start) {
+		unused_sub_pmd_start = end;
+		if (likely(IS_ALIGNED(unused_sub_pmd_start, PMD_SIZE)))
+			unused_sub_pmd_start = 0;
 		return;
 	}
-	vmemmap_flush_unused_pmd();
-	__vmemmap_use_sub_pmd(start, end);
+	vmemmap_flush_unused_sub_pmd();
+	vmemmap_mark_sub_pmd_used(start, end);
 }
 
 static void vmemmap_use_new_sub_pmd(unsigned long start, unsigned long end)
 {
 	void *page = __va(ALIGN_DOWN(start, PMD_SIZE));
 
-	vmemmap_flush_unused_pmd();
+	vmemmap_flush_unused_sub_pmd();
 
 	/* Could be our memmap page is filled with PAGE_UNUSED already ... */
-	__vmemmap_use_sub_pmd(start, end);
+	vmemmap_mark_sub_pmd_used(start, end);
 
 	/* Mark the unused parts of the new memmap page PAGE_UNUSED. */
 	if (!IS_ALIGNED(start, PMD_SIZE))
@@ -136,7 +136,7 @@ static void vmemmap_use_new_sub_pmd(unsigned long start, unsigned long end)
 	 * unused range in the populated PMD.
 	 */
 	if (!IS_ALIGNED(end, PMD_SIZE))
-		unused_pmd_start = end;
+		unused_sub_pmd_start = end;
 }
 
 /* Returns true if the PMD is completely unused and can be freed. */
@@ -144,7 +144,7 @@ static bool vmemmap_unuse_sub_pmd(unsigned long start, unsigned long end)
 {
 	void *page = __va(ALIGN_DOWN(start, PMD_SIZE));
 
-	vmemmap_flush_unused_pmd();
+	vmemmap_flush_unused_sub_pmd();
 	memset(__va(start), PAGE_UNUSED, end - start);
 	return !memchr_inv(page, PAGE_UNUSED, PMD_SIZE);
 }
-- 
2.26.0

