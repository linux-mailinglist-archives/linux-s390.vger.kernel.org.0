Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7857F2AD293
	for <lists+linux-s390@lfdr.de>; Tue, 10 Nov 2020 10:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgKJJgb (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 10 Nov 2020 04:36:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727991AbgKJJgb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Nov 2020 04:36:31 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AA9WJ7O148412
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=bSQimbq3fJmS1gED5S3Il0Rus5kFp68r0wh0NjN/G7o=;
 b=FAaKoCGpHtg2XuGntTRsAgaXdoDwJ3/sOgbxeEkxbbpsdb1EbB6obYfoiRHLvZoX7pch
 C3SvcbIQx0L3+Sgiz1YVz69/BXM7nXWy0STr3C5UI6DGayYk/Dv93QHp5giDda2l+MCI
 5JojrPHITTSm9h8NdEv7HJPD098WN4i0URGOmgsoGJk+xqjob18lCocfxvGSVmA6SvfK
 ExFMBlUL+lxC/TTH1MGLxqYBl+6iHdRql/sXwazha1uTgjZIlCZLCT6/eJiyUsOXs/Df
 JeDnvN2esEjn8OoinevgENhT2MvUyf2kKZfeYe/me/DejjZdwhAJYMATSWZByDoZr7Px EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34qhq32guk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:30 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AA9Y2sY157946
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:30 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34qhq32gtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 04:36:30 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AA9Vk0w008275;
        Tue, 10 Nov 2020 09:36:28 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 34nk781gu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 09:36:28 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AA9aP7j8847996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 09:36:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 935CC4203F;
        Tue, 10 Nov 2020 09:36:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B81942047;
        Tue, 10 Nov 2020 09:36:25 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.174.65])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Nov 2020 09:36:25 +0000 (GMT)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 2/3] s390/vmem: fix possible memory overwrite
Date:   Tue, 10 Nov 2020 10:36:22 +0100
Message-Id: <1abf78a289d76d7448a5640073cf6e8221a54a55.1605000280.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1605000280.git.agordeev@linux.ibm.com>
References: <cover.1605000280.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_04:2020-11-05,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=755 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100066
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

If for whatever reason the sub-PMD region to be used is less
than struct page size (e.g in the future), then it is possible
to overwrite beyond the region size.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/mm/vmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 56ab9bb770f3a..d7f25884061f4 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -91,13 +91,15 @@ static void vmemmap_flush_unused_pmd(void)
 
 static void __vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
 {
+	unsigned long size = min(end - start, sizeof(struct page));
+
 	/*
 	 * As we expect to add in the same granularity as we remove, it's
 	 * sufficient to mark only some piece used to block the memmap page from
 	 * getting removed (just in case the memmap never gets initialized,
 	 * e.g., because the memory block never gets onlined).
 	 */
-	memset(__va(start), 0, sizeof(struct page));
+	memset(__va(start), 0, size);
 }
 
 static void vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
-- 
2.26.0

