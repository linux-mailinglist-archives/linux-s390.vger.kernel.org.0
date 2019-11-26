Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75DD310A089
	for <lists+linux-s390@lfdr.de>; Tue, 26 Nov 2019 15:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfKZOlk (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 26 Nov 2019 09:41:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728039AbfKZOlk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 Nov 2019 09:41:40 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAQEXpRA026419
        for <linux-s390@vger.kernel.org>; Tue, 26 Nov 2019 09:41:39 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wh49u500p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 26 Nov 2019 09:41:38 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <zaslonko@linux.ibm.com>;
        Tue, 26 Nov 2019 14:41:36 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Nov 2019 14:41:33 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAQEfVdw43319496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 14:41:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8853652051;
        Tue, 26 Nov 2019 14:41:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 366525204F;
        Tue, 26 Nov 2019 14:41:31 +0000 (GMT)
From:   Mikhail Zaslonko <zaslonko@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Richard Purdie <rpurdie@rpsys.net>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] s390/boot: Rename HEAP_SIZE due to name collision
Date:   Tue, 26 Nov 2019 15:41:27 +0100
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191126144130.75710-1-zaslonko@linux.ibm.com>
References: <20191126144130.75710-1-zaslonko@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19112614-0012-0000-0000-0000036C8330
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112614-0013-0000-0000-000021A82885
Message-Id: <20191126144130.75710-3-zaslonko@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-26_03:2019-11-26,2019-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=2
 adultscore=0 clxscore=1011 impostorscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=864 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911260129
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Change the conflicting macro name in preparation for zlib_inflate
hardware support.

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 arch/s390/boot/compressed/decompressor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/boot/compressed/decompressor.c b/arch/s390/boot/compressed/decompressor.c
index 45046630c56a..368fd372c875 100644
--- a/arch/s390/boot/compressed/decompressor.c
+++ b/arch/s390/boot/compressed/decompressor.c
@@ -30,13 +30,13 @@ extern unsigned char _compressed_start[];
 extern unsigned char _compressed_end[];
 
 #ifdef CONFIG_HAVE_KERNEL_BZIP2
-#define HEAP_SIZE	0x400000
+#define BOOT_HEAP_SIZE	0x400000
 #else
-#define HEAP_SIZE	0x10000
+#define BOOT_HEAP_SIZE	0x10000
 #endif
 
 static unsigned long free_mem_ptr = (unsigned long) _end;
-static unsigned long free_mem_end_ptr = (unsigned long) _end + HEAP_SIZE;
+static unsigned long free_mem_end_ptr = (unsigned long) _end + BOOT_HEAP_SIZE;
 
 #ifdef CONFIG_KERNEL_GZIP
 #include "../../../../lib/decompress_inflate.c"
@@ -62,7 +62,7 @@ static unsigned long free_mem_end_ptr = (unsigned long) _end + HEAP_SIZE;
 #include "../../../../lib/decompress_unxz.c"
 #endif
 
-#define decompress_offset ALIGN((unsigned long)_end + HEAP_SIZE, PAGE_SIZE)
+#define decompress_offset ALIGN((unsigned long)_end + BOOT_HEAP_SIZE, PAGE_SIZE)
 
 unsigned long mem_safe_offset(void)
 {
-- 
2.17.1

