Return-Path: <linux-s390+bounces-13805-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6DFBCC3A2
	for <lists+linux-s390@lfdr.de>; Fri, 10 Oct 2025 10:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A6D54E17B6
	for <lists+linux-s390@lfdr.de>; Fri, 10 Oct 2025 08:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D4326CE10;
	Fri, 10 Oct 2025 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tQ2eik3t"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B38626561D;
	Fri, 10 Oct 2025 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760086335; cv=none; b=Jo3uRl+Wn0iCa4pJxc7Ijfgg+k3iOidHbiEAEBWwmESwIsivSZe/4bP5tRygTi9XGB6kOvCMrVyl+8SXwQ1+a8w6iBlYxfPOcEIywLib8tVkz0quwfH/TbV2RApBHL2vuCsC0phUzcr7ogMvoLQzjVNBSDDBRm9mWY8SBva61Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760086335; c=relaxed/simple;
	bh=R81YTkVQnNoin6piiyAzT3ZLiNAMbWBV6X0IhoOkX94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvnFINwbEEwaB0B6AU6LIh0EvePQsLrKOzLqbJTrIi20NcyFFMtlbMq9cqBqAZc1inCqbY5y6Fzwu4hUgqTymPOiesu0WlyWK3FBMfRBxTcc2M5ptNwiEJPwL1AUAShifciiCnc1vKhL5g1X5stgPqpoGsh3GUnqKNTCnq0dBTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tQ2eik3t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599NTexq012322;
	Fri, 10 Oct 2025 08:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Y8z4PXcHP8B5u9iIT
	K0Sb1JPJ9Ukzhrfsj7UNFUahYQ=; b=tQ2eik3tpKCncq3NkFmCKvNhGP5oVo4FZ
	mKyTRT0js2VHBmbqzOi90SAqmk9PoCpAHbbuYN6rG0hTyfPKJSw/oXfnVe4wUF+S
	QvqHZYWJ9UP2AAU0U63yN2DksV6KxyKQPZ9S8cmoUUQln97Hf075IEdKFrgsOZXT
	UH1+4ezLBwS3hYLNoLx1WXLXNXzeyDXhP3nM6qw2JbTbE7K6piEAaTDUtPwnmBzc
	DROgs6RK38SGdSmq/bIj7VVhz9h8F3uXE4oD7t/x37AoL3Ttkx9KLZVSvm7XXGHs
	vJKFRqONYE6uHlnCggMGKKVXwppVL0vS2TMN+vEfQxEwQ608oqEVA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv7yhq4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 08:52:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59A83uKZ021009;
	Fri, 10 Oct 2025 08:52:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nv8ss0f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 08:52:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59A8q1AS56361224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 08:52:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 905352008C;
	Fri, 10 Oct 2025 08:52:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 513E920091;
	Fri, 10 Oct 2025 08:52:01 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Oct 2025 08:52:01 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm <linux-mm@kvack.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH v3 2/4] s390/sclp: Add support for dynamic (de)configuration of memory
Date: Fri, 10 Oct 2025 10:51:45 +0200
Message-ID: <20251010085147.2175918-3-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251010085147.2175918-1-sumanthk@linux.ibm.com>
References: <20251010085147.2175918-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Asv3mS31ELzuEAuOig8qjHDXmdPo9I3q
X-Proofpoint-ORIG-GUID: Asv3mS31ELzuEAuOig8qjHDXmdPo9I3q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX73JB1GOEYknL
 +MD1P5mkimGR/2ye8jQo2PQmAf5Yrc5Hk8QR2ATujKISPxXphkPr1G/+PPfApx+dFogpEGt5yhA
 DWQTJrSnRx/1BVIoLt+0T2bA4TkjE2g8jEWpkQvwZm6n8De+/fXsu4TLWNSdmNkkIu04SfepYg+
 Ydcv8Krjek3ZwArbGal567ZZm2wqpFtT8KTkdInG0QM69EiLSe+57r1Ppf4HdzTn77YTrjU9TQl
 W0eqQxhQ36WHLKAmwUh09xuh6EvaHPMXgAq5SVOZQo8zgv1Vbl6R2BK8s6oD8I9ZhtRRCmBwB3/
 o2OGaCgY1FMenyJMyaJ8eGAZvKsSPBu8uRm3Vt9jTQgDuswHligyUqee/T/PDlrPzvgCHoV4qbE
 qolTKO7TLEekYAoRVZWJSuvOtiroqQ==
X-Authority-Analysis: v=2.4 cv=FtwIPmrq c=1 sm=1 tr=0 ts=68e8c936 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=GHt7ZKPcJgLmr8k-lvIA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

Provide a new interface for dynamic configuration and deconfiguration of
hotplug memory, allowing with/without memmap_on_memory support. It is a
follow up on the discussion with David when introducing memmap_on_memory
support for s390 and support dynamic (de)configuration of memory:
https://lore.kernel.org/all/ee492da8-74b4-4a97-8b24-73e07257f01d@redhat.com/
https://lore.kernel.org/all/20241202082732.3959803-1-sumanthk@linux.ibm.com/

The original motivation for introducing memmap_on_memory on s390 was to
avoid using online memory to store struct pages metadata, particularly
for standby memory blocks. This became critical in cases where there was
an imbalance between standby and online memory, potentially leading to
boot failures due to insufficient memory for metadata allocation.

To address this, memmap_on_memory was utilized on s390. However, in its
current form, it adds struct pages metadata at the start of each memory
block at the time of addition and this configuration is static. It
cannot be changed at runtime. (When the user needs continuous physical
memory).

Inorder to provide more flexibility to the user and overcome the above
limitation, add option to dynamically configure and deconfigure
hotpluggable memory block with/without memmap_on_memory.

With the new interface, s390 will not add all possible hotplug memory in
advance, like before, to make it visible in sysfs for online/offline
actions. Instead, before memory block can be set online, it has to be
configured via a new interface in /sys/firmware/memory/memoryX/config,
which makes s390 similar to others.  i.e. Adding of hotpluggable memory is
controlled by the user instead of adding it at boottime.

The s390 kernel sysfs interface to configure and deconfigure memory is
as follows (considering the upcoming lsmem changes):

* Initial memory layout:
lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                 SIZE   STATE BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x7fffffff   2G  online 0-15  yes        no
0x80000000-0xffffffff   2G offline 16-31 no         yes

* Configure memory
sys="/sys"
echo 1 > $sys/firmware/memory/memory16/config
lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                  SIZE  STATE   BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x7fffffff    2G  online  0-15  yes        no
0x80000000-0x87ffffff  128M offline    16  yes        yes
0x88000000-0xffffffff  1.9G offline 17-31  no         yes

* Deconfigure memory
echo 0 > $sys/firmware/memory/memory16/config
lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                 SIZE   STATE BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x7fffffff   2G  online 0-15  yes        no
0x80000000-0xffffffff   2G offline 16-31 no         yes

3. Enable memmap_on_memory and online it.
echo 0 > $sys/devices/system/memory/memory5/online
echo 0 > $sys/firmware/memory/memory5/config

lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                  SIZE  STATE  BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x27ffffff  640M  online 0-4   yes        no
0x28000000-0x2fffffff  128M offline 5     no         no
0x30000000-0x7fffffff  1.3G  online 6-15  yes        no
0x80000000-0xffffffff    2G offline 16-31 no         yes

echo 1 > $sys/firmware/memory/memory5/memmap_on_memory
echo 1 > $sys/firmware/memory/memory5/config
echo 1 > $sys/devices/system/memory/memory5/online

lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                  SIZE  STATE   BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x27ffffff  640M  online  0-4   yes        no
0x28000000-0x2fffffff  128M  online  5     yes        yes
0x30000000-0x7fffffff  1.3G  online  6-15  yes        no
0x80000000-0xffffffff    2G  offline 16-31 no         yes

4. Disable memmap_on_memory and online it.
echo 0 > $sys/devices/system/memory/memory5/online
echo 0 > $sys/firmware/memory/memory5/config

lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                  SIZE  STATE  BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x27ffffff  640M  online 0-4   yes        no
0x28000000-0x2fffffff  128M offline 5     no         yes
0x30000000-0x7fffffff  1.3G  online 6-15  yes        no
0x80000000-0xffffffff    2G offline 16-31 no         yes

echo 0 > $sys/firmware/memory/memory5/memmap_on_memory
echo 1 > $sys/firmware/memory/memory5/config
echo 1 > $sys/devices/system/memory/memory5/online

lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                  SIZE  STATE   BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x7fffffff  2G    online  0-15  yes        no
0x80000000-0xffffffff  2G    offline 16-31 no         yes

Acked-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 drivers/s390/char/sclp_mem.c | 288 +++++++++++++++++++++++++----------
 1 file changed, 205 insertions(+), 83 deletions(-)

diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
index 27f49f5fd358..e44b3b01dae6 100644
--- a/drivers/s390/char/sclp_mem.c
+++ b/drivers/s390/char/sclp_mem.c
@@ -9,9 +9,12 @@
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/cpufeature.h>
+#include <linux/container_of.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/kstrtox.h>
 #include <linux/memory.h>
 #include <linux/memory_hotplug.h>
 #include <linux/mm.h>
@@ -27,7 +30,6 @@
 #define SCLP_CMDW_ASSIGN_STORAGE		0x000d0001
 #define SCLP_CMDW_UNASSIGN_STORAGE		0x000c0001
 
-static DEFINE_MUTEX(sclp_mem_mutex);
 static LIST_HEAD(sclp_mem_list);
 static u8 sclp_max_storage_id;
 static DECLARE_BITMAP(sclp_storage_ids, 256);
@@ -38,6 +40,18 @@ struct memory_increment {
 	int standby;
 };
 
+struct sclp_mem {
+	struct kobject kobj;
+	unsigned int id;
+	unsigned int memmap_on_memory;
+	unsigned int config;
+};
+
+struct sclp_mem_arg {
+	struct sclp_mem *sclp_mems;
+	struct kset *kset;
+};
+
 struct assign_storage_sccb {
 	struct sccb_header header;
 	u16 rn;
@@ -163,92 +177,165 @@ static int sclp_mem_change_state(unsigned long start, unsigned long size,
 	return rc ? -EIO : 0;
 }
 
-static bool contains_standby_increment(unsigned long start, unsigned long end)
+static ssize_t config_sclp_mem_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
-	struct memory_increment *incr;
-	unsigned long istart;
+	struct sclp_mem *sclp_mem = container_of(kobj, struct sclp_mem, kobj);
 
-	list_for_each_entry(incr, &sclp_mem_list, list) {
-		istart = rn2addr(incr->rn);
-		if (end - 1 < istart)
-			continue;
-		if (start > istart + sclp.rzm - 1)
-			continue;
-		if (incr->standby)
-			return true;
-	}
-	return false;
+	return sysfs_emit(buf, "%u\n", READ_ONCE(sclp_mem->config));
 }
 
-static int sclp_mem_notifier(struct notifier_block *nb,
-			     unsigned long action, void *data)
+static ssize_t config_sclp_mem_store(struct kobject *kobj, struct kobj_attribute *attr,
+				     const char *buf, size_t count)
 {
-	unsigned long start, size;
-	struct memory_notify *arg;
+	unsigned long addr, block_size;
+	struct sclp_mem *sclp_mem;
+	struct memory_block *mem;
 	unsigned char id;
-	int rc = 0;
+	bool value;
+	int rc;
 
-	arg = data;
-	start = arg->start_pfn << PAGE_SHIFT;
-	size = arg->nr_pages << PAGE_SHIFT;
-	mutex_lock(&sclp_mem_mutex);
+	rc = kstrtobool(buf, &value);
+	if (rc)
+		return rc;
+	sclp_mem = container_of(kobj, struct sclp_mem, kobj);
+	block_size = memory_block_size_bytes();
+	addr = sclp_mem->id * block_size;
+	/*
+	 * Hold device_hotplug_lock when adding/removing memory blocks.
+	 * Additionally, also protect calls to find_memory_block() and
+	 * sclp_attach_storage().
+	 */
+	rc = lock_device_hotplug_sysfs();
+	if (rc)
+		goto out;
 	for_each_clear_bit(id, sclp_storage_ids, sclp_max_storage_id + 1)
 		sclp_attach_storage(id);
-	switch (action) {
-	case MEM_GOING_OFFLINE:
-		/*
-		 * Do not allow to set memory blocks offline that contain
-		 * standby memory. This is done to simplify the "memory online"
-		 * case.
-		 */
-		if (contains_standby_increment(start, start + size))
-			rc = -EPERM;
-		break;
-	case MEM_PREPARE_ONLINE:
+	if (value) {
+		if (sclp_mem->config)
+			goto out_unlock;
+		rc = sclp_mem_change_state(addr, block_size, 1);
+		if (rc)
+			goto out_unlock;
 		/*
-		 * Access the altmap_start_pfn and altmap_nr_pages fields
-		 * within the struct memory_notify specifically when dealing
-		 * with only MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers.
-		 *
-		 * When altmap is in use, take the specified memory range
-		 * online, which includes the altmap.
+		 * Set entire memory block CMMA state to nodat. Later, when
+		 * page tables pages are allocated via __add_memory(), those
+		 * regions are marked __arch_set_page_dat().
 		 */
-		if (arg->altmap_nr_pages) {
-			start = PFN_PHYS(arg->altmap_start_pfn);
-			size += PFN_PHYS(arg->altmap_nr_pages);
+		__arch_set_page_nodat((void *)__va(addr), block_size >> PAGE_SHIFT);
+		rc = __add_memory(0, addr, block_size,
+				  sclp_mem->memmap_on_memory ?
+				  MHP_MEMMAP_ON_MEMORY | MHP_OFFLINE_INACCESSIBLE : MHP_NONE);
+		if (rc) {
+			sclp_mem_change_state(addr, block_size, 0);
+			goto out_unlock;
 		}
-		rc = sclp_mem_change_state(start, size, 1);
-		if (rc || !arg->altmap_nr_pages)
-			break;
-		/*
-		 * Set CMMA state to nodat here, since the struct page memory
-		 * at the beginning of the memory block will not go through the
-		 * buddy allocator later.
-		 */
-		__arch_set_page_nodat((void *)__va(start), arg->altmap_nr_pages);
-		break;
-	case MEM_FINISH_OFFLINE:
-		/*
-		 * When altmap is in use, take the specified memory range
-		 * offline, which includes the altmap.
-		 */
-		if (arg->altmap_nr_pages) {
-			start = PFN_PHYS(arg->altmap_start_pfn);
-			size += PFN_PHYS(arg->altmap_nr_pages);
+		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
+		put_device(&mem->dev);
+		WRITE_ONCE(sclp_mem->config, 1);
+	} else {
+		if (!sclp_mem->config)
+			goto out_unlock;
+		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
+		if (mem->state != MEM_OFFLINE) {
+			put_device(&mem->dev);
+			rc = -EBUSY;
+			goto out_unlock;
 		}
-		sclp_mem_change_state(start, size, 0);
-		break;
-	default:
-		break;
+		/* drop the ref just got via find_memory_block() */
+		put_device(&mem->dev);
+		sclp_mem_change_state(addr, block_size, 0);
+		__remove_memory(addr, block_size);
+		WRITE_ONCE(sclp_mem->config, 0);
+	}
+out_unlock:
+	unlock_device_hotplug();
+out:
+	return rc ? rc : count;
+}
+
+static ssize_t memmap_on_memory_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	struct sclp_mem *sclp_mem = container_of(kobj, struct sclp_mem, kobj);
+
+	return sysfs_emit(buf, "%u\n", READ_ONCE(sclp_mem->memmap_on_memory));
+}
+
+static ssize_t memmap_on_memory_store(struct kobject *kobj, struct kobj_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct sclp_mem *sclp_mem;
+	unsigned long block_size;
+	struct memory_block *mem;
+	bool value;
+	int rc;
+
+	rc = kstrtobool(buf, &value);
+	if (rc)
+		return rc;
+	rc = lock_device_hotplug_sysfs();
+	if (rc)
+		return rc;
+	block_size = memory_block_size_bytes();
+	sclp_mem = container_of(kobj, struct sclp_mem, kobj);
+	mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(sclp_mem->id * block_size)));
+	if (!mem) {
+		WRITE_ONCE(sclp_mem->memmap_on_memory, value);
+	} else {
+		put_device(&mem->dev);
+		rc = -EBUSY;
 	}
-	mutex_unlock(&sclp_mem_mutex);
-	return rc ? NOTIFY_BAD : NOTIFY_OK;
+	unlock_device_hotplug();
+	return rc ? rc : count;
 }
 
-static struct notifier_block sclp_mem_nb = {
-	.notifier_call = sclp_mem_notifier,
+static const struct kobj_type ktype = {
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+static struct kobj_attribute memmap_attr =
+	__ATTR(memmap_on_memory, 0644, memmap_on_memory_show, memmap_on_memory_store);
+static struct kobj_attribute config_attr =
+	__ATTR(config, 0644, config_sclp_mem_show, config_sclp_mem_store);
+
+static struct attribute *sclp_mem_attrs[] = {
+	&memmap_attr.attr,
+	&config_attr.attr,
+	NULL,
+};
+
+static struct attribute_group sclp_mem_attr_group = {
+	.attrs = sclp_mem_attrs,
 };
 
+static int create_sclp_mem(struct sclp_mem *sclp_mem, struct kset *kset,
+			   unsigned int id, bool config, bool memmap_on_memory)
+{
+	int rc;
+
+	sclp_mem->memmap_on_memory = memmap_on_memory;
+	sclp_mem->config = config;
+	sclp_mem->id = id;
+	kobject_init(&sclp_mem->kobj, &ktype);
+	rc = kobject_add(&sclp_mem->kobj, &kset->kobj, "memory%d", id);
+	if (rc)
+		return rc;
+	return sysfs_create_group(&sclp_mem->kobj, &sclp_mem_attr_group);
+}
+
+static int create_configured_sclp_mem(struct memory_block *mem, void *argument)
+{
+	struct sclp_mem *sclp_mems;
+	struct sclp_mem_arg *arg;
+	struct kset *kset;
+	unsigned int id;
+
+	id = mem->dev.id;
+	arg = (struct sclp_mem_arg *)argument;
+	sclp_mems = arg->sclp_mems;
+	kset = arg->kset;
+	return create_sclp_mem(&sclp_mems[id], kset, id, true, false);
+}
+
 static void __init align_to_block_size(unsigned long *start,
 				       unsigned long *size,
 				       unsigned long alignment)
@@ -264,14 +351,17 @@ static void __init align_to_block_size(unsigned long *start,
 	*size = size_align;
 }
 
-static void __init add_memory_merged(u16 rn)
+static int __init create_standby_sclp_mems_merged(struct sclp_mem *sclp_mems,
+						  struct kset *kset, u16 rn)
 {
 	unsigned long start, size, addr, block_size;
 	static u16 first_rn, num;
+	unsigned int id;
+	int rc = 0;
 
 	if (rn && first_rn && (first_rn + num == rn)) {
 		num++;
-		return;
+		return rc;
 	}
 	if (!first_rn)
 		goto skip_add;
@@ -286,24 +376,59 @@ static void __init add_memory_merged(u16 rn)
 	if (!size)
 		goto skip_add;
 	for (addr = start; addr < start + size; addr += block_size) {
-		add_memory(0, addr, block_size,
-			   cpu_has_edat1() ?
-			   MHP_MEMMAP_ON_MEMORY | MHP_OFFLINE_INACCESSIBLE : MHP_NONE);
+		id = addr / block_size;
+		rc = create_sclp_mem(&sclp_mems[id], kset, id, false,
+				     mhp_supports_memmap_on_memory());
+		if (rc)
+			break;
 	}
 skip_add:
 	first_rn = rn;
 	num = 1;
+	return rc;
 }
 
-static void __init sclp_add_standby_memory(void)
+static int __init create_standby_sclp_mems(struct sclp_mem *sclp_mems, struct kset *kset)
 {
 	struct memory_increment *incr;
+	int rc = 0;
 
 	list_for_each_entry(incr, &sclp_mem_list, list) {
 		if (incr->standby)
-			add_memory_merged(incr->rn);
+			rc = create_standby_sclp_mems_merged(sclp_mems, kset, incr->rn);
+		if (rc)
+			return rc;
 	}
-	add_memory_merged(0);
+	return create_standby_sclp_mems_merged(sclp_mems, kset, 0);
+}
+
+static int __init init_sclp_mem(void)
+{
+	const unsigned long block_size = memory_block_size_bytes();
+	const unsigned int max_sclp_mems = roundup(sclp.rnmax * sclp.rzm, block_size) / block_size;
+	struct sclp_mem *sclp_mems;
+	struct sclp_mem_arg arg;
+	struct kset *kset;
+	int rc;
+
+	/* Allocate memory for all blocks ahead of time. */
+	sclp_mems = kcalloc(max_sclp_mems, sizeof(struct sclp_mem), GFP_KERNEL);
+	if (!sclp_mems)
+		return -ENOMEM;
+
+	kset = kset_create_and_add("memory", NULL, firmware_kobj);
+	if (!kset)
+		return -ENOMEM;
+
+	/* Initial memory is in the "configured" state already. */
+	arg.sclp_mems = sclp_mems;
+	arg.kset = kset;
+	rc = for_each_memory_block(&arg, create_configured_sclp_mem);
+	if (rc)
+		return rc;
+
+	/* Standby memory is "deconfigured". */
+	return create_standby_sclp_mems(sclp_mems, kset);
 }
 
 static void __init insert_increment(u16 rn, int standby, int assigned)
@@ -336,7 +461,7 @@ static void __init insert_increment(u16 rn, int standby, int assigned)
 	list_add(&new_incr->list, prev);
 }
 
-static int __init sclp_detect_standby_memory(void)
+static int __init sclp_setup_memory(void)
 {
 	struct read_storage_sccb *sccb;
 	int i, id, assigned, rc;
@@ -388,12 +513,9 @@ static int __init sclp_detect_standby_memory(void)
 		goto out;
 	for (i = 1; i <= sclp.rnmax - assigned; i++)
 		insert_increment(0, 1, 0);
-	rc = register_memory_notifier(&sclp_mem_nb);
-	if (rc)
-		goto out;
-	sclp_add_standby_memory();
+	rc = init_sclp_mem();
 out:
 	free_page((unsigned long)sccb);
 	return rc;
 }
-__initcall(sclp_detect_standby_memory);
+__initcall(sclp_setup_memory);
-- 
2.48.1


