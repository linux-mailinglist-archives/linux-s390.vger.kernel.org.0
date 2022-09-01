Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DFA5A95B8
	for <lists+linux-s390@lfdr.de>; Thu,  1 Sep 2022 13:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiIALaZ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 1 Sep 2022 07:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIALaX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Sep 2022 07:30:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784DD2A403;
        Thu,  1 Sep 2022 04:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7ABU14MNOZEUh1mSDrdSB+ug3ovCSl4qqs3yLXXVi68=; b=bi2BPVk9FnZ6w+M+6dwV/WS0kP
        o87SjSiZzhYoe0uTZYIVL2ANWgkVKPO05VvmfFgiU9gxOBuYFpipmJgrR0+CpsOyKO2RGHRQiwulN
        Ni/e9XPkk/hD3HTPqIiiOSd6iTAGayXoDcDZj4HiG1AevNA37safV/rL+WGT0z2WHq+YFuxTlE6nq
        jfftY6CPYtYaefYfoXyt1vRDvAI54RrOA2heLdTK0k0UBtg/L5ZXDhR5WIbsSbMWGLVU+WNi29eWk
        XFgAeghthl8gNDNi0Mz8F1k6hd2DmNtqd+k4OpT+mK5+wNqHZxuWS6CrY1krApr5hLrxnxLxP96uP
        eD1xaxwA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTiOJ-008ODY-Vf; Thu, 01 Sep 2022 11:29:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D0B4530010B;
        Thu,  1 Sep 2022 13:29:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B97BF2B8BBAF9; Thu,  1 Sep 2022 13:29:46 +0200 (CEST)
Date:   Thu, 1 Sep 2022 13:29:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        will@kernel.org, robh@kernel.org, mingo@redhat.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH] perf: Rewrite core context handling
Message-ID: <YxCXqjfiJca3izQd@hirez.programming.kicks-ass.net>
References: <20220829113347.295-1-ravi.bangoria@amd.com>
 <YwyrUYS30gVbxc2D@hirez.programming.kicks-ass.net>
 <YwzP+AFWCx4Ni/kx@hirez.programming.kicks-ass.net>
 <c5a6aea9-4f3a-495e-78fa-e426de9b0496@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a6aea9-4f3a-495e-78fa-e426de9b0496@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Sep 01, 2022 at 04:05:53PM +0530, Ravi Bangoria wrote:
> On 29-Aug-22 8:10 PM, Peter Zijlstra wrote:
> > On Mon, Aug 29, 2022 at 02:04:33PM +0200, Peter Zijlstra wrote:
> >> On Mon, Aug 29, 2022 at 05:03:47PM +0530, Ravi Bangoria wrote:
> >>> @@ -12598,6 +12590,7 @@ EXPORT_SYMBOL_GPL(perf_event_create_kernel_counter);
> >>>  
> >>>  void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
> >>>  {
> >>> +#if 0 // XXX buggered - cpu hotplug, who cares
> >>>  	struct perf_event_context *src_ctx;
> >>>  	struct perf_event_context *dst_ctx;
> >>>  	struct perf_event *event, *tmp;
> >>> @@ -12658,6 +12651,7 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
> >>>  	}
> >>>  	mutex_unlock(&dst_ctx->mutex);
> >>>  	mutex_unlock(&src_ctx->mutex);
> >>> +#endif
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(perf_pmu_migrate_context);
> >>>  
> >>
> >> Note to self; fix this :-) I'll see if I have time for that later today.
> > 
> > Urgh, while going through that it appears the whole refcounting thing
> > isn't fully done either.
> 
> Not sure I follow. Can you please elaborate.

Sure, and sorry, I've not been feeling too well the past few days; I
meant to post something, but I just couldn't find it in me to finish it
let alone make it work.

So the basic issue I mentioned is that:


/*
 *           ,------------------------[1:n]---------------------.
 *           V                                                  V
 * perf_event_context <-[1:n]-> perf_event_pmu_context <--- perf_event
 *           ^                      ^     |                     |
 *           `--------[1:n]---------'     `-[n:1]-> pmu <-[1:n]-'
 *
 *
 * XXX destroy epc when empty
 *   refcount, !rcu
 *
 * XXX epc locking
 *
 *   event->pmu_ctx            ctx->mutex && inactive
 *   ctx->pmu_ctx_list         ctx->mutex && ctx->lock
 *
 */
struct perf_event_pmu_context {
	...
        atomic_t                        refcount; /* event <-> epc */
	...
}

But that then also suggests that:

struct perf_event_context {
	...
        refcount_t                      refcount;
	...
}

should be: ctx <-> epc, and that is not so, the ctx::refcount still
counts the number of events.

Now this might not be bad, but it is confusing.

Anywya; below is what I have, but it is entirely unfinished untested
might eat your ganny etc..


---
Index: linux-2.6/include/linux/perf_event.h
===================================================================
--- linux-2.6.orig/include/linux/perf_event.h
+++ linux-2.6/include/linux/perf_event.h
@@ -883,7 +883,7 @@ struct perf_event_context {
 	int				nr_freq;
 	int				rotate_disable;
 
-	refcount_t			refcount;
+	refcount_t			refcount; /* ctx <-> epc */
 	struct task_struct		*task;
 
 	/*
Index: linux-2.6/kernel/events/core.c
===================================================================
--- linux-2.6.orig/kernel/events/core.c
+++ linux-2.6/kernel/events/core.c
@@ -2750,7 +2750,7 @@ perf_install_in_context(struct perf_even
 	WARN_ON_ONCE(!exclusive_event_installable(event, ctx));
 
 	if (event->cpu != -1)
-		event->cpu = cpu;
+		WARN_ON_ONCE(event->cpu != cpu);
 
 	/*
 	 * Ensures that if we can observe event->ctx, both the event and ctx
@@ -4764,6 +4764,7 @@ find_get_pmu_context(struct pmu *pmu, st
 			list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
 			epc->ctx = ctx;
 			raw_spin_unlock_irq(&ctx->lock);
+			// XXX get_ctx(ctx);
 		} else {
 			WARN_ON_ONCE(epc->ctx != ctx);
 			atomic_inc(&epc->refcount);
@@ -4800,6 +4801,7 @@ find_get_pmu_context(struct pmu *pmu, st
 
 	list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
 	epc->ctx = ctx;
+	// XXX get_ctx(ctx)
 
 found_epc:
 	if (task_ctx_data && !epc->task_ctx_data) {
@@ -4837,6 +4839,8 @@ static void put_pmu_ctx(struct perf_even
 		list_del_init(&epc->pmu_ctx_entry);
 		epc->ctx = NULL;
 		raw_spin_unlock_irqrestore(&ctx->lock, flags);
+		
+		// XXX put_ctx(ctx)
 	}
 
 	WARN_ON_ONCE(!list_empty(&epc->pinned_active));
@@ -12444,6 +12448,8 @@ SYSCALL_DEFINE5(perf_event_open,
 	perf_unpin_context(ctx);
 
 	mutex_unlock(&ctx->mutex);
+	
+	// XXX put_ctx(ctx);
 
 	if (task) {
 		up_read(&task->signal->exec_update_lock);
@@ -12588,34 +12594,44 @@ err:
 }
 EXPORT_SYMBOL_GPL(perf_event_create_kernel_counter);
 
-void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
+static void __perf_pmu_remove(struct perf_event_context *ctx,
+			      int cpu, struct pmu *pmu,
+			      struct perf_event_groups *groups,
+			      struct list_head *events)
 {
-#if 0 // XXX buggered - cpu hotplug, who cares
-	struct perf_event_context *src_ctx;
-	struct perf_event_context *dst_ctx;
-	struct perf_event *event, *tmp;
-	LIST_HEAD(events);
+	struct perf_event *event;
 
-	src_ctx = &per_cpu_ptr(pmu->pmu_cpu_context, src_cpu)->ctx;
-	dst_ctx = &per_cpu_ptr(pmu->pmu_cpu_context, dst_cpu)->ctx;
+	for (event = perf_event_groups_first(groups, cpu, pmu, NULL);
+	     event;
+	     event = perf_event_groups_next(event, pmu)) {
 
-	/*
-	 * See perf_event_ctx_lock() for comments on the details
-	 * of swizzling perf_event::ctx.
-	 */
-	mutex_lock_double(&src_ctx->mutex, &dst_ctx->mutex);
-	list_for_each_entry_safe(event, tmp, &src_ctx->event_list,
-				 event_entry) {
 		perf_remove_from_context(event, 0);
-		unaccount_event_cpu(event, src_cpu);
-		put_ctx(src_ctx);
-		list_add(&event->migrate_entry, &events);
+		unaccount_event_cpu(event, cpu);
+		put_pmu_ctx(event->pmu_ctx);
+		list_add(&event->migrate_event, events);
 	}
+}
 
-	/*
-	 * Wait for the events to quiesce before re-instating them.
-	 */
-	synchronize_rcu();
+static void __perf_pmu_install_event(struct pmu *pmu,
+				     struct perf_event_context *ctx,
+				     int cpu, struct perf_event *event)
+{
+	struct perf_event_pmu_context *epc;
+
+	event->cpu = cpu;
+	epc = find_get_pmu_context(pmu, ctx, event);
+	event->pmu_ctx = epc;
+
+	if (event->state >= PERF_EVENT_STATE_OFF)
+		event->state = PERF_EVENT_STATE_INACTIVE;
+	account_event_cpu(event, cpu);
+	perf_install_in_context(ctx, event, cpu);
+}
+
+static void __perf_pmu_install(struct perf_event_context *ctx,
+			       int cpu, struct pmu *pmu, struct list_head *events)
+{
+	struct perf_event *event, *tmp;
 
 	/*
 	 * Re-instate events in 2 passes.
@@ -12625,33 +12641,50 @@ void perf_pmu_migrate_context(struct pmu
 	 * leader will enable its siblings, even if those are still on the old
 	 * context.
 	 */
-	list_for_each_entry_safe(event, tmp, &events, migrate_entry) {
+	list_for_each_entry_safe(event, tmp, events, migrate_entry) {
 		if (event->group_leader == event)
 			continue;
 
 		list_del(&event->migrate_entry);
-		if (event->state >= PERF_EVENT_STATE_OFF)
-			event->state = PERF_EVENT_STATE_INACTIVE;
-		account_event_cpu(event, dst_cpu);
-		perf_install_in_context(dst_ctx, event, dst_cpu);
-		get_ctx(dst_ctx);
+		__perf_pmu_install_event(pmu, ctx, cpu, event);
 	}
 
 	/*
 	 * Once all the siblings are setup properly, install the group leaders
 	 * to make it go.
 	 */
-	list_for_each_entry_safe(event, tmp, &events, migrate_entry) {
+	list_for_each_entry_safe(event, tmp, events, migrate_entry) {
 		list_del(&event->migrate_entry);
-		if (event->state >= PERF_EVENT_STATE_OFF)
-			event->state = PERF_EVENT_STATE_INACTIVE;
-		account_event_cpu(event, dst_cpu);
-		perf_install_in_context(dst_ctx, event, dst_cpu);
-		get_ctx(dst_ctx);
+		__perf_pmu_install_event(pmu, ctx, cpu, event);
 	}
+}
+
+void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
+{
+	struct perf_event_context *src_ctx, *dst_ctx;
+	LIST_HEAD(events);
+
+	src_ctx = &per_cpu_ptr(&cpu_context, src_cpu)->ctx;
+	dst_ctx = &per_cpu_ptr(&cpu_context, dst_cpu)->ctx;
+
+	/*
+	 * See perf_event_ctx_lock() for comments on the details
+	 * of swizzling perf_event::ctx.
+	 */
+	mutex_lock_double(&src_ctx->mutex, &dst_ctx->mutex);
+
+	__perf_pmu_remove(src_ctx, src_cpu, pmu, &src_src->pinned_groups, &events);
+	__perf_pmu_remove(src_ctx, src_cpu, pmu, &src_src->flexible_groups, &events);
+
+	/*
+	 * Wait for the events to quiesce before re-instating them.
+	 */
+	synchronize_rcu();
+
+	__perf_pmu_install(dst_ctx, dst_cpu, pmu, &events);
+
 	mutex_unlock(&dst_ctx->mutex);
 	mutex_unlock(&src_ctx->mutex);
-#endif
 }
 EXPORT_SYMBOL_GPL(perf_pmu_migrate_context);
 
