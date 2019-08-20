Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02FB395CB1
	for <lists+linux-s390@lfdr.de>; Tue, 20 Aug 2019 12:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbfHTK4M (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 20 Aug 2019 06:56:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728842AbfHTK4M (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Aug 2019 06:56:12 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KAqhpf015326
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 06:56:11 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ugdc5pajg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 06:56:11 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 20 Aug 2019 11:56:09 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 20 Aug 2019 11:56:07 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7KAu6tu41812184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 10:56:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F015E4C046;
        Tue, 20 Aug 2019 10:56:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45D314C040;
        Tue, 20 Aug 2019 10:56:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.131])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Aug 2019 10:56:05 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com
Subject: [kvm-unit-tests PATCH 1/3] s390x: Support PSW restart boot
Date:   Tue, 20 Aug 2019 12:55:48 +0200
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190820105550.4991-1-frankja@linux.ibm.com>
References: <20190820105550.4991-1-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19082010-0012-0000-0000-00000340AA36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082010-0013-0000-0000-0000217ACDD3
Message-Id: <20190820105550.4991-2-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200114
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add a boot PSW to PSW restart new, so we can also boot via a PSW
restart.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/flat.lds | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/s390x/flat.lds b/s390x/flat.lds
index 403d967..86dffac 100644
--- a/s390x/flat.lds
+++ b/s390x/flat.lds
@@ -1,14 +1,18 @@
 SECTIONS
 {
-	/*
-	 * Initial short psw for disk boot, with 31 bit addressing for
-	 * non z/Arch environment compatibility and the instruction
-	 * address 0x10000 (cstart64.S .init).
-	 */
 	.lowcore : {
+		/*
+		 * Initial short psw for disk boot, with 31 bit addressing for
+		 * non z/Arch environment compatibility and the instruction
+		 * address 0x10000 (cstart64.S .init).
+		 */
 		. = 0;
 		 LONG(0x00080000)
 		 LONG(0x80010000)
+		 /* Restart new PSW for booting via PSW restart. */
+		 . = 0x1a0;
+		 QUAD(0x0000000180000000)
+		 QUAD(0x0000000000010000)
 	}
 	. = 0x10000;
 	.text : {
-- 
2.17.0

