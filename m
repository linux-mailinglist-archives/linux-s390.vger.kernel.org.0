Return-Path: <linux-s390+bounces-45-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5727F38C2
	for <lists+linux-s390@lfdr.de>; Tue, 21 Nov 2023 23:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E9A28283C
	for <lists+linux-s390@lfdr.de>; Tue, 21 Nov 2023 22:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C257054678;
	Tue, 21 Nov 2023 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IzMejt7N"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1860510D5;
	Tue, 21 Nov 2023 14:03:08 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALLfDl0025205;
	Tue, 21 Nov 2023 22:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Jw5Y1HvNWq7xyQLWYP0uulKSfMNkdY0+zz8uCuv3y/0=;
 b=IzMejt7NQo7glexgqNP3In+hN9eFEdhQDC/eGPrtUex06xGfRkDlauZFtqd5m2QQZPuh
 eFZhBvRvDVSkk73E3hcYQC9EKOoJnWEPjpMZdtna+ZzYTTsXNstltldsWBmIiSeOE14E
 ieokMr72lmrvqZXAbRfuPZtt29pxv2HDBNJhXmIbhf9Mn8neK8zaV3j3AD6w8JZafrgs
 bFa20kGrTTbej1O3T+vrRbK2h4X4KJrY7wQOBK6JfizyMm4nJRl8M/m6/Tsaxf+tJdYv
 ObxqVvg7BMcbMc16/XzL9447YjM+IoN98VP6T7Cc3MArW+JXB18Ub2LyCxn52NKdRKlZ 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh46a1ac9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 22:02:51 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALLfLdc025865;
	Tue, 21 Nov 2023 22:02:50 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh46a1abu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 22:02:50 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALLna3m011089;
	Tue, 21 Nov 2023 22:02:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf9tkbbku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 22:02:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ALM2kHB9831118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Nov 2023 22:02:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF49A20065;
	Tue, 21 Nov 2023 22:02:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 526B620063;
	Tue, 21 Nov 2023 22:02:45 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.23.98])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Nov 2023 22:02:45 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 23/33] s390/boot: Add the KMSAN runtime stub
Date: Tue, 21 Nov 2023 23:01:17 +0100
Message-ID: <20231121220155.1217090-24-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231121220155.1217090-1-iii@linux.ibm.com>
References: <20231121220155.1217090-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qe4SXelpch00WHhO8n0hLeZh5nQleolM
X-Proofpoint-GUID: 2hpmIJbsI3XPvZcXaNBq09lhpHW9HWVv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_12,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210172

It should be possible to have inline functions in the s390 header
files, which call kmsan_unpoison_memory(). The problem is that these
header files might be included by the decompressor, which does not
contain KMSAN runtime, causing linker errors.

Not compiling these calls if __SANITIZE_MEMORY__ is not defined -
either by changing kmsan-checks.h or at the call sites - may cause
unintended side effects, since calling these functions from an
uninstrumented code that is linked into the kernel is valid use case.

One might want to explicitly distinguish between the kernel and the
decompressor. Checking for a decompressor-specific #define is quite
heavy-handed, and will have to be done at all call sites.

A more generic approach is to provide a dummy kmsan_unpoison_memory()
definition. This produces some runtime overhead, but only when building
with CONFIG_KMSAN. The benefit is that it does not disturb the existing
KMSAN build logic and call sites don't need to be changed.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/boot/Makefile | 1 +
 arch/s390/boot/kmsan.c  | 6 ++++++
 2 files changed, 7 insertions(+)
 create mode 100644 arch/s390/boot/kmsan.c

diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index fb10fcd21221..096216a72e98 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -44,6 +44,7 @@ obj-$(findstring y, $(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) $(CONFIG_PGSTE))	+=
 obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
 obj-y	+= $(if $(CONFIG_KERNEL_UNCOMPRESSED),,decompressor.o) info.o
 obj-$(CONFIG_KERNEL_ZSTD) += clz_ctz.o
+obj-$(CONFIG_KMSAN) += kmsan.o
 obj-all := $(obj-y) piggy.o syms.o
 
 targets	:= bzImage section_cmp.boot.data section_cmp.boot.preserved.data $(obj-y)
diff --git a/arch/s390/boot/kmsan.c b/arch/s390/boot/kmsan.c
new file mode 100644
index 000000000000..e7b3ac48143e
--- /dev/null
+++ b/arch/s390/boot/kmsan.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kmsan-checks.h>
+
+void kmsan_unpoison_memory(const void *address, size_t size)
+{
+}
-- 
2.41.0


