Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D62E143E59
	for <lists+linux-s390@lfdr.de>; Tue, 21 Jan 2020 14:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgAUNn0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 21 Jan 2020 08:43:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729187AbgAUNnX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Jan 2020 08:43:23 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00LDgMuw023010
        for <linux-s390@vger.kernel.org>; Tue, 21 Jan 2020 08:43:22 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xkxhy4ah5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 21 Jan 2020 08:43:21 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 21 Jan 2020 13:43:19 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Jan 2020 13:43:16 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00LDhFxd55509184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 13:43:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C67D2A4060;
        Tue, 21 Jan 2020 13:43:15 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF2ADA405B;
        Tue, 21 Jan 2020 13:43:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.211])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jan 2020 13:43:14 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     thuth@redhat.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com
Subject: [kvm-unit-tests PATCH v4 4/9] s390x: smp: Rework cpu start and active tracking
Date:   Tue, 21 Jan 2020 08:42:49 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200121134254.4570-1-frankja@linux.ibm.com>
References: <20200121134254.4570-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012113-0020-0000-0000-000003A2B091
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012113-0021-0000-0000-000021FA4082
Message-Id: <20200121134254.4570-5-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-21_04:2020-01-21,2020-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=1
 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=867
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001210114
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The architecture specifies that processing sigp orders may be
asynchronous, and this is indeed the case on some hypervisors, so we
need to wait until the cpu runs before we return from the setup/start
function.

As there was a lot of duplicate code, a common function for cpu
restarts has been introduced.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 lib/s390x/smp.c | 50 ++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
index f57f420..84e681d 100644
--- a/lib/s390x/smp.c
+++ b/lib/s390x/smp.c
@@ -104,35 +104,46 @@ int smp_cpu_stop_store_status(uint16_t addr)
 	return rc;
 }
 
+static int smp_cpu_restart_nolock(uint16_t addr, struct psw *psw)
+{
+	int rc;
+	struct cpu *cpu = smp_cpu_from_addr(addr);
+
+	if (!cpu)
+		return -1;
+	if (psw) {
+		cpu->lowcore->restart_new_psw.mask = psw->mask;
+		cpu->lowcore->restart_new_psw.addr = psw->addr;
+	}
+	rc = sigp(addr, SIGP_RESTART, 0, NULL);
+	if (rc)
+		return rc;
+	/*
+	 * The order has been accepted, but the actual restart may not
+	 * have been performed yet, so wait until the cpu is running.
+	 */
+	while (!smp_cpu_running(addr))
+		mb();
+	cpu->active = true;
+	return 0;
+}
+
 int smp_cpu_restart(uint16_t addr)
 {
-	int rc = -1;
-	struct cpu *cpu;
+	int rc;
 
 	spin_lock(&lock);
-	cpu = smp_cpu_from_addr(addr);
-	if (cpu) {
-		rc = sigp(addr, SIGP_RESTART, 0, NULL);
-		cpu->active = true;
-	}
+	rc = smp_cpu_restart_nolock(addr, NULL);
 	spin_unlock(&lock);
 	return rc;
 }
 
 int smp_cpu_start(uint16_t addr, struct psw psw)
 {
-	int rc = -1;
-	struct cpu *cpu;
-	struct lowcore *lc;
+	int rc;
 
 	spin_lock(&lock);
-	cpu = smp_cpu_from_addr(addr);
-	if (cpu) {
-		lc = cpu->lowcore;
-		lc->restart_new_psw.mask = psw.mask;
-		lc->restart_new_psw.addr = psw.addr;
-		rc = sigp(addr, SIGP_RESTART, 0, NULL);
-	}
+	rc = smp_cpu_restart_nolock(addr, &psw);
 	spin_unlock(&lock);
 	return rc;
 }
@@ -192,10 +203,7 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)
 	lc->sw_int_crs[0] = 0x0000000000040000UL;
 
 	/* Start processing */
-	rc = sigp_retry(cpu->addr, SIGP_RESTART, 0, NULL);
-	if (!rc)
-		cpu->active = true;
-
+	smp_cpu_restart_nolock(addr, NULL);
 out:
 	spin_unlock(&lock);
 	return rc;
-- 
2.20.1

