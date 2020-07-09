Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9587219A87
	for <lists+linux-s390@lfdr.de>; Thu,  9 Jul 2020 10:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgGIIH7 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 9 Jul 2020 04:07:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23686 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726504AbgGIIH7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jul 2020 04:07:59 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06985n02009925;
        Thu, 9 Jul 2020 04:07:57 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 325wbv3c0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 04:07:57 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06985pkO009973;
        Thu, 9 Jul 2020 04:07:57 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 325wbv3c0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 04:07:57 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06987LMI025673;
        Thu, 9 Jul 2020 08:07:54 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 325k0crkcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 08:07:54 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06986UYP16712010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jul 2020 08:06:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62D0BA405F;
        Thu,  9 Jul 2020 08:07:52 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E49F3A405C;
        Thu,  9 Jul 2020 08:07:51 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.34.67])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jul 2020 08:07:51 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@redhat.com, thuth@redhat.com, cohuck@redhat.com,
        drjones@redhat.com
Subject: [kvm-unit-tests PATCH v11 4/9] s390x: clock and delays calculations
Date:   Thu,  9 Jul 2020 10:07:43 +0200
Message-Id: <1594282068-11054-5-git-send-email-pmorel@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594282068-11054-1-git-send-email-pmorel@linux.ibm.com>
References: <1594282068-11054-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_04:2020-07-08,2020-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 phishscore=0 suspectscore=1 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090064
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The hardware gives us a good definition of the microsecond,
let's keep this information and let the routine accessing
the hardware keep all the information and return microseconds.

Calculate delays in microseconds and take care about wrapping
around zero.

Define values with macros and use inlines to keep the
milliseconds interface.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/asm/time.h | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/lib/s390x/asm/time.h b/lib/s390x/asm/time.h
index 1791380..7375aa2 100644
--- a/lib/s390x/asm/time.h
+++ b/lib/s390x/asm/time.h
@@ -13,14 +13,38 @@
 #ifndef ASM_S390X_TIME_H
 #define ASM_S390X_TIME_H
 
-static inline uint64_t get_clock_ms(void)
+#define STCK_SHIFT_US	(63 - 51)
+#define STCK_MAX	((1UL << 52) - 1)
+
+static inline uint64_t get_clock_us(void)
 {
 	uint64_t clk;
 
 	asm volatile(" stck %0 " : : "Q"(clk) : "memory");
 
-	/* Bit 51 is incrememented each microsecond */
-	return (clk >> (63 - 51)) / 1000;
+	return clk >> STCK_SHIFT_US;
+}
+
+static inline uint64_t get_clock_ms(void)
+{
+	return get_clock_us() / 1000;
+}
+
+static inline void udelay(unsigned long us)
+{
+	unsigned long startclk = get_clock_us();
+	unsigned long c;
+
+	do {
+		c = get_clock_us();
+		if (c < startclk)
+			c += STCK_MAX;
+	} while (c < startclk + us);
+}
+
+static inline void mdelay(unsigned long ms)
+{
+	udelay(ms * 1000);
 }
 
 #endif
-- 
2.25.1

