Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5C74F26AF
	for <lists+linux-s390@lfdr.de>; Tue,  5 Apr 2022 10:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiDEIEk (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 5 Apr 2022 04:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbiDEH7w (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Apr 2022 03:59:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873E44131C;
        Tue,  5 Apr 2022 00:55:48 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2357dqxm008926;
        Tue, 5 Apr 2022 07:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4QJTcaMRTLGT9n1xUKyyCrIbuXDJUbuoPr4iGXqINjw=;
 b=bkAglgu5D/XdMVi3SqfFiOc6i/z82/AMYjucI3ASaWXmlqjxEq00abfWmZoVXjbultoi
 qE2O5VmhJrumgpq3gk4d/1/jp1ja0Wen1hxx+O0HCxQgocLh5rZpq+rxVZQP5cgx5lv6
 gbCxgfRwgrIQBYgTysf47RO3WKMI9yQF0ua/2MZAHYiEg+/MQRb8sI3yJCqJuWF7xLcg
 f/oa8l3pExUYnTC30GFAswvmPHNz7wW1WI7f6khXKfdLMPvRbdMmnog+oKWDW3YkufD9
 dUS+qF6oYU9h+YgW2/1cZk9uNKmQgeBrhSTTfH+vbRKJl5dEDYw/RIXuyz+LdFdSOoFg ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f705hjrub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Apr 2022 07:55:47 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2357i1Yv023169;
        Tue, 5 Apr 2022 07:55:47 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f705hjrtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Apr 2022 07:55:47 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2357hTes024593;
        Tue, 5 Apr 2022 07:55:45 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3f6e48v9g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Apr 2022 07:55:45 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2357tgTL45613422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Apr 2022 07:55:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E900842042;
        Tue,  5 Apr 2022 07:55:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2888F4203F;
        Tue,  5 Apr 2022 07:55:41 +0000 (GMT)
Received: from linux6.. (unknown [9.114.12.104])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Apr 2022 07:55:41 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, thuth@redhat.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com
Subject: [kvm-unit-tests PATCH 5/8] s390x: pv-diags: Cleanup includes
Date:   Tue,  5 Apr 2022 07:52:22 +0000
Message-Id: <20220405075225.15903-6-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405075225.15903-1-frankja@linux.ibm.com>
References: <20220405075225.15903-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nkui-oPANCeCASvctxQIlVvhQKQuCK94
X-Proofpoint-ORIG-GUID: gVbxXgG1A_KAOI7oRPrGYVcPPrfxxVV9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_09,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=765
 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204050044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This file has way too much includes. Time to remove some.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/pv-diags.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/s390x/pv-diags.c b/s390x/pv-diags.c
index 6899b859..9ced68c7 100644
--- a/s390x/pv-diags.c
+++ b/s390x/pv-diags.c
@@ -8,23 +8,10 @@
  *  Janosch Frank <frankja@linux.ibm.com>
  */
 #include <libcflat.h>
-#include <asm/asm-offsets.h>
-#include <asm-generic/barrier.h>
-#include <asm/interrupt.h>
-#include <asm/pgtable.h>
-#include <mmu.h>
-#include <asm/page.h>
-#include <asm/facility.h>
-#include <asm/mem.h>
-#include <asm/sigp.h>
-#include <smp.h>
-#include <alloc_page.h>
-#include <vmalloc.h>
-#include <sclp.h>
 #include <snippet.h>
 #include <sie.h>
-#include <uv.h>
-#include <asm/uv.h>
+#include <sclp.h>
+#include <asm/facility.h>
 
 static struct vm vm;
 
-- 
2.32.0

