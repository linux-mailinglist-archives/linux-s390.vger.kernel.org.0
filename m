Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C341AA00C5
	for <lists+linux-s390@lfdr.de>; Wed, 28 Aug 2019 13:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfH1Lgc (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 28 Aug 2019 07:36:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726259AbfH1Lgc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Aug 2019 07:36:32 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SBXB8s057833
        for <linux-s390@vger.kernel.org>; Wed, 28 Aug 2019 07:36:30 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2unq38cfes-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 28 Aug 2019 07:36:30 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 28 Aug 2019 12:36:29 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Aug 2019 12:36:26 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SBaPUx22020230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 11:36:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1ABB7A4064;
        Wed, 28 Aug 2019 11:36:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 714A1A405C;
        Wed, 28 Aug 2019 11:36:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.131])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 11:36:24 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com
Subject: [kvm-unit-tests PATCH v2 3/4] s390x: Bump march to zEC12
Date:   Wed, 28 Aug 2019 13:36:14 +0200
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190828113615.4769-1-frankja@linux.ibm.com>
References: <20190828113615.4769-1-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19082811-0020-0000-0000-00000364DBBD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082811-0021-0000-0000-000021BA2E35
Message-Id: <20190828113615.4769-4-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=788 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280124
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

TCG has majored a lot and can now support many newer instructions, so
there's no need to compile with the ancient march z900.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/s390x/Makefile b/s390x/Makefile
index 76db0bb..07bd353 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -25,7 +25,7 @@ CFLAGS += -std=gnu99
 CFLAGS += -ffreestanding
 CFLAGS += -I $(SRCDIR)/lib -I $(SRCDIR)/lib/s390x -I lib
 CFLAGS += -O2
-CFLAGS += -march=z900
+CFLAGS += -march=zEC12
 CFLAGS += -fno-delete-null-pointer-checks
 LDFLAGS += -nostdlib -Wl,--build-id=none
 
-- 
2.17.0

