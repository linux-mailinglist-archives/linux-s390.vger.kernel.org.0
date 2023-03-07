Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA9C6AE328
	for <lists+linux-s390@lfdr.de>; Tue,  7 Mar 2023 15:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjCGOsN (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 7 Mar 2023 09:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjCGOqJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Mar 2023 09:46:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C4714E9E
        for <linux-s390@vger.kernel.org>; Tue,  7 Mar 2023 06:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678199833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XswZDw+iZ8+4q1nFeXIY6yQ9xCKRhgciDOrB6q6HEYQ=;
        b=STQ2yx1nNXXH+FQAxk1phsKpQ0Vqm5eV7leaktXC0+dO4GVFO836Z0WKoPXjGnNA4TofBB
        nf4HI+1fSbB2PsHgq7sEtFxhQMBQnqvkxSci7d0BspUG5fTUXpQvTUJHhFMDAK6+F60KYj
        WR17Z37icdJ3LjxGuc96bqq8s3g3eJk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-36ucpmLzP_2BcZo3oA4DaA-1; Tue, 07 Mar 2023 09:37:10 -0500
X-MC-Unique: 36ucpmLzP_2BcZo3oA4DaA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FD763C69860;
        Tue,  7 Mar 2023 14:37:08 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.33.37.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC778400DFA1;
        Tue,  7 Mar 2023 14:37:02 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v5 7/7] sched, smp: Trace smp callback causing an IPI
Date:   Tue,  7 Mar 2023 14:35:58 +0000
Message-Id: <20230307143558.294354-8-vschneid@redhat.com>
In-Reply-To: <20230307143558.294354-1-vschneid@redhat.com>
References: <20230307143558.294354-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Context
=======

The newly-introduced ipi_send_cpumask tracepoint has a "callback" parameter
which so far has only been fed with NULL.

While CSD_TYPE_SYNC/ASYNC and CSD_TYPE_IRQ_WORK share a similar backing
struct layout (meaning their callback func can be accessed without caring
about the actual CSD type), CSD_TYPE_TTWU doesn't even have a function
attached to its struct. This means we need to check the type of a CSD
before eventually dereferencing its associated callback.

This isn't as trivial as it sounds: the CSD type is stored in
__call_single_node.u_flags, which get cleared right before the callback is
executed via csd_unlock(). This implies checking the CSD type before it is
enqueued on the call_single_queue, as the target CPU's queue can be flushed
before we get to sending an IPI.

Furthermore, send_call_function_single_ipi() only has a CPU parameter, and
would need to have an additional argument to trickle down the invoked
function. This is somewhat silly, as the extra argument will always be
pushed down to the function even when nothing is being traced, which is
unnecessary overhead.

Changes
=======

send_call_function_single_ipi() is only used by smp.c, and is defined in
sched/core.c as it contains scheduler-specific ops (set_nr_if_polling() of
a CPU's idle task).

Split it into two parts: the scheduler bits remain in sched/core.c, and the
actual IPI emission is moved into smp.c. This lets us define an
__always_inline helper function that can take the related callback as
parameter without creating useless register pressure in the non-traced path
which only gains a (disabled) static branch.

Do the same thing for the multi IPI case.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/core.c | 18 +++++++-----
 kernel/sched/smp.h  |  2 +-
 kernel/smp.c        | 72 +++++++++++++++++++++++++++++++++------------
 3 files changed, 66 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 85114f75f1c9c..60c79b4e4a5b1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3827,16 +3827,20 @@ void sched_ttwu_pending(void *arg)
 	rq_unlock_irqrestore(rq, &rf);
 }
 
-void send_call_function_single_ipi(int cpu)
+/*
+ * Prepare the scene for sending an IPI for a remote smp_call
+ *
+ * Returns true if the caller can proceed with sending the IPI.
+ * Returns false otherwise.
+ */
+bool call_function_single_prep_ipi(int cpu)
 {
-	struct rq *rq = cpu_rq(cpu);
-
-	if (!set_nr_if_polling(rq->idle)) {
-		trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, NULL);
-		arch_send_call_function_single_ipi(cpu);
-	} else {
+	if (set_nr_if_polling(cpu_rq(cpu)->idle)) {
 		trace_sched_wake_idle_without_ipi(cpu);
+		return false;
 	}
+
+	return true;
 }
 
 /*
diff --git a/kernel/sched/smp.h b/kernel/sched/smp.h
index 2eb23dd0f2856..21ac44428bb02 100644
--- a/kernel/sched/smp.h
+++ b/kernel/sched/smp.h
@@ -6,7 +6,7 @@
 
 extern void sched_ttwu_pending(void *arg);
 
-extern void send_call_function_single_ipi(int cpu);
+extern bool call_function_single_prep_ipi(int cpu);
 
 #ifdef CONFIG_SMP
 extern void flush_smp_call_function_queue(void);
diff --git a/kernel/smp.c b/kernel/smp.c
index 821b5986721ac..5cd680a7e78ef 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -161,9 +161,18 @@ void __init call_function_init(void)
 }
 
 static __always_inline void
-send_call_function_ipi_mask(const struct cpumask *mask)
+send_call_function_single_ipi(int cpu, smp_call_func_t func)
 {
-	trace_ipi_send_cpumask(mask, _RET_IP_, NULL);
+	if (call_function_single_prep_ipi(cpu)) {
+		trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, func);
+		arch_send_call_function_single_ipi(cpu);
+	}
+}
+
+static __always_inline void
+send_call_function_ipi_mask(const struct cpumask *mask, smp_call_func_t func)
+{
+	trace_ipi_send_cpumask(mask, _RET_IP_, func);
 	arch_send_call_function_ipi_mask(mask);
 }
 
@@ -430,12 +439,16 @@ static void __smp_call_single_queue_debug(int cpu, struct llist_node *node)
 	struct cfd_seq_local *seq = this_cpu_ptr(&cfd_seq_local);
 	struct call_function_data *cfd = this_cpu_ptr(&cfd_data);
 	struct cfd_percpu *pcpu = per_cpu_ptr(cfd->pcpu, cpu);
+	struct __call_single_data *csd;
+
+	csd = container_of(node, call_single_data_t, node.llist);
+	WARN_ON_ONCE(!(CSD_TYPE(csd) & (CSD_TYPE_SYNC | CSD_TYPE_ASYNC)));
 
 	cfd_seq_store(pcpu->seq_queue, this_cpu, cpu, CFD_SEQ_QUEUE);
 	if (llist_add(node, &per_cpu(call_single_queue, cpu))) {
 		cfd_seq_store(pcpu->seq_ipi, this_cpu, cpu, CFD_SEQ_IPI);
 		cfd_seq_store(seq->ping, this_cpu, cpu, CFD_SEQ_PING);
-		send_call_function_single_ipi(cpu);
+		send_call_function_single_ipi(cpu, csd->func);
 		cfd_seq_store(seq->pinged, this_cpu, cpu, CFD_SEQ_PINGED);
 	} else {
 		cfd_seq_store(pcpu->seq_noipi, this_cpu, cpu, CFD_SEQ_NOIPI);
@@ -477,6 +490,25 @@ static __always_inline void csd_unlock(struct __call_single_data *csd)
 	smp_store_release(&csd->node.u_flags, 0);
 }
 
+static __always_inline void
+raw_smp_call_single_queue(int cpu, struct llist_node *node, smp_call_func_t func)
+{
+	/*
+	 * The list addition should be visible to the target CPU when it pops
+	 * the head of the list to pull the entry off it in the IPI handler
+	 * because of normal cache coherency rules implied by the underlying
+	 * llist ops.
+	 *
+	 * If IPIs can go out of order to the cache coherency protocol
+	 * in an architecture, sufficient synchronisation should be added
+	 * to arch code to make it appear to obey cache coherency WRT
+	 * locking and barrier primitives. Generic code isn't really
+	 * equipped to do the right thing...
+	 */
+	if (llist_add(node, &per_cpu(call_single_queue, cpu)))
+		send_call_function_single_ipi(cpu, func);
+}
+
 static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
 
 void __smp_call_single_queue(int cpu, struct llist_node *node)
@@ -493,21 +525,25 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
 		}
 	}
 #endif
-
 	/*
-	 * The list addition should be visible to the target CPU when it pops
-	 * the head of the list to pull the entry off it in the IPI handler
-	 * because of normal cache coherency rules implied by the underlying
-	 * llist ops.
-	 *
-	 * If IPIs can go out of order to the cache coherency protocol
-	 * in an architecture, sufficient synchronisation should be added
-	 * to arch code to make it appear to obey cache coherency WRT
-	 * locking and barrier primitives. Generic code isn't really
-	 * equipped to do the right thing...
+	 * We have to check the type of the CSD before queueing it, because
+	 * once queued it can have its flags cleared by
+	 *   flush_smp_call_function_queue()
+	 * even if we haven't sent the smp_call IPI yet (e.g. the stopper
+	 * executes migration_cpu_stop() on the remote CPU).
 	 */
-	if (llist_add(node, &per_cpu(call_single_queue, cpu)))
-		send_call_function_single_ipi(cpu);
+	if (trace_ipi_send_cpumask_enabled()) {
+		call_single_data_t *csd;
+		smp_call_func_t func;
+
+		csd = container_of(node, call_single_data_t, node.llist);
+		func = CSD_TYPE(csd) == CSD_TYPE_TTWU ?
+			sched_ttwu_pending : csd->func;
+
+		raw_smp_call_single_queue(cpu, node, func);
+	} else {
+		raw_smp_call_single_queue(cpu, node, NULL);
+	}
 }
 
 /*
@@ -976,9 +1012,9 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		 * provided mask.
 		 */
 		if (nr_cpus == 1)
-			send_call_function_single_ipi(last_cpu);
+			send_call_function_single_ipi(last_cpu, func);
 		else if (likely(nr_cpus > 1))
-			send_call_function_ipi_mask(cfd->cpumask_ipi);
+			send_call_function_ipi_mask(cfd->cpumask_ipi, func);
 
 		cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->pinged, this_cpu, CFD_SEQ_NOCPU, CFD_SEQ_PINGED);
 	}
-- 
2.31.1

