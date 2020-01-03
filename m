Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5728112FED3
	for <lists+linux-s390@lfdr.de>; Fri,  3 Jan 2020 23:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgACWdq (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 Jan 2020 17:33:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728832AbgACWdq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jan 2020 17:33:46 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 003MHIAr141138
        for <linux-s390@vger.kernel.org>; Fri, 3 Jan 2020 17:33:45 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x9j3q5da7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 03 Jan 2020 17:33:44 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <zaslonko@linux.ibm.com>;
        Fri, 3 Jan 2020 22:33:42 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Jan 2020 22:33:38 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 003MXaHv48955558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jan 2020 22:33:36 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1BA95206D;
        Fri,  3 Jan 2020 22:33:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 47A6052069;
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
Subject: [PATCH v3 4/6] s390/boot: Add dfltcc= kernel command line parameter
Date:   Fri,  3 Jan 2020 23:33:32 +0100
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103223334.20669-1-zaslonko@linux.ibm.com>
References: <20200103223334.20669-1-zaslonko@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20010322-0008-0000-0000-000003465157
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010322-0009-0000-0000-00004A668BBF
Message-Id: <20200103223334.20669-5-zaslonko@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-03_06:2020-01-02,2020-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001030203
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add the new kernel command line parameter 'dfltcc=' to configure
s390 zlib hardware support.
Format: { on | off | def_only | inf_only | always }
 on:       s390 zlib hardware support for compression on
           level 1 and decompression (default)
 off:      No s390 zlib hardware support
 def_only: s390 zlib hardware support for deflate
           only (compression on level 1)
 inf_only: s390 zlib hardware support for inflate
           only (decompression)
 always:   Same as 'on' but ignores the selected compression
           level always using hardware support (used for debugging)

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
 arch/s390/boot/ipl_parm.c                       | 14 ++++++++++++++
 arch/s390/include/asm/setup.h                   |  7 +++++++
 arch/s390/kernel/setup.c                        |  2 ++
 lib/zlib_dfltcc/dfltcc.c                        |  5 ++++-
 lib/zlib_dfltcc/dfltcc.h                        |  1 +
 lib/zlib_dfltcc/dfltcc_deflate.c                |  6 ++++++
 lib/zlib_dfltcc/dfltcc_inflate.c                |  6 ++++++
 lib/zlib_dfltcc/dfltcc_util.h                   |  4 +++-
 9 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ade4e6ec23e0..08fcbaa69877 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -834,6 +834,18 @@
 			dump out devices still on the deferred probe list after
 			retrying.
 
+	dfltcc=		[HW,S390]
+			Format: { on | off | def_only | inf_only | always }
+			on:       s390 zlib hardware support for compression on
+			          level 1 and decompression (default)
+			off:      No s390 zlib hardware support
+			def_only: s390 zlib hardware support for deflate
+			          only (compression on level 1)
+			inf_only: s390 zlib hardware support for inflate
+			          only (decompression)
+			always:   Same as 'on' but ignores the selected compression
+			          level always using hardware support (used for debugging)
+
 	dhash_entries=	[KNL]
 			Set number of hash buckets for dentry cache.
 
diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index 24ef67eb1cef..357adad991d2 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -14,6 +14,7 @@
 char __bootdata(early_command_line)[COMMAND_LINE_SIZE];
 struct ipl_parameter_block __bootdata_preserved(ipl_block);
 int __bootdata_preserved(ipl_block_valid);
+unsigned int __bootdata_preserved(zlib_dfltcc_support) = ZLIB_DFLTCC_FULL;
 
 unsigned long __bootdata(vmalloc_size) = VMALLOC_DEFAULT_SIZE;
 unsigned long __bootdata(memory_end);
@@ -229,6 +230,19 @@ void parse_boot_command_line(void)
 		if (!strcmp(param, "vmalloc") && val)
 			vmalloc_size = round_up(memparse(val, NULL), PAGE_SIZE);
 
+		if (!strcmp(param, "dfltcc")) {
+			if (!strcmp(val, "off"))
+				zlib_dfltcc_support = ZLIB_DFLTCC_DISABLED;
+			else if (!strcmp(val, "on"))
+				zlib_dfltcc_support = ZLIB_DFLTCC_FULL;
+			else if (!strcmp(val, "def_only"))
+				zlib_dfltcc_support = ZLIB_DFLTCC_DEFLATE_ONLY;
+			else if (!strcmp(val, "inf_only"))
+				zlib_dfltcc_support = ZLIB_DFLTCC_INFLATE_ONLY;
+			else if (!strcmp(val, "always"))
+				zlib_dfltcc_support = ZLIB_DFLTCC_FULL_DEBUG;
+		}
+
 		if (!strcmp(param, "noexec")) {
 			rc = kstrtobool(val, &enabled);
 			if (!rc && !enabled)
diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
index 69289e99cabd..b241ddb67caf 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
@@ -79,6 +79,13 @@ struct parmarea {
 	char command_line[ARCH_COMMAND_LINE_SIZE];	/* 0x10480 */
 };
 
+extern unsigned int zlib_dfltcc_support;
+#define ZLIB_DFLTCC_DISABLED		0
+#define ZLIB_DFLTCC_FULL		1
+#define ZLIB_DFLTCC_DEFLATE_ONLY	2
+#define ZLIB_DFLTCC_INFLATE_ONLY	3
+#define ZLIB_DFLTCC_FULL_DEBUG		4
+
 extern int noexec_disabled;
 extern int memory_end_set;
 extern unsigned long memory_end;
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 9cbf490fd162..a577d7df379c 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -111,6 +111,8 @@ unsigned long __bootdata_preserved(__etext_dma);
 unsigned long __bootdata_preserved(__sdma);
 unsigned long __bootdata_preserved(__edma);
 unsigned long __bootdata_preserved(__kaslr_offset);
+unsigned int __bootdata_preserved(zlib_dfltcc_support);
+EXPORT_SYMBOL(zlib_dfltcc_support);
 
 unsigned long VMALLOC_START;
 EXPORT_SYMBOL(VMALLOC_START);
diff --git a/lib/zlib_dfltcc/dfltcc.c b/lib/zlib_dfltcc/dfltcc.c
index 7f77e5bb01c6..c30de430b30c 100644
--- a/lib/zlib_dfltcc/dfltcc.c
+++ b/lib/zlib_dfltcc/dfltcc.c
@@ -44,7 +44,10 @@ void dfltcc_reset(
     dfltcc_state->param.nt = 1;
 
     /* Initialize tuning parameters */
-    dfltcc_state->level_mask = DFLTCC_LEVEL_MASK;
+    if (zlib_dfltcc_support == ZLIB_DFLTCC_FULL_DEBUG)
+        dfltcc_state->level_mask = DFLTCC_LEVEL_MASK_DEBUG;
+    else
+        dfltcc_state->level_mask = DFLTCC_LEVEL_MASK;
     dfltcc_state->block_size = DFLTCC_BLOCK_SIZE;
     dfltcc_state->block_threshold = DFLTCC_FIRST_FHT_BLOCK_SIZE;
     dfltcc_state->dht_threshold = DFLTCC_DHT_MIN_SAMPLE_SIZE;
diff --git a/lib/zlib_dfltcc/dfltcc.h b/lib/zlib_dfltcc/dfltcc.h
index 4782c92bb2ff..be70c807b62f 100644
--- a/lib/zlib_dfltcc/dfltcc.h
+++ b/lib/zlib_dfltcc/dfltcc.h
@@ -8,6 +8,7 @@
  * Tuning parameters.
  */
 #define DFLTCC_LEVEL_MASK 0x2 /* DFLTCC compression for level 1 only */
+#define DFLTCC_LEVEL_MASK_DEBUG 0x3fe /* DFLTCC compression for all levels */
 #define DFLTCC_BLOCK_SIZE 1048576
 #define DFLTCC_FIRST_FHT_BLOCK_SIZE 4096
 #define DFLTCC_DHT_MIN_SAMPLE_SIZE 4096
diff --git a/lib/zlib_dfltcc/dfltcc_deflate.c b/lib/zlib_dfltcc/dfltcc_deflate.c
index b9d16917c30a..aa4539f5c071 100644
--- a/lib/zlib_dfltcc/dfltcc_deflate.c
+++ b/lib/zlib_dfltcc/dfltcc_deflate.c
@@ -3,6 +3,7 @@
 #include "../zlib_deflate/defutil.h"
 #include "dfltcc_util.h"
 #include "dfltcc.h"
+#include <asm/setup.h>
 #include <linux/zutil.h>
 
 /*
@@ -15,6 +16,11 @@ int dfltcc_can_deflate(
     deflate_state *state = (deflate_state *)strm->state;
     struct dfltcc_state *dfltcc_state = GET_DFLTCC_STATE(state);
 
+    /* Check for kernel dfltcc command line parameter */
+    if (zlib_dfltcc_support == ZLIB_DFLTCC_DISABLED ||
+            zlib_dfltcc_support == ZLIB_DFLTCC_INFLATE_ONLY)
+        return 0;
+
     /* Unsupported compression settings */
     if (!dfltcc_are_params_ok(state->level, state->w_bits, state->strategy,
                               dfltcc_state->level_mask))
diff --git a/lib/zlib_dfltcc/dfltcc_inflate.c b/lib/zlib_dfltcc/dfltcc_inflate.c
index 12a93a06bd61..aa9ef23474df 100644
--- a/lib/zlib_dfltcc/dfltcc_inflate.c
+++ b/lib/zlib_dfltcc/dfltcc_inflate.c
@@ -3,6 +3,7 @@
 #include "../zlib_inflate/inflate.h"
 #include "dfltcc_util.h"
 #include "dfltcc.h"
+#include <asm/setup.h>
 #include <linux/zutil.h>
 
 /*
@@ -15,6 +16,11 @@ int dfltcc_can_inflate(
     struct inflate_state *state = (struct inflate_state *)strm->state;
     struct dfltcc_state *dfltcc_state = GET_DFLTCC_STATE(state);
 
+    /* Check for kernel dfltcc command line parameter */
+    if (zlib_dfltcc_support == ZLIB_DFLTCC_DISABLED ||
+            zlib_dfltcc_support == ZLIB_DFLTCC_DEFLATE_ONLY)
+        return 0;
+
     /* Unsupported compression settings */
     if (state->wbits != HB_BITS)
         return 0;
diff --git a/lib/zlib_dfltcc/dfltcc_util.h b/lib/zlib_dfltcc/dfltcc_util.h
index 82cd1950c416..7c0d3bdc50a9 100644
--- a/lib/zlib_dfltcc/dfltcc_util.h
+++ b/lib/zlib_dfltcc/dfltcc_util.h
@@ -4,6 +4,7 @@
 
 #include <linux/zutil.h>
 #include <asm/facility.h>
+#include <asm/setup.h>
 
 /*
  * C wrapper for the DEFLATE CONVERSION CALL instruction.
@@ -102,7 +103,8 @@ static inline int dfltcc_are_params_ok(
 
 static inline int is_dfltcc_enabled(void)
 {
-    return test_facility(DFLTCC_FACILITY);
+    return (zlib_dfltcc_support != ZLIB_DFLTCC_DISABLED &&
+            test_facility(DFLTCC_FACILITY));
 }
 
 char *oesc_msg(char *buf, int oesc);
-- 
2.17.1

