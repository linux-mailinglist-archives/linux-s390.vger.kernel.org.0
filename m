Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D221B12FED2
	for <lists+linux-s390@lfdr.de>; Fri,  3 Jan 2020 23:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgACWdq (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 Jan 2020 17:33:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728882AbgACWdp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jan 2020 17:33:45 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 003MHKq1030550
        for <linux-s390@vger.kernel.org>; Fri, 3 Jan 2020 17:33:44 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x9x04hsb0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 03 Jan 2020 17:33:44 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <zaslonko@linux.ibm.com>;
        Fri, 3 Jan 2020 22:33:42 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Jan 2020 22:33:38 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 003MXbc051773598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jan 2020 22:33:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07AE752073;
        Fri,  3 Jan 2020 22:33:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A338E52071;
        Fri,  3 Jan 2020 22:33:36 +0000 (GMT)
From:   Mikhail Zaslonko <zaslonko@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Richard Purdie <rpurdie@rpsys.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] lib/zlib: Add zlib_deflate_dfltcc_enabled() function
Date:   Fri,  3 Jan 2020 23:33:33 +0100
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103223334.20669-1-zaslonko@linux.ibm.com>
References: <20200103223334.20669-1-zaslonko@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20010322-0016-0000-0000-000002DA49EE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010322-0017-0000-0000-0000333CB867
Message-Id: <20200103223334.20669-6-zaslonko@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-03_06:2020-01-02,2020-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001030203
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add a new function to zlib.h checking if s390 Deflate-Conversion facility
is installed and enabled.

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 include/linux/zlib.h            |  6 ++++++
 lib/zlib_deflate/deflate.c      |  6 ++++++
 lib/zlib_deflate/deflate_syms.c |  1 +
 lib/zlib_dfltcc/dfltcc.h        | 11 +++++++++++
 lib/zlib_dfltcc/dfltcc_util.h   |  9 ---------
 5 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/linux/zlib.h b/include/linux/zlib.h
index 92dbbd3f6c75..c757d848a758 100644
--- a/include/linux/zlib.h
+++ b/include/linux/zlib.h
@@ -191,6 +191,12 @@ extern int zlib_deflate_workspacesize (int windowBits, int memLevel);
    exceed those passed here.
 */
 
+extern int zlib_deflate_dfltcc_enabled (void);
+/*
+   Returns 1 if Deflate-Conversion facility is installed and enabled,
+   otherwise 0.
+*/
+
 /* 
 extern int deflateInit (z_streamp strm, int level);
 
diff --git a/lib/zlib_deflate/deflate.c b/lib/zlib_deflate/deflate.c
index 0d60d81a2637..8a878d0d892c 100644
--- a/lib/zlib_deflate/deflate.c
+++ b/lib/zlib_deflate/deflate.c
@@ -59,6 +59,7 @@
 #define DEFLATE_RESET_HOOK(strm) do {} while (0)
 #define DEFLATE_HOOK(strm, flush, bstate) 0
 #define DEFLATE_NEED_CHECKSUM(strm) 1
+#define DEFLATE_DFLTCC_ENABLED() 0
 #endif
 
 /* ===========================================================================
@@ -1138,3 +1139,8 @@ int zlib_deflate_workspacesize(int windowBits, int memLevel)
         + zlib_deflate_head_memsize(memLevel)
         + zlib_deflate_overlay_memsize(memLevel);
 }
+
+int zlib_deflate_dfltcc_enabled(void)
+{
+	return DEFLATE_DFLTCC_ENABLED();
+}
diff --git a/lib/zlib_deflate/deflate_syms.c b/lib/zlib_deflate/deflate_syms.c
index 72fe4b73be53..24b740b99678 100644
--- a/lib/zlib_deflate/deflate_syms.c
+++ b/lib/zlib_deflate/deflate_syms.c
@@ -12,6 +12,7 @@
 #include <linux/zlib.h>
 
 EXPORT_SYMBOL(zlib_deflate_workspacesize);
+EXPORT_SYMBOL(zlib_deflate_dfltcc_enabled);
 EXPORT_SYMBOL(zlib_deflate);
 EXPORT_SYMBOL(zlib_deflateInit2);
 EXPORT_SYMBOL(zlib_deflateEnd);
diff --git a/lib/zlib_dfltcc/dfltcc.h b/lib/zlib_dfltcc/dfltcc.h
index be70c807b62f..2a2fac1d050a 100644
--- a/lib/zlib_dfltcc/dfltcc.h
+++ b/lib/zlib_dfltcc/dfltcc.h
@@ -3,6 +3,8 @@
 #define DFLTCC_H
 
 #include "../zlib_deflate/defutil.h"
+#include <asm/facility.h>
+#include <asm/setup.h>
 
 /*
  * Tuning parameters.
@@ -14,6 +16,8 @@
 #define DFLTCC_DHT_MIN_SAMPLE_SIZE 4096
 #define DFLTCC_RIBM 0
 
+#define DFLTCC_FACILITY 151
+
 /*
  * Parameter Block for Query Available Functions.
  */
@@ -113,6 +117,11 @@ typedef enum {
 } dfltcc_inflate_action;
 dfltcc_inflate_action dfltcc_inflate(z_streamp strm,
                                      int flush, int *ret);
+static inline int is_dfltcc_enabled(void)
+{
+return (zlib_dfltcc_support != ZLIB_DFLTCC_DISABLED &&
+        test_facility(DFLTCC_FACILITY));
+}
 
 #define DEFLATE_RESET_HOOK(strm) \
     dfltcc_reset((strm), sizeof(deflate_state))
@@ -121,6 +130,8 @@ dfltcc_inflate_action dfltcc_inflate(z_streamp strm,
 
 #define DEFLATE_NEED_CHECKSUM(strm) (!dfltcc_can_deflate((strm)))
 
+#define DEFLATE_DFLTCC_ENABLED() is_dfltcc_enabled()
+
 #define INFLATE_RESET_HOOK(strm) \
     dfltcc_reset((strm), sizeof(struct inflate_state))
 
diff --git a/lib/zlib_dfltcc/dfltcc_util.h b/lib/zlib_dfltcc/dfltcc_util.h
index 7c0d3bdc50a9..4a46b5009f0d 100644
--- a/lib/zlib_dfltcc/dfltcc_util.h
+++ b/lib/zlib_dfltcc/dfltcc_util.h
@@ -3,8 +3,6 @@
 #define DFLTCC_UTIL_H
 
 #include <linux/zutil.h>
-#include <asm/facility.h>
-#include <asm/setup.h>
 
 /*
  * C wrapper for the DEFLATE CONVERSION CALL instruction.
@@ -24,7 +22,6 @@ typedef enum {
 #define HBT_CIRCULAR (1 << 7)
 #define HB_BITS 15
 #define HB_SIZE (1 << HB_BITS)
-#define DFLTCC_FACILITY 151
 
 static inline dfltcc_cc dfltcc(
     int fn,
@@ -101,12 +98,6 @@ static inline int dfltcc_are_params_ok(
         (strategy == Z_DEFAULT_STRATEGY);
 }
 
-static inline int is_dfltcc_enabled(void)
-{
-    return (zlib_dfltcc_support != ZLIB_DFLTCC_DISABLED &&
-            test_facility(DFLTCC_FACILITY));
-}
-
 char *oesc_msg(char *buf, int oesc);
 
 #endif /* DFLTCC_UTIL_H */
-- 
2.17.1

