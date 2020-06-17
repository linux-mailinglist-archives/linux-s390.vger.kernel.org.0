Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC341FC7E1
	for <lists+linux-s390@lfdr.de>; Wed, 17 Jun 2020 09:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgFQHtN (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 17 Jun 2020 03:49:13 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56902 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgFQHtM (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jun 2020 03:49:12 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jlSJz-0003hE-8g; Wed, 17 Jun 2020 17:17:20 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 17 Jun 2020 17:17:19 +1000
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Wed, 17 Jun 2020 17:17:19 +1000
Subject: [v3 PATCH 1/2] lockdep: Split header file into lockdep and lockdep_types
References: <20200617071524.GA3055@gondor.apana.org.au>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Message-Id: <E1jlSJz-0003hE-8g@fornost.hmeau.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

There is a header file inclusion loop between asm-generic/bug.h
and linux/kernel.h.  This causes potential compile failurs depending
on the which file is included first.  One way of breaking this loop
is to stop spinlock_types.h from including lockdep.h.  This patch
splits lockdep.h into two files for this purpose.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Acked-by: Petr Mladek <pmladek@suse.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---

 include/linux/lockdep.h        |  178 -------------------------------------
 include/linux/lockdep_types.h  |  196 +++++++++++++++++++++++++++++++++++++++++
 include/linux/spinlock.h       |    1 
 include/linux/spinlock_types.h |    2 
 4 files changed, 200 insertions(+), 177 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 8fce5c98a4b0e..3b73cf84f77dd 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -10,181 +10,20 @@
 #ifndef __LINUX_LOCKDEP_H
 #define __LINUX_LOCKDEP_H
 
+#include <linux/lockdep_types.h>
+
 struct task_struct;
-struct lockdep_map;
 
 /* for sysctl */
 extern int prove_locking;
 extern int lock_stat;
 
-#define MAX_LOCKDEP_SUBCLASSES		8UL
-
-#include <linux/types.h>
-
-enum lockdep_wait_type {
-	LD_WAIT_INV = 0,	/* not checked, catch all */
-
-	LD_WAIT_FREE,		/* wait free, rcu etc.. */
-	LD_WAIT_SPIN,		/* spin loops, raw_spinlock_t etc.. */
-
-#ifdef CONFIG_PROVE_RAW_LOCK_NESTING
-	LD_WAIT_CONFIG,		/* CONFIG_PREEMPT_LOCK, spinlock_t etc.. */
-#else
-	LD_WAIT_CONFIG = LD_WAIT_SPIN,
-#endif
-	LD_WAIT_SLEEP,		/* sleeping locks, mutex_t etc.. */
-
-	LD_WAIT_MAX,		/* must be last */
-};
-
 #ifdef CONFIG_LOCKDEP
 
 #include <linux/linkage.h>
-#include <linux/list.h>
 #include <linux/debug_locks.h>
 #include <linux/stacktrace.h>
 
-/*
- * We'd rather not expose kernel/lockdep_states.h this wide, but we do need
- * the total number of states... :-(
- */
-#define XXX_LOCK_USAGE_STATES		(1+2*4)
-
-/*
- * NR_LOCKDEP_CACHING_CLASSES ... Number of classes
- * cached in the instance of lockdep_map
- *
- * Currently main class (subclass == 0) and signle depth subclass
- * are cached in lockdep_map. This optimization is mainly targeting
- * on rq->lock. double_rq_lock() acquires this highly competitive with
- * single depth.
- */
-#define NR_LOCKDEP_CACHING_CLASSES	2
-
-/*
- * A lockdep key is associated with each lock object. For static locks we use
- * the lock address itself as the key. Dynamically allocated lock objects can
- * have a statically or dynamically allocated key. Dynamically allocated lock
- * keys must be registered before being used and must be unregistered before
- * the key memory is freed.
- */
-struct lockdep_subclass_key {
-	char __one_byte;
-} __attribute__ ((__packed__));
-
-/* hash_entry is used to keep track of dynamically allocated keys. */
-struct lock_class_key {
-	union {
-		struct hlist_node		hash_entry;
-		struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
-	};
-};
-
-extern struct lock_class_key __lockdep_no_validate__;
-
-struct lock_trace;
-
-#define LOCKSTAT_POINTS		4
-
-/*
- * The lock-class itself. The order of the structure members matters.
- * reinit_class() zeroes the key member and all subsequent members.
- */
-struct lock_class {
-	/*
-	 * class-hash:
-	 */
-	struct hlist_node		hash_entry;
-
-	/*
-	 * Entry in all_lock_classes when in use. Entry in free_lock_classes
-	 * when not in use. Instances that are being freed are on one of the
-	 * zapped_classes lists.
-	 */
-	struct list_head		lock_entry;
-
-	/*
-	 * These fields represent a directed graph of lock dependencies,
-	 * to every node we attach a list of "forward" and a list of
-	 * "backward" graph nodes.
-	 */
-	struct list_head		locks_after, locks_before;
-
-	const struct lockdep_subclass_key *key;
-	unsigned int			subclass;
-	unsigned int			dep_gen_id;
-
-	/*
-	 * IRQ/softirq usage tracking bits:
-	 */
-	unsigned long			usage_mask;
-	const struct lock_trace		*usage_traces[XXX_LOCK_USAGE_STATES];
-
-	/*
-	 * Generation counter, when doing certain classes of graph walking,
-	 * to ensure that we check one node only once:
-	 */
-	int				name_version;
-	const char			*name;
-
-	short				wait_type_inner;
-	short				wait_type_outer;
-
-#ifdef CONFIG_LOCK_STAT
-	unsigned long			contention_point[LOCKSTAT_POINTS];
-	unsigned long			contending_point[LOCKSTAT_POINTS];
-#endif
-} __no_randomize_layout;
-
-#ifdef CONFIG_LOCK_STAT
-struct lock_time {
-	s64				min;
-	s64				max;
-	s64				total;
-	unsigned long			nr;
-};
-
-enum bounce_type {
-	bounce_acquired_write,
-	bounce_acquired_read,
-	bounce_contended_write,
-	bounce_contended_read,
-	nr_bounce_types,
-
-	bounce_acquired = bounce_acquired_write,
-	bounce_contended = bounce_contended_write,
-};
-
-struct lock_class_stats {
-	unsigned long			contention_point[LOCKSTAT_POINTS];
-	unsigned long			contending_point[LOCKSTAT_POINTS];
-	struct lock_time		read_waittime;
-	struct lock_time		write_waittime;
-	struct lock_time		read_holdtime;
-	struct lock_time		write_holdtime;
-	unsigned long			bounces[nr_bounce_types];
-};
-
-struct lock_class_stats lock_stats(struct lock_class *class);
-void clear_lock_stats(struct lock_class *class);
-#endif
-
-/*
- * Map the lock object (the lock instance) to the lock-class object.
- * This is embedded into specific lock instances:
- */
-struct lockdep_map {
-	struct lock_class_key		*key;
-	struct lock_class		*class_cache[NR_LOCKDEP_CACHING_CLASSES];
-	const char			*name;
-	short				wait_type_outer; /* can be taken in this context */
-	short				wait_type_inner; /* presents this context */
-#ifdef CONFIG_LOCK_STAT
-	int				cpu;
-	unsigned long			ip;
-#endif
-};
-
 static inline void lockdep_copy_map(struct lockdep_map *to,
 				    struct lockdep_map *from)
 {
@@ -440,8 +279,6 @@ static inline void lock_set_subclass(struct lockdep_map *lock,
 
 extern void lock_downgrade(struct lockdep_map *lock, unsigned long ip);
 
-struct pin_cookie { unsigned int val; };
-
 #define NIL_COOKIE (struct pin_cookie){ .val = 0U, }
 
 extern struct pin_cookie lock_pin_lock(struct lockdep_map *lock);
@@ -520,10 +357,6 @@ static inline void lockdep_set_selftest_task(struct task_struct *task)
 # define lockdep_reset()		do { debug_locks = 1; } while (0)
 # define lockdep_free_key_range(start, size)	do { } while (0)
 # define lockdep_sys_exit() 			do { } while (0)
-/*
- * The class key takes no space if lockdep is disabled:
- */
-struct lock_class_key { };
 
 static inline void lockdep_register_key(struct lock_class_key *key)
 {
@@ -533,11 +366,6 @@ static inline void lockdep_unregister_key(struct lock_class_key *key)
 {
 }
 
-/*
- * The lockdep_map takes no space if lockdep is disabled:
- */
-struct lockdep_map { };
-
 #define lockdep_depth(tsk)	(0)
 
 #define lockdep_is_held_type(l, r)		(1)
@@ -549,8 +377,6 @@ struct lockdep_map { };
 
 #define lockdep_recursing(tsk)			(0)
 
-struct pin_cookie { };
-
 #define NIL_COOKIE (struct pin_cookie){ }
 
 #define lockdep_pin_lock(l)			({ struct pin_cookie cookie = { }; cookie; })
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
new file mode 100644
index 0000000000000..7b9350624577c
--- /dev/null
+++ b/include/linux/lockdep_types.h
@@ -0,0 +1,196 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Runtime locking correctness validator
+ *
+ *  Copyright (C) 2006,2007 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
+ *
+ * see Documentation/locking/lockdep-design.rst for more details.
+ */
+#ifndef __LINUX_LOCKDEP_TYPES_H
+#define __LINUX_LOCKDEP_TYPES_H
+
+#include <linux/types.h>
+
+#define MAX_LOCKDEP_SUBCLASSES		8UL
+
+enum lockdep_wait_type {
+	LD_WAIT_INV = 0,	/* not checked, catch all */
+
+	LD_WAIT_FREE,		/* wait free, rcu etc.. */
+	LD_WAIT_SPIN,		/* spin loops, raw_spinlock_t etc.. */
+
+#ifdef CONFIG_PROVE_RAW_LOCK_NESTING
+	LD_WAIT_CONFIG,		/* CONFIG_PREEMPT_LOCK, spinlock_t etc.. */
+#else
+	LD_WAIT_CONFIG = LD_WAIT_SPIN,
+#endif
+	LD_WAIT_SLEEP,		/* sleeping locks, mutex_t etc.. */
+
+	LD_WAIT_MAX,		/* must be last */
+};
+
+#ifdef CONFIG_LOCKDEP
+
+#include <linux/list.h>
+
+/*
+ * We'd rather not expose kernel/lockdep_states.h this wide, but we do need
+ * the total number of states... :-(
+ */
+#define XXX_LOCK_USAGE_STATES		(1+2*4)
+
+/*
+ * NR_LOCKDEP_CACHING_CLASSES ... Number of classes
+ * cached in the instance of lockdep_map
+ *
+ * Currently main class (subclass == 0) and signle depth subclass
+ * are cached in lockdep_map. This optimization is mainly targeting
+ * on rq->lock. double_rq_lock() acquires this highly competitive with
+ * single depth.
+ */
+#define NR_LOCKDEP_CACHING_CLASSES	2
+
+/*
+ * A lockdep key is associated with each lock object. For static locks we use
+ * the lock address itself as the key. Dynamically allocated lock objects can
+ * have a statically or dynamically allocated key. Dynamically allocated lock
+ * keys must be registered before being used and must be unregistered before
+ * the key memory is freed.
+ */
+struct lockdep_subclass_key {
+	char __one_byte;
+} __attribute__ ((__packed__));
+
+/* hash_entry is used to keep track of dynamically allocated keys. */
+struct lock_class_key {
+	union {
+		struct hlist_node		hash_entry;
+		struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
+	};
+};
+
+extern struct lock_class_key __lockdep_no_validate__;
+
+struct lock_trace;
+
+#define LOCKSTAT_POINTS		4
+
+/*
+ * The lock-class itself. The order of the structure members matters.
+ * reinit_class() zeroes the key member and all subsequent members.
+ */
+struct lock_class {
+	/*
+	 * class-hash:
+	 */
+	struct hlist_node		hash_entry;
+
+	/*
+	 * Entry in all_lock_classes when in use. Entry in free_lock_classes
+	 * when not in use. Instances that are being freed are on one of the
+	 * zapped_classes lists.
+	 */
+	struct list_head		lock_entry;
+
+	/*
+	 * These fields represent a directed graph of lock dependencies,
+	 * to every node we attach a list of "forward" and a list of
+	 * "backward" graph nodes.
+	 */
+	struct list_head		locks_after, locks_before;
+
+	const struct lockdep_subclass_key *key;
+	unsigned int			subclass;
+	unsigned int			dep_gen_id;
+
+	/*
+	 * IRQ/softirq usage tracking bits:
+	 */
+	unsigned long			usage_mask;
+	const struct lock_trace		*usage_traces[XXX_LOCK_USAGE_STATES];
+
+	/*
+	 * Generation counter, when doing certain classes of graph walking,
+	 * to ensure that we check one node only once:
+	 */
+	int				name_version;
+	const char			*name;
+
+	short				wait_type_inner;
+	short				wait_type_outer;
+
+#ifdef CONFIG_LOCK_STAT
+	unsigned long			contention_point[LOCKSTAT_POINTS];
+	unsigned long			contending_point[LOCKSTAT_POINTS];
+#endif
+} __no_randomize_layout;
+
+#ifdef CONFIG_LOCK_STAT
+struct lock_time {
+	s64				min;
+	s64				max;
+	s64				total;
+	unsigned long			nr;
+};
+
+enum bounce_type {
+	bounce_acquired_write,
+	bounce_acquired_read,
+	bounce_contended_write,
+	bounce_contended_read,
+	nr_bounce_types,
+
+	bounce_acquired = bounce_acquired_write,
+	bounce_contended = bounce_contended_write,
+};
+
+struct lock_class_stats {
+	unsigned long			contention_point[LOCKSTAT_POINTS];
+	unsigned long			contending_point[LOCKSTAT_POINTS];
+	struct lock_time		read_waittime;
+	struct lock_time		write_waittime;
+	struct lock_time		read_holdtime;
+	struct lock_time		write_holdtime;
+	unsigned long			bounces[nr_bounce_types];
+};
+
+struct lock_class_stats lock_stats(struct lock_class *class);
+void clear_lock_stats(struct lock_class *class);
+#endif
+
+/*
+ * Map the lock object (the lock instance) to the lock-class object.
+ * This is embedded into specific lock instances:
+ */
+struct lockdep_map {
+	struct lock_class_key		*key;
+	struct lock_class		*class_cache[NR_LOCKDEP_CACHING_CLASSES];
+	const char			*name;
+	short				wait_type_outer; /* can be taken in this context */
+	short				wait_type_inner; /* presents this context */
+#ifdef CONFIG_LOCK_STAT
+	int				cpu;
+	unsigned long			ip;
+#endif
+};
+
+struct pin_cookie { unsigned int val; };
+
+#else /* !CONFIG_LOCKDEP */
+
+/*
+ * The class key takes no space if lockdep is disabled:
+ */
+struct lock_class_key { };
+
+/*
+ * The lockdep_map takes no space if lockdep is disabled:
+ */
+struct lockdep_map { };
+
+struct pin_cookie { };
+
+#endif /* !LOCKDEP */
+
+#endif /* __LINUX_LOCKDEP_TYPES_H */
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index d3770b3f9d9a9..f2f12d746dbdb 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -56,6 +56,7 @@
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 #include <linux/bottom_half.h>
+#include <linux/lockdep.h>
 #include <asm/barrier.h>
 #include <asm/mmiowb.h>
 
diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index 6102e6bff3aeb..b981caafe8bf1 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -15,7 +15,7 @@
 # include <linux/spinlock_types_up.h>
 #endif
 
-#include <linux/lockdep.h>
+#include <linux/lockdep_types.h>
 
 typedef struct raw_spinlock {
 	arch_spinlock_t raw_lock;
