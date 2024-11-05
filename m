Return-Path: <linux-s390+bounces-6927-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BAD9BC3C0
	for <lists+linux-s390@lfdr.de>; Tue,  5 Nov 2024 04:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E6F282A36
	for <lists+linux-s390@lfdr.de>; Tue,  5 Nov 2024 03:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F715183CB0;
	Tue,  5 Nov 2024 03:19:56 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B442181334;
	Tue,  5 Nov 2024 03:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776796; cv=none; b=O176Ze5nVlZmkYic+6yrp5YOJBLkmrdlcbzobYHMGZcIVJ48aPoyckI8LI0Q21JfsvDlB+0DrsGIqJwg2vNzzojinGBZneIJT86Uns+cLB+OmC7XVxk/bDt0iNL2kt6GH4xtGPe0/7v5eDP1u9ys12u/001XSKTNemZkLhZ5y6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776796; c=relaxed/simple;
	bh=aWMTtXfngzPBbmUbkqXhqKK9gtIYyy2JFoMVlKcDQ44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VimCHx/bYQnLvbCoaCUPCA0NWRXBRezYMkBvabO7BRre2ULlpzLqbpl5nGK4kQGASZ/Hc6LpaaXfYDjrWVDtioo+rRR964AUz6tJ/Y0SzEbLXPgDp/7F3cAg9XYUNuSiQhuyBWcd2RJE4SuJYlaT3FJHHIS5VK2s1uWdth2wIG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XjD6x4F5jz1SDm9;
	Tue,  5 Nov 2024 11:18:01 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 850E91A0188;
	Tue,  5 Nov 2024 11:19:41 +0800 (CST)
Received: from huawei.com (10.110.54.32) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 5 Nov
 2024 11:19:40 +0800
From: liqiang <liqiang64@huawei.com>
To: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<dust.li@linux.alibaba.com>, <kuba@kernel.org>
CC: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luanjianhai@huawei.com>,
	<zhangxuzhou4@huawei.com>, <dengguangxing@huawei.com>, <gaochao24@huawei.com>
Subject: [PATCH v2 net-next] net/smc: Optimize the search method of reused buf_desc
Date: Tue, 5 Nov 2024 11:19:38 +0800
Message-ID: <20241105031938.1319-1-liqiang64@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20241101082342.1254-1-liqiang64@huawei.com>
References: <20241101082342.1254-1-liqiang64@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf200001.china.huawei.com (7.202.181.227)

We create a lock-less link list for the currently
idle reusable smc_buf_desc.

When the 'used' filed mark to 0, it is added to
the lock-less linked list.

When a new connection is established, a suitable
element is obtained directly, which eliminates the
need for traversal and search, and does not require
locking resource.

A lock-free linked list is a linked list that uses
atomic operations to optimize the producer-consumer model.

I tested the time-consuming comparison of this function
under multiple connections based on redis-benchmark
(test in smc loopback-ism mode):
The function 'smc_buf_get_slot' takes less time when a
new SMC link is established:
1. 5us->100ns (when there are 200 active links);
2. 30us->100ns (when there are 1000 active links).

Test data with wrk+nginx command:
On server:
smc_run nginx

On client:
smc_run wrk -t <2~64> -c 200 -H "Connection: close" http://127.0.0.1

Requests/sec
--------+---------------+---------------+
req/s   | without patch | apply patch   |
--------+---------------+---------------+
-t 2    |6924.18        |7456.54        |
--------+---------------+---------------+
-t 4    |8731.68        |9660.33        |
--------+---------------+---------------+
-t 8    |11363.22       |13802.08       |
--------+---------------+---------------+
-t 16   |12040.12       |18666.69       |
--------+---------------+---------------+
-t 32   |11460.82       |17017.28       |
--------+---------------+---------------+
-t 64   |11018.65       |14974.80       |
--------+---------------+---------------+

Transfer/sec
--------+---------------+---------------+
trans/s | without patch | apply patch   |
--------+---------------+---------------+
-t 2    |24.72MB        |26.62MB        |
--------+---------------+---------------+
-t 4    |31.18MB        |34.49MB        |
--------+---------------+---------------+
-t 8    |40.57MB        |49.28MB        |
--------+---------------+---------------+
-t 16   |42.99MB        |66.65MB        |
--------+---------------+---------------+
-t 32   |40.92MB        |60.76MB        |
--------+---------------+---------------+
-t 64   |39.34MB        |53.47MB        |
--------+---------------+---------------+


Signed-off-by: liqiang <liqiang64@huawei.com>
---
v2:
- Correct the acquisition logic of a lock-less linked list.(Dust.Li)
- fix comment symbol '//' -> '/**/'.(Dust.Li)
v1: https://lore.kernel.org/all/20241101082342.1254-1-liqiang64@huawei.com/

 net/smc/smc_core.c | 58 ++++++++++++++++++++++++++++++----------------
 net/smc/smc_core.h |  4 ++++
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 500952c2e67b..6f26e70c7c4d 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -16,6 +16,7 @@
 #include <linux/wait.h>
 #include <linux/reboot.h>
 #include <linux/mutex.h>
+#include <linux/llist.h>
 #include <linux/list.h>
 #include <linux/smc.h>
 #include <net/tcp.h>
@@ -909,6 +910,8 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	for (i = 0; i < SMC_RMBE_SIZES; i++) {
 		INIT_LIST_HEAD(&lgr->sndbufs[i]);
 		INIT_LIST_HEAD(&lgr->rmbs[i]);
+		init_llist_head(&lgr->rmbs_free[i]);
+		init_llist_head(&lgr->sndbufs_free[i]);
 	}
 	lgr->next_link_id = 0;
 	smc_lgr_list.num += SMC_LGR_NUM_INCR;
@@ -1183,6 +1186,10 @@ static void smcr_buf_unuse(struct smc_buf_desc *buf_desc, bool is_rmb,
 		/* memzero_explicit provides potential memory barrier semantics */
 		memzero_explicit(buf_desc->cpu_addr, buf_desc->len);
 		WRITE_ONCE(buf_desc->used, 0);
+		if (is_rmb)
+			llist_add(&buf_desc->llist, &lgr->rmbs_free[buf_desc->bufsiz_comp]);
+		else
+			llist_add(&buf_desc->llist, &lgr->sndbufs_free[buf_desc->bufsiz_comp]);
 	}
 }
 
@@ -1214,6 +1221,8 @@ static void smc_buf_unuse(struct smc_connection *conn,
 		} else {
 			memzero_explicit(conn->sndbuf_desc->cpu_addr, bufsize);
 			WRITE_ONCE(conn->sndbuf_desc->used, 0);
+			llist_add(&conn->sndbuf_desc->llist,
+				  &lgr->sndbufs_free[conn->sndbuf_desc->bufsiz_comp]);
 		}
 		SMC_STAT_RMB_SIZE(smc, is_smcd, false, false, bufsize);
 	}
@@ -1225,6 +1234,8 @@ static void smc_buf_unuse(struct smc_connection *conn,
 			bufsize += sizeof(struct smcd_cdc_msg);
 			memzero_explicit(conn->rmb_desc->cpu_addr, bufsize);
 			WRITE_ONCE(conn->rmb_desc->used, 0);
+			llist_add(&conn->rmb_desc->llist,
+				  &lgr->rmbs_free[conn->rmb_desc->bufsiz_comp]);
 		}
 		SMC_STAT_RMB_SIZE(smc, is_smcd, true, false, bufsize);
 	}
@@ -1413,13 +1424,21 @@ static void __smc_lgr_free_bufs(struct smc_link_group *lgr, bool is_rmb)
 {
 	struct smc_buf_desc *buf_desc, *bf_desc;
 	struct list_head *buf_list;
+	struct llist_head *buf_llist;
 	int i;
 
 	for (i = 0; i < SMC_RMBE_SIZES; i++) {
-		if (is_rmb)
+		if (is_rmb) {
 			buf_list = &lgr->rmbs[i];
-		else
+			buf_llist = &lgr->rmbs_free[i];
+		} else {
 			buf_list = &lgr->sndbufs[i];
+			buf_llist = &lgr->sndbufs_free[i];
+		}
+		/* just invalid this list first, and then free the memory
+		 * in the following loop
+		 */
+		llist_del_all(buf_llist);
 		list_for_each_entry_safe(buf_desc, bf_desc, buf_list,
 					 list) {
 			smc_lgr_buf_list_del(lgr, is_rmb, buf_desc);
@@ -2087,24 +2106,19 @@ int smc_uncompress_bufsize(u8 compressed)
 	return (int)size;
 }
 
-/* try to reuse a sndbuf or rmb description slot for a certain
- * buffer size; if not available, return NULL
- */
-static struct smc_buf_desc *smc_buf_get_slot(int compressed_bufsize,
-					     struct rw_semaphore *lock,
-					     struct list_head *buf_list)
+/* use lock less list to save and find reuse buf desc */
+static struct smc_buf_desc *smc_buf_get_slot_free(struct llist_head *buf_llist)
 {
-	struct smc_buf_desc *buf_slot;
+	struct smc_buf_desc *buf_free;
+	struct llist_node *llnode;
 
-	down_read(lock);
-	list_for_each_entry(buf_slot, buf_list, list) {
-		if (cmpxchg(&buf_slot->used, 0, 1) == 0) {
-			up_read(lock);
-			return buf_slot;
-		}
-	}
-	up_read(lock);
-	return NULL;
+	/* lock-less link list don't need an lock */
+	llnode = llist_del_first(buf_llist);
+	if (!llnode)
+		return NULL;
+	buf_free = llist_entry(llnode, struct smc_buf_desc, llist);
+	WRITE_ONCE(buf_free->used, 1);
+	return buf_free;
 }
 
 /* one of the conditions for announcing a receiver's current window size is
@@ -2409,6 +2423,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 	struct smc_connection *conn = &smc->conn;
 	struct smc_link_group *lgr = conn->lgr;
 	struct list_head *buf_list;
+	struct llist_head *buf_llist;
 	int bufsize, bufsize_comp;
 	struct rw_semaphore *lock;	/* lock buffer list */
 	bool is_dgraded = false;
@@ -2424,15 +2439,17 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 	     bufsize_comp >= 0; bufsize_comp--) {
 		if (is_rmb) {
 			lock = &lgr->rmbs_lock;
+			buf_llist = &lgr->rmbs_free[bufsize_comp];
 			buf_list = &lgr->rmbs[bufsize_comp];
 		} else {
 			lock = &lgr->sndbufs_lock;
+			buf_llist = &lgr->sndbufs_free[bufsize_comp];
 			buf_list = &lgr->sndbufs[bufsize_comp];
 		}
 		bufsize = smc_uncompress_bufsize(bufsize_comp);
 
 		/* check for reusable slot in the link group */
-		buf_desc = smc_buf_get_slot(bufsize_comp, lock, buf_list);
+		buf_desc = smc_buf_get_slot_free(buf_llist);
 		if (buf_desc) {
 			buf_desc->is_dma_need_sync = 0;
 			SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, true, bufsize);
@@ -2457,7 +2474,8 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 
 		SMC_STAT_RMB_ALLOC(smc, is_smcd, is_rmb);
 		SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, true, bufsize);
-		buf_desc->used = 1;
+		WRITE_ONCE(buf_desc->used, 1);
+		WRITE_ONCE(buf_desc->bufsiz_comp, bufsize_comp);
 		down_write(lock);
 		smc_lgr_buf_list_add(lgr, is_rmb, buf_list, buf_desc);
 		up_write(lock);
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 69b54ecd6503..076ee15f5c10 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -188,10 +188,12 @@ struct smc_link {
 /* tx/rx buffer list element for sndbufs list and rmbs list of a lgr */
 struct smc_buf_desc {
 	struct list_head	list;
+	struct llist_node	llist;
 	void			*cpu_addr;	/* virtual address of buffer */
 	struct page		*pages;
 	int			len;		/* length of buffer */
 	u32			used;		/* currently used / unused */
+	int			bufsiz_comp;
 	union {
 		struct { /* SMC-R */
 			struct sg_table	sgt[SMC_LINKS_PER_LGR_MAX];
@@ -278,8 +280,10 @@ struct smc_link_group {
 	unsigned short		vlan_id;	/* vlan id of link group */
 
 	struct list_head	sndbufs[SMC_RMBE_SIZES];/* tx buffers */
+	struct llist_head	sndbufs_free[SMC_RMBE_SIZES]; /* tx buffer free list */
 	struct rw_semaphore	sndbufs_lock;	/* protects tx buffers */
 	struct list_head	rmbs[SMC_RMBE_SIZES];	/* rx buffers */
+	struct llist_head	rmbs_free[SMC_RMBE_SIZES]; /* rx buffer free list */
 	struct rw_semaphore	rmbs_lock;	/* protects rx buffers */
 	u64			alloc_sndbufs;	/* stats of tx buffers */
 	u64			alloc_rmbs;	/* stats of rx buffers */
-- 
2.43.0


