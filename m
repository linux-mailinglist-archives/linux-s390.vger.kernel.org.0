Return-Path: <linux-s390+bounces-8689-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A25A2239A
	for <lists+linux-s390@lfdr.de>; Wed, 29 Jan 2025 19:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73FE3A4397
	for <lists+linux-s390@lfdr.de>; Wed, 29 Jan 2025 18:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57302190696;
	Wed, 29 Jan 2025 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DDP7wGSD"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31951E0E16
	for <linux-s390@vger.kernel.org>; Wed, 29 Jan 2025 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174013; cv=none; b=ZebhF4wCpiEGt67x0aHctX1TwZs5gxqUuYH1mevLp2NneQvmw6pNDvoe4rA3rtuzfWoWnBKTegyUnyqWYnPfcElT1tFoz4q9GwF5IY++WASdihh3L5ykeTW1Id9czFsKcOVwVdExyElX+UWRd+/J36kyRA4FLqNTSAXz7b50MF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174013; c=relaxed/simple;
	bh=himmZ4xjv3BI13JecayKN8qS5Mo+rMtLmqEtknkIwWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIZpM7Xuyw5oDLYC9Ar5gFagV2XglOgihVWDGGV882t9PiWnWenrYMusNbYPRIuQffbW15AqCScuIcpVkIg86smZYH1btsXI4U81PyZ6mwb+kSTNPwEhmcYi9V7Yd7X7hGjI5X20RqfSEV5blQ+Y+6dd+dWjFcAur+aYEHTTGbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DDP7wGSD; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738174007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FT4YGOt3bo9db/JwvEGY/YuMUDbNNKm3knPDe4QtXNY=;
	b=DDP7wGSDPsbxG/VKR86wfJzdmJHxncLLxiBFm9cPZq75611W6ZPCZ1qWqdLWFZHiKfz1p4
	W0dUDzkjFQQIEVNeOdZ8CQWEQxzxfvoKT5JwB98SHvjm/x/9eHuXxO+CNYkJ3zbwAprutO
	1mYG5sLZDrSkCbY6M93T8fdvtdPDsQA=
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
Subject: [PATCH v2 1/2] mm: z3fold: remove z3fold
Date: Wed, 29 Jan 2025 18:06:31 +0000
Message-ID: <20250129180633.3501650-2-yosry.ahmed@linux.dev>
In-Reply-To: <20250129180633.3501650-1-yosry.ahmed@linux.dev>
References: <20250129180633.3501650-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Z3fold has been marked as deprecated for 2 cycles and no one complained,
as expected. As there are no known users, remove the code now.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Nhat Pham <nphamcs@gmail.com>
---
 CREDITS                                       |    1 +
 Documentation/mm/index.rst                    |    1 -
 Documentation/mm/z3fold.rst                   |   28 -
 Documentation/translations/zh_CN/mm/index.rst |    1 -
 .../translations/zh_CN/mm/z3fold.rst          |   31 -
 MAINTAINERS                                   |    7 -
 mm/Kconfig                                    |   29 -
 mm/Makefile                                   |    1 -
 mm/z3fold.c                                   | 1447 -----------------
 9 files changed, 1 insertion(+), 1545 deletions(-)
 delete mode 100644 Documentation/mm/z3fold.rst
 delete mode 100644 Documentation/translations/zh_CN/mm/z3fold.rst
 delete mode 100644 mm/z3fold.c

diff --git a/CREDITS b/CREDITS
index 1f9f0f078b4ae..324428ad37e83 100644
--- a/CREDITS
+++ b/CREDITS
@@ -4313,6 +4313,7 @@ S: England
 N: Vitaly Wool
 E: vitaly.wool@konsulko.com
 D: Maintenance and development of zswap
+D: Maintenance and development of z3fold
 
 N: Chris Wright
 E: chrisw@sous-sol.org
diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index 0be1c7503a010..d3ada3e45e103 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -62,5 +62,4 @@ documentation, or deleted if it has served its purpose.
    unevictable-lru
    vmalloced-kernel-stacks
    vmemmap_dedup
-   z3fold
    zsmalloc
diff --git a/Documentation/mm/z3fold.rst b/Documentation/mm/z3fold.rst
deleted file mode 100644
index 25b5935d06c7d..0000000000000
--- a/Documentation/mm/z3fold.rst
+++ /dev/null
@@ -1,28 +0,0 @@
-======
-z3fold
-======
-
-z3fold is a special purpose allocator for storing compressed pages.
-It is designed to store up to three compressed pages per physical page.
-It is a zbud derivative which allows for higher compression
-ratio keeping the simplicity and determinism of its predecessor.
-
-The main differences between z3fold and zbud are:
-
-* unlike zbud, z3fold allows for up to PAGE_SIZE allocations
-* z3fold can hold up to 3 compressed pages in its page
-* z3fold doesn't export any API itself and is thus intended to be used
-  via the zpool API.
-
-To keep the determinism and simplicity, z3fold, just like zbud, always
-stores an integral number of compressed pages per page, but it can store
-up to 3 pages unlike zbud which can store at most 2. Therefore the
-compression ratio goes to around 2.7x while zbud's one is around 1.7x.
-
-Unlike zbud (but like zsmalloc for that matter) z3fold_alloc() does not
-return a dereferenceable pointer. Instead, it returns an unsigned long
-handle which encodes actual location of the allocated object.
-
-Keeping effective compression ratio close to zsmalloc's, z3fold doesn't
-depend on MMU enabled and provides more predictable reclaim behavior
-which makes it a better fit for small and response-critical systems.
diff --git a/Documentation/translations/zh_CN/mm/index.rst b/Documentation/translations/zh_CN/mm/index.rst
index c8726bce8f745..a71116be058fd 100644
--- a/Documentation/translations/zh_CN/mm/index.rst
+++ b/Documentation/translations/zh_CN/mm/index.rst
@@ -58,7 +58,6 @@ Linux内存管理文档
    remap_file_pages
    split_page_table_lock
    vmalloced-kernel-stacks
-   z3fold
    zsmalloc
 
 TODOLIST:
diff --git a/Documentation/translations/zh_CN/mm/z3fold.rst b/Documentation/translations/zh_CN/mm/z3fold.rst
deleted file mode 100644
index 9569a6d882700..0000000000000
--- a/Documentation/translations/zh_CN/mm/z3fold.rst
+++ /dev/null
@@ -1,31 +0,0 @@
-:Original: Documentation/mm/z3fold.rst
-
-:翻译:
-
- 司延腾 Yanteng Si <siyanteng@loongson.cn>
-
-:校译:
-
-
-======
-z3fold
-======
-
-z3fold是一个专门用于存储压缩页的分配器。它被设计为每个物理页最多可以存储三个压缩页。
-它是zbud的衍生物，允许更高的压缩率，保持其前辈的简单性和确定性。
-
-z3fold和zbud的主要区别是:
-
-* 与zbud不同的是，z3fold允许最大的PAGE_SIZE分配。
-* z3fold在其页面中最多可以容纳3个压缩页面
-* z3fold本身没有输出任何API，因此打算通过zpool的API来使用
-
-为了保持确定性和简单性，z3fold，就像zbud一样，总是在每页存储一个整数的压缩页，但是
-它最多可以存储3页，不像zbud最多可以存储2页。因此压缩率达到2.7倍左右，而zbud的压缩
-率是1.7倍左右。
-
-不像zbud（但也像zsmalloc），z3fold_alloc()那样不返回一个可重复引用的指针。相反，它
-返回一个无符号长句柄，它编码了被分配对象的实际位置。
-
-保持有效的压缩率接近于zsmalloc，z3fold不依赖于MMU的启用，并提供更可预测的回收行
-为，这使得它更适合于小型和反应迅速的系统。
diff --git a/MAINTAINERS b/MAINTAINERS
index feed152470f68..1583bb8eee587 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26055,13 +26055,6 @@ S:	Maintained
 F:	Documentation/input/devices/yealink.rst
 F:	drivers/input/misc/yealink.*
 
-Z3FOLD COMPRESSED PAGE ALLOCATOR
-M:	Vitaly Wool <vitaly.wool@konsulko.com>
-R:	Miaohe Lin <linmiaohe@huawei.com>
-L:	linux-mm@kvack.org
-S:	Maintained
-F:	mm/z3fold.c
-
 Z8530 DRIVER FOR AX.25
 M:	Joerg Reuter <jreuter@yaina.de>
 L:	linux-hams@vger.kernel.org
diff --git a/mm/Kconfig b/mm/Kconfig
index 1b501db064172..6fa19022c09b8 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -146,15 +146,6 @@ config ZSWAP_ZPOOL_DEFAULT_ZBUD
 	help
 	  Use the zbud allocator as the default allocator.
 
-config ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED
-	bool "z3foldi (DEPRECATED)"
-	select Z3FOLD_DEPRECATED
-	help
-	  Use the z3fold allocator as the default allocator.
-
-	  Deprecated and scheduled for removal in a few cycles,
-	  see CONFIG_Z3FOLD_DEPRECATED.
-
 config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
 	bool "zsmalloc"
 	select ZSMALLOC
@@ -166,7 +157,6 @@ config ZSWAP_ZPOOL_DEFAULT
        string
        depends on ZSWAP
        default "zbud" if ZSWAP_ZPOOL_DEFAULT_ZBUD
-       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED
        default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
        default ""
 
@@ -180,25 +170,6 @@ config ZBUD
 	  deterministic reclaim properties that make it preferable to a higher
 	  density approach when reclaim will be used.
 
-config Z3FOLD_DEPRECATED
-	tristate "3:1 compression allocator (z3fold) (DEPRECATED)"
-	depends on ZSWAP
-	help
-	  Deprecated and scheduled for removal in a few cycles. If you have
-	  a good reason for using Z3FOLD over ZSMALLOC, please contact
-	  linux-mm@kvack.org and the zswap maintainers.
-
-	  A special purpose allocator for storing compressed pages.
-	  It is designed to store up to three compressed pages per physical
-	  page. It is a ZBUD derivative so the simplicity and determinism are
-	  still there.
-
-config Z3FOLD
-	tristate
-	default y if Z3FOLD_DEPRECATED=y
-	default m if Z3FOLD_DEPRECATED=m
-	depends on Z3FOLD_DEPRECATED
-
 config ZSMALLOC
 	tristate
 	prompt "N:1 compression allocator (zsmalloc)" if (ZSWAP || ZRAM)
diff --git a/mm/Makefile b/mm/Makefile
index 850386a67b3e0..e4c03da3c0846 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -115,7 +115,6 @@ obj-$(CONFIG_MEMORY_ISOLATION) += page_isolation.o
 obj-$(CONFIG_ZPOOL)	+= zpool.o
 obj-$(CONFIG_ZBUD)	+= zbud.o
 obj-$(CONFIG_ZSMALLOC)	+= zsmalloc.o
-obj-$(CONFIG_Z3FOLD)	+= z3fold.o
 obj-$(CONFIG_GENERIC_EARLY_IOREMAP) += early_ioremap.o
 obj-$(CONFIG_CMA)	+= cma.o
 obj-$(CONFIG_NUMA) += numa.o
diff --git a/mm/z3fold.c b/mm/z3fold.c
deleted file mode 100644
index 379d24b4fef99..0000000000000
--- a/mm/z3fold.c
+++ /dev/null
@@ -1,1447 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * z3fold.c
- *
- * Author: Vitaly Wool <vitaly.wool@konsulko.com>
- * Copyright (C) 2016, Sony Mobile Communications Inc.
- *
- * This implementation is based on zbud written by Seth Jennings.
- *
- * z3fold is an special purpose allocator for storing compressed pages. It
- * can store up to three compressed pages per page which improves the
- * compression ratio of zbud while retaining its main concepts (e. g. always
- * storing an integral number of objects per page) and simplicity.
- * It still has simple and deterministic reclaim properties that make it
- * preferable to a higher density approach (with no requirement on integral
- * number of object per page) when reclaim is used.
- *
- * As in zbud, pages are divided into "chunks".  The size of the chunks is
- * fixed at compile time and is determined by NCHUNKS_ORDER below.
- *
- * z3fold doesn't export any API and is meant to be used via zpool API.
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/atomic.h>
-#include <linux/sched.h>
-#include <linux/cpumask.h>
-#include <linux/list.h>
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/page-flags.h>
-#include <linux/migrate.h>
-#include <linux/node.h>
-#include <linux/compaction.h>
-#include <linux/percpu.h>
-#include <linux/preempt.h>
-#include <linux/workqueue.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/zpool.h>
-#include <linux/kmemleak.h>
-
-/*
- * NCHUNKS_ORDER determines the internal allocation granularity, effectively
- * adjusting internal fragmentation.  It also determines the number of
- * freelists maintained in each pool. NCHUNKS_ORDER of 6 means that the
- * allocation granularity will be in chunks of size PAGE_SIZE/64. Some chunks
- * in the beginning of an allocated page are occupied by z3fold header, so
- * NCHUNKS will be calculated to 63 (or 62 in case CONFIG_DEBUG_SPINLOCK=y),
- * which shows the max number of free chunks in z3fold page, also there will
- * be 63, or 62, respectively, freelists per pool.
- */
-#define NCHUNKS_ORDER	6
-
-#define CHUNK_SHIFT	(PAGE_SHIFT - NCHUNKS_ORDER)
-#define CHUNK_SIZE	(1 << CHUNK_SHIFT)
-#define ZHDR_SIZE_ALIGNED round_up(sizeof(struct z3fold_header), CHUNK_SIZE)
-#define ZHDR_CHUNKS	(ZHDR_SIZE_ALIGNED >> CHUNK_SHIFT)
-#define TOTAL_CHUNKS	(PAGE_SIZE >> CHUNK_SHIFT)
-#define NCHUNKS		(TOTAL_CHUNKS - ZHDR_CHUNKS)
-
-#define BUDDY_MASK	(0x3)
-#define BUDDY_SHIFT	2
-#define SLOTS_ALIGN	(0x40)
-
-/*****************
- * Structures
-*****************/
-struct z3fold_pool;
-
-enum buddy {
-	HEADLESS = 0,
-	FIRST,
-	MIDDLE,
-	LAST,
-	BUDDIES_MAX = LAST
-};
-
-struct z3fold_buddy_slots {
-	/*
-	 * we are using BUDDY_MASK in handle_to_buddy etc. so there should
-	 * be enough slots to hold all possible variants
-	 */
-	unsigned long slot[BUDDY_MASK + 1];
-	unsigned long pool; /* back link */
-	rwlock_t lock;
-};
-#define HANDLE_FLAG_MASK	(0x03)
-
-/*
- * struct z3fold_header - z3fold page metadata occupying first chunks of each
- *			z3fold page, except for HEADLESS pages
- * @buddy:		links the z3fold page into the relevant list in the
- *			pool
- * @page_lock:		per-page lock
- * @refcount:		reference count for the z3fold page
- * @work:		work_struct for page layout optimization
- * @slots:		pointer to the structure holding buddy slots
- * @pool:		pointer to the containing pool
- * @cpu:		CPU which this page "belongs" to
- * @first_chunks:	the size of the first buddy in chunks, 0 if free
- * @middle_chunks:	the size of the middle buddy in chunks, 0 if free
- * @last_chunks:	the size of the last buddy in chunks, 0 if free
- * @first_num:		the starting number (for the first handle)
- * @mapped_count:	the number of objects currently mapped
- */
-struct z3fold_header {
-	struct list_head buddy;
-	spinlock_t page_lock;
-	struct kref refcount;
-	struct work_struct work;
-	struct z3fold_buddy_slots *slots;
-	struct z3fold_pool *pool;
-	short cpu;
-	unsigned short first_chunks;
-	unsigned short middle_chunks;
-	unsigned short last_chunks;
-	unsigned short start_middle;
-	unsigned short first_num:2;
-	unsigned short mapped_count:2;
-	unsigned short foreign_handles:2;
-};
-
-/**
- * struct z3fold_pool - stores metadata for each z3fold pool
- * @name:	pool name
- * @lock:	protects pool unbuddied lists
- * @stale_lock:	protects pool stale page list
- * @unbuddied:	per-cpu array of lists tracking z3fold pages that contain 2-
- *		buddies; the list each z3fold page is added to depends on
- *		the size of its free region.
- * @stale:	list of pages marked for freeing
- * @pages_nr:	number of z3fold pages in the pool.
- * @c_handle:	cache for z3fold_buddy_slots allocation
- * @compact_wq:	workqueue for page layout background optimization
- * @release_wq:	workqueue for safe page release
- * @work:	work_struct for safe page release
- *
- * This structure is allocated at pool creation time and maintains metadata
- * pertaining to a particular z3fold pool.
- */
-struct z3fold_pool {
-	const char *name;
-	spinlock_t lock;
-	spinlock_t stale_lock;
-	struct list_head __percpu *unbuddied;
-	struct list_head stale;
-	atomic64_t pages_nr;
-	struct kmem_cache *c_handle;
-	struct workqueue_struct *compact_wq;
-	struct workqueue_struct *release_wq;
-	struct work_struct work;
-};
-
-/*
- * Internal z3fold page flags
- */
-enum z3fold_page_flags {
-	PAGE_HEADLESS = 0,
-	MIDDLE_CHUNK_MAPPED,
-	NEEDS_COMPACTING,
-	PAGE_STALE,
-	PAGE_CLAIMED, /* by either reclaim or free */
-	PAGE_MIGRATED, /* page is migrated and soon to be released */
-};
-
-/*
- * handle flags, go under HANDLE_FLAG_MASK
- */
-enum z3fold_handle_flags {
-	HANDLES_NOFREE = 0,
-};
-
-/*
- * Forward declarations
- */
-static struct z3fold_header *__z3fold_alloc(struct z3fold_pool *, size_t, bool);
-static void compact_page_work(struct work_struct *w);
-
-/*****************
- * Helpers
-*****************/
-
-/* Converts an allocation size in bytes to size in z3fold chunks */
-static int size_to_chunks(size_t size)
-{
-	return (size + CHUNK_SIZE - 1) >> CHUNK_SHIFT;
-}
-
-#define for_each_unbuddied_list(_iter, _begin) \
-	for ((_iter) = (_begin); (_iter) < NCHUNKS; (_iter)++)
-
-static inline struct z3fold_buddy_slots *alloc_slots(struct z3fold_pool *pool,
-							gfp_t gfp)
-{
-	struct z3fold_buddy_slots *slots = kmem_cache_zalloc(pool->c_handle,
-							     gfp);
-
-	if (slots) {
-		/* It will be freed separately in free_handle(). */
-		kmemleak_not_leak(slots);
-		slots->pool = (unsigned long)pool;
-		rwlock_init(&slots->lock);
-	}
-
-	return slots;
-}
-
-static inline struct z3fold_pool *slots_to_pool(struct z3fold_buddy_slots *s)
-{
-	return (struct z3fold_pool *)(s->pool & ~HANDLE_FLAG_MASK);
-}
-
-static inline struct z3fold_buddy_slots *handle_to_slots(unsigned long handle)
-{
-	return (struct z3fold_buddy_slots *)(handle & ~(SLOTS_ALIGN - 1));
-}
-
-/* Lock a z3fold page */
-static inline void z3fold_page_lock(struct z3fold_header *zhdr)
-{
-	spin_lock(&zhdr->page_lock);
-}
-
-/* Try to lock a z3fold page */
-static inline int z3fold_page_trylock(struct z3fold_header *zhdr)
-{
-	return spin_trylock(&zhdr->page_lock);
-}
-
-/* Unlock a z3fold page */
-static inline void z3fold_page_unlock(struct z3fold_header *zhdr)
-{
-	spin_unlock(&zhdr->page_lock);
-}
-
-/* return locked z3fold page if it's not headless */
-static inline struct z3fold_header *get_z3fold_header(unsigned long handle)
-{
-	struct z3fold_buddy_slots *slots;
-	struct z3fold_header *zhdr;
-	int locked = 0;
-
-	if (!(handle & (1 << PAGE_HEADLESS))) {
-		slots = handle_to_slots(handle);
-		do {
-			unsigned long addr;
-
-			read_lock(&slots->lock);
-			addr = *(unsigned long *)handle;
-			zhdr = (struct z3fold_header *)(addr & PAGE_MASK);
-			locked = z3fold_page_trylock(zhdr);
-			read_unlock(&slots->lock);
-			if (locked) {
-				struct page *page = virt_to_page(zhdr);
-
-				if (!test_bit(PAGE_MIGRATED, &page->private))
-					break;
-				z3fold_page_unlock(zhdr);
-			}
-			cpu_relax();
-		} while (true);
-	} else {
-		zhdr = (struct z3fold_header *)(handle & PAGE_MASK);
-	}
-
-	return zhdr;
-}
-
-static inline void put_z3fold_header(struct z3fold_header *zhdr)
-{
-	struct page *page = virt_to_page(zhdr);
-
-	if (!test_bit(PAGE_HEADLESS, &page->private))
-		z3fold_page_unlock(zhdr);
-}
-
-static inline void free_handle(unsigned long handle, struct z3fold_header *zhdr)
-{
-	struct z3fold_buddy_slots *slots;
-	int i;
-	bool is_free;
-
-	if (WARN_ON(*(unsigned long *)handle == 0))
-		return;
-
-	slots = handle_to_slots(handle);
-	write_lock(&slots->lock);
-	*(unsigned long *)handle = 0;
-
-	if (test_bit(HANDLES_NOFREE, &slots->pool)) {
-		write_unlock(&slots->lock);
-		return; /* simple case, nothing else to do */
-	}
-
-	if (zhdr->slots != slots)
-		zhdr->foreign_handles--;
-
-	is_free = true;
-	for (i = 0; i <= BUDDY_MASK; i++) {
-		if (slots->slot[i]) {
-			is_free = false;
-			break;
-		}
-	}
-	write_unlock(&slots->lock);
-
-	if (is_free) {
-		struct z3fold_pool *pool = slots_to_pool(slots);
-
-		if (zhdr->slots == slots)
-			zhdr->slots = NULL;
-		kmem_cache_free(pool->c_handle, slots);
-	}
-}
-
-/* Initializes the z3fold header of a newly allocated z3fold page */
-static struct z3fold_header *init_z3fold_page(struct page *page, bool headless,
-					struct z3fold_pool *pool, gfp_t gfp)
-{
-	struct z3fold_header *zhdr = page_address(page);
-	struct z3fold_buddy_slots *slots;
-
-	clear_bit(PAGE_HEADLESS, &page->private);
-	clear_bit(MIDDLE_CHUNK_MAPPED, &page->private);
-	clear_bit(NEEDS_COMPACTING, &page->private);
-	clear_bit(PAGE_STALE, &page->private);
-	clear_bit(PAGE_CLAIMED, &page->private);
-	clear_bit(PAGE_MIGRATED, &page->private);
-	if (headless)
-		return zhdr;
-
-	slots = alloc_slots(pool, gfp);
-	if (!slots)
-		return NULL;
-
-	memset(zhdr, 0, sizeof(*zhdr));
-	spin_lock_init(&zhdr->page_lock);
-	kref_init(&zhdr->refcount);
-	zhdr->cpu = -1;
-	zhdr->slots = slots;
-	zhdr->pool = pool;
-	INIT_LIST_HEAD(&zhdr->buddy);
-	INIT_WORK(&zhdr->work, compact_page_work);
-	return zhdr;
-}
-
-/* Resets the struct page fields and frees the page */
-static void free_z3fold_page(struct page *page, bool headless)
-{
-	if (!headless) {
-		lock_page(page);
-		__ClearPageMovable(page);
-		unlock_page(page);
-	}
-	__free_page(page);
-}
-
-/* Helper function to build the index */
-static inline int __idx(struct z3fold_header *zhdr, enum buddy bud)
-{
-	return (bud + zhdr->first_num) & BUDDY_MASK;
-}
-
-/*
- * Encodes the handle of a particular buddy within a z3fold page.
- * Zhdr->page_lock should be held as this function accesses first_num
- * if bud != HEADLESS.
- */
-static unsigned long __encode_handle(struct z3fold_header *zhdr,
-				struct z3fold_buddy_slots *slots,
-				enum buddy bud)
-{
-	unsigned long h = (unsigned long)zhdr;
-	int idx = 0;
-
-	/*
-	 * For a headless page, its handle is its pointer with the extra
-	 * PAGE_HEADLESS bit set
-	 */
-	if (bud == HEADLESS)
-		return h | (1 << PAGE_HEADLESS);
-
-	/* otherwise, return pointer to encoded handle */
-	idx = __idx(zhdr, bud);
-	h += idx;
-	if (bud == LAST)
-		h |= (zhdr->last_chunks << BUDDY_SHIFT);
-
-	write_lock(&slots->lock);
-	slots->slot[idx] = h;
-	write_unlock(&slots->lock);
-	return (unsigned long)&slots->slot[idx];
-}
-
-static unsigned long encode_handle(struct z3fold_header *zhdr, enum buddy bud)
-{
-	return __encode_handle(zhdr, zhdr->slots, bud);
-}
-
-/* only for LAST bud, returns zero otherwise */
-static unsigned short handle_to_chunks(unsigned long handle)
-{
-	struct z3fold_buddy_slots *slots = handle_to_slots(handle);
-	unsigned long addr;
-
-	read_lock(&slots->lock);
-	addr = *(unsigned long *)handle;
-	read_unlock(&slots->lock);
-	return (addr & ~PAGE_MASK) >> BUDDY_SHIFT;
-}
-
-/*
- * (handle & BUDDY_MASK) < zhdr->first_num is possible in encode_handle
- *  but that doesn't matter. because the masking will result in the
- *  correct buddy number.
- */
-static enum buddy handle_to_buddy(unsigned long handle)
-{
-	struct z3fold_header *zhdr;
-	struct z3fold_buddy_slots *slots = handle_to_slots(handle);
-	unsigned long addr;
-
-	read_lock(&slots->lock);
-	WARN_ON(handle & (1 << PAGE_HEADLESS));
-	addr = *(unsigned long *)handle;
-	read_unlock(&slots->lock);
-	zhdr = (struct z3fold_header *)(addr & PAGE_MASK);
-	return (addr - zhdr->first_num) & BUDDY_MASK;
-}
-
-static inline struct z3fold_pool *zhdr_to_pool(struct z3fold_header *zhdr)
-{
-	return zhdr->pool;
-}
-
-static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
-{
-	struct page *page = virt_to_page(zhdr);
-	struct z3fold_pool *pool = zhdr_to_pool(zhdr);
-
-	WARN_ON(!list_empty(&zhdr->buddy));
-	set_bit(PAGE_STALE, &page->private);
-	clear_bit(NEEDS_COMPACTING, &page->private);
-	spin_lock(&pool->lock);
-	spin_unlock(&pool->lock);
-
-	if (locked)
-		z3fold_page_unlock(zhdr);
-
-	spin_lock(&pool->stale_lock);
-	list_add(&zhdr->buddy, &pool->stale);
-	queue_work(pool->release_wq, &pool->work);
-	spin_unlock(&pool->stale_lock);
-
-	atomic64_dec(&pool->pages_nr);
-}
-
-static void release_z3fold_page_locked(struct kref *ref)
-{
-	struct z3fold_header *zhdr = container_of(ref, struct z3fold_header,
-						refcount);
-	WARN_ON(z3fold_page_trylock(zhdr));
-	__release_z3fold_page(zhdr, true);
-}
-
-static void release_z3fold_page_locked_list(struct kref *ref)
-{
-	struct z3fold_header *zhdr = container_of(ref, struct z3fold_header,
-					       refcount);
-	struct z3fold_pool *pool = zhdr_to_pool(zhdr);
-
-	spin_lock(&pool->lock);
-	list_del_init(&zhdr->buddy);
-	spin_unlock(&pool->lock);
-
-	WARN_ON(z3fold_page_trylock(zhdr));
-	__release_z3fold_page(zhdr, true);
-}
-
-static inline int put_z3fold_locked(struct z3fold_header *zhdr)
-{
-	return kref_put(&zhdr->refcount, release_z3fold_page_locked);
-}
-
-static inline int put_z3fold_locked_list(struct z3fold_header *zhdr)
-{
-	return kref_put(&zhdr->refcount, release_z3fold_page_locked_list);
-}
-
-static void free_pages_work(struct work_struct *w)
-{
-	struct z3fold_pool *pool = container_of(w, struct z3fold_pool, work);
-
-	spin_lock(&pool->stale_lock);
-	while (!list_empty(&pool->stale)) {
-		struct z3fold_header *zhdr = list_first_entry(&pool->stale,
-						struct z3fold_header, buddy);
-		struct page *page = virt_to_page(zhdr);
-
-		list_del(&zhdr->buddy);
-		if (WARN_ON(!test_bit(PAGE_STALE, &page->private)))
-			continue;
-		spin_unlock(&pool->stale_lock);
-		cancel_work_sync(&zhdr->work);
-		free_z3fold_page(page, false);
-		cond_resched();
-		spin_lock(&pool->stale_lock);
-	}
-	spin_unlock(&pool->stale_lock);
-}
-
-/*
- * Returns the number of free chunks in a z3fold page.
- * NB: can't be used with HEADLESS pages.
- */
-static int num_free_chunks(struct z3fold_header *zhdr)
-{
-	int nfree;
-	/*
-	 * If there is a middle object, pick up the bigger free space
-	 * either before or after it. Otherwise just subtract the number
-	 * of chunks occupied by the first and the last objects.
-	 */
-	if (zhdr->middle_chunks != 0) {
-		int nfree_before = zhdr->first_chunks ?
-			0 : zhdr->start_middle - ZHDR_CHUNKS;
-		int nfree_after = zhdr->last_chunks ?
-			0 : TOTAL_CHUNKS -
-				(zhdr->start_middle + zhdr->middle_chunks);
-		nfree = max(nfree_before, nfree_after);
-	} else
-		nfree = NCHUNKS - zhdr->first_chunks - zhdr->last_chunks;
-	return nfree;
-}
-
-/* Add to the appropriate unbuddied list */
-static inline void add_to_unbuddied(struct z3fold_pool *pool,
-				struct z3fold_header *zhdr)
-{
-	if (zhdr->first_chunks == 0 || zhdr->last_chunks == 0 ||
-			zhdr->middle_chunks == 0) {
-		struct list_head *unbuddied;
-		int freechunks = num_free_chunks(zhdr);
-
-		migrate_disable();
-		unbuddied = this_cpu_ptr(pool->unbuddied);
-		spin_lock(&pool->lock);
-		list_add(&zhdr->buddy, &unbuddied[freechunks]);
-		spin_unlock(&pool->lock);
-		zhdr->cpu = smp_processor_id();
-		migrate_enable();
-	}
-}
-
-static inline enum buddy get_free_buddy(struct z3fold_header *zhdr, int chunks)
-{
-	enum buddy bud = HEADLESS;
-
-	if (zhdr->middle_chunks) {
-		if (!zhdr->first_chunks &&
-		    chunks <= zhdr->start_middle - ZHDR_CHUNKS)
-			bud = FIRST;
-		else if (!zhdr->last_chunks)
-			bud = LAST;
-	} else {
-		if (!zhdr->first_chunks)
-			bud = FIRST;
-		else if (!zhdr->last_chunks)
-			bud = LAST;
-		else
-			bud = MIDDLE;
-	}
-
-	return bud;
-}
-
-static inline void *mchunk_memmove(struct z3fold_header *zhdr,
-				unsigned short dst_chunk)
-{
-	void *beg = zhdr;
-	return memmove(beg + (dst_chunk << CHUNK_SHIFT),
-		       beg + (zhdr->start_middle << CHUNK_SHIFT),
-		       zhdr->middle_chunks << CHUNK_SHIFT);
-}
-
-static inline bool buddy_single(struct z3fold_header *zhdr)
-{
-	return !((zhdr->first_chunks && zhdr->middle_chunks) ||
-			(zhdr->first_chunks && zhdr->last_chunks) ||
-			(zhdr->middle_chunks && zhdr->last_chunks));
-}
-
-static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
-{
-	struct z3fold_pool *pool = zhdr_to_pool(zhdr);
-	void *p = zhdr;
-	unsigned long old_handle = 0;
-	size_t sz = 0;
-	struct z3fold_header *new_zhdr = NULL;
-	int first_idx = __idx(zhdr, FIRST);
-	int middle_idx = __idx(zhdr, MIDDLE);
-	int last_idx = __idx(zhdr, LAST);
-	unsigned short *moved_chunks = NULL;
-
-	/*
-	 * No need to protect slots here -- all the slots are "local" and
-	 * the page lock is already taken
-	 */
-	if (zhdr->first_chunks && zhdr->slots->slot[first_idx]) {
-		p += ZHDR_SIZE_ALIGNED;
-		sz = zhdr->first_chunks << CHUNK_SHIFT;
-		old_handle = (unsigned long)&zhdr->slots->slot[first_idx];
-		moved_chunks = &zhdr->first_chunks;
-	} else if (zhdr->middle_chunks && zhdr->slots->slot[middle_idx]) {
-		p += zhdr->start_middle << CHUNK_SHIFT;
-		sz = zhdr->middle_chunks << CHUNK_SHIFT;
-		old_handle = (unsigned long)&zhdr->slots->slot[middle_idx];
-		moved_chunks = &zhdr->middle_chunks;
-	} else if (zhdr->last_chunks && zhdr->slots->slot[last_idx]) {
-		p += PAGE_SIZE - (zhdr->last_chunks << CHUNK_SHIFT);
-		sz = zhdr->last_chunks << CHUNK_SHIFT;
-		old_handle = (unsigned long)&zhdr->slots->slot[last_idx];
-		moved_chunks = &zhdr->last_chunks;
-	}
-
-	if (sz > 0) {
-		enum buddy new_bud = HEADLESS;
-		short chunks = size_to_chunks(sz);
-		void *q;
-
-		new_zhdr = __z3fold_alloc(pool, sz, false);
-		if (!new_zhdr)
-			return NULL;
-
-		if (WARN_ON(new_zhdr == zhdr))
-			goto out_fail;
-
-		new_bud = get_free_buddy(new_zhdr, chunks);
-		q = new_zhdr;
-		switch (new_bud) {
-		case FIRST:
-			new_zhdr->first_chunks = chunks;
-			q += ZHDR_SIZE_ALIGNED;
-			break;
-		case MIDDLE:
-			new_zhdr->middle_chunks = chunks;
-			new_zhdr->start_middle =
-				new_zhdr->first_chunks + ZHDR_CHUNKS;
-			q += new_zhdr->start_middle << CHUNK_SHIFT;
-			break;
-		case LAST:
-			new_zhdr->last_chunks = chunks;
-			q += PAGE_SIZE - (new_zhdr->last_chunks << CHUNK_SHIFT);
-			break;
-		default:
-			goto out_fail;
-		}
-		new_zhdr->foreign_handles++;
-		memcpy(q, p, sz);
-		write_lock(&zhdr->slots->lock);
-		*(unsigned long *)old_handle = (unsigned long)new_zhdr +
-			__idx(new_zhdr, new_bud);
-		if (new_bud == LAST)
-			*(unsigned long *)old_handle |=
-					(new_zhdr->last_chunks << BUDDY_SHIFT);
-		write_unlock(&zhdr->slots->lock);
-		add_to_unbuddied(pool, new_zhdr);
-		z3fold_page_unlock(new_zhdr);
-
-		*moved_chunks = 0;
-	}
-
-	return new_zhdr;
-
-out_fail:
-	if (new_zhdr && !put_z3fold_locked(new_zhdr)) {
-		add_to_unbuddied(pool, new_zhdr);
-		z3fold_page_unlock(new_zhdr);
-	}
-	return NULL;
-
-}
-
-#define BIG_CHUNK_GAP	3
-/* Has to be called with lock held */
-static int z3fold_compact_page(struct z3fold_header *zhdr)
-{
-	struct page *page = virt_to_page(zhdr);
-
-	if (test_bit(MIDDLE_CHUNK_MAPPED, &page->private))
-		return 0; /* can't move middle chunk, it's used */
-
-	if (unlikely(PageIsolated(page)))
-		return 0;
-
-	if (zhdr->middle_chunks == 0)
-		return 0; /* nothing to compact */
-
-	if (zhdr->first_chunks == 0 && zhdr->last_chunks == 0) {
-		/* move to the beginning */
-		mchunk_memmove(zhdr, ZHDR_CHUNKS);
-		zhdr->first_chunks = zhdr->middle_chunks;
-		zhdr->middle_chunks = 0;
-		zhdr->start_middle = 0;
-		zhdr->first_num++;
-		return 1;
-	}
-
-	/*
-	 * moving data is expensive, so let's only do that if
-	 * there's substantial gain (at least BIG_CHUNK_GAP chunks)
-	 */
-	if (zhdr->first_chunks != 0 && zhdr->last_chunks == 0 &&
-	    zhdr->start_middle - (zhdr->first_chunks + ZHDR_CHUNKS) >=
-			BIG_CHUNK_GAP) {
-		mchunk_memmove(zhdr, zhdr->first_chunks + ZHDR_CHUNKS);
-		zhdr->start_middle = zhdr->first_chunks + ZHDR_CHUNKS;
-		return 1;
-	} else if (zhdr->last_chunks != 0 && zhdr->first_chunks == 0 &&
-		   TOTAL_CHUNKS - (zhdr->last_chunks + zhdr->start_middle
-					+ zhdr->middle_chunks) >=
-			BIG_CHUNK_GAP) {
-		unsigned short new_start = TOTAL_CHUNKS - zhdr->last_chunks -
-			zhdr->middle_chunks;
-		mchunk_memmove(zhdr, new_start);
-		zhdr->start_middle = new_start;
-		return 1;
-	}
-
-	return 0;
-}
-
-static void do_compact_page(struct z3fold_header *zhdr, bool locked)
-{
-	struct z3fold_pool *pool = zhdr_to_pool(zhdr);
-	struct page *page;
-
-	page = virt_to_page(zhdr);
-	if (locked)
-		WARN_ON(z3fold_page_trylock(zhdr));
-	else
-		z3fold_page_lock(zhdr);
-	if (WARN_ON(!test_and_clear_bit(NEEDS_COMPACTING, &page->private))) {
-		z3fold_page_unlock(zhdr);
-		return;
-	}
-	spin_lock(&pool->lock);
-	list_del_init(&zhdr->buddy);
-	spin_unlock(&pool->lock);
-
-	if (put_z3fold_locked(zhdr))
-		return;
-
-	if (test_bit(PAGE_STALE, &page->private) ||
-	    test_and_set_bit(PAGE_CLAIMED, &page->private)) {
-		z3fold_page_unlock(zhdr);
-		return;
-	}
-
-	if (!zhdr->foreign_handles && buddy_single(zhdr) &&
-	    zhdr->mapped_count == 0 && compact_single_buddy(zhdr)) {
-		if (!put_z3fold_locked(zhdr)) {
-			clear_bit(PAGE_CLAIMED, &page->private);
-			z3fold_page_unlock(zhdr);
-		}
-		return;
-	}
-
-	z3fold_compact_page(zhdr);
-	add_to_unbuddied(pool, zhdr);
-	clear_bit(PAGE_CLAIMED, &page->private);
-	z3fold_page_unlock(zhdr);
-}
-
-static void compact_page_work(struct work_struct *w)
-{
-	struct z3fold_header *zhdr = container_of(w, struct z3fold_header,
-						work);
-
-	do_compact_page(zhdr, false);
-}
-
-/* returns _locked_ z3fold page header or NULL */
-static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
-						size_t size, bool can_sleep)
-{
-	struct z3fold_header *zhdr = NULL;
-	struct page *page;
-	struct list_head *unbuddied;
-	int chunks = size_to_chunks(size), i;
-
-lookup:
-	migrate_disable();
-	/* First, try to find an unbuddied z3fold page. */
-	unbuddied = this_cpu_ptr(pool->unbuddied);
-	for_each_unbuddied_list(i, chunks) {
-		struct list_head *l = &unbuddied[i];
-
-		zhdr = list_first_entry_or_null(READ_ONCE(l),
-					struct z3fold_header, buddy);
-
-		if (!zhdr)
-			continue;
-
-		/* Re-check under lock. */
-		spin_lock(&pool->lock);
-		if (unlikely(zhdr != list_first_entry(READ_ONCE(l),
-						struct z3fold_header, buddy)) ||
-		    !z3fold_page_trylock(zhdr)) {
-			spin_unlock(&pool->lock);
-			zhdr = NULL;
-			migrate_enable();
-			if (can_sleep)
-				cond_resched();
-			goto lookup;
-		}
-		list_del_init(&zhdr->buddy);
-		zhdr->cpu = -1;
-		spin_unlock(&pool->lock);
-
-		page = virt_to_page(zhdr);
-		if (test_bit(NEEDS_COMPACTING, &page->private) ||
-		    test_bit(PAGE_CLAIMED, &page->private)) {
-			z3fold_page_unlock(zhdr);
-			zhdr = NULL;
-			migrate_enable();
-			if (can_sleep)
-				cond_resched();
-			goto lookup;
-		}
-
-		/*
-		 * this page could not be removed from its unbuddied
-		 * list while pool lock was held, and then we've taken
-		 * page lock so kref_put could not be called before
-		 * we got here, so it's safe to just call kref_get()
-		 */
-		kref_get(&zhdr->refcount);
-		break;
-	}
-	migrate_enable();
-
-	if (!zhdr) {
-		int cpu;
-
-		/* look for _exact_ match on other cpus' lists */
-		for_each_online_cpu(cpu) {
-			struct list_head *l;
-
-			unbuddied = per_cpu_ptr(pool->unbuddied, cpu);
-			spin_lock(&pool->lock);
-			l = &unbuddied[chunks];
-
-			zhdr = list_first_entry_or_null(READ_ONCE(l),
-						struct z3fold_header, buddy);
-
-			if (!zhdr || !z3fold_page_trylock(zhdr)) {
-				spin_unlock(&pool->lock);
-				zhdr = NULL;
-				continue;
-			}
-			list_del_init(&zhdr->buddy);
-			zhdr->cpu = -1;
-			spin_unlock(&pool->lock);
-
-			page = virt_to_page(zhdr);
-			if (test_bit(NEEDS_COMPACTING, &page->private) ||
-			    test_bit(PAGE_CLAIMED, &page->private)) {
-				z3fold_page_unlock(zhdr);
-				zhdr = NULL;
-				if (can_sleep)
-					cond_resched();
-				continue;
-			}
-			kref_get(&zhdr->refcount);
-			break;
-		}
-	}
-
-	if (zhdr && !zhdr->slots) {
-		zhdr->slots = alloc_slots(pool, GFP_ATOMIC);
-		if (!zhdr->slots)
-			goto out_fail;
-	}
-	return zhdr;
-
-out_fail:
-	if (!put_z3fold_locked(zhdr)) {
-		add_to_unbuddied(pool, zhdr);
-		z3fold_page_unlock(zhdr);
-	}
-	return NULL;
-}
-
-/*
- * API Functions
- */
-
-/**
- * z3fold_create_pool() - create a new z3fold pool
- * @name:	pool name
- * @gfp:	gfp flags when allocating the z3fold pool structure
- *
- * Return: pointer to the new z3fold pool or NULL if the metadata allocation
- * failed.
- */
-static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp)
-{
-	struct z3fold_pool *pool = NULL;
-	int i, cpu;
-
-	pool = kzalloc(sizeof(struct z3fold_pool), gfp);
-	if (!pool)
-		goto out;
-	pool->c_handle = kmem_cache_create("z3fold_handle",
-				sizeof(struct z3fold_buddy_slots),
-				SLOTS_ALIGN, 0, NULL);
-	if (!pool->c_handle)
-		goto out_c;
-	spin_lock_init(&pool->lock);
-	spin_lock_init(&pool->stale_lock);
-	pool->unbuddied = __alloc_percpu(sizeof(struct list_head) * NCHUNKS,
-					 __alignof__(struct list_head));
-	if (!pool->unbuddied)
-		goto out_pool;
-	for_each_possible_cpu(cpu) {
-		struct list_head *unbuddied =
-				per_cpu_ptr(pool->unbuddied, cpu);
-		for_each_unbuddied_list(i, 0)
-			INIT_LIST_HEAD(&unbuddied[i]);
-	}
-	INIT_LIST_HEAD(&pool->stale);
-	atomic64_set(&pool->pages_nr, 0);
-	pool->name = name;
-	pool->compact_wq = create_singlethread_workqueue(pool->name);
-	if (!pool->compact_wq)
-		goto out_unbuddied;
-	pool->release_wq = create_singlethread_workqueue(pool->name);
-	if (!pool->release_wq)
-		goto out_wq;
-	INIT_WORK(&pool->work, free_pages_work);
-	return pool;
-
-out_wq:
-	destroy_workqueue(pool->compact_wq);
-out_unbuddied:
-	free_percpu(pool->unbuddied);
-out_pool:
-	kmem_cache_destroy(pool->c_handle);
-out_c:
-	kfree(pool);
-out:
-	return NULL;
-}
-
-/**
- * z3fold_destroy_pool() - destroys an existing z3fold pool
- * @pool:	the z3fold pool to be destroyed
- *
- * The pool should be emptied before this function is called.
- */
-static void z3fold_destroy_pool(struct z3fold_pool *pool)
-{
-	kmem_cache_destroy(pool->c_handle);
-
-	/*
-	 * We need to destroy pool->compact_wq before pool->release_wq,
-	 * as any pending work on pool->compact_wq will call
-	 * queue_work(pool->release_wq, &pool->work).
-	 *
-	 * There are still outstanding pages until both workqueues are drained,
-	 * so we cannot unregister migration until then.
-	 */
-
-	destroy_workqueue(pool->compact_wq);
-	destroy_workqueue(pool->release_wq);
-	free_percpu(pool->unbuddied);
-	kfree(pool);
-}
-
-static const struct movable_operations z3fold_mops;
-
-/**
- * z3fold_alloc() - allocates a region of a given size
- * @pool:	z3fold pool from which to allocate
- * @size:	size in bytes of the desired allocation
- * @gfp:	gfp flags used if the pool needs to grow
- * @handle:	handle of the new allocation
- *
- * This function will attempt to find a free region in the pool large enough to
- * satisfy the allocation request.  A search of the unbuddied lists is
- * performed first. If no suitable free region is found, then a new page is
- * allocated and added to the pool to satisfy the request.
- *
- * Return: 0 if success and handle is set, otherwise -EINVAL if the size or
- * gfp arguments are invalid or -ENOMEM if the pool was unable to allocate
- * a new page.
- */
-static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
-			unsigned long *handle)
-{
-	int chunks = size_to_chunks(size);
-	struct z3fold_header *zhdr = NULL;
-	struct page *page = NULL;
-	enum buddy bud;
-	bool can_sleep = gfpflags_allow_blocking(gfp);
-
-	if (!size || (gfp & __GFP_HIGHMEM))
-		return -EINVAL;
-
-	if (size > PAGE_SIZE)
-		return -ENOSPC;
-
-	if (size > PAGE_SIZE - ZHDR_SIZE_ALIGNED - CHUNK_SIZE)
-		bud = HEADLESS;
-	else {
-retry:
-		zhdr = __z3fold_alloc(pool, size, can_sleep);
-		if (zhdr) {
-			bud = get_free_buddy(zhdr, chunks);
-			if (bud == HEADLESS) {
-				if (!put_z3fold_locked(zhdr))
-					z3fold_page_unlock(zhdr);
-				pr_err("No free chunks in unbuddied\n");
-				WARN_ON(1);
-				goto retry;
-			}
-			page = virt_to_page(zhdr);
-			goto found;
-		}
-		bud = FIRST;
-	}
-
-	page = alloc_page(gfp);
-	if (!page)
-		return -ENOMEM;
-
-	zhdr = init_z3fold_page(page, bud == HEADLESS, pool, gfp);
-	if (!zhdr) {
-		__free_page(page);
-		return -ENOMEM;
-	}
-	atomic64_inc(&pool->pages_nr);
-
-	if (bud == HEADLESS) {
-		set_bit(PAGE_HEADLESS, &page->private);
-		goto headless;
-	}
-	if (can_sleep) {
-		lock_page(page);
-		__SetPageMovable(page, &z3fold_mops);
-		unlock_page(page);
-	} else {
-		WARN_ON(!trylock_page(page));
-		__SetPageMovable(page, &z3fold_mops);
-		unlock_page(page);
-	}
-	z3fold_page_lock(zhdr);
-
-found:
-	if (bud == FIRST)
-		zhdr->first_chunks = chunks;
-	else if (bud == LAST)
-		zhdr->last_chunks = chunks;
-	else {
-		zhdr->middle_chunks = chunks;
-		zhdr->start_middle = zhdr->first_chunks + ZHDR_CHUNKS;
-	}
-	add_to_unbuddied(pool, zhdr);
-
-headless:
-	spin_lock(&pool->lock);
-	*handle = encode_handle(zhdr, bud);
-	spin_unlock(&pool->lock);
-	if (bud != HEADLESS)
-		z3fold_page_unlock(zhdr);
-
-	return 0;
-}
-
-/**
- * z3fold_free() - frees the allocation associated with the given handle
- * @pool:	pool in which the allocation resided
- * @handle:	handle associated with the allocation returned by z3fold_alloc()
- *
- * In the case that the z3fold page in which the allocation resides is under
- * reclaim, as indicated by the PAGE_CLAIMED flag being set, this function
- * only sets the first|middle|last_chunks to 0.  The page is actually freed
- * once all buddies are evicted (see z3fold_reclaim_page() below).
- */
-static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
-{
-	struct z3fold_header *zhdr;
-	struct page *page;
-	enum buddy bud;
-	bool page_claimed;
-
-	zhdr = get_z3fold_header(handle);
-	page = virt_to_page(zhdr);
-	page_claimed = test_and_set_bit(PAGE_CLAIMED, &page->private);
-
-	if (test_bit(PAGE_HEADLESS, &page->private)) {
-		/* if a headless page is under reclaim, just leave.
-		 * NB: we use test_and_set_bit for a reason: if the bit
-		 * has not been set before, we release this page
-		 * immediately so we don't care about its value any more.
-		 */
-		if (!page_claimed) {
-			put_z3fold_header(zhdr);
-			free_z3fold_page(page, true);
-			atomic64_dec(&pool->pages_nr);
-		}
-		return;
-	}
-
-	/* Non-headless case */
-	bud = handle_to_buddy(handle);
-
-	switch (bud) {
-	case FIRST:
-		zhdr->first_chunks = 0;
-		break;
-	case MIDDLE:
-		zhdr->middle_chunks = 0;
-		break;
-	case LAST:
-		zhdr->last_chunks = 0;
-		break;
-	default:
-		pr_err("%s: unknown bud %d\n", __func__, bud);
-		WARN_ON(1);
-		put_z3fold_header(zhdr);
-		return;
-	}
-
-	if (!page_claimed)
-		free_handle(handle, zhdr);
-	if (put_z3fold_locked_list(zhdr))
-		return;
-	if (page_claimed) {
-		/* the page has not been claimed by us */
-		put_z3fold_header(zhdr);
-		return;
-	}
-	if (test_and_set_bit(NEEDS_COMPACTING, &page->private)) {
-		clear_bit(PAGE_CLAIMED, &page->private);
-		put_z3fold_header(zhdr);
-		return;
-	}
-	if (zhdr->cpu < 0 || !cpu_online(zhdr->cpu)) {
-		zhdr->cpu = -1;
-		kref_get(&zhdr->refcount);
-		clear_bit(PAGE_CLAIMED, &page->private);
-		do_compact_page(zhdr, true);
-		return;
-	}
-	kref_get(&zhdr->refcount);
-	clear_bit(PAGE_CLAIMED, &page->private);
-	queue_work_on(zhdr->cpu, pool->compact_wq, &zhdr->work);
-	put_z3fold_header(zhdr);
-}
-
-/**
- * z3fold_map() - maps the allocation associated with the given handle
- * @pool:	pool in which the allocation resides
- * @handle:	handle associated with the allocation to be mapped
- *
- * Extracts the buddy number from handle and constructs the pointer to the
- * correct starting chunk within the page.
- *
- * Returns: a pointer to the mapped allocation
- */
-static void *z3fold_map(struct z3fold_pool *pool, unsigned long handle)
-{
-	struct z3fold_header *zhdr;
-	struct page *page;
-	void *addr;
-	enum buddy buddy;
-
-	zhdr = get_z3fold_header(handle);
-	addr = zhdr;
-	page = virt_to_page(zhdr);
-
-	if (test_bit(PAGE_HEADLESS, &page->private))
-		goto out;
-
-	buddy = handle_to_buddy(handle);
-	switch (buddy) {
-	case FIRST:
-		addr += ZHDR_SIZE_ALIGNED;
-		break;
-	case MIDDLE:
-		addr += zhdr->start_middle << CHUNK_SHIFT;
-		set_bit(MIDDLE_CHUNK_MAPPED, &page->private);
-		break;
-	case LAST:
-		addr += PAGE_SIZE - (handle_to_chunks(handle) << CHUNK_SHIFT);
-		break;
-	default:
-		pr_err("unknown buddy id %d\n", buddy);
-		WARN_ON(1);
-		addr = NULL;
-		break;
-	}
-
-	if (addr)
-		zhdr->mapped_count++;
-out:
-	put_z3fold_header(zhdr);
-	return addr;
-}
-
-/**
- * z3fold_unmap() - unmaps the allocation associated with the given handle
- * @pool:	pool in which the allocation resides
- * @handle:	handle associated with the allocation to be unmapped
- */
-static void z3fold_unmap(struct z3fold_pool *pool, unsigned long handle)
-{
-	struct z3fold_header *zhdr;
-	struct page *page;
-	enum buddy buddy;
-
-	zhdr = get_z3fold_header(handle);
-	page = virt_to_page(zhdr);
-
-	if (test_bit(PAGE_HEADLESS, &page->private))
-		return;
-
-	buddy = handle_to_buddy(handle);
-	if (buddy == MIDDLE)
-		clear_bit(MIDDLE_CHUNK_MAPPED, &page->private);
-	zhdr->mapped_count--;
-	put_z3fold_header(zhdr);
-}
-
-/**
- * z3fold_get_pool_pages() - gets the z3fold pool size in pages
- * @pool:	pool whose size is being queried
- *
- * Returns: size in pages of the given pool.
- */
-static u64 z3fold_get_pool_pages(struct z3fold_pool *pool)
-{
-	return atomic64_read(&pool->pages_nr);
-}
-
-static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
-{
-	struct z3fold_header *zhdr;
-	struct z3fold_pool *pool;
-
-	VM_BUG_ON_PAGE(PageIsolated(page), page);
-
-	if (test_bit(PAGE_HEADLESS, &page->private))
-		return false;
-
-	zhdr = page_address(page);
-	z3fold_page_lock(zhdr);
-	if (test_bit(NEEDS_COMPACTING, &page->private) ||
-	    test_bit(PAGE_STALE, &page->private))
-		goto out;
-
-	if (zhdr->mapped_count != 0 || zhdr->foreign_handles != 0)
-		goto out;
-
-	if (test_and_set_bit(PAGE_CLAIMED, &page->private))
-		goto out;
-	pool = zhdr_to_pool(zhdr);
-	spin_lock(&pool->lock);
-	if (!list_empty(&zhdr->buddy))
-		list_del_init(&zhdr->buddy);
-	spin_unlock(&pool->lock);
-
-	kref_get(&zhdr->refcount);
-	z3fold_page_unlock(zhdr);
-	return true;
-
-out:
-	z3fold_page_unlock(zhdr);
-	return false;
-}
-
-static int z3fold_page_migrate(struct page *newpage, struct page *page,
-		enum migrate_mode mode)
-{
-	struct z3fold_header *zhdr, *new_zhdr;
-	struct z3fold_pool *pool;
-
-	VM_BUG_ON_PAGE(!PageIsolated(page), page);
-	VM_BUG_ON_PAGE(!test_bit(PAGE_CLAIMED, &page->private), page);
-	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
-
-	zhdr = page_address(page);
-	pool = zhdr_to_pool(zhdr);
-
-	if (!z3fold_page_trylock(zhdr))
-		return -EAGAIN;
-	if (zhdr->mapped_count != 0 || zhdr->foreign_handles != 0) {
-		clear_bit(PAGE_CLAIMED, &page->private);
-		z3fold_page_unlock(zhdr);
-		return -EBUSY;
-	}
-	if (work_pending(&zhdr->work)) {
-		z3fold_page_unlock(zhdr);
-		return -EAGAIN;
-	}
-	new_zhdr = page_address(newpage);
-	memcpy(new_zhdr, zhdr, PAGE_SIZE);
-	newpage->private = page->private;
-	set_bit(PAGE_MIGRATED, &page->private);
-	z3fold_page_unlock(zhdr);
-	spin_lock_init(&new_zhdr->page_lock);
-	INIT_WORK(&new_zhdr->work, compact_page_work);
-	/*
-	 * z3fold_page_isolate() ensures that new_zhdr->buddy is empty,
-	 * so we only have to reinitialize it.
-	 */
-	INIT_LIST_HEAD(&new_zhdr->buddy);
-	__ClearPageMovable(page);
-
-	get_page(newpage);
-	z3fold_page_lock(new_zhdr);
-	if (new_zhdr->first_chunks)
-		encode_handle(new_zhdr, FIRST);
-	if (new_zhdr->last_chunks)
-		encode_handle(new_zhdr, LAST);
-	if (new_zhdr->middle_chunks)
-		encode_handle(new_zhdr, MIDDLE);
-	set_bit(NEEDS_COMPACTING, &newpage->private);
-	new_zhdr->cpu = smp_processor_id();
-	__SetPageMovable(newpage, &z3fold_mops);
-	z3fold_page_unlock(new_zhdr);
-
-	queue_work_on(new_zhdr->cpu, pool->compact_wq, &new_zhdr->work);
-
-	/* PAGE_CLAIMED and PAGE_MIGRATED are cleared now. */
-	page->private = 0;
-	put_page(page);
-	return 0;
-}
-
-static void z3fold_page_putback(struct page *page)
-{
-	struct z3fold_header *zhdr;
-	struct z3fold_pool *pool;
-
-	zhdr = page_address(page);
-	pool = zhdr_to_pool(zhdr);
-
-	z3fold_page_lock(zhdr);
-	if (!list_empty(&zhdr->buddy))
-		list_del_init(&zhdr->buddy);
-	INIT_LIST_HEAD(&page->lru);
-	if (put_z3fold_locked(zhdr))
-		return;
-	if (list_empty(&zhdr->buddy))
-		add_to_unbuddied(pool, zhdr);
-	clear_bit(PAGE_CLAIMED, &page->private);
-	z3fold_page_unlock(zhdr);
-}
-
-static const struct movable_operations z3fold_mops = {
-	.isolate_page = z3fold_page_isolate,
-	.migrate_page = z3fold_page_migrate,
-	.putback_page = z3fold_page_putback,
-};
-
-/*****************
- * zpool
- ****************/
-
-static void *z3fold_zpool_create(const char *name, gfp_t gfp)
-{
-	return z3fold_create_pool(name, gfp);
-}
-
-static void z3fold_zpool_destroy(void *pool)
-{
-	z3fold_destroy_pool(pool);
-}
-
-static int z3fold_zpool_malloc(void *pool, size_t size, gfp_t gfp,
-			unsigned long *handle)
-{
-	return z3fold_alloc(pool, size, gfp, handle);
-}
-static void z3fold_zpool_free(void *pool, unsigned long handle)
-{
-	z3fold_free(pool, handle);
-}
-
-static void *z3fold_zpool_map(void *pool, unsigned long handle,
-			enum zpool_mapmode mm)
-{
-	return z3fold_map(pool, handle);
-}
-static void z3fold_zpool_unmap(void *pool, unsigned long handle)
-{
-	z3fold_unmap(pool, handle);
-}
-
-static u64 z3fold_zpool_total_pages(void *pool)
-{
-	return z3fold_get_pool_pages(pool);
-}
-
-static struct zpool_driver z3fold_zpool_driver = {
-	.type =		"z3fold",
-	.sleep_mapped = true,
-	.owner =	THIS_MODULE,
-	.create =	z3fold_zpool_create,
-	.destroy =	z3fold_zpool_destroy,
-	.malloc =	z3fold_zpool_malloc,
-	.free =		z3fold_zpool_free,
-	.map =		z3fold_zpool_map,
-	.unmap =	z3fold_zpool_unmap,
-	.total_pages =	z3fold_zpool_total_pages,
-};
-
-MODULE_ALIAS("zpool-z3fold");
-
-static int __init init_z3fold(void)
-{
-	/*
-	 * Make sure the z3fold header is not larger than the page size and
-	 * there has remaining spaces for its buddy.
-	 */
-	BUILD_BUG_ON(ZHDR_SIZE_ALIGNED > PAGE_SIZE - CHUNK_SIZE);
-	zpool_register_driver(&z3fold_zpool_driver);
-
-	return 0;
-}
-
-static void __exit exit_z3fold(void)
-{
-	zpool_unregister_driver(&z3fold_zpool_driver);
-}
-
-module_init(init_z3fold);
-module_exit(exit_z3fold);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Vitaly Wool <vitalywool@gmail.com>");
-MODULE_DESCRIPTION("3-Fold Allocator for Compressed Pages");
-- 
2.48.1.262.g85cc9f2d1e-goog


