Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD9D17A1D5
	for <lists+linux-s390@lfdr.de>; Thu,  5 Mar 2020 10:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCEJEL (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 5 Mar 2020 04:04:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgCEJEK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Mar 2020 04:04:10 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0258wfJZ049346
        for <linux-s390@vger.kernel.org>; Thu, 5 Mar 2020 04:04:09 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yj4q25jh8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 05 Mar 2020 04:04:08 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <mimu@linux.ibm.com>;
        Thu, 5 Mar 2020 09:04:06 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Mar 2020 09:04:04 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 025942UE61603854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Mar 2020 09:04:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 292684C046;
        Thu,  5 Mar 2020 09:04:02 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB85B4C040;
        Thu,  5 Mar 2020 09:04:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Mar 2020 09:04:01 +0000 (GMT)
From:   Michael Mueller <mimu@linux.ibm.com>
To:     linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH] s390/diag: fix display of diagnose call statistics
Date:   Thu,  5 Mar 2020 10:03:55 +0100
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 20030509-0028-0000-0000-000003E11438
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030509-0029-0000-0000-000024A64869
Message-Id: <20200305090355.88036-1-mimu@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-05_02:2020-03-04,2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=1 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0 mlxlogscore=876
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050057
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Show the full diag statistic table and not just parts of it.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/kernel/diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/diag.c b/arch/s390/kernel/diag.c
index e9dac9a24d3f..61f2b0412345 100644
--- a/arch/s390/kernel/diag.c
+++ b/arch/s390/kernel/diag.c
@@ -84,7 +84,7 @@ static int show_diag_stat(struct seq_file *m, void *v)
 
 static void *show_diag_stat_start(struct seq_file *m, loff_t *pos)
 {
-	return *pos <= nr_cpu_ids ? (void *)((unsigned long) *pos + 1) : NULL;
+	return *pos <= NR_DIAG_STAT ? (void *)((unsigned long) *pos + 1) : NULL;
 }
 
 static void *show_diag_stat_next(struct seq_file *m, void *v, loff_t *pos)
-- 
2.17.1

