Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2412AD294
	for <lists+linux-s390@lfdr.de>; Tue, 10 Nov 2020 10:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgKJJgc (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 10 Nov 2020 04:36:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727098AbgKJJgc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Nov 2020 04:36:32 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AA9YXdQ064883
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=E+iuxYVnIQlaWYFoHai7lumjfN7sHFciBdKQqF/nN5c=;
 b=KpQYr5uYUhqyYZgGO1sJXiCm8gEryWInIeNKyASc39vzG7TmIxCoIGaXpEV9+iuSaO+k
 2srxAZ47pgyiR+6nBsWRg+uiXdKo3Avz0eEiy25kJYwBs5QJFzO+YegZ2OSSk3xhwOBT
 pvbszRGaIfqwmhydDxdSCLwfP1GqTwc7JJ9mPteisC02ch3JlCjcmjKV3bRcF8uhV91N
 2qYN6VIplcthiAhNCQ2vVPW4qYG0npTXv4u1a2eM/ZWBYLAS3GaJovzDgU4MhMa0Y5fw
 ZspfL+R0ls0K3xuHnLvQrjc0rqlZME1Jy1jhVpZkkeGl5yTD4cCNKsuzoSUb9QvQgeU8 +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34qanawk12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:30 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AA9ZSea067834
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:30 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34qanawk00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 04:36:30 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AA9Vpx5007579;
        Tue, 10 Nov 2020 09:36:28 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 34njuh2yak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 09:36:28 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AA9aPBT8847994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 09:36:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36A9B4203F;
        Tue, 10 Nov 2020 09:36:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2FF042042;
        Tue, 10 Nov 2020 09:36:24 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.174.65])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Nov 2020 09:36:24 +0000 (GMT)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 1/3] s390/vmem: remove redundant check
Date:   Tue, 10 Nov 2020 10:36:21 +0100
Message-Id: <90f322a1d24b63a639dec1876a7a5cbbf866482a.1605000280.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1605000280.git.agordeev@linux.ibm.com>
References: <cover.1605000280.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_04:2020-11-05,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 bulkscore=0 mlxlogscore=982 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100068
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/mm/vmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index b239f2ba93b09..56ab9bb770f3a 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -223,7 +223,7 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 		if (!add) {
 			if (pmd_none(*pmd))
 				continue;
-			if (pmd_large(*pmd) && !add) {
+			if (pmd_large(*pmd)) {
 				if (IS_ALIGNED(addr, PMD_SIZE) &&
 				    IS_ALIGNED(next, PMD_SIZE)) {
 					if (!direct)
-- 
2.26.0

