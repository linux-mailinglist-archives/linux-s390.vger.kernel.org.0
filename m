Return-Path: <linux-s390+bounces-8690-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55962A22399
	for <lists+linux-s390@lfdr.de>; Wed, 29 Jan 2025 19:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CF018879B9
	for <lists+linux-s390@lfdr.de>; Wed, 29 Jan 2025 18:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01971E230E;
	Wed, 29 Jan 2025 18:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iDd1ZUl/"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1287F1E1C1F
	for <linux-s390@vger.kernel.org>; Wed, 29 Jan 2025 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174017; cv=none; b=TQV5nPxdBEpDYgO1JNRRLGQhw4vny+3Lw4z42eoxjjGUxJn+CGZHuhD1Gt/pG5iSfgsNz0VRc37qjcPQ1Zva3ZQVl1H8ITWmIBjJfdi/Q6VQpVSGXOGuBqY4dckwx2ikkS7wrcVLStGhWD1G+L9lacSWvZSlZYoxhELwH+/TmBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174017; c=relaxed/simple;
	bh=BgOAw92WGFUTDNKl8lvTa2dY/8YKXhs9pWo8dFqmsj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QW1nRt1o+ueQwckdGVT3gbvpu8W20ETPWhNQ+2mXzDSH+QWuJEv/AtythTbsezUxh1j5xWDwVxGKwFpjQn9BJcnq3lGFhnBMvSuvNa1qBfzpFKXWmRSg6ObZvJ7raMmOzS5fdN0o5JLzbSdMYQKDsJbRAcSWMpZGzhQ9oPpv8y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iDd1ZUl/; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738174013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCr+FQFEG2oCVV8WcBrd5Fpq/NTKdM1KceSOvH3NLXo=;
	b=iDd1ZUl/T7D8oyxkXec43b40Wb21Bw1EFwQ5tDmkiM8IIEmaDp9PaUQhj6LGbXqIJsRNR6
	78yKVxFUGhSvqrs4RtNvsRLboEBfHoE7qhABdaMXHohRFJKyieuIOGJBrbTcgYwWuUp4xk
	SwhnxH5aNVfaez0gBk9bFpGrZWtlREM=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>,
	Seth Jennings <sjenning@redhat.com>,
	Dan Streetman <ddstreet@ieee.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 2/2] mm: zbud: remove zbud
Date: Wed, 29 Jan 2025 18:06:32 +0000
Message-ID: <20250129180633.3501650-3-yosry.ahmed@linux.dev>
In-Reply-To: <20250129180633.3501650-1-yosry.ahmed@linux.dev>
References: <20250129180633.3501650-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The zbud compressed pages allocator is rarely used, most users use
zsmalloc. zbud consumes much more memory (only stores 1 or 2 compressed
pages per physical page). The only advantage of zbud is a marginal
performance improvement that by no means justify the memory overhead.

Historically, zsmalloc had significantly worse latency than zbud and
z3fold but offered better memory savings.  This is no longer the case as
shown by a simple recent analysis [1].  In a kernel build test on tmpfs
in a limited cgroup, zbud 2-3% less time than zsmalloc, but at the cost
of using ~32% more memory (1.5G vs 1.13G). The tradeoff does not make
sense for zbud in any practical scenario.

The only alleged advantage of zbud is not having the dependency on
CONFIG_MMU, but CONFIG_SWAP already depends on CONFIG_MMU anyway, and
zbud is only used by zswap.

Remove zbud after z3fold's removal, leaving zsmalloc as the one and only
zpool allocator. Leave the removal of the zpool API (and its associated
config options) to a followup cleanup after no more allocators show up.

Deprecating zbud for a few cycles before removing it was initially
proposed [2], like z3fold was marked as deprecated for 2 cycles [3].
However, Johannes rightfully pointed out that the 2 cycles is too short
for most downstream consumers, and z3fold was deprecated first only as a
courtesy anyway.

[1]https://lore.kernel.org/lkml/CAJD7tkbRF6od-2x_L8-A1QL3=2Ww13sCj4S3i4bNndqF+3+_Vg@mail.gmail.com/
[2]https://lore.kernel.org/lkml/Z5gdnSX5Lv-nfjQL@google.com/
[3]https://lore.kernel.org/lkml/20240904233343.933462-1-yosryahmed@google.com/

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 CREDITS                                    |   2 +
 Documentation/admin-guide/mm/zswap.rst     |  10 +-
 MAINTAINERS                                |   7 -
 arch/loongarch/configs/loongson3_defconfig |   3 +-
 arch/s390/configs/debug_defconfig          |   2 +-
 arch/s390/configs/defconfig                |   2 +-
 include/linux/zpool.h                      |   5 +-
 mm/Kconfig                                 |  18 -
 mm/Makefile                                |   1 -
 mm/zbud.c                                  | 455 ---------------------
 mm/zpool.c                                 |   4 +-
 11 files changed, 13 insertions(+), 496 deletions(-)
 delete mode 100644 mm/zbud.c

diff --git a/CREDITS b/CREDITS
index 324428ad37e83..7d1f554238d65 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1895,6 +1895,7 @@ S: Czech Republic
 N: Seth Jennings
 E: sjenning@redhat.com
 D: Creation and maintenance of zswap
+D: Creation and maintenace of the zbud allocator
 
 N: Jeremy Kerr
 D: Maintainer of SPU File System
@@ -3790,6 +3791,7 @@ N: Dan Streetman
 E: ddstreet@ieee.org
 D: Maintenance and development of zswap
 D: Creation and maintenance of the zpool API
+D: Maintenace of the zbud allocator
 
 N: Drew Sullivan
 E: drew@ss.org
diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index 3598dcd7dbe7e..fd3370aa43fe8 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -60,15 +60,13 @@ accessed.  The compressed memory pool grows on demand and shrinks as compressed
 pages are freed.  The pool is not preallocated.  By default, a zpool
 of type selected in ``CONFIG_ZSWAP_ZPOOL_DEFAULT`` Kconfig option is created,
 but it can be overridden at boot time by setting the ``zpool`` attribute,
-e.g. ``zswap.zpool=zbud``. It can also be changed at runtime using the sysfs
+e.g. ``zswap.zpool=zsmalloc``. It can also be changed at runtime using the sysfs
 ``zpool`` attribute, e.g.::
 
-	echo zbud > /sys/module/zswap/parameters/zpool
+	echo zsmalloc > /sys/module/zswap/parameters/zpool
 
-The zbud type zpool allocates exactly 1 page to store 2 compressed pages, which
-means the compression ratio will always be 2:1 or worse (because of half-full
-zbud pages).  The zsmalloc type zpool has a more complex compressed page
-storage method, and it can achieve greater storage densities.
+The zsmalloc type zpool has a complex compressed page storage method, and it
+can achieve great storage densities.
 
 When a swap page is passed from swapout to zswap, zswap maintains a mapping
 of the swap entry, a combination of the swap type and swap offset, to the zpool
diff --git a/MAINTAINERS b/MAINTAINERS
index 1583bb8eee587..6460fd94a986e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26065,13 +26065,6 @@ F:	Documentation/networking/device_drivers/hamradio/z8530drv.rst
 F:	drivers/net/hamradio/*scc.c
 F:	drivers/net/hamradio/z8530.h
 
-ZBUD COMPRESSED PAGE ALLOCATOR
-M:	Seth Jennings <sjenning@redhat.com>
-M:	Dan Streetman <ddstreet@ieee.org>
-L:	linux-mm@kvack.org
-S:	Maintained
-F:	mm/zbud.c
-
 ZD1211RW WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 73c77500ac467..7ce5beb3cbf34 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -109,8 +109,7 @@ CONFIG_BINFMT_MISC=m
 CONFIG_ZPOOL=y
 CONFIG_ZSWAP=y
 CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD=y
-CONFIG_ZBUD=y
-CONFIG_ZSMALLOC=m
+CONFIG_ZSMALLOC=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_MEMORY_HOTPLUG=y
 # CONFIG_MHP_DEFAULT_ONLINE_TYPE_OFFLINE is not set
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index d6beec5292a00..9bf540aee8277 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -92,7 +92,7 @@ CONFIG_UNIXWARE_DISKLABEL=y
 CONFIG_IOSCHED_BFQ=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ZSWAP=y
-CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
+CONFIG_ZSMALLOC=y
 CONFIG_ZSMALLOC_STAT=y
 CONFIG_SLAB_BUCKETS=y
 CONFIG_SLUB_STATS=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 8cfbfb10bba8c..2918635d8e55a 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -86,7 +86,7 @@ CONFIG_UNIXWARE_DISKLABEL=y
 CONFIG_IOSCHED_BFQ=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ZSWAP=y
-CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
+CONFIG_ZSMALLOC=y
 CONFIG_ZSMALLOC_STAT=y
 CONFIG_SLAB_BUCKETS=y
 # CONFIG_COMPAT_BRK is not set
diff --git a/include/linux/zpool.h b/include/linux/zpool.h
index a67d62b796980..5e6dc46b8cc4c 100644
--- a/include/linux/zpool.h
+++ b/include/linux/zpool.h
@@ -4,9 +4,8 @@
  *
  * Copyright (C) 2014 Dan Streetman
  *
- * This is a common frontend for the zbud and zsmalloc memory
- * storage pool implementations.  Typically, this is used to
- * store compressed memory.
+ * This is a common frontend for the zswap compressed memory storage
+ * implementations.
  */
 
 #ifndef _ZPOOL_H_
diff --git a/mm/Kconfig b/mm/Kconfig
index 6fa19022c09b8..fba9757e58147 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -129,7 +129,6 @@ choice
 	prompt "Default allocator"
 	depends on ZSWAP
 	default ZSWAP_ZPOOL_DEFAULT_ZSMALLOC if MMU
-	default ZSWAP_ZPOOL_DEFAULT_ZBUD
 	help
 	  Selects the default allocator for the compressed cache for
 	  swap pages.
@@ -140,12 +139,6 @@ choice
 	  The selection made here can be overridden by using the kernel
 	  command line 'zswap.zpool=' option.
 
-config ZSWAP_ZPOOL_DEFAULT_ZBUD
-	bool "zbud"
-	select ZBUD
-	help
-	  Use the zbud allocator as the default allocator.
-
 config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
 	bool "zsmalloc"
 	select ZSMALLOC
@@ -156,20 +149,9 @@ endchoice
 config ZSWAP_ZPOOL_DEFAULT
        string
        depends on ZSWAP
-       default "zbud" if ZSWAP_ZPOOL_DEFAULT_ZBUD
        default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
        default ""
 
-config ZBUD
-	tristate "2:1 compression allocator (zbud)"
-	depends on ZSWAP
-	help
-	  A special purpose allocator for storing compressed pages.
-	  It is designed to store up to two compressed pages per physical
-	  page.  While this design limits storage density, it has simple and
-	  deterministic reclaim properties that make it preferable to a higher
-	  density approach when reclaim will be used.
-
 config ZSMALLOC
 	tristate
 	prompt "N:1 compression allocator (zsmalloc)" if (ZSWAP || ZRAM)
diff --git a/mm/Makefile b/mm/Makefile
index e4c03da3c0846..53392d2af3a58 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -113,7 +113,6 @@ obj-$(CONFIG_DEBUG_VM_PGTABLE) += debug_vm_pgtable.o
 obj-$(CONFIG_PAGE_OWNER) += page_owner.o
 obj-$(CONFIG_MEMORY_ISOLATION) += page_isolation.o
 obj-$(CONFIG_ZPOOL)	+= zpool.o
-obj-$(CONFIG_ZBUD)	+= zbud.o
 obj-$(CONFIG_ZSMALLOC)	+= zsmalloc.o
 obj-$(CONFIG_GENERIC_EARLY_IOREMAP) += early_ioremap.o
 obj-$(CONFIG_CMA)	+= cma.o
diff --git a/mm/zbud.c b/mm/zbud.c
deleted file mode 100644
index e9836fff94381..0000000000000
--- a/mm/zbud.c
+++ /dev/null
@@ -1,455 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * zbud.c
- *
- * Copyright (C) 2013, Seth Jennings, IBM
- *
- * Concepts based on zcache internal zbud allocator by Dan Magenheimer.
- *
- * zbud is an special purpose allocator for storing compressed pages.  Contrary
- * to what its name may suggest, zbud is not a buddy allocator, but rather an
- * allocator that "buddies" two compressed pages together in a single memory
- * page.
- *
- * While this design limits storage density, it has simple and deterministic
- * reclaim properties that make it preferable to a higher density approach when
- * reclaim will be used.
- *
- * zbud works by storing compressed pages, or "zpages", together in pairs in a
- * single memory page called a "zbud page".  The first buddy is "left
- * justified" at the beginning of the zbud page, and the last buddy is "right
- * justified" at the end of the zbud page.  The benefit is that if either
- * buddy is freed, the freed buddy space, coalesced with whatever slack space
- * that existed between the buddies, results in the largest possible free region
- * within the zbud page.
- *
- * zbud also provides an attractive lower bound on density. The ratio of zpages
- * to zbud pages can not be less than 1.  This ensures that zbud can never "do
- * harm" by using more pages to store zpages than the uncompressed zpages would
- * have used on their own.
- *
- * zbud pages are divided into "chunks".  The size of the chunks is fixed at
- * compile time and determined by NCHUNKS_ORDER below.  Dividing zbud pages
- * into chunks allows organizing unbuddied zbud pages into a manageable number
- * of unbuddied lists according to the number of free chunks available in the
- * zbud page.
- *
- * The zbud API differs from that of conventional allocators in that the
- * allocation function, zbud_alloc(), returns an opaque handle to the user,
- * not a dereferenceable pointer.  The user must map the handle using
- * zbud_map() in order to get a usable pointer by which to access the
- * allocation data and unmap the handle with zbud_unmap() when operations
- * on the allocation data are complete.
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/atomic.h>
-#include <linux/list.h>
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/preempt.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/zpool.h>
-
-/*****************
- * Structures
-*****************/
-/*
- * NCHUNKS_ORDER determines the internal allocation granularity, effectively
- * adjusting internal fragmentation.  It also determines the number of
- * freelists maintained in each pool. NCHUNKS_ORDER of 6 means that the
- * allocation granularity will be in chunks of size PAGE_SIZE/64. As one chunk
- * in allocated page is occupied by zbud header, NCHUNKS will be calculated to
- * 63 which shows the max number of free chunks in zbud page, also there will be
- * 63 freelists per pool.
- */
-#define NCHUNKS_ORDER	6
-
-#define CHUNK_SHIFT	(PAGE_SHIFT - NCHUNKS_ORDER)
-#define CHUNK_SIZE	(1 << CHUNK_SHIFT)
-#define ZHDR_SIZE_ALIGNED CHUNK_SIZE
-#define NCHUNKS		((PAGE_SIZE - ZHDR_SIZE_ALIGNED) >> CHUNK_SHIFT)
-
-struct zbud_pool;
-
-/**
- * struct zbud_pool - stores metadata for each zbud pool
- * @lock:	protects all pool fields and first|last_chunk fields of any
- *		zbud page in the pool
- * @unbuddied:	array of lists tracking zbud pages that only contain one buddy;
- *		the lists each zbud page is added to depends on the size of
- *		its free region.
- * @buddied:	list tracking the zbud pages that contain two buddies;
- *		these zbud pages are full
- * @pages_nr:	number of zbud pages in the pool.
- *
- * This structure is allocated at pool creation time and maintains metadata
- * pertaining to a particular zbud pool.
- */
-struct zbud_pool {
-	spinlock_t lock;
-	union {
-		/*
-		 * Reuse unbuddied[0] as buddied on the ground that
-		 * unbuddied[0] is unused.
-		 */
-		struct list_head buddied;
-		struct list_head unbuddied[NCHUNKS];
-	};
-	u64 pages_nr;
-};
-
-/*
- * struct zbud_header - zbud page metadata occupying the first chunk of each
- *			zbud page.
- * @buddy:	links the zbud page into the unbuddied/buddied lists in the pool
- * @first_chunks:	the size of the first buddy in chunks, 0 if free
- * @last_chunks:	the size of the last buddy in chunks, 0 if free
- */
-struct zbud_header {
-	struct list_head buddy;
-	unsigned int first_chunks;
-	unsigned int last_chunks;
-};
-
-/*****************
- * Helpers
-*****************/
-/* Just to make the code easier to read */
-enum buddy {
-	FIRST,
-	LAST
-};
-
-/* Converts an allocation size in bytes to size in zbud chunks */
-static int size_to_chunks(size_t size)
-{
-	return (size + CHUNK_SIZE - 1) >> CHUNK_SHIFT;
-}
-
-#define for_each_unbuddied_list(_iter, _begin) \
-	for ((_iter) = (_begin); (_iter) < NCHUNKS; (_iter)++)
-
-/* Initializes the zbud header of a newly allocated zbud page */
-static struct zbud_header *init_zbud_page(struct page *page)
-{
-	struct zbud_header *zhdr = page_address(page);
-	zhdr->first_chunks = 0;
-	zhdr->last_chunks = 0;
-	INIT_LIST_HEAD(&zhdr->buddy);
-	return zhdr;
-}
-
-/* Resets the struct page fields and frees the page */
-static void free_zbud_page(struct zbud_header *zhdr)
-{
-	__free_page(virt_to_page(zhdr));
-}
-
-/*
- * Encodes the handle of a particular buddy within a zbud page
- * Pool lock should be held as this function accesses first|last_chunks
- */
-static unsigned long encode_handle(struct zbud_header *zhdr, enum buddy bud)
-{
-	unsigned long handle;
-
-	/*
-	 * For now, the encoded handle is actually just the pointer to the data
-	 * but this might not always be the case.  A little information hiding.
-	 * Add CHUNK_SIZE to the handle if it is the first allocation to jump
-	 * over the zbud header in the first chunk.
-	 */
-	handle = (unsigned long)zhdr;
-	if (bud == FIRST)
-		/* skip over zbud header */
-		handle += ZHDR_SIZE_ALIGNED;
-	else /* bud == LAST */
-		handle += PAGE_SIZE - (zhdr->last_chunks  << CHUNK_SHIFT);
-	return handle;
-}
-
-/* Returns the zbud page where a given handle is stored */
-static struct zbud_header *handle_to_zbud_header(unsigned long handle)
-{
-	return (struct zbud_header *)(handle & PAGE_MASK);
-}
-
-/* Returns the number of free chunks in a zbud page */
-static int num_free_chunks(struct zbud_header *zhdr)
-{
-	/*
-	 * Rather than branch for different situations, just use the fact that
-	 * free buddies have a length of zero to simplify everything.
-	 */
-	return NCHUNKS - zhdr->first_chunks - zhdr->last_chunks;
-}
-
-/*****************
- * API Functions
-*****************/
-/**
- * zbud_create_pool() - create a new zbud pool
- * @gfp:	gfp flags when allocating the zbud pool structure
- *
- * Return: pointer to the new zbud pool or NULL if the metadata allocation
- * failed.
- */
-static struct zbud_pool *zbud_create_pool(gfp_t gfp)
-{
-	struct zbud_pool *pool;
-	int i;
-
-	pool = kzalloc(sizeof(struct zbud_pool), gfp);
-	if (!pool)
-		return NULL;
-	spin_lock_init(&pool->lock);
-	for_each_unbuddied_list(i, 0)
-		INIT_LIST_HEAD(&pool->unbuddied[i]);
-	INIT_LIST_HEAD(&pool->buddied);
-	pool->pages_nr = 0;
-	return pool;
-}
-
-/**
- * zbud_destroy_pool() - destroys an existing zbud pool
- * @pool:	the zbud pool to be destroyed
- *
- * The pool should be emptied before this function is called.
- */
-static void zbud_destroy_pool(struct zbud_pool *pool)
-{
-	kfree(pool);
-}
-
-/**
- * zbud_alloc() - allocates a region of a given size
- * @pool:	zbud pool from which to allocate
- * @size:	size in bytes of the desired allocation
- * @gfp:	gfp flags used if the pool needs to grow
- * @handle:	handle of the new allocation
- *
- * This function will attempt to find a free region in the pool large enough to
- * satisfy the allocation request.  A search of the unbuddied lists is
- * performed first. If no suitable free region is found, then a new page is
- * allocated and added to the pool to satisfy the request.
- *
- * gfp should not set __GFP_HIGHMEM as highmem pages cannot be used
- * as zbud pool pages.
- *
- * Return: 0 if success and handle is set, otherwise -EINVAL if the size or
- * gfp arguments are invalid or -ENOMEM if the pool was unable to allocate
- * a new page.
- */
-static int zbud_alloc(struct zbud_pool *pool, size_t size, gfp_t gfp,
-			unsigned long *handle)
-{
-	int chunks, i, freechunks;
-	struct zbud_header *zhdr = NULL;
-	enum buddy bud;
-	struct page *page;
-
-	if (!size || (gfp & __GFP_HIGHMEM))
-		return -EINVAL;
-	if (size > PAGE_SIZE - ZHDR_SIZE_ALIGNED - CHUNK_SIZE)
-		return -ENOSPC;
-	chunks = size_to_chunks(size);
-	spin_lock(&pool->lock);
-
-	/* First, try to find an unbuddied zbud page. */
-	for_each_unbuddied_list(i, chunks) {
-		if (!list_empty(&pool->unbuddied[i])) {
-			zhdr = list_first_entry(&pool->unbuddied[i],
-					struct zbud_header, buddy);
-			list_del(&zhdr->buddy);
-			if (zhdr->first_chunks == 0)
-				bud = FIRST;
-			else
-				bud = LAST;
-			goto found;
-		}
-	}
-
-	/* Couldn't find unbuddied zbud page, create new one */
-	spin_unlock(&pool->lock);
-	page = alloc_page(gfp);
-	if (!page)
-		return -ENOMEM;
-	spin_lock(&pool->lock);
-	pool->pages_nr++;
-	zhdr = init_zbud_page(page);
-	bud = FIRST;
-
-found:
-	if (bud == FIRST)
-		zhdr->first_chunks = chunks;
-	else
-		zhdr->last_chunks = chunks;
-
-	if (zhdr->first_chunks == 0 || zhdr->last_chunks == 0) {
-		/* Add to unbuddied list */
-		freechunks = num_free_chunks(zhdr);
-		list_add(&zhdr->buddy, &pool->unbuddied[freechunks]);
-	} else {
-		/* Add to buddied list */
-		list_add(&zhdr->buddy, &pool->buddied);
-	}
-
-	*handle = encode_handle(zhdr, bud);
-	spin_unlock(&pool->lock);
-
-	return 0;
-}
-
-/**
- * zbud_free() - frees the allocation associated with the given handle
- * @pool:	pool in which the allocation resided
- * @handle:	handle associated with the allocation returned by zbud_alloc()
- */
-static void zbud_free(struct zbud_pool *pool, unsigned long handle)
-{
-	struct zbud_header *zhdr;
-	int freechunks;
-
-	spin_lock(&pool->lock);
-	zhdr = handle_to_zbud_header(handle);
-
-	/* If first buddy, handle will be page aligned */
-	if ((handle - ZHDR_SIZE_ALIGNED) & ~PAGE_MASK)
-		zhdr->last_chunks = 0;
-	else
-		zhdr->first_chunks = 0;
-
-	/* Remove from existing buddy list */
-	list_del(&zhdr->buddy);
-
-	if (zhdr->first_chunks == 0 && zhdr->last_chunks == 0) {
-		/* zbud page is empty, free */
-		free_zbud_page(zhdr);
-		pool->pages_nr--;
-	} else {
-		/* Add to unbuddied list */
-		freechunks = num_free_chunks(zhdr);
-		list_add(&zhdr->buddy, &pool->unbuddied[freechunks]);
-	}
-
-	spin_unlock(&pool->lock);
-}
-
-/**
- * zbud_map() - maps the allocation associated with the given handle
- * @pool:	pool in which the allocation resides
- * @handle:	handle associated with the allocation to be mapped
- *
- * While trivial for zbud, the mapping functions for others allocators
- * implementing this allocation API could have more complex information encoded
- * in the handle and could create temporary mappings to make the data
- * accessible to the user.
- *
- * Returns: a pointer to the mapped allocation
- */
-static void *zbud_map(struct zbud_pool *pool, unsigned long handle)
-{
-	return (void *)(handle);
-}
-
-/**
- * zbud_unmap() - maps the allocation associated with the given handle
- * @pool:	pool in which the allocation resides
- * @handle:	handle associated with the allocation to be unmapped
- */
-static void zbud_unmap(struct zbud_pool *pool, unsigned long handle)
-{
-}
-
-/**
- * zbud_get_pool_pages() - gets the zbud pool size in pages
- * @pool:	pool whose size is being queried
- *
- * Returns: size in pages of the given pool.  The pool lock need not be
- * taken to access pages_nr.
- */
-static u64 zbud_get_pool_pages(struct zbud_pool *pool)
-{
-	return pool->pages_nr;
-}
-
-/*****************
- * zpool
- ****************/
-
-static void *zbud_zpool_create(const char *name, gfp_t gfp)
-{
-	return zbud_create_pool(gfp);
-}
-
-static void zbud_zpool_destroy(void *pool)
-{
-	zbud_destroy_pool(pool);
-}
-
-static int zbud_zpool_malloc(void *pool, size_t size, gfp_t gfp,
-			unsigned long *handle)
-{
-	return zbud_alloc(pool, size, gfp, handle);
-}
-static void zbud_zpool_free(void *pool, unsigned long handle)
-{
-	zbud_free(pool, handle);
-}
-
-static void *zbud_zpool_map(void *pool, unsigned long handle,
-			enum zpool_mapmode mm)
-{
-	return zbud_map(pool, handle);
-}
-static void zbud_zpool_unmap(void *pool, unsigned long handle)
-{
-	zbud_unmap(pool, handle);
-}
-
-static u64 zbud_zpool_total_pages(void *pool)
-{
-	return zbud_get_pool_pages(pool);
-}
-
-static struct zpool_driver zbud_zpool_driver = {
-	.type =		"zbud",
-	.sleep_mapped = true,
-	.owner =	THIS_MODULE,
-	.create =	zbud_zpool_create,
-	.destroy =	zbud_zpool_destroy,
-	.malloc =	zbud_zpool_malloc,
-	.free =		zbud_zpool_free,
-	.map =		zbud_zpool_map,
-	.unmap =	zbud_zpool_unmap,
-	.total_pages =	zbud_zpool_total_pages,
-};
-
-MODULE_ALIAS("zpool-zbud");
-
-static int __init init_zbud(void)
-{
-	/* Make sure the zbud header will fit in one chunk */
-	BUILD_BUG_ON(sizeof(struct zbud_header) > ZHDR_SIZE_ALIGNED);
-	pr_info("loaded\n");
-
-	zpool_register_driver(&zbud_zpool_driver);
-
-	return 0;
-}
-
-static void __exit exit_zbud(void)
-{
-	zpool_unregister_driver(&zbud_zpool_driver);
-	pr_info("unloaded\n");
-}
-
-module_init(init_zbud);
-module_exit(exit_zbud);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Seth Jennings <sjennings@variantweb.net>");
-MODULE_DESCRIPTION("Buddy Allocator for Compressed Pages");
diff --git a/mm/zpool.c b/mm/zpool.c
index b9fda1fa857da..4bbd12d4b6599 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -95,7 +95,7 @@ static void zpool_put_driver(struct zpool_driver *driver)
 
 /**
  * zpool_has_pool() - Check if the pool driver is available
- * @type:	The type of the zpool to check (e.g. zbud, zsmalloc)
+ * @type:	The type of the zpool to check (e.g. zsmalloc)
  *
  * This checks if the @type pool driver is available.  This will try to load
  * the requested module, if needed, but there is no guarantee the module will
@@ -130,7 +130,7 @@ EXPORT_SYMBOL(zpool_has_pool);
 
 /**
  * zpool_create_pool() - Create a new zpool
- * @type:	The type of the zpool to create (e.g. zbud, zsmalloc)
+ * @type:	The type of the zpool to create (e.g. zsmalloc)
  * @name:	The name of the zpool (e.g. zram0, zswap)
  * @gfp:	The GFP flags to use when allocating the pool.
  *
-- 
2.48.1.262.g85cc9f2d1e-goog


