Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5A8E7712
	for <lists+linux-s390@lfdr.de>; Mon, 28 Oct 2019 17:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfJ1Q4F (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 28 Oct 2019 12:56:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403920AbfJ1Q4F (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 28 Oct 2019 12:56:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9SGqkta008680
        for <linux-s390@vger.kernel.org>; Mon, 28 Oct 2019 12:56:03 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vx2xmb9c9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 28 Oct 2019 12:56:03 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <iii@linux.ibm.com>;
        Mon, 28 Oct 2019 16:56:02 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 28 Oct 2019 16:56:00 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9SGtwJa38273158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 16:55:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C82AAE045;
        Mon, 28 Oct 2019 16:55:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BEADAE04D;
        Mon, 28 Oct 2019 16:55:58 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.97.44])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Oct 2019 16:55:58 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] mm/sparse.c: mark populate_section_memmap as __meminit
Date:   Mon, 28 Oct 2019 17:55:49 +0100
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102816-0008-0000-0000-000003287607
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102816-0009-0000-0000-00004A47B510
Message-Id: <20191028165549.14478-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910280163
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Building the kernel on s390 with -Og produces the following warning:

WARNING: vmlinux.o(.text+0x28dabe): Section mismatch in reference from the function populate_section_memmap() to the function .meminit.text:__populate_section_memmap()
The function populate_section_memmap() references
the function __meminit __populate_section_memmap().
This is often because populate_section_memmap lacks a __meminit
annotation or the annotation of __populate_section_memmap is wrong.

While -Og is not supported, in theory this might still happen with
another compiler or on another architecture. So fix this by using the
correct section annotations.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/sparse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index f6891c1992b1..0f1f36443a96 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -448,7 +448,7 @@ static unsigned long __init section_map_size(void)
 	return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
 }
 
-struct page __init *__populate_section_memmap(unsigned long pfn,
+struct page __meminit *__populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
 	unsigned long size = section_map_size();
@@ -647,7 +647,7 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 #endif
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-static struct page *populate_section_memmap(unsigned long pfn,
+static struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
 	return __populate_section_memmap(pfn, nr_pages, nid, altmap);
@@ -669,7 +669,7 @@ static void free_map_bootmem(struct page *memmap)
 	vmemmap_free(start, end, NULL);
 }
 #else
-struct page *populate_section_memmap(unsigned long pfn,
+struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
 {
 	struct page *page, *ret;
-- 
2.23.0

