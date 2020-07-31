Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0A5234393
	for <lists+linux-s390@lfdr.de>; Fri, 31 Jul 2020 11:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbgGaJqc (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 31 Jul 2020 05:46:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732400AbgGaJqb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jul 2020 05:46:31 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06V9jVFe153389;
        Fri, 31 Jul 2020 05:46:31 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mfsc9tsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 05:46:31 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06V93F4D153417;
        Fri, 31 Jul 2020 05:46:30 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mfsc9tr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 05:46:30 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06V9jlAD008365;
        Fri, 31 Jul 2020 09:46:27 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 32gcpwcbu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 09:46:27 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06V9kOwK26149194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 09:46:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AA4AAE04D;
        Fri, 31 Jul 2020 09:46:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 055CCAE05A;
        Fri, 31 Jul 2020 09:46:24 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.145.62.184])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 31 Jul 2020 09:46:23 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     pbonzini@redhat.com
Cc:     kvm@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com,
        thuth@redhat.com, pmorel@linux.ibm.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com
Subject: [kvm-unit-tests GIT PULL 09/11] s390x: css: msch, enable test
Date:   Fri, 31 Jul 2020 11:46:05 +0200
Message-Id: <20200731094607.15204-10-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200731094607.15204-1-frankja@linux.ibm.com>
References: <20200731094607.15204-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_02:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 suspectscore=1 impostorscore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310068
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Pierre Morel <pmorel@linux.ibm.com>

A second step when testing the channel subsystem is to prepare a channel
for use.
This includes:
- Get the current subchannel Information Block (SCHIB) using STSCH
- Update it in memory to set the ENABLE bit and the specified ISC
- Tell the CSS that the SCHIB has been modified using MSCH
- Get the SCHIB from the CSS again to verify that the subchannel is
  enabled and uses the specified ISC.
- If the command succeeds but subchannel is not enabled or the ISC
  field is not as expected, retry a predefined retries count.
- If the command fails, report the failure and do not retry, even
  if cc indicates a busy/status pending as we do not expect this.

This tests the MSCH instruction to enable a channel successfully.
Retries are done and in case of error, and if the retries count
is exceeded, a report is made.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <1594887809-10521-9-git-send-email-pmorel@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/css.h     |  9 ++++--
 lib/s390x/css_lib.c | 73 +++++++++++++++++++++++++++++++++++++++++++++
 s390x/css.c         | 15 ++++++++++
 3 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/lib/s390x/css.h b/lib/s390x/css.h
index 0ddceb1..63a70f1 100644
--- a/lib/s390x/css.h
+++ b/lib/s390x/css.h
@@ -71,8 +71,10 @@ struct scsw {
 
 struct pmcw {
 	uint32_t intparm;
-#define PMCW_DNV        0x0001
-#define PMCW_ENABLE     0x0080
+#define PMCW_DNV	0x0001
+#define PMCW_ENABLE	0x0080
+#define PMCW_ISC_MASK	0x3800
+#define PMCW_ISC_SHIFT	11
 	uint16_t flags;
 	uint16_t devnum;
 	uint8_t  lpm;
@@ -251,6 +253,7 @@ void dump_orb(struct orb *op);
 
 int css_enumerate(void);
 #define MAX_ENABLE_RETRIES      5
-int css_enable(int schid);
 
+#define IO_SCH_ISC      3
+int css_enable(int schid, int isc);
 #endif
diff --git a/lib/s390x/css_lib.c b/lib/s390x/css_lib.c
index fd087ce..e47a945 100644
--- a/lib/s390x/css_lib.c
+++ b/lib/s390x/css_lib.c
@@ -15,6 +15,7 @@
 #include <string.h>
 #include <interrupt.h>
 #include <asm/arch_def.h>
+#include <asm/time.h>
 
 #include <css.h>
 
@@ -68,3 +69,75 @@ out:
 		    scn, scn_found, dev_found);
 	return schid;
 }
+
+/*
+ * css_enable: enable the subchannel with the specified ISC
+ * @schid: Subchannel Identifier
+ * @isc  : number of the interruption subclass to use
+ * Return value:
+ *   On success: 0
+ *   On error the CC of the faulty instruction
+ *      or -1 if the retry count is exceeded.
+ */
+int css_enable(int schid, int isc)
+{
+	struct pmcw *pmcw = &schib.pmcw;
+	int retry_count = 0;
+	uint16_t flags;
+	int cc;
+
+	/* Read the SCHIB for this subchannel */
+	cc = stsch(schid, &schib);
+	if (cc) {
+		report_info("stsch: sch %08x failed with cc=%d", schid, cc);
+		return cc;
+	}
+
+	flags = PMCW_ENABLE | (isc << PMCW_ISC_SHIFT);
+	if ((pmcw->flags & (PMCW_ISC_MASK | PMCW_ENABLE)) == flags) {
+		report_info("stsch: sch %08x already enabled", schid);
+		return 0;
+	}
+
+retry:
+	/* Update the SCHIB to enable the channel and set the ISC */
+	pmcw->flags &= ~PMCW_ISC_MASK;
+	pmcw->flags |= flags;
+
+	/* Tell the CSS we want to modify the subchannel */
+	cc = msch(schid, &schib);
+	if (cc) {
+		/*
+		 * If the subchannel is status pending or
+		 * if a function is in progress,
+		 * we consider both cases as errors.
+		 */
+		report_info("msch: sch %08x failed with cc=%d", schid, cc);
+		return cc;
+	}
+
+	/*
+	 * Read the SCHIB again to verify the enablement
+	 */
+	cc = stsch(schid, &schib);
+	if (cc) {
+		report_info("stsch: updating sch %08x failed with cc=%d",
+			    schid, cc);
+		return cc;
+	}
+
+	if ((pmcw->flags & flags) == flags) {
+		report_info("stsch: sch %08x successfully modified after %d retries",
+			    schid, retry_count);
+		return 0;
+	}
+
+	if (retry_count++ < MAX_ENABLE_RETRIES) {
+		mdelay(10); /* the hardware was not ready, give it some time */
+		goto retry;
+	}
+
+	report_info("msch: modifying sch %08x failed after %d retries. pmcw flags: %04x",
+		    schid, retry_count, pmcw->flags);
+	return -1;
+}
diff --git a/s390x/css.c b/s390x/css.c
index e19ffc8..f314a0c 100644
--- a/s390x/css.c
+++ b/s390x/css.c
@@ -31,11 +31,26 @@ static void test_enumerate(void)
 	report(0, "No I/O device found");
 }
 
+static void test_enable(void)
+{
+	int cc;
+
+	if (!test_device_sid) {
+		report_skip("No device");
+		return;
+	}
+
+	cc = css_enable(test_device_sid, IO_SCH_ISC);
+
+	report(cc == 0, "Enable subchannel %08x", test_device_sid);
+}
+
 static struct {
 	const char *name;
 	void (*func)(void);
 } tests[] = {
 	{ "enumerate (stsch)", test_enumerate },
+	{ "enable (msch)", test_enable },
 	{ NULL, NULL }
 };
 
-- 
2.25.4

