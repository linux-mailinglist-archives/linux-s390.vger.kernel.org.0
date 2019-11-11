Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB88F77B5
	for <lists+linux-s390@lfdr.de>; Mon, 11 Nov 2019 16:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfKKPd7 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 11 Nov 2019 10:33:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbfKKPd7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Nov 2019 10:33:59 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xABFUOGF019092
        for <linux-s390@vger.kernel.org>; Mon, 11 Nov 2019 10:33:58 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7a7wgn5f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 11 Nov 2019 10:33:58 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 11 Nov 2019 15:33:56 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Nov 2019 15:33:53 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xABFXrW953412010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Nov 2019 15:33:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05D6952050;
        Mon, 11 Nov 2019 15:33:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.179.89])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D659852057;
        Mon, 11 Nov 2019 15:33:51 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com
Subject: [kvm-unit-tests PATCH v2 1/3] s390x: Fix initial cr0 load comments
Date:   Mon, 11 Nov 2019 10:33:43 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191111153345.22505-1-frankja@linux.ibm.com>
References: <20191111153345.22505-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111115-4275-0000-0000-0000037CC698
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111115-4276-0000-0000-00003890203B
Message-Id: <20191111153345.22505-2-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=885 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911110142
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

We need to load cr0 to have access to all fprs during save and restore
of fprs. Saving conditionally on basis of the CR0 AFP bit would be a
pain.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/cstart64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/s390x/cstart64.S b/s390x/cstart64.S
index 8e2b21e..043e34a 100644
--- a/s390x/cstart64.S
+++ b/s390x/cstart64.S
@@ -94,7 +94,7 @@ memsetxc:
 	stmg	%r0, %r15, GEN_LC_SW_INT_GRS
 	/* save cr0 */
 	stctg	%c0, %c0, GEN_LC_SW_INT_CR0
-	/* load initial cr0 again */
+	/* load a cr0 that has the AFP control bit which enables all FPRs */
 	larl	%r1, initial_cr0
 	lctlg	%c0, %c0, 0(%r1)
 	/* save fprs 0-15 + fpc */
@@ -139,7 +139,7 @@ diag308_load_reset:
 	xgr	%r2, %r2
 	br	%r14
 	/* Success path */
-	/* We lost cr0 due to the reset */
+	/* load a cr0 that has the AFP control bit which enables all FPRs */
 0:	larl	%r1, initial_cr0
 	lctlg	%c0, %c0, 0(%r1)
 	RESTORE_REGS
-- 
2.20.1

