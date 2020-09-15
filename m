Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79ECF26AA91
	for <lists+linux-s390@lfdr.de>; Tue, 15 Sep 2020 19:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgIOR1y (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 15 Sep 2020 13:27:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39060 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727540AbgIOR1H (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 13:27:07 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FFXLZp175964;
        Tue, 15 Sep 2020 11:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=sxB+CX7TO/+AfDjZVtHfRKkGDonWjuAw8lMsibi3RDg=;
 b=dQqePQNP8xNGDNnpoMGube1c4PJe6Ri/5da6QfZF4dObL2O/vYehqbcxiFoeTd+ORNBj
 GW96aVq05rQ9YilFYpwkfIaHDOYZiNh5edilvepKE6cYkVA44yaiahsrYmF1SycrM0MS
 XOz/FJSzyDULlAVEmbMDgIq7koHfkKWb8b7ageS59OuorDxjLQPwUbbmCWYuiwgt/F4Z
 tTrFQWJRA4ANhza3oAjFRo2e0uHymgdt9rMyRePSvO19N0Goceg8duwWz5rBUvrD8GVP
 MeqN97CghoB2FUfnk806b7CkX9uHckWSiY4DnjW7TLw4iwCasMpZMcEUHt1cleh1GFi2 gg== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33jx26v8jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 11:43:47 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FFN5IA016638;
        Tue, 15 Sep 2020 15:43:45 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 33hkfah92q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 15:43:44 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08FFhghu22086014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 15:43:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F36E2A405B;
        Tue, 15 Sep 2020 15:43:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9EB6A4054;
        Tue, 15 Sep 2020 15:43:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Sep 2020 15:43:41 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH 2/4] s390/dis: get rid of set_fs() usage
Date:   Tue, 15 Sep 2020 17:43:38 +0200
Message-Id: <20200915154340.4215-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915154340.4215-1-hca@linux.ibm.com>
References: <20200915154340.4215-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_11:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=931
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150128
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/dis.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
index f304802ecf7b..68bf2e9ebe5a 100644
--- a/arch/s390/kernel/dis.c
+++ b/arch/s390/kernel/dis.c
@@ -487,26 +487,30 @@ void show_code(struct pt_regs *regs)
 	char *mode = user_mode(regs) ? "User" : "Krnl";
 	unsigned char code[64];
 	char buffer[128], *ptr;
-	mm_segment_t old_fs;
 	unsigned long addr;
 	int start, end, opsize, hops, i;
 
 	/* Get a snapshot of the 64 bytes surrounding the fault address. */
-	old_fs = get_fs();
-	set_fs(user_mode(regs) ? USER_DS : KERNEL_DS);
 	for (start = 32; start && regs->psw.addr >= 34 - start; start -= 2) {
 		addr = regs->psw.addr - 34 + start;
-		if (__copy_from_user(code + start - 2,
-				     (char __user *) addr, 2))
-			break;
+		if (user_mode(regs)) {
+			if (__copy_from_user(code + start - 2, (char __user *)addr, 2))
+				break;
+		} else {
+			if (copy_from_kernel_nofault(code + start - 2, (char *)addr, 2))
+				break;
+		}
 	}
 	for (end = 32; end < 64; end += 2) {
 		addr = regs->psw.addr + end - 32;
-		if (__copy_from_user(code + end,
-				     (char __user *) addr, 2))
-			break;
+		if (user_mode(regs)) {
+			if (__copy_from_user(code + end, (char __user *)addr, 2))
+				break;
+		} else {
+			if (copy_from_kernel_nofault(code + end, (char *)addr, 2))
+				break;
+		}
 	}
-	set_fs(old_fs);
 	/* Code snapshot useable ? */
 	if ((regs->psw.addr & 1) || start >= end) {
 		printk("%s Code: Bad PSW.\n", mode);
-- 
2.17.1

