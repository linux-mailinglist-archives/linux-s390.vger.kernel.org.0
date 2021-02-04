Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C126230A085
	for <lists+linux-s390@lfdr.de>; Mon,  1 Feb 2021 04:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhBADZu (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 31 Jan 2021 22:25:50 -0500
Received: from foss.arm.com ([217.140.110.172]:46294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231347AbhBADZt (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 31 Jan 2021 22:25:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 820E4142F;
        Sun, 31 Jan 2021 19:25:03 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.93.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3A6DD3F66E;
        Sun, 31 Jan 2021 19:24:56 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com,
        catalin.marinas@arm.com, david@redhat.com, osalvador@suse.de
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        teawater <teawaterz@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH V5 4/4] virtio-mem: check against mhp_get_pluggable_range() which memory we can hotplug
Date:   Mon,  1 Feb 2021 08:55:02 +0530
Message-Id: <1612149902-7867-5-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612149902-7867-1-git-send-email-anshuman.khandual@arm.com>
References: <1612149902-7867-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

Right now, we only check against MAX_PHYSMEM_BITS - but turns out there
are more restrictions of which memory we can actually hotplug, especially
om arm64 or s390x once we support them: we might receive something like
-E2BIG or -ERANGE from add_memory_driver_managed(), stopping device
operation.

So, check right when initializing the device which memory we can add,
warning the user. Try only adding actually pluggable ranges: in the worst
case, no memory provided by our device is pluggable.

In the usual case, we expect all device memory to be pluggable, and in
corner cases only some memory at the end of the device-managed memory
region to not be pluggable.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: catalin.marinas@arm.com
Cc: teawater <teawaterz@linux.alibaba.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: hca@linux.ibm.com
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/virtio/virtio_mem.c | 41 ++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 9fc9ec4a25f5..c3cd4ad62e5b 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2222,7 +2222,7 @@ static int virtio_mem_unplug_pending_mb(struct virtio_mem *vm)
  */
 static void virtio_mem_refresh_config(struct virtio_mem *vm)
 {
-	const uint64_t phys_limit = 1UL << MAX_PHYSMEM_BITS;
+	const struct range pluggable_range = mhp_get_pluggable_range(true);
 	uint64_t new_plugged_size, usable_region_size, end_addr;
 
 	/* the plugged_size is just a reflection of what _we_ did previously */
@@ -2234,15 +2234,25 @@ static void virtio_mem_refresh_config(struct virtio_mem *vm)
 	/* calculate the last usable memory block id */
 	virtio_cread_le(vm->vdev, struct virtio_mem_config,
 			usable_region_size, &usable_region_size);
-	end_addr = vm->addr + usable_region_size;
-	end_addr = min(end_addr, phys_limit);
+	end_addr = min(vm->addr + usable_region_size - 1,
+		       pluggable_range.end);
 
-	if (vm->in_sbm)
-		vm->sbm.last_usable_mb_id =
-					 virtio_mem_phys_to_mb_id(end_addr) - 1;
-	else
-		vm->bbm.last_usable_bb_id =
-				     virtio_mem_phys_to_bb_id(vm, end_addr) - 1;
+	if (vm->in_sbm) {
+		vm->sbm.last_usable_mb_id = virtio_mem_phys_to_mb_id(end_addr);
+		if (!IS_ALIGNED(end_addr + 1, memory_block_size_bytes()))
+			vm->sbm.last_usable_mb_id--;
+	} else {
+		vm->bbm.last_usable_bb_id = virtio_mem_phys_to_bb_id(vm,
+								     end_addr);
+		if (!IS_ALIGNED(end_addr + 1, vm->bbm.bb_size))
+			vm->bbm.last_usable_bb_id--;
+	}
+	/*
+	 * If we cannot plug any of our device memory (e.g., nothing in the
+	 * usable region is addressable), the last usable memory block id will
+	 * be smaller than the first usable memory block id. We'll stop
+	 * attempting to add memory with -ENOSPC from our main loop.
+	 */
 
 	/* see if there is a request to change the size */
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, requested_size,
@@ -2364,7 +2374,7 @@ static int virtio_mem_init_vq(struct virtio_mem *vm)
 
 static int virtio_mem_init(struct virtio_mem *vm)
 {
-	const uint64_t phys_limit = 1UL << MAX_PHYSMEM_BITS;
+	const struct range pluggable_range = mhp_get_pluggable_range(true);
 	uint64_t sb_size, addr;
 	uint16_t node_id;
 
@@ -2405,9 +2415,10 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	if (!IS_ALIGNED(vm->addr + vm->region_size, memory_block_size_bytes()))
 		dev_warn(&vm->vdev->dev,
 			 "The alignment of the physical end address can make some memory unusable.\n");
-	if (vm->addr + vm->region_size > phys_limit)
+	if (vm->addr < pluggable_range.start ||
+	    vm->addr + vm->region_size - 1 > pluggable_range.end)
 		dev_warn(&vm->vdev->dev,
-			 "Some memory is not addressable. This can make some memory unusable.\n");
+			 "Some device memory is not addressable/pluggable. This can make some memory unusable.\n");
 
 	/*
 	 * We want subblocks to span at least MAX_ORDER_NR_PAGES and
@@ -2429,7 +2440,8 @@ static int virtio_mem_init(struct virtio_mem *vm)
 				     vm->sbm.sb_size;
 
 		/* Round up to the next full memory block */
-		addr = vm->addr + memory_block_size_bytes() - 1;
+		addr = max_t(uint64_t, vm->addr, pluggable_range.start) +
+		       memory_block_size_bytes() - 1;
 		vm->sbm.first_mb_id = virtio_mem_phys_to_mb_id(addr);
 		vm->sbm.next_mb_id = vm->sbm.first_mb_id;
 	} else {
@@ -2450,7 +2462,8 @@ static int virtio_mem_init(struct virtio_mem *vm)
 		}
 
 		/* Round up to the next aligned big block */
-		addr = vm->addr + vm->bbm.bb_size - 1;
+		addr = max_t(uint64_t, vm->addr, pluggable_range.start) +
+		       vm->bbm.bb_size - 1;
 		vm->bbm.first_bb_id = virtio_mem_phys_to_bb_id(vm, addr);
 		vm->bbm.next_bb_id = vm->bbm.first_bb_id;
 	}
-- 
2.20.1

