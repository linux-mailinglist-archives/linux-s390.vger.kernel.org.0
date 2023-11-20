Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2CC7F1673
	for <lists+linux-s390@lfdr.de>; Mon, 20 Nov 2023 15:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjKTOzD (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 20 Nov 2023 09:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbjKTOyn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Nov 2023 09:54:43 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8983D1BF8;
        Mon, 20 Nov 2023 06:54:17 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKEiX6X015672;
        Mon, 20 Nov 2023 14:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QWS0HKW11eNRfLJyewWoDWotkqUlokRtyEk9WNo7/gg=;
 b=KrAaZeDtViMEgjPGlNfnAvEQWqZVAJZtz2IxsNzhas29CHwqcZQ6d80VcMR9bP/+7NLa
 dcCXpq0XIDG6C7h2YMN8hijEdlO/kT1otUThVYqOtdvxDXn0mJFbEfscou6hgkhjL/yc
 9lK32UncuBHDwTMOw5cjd9mZ9IpWfsYe77v4Pb+4As0rQex0hlw0+6nI/8Dm3A9Lvlqt
 oPEgg4ysBLdX0ZTUuP04d4x8WDuisTy4uyNFH6cy2WCQoILXEvY5X3wDnqUyNeMWUvZk
 GKueTUa4zWEz7I/9Zp3bchGFo8YaWo21kH3VV8CkXfL8q6DvYtw7o3bbY6ntMm72iVDG rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug9fxg7m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 14:54:07 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AKEk3Ew021705;
        Mon, 20 Nov 2023 14:54:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug9fxg7m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 14:54:06 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKDOAiP008955;
        Mon, 20 Nov 2023 14:54:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yy9yvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 14:54:05 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AKEs26r22151830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 14:54:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7C562004D;
        Mon, 20 Nov 2023 14:54:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72F7D2004B;
        Mon, 20 Nov 2023 14:54:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Nov 2023 14:54:02 +0000 (GMT)
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
To:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] mm/memory_hotplug: add missing mem_hotplug_lock
Date:   Mon, 20 Nov 2023 15:53:52 +0100
Message-Id: <20231120145354.308999-2-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120145354.308999-1-sumanthk@linux.ibm.com>
References: <20231120145354.308999-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6brmeEHDq_grf2h_IfBodNGVI96i4-KE
X-Proofpoint-GUID: jiG6ldOHIlSIZqF0WOlyVQrXUBBWjI4c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_14,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=423 suspectscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From Documentation/core-api/memory-hotplug.rst:
When adding/removing/onlining/offlining memory or adding/removing
heterogeneous/device memory, we should always hold the mem_hotplug_lock
in write mode to serialise memory hotplug (e.g. access to global/zone
variables).

mhp_(de)init_memmap_on_memory() functions can change zone stats and
struct page content, but they are currently called w/o the
mem_hotplug_lock.

When memory block is being offlined and when kmemleak goes through each
populated zone, the following theoretical race conditions could occur:
CPU 0:					     | CPU 1:
memory_offline()			     |
-> offline_pages()			     |
	-> mem_hotplug_begin()		     |
	   ...				     |
	-> mem_hotplug_done()		     |
					     | kmemleak_scan()
					     | -> get_online_mems()
					     |    ...
-> mhp_deinit_memmap_on_memory()	     |
  [not protected by mem_hotplug_begin/done()]|
  Marks memory section as offline,	     |   Retrieves zone_start_pfn
  poisons vmemmap struct pages and updates   |   and struct page members.
  the zone related data			     |
   					     |    ...
   					     | -> put_online_mems()

Fix this by ensuring mem_hotplug_lock is taken before performing
mhp_init_memmap_on_memory(). Also ensure that
mhp_deinit_memmap_on_memory() holds the lock.

online/offline_pages() are currently only called from
memory_block_online/offline(), so it is safe to move the locking there.

Fixes: a08a2ae34613 ("mm,memory_hotplug: allocate memmap from the added memory range")
Cc: stable@vger.kernel.org # 5.15+
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 drivers/base/memory.c | 18 +++++++++++++++---
 mm/memory_hotplug.c   | 13 ++++++-------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index f3b9a4d0fa3b..8a13babd826c 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -180,6 +180,9 @@ static inline unsigned long memblk_nr_poison(struct memory_block *mem)
 }
 #endif
 
+/*
+ * Must acquire mem_hotplug_lock in write mode.
+ */
 static int memory_block_online(struct memory_block *mem)
 {
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
@@ -204,10 +207,11 @@ static int memory_block_online(struct memory_block *mem)
 	if (mem->altmap)
 		nr_vmemmap_pages = mem->altmap->free;
 
+	mem_hotplug_begin();
 	if (nr_vmemmap_pages) {
 		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages, zone);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	ret = online_pages(start_pfn + nr_vmemmap_pages,
@@ -215,7 +219,7 @@ static int memory_block_online(struct memory_block *mem)
 	if (ret) {
 		if (nr_vmemmap_pages)
 			mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
-		return ret;
+		goto out;
 	}
 
 	/*
@@ -227,9 +231,14 @@ static int memory_block_online(struct memory_block *mem)
 					  nr_vmemmap_pages);
 
 	mem->zone = zone;
+out:
+	mem_hotplug_done();
 	return ret;
 }
 
+/*
+ * Must acquire mem_hotplug_lock in write mode.
+ */
 static int memory_block_offline(struct memory_block *mem)
 {
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
@@ -247,6 +256,7 @@ static int memory_block_offline(struct memory_block *mem)
 	if (mem->altmap)
 		nr_vmemmap_pages = mem->altmap->free;
 
+	mem_hotplug_begin();
 	if (nr_vmemmap_pages)
 		adjust_present_page_count(pfn_to_page(start_pfn), mem->group,
 					  -nr_vmemmap_pages);
@@ -258,13 +268,15 @@ static int memory_block_offline(struct memory_block *mem)
 		if (nr_vmemmap_pages)
 			adjust_present_page_count(pfn_to_page(start_pfn),
 						  mem->group, nr_vmemmap_pages);
-		return ret;
+		goto out;
 	}
 
 	if (nr_vmemmap_pages)
 		mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
 
 	mem->zone = NULL;
+out:
+	mem_hotplug_done();
 	return ret;
 }
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1b03f4ec6fd2..c8238fc5edcb 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1129,6 +1129,9 @@ void mhp_deinit_memmap_on_memory(unsigned long pfn, unsigned long nr_pages)
 	kasan_remove_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
 }
 
+/*
+ * Must be called with mem_hotplug_lock in write mode.
+ */
 int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 		       struct zone *zone, struct memory_group *group)
 {
@@ -1149,7 +1152,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 			 !IS_ALIGNED(pfn + nr_pages, PAGES_PER_SECTION)))
 		return -EINVAL;
 
-	mem_hotplug_begin();
 
 	/* associate pfn range with the zone */
 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_ISOLATE);
@@ -1208,7 +1210,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	writeback_set_ratelimit();
 
 	memory_notify(MEM_ONLINE, &arg);
-	mem_hotplug_done();
 	return 0;
 
 failed_addition:
@@ -1217,7 +1218,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 		 (((unsigned long long) pfn + nr_pages) << PAGE_SHIFT) - 1);
 	memory_notify(MEM_CANCEL_ONLINE, &arg);
 	remove_pfn_range_from_zone(zone, pfn, nr_pages);
-	mem_hotplug_done();
 	return ret;
 }
 
@@ -1863,6 +1863,9 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
 	return 0;
 }
 
+/*
+ * Must be called with mem_hotplug_lock in write mode.
+ */
 int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 			struct zone *zone, struct memory_group *group)
 {
@@ -1885,8 +1888,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 			 !IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION)))
 		return -EINVAL;
 
-	mem_hotplug_begin();
-
 	/*
 	 * Don't allow to offline memory blocks that contain holes.
 	 * Consequently, memory blocks with holes can never get onlined
@@ -2027,7 +2028,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 	memory_notify(MEM_OFFLINE, &arg);
 	remove_pfn_range_from_zone(zone, start_pfn, nr_pages);
-	mem_hotplug_done();
 	return 0;
 
 failed_removal_isolated:
@@ -2042,7 +2042,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 		 (unsigned long long) start_pfn << PAGE_SHIFT,
 		 ((unsigned long long) end_pfn << PAGE_SHIFT) - 1,
 		 reason);
-	mem_hotplug_done();
 	return ret;
 }
 
-- 
2.41.0

