Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5793A391ADF
	for <lists+linux-s390@lfdr.de>; Wed, 26 May 2021 16:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbhEZO53 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 26 May 2021 10:57:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235156AbhEZO53 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 May 2021 10:57:29 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14QEWbvZ031971;
        Wed, 26 May 2021 10:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+fiFLkvJW429bUyNlMqzhnk/9Bx1NXP9vx3Q2lpsP54=;
 b=IEY4P2QS3gM8McRyNQdx+6ylvG/5xYzLJGvVgduF/KLdC6SfNezOIO0G1keU6Rx6l16c
 rMvFTQoYfybuAuY2iiGzT2Or8DfdSH6ps0OdL+iKfM77Tl7DyIw8QCC/Ciamv9ndDqwt
 m81OZUhHgYuByF0tJ0WCoA797zw1oFVHtv+f1+o+7jXNM7zpWadbgJBUyv2ov/zkawxn
 SscPe5EmINMnO/E2ihQPtA6dQiDYFOOTNki8xwlRbkJyBnbm7tS74+IrgHLOfbjTETJv
 3IkNONXezqHgw3kFrnTLGvvxu7+L/QGCgUrXgY5XVkdd9w/nBq6FaRUzuilktB9A7sUQ Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38sqanjk11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 10:55:57 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14QEXoT5037153;
        Wed, 26 May 2021 10:55:56 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38sqanjk01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 10:55:56 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14QEqXpp003766;
        Wed, 26 May 2021 14:55:54 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 38s1ssrbnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 14:55:54 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14QEtpGd18940394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 14:55:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51FD3A407C;
        Wed, 26 May 2021 14:55:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1C2BA40A6;
        Wed, 26 May 2021 14:55:49 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.145.174.11])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 May 2021 14:55:49 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     pbonzini@redhat.com
Cc:     kvm@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        thuth@redhat.com
Subject: [kvm-unit-tests GIT PULL 3/9] s390x: uv: Add UV lib
Date:   Wed, 26 May 2021 16:55:33 +0200
Message-Id: <20210526145539.52008-4-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526145539.52008-1-frankja@linux.ibm.com>
References: <20210526145539.52008-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LJ1A84O7zaxH6vhZJl6Wbxj5ZyxTAXLY
X-Proofpoint-ORIG-GUID: xTMSMSRVO0clrL2feQhmPx2whh8B2q0p
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_09:2021-05-26,2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105260098
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Lets add a UV library to make checking the UV feature bit easier.
In the future this library file can take care of handling UV
initialization and UV guest creation.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 lib/s390x/asm/uv.h |  4 ++--
 lib/s390x/io.c     |  2 ++
 lib/s390x/uv.c     | 45 +++++++++++++++++++++++++++++++++++++++++++++
 lib/s390x/uv.h     | 10 ++++++++++
 s390x/Makefile     |  1 +
 5 files changed, 60 insertions(+), 2 deletions(-)
 create mode 100644 lib/s390x/uv.c
 create mode 100644 lib/s390x/uv.h

diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
index 11f70a9f..b22cbaa8 100644
--- a/lib/s390x/asm/uv.h
+++ b/lib/s390x/asm/uv.h
@@ -9,8 +9,8 @@
  * This code is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2.
  */
-#ifndef UV_H
-#define UV_H
+#ifndef ASM_S390X_UV_H
+#define ASM_S390X_UV_H
 
 #define UVC_RC_EXECUTED		0x0001
 #define UVC_RC_INV_CMD		0x0002
diff --git a/lib/s390x/io.c b/lib/s390x/io.c
index ef9f59e3..a4f1b113 100644
--- a/lib/s390x/io.c
+++ b/lib/s390x/io.c
@@ -14,6 +14,7 @@
 #include <asm/facility.h>
 #include <asm/sigp.h>
 #include "sclp.h"
+#include "uv.h"
 #include "smp.h"
 
 extern char ipl_args[];
@@ -38,6 +39,7 @@ void setup(void)
 	sclp_facilities_setup();
 	sclp_console_setup();
 	sclp_memory_setup();
+	uv_setup();
 	smp_setup();
 }
 
diff --git a/lib/s390x/uv.c b/lib/s390x/uv.c
new file mode 100644
index 00000000..0d8c141c
--- /dev/null
+++ b/lib/s390x/uv.c
@@ -0,0 +1,45 @@
+#include <libcflat.h>
+#include <bitops.h>
+#include <alloc.h>
+#include <alloc_page.h>
+#include <asm/page.h>
+#include <asm/arch_def.h>
+
+#include <asm/facility.h>
+#include <asm/uv.h>
+#include <uv.h>
+
+static struct uv_cb_qui uvcb_qui = {
+	.header.cmd = UVC_CMD_QUI,
+	.header.len = sizeof(uvcb_qui),
+};
+
+bool uv_os_is_guest(void)
+{
+	return test_facility(158) &&
+		uv_query_test_call(BIT_UVC_CMD_SET_SHARED_ACCESS) &&
+		uv_query_test_call(BIT_UVC_CMD_REMOVE_SHARED_ACCESS);
+}
+
+bool uv_os_is_host(void)
+{
+	return test_facility(158) && uv_query_test_call(BIT_UVC_CMD_INIT_UV);
+}
+
+bool uv_query_test_call(unsigned int nr)
+{
+	/* Query needs to be called first */
+	assert(uvcb_qui.header.rc);
+	assert(nr < BITS_PER_LONG * ARRAY_SIZE(uvcb_qui.inst_calls_list));
+
+	return test_bit_inv(nr, uvcb_qui.inst_calls_list);
+}
+
+int uv_setup(void)
+{
+	if (!test_facility(158))
+		return 0;
+
+	assert(!uv_call(0, (u64)&uvcb_qui));
+	return 1;
+}
diff --git a/lib/s390x/uv.h b/lib/s390x/uv.h
new file mode 100644
index 00000000..42608a96
--- /dev/null
+++ b/lib/s390x/uv.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef UV_H
+#define UV_H
+
+bool uv_os_is_guest(void);
+bool uv_os_is_host(void);
+bool uv_query_test_call(unsigned int nr);
+int uv_setup(void);
+
+#endif /* UV_H */
diff --git a/s390x/Makefile b/s390x/Makefile
index b92de9c5..bbf177fa 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -67,6 +67,7 @@ cflatobjs += lib/s390x/vm.o
 cflatobjs += lib/s390x/css_dump.o
 cflatobjs += lib/s390x/css_lib.o
 cflatobjs += lib/s390x/malloc_io.o
+cflatobjs += lib/s390x/uv.o
 
 OBJDIRS += lib/s390x
 
-- 
2.31.1

