Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C32E1F9385
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2020 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgFOJcN (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 15 Jun 2020 05:32:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729155AbgFOJcM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jun 2020 05:32:12 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05F9I3xw126464;
        Mon, 15 Jun 2020 05:32:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31n45cd609-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 05:32:11 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05F83NEf112957;
        Mon, 15 Jun 2020 05:32:10 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31n45cd5xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 05:32:10 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05F9L81V024525;
        Mon, 15 Jun 2020 09:32:07 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 31mpe81agc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 09:32:07 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05F9W5Hr41812018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jun 2020 09:32:05 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B99D95206D;
        Mon, 15 Jun 2020 09:32:04 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.1.141])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5D5775204E;
        Mon, 15 Jun 2020 09:32:04 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@redhat.com, thuth@redhat.com, cohuck@redhat.com
Subject: [kvm-unit-tests PATCH v9 04/12] s390x: interrupt registration
Date:   Mon, 15 Jun 2020 11:31:53 +0200
Message-Id: <1592213521-19390-5-git-send-email-pmorel@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-15_01:2020-06-15,2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=1 phishscore=0 adultscore=0 mlxlogscore=777
 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0
 clxscore=1015 cotscore=-2147483648 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006150066
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Let's make it possible to add and remove a custom io interrupt handler,
that can be used instead of the normal one.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/interrupt.c | 23 ++++++++++++++++++++++-
 lib/s390x/interrupt.h |  8 ++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 lib/s390x/interrupt.h

diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
index 3a40cac..243b9c2 100644
--- a/lib/s390x/interrupt.c
+++ b/lib/s390x/interrupt.c
@@ -10,9 +10,9 @@
  * under the terms of the GNU Library General Public License version 2.
  */
 #include <libcflat.h>
-#include <asm/interrupt.h>
 #include <asm/barrier.h>
 #include <sclp.h>
+#include <interrupt.h>
 
 static bool pgm_int_expected;
 static bool ext_int_expected;
@@ -144,12 +144,33 @@ void handle_mcck_int(void)
 		     stap(), lc->mcck_old_psw.addr);
 }
 
+static void (*io_int_func)(void);
+
 void handle_io_int(void)
 {
+	if (io_int_func)
+		return io_int_func();
+
 	report_abort("Unexpected io interrupt: on cpu %d at %#lx",
 		     stap(), lc->io_old_psw.addr);
 }
 
+int register_io_int_func(void (*f)(void))
+{
+	if (io_int_func)
+		return -1;
+	io_int_func = f;
+	return 0;
+}
+
+int unregister_io_int_func(void (*f)(void))
+{
+	if (io_int_func != f)
+		return -1;
+	io_int_func = NULL;
+	return 0;
+}
+
 void handle_svc_int(void)
 {
 	report_abort("Unexpected supervisor call interrupt: on cpu %d at %#lx",
diff --git a/lib/s390x/interrupt.h b/lib/s390x/interrupt.h
new file mode 100644
index 0000000..1973d26
--- /dev/null
+++ b/lib/s390x/interrupt.h
@@ -0,0 +1,8 @@
+#ifndef INTERRUPT_H
+#define INTERRUPT_H
+#include <asm/interrupt.h>
+
+int register_io_int_func(void (*f)(void));
+int unregister_io_int_func(void (*f)(void));
+
+#endif /* INTERRUPT_H */
-- 
2.25.1

